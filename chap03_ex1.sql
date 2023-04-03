-- Book ���̺��� bookid�� 1�� ������ �������� ��ȸ�մϴ�.
SELECT bookname
FROM Book
WHERE bookid = 1;

-- Book ���̺��� ������ 20,000�� �̻��� ������ �������� ��ȸ�մϴ�.
SELECT bookname AS "������ 20000�� �̻��� ������"
FROM Book
WHERE price >= 20000;

-- Orders ���̺��� custid�� 1�� ���� ������ �ֹ� ��ǰ ������ �հ踦 ��ȸ�մϴ�.
SELECT SUM(saleprice) AS "�������� �� ���ž�"
FROM Orders
WHERE custid = 1;

-- LIKE ������ �����
SELECT SUM(saleprice) AS "�������� �� ���ž�"
FROM Customer, Orders
WHERE Customer.custid = Orders.custid AND Customer.name LIKE '������';

-- Orders ���̺��� custid�� 1�� ���� ������ �ֹ� �� ���� ��ȸ�մϴ�.
SELECT COUNT(*) AS "�������� �ֹ� �� ��"
FROM Orders
WHERE custid = 1;

-- LIKE ����ؼ� �����
SELECT COUNT(*) AS "�������� �ֹ� �� ��"
FROM Orders, Customer
WHERE Orders.custid = 1 AND Customer.name LIKE '������';

-- Book ���̺��� ���ǻ� ���� ��ȸ�մϴ�.
SELECT COUNT(DISTINCT publisher) AS "���ǻ� ��"
FROM Book;

-- �������� ������ ������ ���ǻ��� ��
SELECT COUNT(Book.publisher) AS "�������� ������ ������ ���ǻ� ��"
FROM Book, Customer, Orders
WHERE Book.bookid = Orders.bookid AND Customer.custid = Orders.custid AND Customer.name LIKE '������';
