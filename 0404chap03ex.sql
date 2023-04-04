SELECT COUNT(DISTINCT publisher) AS "박지성이 구매한 도서의 출판사 수"
FROM Book
WHERE bookid IN (SELECT bookid
FROM Orders
WHERE custid = (SELECT custid FROM Customer WHERE name = '박지성'));

-- 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT Book.bookname, Book.price, (Book.price - Orders.saleprice) AS "정가와 판매가격의 차이"
FROM Book
JOIN Orders ON Book.bookid = Orders.bookid
JOIN Customer ON Orders.custid = Customer.custid
WHERE Customer.name = '박지성';

-- 박지성이 구매하지 않은 도서의 이름
SELECT Book.bookname AS "박지성이 구매하지 않은 책 이름"
FROM Book
WHERE bookid NOT IN (SELECT DISTINCT bookid FROM Orders WHERE custid = (SELECT custid FROM Customer WHERE name = '박지성'));

-- 주문하지 않은 고객의 이름(부속절)
SELECT name
FROM Customer
WHERE custid NOT IN (SELECT DISTINCT custid FROM Orders);

-- 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) AS "주문 금액의 총액", AVG(saleprice) AS "주문의 평균 금액"
FROM Orders;

-- 고객의 이름과 고객별 구매액
SELECT customer.name AS "고객의 이름", SUM(orders.saleprice) AS "고객 별 구매액"
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name;

-- 고객의 이름과 고객이 구매한 도서 목록
SELECT customer.name, book.bookname
FROM Orders
JOIN Customer ON Orders.custid = Customer.custid
JOIN Book ON Orders.bookid = Book.bookid
GROUP BY customer.name, book.bookname;

-- 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT *
FROM book, ORDERS
WHERE book.BOOKID = orders.BOOKID AND book.PRICE-orders.SALEPRICE = (SELECT max(book.PRICE-orders.SALEPRICE) FROM book, ORDERS WHERE book.BOOKID = orders.BOOKID);

-- 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT Customer.name
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name
HAVING AVG(Orders.saleprice) > (SELECT AVG(saleprice) FROM Orders);