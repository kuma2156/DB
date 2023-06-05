/*2023.06.05
뷰 생성, 수정 , 삭제*/
select *
from book;

/*책 제목에 축구가 들어가는 자료만 가상 테이블로 생성*/
-- 뷰 생성 
create view vw_book
as select * from book where bookname like '%축구%';

select *
from vw_book;

/*주소가 대한민국인 고객 자료만 가상 테이블로  생성*/
-- 뷰 생성 
select *
from customer;

create view vw_customer
as select * from customer where address like '%대한민국%';

select *
from vw_customer;

/*주소가 대한민국인 고객의 정보를 영국으로 수정*/
-- 뷰 수정

create or replace view vw_customer(custid,name,address)
as select custid, name, address
   from customer
   where address like '%영국&';
   
select * from vw_customer;