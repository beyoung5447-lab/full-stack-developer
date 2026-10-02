select * from emp;
/* 오라클의 키워드 연산자
키워드 연산자: 단순한 비교를 넘어 특별한 의미를 가진 예약어(keyword)를 사용하여 복잡한
조건을 간결하게 처리하는 연산자를 말합니다. 데이터베이스에게 목록안에 있는 것만 찾아줘
또는 범위안에 해당 하는 것만 보여줘 같이 보다 구체적이고 복잡한 명령을 내릴 때 사용하는 
특수명령 where 조건 절에서 필터링 조건을 만들때 코드의 가독성을 높이고 여러 줄로 작성 해야 할
or나 and 조합을 한줄로 깔끔하게 만들어주는 역할
핵심코드
in(데이터 1,데이터2,데이터3)
between 데이터 1 and 데이터 2
like '$$'
컬럼 is null
SELECT *
FROM emp
WHERE comm IS NULL;
null이 아닐때는 is not
in 키워드 연산자
특정 직책을 가진 사원들처럼 여러 값중 하나라도 일치하는 데이터 찾을때 사용
쇼핑 바구니에 달아둔 리스트에 해당 하는 사원만 고른다고 생가
직책이 'manager','salesman'인 사원만 사원명, 직책명을 찾자
SELECT ename, job
FROM emp
WHERE UPPER(job) IN ('MANAGER', 'SALESMAN'
사원번호가 7369,7521,7782인 사원정보 사원번호, 사원명을 출력
SELECT empno, ename
FROM emp
WHERE empno IN (7369, 7521, 7782);
컬럼명 between 시작 and 마지막: 해당 컬럼에 특정 데이터 범위를 지정해서 해당 데이터로 
로딩하여 처리
급여가 2000 - 3000 사이의 사원명, 급여를 출력
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 2000 AND 3000;
사원번호가 7800 부터 7900까지 데이터를 검색하여 사원 번호, 사원명을 출력 하세요.
SELECT empno, ename
FROM emp
WHERE empno BETWEEN 7800 AND 7900;
like 
오라클데이터베이스에서 원하는 데이터를 효과적으로 검색하기 위해 like 키워드 연산자는 필수적인
도구입니다. 특정 패턴을 포함하는 문자열을 찾을때 강력한 힘을 발휘하는 like의 개념을 명확히
이해하고 키워드를 암기하여 실용적인 예제를 통해 활용도를 높여 보겠습니다.
like: 비슷한 것을 찾아내는 기술
like 연산자는 where절과 함께 사용되며 칼럼의 데이터가 특정 문자열 패턴과 일치하는지를 
비교 합니다. 완전 일치를 찾는 등호 연산자와 달리 like는 와일드카드문다(%,_)를 사용하며 유연한
검색을 가능하게 합니다.
핵심 와일드 카드
퍼센트:0개 이상의 모든 문자를 의미합니다. 어떤 문자든 몇개가 모든 상관 없다.
컬럼 like, %a% a를 포함 하기만 하면 앞뒤 어떤 글자가와도 상관 x
컬럼 like %% 문자 상관 없이 전체 데이터 검색
언드스코어: 단 하나의 문자를 의미. 정확히 단 하나의 글자
컬럼 like '%문자열%': 앞뒤 문자 상관없이 문자열을 포함
컬럼 like '문자열%': 해당 문자열로 끝나는 데이터
컬럼 like '%문자열': 문자열로 끝나는 데이터
사원명에 a를 포함되는 모든 사원 정보를 출력
SELECT *
FROM emp
WHERE UPPER(ename) LIKE '%A%';
직책이 s로 시작 man으로 끝나는거 찾기
SELECT *
FROM emp
WHERE UPPER(job) LIKE 'S%MAN';
_(언더스코어)
자리수까지 정확히 맞추어서 확인할때 사용한 와일드카드 문자이다.
사원명중에 세번째 문자열이 a인 사원정보를 출력하라.
SELECT *
FROM emp
WHERE UPPER(ename) LIKE '__A%';
직책명이 뒤에서 두번째 문자가 a인 것을 검색
SELECT *
FROM emp
WHERE UPPER(job) LIKE '%A_';
사원명의 자리수가 5자리이고 마지막 글자인 s인 경우 출력
SELECT *
FROM emp
WHERE UPPER(ename) LIKE '____S';
사원명중에 두번째 글자가 a인 사원을 출력 하세요.*/
SELECT *
FROM emp
WHERE UPPER(ename) LIKE '_A%';
사원명이 총5자리이고 마지막 글자가 s인 사원을 찾아라
SELECT *
FROM emp
WHERE UPPER(ename) LIKE '____S';*/

