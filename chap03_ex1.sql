-- Book 테이블에서 bookid가 1인 도서의 도서명을 조회합니다.
SELECT bookname
FROM Book
WHERE bookid = 1;

-- Book 테이블에서 가격이 20,000원 이상인 도서의 도서명을 조회합니다.
SELECT bookname AS "가격이 20000원 이상인 도서명"
FROM Book
WHERE price >= 20000;

-- Orders 테이블에서 custid가 1인 고객이 구매한 주문 상품 가격의 합계를 조회합니다.
SELECT SUM(saleprice) AS "박지성의 총 구매액"
FROM Orders
WHERE custid = 1;

-- LIKE 문으로 만들기
SELECT SUM(saleprice) AS "박지성의 총 구매액"
FROM Customer, Orders
WHERE Customer.custid = Orders.custid AND Customer.name LIKE '박지성';

-- Orders 테이블에서 custid가 1인 고객이 구매한 주문 건 수를 조회합니다.
SELECT COUNT(*) AS "박지성의 주문 건 수"
FROM Orders
WHERE custid = 1;

-- LIKE 사용해서 만들기
SELECT COUNT(*) AS "박지성의 주문 건 수"
FROM Orders, Customer
WHERE Orders.custid = 1 AND Customer.name LIKE '박지성';

-- Book 테이블에서 출판사 수를 조회합니다.
SELECT COUNT(DISTINCT publisher) AS "출판사 수"
FROM Book;

-- 박지성이 구매한 도서의 출판사의 수
SELECT COUNT(Book.publisher) AS "박지성이 구매한 도서의 출판사 수"
FROM Book, Customer, Orders
WHERE Book.bookid = Orders.bookid AND Customer.custid = Orders.custid AND Customer.name LIKE '박지성';
