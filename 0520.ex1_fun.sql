-- 2023-05-30 �Լ� ����
/*���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��ϱ�               -2 �� �ڸ� ��*/
select custid "����ȣ", round(sum(saleprice)/ count(*), -2)"��ձݾ�"
from orders
group by custid;

/*��¥�� ���� ���� ���    TO_DATE ��¥�� ����Ʈ�� ������ ����Ʈ�� �ٲپ��*/
select to_date('2020-07-01','yyyy-mm-dd') + 5 before, to_date('2020-07-01','yyyy-mm-dd') -5 after
from dual;

/*�ֹ��Ϸ� ���� 10�� �� ���� Ȯ��   ����Ʈ�� �Ӽ� orderdate �� 10�� ���� ������ �����ϴ�*/
select orderid "�ֹ���ȣ",orderdate"�ֹ���",orderdate + 10 "Ȯ��"
from orders;

/*dbms ������ ������ ���� ��¥�� �ð�, ���� Ȯ��    sysdate ������ ��ϵ� �ð��� Ȯ���ϴ� �Ӽ� // to_char() ��¥�� �����͸� ���ڿ��� �ٲٴ� �Լ�*/
select sysdate, to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') "sysdate_1"
from dual;

/*���缭�� �� �� ���� ���� ���� ����� �� ������ ���� �ο� �� ���ϱ�  substr() �Լ��� ���ڿ��� Ư�� ����ü���� �����Ͽ� ������ ���� ��ŭ ���ڿ��� ��ȯ*/
select substr(name,1,1)"��",count(*)"�ο�"
from customer
group by substr(name,1,1);

/*null ���� �ٸ� ������ ��ġ�ϴ� nvl �Լ�*/
select name "�̸�" , nvl(phone,'����ó ����') "��ȭ��ȣ"
from customer;

/*sql ��ȸ����� �������� ��Ÿ���� rownum*/
select rownum "����" ,custid, name,phone
from customer
where rownum <= 2;
