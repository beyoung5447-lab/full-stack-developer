/* *select * from emp;
create table student09(
    snd number(4,0) constraint student09_snd_pk primary key
);
select * from STUDENT VALUES(1000);
insert into student VALUES(1000);
insert into student VALUES(1000);
insert into student VALUES(1000);
insert into student VALUES(null);

empolyee01 테이블에서 사원번호, 사원명을 설정하여 
테이블에 입력 하여 위 키에 대한 제약조건을 처리 내용을 확인

-- 1. 기존 테이블이 존재할 경우 삭제 (초기화)
DROP TABLE employee01 PURGE;

-- 2. 테이블 생성 및 제약조건 설정
-- emp_id: 기본키(PRIMARY KEY) 설정 -> 중복 불가, NULL 불가
-- emp_name: NOT NULL 설정 -> 필수 입력
CREATE TABLE employee01 (
    emp_id   NUMBER(4)     CONSTRAINT pk_employee01 PRIMARY KEY,
    emp_name VARCHAR2(50)  NOT NULL
);

-- 3. 정상 데이터 입력 (성공 케이스)
INSERT INTO employee01 (emp_id, emp_name) VALUES (1001, '김철수');
INSERT INTO employee01 (emp_id, emp_name) VALUES (1002, '이영희');

-- 변경사항 반영
COMMIT;


-- ========================================================
-- 4. 제약조건 위반 검증 (테스트 시 에러 발생 확인용)
-- ========================================================

-- [테스트 1] UNIQUE 제약조건 위반: 이미 존재하는 사원번호(1001) 입력 시도
-- 에러 발생: ORA-00001: unique constraint (...) violated
INSERT INTO employee01 (emp_id, emp_name) VALUES (1001, '박민수');

-- [테스트 2] NOT NULL 제약조건 위반: 기본키에 NULL 입력 시도
-- 에러 발생: ORA-01400: cannot insert NULL into (...)
INSERT INTO employee01 (emp_id, emp_name) VALUES (NULL, '최수진');


-- ========================================================
-- 5. 결과 및 설정 데이터 조회
-- ========================================================

-- ① 정상 등록된 데이터 확인
SELECT emp_id, emp_name 
FROM employee01;

-- ② 적용된 제약조건 정보 확인 (P: Primary Key, C: Check/Not Null)
SELECT 
    constraint_name, 
    constraint_type, 
    table_name 
FROM user_constraints 
WHERE table_name = 'EMPLOYEE01';
check: 특정한 데이터만 입력되는 비교/논리 연산식(where 제약 조건안에 들어가는 것)으로 설정
1. 기본 형식
컬럼명  데이터 유형 constraints 제약조건명 check(비교/논리 연산식)
CREATE TABLE student10 (
    name   VARCHAR2(50),
    gender CHAR(1) CONSTRAINT student_gender_ck CHECK (gender IN ('f', 'm'))
);
select *from STUDENT;
insert into STUDENT10 values ('홍길동','f');
insert into STUDENT10 values ('김미나','m');
insert into STUDENT10 values ('김미나','k');
insert into STUDENT10 values ('김미나','null');
select *
from EMP
where sal between 1000 and 2000;
sutdent1만 만들고 sno,name, grade(check 제약조건으로 1~4까지만 입력 되게 처리) 테이블 생성
CREATE TABLE student1 (
    sno   NUMBER(10),
    name  VARCHAR2(50),
    grade NUMBER(1) CONSTRAINT student1_grade_ck CHECK (grade BETWEEN 1 AND 4)
);
-- 1. 정상 입력 테스트 (성공)
INSERT INTO student1 (sno, name, grade) VALUES (20240001, '김철수', 1);
INSERT INTO student1 (sno, name, grade) VALUES (20240002, '이영희', 4);

-- 2. CHECK 제약조건 위반 테스트 (에러 발생 - ORA-02290)
-- 학년에 5를 입력하면 범위(1~4)를 벗어나므로 거부됩니다.
INSERT INTO student1 (sno, name, grade) VALUES (20240003, '박민수', 5);

-- 3. 입력 데이터 확인
SELECT * FROM student1;
외래키 제약 조건
특정한 컬럼에 데이터 입력/수정의 범위가 다른 테이블의 데이터를 기준으로 처리할때 주로 사용
기본 형식: 컬럼명 데이터 유형 constraint 제약조건명 reference 참조테이블명(컬럼명)
emp테이블에서 deptno을 입력 할때 ept테이블의 deptno를 참조해서 입력이 가능합니다.
select * from emp;
select * from dept;

CREATE TABLE STUDENT11(
   SNO NUMBER(4,0) PRIMARY KEY, -- 오라클 시스템에서 자동으로 제약조건 이름 생성
   NAME varchar2(50),
   GRADE CHAR(1) CONSTRAINT STUDENT11_GRADE_CK CHECK( GRADE BETWEEN 1 AND 4)
);
SELECT FROM EMP;
SELECT * FROM DEPT;
CREATE TABLE EMP07(
    EMPNO NUMBER(4,0),
    ENAME VARCHAR2(50),
    DEPTNO NUMBER(2,0) CONSTRAINT EMP07_DEPNO_FK REFERENCES DEPT(DEPTNO)
);
INSERT INTO EMP07 VALUES(1000, '홍길동', 10);
INSERT INTO EMP07 VALUES(1001, '김길동', 20);
INSERT INTO EMP07 VALUES(1002, '신길동', 30);
INSERT INTO EMP07 VALUES(1003, '오길동', 40);
INSERT INTO EMP07 VALUES(1004, '마길동', 50); 
-- FOREIGN KEY 제약조건 입력 문제로 에러 발생 DEPT테이블에 있는 데이터가 입력되었을 때만 가능 하다
학생들이 과목신청현황을 확인 하는 1:다 관계의 테이블을 구성 할려고 한다.
우선 학생 테이블(student12 - sid(primary key), name, age)
과목별신청현황 테이블(student_subject, grade(1~4R까지 가능), 
sid 학생  id로 foregin key 생성
-- 1. (참고) 부모 테이블이 생성되어 있지 않다면 먼저 생성되어 있어야 합니다.
-- CREATE TABLE student1 (
--     sno NUMBER(10) CONSTRAINT pk_student1 PRIMARY KEY,
--     name VARCHAR2(50)
-- );

-- 2. 과목별신청현황(student_subject) 테이블 생성

-- 1. 기존 테이블 삭제 (초기화)
DROP TABLE student_subject PURGE;
DROP TABLE student1 PURGE;

-- 2. 부모 테이블 생성 (sno에 PRIMARY KEY 제약조건 추가)
CREATE TABLE student1 (
    sno   NUMBER(10) CONSTRAINT pk_student1 PRIMARY KEY, -- Primary Key 설정 필수!
    name  VARCHAR2(50),
    grade NUMBER(1) CONSTRAINT student1_grade_ck CHECK (grade BETWEEN 1 AND 4)
);

-- 3. 자식 테이블 생성 (정상 실행됨)
CREATE TABLE student_subject (
    sub_id   NUMBER(10),
    sid      NUMBER(10),
    sub_name VARCHAR2(100),
    grade    NUMBER(1),
    
    CONSTRAINT ck_student_subject_grade CHECK (grade BETWEEN 1 AND 4),
    -- student1 테이블의 PRIMARY KEY인 sno를 정상 참조
    CONSTRAINT fk_student_subject_sid FOREIGN KEY (sid) REFERENCES student1(sno)
);
-- [준비] 부모 테이블(student1)에 기준 학생 데이터 입력
INSERT INTO student1 (sno, name) VALUES (20240001, '김철수');
COMMIT;


-- 1. 정상 입력 테스트 (성공)
-- 존재 학생(20240001)과 유효 학년(2학년) 입력
INSERT INTO student_subject (sub_id, sid, sub_name, grade) 
VALUES (1, 20240001, '데이터베이스', 2);


-- 2. CHECK 제약조건 위반 테스트 (에러 발생 - ORA-02290)
-- 학년에 5 입력 시 범위(1~4) 초과로 실패
INSERT INTO student_subject (sub_id, sid, sub_name, grade) 
VALUES (2, 20240001, '자바프로그래밍', 5);


-- 3. Foreign Key 제약조건 위반 테스트 (에러 발생 - ORA-02291)
-- 부모 테이블(student1)에 존재하지 않는 학생 ID(99999999) 입력 시 실패
INSERT INTO student_subject (sub_id, sid, sub_name, grade) 
VALUES (3, 99999999, '인공지능기초', 3);


-- 4. 입력 데이터 확인
SELECT * FROM student_subject;
*/

