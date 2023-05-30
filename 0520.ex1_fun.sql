-- 2023-05-30 함수 연습
/*고객별 평균 주문 금액을 백원 단위로 반올림하기               -2 는 자리 수*/
select custid "고객번호", round(sum(saleprice)/ count(*), -2)"평균금액"
from orders
group by custid;

/*날짜의 이전 이후 계산    TO_DATE 날짜형 데이트를 숫자형 데이트로 바꾸어라*/
select to_date('2020-07-01','yyyy-mm-dd') + 5 before, to_date('2020-07-01','yyyy-mm-dd') -5 after
from dual;

/*주문일로 부터 10일 후 매출 확정   데이트형 속성 orderdate 에 10을 더한 계산식이 가능하다*/
select orderid "주문번호",orderdate"주문일",orderdate + 10 "확정"
from orders;

/*dbms 서버에 설정된 현재 날짜와 시간, 요일 확인    sysdate 서버에 등록된 시간을 확인하는 속성 // to_char() 날짜형 데이터를 문자열로 바꾸는 함수*/
select sysdate, to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') "sysdate_1"
from dual;

/*마당서점 고객 중 같은 성을 가진 사람이 몇 명인지 성별 인원 수 구하기  substr() 함수는 문자열의 특정 ㅇ위체에서 시작하여 지정한 길이 만큼 문자열을 반환*/
select substr(name,1,1)"성",count(*)"인원"
from customer
group by substr(name,1,1);

/*null 값을 다른 값으로 대치하는 nvl 함수*/
select name "이름" , nvl(phone,'연락처 없음') "전화번호"
from customer;

/*sql 조회결과를 순번으로 나타내는 rownum*/
select rownum "순번" ,custid, name,phone
from customer
where rownum <= 2;
