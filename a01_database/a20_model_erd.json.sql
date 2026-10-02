/*실전 연습! 판타지 마을 '용사 길드' 데이터베이스 설계
=============================================================================

[상황극]
당신은 판타지 세계 '초보 용사 길드'의 관리자입니다. 주먹구구식으로 양피지에 기록하던 길드 장부가 드래곤의 불꽃에 타버리는 바람에, 마법 공학을 이용해 데이터베이스를 새롭게 구축하려고 합니다. 길드장님이 다음의 요구사항을 읊어줍니다.

"우리 길드에는 수많은 [용사]들이 등록되어 있지! 용사들은 대장간에서 만들어진 [무기]들 중 딱 하나씩만 주력으로 장착할 수 있다네. (물론 롱소드 같은 같은 종류의 무기를 여러 용사가 찰 수는 있지). 그리고 마을 주민들이 길드 게시판에 [의뢰(퀘스트)]**를 올리면 용사들이 그걸 해결해. 여기서 중요한 건, 잘나가는 용사는 한 번에 여러 의뢰를 동시에 맡을 수도 있고, 드래곤 토벌 같은 거대한 의뢰는 여러 용사가 파티를 맺어 함께 덤빌 수도 있다네!"

---

📝 [연습문제 1] 개념적 모델링 (엔티티와 관계 찾기)
위 길드장님의 요구사항을 읽고 다음을 찾아보세요.

엔티티(Entity) 3가지를 추출해 보세요.
관계(Relationship)를 정의해 보세요.
무기와 용사의 관계 (1:1, 1:N, N:M 중 무엇일까요?)
용사와 의뢰의 관계 (1:1, 1:N, N:M 중 무엇일까요?)



📝 [연습문제 2] 논리적 모델링 (테이블 뼈대 만들기)
찾아낸 엔티티와 관계를 바탕으로 테이블을 설계합니다. PK(기본키)와 FK(외래키)를 어디에 두어야 할지 고민해 보세요.
(힌트: 다대다(N:M) 관계는 데이터베이스에서 직접 연결할 수 없으므로, 중간에서 연결해주는 '교차 테이블'이 하나 더 필요합니다!)

무기(WEAPON) 테이블: 무기번호, 무기명, 공격력
용사(HERO) 테이블: 용사아이디, 용사이름, 레벨, (어떤 컬럼이 추가되어야 할까요?)
의뢰(QUEST) 테이블: 의뢰번호, 의뢰제목, 보상금
??? 테이블: 용사와 의뢰를 묶어줄 중간 테이블의 이름과 컬럼을 상상해 보세요!
2단계: 논리적 모델링 (PK/FK 설계), 물리적 모델(export)
1:1 관계는 두 테이블 중 아무 곳에나 외래키(FK)를 두어도 무방
합니다. (보통 데이터가 먼저 생기는 주체 쪽에 두거나, 관리가 
편한 쪽에 둡니다.) 여기서는 기사 정보에 '자신의 무기 번호'를 적어두겠습니다.

소울웨폰(SOUL_WEAPON): PK = 무기번호
      WEAPON_NO WEAPON_NAME MAGIC_ATTR
기사(KNIGHT): PK = 기사번호 / FK = 무기번호 (소울웨폰 참조) 
      KNIGHT_NO KNIGHT_NAME OATH_DATE
      WHENEVER SQLERROR CONTINUE;


DROP TABLE SOUL_WEAPON CASCADE CONSTRAINTS;
DROP TABLE KNIGHT CASCADE CONSTRAINTS;


WHENEVER SQLERROR EXIT FAILURE ROLLBACK;


CREATE TABLE KNIGHT (
    knight_id   VARCHAR2(20) PRIMARY KEY,       -- 기사번호 (PK)
    knight_name VARCHAR2(50) NOT NULL,          -- 이름
    pledge_date DATE DEFAULT SYSDATE NOT NULL   -- 서약일
);

-- 소울웨폰 테이블
CREATE TABLE SOUL_WEAPON (
    weapon_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- 무기번호 (PK)
    weapon_name  VARCHAR2(50) NOT NULL,                           -- 무기 이름
    element_type VARCHAR2(20) NOT NULL,                           -- 마법속성 (불, 얼음 등)
    knight_id    VARCHAR2(20) NOT NULL UNIQUE,                    -- 기사번호 (FK + UNIQUE ★ 1:1 강제)
    
    CONSTRAINT fk_soul_knight FOREIGN KEY (knight_id) 
        REFERENCES KNIGHT(knight_id) ON DELETE CASCADE
);


-- 기사 등록
INSERT INTO KNIGHT (knight_id, knight_name, pledge_date) 
VALUES ('KNG_01', '아더', TO_DATE('2026-01-15', 'YYYY-MM-DD'));

INSERT INTO KNIGHT (knight_id, knight_name, pledge_date) 
VALUES ('KNG_02', '랜슬롯', TO_DATE('2026-03-01', 'YYYY-MM-DD'));
)
INSERT INTO SOUL_WEAPON (weapon_name, element_type, knight_id) 
VALUES ('엑스칼리버', '불', 'KNG_01');

INSERT INTO SOUL_WEAPON (weapon_name, element_type, knight_id) 
VALUES ('아론다이트', '얼음', 'KNG_02');

-- 데이터 영구 반영 (핵심)
COMMIT;


SELECT 
    K.knight_id   AS "기사번호",
    K.knight_name AS "기사 이름",
    TO_CHAR(K.pledge_date, 'YYYY-MM-DD') AS "서약일",
    S.weapon_name AS "소울웨폰 이름",
    S.element_type AS "마법속성"
FROM KNIGHT K
JOIN SOUL_WEAPON S ON K.knight_id = S.knight_id;*/


