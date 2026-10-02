select * from emp;
/* 삭제 처리
테이블에 이미 존재하는 데이터 행 전체를 삭제할 때 사용합니다. 
삭제는 where 조건절로 행단위로 전체를 삭제를 한다. 열단위 x
특정 열단위 데이터를 지울 때는 수정으로 해당 데이터에 대입연산자를 이용해서 null로 할당하여
실제 구문으로는 수저응로 처리된다.
기본형식
delete -- 삭제시는 행단위로 삭제 되기에 지정하는 옵션 자체가 없다.
from table
where 조건;
사원번호가 7363인 사원정보를 삭제하라
delete 
from emp01
where empno = 7363;
직책이 salesman이고 급여가 2000미만인 사원정보를 삭제하라
delete
from emp01
where job = 'SALESMAN'
and sal , 2000;
select * from emp01;
rollback;
select * from orders01;
order id가 5인 정보를 삭제
 WHERE orderid = 5;

-- 삭제 결과 확인
SELECT * FROM orders WHERE orderid = 5;
book id가 10이고 saleprice가 7000인 정보를 삭제
*/