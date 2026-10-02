select * from emp;'
/* 복사테이블 만들기
아무기반 없이 테이블을 만들기 위해서는 복잡한 과정을 거친다
테이블명 지정, 그 테이블안에 어떤 데이터 유형, 이름을 설정 해서 데이터를 입력할 저장 구조인
테이블을 만들어야 하고 해당 테이블에 컬럼과 유형에 맞게 데이터를 입력 해야 한다.
데이터 생성 규칙인 속성의 유형과 이름을 지정하는 내용을 알아야 한다.
우선 복사 테이블로 간단하게 기존 테이블의 내용을 활용하여 임시 테이블 + 데이터를 만들어서
데이터의 등록, 수정, 삭제하는 연습을 하도록 한다.
기본형식
create 추가할 테이블명
as select * from 원본테이블;
테이블을 새롭게 만드는데 구조뿐만 아니라 데이터도 입력된 새로운 테이블이 생성된다.
create table empo1
as
select * from emp;
select * from emp;
books1이라는 복사테이블을 book을 기반하여 만드세요
CREATE TABLE books1 AS 
SELECT * FROM book;
CREATE TABLE depto1
AS 
SELECT * FROM dept;
dml(data manipulation language, 데이터 조작법)
데이터베이스의 테이블에서 테이블을 등록 수정하거나 삭제할때 사용하는 sql명령을 dml
dml의 핵심은 insert, update, delete
데이터 입력 처리
만들어진 테이블에 데이터를 입력을 위해서는 insert를 구분을 이용
데이터 입력 방식
전체 컬럼 데이터 입력
insert into 테이블명 values
테이블 생성시 만들어진 컬럼의 순서대로 각각의 컬럼에 정의한 데이터 유형에 맞게 데이터를 
입력하여 하나의 행단위의 데이터가 입력된다.
컬럼지정 데이터 입력
특정한 경우에는 특정한 컬럼에만 데이터를 입력하는 경우가 필요로 한다, 이때는 반드시 해당 
테이블의 컬럼명을 지정하여 해당 컬럼에 맞는 유형의 데이터를 입력 해야 한다. insert into
테이블명, vlaues
dpto1 테이블의 전체 영에 데이터를 입력한다.
INSERT INTO depto1 VALUES (50, '인사', '서울');
SELECT * FROM depto1;
각 컬럼별 데이터 유형을 확인하고 전체 데이터를 행단위로 입력
select * from books1;
insert into books1 values(11, '오라클 기초', '데이터 기초',2500);
CREATE TABLE CUSTOMER01
AS 
SELECT * FROM CUSTOMER;
SELECT * FROM CUSTOMER01;
insert into customer01 values(6,'홍길동','대한민국서울','010-0000-0000');
orders 테이블을 기준으로 복사테이블 order01을 만들고 데이터를 입력하세여
SELECT table_name 
FROM user_tables;
SELECT * FROM orders;
지정된 컬럼의 데이터만 입력하는 경우
SELECT * FROM depto1;
INSERT INTO depto1 (deptno) VALUES (60);
SELECT * FROM depto1;
book1은 bookid와 price 입력
SELECT table_name FROM user_tables;
SELECT * FROM books1;
INSERT INTO books1 (bookid, price) VALUES (1, 15000);
SELECT * FROM books1;
custermor1은  custid, name, phone만 처리
INSERT INTO customer1 (custid, name, phone) 
VALUES (1, '홍길동', '010-1234-5678');
SELECT * FROM customer1;
dml에서 주로 발생한는 트렌젝션 문제
dml에서 취소할지를 결절하는 프로세스는 만들어져 잇다. 이 과정을 트랙젝션이라고 한다.
데이터의 일관성과 안전성을 보장한다. 트렉젝션: 데이터의 직업을 처리하는 하나의 논리적 단위
, insert, update, delete 같은 여러 dml이 하나의 트렉젝션으로 묶인다.
commit: 모든 dmi 작업을 성공적으로 마치고 변경된 내용을 데이터베이스 서버에 영구적으로
저장하는 명령어입니다. 커밋이 완료되면 이전 상태로 되도릴 수 없습니다.
rollback: dml 작업 중 문제가 발생 했거나 작업을 취소 하고 싶을때 가장 마지막에 commit 
시점 이전에 commit을 하기 위한 명령어.  save point: 긴 트렉젝션안에서 중간 저장 지점을 
만드는 명령어입니다. 문제가 생겼을때, 전체를 rollback하는 대신 특정 savepint 지점 까지만 
되돌아 갈 수 있습니다.
-- 1. 초기 상태 조회
-- dept 테이블을 복사하여 dept01 테이블 생성
CREATE TABLE dept01 AS 
SELECT * FROM dept;
SELECT * FROM dept01;

-- 2. 부서번호 80 추가 및 확인
INSERT INTO dept01 (deptno) VALUES (80);
SELECT * FROM dept01;

-- 3. 이전 상태로 롤백 (80번 취소)
ROLLBACK;

-- 4. 롤백 결과 확인 (80번이 없어져야 함)
SELECT * FROM dept01;

-- 5. 부서번호 90 추가 및 확인 
INSERT INTO dept01 (deptno) VALUES (90);
SELECT * FROM dept01;

-- 6. 이전 상태로 롤백 (90번 취소)
ROLLBACK;

-- 7. 최종 상태 확인 (depto1 -> dept01 오타 수정)
SELECT * FROM dept01;

-- 4. Verify the rollback (row 80 should be gone)
SELECT * FROM dept01;

-- 5. Insert another department and verify (fixed table name: dept01)
INSERT INTO dept01 (deptno) VALUES (90);
SELECT * FROM dept01;

-- 6. Roll back the second insertion
ROLLBACK;

-- 7. Final verification
SELECT * FROM dept01; 
rollback은 여러개의 명령들도 commit 하기전에 모두 왕복이 가능
book1에 대해 13, 14으로 데이터 2개 행을 입력 하여 확인을 하고 롤백을 해서 왕복이 되는지 
확인하고 다시 15,16 데이터 2개행을 입력후 확인하는데 이번에는 커밋을 처리하여 다시 롤백을
해서 왕복이 되는지 확인하세요 
SELECT FROM BOOK01;
INSERT INTO BOOK01(BOOKID) VALUES(13);
INSERT INTO BOOK01 VALUES(14, '파이썬 기초','파이썬제국', 27000);
-- 입력 후, 롤백 처리
ROLLBACK;
INSERT INTO BOOK01(BOOKID) VALUES(15);
INSERT INTO BOOK01(BOOKID, BOOKNAME) VALUES(16, '빅데이터 기초');
COMMIT;
SELECT * FROM BOOK01;
ROLLBACK;
SELECT * FROM BOOK01;
*/
