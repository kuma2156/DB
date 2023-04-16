-- 박지성이 구매한 도서의 출판사 수 1.5
SELECT COUNT(DISTINCT publisher) AS "박지성이 구매한 도서의 출판사 수"
FROM Book
WHERE bookid IN (SELECT bookid
                 FROM Orders
                 WHERE custid = (SELECT custid 
                                 FROM Customer 
                                 WHERE name = '박지성'));
                                 
select count(distinct publisher)
from customer,orders,book
where customer.custid = orders.custid and orders.bookid = book.bookid and customer.name like '박지성';
/*from에 customer, orders, book 테이블을 적어주고 where 절에 테이블들을 조인시켜준다.*/
--------------------------------------------------------------------------------------------------------------
-- 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 1.6
SELECT Book.bookname, Book.price, (Book.price - Orders.saleprice) AS "정가와 판매가격의 차이"
FROM Book
JOIN Orders ON Book.bookid = Orders.bookid
JOIN Customer ON Orders.custid = Customer.custid
WHERE Customer.name = '박지성';

select book.bookname , book.price, (book.price - orders.saleprice)
from book, orders , customer
where customer.custid = orders.custid and orders.bookid = book.bookid and customer.name like '박지성';
---------------------------------------------------------------------------------------------------------------
-- 박지성이 구매하지 않은 도서의 이름 1.7
SELECT Book.bookname AS "박지성이 구매하지 않은 책 이름"
FROM Book
WHERE bookid NOT IN (SELECT DISTINCT bookid FROM Orders WHERE custid = (SELECT custid FROM Customer WHERE name = '박지성'));

select bookname
from book
where not exists (
                  select bookname
                  from customer, orders
                  where customer.custid = orders.custid and 
                        orders.bookid = book.bookid and 
                        customer.name like '박지성');
                  
---------------------------------------------------------------------------------------------------------------
-- 주문하지 않은 고객의 이름(부속절) 2.8
SELECT name
FROM Customer
WHERE custid NOT IN (SELECT DISTINCT custid FROM Orders);

select name
from customer
where custid not in (select distinct custid
                     from orders);
                     
select distinct custid
from orders;
---------------------------------------------------------------------------------------------------------------
-- 주문 금액의 총액과 주문의 평균 금액 2.9
SELECT SUM(saleprice) AS "주문 금액의 총액", AVG(saleprice) AS "주문의 평균 금액"
FROM Orders;

select sum(saleprice), avg(saleprice)
from orders;
---------------------------------------------------------------------------------------------------------------
-- 고객의 이름과 고객별 구매액 2.10
SELECT customer.name AS "고객의 이름", SUM(orders.saleprice) AS "고객 별 구매액"
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name;

select name , sum(saleprice) as "total"
from customer, orders
where customer.custid = orders.custid
group by name;
---------------------------------------------------------------------------------------------------------------
-- 고객의 이름과 고객이 구매한 도서 목록 2.11
SELECT customer.name, book.bookname
FROM Orders
JOIN Customer ON Orders.custid = Customer.custid
JOIN Book ON Orders.bookid = Book.bookid
GROUP BY customer.name, book.bookname;

select name as "고객 이름", bookname as "구매한 도서이름"
from customer, book , orders
where customer.custid = orders.custid and orders.bookid = book.bookid
group by name, bookname;
---------------------------------------------------------------------------------------------------------------
-- 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문 2.12
SELECT *
FROM book, ORDERS
WHERE book.BOOKID = orders.BOOKID AND book.PRICE-orders.SALEPRICE = (SELECT max(book.PRICE-orders.SALEPRICE) FROM book, ORDERS WHERE book.BOOKID = orders.BOOKID);

select *
from book, orders
where orders.bookid = book.bookid and book.price - orders.saleprice = (select max(book.price - orders.saleprice)
                                                                       from book, orders
                                                                       where orders.bookid = book.bookid);
---------------------------------------------------------------------------------------------------------------
-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름 2.13
SELECT Customer.name
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name
HAVING AVG(Orders.saleprice) > (SELECT AVG(saleprice) FROM Orders);

select name , avg(saleprice)
from customer,orders,book
where customer.custid = orders.custid and orders.bookid = book.bookid
group by name
having avg(saleprice) > (select avg(saleprice) from orders);
----------------------------------------------------------------------------------------------------------------
select Customer.name , book.bookname
from Customer , Orders, Book
where Customer.custid = Orders.custid AND Orders.bookid = Book.bookid and Book.price = 20000;
---------------------------------------------------------------------------------------------------------
-- 외부 조인 (왼쪽) +를 사용하여 간략하게 표시
select Customer.name , saleprice
from Customer, Orders
where Customer.custid = Orders.custid(+);

-- 외부 조인 (오른쪽) +를 사용하여 간략하게 표시 (주문하지 않은 고객의 이름과 가격)
select Customer.name , saleprice
from Customer, Orders
where Customer.custid(+) = Orders.custid;

-- 외부 조인 (왼쪽) left outer join "조인될 대상"  on "동등 조인"
select Customer.name ,saleprice
from Customer LEFT outer join Orders
                        on Customer.custid = Orders.custid;

-- 동등 조인
select name , saleprice
from customer, Orders
where customer.custid = orders.custid;
---------------------------------------------------------------------------------------------------------
-- 가장 비싼 도서의 이름 찾아보기
-- (1) 하위질의 (가장 비싼 책의 가격 정보 출력)
select max(price)
from Book;

-- (2) 하위질의 ((1)에서 찾은 가격으로 책의 이름 찾기)
select bookname
from Book
where price = 35000;

-- (1) + (2) 한 결과 부속질의 (두 지문을 합쳐서 where 절에 이런 식으로 표시할 수 있다.)
select bookname --(2)
from Book
where price = (select max(price) from Book);--(1)
---------------------------------------------------------------------------------------------------------
-- 주문한 고객의 이름 찾기
-- a (먼저 주문자 아이디를 찾는다.)
select custid
from Orders;

-- b (알아낸 주문자의 아이디를 in 으로 여러개를 검색하고 이름을 출력한다.)
select name
from customer  
where custid IN(1,2,3,4);

-- (a) + (b) (부속질의로 합쳐서 해봤다.)
select name -- b
from Customer
where custid in(select custid from Orders); -- a
---------------------------------------------------------------------------------------------------------
-- '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 보이시오.(하위 부속질의)
select name -- 3 2에서 알아낸 주문자의 아이디로 이름을 출력한다.
from Customer
where custid in(select custid 
                from Orders
                where bookid in(select bookid -- 2 알아낸 책 아이디로 주문자의 아이디를 알아낸다.
                                from Book
                                where publisher = '대한미디어')); -- 1 먼저 대한미디어의 책 아이디를 알아낸다.
---------------------------------------------------------------------------------------------------------
-- 상관 부속질의
-- 임의의 별명을 만들어서 실행한다.
-- 테이블 이름을 별명을 지을 수 있다.... 이를 튜플의 변수라고 한다. ex) Book b1, Book b2

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select b1.bookname
from Book b1 -- (1) b1이라는 별명을 지어줬다
where b1.price > ( select avg(b2.price) -- (2) b2의 가격의 평균을 구하라.
                    from Book b2 -- (2) b2라는 별명
                    where b2.publisher = b1.publisher); -- b2와 b1의 출판사가 같은 것을 조건
                    
---------------------------------------------------------------------------------------------------------
-- 집합연산
-- 도서를 주문하지 않은 고객의 이름을 구하시오
select name -- 모든 고객의 이름
from Customer
Minus -- 차집합
select name -- 주문한 고객의 이름
from Customer
where custid in(select custid from Orders);
---------------------------------------------------------------------------------------------------------
--EXISTS
-- 주문이 있는 고객의 이름과 주소를 보이시오.
select name ,address
from Customer cs
where EXISTS (select *
              from Orders od
              where cs.custid = od.custid);
