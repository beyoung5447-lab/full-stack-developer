/*
무결성 제약 조건
무결성이란 데이터와 흠결이 없는 것으로 데이터의 정확성과 일관성을 의미한다.
주민번호가 중복되지 않게 처리한다던지 부서정보가 있는 테이블에 있는 부서번호만 
등록되게 한다던지 학년 컬럼에 1~4학년만 입력되게 범위를 정하는등 해당 데이터가
데이터의 정확성과 일관성에 맞게 등록/ 수정이 가능하게 하는 것을 말한다.
데이터의 정확성을 유지하기 위해서는 다양한 종류의 업무규칙을 고려하여야 한다.
주민번호는 식별이 가능하게 입력
학사테이블에 학생이름은 반드시 입력하게 처리
수강과목은 수강테이블에 등록된 과목만 가능하게 하는 것등을 말한다
데이터 무결성 제약조건의 장점
데이터 생성시, 무결성 제약조건을 정의 가능
생성 후에도 제약조건 변경 삭제 가능
테이블에 대해 정의, 데이터 딕셔너리에 저장되므로
행동프로그램에서 입력한 모든 데이터에 대해 동일하게 적용
제약조건이 걸려 있는 컬럼에 위반 되면 해당 행 전체가 입력 x
무결성 제약조건의 종류
not null: 열에 null을 포함 할 수 없음
unique key: 테이블에 모든 행에 고유값을 갖는 열 또는 열조합을 지정해야 한다.
primary key: 해당 컬럼 같은 반드시 존재 해야 하며 유일해야 한다.
foreign key: 한 열과 참조되는 테이블의 열간에 외래키 관계를 설정 하고 시행
check: 해당 컬럼에 저장 가능한 데이터 값의 범위나 조건을 저장 하여 처리
제약 조건 이름 설정 규칙
이름 없이 생성 하면 내부적 메타정보에 의해서 자동 생성이 된다.
이름 설정하여 처리 하는 경우
constraints 테이블명_컬럼명_제약조건(uk,nn,pr,fk,ck) 형식으로 처리 한다.
메타 정보로 제약 조건 확인
select *
from user_constraints
where tabels_name = '테이블명대문자';
not null 제약 조건 설정 메타정보 확인 
CREATE TABLE STUDENT05(
    NAME varchar2(50)
);
INSERT INTO STUDENT05 VALUES('홍길동');
INSERT INTO STUDENT05 VALUES(NULL);
SELECT * FROM STUDENT05;
SELECT * 
FROM user_constraints 
WHERE table_name = 'STUDENT04';
student06 학생명, 국어, 영어, 수학 점수를 컬럼 타입으로 지정하되 학생명과 국어 점수 not null로
설정해, 데이터 입력시 제약 조건이 어떻게 작동하는지 확인하고 메타정보 user_contrsints로 확인
--------------------------------------------------
-- 1. 기존 테이블 삭제 (초기화)
--------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE student06 PURGE';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

--------------------------------------------------
-- 2. DDL: student06 테이블 생성 및 NOT NULL 설정
--------------------------------------------------
CREATE TABLE student06 (
    student_name VARCHAR2(50) NOT NULL, -- 학생명 (필수)
    kor_score    NUMBER(3)    NOT NULL, -- 국어 점수 (필수)
    eng_score    NUMBER(3),             -- 영어 점수 (선택 - NULL 허용)
    math_score   NUMBER(3)              -- 수학 점수 (선택 - NULL 허용)
);

--------------------------------------------------
-- 3. DML: 데이터 입력 테스트 및 제약조건 검증
--------------------------------------------------

-- [테스트 1] 정상 입력: 모든 값 지정
INSERT INTO student06 (student_name, kor_score, eng_score, math_score) 
VALUES ('김철수', 90, 85, 95);

-- [테스트 2] 정상 입력: NOT NULL 컬럼만 입력 (영어, 수학은 NULL 저장)
INSERT INTO student06 (student_name, kor_score) 
VALUES ('이영희', 100);

-- [테스트 3] ❌ 에러 발생: 국어 점수(kor_score)에 NULL 명시 입력 시도
-- 오류: ORA-01400: NULL을 ("SCOTT"."STUDENT06"."KOR_SCORE") 안에 삽입할 수 없습니다
-- INSERT INTO student06 (student_name, kor_score) VALUES ('박민수', NULL);

-- [테스트 4] ❌ 에러 발생: 필수 입력 컬럼(student_name) 누락 시도
-- 오류: ORA-01400: NULL을 ("SCOTT"."STUDENT06"."STUDENT_NAME") 안에 삽입할 수 없습니다
-- INSERT INTO student06 (kor_score, eng_score) VALUES (80, 70);

-- 성공한 데이터 저장
COMMIT;

--------------------------------------------------
-- 4. DQL: 저장된 데이터 확인
--------------------------------------------------
SELECT * FROM student06;

--------------------------------------------------
-- 5. 메타 정보 확인: USER_CONSTRAINTS 조회
--------------------------------------------------
-- 오라클에서 NOT NULL 제약조건은 C (Check) 유형으로 분류됩니다.
SELECT 
    constraint_name AS "제약조건명",
    constraint_type AS "유형",      -- C: CHECK (NOT NULL 포함)
    table_name      AS "테이블명",
    search_condition AS "조건식",    -- "STUDENT_NAME" IS NOT NULL 등
    status          AS "상태"
FROM user_constraints 
WHERE table_name = 'STUDENT06';
제약 조건 unique key: 유일한 입력 데이터 처리시 사용된다. 하지만 null이 입력 하더라도 상관없다.
제약조건 이름 설정 하기: 칼럼명 데이터 유형 constraints 제약조건명 제약조건(unique)
제약 조건 이름은 일반적으로 테이블명_컬럼명_제약조건유형
제약조건 유형: nn(not null), uk(unique), pr(primary key), ck(check)
student06테이블에 name에 not null 설정, student06_name_nm
학생 테이블 student07 snd를 unique 제약 조건 설정, 제약조건명 (student07_snd_uk)
create table student07(
    snd number(5,0) constraint student07_snd_uk unique
);
select * from STUDENT07;
-- Check table data
SELECT * FROM STUDENT07;

-- Check constraints for the table
SELECT constraint_name, constraint_type, search_condition 
FROM user_constraints 
WHERE table_name = 'STUDENT07';

-- Insert statements
INSERT INTO STUDENT07 VALUES (NULL);
INSERT INTO STUDENT07 VALUES (3000);
INSERT INTO STUDENT07 VALUES (4000);
INSERT INTO STUDENT07 VALUES (3000);
INSERT INTO STUDENT07 VALUES (NULL);
INSERT INTO STUDENT07 VALUES (NULL);
INSERT INTO STUDENT07 VALUES (5000);
student08 테이블로 학번 이름 국어 영어 처리하되 학번 이름 국어 영어 후사
제약조건 이름을 설정하여 처리하고 user_constratints에서 확인
CREATE TABLE STUDENT08 (
    STUDENT_ID  NUMBER(5),
    NAME        VARCHAR2(20),
    KOR         NUMBER(3),
    ENG         NUMBER(3),
    
    -- 제약조건 명시적 생성 (제약조건 이름 지정)
    CONSTRAINT PK_STUDENT08_ID   PRIMARY KEY (STUDENT_ID),
    CONSTRAINT NN_STUDENT08_NAME CHECK (NAME IS NOT NULL),
    CONSTRAINT CK_STUDENT08_KOR  CHECK (KOR BETWEEN 0 AND 100),
    CONSTRAINT CK_STUDENT08_ENG  CHECK (ENG BETWEEN 0 AND 100)
);
-- 정상 데이터 입력
INSERT INTO STUDENT08 VALUES (202401, '홍길동', 90, 85);
INSERT INTO STUDENT08 VALUES (202402, '이순신', 100, 95);

-- 데이터 확인
SELECT * FROM STUDENT08;

SELECT constraint_name, 
       constraint_type, 
       search_condition
FROM user_constraints
WHERE table_name = 'STUDENT08';
*/
