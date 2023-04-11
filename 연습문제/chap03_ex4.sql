------------------------------------- 연습문제 ----------------------------------------------------------------
-- 04
SELECT * FROM book;

/*1번 새로운 도서(스포츠세계, 대한미디어, 10000원)이 마당서점에 입고되었다. 삽입이 안 될 경우 필요한 데이터가 더 있는지 찾아보시오*/
insert into book values(20,'스포츠 세계', '대한미디어',10000);

/*2번 삼성당에서 출판사 도서를 삭제하시오*/
delete from book where publisher = '삼성당';

/*3번 이상미디어에서 출판한 도서를 삭제하시오. 삭제가 안된다면 원인을 생각해보시오*/
delete from book where publisher = '이상미디어';
/*다른 테이블이랑 연동되어 있어 삭제연쇄를 안시켜두어서 안된다.
orders 테이블에 주문시켜둔 책이 이상미디어여서 외래키 참조에 위배된다.*/

/*4번 출판사 대한미디어를 대한출판사로 바꾸어라*/
update book
set publisher = '대한출판사'
where publisher = '대한미디어';

/*5번 출판사에 대한 정보를 저장하는 테이블 bookcompany를 생성하고자 한다. name은 기본키 varchar2(20), address varchar2(20) begin date 형식으로 타입을 선언하라*/
create table Bookcompany(
name varchar2(20) PRIMARY KEY,
address varchar2(20),
begin date
);

/*6번 bookcompany 테이블에 인터넷 주소를 저장하는 webaddress 속성을 varchar2(30)으로 추가하라.*/
alter table Bookcompany add webaddress varchar2(30);

/*7번  bookcompany 테이블에 임의의 투플 name = 한빛아카데미 , address = 서울시 마포구 , begin = 1993-01-01, webaddress = http://hanbit.co.kr을 삽입하라.*/
insert into Bookcompany values('한빛아카데미','서울시 마포구','1998-01-01','http://hanbit.co.kr');

select * from Bookcompany;