select * from emp;
select * from book;
/*order by
핵심 키워드
 order by 컬럼명 asc | desc 내림차순, 오르차순으로 특정 컬럼 기준으로 정렬 처리
select 문으로 조회된 데이터는 기본적으로 정해진 순서 없이 출력 될 수 있습니다.
이때, oredre by절을 사용하면 특정 컬럼을 기준으로 데이터를 줄 세울수 있습니다.
oreder by는 sql 문자에서 거의 항상 마지막에 위치하는 규칙이 있습니다. order by: 이제부터 
줄을 세우겠다는 선언 정렬 기준 컬럼: 키나 이름 처럼 줄을 세울 기준이 되는 컬럼
정렬 방식: 오름차순, 내림차순 정렬 order by 컬럼명 asc|DESC 내림차순 오름차순으로 특정 
컬럼기준으로 정렬처리 컬럼명만 지정하면 오름차순으로 처리가 된다.
select * from emp order by sal; 오름차순
select * from emp order by sal desc; 내림차순
order by: 이리와서 줄서
order: 명령하다, 순서를 정하다 + by: ~을 기준으로
asc는 ascending의 약자 디폴트는 asc
desc는  descending의 약자 
최근에 입사한 사람부터 최초로 입사한 사람까지 입사일 정렬
select * from emp order by hiredate desc;
부서 번호(deptno)를 기준으로 오름차순 정렬
select * from emp order by deptno;
다음 정렬
정렬을 진행할 때 하나의 기준으로 하는 경우도 있지만 제1기준으로 우선 정렬하고 그 이후에
제1기준이 같을때 제2기준으로 정렬을 하고자 할 때 사용됩니다.
부서별&이름 순 명단
모든 직원들 첫번째 기준인 부서 번호로 먼저 정렬하고 같은 부서 내에서는 두번째 기준인 이름으로
정렬하는 것을 말합니다. 
SELECT deptno, ename
FROM emp
ORDER BY deptno DESC, ename DESC;
SELECT deptno, ename
FROM emp
ORDER BY deptno DESC, ename;
모든 직원을 직책순으로 오름차순으로 정렬하고 같은 직책의 경우에는 급여가 가장 높은 부분부터 
낮은순으로 정렬
SELECT deptno, job, sal
FROM emp
ORDER BY deptno DESC, job ASC, sal DESC;
mgr이 관리자 번호를 기준으로 내림차순으로 정렬 하되 관리자 번호가 같으면 사원명을 기준으로
오름차순 정렬
SELECT *
FROM emp
ORDER BY mgr DESC, ename ASC;
정렬 칼럼을 인덱싱으로 선언하여 처리하기(자리번호 부르기)
데이터베이스 엔진에게 월급을 순서대로 줄세워라고 명령하는 두가지 다른 화법
결과는 완전히 동일, 명령 내리는 방식에 차이가 있습니다
이름표 부르기(order by sal)
가장 정석적이고 명확한 방법입니다. 누가 봐도 급여 기준으로 오름차순 정렬했구나하고 단번에 
이해 가능 시스템에 반영하거나 동료와 함께 보는 코드에서 가장 권장되는 방식
데이터베이스에서 select 목록에서 9번째에 있는 애 기준으로 줄 세워라고 지시하는 방식
select절에 나열하는 컬럼의 순서를 기준으로 한다.
1번 자리: ename
2번 자리: job
3번 자리: sal
이 숫자를 활용한 정렬은 현업에서 아주 명확한 장단점을 가집니다.
장점: 쿼리 작성의 효율성
타이핑 단축: 타이핑을 최소화 하여 빠르게 데이터를 조회할때 유용합니다.
복잡한 수식 정렬: 만약 select절에 복잡한 수식이 있다면 order by 위에 긴 수식을 똑같이 
복사해서 붙여넣거나 별칭을 따로 지정할 필요없이 깔끔하게 숫자 하나로 정렬을 끝내는 것이 가능
단점: 유지보수의 지뢰
만약 추후에 요구사항이 변경되어 누군가 select절 중간에 컬럼을 추가 한다면 대참사가 일어날 수
있습니다. 쿼리 실행시 에러는 전혀 발생 하지 않지만 데이터는 엉뚱하게 출력. 
실무 적용 포인트
혼자 데이터베이스에 접속해 빠르게 데이터를 훓어보는 일회성 조회에서는 숫자를 쓰는 최고의 
효율을 낸다. 애플리케이션 소스 코드에 삽입되어 오랫동안 유지보수해야 하는 쿼리라면 컬럼명을
써야 한다.
select 순서를 기준으로 숫자로 선택해서 정렬을 처리 가능
SELECT ENAME, JOB, SAL
FROM EMP
ORDER BY SAL;
SELECT ENAME, JOB, SAL
FROM EMP
ORDER BY 3;
도서정보에서 도서명, 출판사, 가격을 출력 하되, 순서번호로 가격을 기준으로 오름 차순으로 정렬
SELECT 
    ROW_NUMBER() OVER (ORDER BY price ASC) AS 순서번호,
    bookname AS 도서명,
    publisher AS 출판사,
    price AS 가격
FROM book
ORDER BY price ASC;
*/



