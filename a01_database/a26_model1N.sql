-- 1. 기존 테이블이 존재할 경우에만 삭제 (없으면 안전하게 건너뜀)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE STUDENT CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SCHOOL_CLASS CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- 2. 부모 테이블 생성 (SCHOOL_CLASS)
CREATE TABLE SCHOOL_CLASS (
    반번호 NUMBER PRIMARY KEY,
    반이름 VARCHAR2(50) NOT NULL
);

-- 3. 자식 테이블 생성 (STUDENT)
CREATE TABLE STUDENT (
    학번 VARCHAR2(20) PRIMARY KEY,
    학생이름 VARCHAR2(50) NOT NULL,
    반번호 NUMBER NOT NULL,
    CONSTRAINT FK_STUDENT_CLASS FOREIGN KEY (반번호) REFERENCES SCHOOL_CLASS(반번호)
);

-- 4. 샘플 데이터 입력
INSERT INTO SCHOOL_CLASS (반번호, 반이름) VALUES (1, '1학년 1반');
INSERT INTO SCHOOL_CLASS (반번호, 반이름) VALUES (2, '1학년 2반');

INSERT INTO STUDENT (학번, 학생이름, 반번호) VALUES ('2026001', '김철수', 1);
INSERT INTO STUDENT (학번, 학생이름, 반번호) VALUES ('2026002', '이영희', 1);
INSERT INTO STUDENT (학번, 학생이름, 반번호) VALUES ('2026003', '박민수', 2);

-- 변경사항 영구 저장
COMMIT;

-- 5. 데이터 최종 조회 (출력)
SELECT 
    S.학번,
    S.학생이름,
    C.반번호,
    C.반이름
FROM STUDENT S
JOIN SCHOOL_CLASS C ON S.반번호 = C.반번호
ORDER BY S.학번;