# 🗃️ DB 학습 기록  

Oracle 중심으로 데이터베이스 개념, SQL, 정규화, 트랜잭션, 고급 함수 등 실습을 기반으로 배운 내용을 정리한 학습 로그입니다.

---

## 💻 학습자  

<div align="center">
  <img src="https://github.com/user-attachments/assets/61049fd5-5e06-4b17-bb51-d925ea3e68dc" width="250"><br>
  <b>김명규</b><br>
  <a href="https://github.com/kuma2156">https://github.com/kuma2156</a>
</div>

---

## 🗓️ 학습 일지 요약

| 날짜         | 주요 내용 요약                                                                 |
|--------------|----------------------------------------------------------------------------------|
| 2023-04-03   | 교재 195p 연습문제 1, 2번 풀이 / 조건, 함수, 연산자 실습                         |
| 2023-04-04   | 195p 연습문제 마저 풀이 / 부속질의, HAVING 절, 집합 연산 실습                    |
| 2023-04-10   | 195p 풀이 검토 및 나의 풀이 비교 분석                                             |
| 2023-04-11   | 연습문제 풀이 / 교재 179~192p 학습                                                |
| 2023-04-18   | ER 다이어그램, IR 다이어그램 작성 / ex13 문제 기반 테이블 생성                   |
| 2023-05-02   | 이상 현상, 정규화 이론 / `c7_code` 중심 학습                                     |
| 2023-05-16   | 트랜잭션 & 동시성 제어 / 갱신 손실 문제, Lock 개념 정리                          |
| 2023-05-30   | SQL 고급 함수, `NULL` 연산, `rownum()` 실행 순서 / 중첩질의 정리                |
| 2023-06-05   | 뷰(View) 생성, 수정, 삭제 / 인덱스(B-Tree 구조) 이해 및 실습                    |

---

## 🧠 기억할 개념들 요약

### ✅ SQL 실습 핵심

- 다양한 조건절: `WHERE`, `BETWEEN`, `LIKE`, `IN`
- 집계 함수: `COUNT()`, `AVG()`, `SUM()`, `MAX()`, `MIN()`
- 그룹화 & 조건: `GROUP BY`, `HAVING`
- 부속질의(Subquery): `IN`, `EXISTS`, `ANY`, `ALL` 사용
- 집합 연산자: `UNION`, `INTERSECT`, `MINUS`
- 실행 순서: `SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY`

### ✅ 설계 및 모델링

- ER 다이어그램: 개체(Entity), 관계(Relationship), 속성(Attribute) 설계
- 정규화:
  - 1NF: 원자성
  - 2NF: 부분 함수 종속 제거
  - 3NF: 이행 함수 종속 제거
- 이상 현상: 삽입/삭제/갱신 이상 이해

### ✅ 고급 SQL 기능

- 고급 함수: `NVL()`, `DECODE()`, `CASE`, `ROWNUM()`, `SYSDATE`
- `NULL` 처리 주의
- 뷰(View): 가상 테이블 생성 및 활용
- 인덱스: B-Tree 구조 이해 → 검색 최적화

### ✅ 트랜잭션 & 동시성

- 트랜잭션 원칙 (ACID)
- Lock 종류: Shared Lock / Exclusive Lock
- 동시성 제어: 갱신 손실, 비반복 읽기, 팬텀 리드 등 문제 해결

---


