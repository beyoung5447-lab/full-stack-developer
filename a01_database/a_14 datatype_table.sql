select * from emp;
/*테이블 만들기 
테이블을 만드는 과정은 데이터베이스 설계의 핵심 요소이다. oracel sql은 테이블을
생성하면 테이블을 구조화 하고 효율적으로 관리할 수 있다. 주요 요소로는 테이블명, 
열 정의, 제약 조건, 기본값 설정등이 있다.
테이블의 구성요소에 대한 이해
테이블명 및 구조 정의
테이블명을 정하고 각열의 이름과 데이터 유형을 결정한다. 예를 들어,
사원정보를 저장할 테이블의 경우 employee라는 테이블명으로 테이블을 생성할 수 있다.
컬럼명
각 옆에 대한 데이터 유형을 지정하고 필요에 따라 크기및 제약 조건을 설정한다.
예를 들어 사원번호, 이름, 입사일, 급여등을 열로 정의 할 수 있다.
데이터 유형
오라클에서도 프로그래밍과 같이 각 컬럼명에 매칭 되는 데이터 유형을 지정할 수 있다.
기본적인 데이터 유형으로 varchar2 가변형 문자열, date 날짜형등이 있다
blob, file,timestamp등 여러 유형이 있다.
데이터 베이스는 boolean 유형의 타입이 없지만 숫자형을 저장 하면
일반 프로그래밍에서는 boolean 값으로 할당하여 true flase를 처리 할 수 있다.
기본 만들기
create table 테이블명(
   컬럼명1 데이터 유형,
   컬럼명2, 데이터 유형
);
복사 테이블 만들기: 기존에 있는 테이블을 기준으로서 구조와 이름을 차용 하면서 새로운 테이블을
만드는 것을 말한다.
구조와 특정 컬럼의 데이터를 복사.
   CREATE TABLE 테이블명
   AS SELECT 복사할컬럼1, 복사할컬럼2 
       FROM 테이블명;

구조만 복사
CREATE TABLE 테이블명
AS SELECT *
  FROM 테이블명
  WHERE 1=0;   -- 1=0 비교연산식으로 FALSE가 처리되어 데이터를 가져오지 못하지만
              이 테이블의 구조를 복사할 수 있게 한다.
CREATE TABLE student_info (
    no NUMBER,
    name VARCHAR2(20),
    subject VARCHAR2(50),
    grade NUMBER(1, 0)
);
INSERT INTO student VALUES (1, '홍길동', 80, 90, 80);
INSERT INTO student VALUES (2, '강길동', 80, 90, 80);
INSERT INTO student VALUES (3, '신길동', 80, 90, 80);
COMMIT;
테이블명: GOLF_CLUB

컬럼 구성 및 데이터 타입:

MEMBER_NO (회원번호): 숫자형, 최대 4자리 정수

MEMBER_NAME (회원이름 및 직책): 문자형, 가변길이 최대 50바이트

DRIVE_DIST (평균 드라이버 비거리, 단위: m): 숫자형, 최대 3자리 정수

PUTTING_AVG (18홀 평균 퍼팅 수): 숫자형, 최대 3자리 정수

BEST_SCORE (18홀 최고 타수): 숫자형, 최대 3자리 정수

데이터 입력 (INSERT): 다음 3명의 회원 정보를 테이블에 추가하세요.

회원번호 1, '김부장(회장)', 비거리 210, 퍼팅 32, 타수 82

회원번호 2, '이이사(총무)', 비거리 195, 퍼팅 30, 타수 78

회원번호 3, '박대리(신입)', 비거리 245, 퍼팅 45, 타수 98

마무리: 입력한 데이터가 영구적으로 저장되도록 트랜잭션을 확정(COMMIT)하고, 테이블 전체 데이터
를 조회해 보세요.
-- 1. GOLF_CLUB 테이블 생성
CREATE TABLE GOLF_CLUB (
    MEMBER_NO   NUMBER(4, 0),
    MEMBER_NAME VARCHAR2(50),
    DRIVE_DIST  NUMBER(3, 0),
    PUTTING_AVG NUMBER(3, 0),
    BEST_SCORE  NUMBER(3, 0)
);

-- 2. 회원 데이터 3건 입력
INSERT INTO GOLF_CLUB (MEMBER_NO, MEMBER_NAME, DRIVE_DIST, PUTTING_AVG, BEST_SCORE)
VALUES (1, '김부장(회장)', 210, 32, 82);

INSERT INTO GOLF_CLUB (MEMBER_NO, MEMBER_NAME, DRIVE_DIST, PUTTING_AVG, BEST_SCORE)
VALUES (2, '이이사(총무)', 195, 30, 78);

INSERT INTO GOLF_CLUB (MEMBER_NO, MEMBER_NAME, DRIVE_DIST, PUTTING_AVG, BEST_SCORE)
VALUES (3, '박대리(신입)', 245, 45, 98);

-- 3. 데이터 영구 저장 (트랜잭션 확정)
COMMIT;

-- 4. 전체 데이터 조회
SELECT * FROM GOLF_CLUB;
복사 테이블 만들기
create table student01
as select * from STUDENT;
select * from student01;
구조만 복사
CREATE TABLE GOLF_CLUB_NEW AS 
SELECT * 
FROM GOLF_CLUB 
WHERE 1 = 0;
DESC GOLF_CLUB_NEW;
SELECT * FROM GOLF_CLUB_NEW;
-- 1. emp 테이블의 empno, ename, job 컬럼으로 emp02 테이블 생성
CREATE TABLE emp02 AS 
SELECT empno, ename, job 
FROM emp;

-- 2. 생성된 emp02 테이블 데이터 조회
SELECT * FROM emp02;
골프 동호회의 규모가 커지면서 데이터를 안전하게 백업하고, 다음 시즌을 위한 신규 테이블을 준비하려고 합니다. 또한, 외부 동호회와의 친선 교류전을 위해 회원들의 일부 정보만 추려낸 간단한 명단도 필요해졌습니다. 앞서 배운 '복사 테이블 만들기' 기능을 활용하여 다음 요구사항을 해결해 보세요.

[요구사항]

전체 데이터 백업: 기존 GOLF_CLUB 테이블의 구조와 저장된 모든 데이터를 그대로 복사하여 GOLF_CLUB_BACKUP 테이블을 생성하세요.

구조만 복사 (신규 시즌 준비): GOLF_CLUB 테이블의 구조만 복사(데이터는 제외)하여 2027년도 회원을 관리할 GOLF_CLUB_2027 테이블을 생성하세요. 생성 직후 다음 신규 회원의 데이터를 입력하고 저장(COMMIT)하세요.

입력 데이터: 4, '최과장(총무보조)', 220, 38, 90

특정 컬럼 추출 및 이름 변경 (교류전 명단): 기존 GOLF_CLUB 테이블에서 회원의 기본 정보와 실력만 보여주기 위해, MEMBER_NO는 NO로, MEMBER_NAME은 NAME으로, BEST_SCORE는 SCORE로 컬럼명(별칭)을 변경하여 GOLF_ROSTER 테이블을 생성하세요.
--------------------------------------------------
-- 1. 전체 데이터 백업 (구조 + 모든 데이터 복사)
--------------------------------------------------
CREATE TABLE GOLF_CLUB_BACKUP AS 
SELECT * 
FROM GOLF_CLUB;

--------------------------------------------------
-- 2. 구조만 복사 (2027년도 신규 시즌 준비)
--------------------------------------------------
-- WHERE 1=0 조건으로 데이터 제외 후 구조만 복사
CREATE TABLE GOLF_CLUB_2027 AS 
SELECT * 
FROM GOLF_CLUB 
WHERE 1 = 0;

-- 신규 회원 데이터 입력
INSERT INTO GOLF_CLUB_2027 (MEMBER_NO, MEMBER_NAME, DRIVE_DIST, PUTTING_AVG, BEST_SCORE)
VALUES (4, '최과장(총무보조)', 220, 38, 90);

-- 트랜잭션 확정 (저장)
COMMIT;

--------------------------------------------------
-- 3. 특정 컬럼 추출 및 컬럼명 변경 (교류전 명단)
--------------------------------------------------
-- 컬럼 별칭(AS)을 사용하여 원하는 이름으로 새로운 테이블 생성
CREATE TABLE GOLF_ROSTER AS 
SELECT 
    MEMBER_NO   AS NO,
    MEMBER_NAME AS NAME,
    BEST_SCORE  AS SCORE
FROM GOLF_CLUB;
-- 1. 백업 테이블 확인 (기존 3명 데이터 포함 여부)
SELECT * FROM GOLF_CLUB_BACKUP;

-- 2. 2027년 테이블 확인 (신규 최과장 1명 데이터 포함 여부)
SELECT * FROM GOLF_CLUB_2027;

-- 3. 교류전 명단 확인 (NO, NAME, SCORE 컬럼 및 3명 데이터)
SELECT * FROM GOLF_ROSTER;
데이터 삭제 명령어
drop table 테이블명;
*/