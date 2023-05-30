/*��ø����(nested subquery) - where - �� �� ������*/
select orderid, custid, saleprice
from orders md
where saleprice > (select avg (saleprice) from orders so where md.custid = so.custid);

select avg(saleprice)
from orders
where custid = 1;

/*��ø����(nested subquery) - IN , NOT IN ������*/
select sum(saleprice) "total"
from orders
where custid in (select custid from customer where address like '%���ѹα�%');
-- in() ���� �ϳ��� ������ true ��ȯ
select custid from customer where address like '%���ѹα�%';


/*��ø����(nested subquery)  - all, some(any) CS ������*/
-- all �� ��� some(any)�� ���(�ּ��� �ϳ��� )
select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid = 3);
-- 13000���� ���� ũ�Ƿ� all(�μ�����) �� ����� 13000�� ��ȯ
select saleprice from orders where custid = 3;

/*��ø����(nested subquery) -exists, not existsSET ������*/
-- �������� ���翩�θ� Ȯ���ϴ� ������
select sum(saleprice) "total"
from orders od
where exists(select * from customer cs where address like '%���ѹα�%' and cs.custid = od.custid);