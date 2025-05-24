CREATE DATABASE IF NOT EXISTS goodjob DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 선택
USE ajou_order;

-- 사용자 정보 테이블
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,              -- 사용자 고유 ID
    email VARCHAR(255) UNIQUE NOT NULL,                -- 사용자 이메일 (고유값)
    name VARCHAR(100) NOT NULL,                        -- 사용자 이름
    role ENUM('USER', 'BUSINESS') DEFAULT 'USER',         -- 사용자 권한: 일반 사용자 또는 관리자
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,     -- 생성 일자
    last_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 마지막 수정 일자
);

CREATE TABLE store (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,              -- CV 고유 ID
    store_name VARCHAR(255) NOT NULL,                   -- 업로드한 파일 이름
    store_location VARCHAR(500) NOT NULL                -- S3 등 외부 저장소의 파일 URL
);

CREATE TABLE menu (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,              -- 메뉴 고유 ID
    store_id BIGINT NOT NULL,                       -- 상점 ID
    FOREIGN KEY (store_id) REFERENCES store(id) ON DELETE CASCADE, -- 상점 외래 키
    menu_name VARCHAR(255) NOT NULL,                   -- 메뉴 이름
    price INT NOT NULL,                            -- 메뉴 가격
    amount INT,
    description TEXT NOT NULL,                            -- 메뉴 설명
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,     -- 생성 일자
    last_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 마지막 수정 일자
);

CREATE TABLE `order` (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,                
    user_id BIGINT NOT NULL,                             
    store_id BIGINT NOT NULL,                            
    price INT NOT NULL,                            
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED') DEFAULT 'PENDING', 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,        
    last_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES store(id) ON DELETE CASCADE
);
