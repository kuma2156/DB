/*중첩질의(nested subquery) - where - 절 비교 연산자*/
select orderid, custid, saleprice
from orders md
where saleprice > (select avg (saleprice) from orders so where md.custid = so.custid);

select avg(saleprice)
from orders
where custid = 1;

/*중첩질의(nested subquery) - IN , NOT IN 연산자*/
select sum(saleprice) "total"
from orders
where custid in (select custid from customer where address like '%대한민국%');
-- in() 값이 하나라도 있으면 true 반환
select custid from customer where address like '%대한민국%';


/*중첩질의(nested subquery)  - all, some(any) CS 연산자*/
-- all 은 모두 some(any)은 어떠한(최소한 하나라도 )
select orderid, saleprice
from orders
where saleprice > all(select saleprice from orders where custid = 3);
-- 13000원이 제일 크므로 all(부속질의) 의 결과는 13000원 반환
select saleprice from orders where custid = 3;

/*중첩질의(nested subquery) -exists, not existsSET 연산자*/
-- 데이터의 존재여부를 확인하는 연산자
select sum(saleprice) "total"
from orders od
where exists(select * from customer cs where address like '%대한민국%' and cs.custid = od.custid);