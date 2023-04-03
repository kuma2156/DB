-- ���缭���� ������ �� ��
SELECT COUNT(*) AS "���缭���� ������ �� ��"
FROM Book;

-- ���缭���� ������ ����ϴ� ���ǻ��� �� ��
SELECT COUNT(distinct publisher) AS "���缭���� ������ ����ϴ� ���ǻ��� �� ��"
FROM Book;

-- Customer ���̺��� ����� �ּҸ� ��ȸ�մϴ�.
SELECT name, address 
FROM Customer ;

-- Orders ���̺��� 2020�� 7�� 4�Ϻ��� 7�� 7�� ���̿� �߻��� �ֹ���ȣ�� ��ȸ�մϴ�.
SELECT orderid AS "2020�� 7�� 4�� ~ 7�� 7�� ���̿� �߻��� �ֹ���ȣ"
FROM Orders
WHERE orderdate BETWEEN '2020-07-04' AND '2020-07-07';

-- Orders ���̺��� 2020�� 7�� 4�Ϻ��� 7�� 7�� ���̿� �߻����� ���� �ֹ���ȣ�� ��ȸ�մϴ�.
SELECT orderid AS " 2020�� 7�� 4�Ϻ��� 7�� 7�� ���̿� �߻����� ���� �ֹ���ȣ"
FROM Orders
WHERE orderdate NOT BETWEEN  '2020-07-04' AND '2020-07-07';

-- ���� �达�� ���� �̸��� �ּ�
SELECT name , address
FROM Customer
WHERE name LIKE '��%';

-- Customer ���̺��� �̸��� '��'���� �����ϰ� �ڿ� �� ���ڰ� �ְ�, �ڿ� '��'�� ���� ���� �̸��� �ּҸ� ��ȸ�մϴ�.
SELECT name, address
FROM Customer
WHERE name LIKE '��%��';