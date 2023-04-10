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