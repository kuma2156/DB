--------------------------------------- 테이블 -----------------------------------------------------------
-- newbook 테이블 생성
CREATE TABLE newbook (
bookid NUMBER PRIMARY KEY, -- 기본키
bookname VARCHAR2(20) not null ,-- 빈칸 X
publisher VARCHAR2(20) unique ,-- 중복 X
price NUMBER default 10000 check(price > 1000)-- 기본 10000  , Check (제약사항 1000원 이상)
);

-- newCustomer 테이블 생성
CREATE TABLE newCustomer(
custid  number PRIMARY KEY,
name varchar2(20),
address varchar(20),
phone varchar(20)
);

-- newOrders 테이블 생성
CREATE TABLE newOrders(
orderid number  PRIMARY KEY, -- 기본키
custid number   not null, -- 제약조건
bookid number   not null, -- 제약조건
saleprice number,
orderdate date ,
FOREIGN KEY(custid) REFERENCES newCustomer(custid) ON DELETE CASCADE -- 외래키 , 연쇄삭제
);

------------------------------------- 속성 ----------------------------------------------------------------

-- 속성 추가
ALTER TABLE newbook add isbn varchar2(13); 

-- 제약사항 변경
alter table newbook modify isbn number;

-- 테이블 삭제
drop table newbook;

------------------------------------- 데이터 조작어 ----------------------------------------------------------------

select * from book;

-- 튜플 추가       ( 속성과 넣고 싶은 데이터 )
Insert into book(bookid, bookname, publisher, price) 
values (11,'스포츠의학','한솔의학서적',90000);
/* not null 재약조건을 넣지 않은 속성은 값을 안넣고 생성할수있다.*/
insert into book(bookid, bookname, publisher )
values (14,'스포츠의학','한솔의학서적');

select * from imported_book;

-- 대량 삽입
insert into book(bookid, bookname, publisher, price)
select bookid, bookname, publisher, price
from imported_book;


-- 업데이트
UPDATE customer
SET address = '대한민국 부산'
where custid = 5;
/*이런 식으로 하위질의로도 가능하다.*/
update customer
set address = (select address from customer where name = '김연아')
where name = '박세리';

-- 튜플 삭제
DELETE 
from customer 
where name = '박세리';

-- 롤백 (Ctrl + Z)
ROLLBACK;



