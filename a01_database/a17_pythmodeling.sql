
CREATE TABLE 
(
  empno    number(4,0)  NOT NULL COMMENT '사원번호',
  ename    VARCHAR2(50) NOT NULL COMMENT '사원명',
  job      varvhar2(50) NOT NULL COMMENT '직책명',
  mgr      number(4,0)  NULL     COMMENT '관리번호',
  hiredate date         NULL     COMMENT '입사일',
  sal      number(5,2)  NULL     COMMENT '급여',
  comm     number(6,2)  NULL     COMMENT '보너스',
  deptno   number(2,0)  NULL     COMMENT '부서번호',
  deptno   number(2,0)  NOT NULL COMMENT '부서번호',
  deptno   number(2,0)  NOT NULL COMMENT ' 부서번호',
  PRIMARY KEY (empno)
);

CREATE TABLE 
(
  deptno number(2,0)  NOT NULL COMMENT ' 부서번호',
  dname  varchar2(50) NULL     COMMENT '부서명',
  loc    varchar2(50) NULL     COMMENT '부서위치',
  PRIMARY KEY (deptno)
);

CREATE TABLE 고객
(
  고객번호  NOT NULL,
  고객이름  NULL    ,
  주소    NULL    ,
  전화번호  NULL    ,
  고객번호  NOT NULL,
  도서번호  NOT NULL,
  고객번호  NOT NULL,
  PRIMARY KEY (고객번호)
) COMMENT '초기 주문 개체';

CREATE TABLE 도서
(
  도서번호  NOT NULL,
  도서이름  NULL    ,
  출판사   NULL    ,
  도서단가  NULL    ,
  PRIMARY KEY (도서번호)
) COMMENT '초기 도서 개체';

CREATE TABLE 주문
(
  고객번호  NOT NULL,
  고객이름  NOT NULL,
  주소    NULL    ,
  전화번호  NOT NULL,
  PRIMARY KEY (고객번호)
) COMMENT '초기 고객 개체';

ALTER TABLE 
  ADD CONSTRAINT FK__TO_
    FOREIGN KEY (deptno)
    REFERENCES  (deptno);

ALTER TABLE 고객
  ADD CONSTRAINT FK_도서_TO_고객
    FOREIGN KEY (도서번호)
    REFERENCES 도서 (도서번호);

ALTER TABLE 고객
  ADD CONSTRAINT FK_고객_TO_고객
    FOREIGN KEY (고객번호)
    REFERENCES 고객 (고객번호);

ALTER TABLE 주문
  ADD CONSTRAINT FK_고객_TO_주문
    FOREIGN KEY (고객번호)
    REFERENCES 고객 (고객번호);

