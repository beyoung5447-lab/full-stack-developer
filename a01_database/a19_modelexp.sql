--------------------------------------------------
-- 1. 기존 테이블 삭제 (존재하지 않으면 에러 메시지만 남고 다음으로 자동 진행됨)
--------------------------------------------------
DROP TABLE HERO_QUEST CASCADE CONSTRAINTS;
DROP TABLE HERO CASCADE CONSTRAINTS;
DROP TABLE QUEST CASCADE CONSTRAINTS;
DROP TABLE WEAPON CASCADE CONSTRAINTS;

--------------------------------------------------
-- 2. 테이블 생성 (물리적 모델링)
--------------------------------------------------
-- 무기 테이블
CREATE TABLE WEAPON (
    weapon_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    weapon_name VARCHAR2(50) NOT NULL,
    attack_power NUMBER DEFAULT 0 NOT NULL
);

-- 용사 테이블
CREATE TABLE HERO (
    hero_id VARCHAR2(20) PRIMARY KEY,
    hero_name VARCHAR2(50) NOT NULL,
    hero_level NUMBER DEFAULT 1 NOT NULL,
    weapon_id NUMBER NULL,
    CONSTRAINT fk_hero_weapon FOREIGN KEY (weapon_id) 
        REFERENCES WEAPON(weapon_id) ON DELETE SET NULL
);

-- 의뢰 테이블
CREATE TABLE QUEST (
    quest_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    reward NUMBER DEFAULT 0 NOT NULL
);

-- 용사_의뢰 교차 테이블 (N:M 관계 해소)
CREATE TABLE HERO_QUEST (
    hero_id VARCHAR2(20) NOT NULL,
    quest_id NUMBER NOT NULL,
    role VARCHAR2(20) NULL,
    CONSTRAINT pk_hero_quest PRIMARY KEY (hero_id, quest_id),
    CONSTRAINT fk_hq_hero FOREIGN KEY (hero_id) 
        REFERENCES HERO(hero_id) ON DELETE CASCADE,
    CONSTRAINT fk_hq_quest FOREIGN KEY (quest_id) 
        REFERENCES QUEST(quest_id) ON DELETE CASCADE
);

--------------------------------------------------
-- 3. 지문 기반 데이터 입력
--------------------------------------------------
-- 무기 입력
INSERT INTO WEAPON (weapon_name, attack_power) VALUES ('롱소드', 30);

-- 용사 입력 (동일 무기 롱소드 장착)
INSERT INTO HERO (hero_id, hero_name, hero_level, weapon_id) VALUES ('hero_01', '용사A', 10, 1);
INSERT INTO HERO (hero_id, hero_name, hero_level, weapon_id) VALUES ('hero_02', '용사B', 15, 1);

-- 의뢰 입력
INSERT INTO QUEST (title, reward) VALUES ('드래곤 토벌', 1000000);

-- 용사-의뢰 파티 입력
INSERT INTO HERO_QUEST (hero_id, quest_id, role) VALUES ('hero_01', 1, '파티원A');
INSERT INTO HERO_QUEST (hero_id, quest_id, role) VALUES ('hero_02', 1, '파티원B');

-- 오라클 데이터 확정 저장 (핵심)
COMMIT;

--------------------------------------------------
-- 4. 최종 데이터 통합 조회
--------------------------------------------------
SELECT 
    H.hero_name AS "용사명",
    H.hero_level AS "레벨",
    W.weapon_name AS "장착무기",
    Q.title AS "수행 의뢰",
    HQ.role AS "파티 역할"
FROM HERO H
JOIN WEAPON W ON H.weapon_id = W.weapon_id
JOIN HERO_QUEST HQ ON H.hero_id = HQ.hero_id
JOIN QUEST Q ON HQ.quest_id = Q.quest_id;