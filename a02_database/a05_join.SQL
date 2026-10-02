/*
조인은 SQL에서 여러 테이블에 저장된 테이터를 관계에 따라 하나의 결과로 결합하여 조회할 때 
사용하는 기능입니다. 이는 관계형 데이터베이스에서 매우 중요한 개념으로 여러 테이블을 
효율적으로 관리하고 데이터를 조회할 때 사용합니다. 
조인의 기본 개념
조인은 여러 테이블에서 관련된 테이터를 결합하여 하나의 결과를 만들어 내는 SQL의 중요한 
기능입니다. 
select e *, d.loc
from emp e, dept d
where e.deprono = d.deptno;
enp e와 dept d는 emp와 dept 테이블의 별칭
e. deptno = d. deptno는 두 테이블을 deptno 컬럼을 기준으로 결합 하는 조건
결합된 데이터로 새로운 테이블 생성
두 테이블을 조인 하여 결합된 데이터를 새로운 테이블로 생성할 수 있습니다.
create table emp_dept
as select e.*, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno;
sql문은 empdhk dept 테이블을 조인 하여 emp_dept라는 새로운 테이블을 생성합니다.
업데이트 및 삭제 처리
테이블을 분리하여 관리하면 다음과 같은 장점이 있습니다.
예를 들어, 부서명을 변경할 때 EMP_DEPT 테이블에서는 모든 부서 관련 컬럼을 수정해야 하지만, DEPT 테이블만 
수정하면 일관성 문제가 해결됩니다.
부서 정보를 삭제할 때 관련된 사원 정보까지 삭제될 수 있으므로, EMP와 DEPT 테이블을 분리하면 사원 정보는 
그대로 유지됩니다.
사원 테이블과 부서테이블의 조인과 사원번호, 사원명, 부서번호, 부서명 출력
위 형식을 기반하여 사원명 급여 부서명 부서위치를  조인 형식으로 확인 해서 출력
SELECT 
    e.ename    AS "사원명",
    e.sal      AS "급여",
    d.dname    AS "부서명",
    d.loc      AS "부서위치"
FROM emp e, dept d
WHERE e.deptno = d.deptno;
CREATE TABLE MOVIE01 (
    MOVIE_ID INT,
    TITLE VARCHAR(50),
    GENRE VARCHAR(20)
);

INSERT INTO MOVIE01 VALUES (101, '인셉션', 'SF');
INSERT INTO MOVIE01 VALUES (102, '어벤져스', '액션');
INSERT INTO MOVIE01 VALUES (103, '라라랜드', '뮤지컬');
INSERT INTO MOVIE01 VALUES (104, '명량', '역사');
INSERT INTO MOVIE01 VALUES (105, '해리포터', '판타지');


CREATE TABLE CUSTOMER02 (
    CUSTOMER_ID INT,
    NAME VARCHAR(20),
    MOVIE_ID INT
);

INSERT INTO CUSTOMER02 VALUES (1, '철수', 101);
INSERT INTO CUSTOMER02 VALUES (2, '영희', 102);
INSERT INTO CUSTOMER02 VALUES (3, '민수', 103);
INSERT INTO CUSTOMER02 VALUES (4, '수지', 105);
INSERT INTO CUSTOMER02 VALUES (5, '바나나킥', NULL);

SELECT * FROM MOVIE01;
SELECT * FROM CUSTOMER02;
고객별 영화 관람 내역을 확인 하려고 한다. 고객명 영화명 영화종류 조인 하여 출력
SELECT 
    c.name    AS "고객명",
    m.title   AS "영화명",
    m.genre   AS "장르"
FROM customer c
JOIN movie m ON c.movie_id = m.movie_id;
ansi sql
미국 국립 표준협회에서 제정한 표준 sql 문법을 의미 합니다.
특정 데이터 베이스에 종속 되지 않고 모든 dbms에서 공통으로 사용할 수 있도록 공인된 표준
위와 같은 두 테이블간의 연관 컬럼 기준으로 설정하는 ansi 방식은 아래와 같습니다
SELECT 
    e.*, 
    d.dname, 
    d.loc
FROM emp e 
INNER JOIN dept d
   ON e.deptno = d.deptno;
아웃조인
두 개 이상의 테이블을 조인할 때 조인 조건에 맞는 데이터뿐만 아니라 한쪽 테이블만
존재하는 데이터도 결과에 포함 시키는 조인 방식
outer join
left outer join: 기준 테이블이 왼쪽 테이블이고 오른쪽 테이블에 같이 없더라도 출력 
right outer join: 기준 테이블이 오른쪽 테이블이고 왼쪽 테이블에 같이 없더라도 출력
full outer join: 양쪽 모두 포함하여 데이터가 없는 쪽이 null이라도 출력
sELECT * FROM MOVIE01;  -- MOVIE_ID : 101, 102, 103, 104, 105 
SELECT * FROM CUSTOMER02; -- MOVIE_ID : 101, 102, 103, 105, NULL
-- INNER JOIN으로 출력되는 결과는 MOVIE_ID : 101, 102, 103, 105 출력된다.

SELECT M.MOVIE_ID, NAME "고객명", TITLE "영화명", GENRE "영화종류"  -- 동일한 컬럼명이 테이블마다 있는 않은 경우 테이블별칭생략가능
FROM MOVIE01 M, CUSTOMER02 C
WHERE M.MOVIE_ID = C.MOVIE_ID;
-- 제안1  일단을 영화를 기준으로 영화를 보는 고객을 출력하고 싶다. 즉, 영화에 등록된 내용은 다 보이면서, 연동된
--        고객리스트를 보고싶을 때?
SELECT M.*, C.*
FROM MOVIE01 M 
LEFT OUTER JOIN CUSTOMER02 C
  ON M.MOVIE_ID = C.MOVIE_ID;
-- 제안2  고객입장에서 이 고객 정보를 보이면서 영화를 출력하고 싶다. 즉, 기본 고객정보는 출력이 되고, 그외 연동된
--        영화리스트를 보고싶을 때?
SELECT M.*, C.*
FROM MOVIE01 M RIGHT OUTER JOIN CUSTOMER02 C
  ON M.MOVIE_ID = C.MOVIE_ID;
-- 제안3  영화든 고객이든 모든 정보를 보이면서, 연결되지 않는 정보는 표시하고 싶을 때..
SELECT M., C.
SELECT M.*, C.*
FROM MOVIE01 M FULL OUTER JOIN CUSTOMER02 C
  ON M.MOVIE_ID = C.MOVIE_ID;
  - 1. IDOL 테이블 (아이돌 그룹)
CREATE TABLE IDOL (
    IDOL_ID NUMBER PRIMARY KEY,
    GROUP_NAME VARCHAR2(50),
    FANDOM_NAME VARCHAR2(50)
);

-- 2. FAN_MEETING 테이블 (팬미팅 참석자)
CREATE TABLE FAN_MEETING (
    FAN_ID NUMBER PRIMARY KEY,
    FAN_NAME VARCHAR2(50),
    IDOL_ID NUMBER
);

-- 샘플 데이터 입력
-- 아이돌 데이터 (데뷔했지만 아직 팬미팅을 안 했거나, 신생 그룹 포함)
INSERT INTO IDOL VALUES (1, '방탄소년단', 'ARMY');
INSERT INTO IDOL VALUES (2, '아이브', 'DIVE');
INSERT INTO IDOL VALUES (3, '뉴진스', 'Bunnies');
INSERT INTO IDOL VALUES (4, '라이즈', 'BRIIZE'); -- 아직 팬미팅 데이터가 없는 신규 그룹

-- 팬 데이터 (입덕한 팬들, 혹은 탈퇴/잘못된 정보 입력된 팬 포함)
INSERT INTO FAN_MEETING VALUES (101, '김민수', 1);
INSERT INTO FAN_MEETING VALUES (102, '이서연', 2);
INSERT INTO FAN_MEETING VALUES (103, '박지훈', 1);
INSERT INTO FAN_MEETING VALUES (104, '최수아', 3);
INSERT INTO FAN_MEETING VALUES (105, 'unknown팬', 99); -- 존재하지 않는 아이돌 ID를 가진 팬

COMMIT;
left outer join
SELECT 
    I.IDOL_ID,
    I.GROUP_NAME,
    I.FANDOM_NAME,
    F.FAN_ID,
    F.FAN_NAME
FROM IDOL I
LEFT OUTER JOIN FAN_MEETING F ON I.IDOL_ID = F.IDOL_ID
ORDER BY I.IDOL_ID, F.FAN_ID;
right outer join
SELECT 
    I.IDOL_ID,
    I.GROUP_NAME,
    I.FANDOM_NAME,
    F.FAN_ID,
    F.FAN_NAME
FROM IDOL I
RIGHT OUTER JOIN FAN_MEETING F ON I.IDOL_ID = F.IDOL_ID
ORDER BY F.FAN_ID;
full outer join
SELECT 
    I.IDOL_ID,
    I.GROUP_NAME,
    I.FANDOM_NAME,
    F.FAN_ID,
    F.FAN_NAME
FROM IDOL I
FULL OUTER JOIN FAN_MEETING F ON I.IDOL_ID = F.IDOL_ID
ORDER BY NVL(I.IDOL_ID, 999), F.FAN_ID;
*/