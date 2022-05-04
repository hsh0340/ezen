-- 2022년 04월 29일 (금)

SELECT USER(); -- 지금 사용자
SELECT DATABASE(); -- 지금 사용중인 데이터베이스 
SHOW DATABASES; 
USE db01;
SHOW TABLES; -- 테이블들

DROP TABLE member;
SHOW TABLES;

/*
< 프로젝트에서 사용할 회원가입 테이블 설계 >
- 쇼핑몰에서 사용할 회원 테이블
- 기능 : CRUD, 회원가입, 회원확인(1명), 회원수정, 회원삭제(탈퇴)
- 로그인, 로그아웃 : 
- 필드 구성 -> 7개의 컬럼으로 구성
- 테이블명: member
-- id: 아이디, VARCHAR(50), Primary Key
-- pwd: 비밀번호, VARCHAR(20), NOT NULL
-- name: 이름, VARCHAR(30), NOT NULL
-- email: 이메일, VARCHAR(50), NOT NULL
-- tel: 전화번호, VARCHAR(20), NOT NULL
-- address: 주소, VARCHAR(100), NOT NULL
-- regDate datetime: 가입일자, NOT NULL(timestamp 사용)
*/

CREATE TABLE member (
id VARCHAR(50) PRIMARY KEY,
pwd VARCHAR(20) NOT NULL,
name VARCHAR(30) NOT NULL,
email VARCHAR(50) NOT NULL,
tel VARCHAR(20) NOT NULL,
address VARCHAR(100) NOT NULL,
regDate DATETIME NOT NULL
);

DESC member;
SELECT * FROM member;

INSERT INTO member VALUES('aaa1111','1234', '박선영', 'parksy@naver.com', '010-1111-1111', 
'서울시 용산구 용산대로 30', NOW());