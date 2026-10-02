select * from emp;
/*데이터의 수정 처리
update: 테이블에 이미 존재하는 데이터의 내용을 다른 값으로 변경할때 사용
기본형식
update 테이블명
set 수정할 컬럼1 수정할 데이터
    수정할 컬럼2 수정할 데이터
    ...
    where 테이블의 특정한 조건
    emp01 기준으로 급여가 3000이상인 데이터는 6000으로 동일하게 데이터를 수정하자
CREATE TABLE emp01 AS 
SELECT * FROM emp;

-- 2. 급여 수정 및 확인
UPDATE emp01
   SET sal = 6000
 WHERE sal >= 3000;

SELECT * FROM emp01;

-- 3. 롤백 및 확인
ROLLBACK;

SELECT * FROM emp01;

-- 4. 조건별 수정 (구문 오류 수정 완료)
UPDATE emp01
   SET comm = 888,                 -- 쉼표(,) 추가
       hiredate = sysdate,         -- sysdate 오타 수정 및 쉼표(,) 추가
       sal = sal + (sal * 0.15)    -- 마지막 항목 뒤에는 쉼표 없음
 WHERE deptno = 10;

-- 5. 조회 및 롤백 (오타 수정 완료)
SELECT * FROM emp01;               -- demp01 -> emp01 오타 수정

ROLLBACK;

SELECT * FROM emp01;
customer01 기준으로 custid가 5번인 정보의 phone을 010-8888-9999로 변경
UPDATE customer01
   SET phone = '010-8888-9999'
 WHERE custid = 5;

-- 변경 결과 확인
SELECT * FROM customer01 WHERE custid = 5;
book기준으로 price가 1000이상인 도서정보의 bookname을 마지막에 [수정]을 붙여서 처리하고
price는 기준 금액에서 10%를 더한 금액으로 수정 처리
UPDATE book
   SET bookname = bookname || '[수정]',
       price = price * 1.1
 WHERE price >= 1000;

-- 변경 결과 확인
SELECT * FROM book WHERE price >= 1000;*/



