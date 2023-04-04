SELECT COUNT(DISTINCT publisher) AS "�������� ������ ������ ���ǻ� ��"
FROM Book
WHERE bookid IN (SELECT bookid
FROM Orders
WHERE custid = (SELECT custid FROM Customer WHERE name = '������'));

-- �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
SELECT Book.bookname, Book.price, (Book.price - Orders.saleprice) AS "������ �ǸŰ����� ����"
FROM Book
JOIN Orders ON Book.bookid = Orders.bookid
JOIN Customer ON Orders.custid = Customer.custid
WHERE Customer.name = '������';

-- �������� �������� ���� ������ �̸�
SELECT Book.bookname AS "�������� �������� ���� å �̸�"
FROM Book
WHERE bookid NOT IN (SELECT DISTINCT bookid FROM Orders WHERE custid = (SELECT custid FROM Customer WHERE name = '������'));

-- �ֹ����� ���� ���� �̸�(�μ���)
SELECT name
FROM Customer
WHERE custid NOT IN (SELECT DISTINCT custid FROM Orders);

-- �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
SELECT SUM(saleprice) AS "�ֹ� �ݾ��� �Ѿ�", AVG(saleprice) AS "�ֹ��� ��� �ݾ�"
FROM Orders;

-- ���� �̸��� ���� ���ž�
SELECT customer.name AS "���� �̸�", SUM(orders.saleprice) AS "�� �� ���ž�"
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name;

-- ���� �̸��� ���� ������ ���� ���
SELECT customer.name, book.bookname
FROM Orders
JOIN Customer ON Orders.custid = Customer.custid
JOIN Book ON Orders.bookid = Book.bookid
GROUP BY customer.name, book.bookname;

-- ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
SELECT *
FROM book, ORDERS
WHERE book.BOOKID = orders.BOOKID AND book.PRICE-orders.SALEPRICE = (SELECT max(book.PRICE-orders.SALEPRICE) FROM book, ORDERS WHERE book.BOOKID = orders.BOOKID);

-- ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
SELECT Customer.name
FROM Customer
JOIN Orders ON Customer.custid = Orders.custid
GROUP BY Customer.name
HAVING AVG(Orders.saleprice) > (SELECT AVG(saleprice) FROM Orders);