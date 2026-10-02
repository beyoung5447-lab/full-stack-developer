FROM guardian g
JOIN pet p ON g.guardian_id = p.guardian_id;


SELECT table_name FROM user_tables WHERE table_name IN ('GUARDIAN', 'PET');



/* ===================================================
   1. 시퀀스 생성
=================================================== */
CREATE SEQUENCE seq_guardian START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pet START WITH 1 INCREMENT BY 1;


/* ===================================================
   2. 테이블 생성 (1:N 관계)
=================================================== */
CREATE TABLE guardian (
    guardian_id  NUMBER PRIMARY KEY,
    name         VARCHAR2(50) NOT NULL,
    phone        VARCHAR2(20) NOT NULL UNIQUE,
    created_at   DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE pet (
    pet_id       NUMBER PRIMARY KEY,
    name         VARCHAR2(50) NOT NULL,
    species      VARCHAR2(50) NOT NULL,
    age          NUMBER CHECK (age >= 0),
    guardian_id  NUMBER NOT NULL,
    CONSTRAINT fk_pet_guardian 
        FOREIGN KEY (guardian_id) 
        REFERENCES guardian(guardian_id) 
        ON DELETE CASCADE
);


/* ===================================================
   3. 샘플 데이터 입력
=================================================== */
INSERT INTO guardian (guardian_id, name, phone) 
VALUES (seq_guardian.NEXTVAL, '김철수', '010-1234-5678');

INSERT INTO guardian (guardian_id, name, phone) 
VALUES (seq_guardian.NEXTVAL, '이영희', '010-9876-5432');

INSERT INTO pet (pet_id, name, species, age, guardian_id) 
VALUES (seq_pet.NEXTVAL, '초코', '강아지(푸들)', 3, 1);

INSERT INTO pet (pet_id, name, species, age, guardian_id) 
VALUES (seq_pet.NEXTVAL, '나비', '고양이(코숏)', 2, 1);

INSERT INTO pet (pet_id, name, species, age, guardian_id) 
VALUES (seq_pet.NEXTVAL, '해피', '강아지(말티즈)', 5, 2);

COMMIT;


/* ===================================================
   4. 결과 조회
=================================================== */
SELECT 
    g.guardian_id AS 보호자번호,
    g.name        AS 보호자이름,
    p.pet_id      AS 동물번호,
    p.name        AS 동물이름,
    p.species     AS 종,
    p.age         AS 나이
FROM guardian g
JOIN pet p ON g.guardian_id = p.guardian_id
ORDER BY g.guardian_id, p.pet_id;