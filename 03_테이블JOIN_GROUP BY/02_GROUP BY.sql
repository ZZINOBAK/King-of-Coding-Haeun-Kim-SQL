/* ===================
SELECT * | [ DISTINCT ] {컬럼명, 컬럼명, ...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명, ....}
    [HAVING 조건] ] --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC], ....}] 
===================== */
-- GROUP BY : 데이터를 그룹핑해서 처리할 경우 사용
-- GROUP BY 문을 사용하면 SELECT 항목에 사용할 수 있는 데이터가 제한됨
---- GROUP BY 절에 사용된 컬럼 또는 그룹함수(COUNT, SUM, AVG, MAX, MIN) 사용가능
---- 상수값 사용가능(하나의 문자열, 숫자, 날짜 값)
----------------------
-- HAVING 절은 단독으로 사용할 수 없고, 반드시 GROUP BY 절과 함께 사용(종속절)
-- HAVING 절 : GROUP BY 절에 의해서 만들어진 데이터에서 검색(선택)조건 부여
--====================
-- 출판사별 출판한 책 개수 구하기
SELECT PUBLISHER, 
       COUNT(*), SUM(PRICE), AVG(PRICE), MIN(PRICE), MAX(PRICE)
FROM BOOK
GROUP BY PUBLISHER
;
-- 구매 고객별로 구매금액 합계를 구하시오
SELECT CUSTID, SUM(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
---- 이름표시 : 이름으로 그룹핑
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC --많이 구입한 금액부터
;
----
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY 2 DESC --많이 구입한 금액부터(위치번호 기준)
;
----
SELECT C.NAME, SUM(O.SALEPRICE) AS SUM_PRICE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM_PRICE DESC --많이 구입한 금액부터(그룹함수값 별칭 기준)
;
------------
--주문(판매) 테이블의 고객별 데이터 조회(건수, 합계, 평균, 최소, 최대금액)
SELECT CUSTID,
       COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
--고객별 데이터 중 박지성, 추신수 데이터 조회(건수, 합계, 평균, 최소, 최대금액)
SELECT C.NAME,
       COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME IN ('박지성', '추신수')
 GROUP BY C.NAME
;
-----------------------
--(실습) 고객명 기준으로 고객별 구매 데이터 조회(건수, 합계, 평균, 최소, 최대)
---- 추신수, 장미란 고객 2명만 조회(검색)
SELECT C.NAME AS NAME, 
COUNT(*) AS CNT, 
SUM(O.SALEPRICE) SUM_PRICE, 
TRUNC(AVG(SALEPRICE)) AVG_PRICE, 
MAX(O.SALEPRICE) MAX_PRICE, 
MIN(O.SALEPRICE) MIN_PRICE
  FROM ORDERS O INNER JOIN BOOK B
       ON O.BOOKID = B.BOOKID 
       INNER JOIN CUSTOMER C
       ON O.CUSTID = C.CUSTID
 WHERE C.NAME IN ('추신수','장미란')
 GROUP BY C.NAME
;  
-- 표준SQL 형식
SELECT C.NAME AS NAME, 
       COUNT(*) AS CNT, 
       SUM(O.SALEPRICE) SUM_PRICE, 
       TRUNC(AVG(SALEPRICE)) AVG_PRICE, 
       MAX(O.SALEPRICE) MAX_PRICE, 
       MIN(O.SALEPRICE) MIN_PRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID 
AND C.NAME IN ('추신수','장미란')
GROUP BY C.NAME
;
--쌤-----------------------------------------------------
---- 추신수, 장미란 고객 2명만 조회(검색)
SELECT C.NAME,
       COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME IN ('장미란', '추신수')
 GROUP BY C.NAME
;
-- 표준SQL 형식
SELECT C.NAME,
       COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
--SELECT *    
  FROM ORDERS O INNER JOIN CUSTOMER C
       ON O.CUSTID = C.CUSTID
 WHERE C.NAME IN ('장미란', '추신수')
 GROUP BY C.NAME
;
----------
SELECT C.NAME, COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 HAVING C.NAME IN ('장미란', '추신수') -- 그룹핑된 데이터에서 찾기(검색/걸러내기)
;
--------------------------
-- HAVING 절은 단독으로 사용할 수 없고, 반드시 GROUP BY 절과 함께 사용(종속절)
-- HAVING 절 : GROUP BY 절에 의해서 만들어진 데이터에서 검색(선택)조건 부여
-------------
SELECT * FROM ORDERS;
-- 3건 이상 구입한 고객 조회(이름, 구입수량)
SELECT C.NAME, -- 테이블 CUSTOMER의 컬럼 NAME의 데이터 출력.
COUNT(*) -- 조건에 해당하는 데이터 전체를 카운팅해서 출력
FROM ORDERS O, CUSTOMER C -- 테이블 ORDERS와 CUSTOMER의 데이터를 사용
WHERE O.CUSTID = C.CUSTID -- 조건 = 두 테이블의 CUSTID는 같다.
GROUP BY C.NAME -- 테이블 CUSTOMER의 컬럼 NAME을 그룹핑함.
HAVING COUNT(*) >= 3 -- 윗줄에서 그룹핑한 데이터 중 3보다 크게 카운팅 된 데이터를 출력
;

-- 구매한 책중에 20000원 이상인 책을 구입한 사람의 통계 데이터
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, CUSTOMER C 
WHERE O.CUSTID = C.CUSTID 
AND O.SALEPRICE >= 20000
;
SELECT O.SALEPRICE AS SALEPRICE
FROM ORDERS O, CUSTOMER C 
WHERE O.CUSTID = C.CUSTID 
GROUP BY O.SALEPRICE
HAVING O.SALEPRICE >= 20000
;
--쌤--------------------------------
SELECT C.NAME AS NAME,
MAX(O.SALEPRICE)
FROM ORDERS O, CUSTOMER C 
WHERE O.CUSTID = C.CUSTID 
GROUP BY C.NAME
HAVING MAX(O.SALEPRICE) >= 20000
;
-- 3건 이상 구입한 고객 조회(이름, 구입수량)
SELECT C.NAME, COUNT(*) AS CNT
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) >= 3
;
-------
-- 구매한 책중에 20000원 이상인 책을 구입한 사람의 통계 데이터
SELECT C.NAME, COUNT(*) AS CNT, SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING MAX(O.SALEPRICE) >= 20000 -- 2만원 이상 책을 1권이라도 구입한 사람
;
------
SELECT C.NAME, COUNT(*) AS CNT, SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
  AND O.SALEPRICE >= 20000 -- 2만원 이상 책들만 대상으로
GROUP BY C.NAME
;
SELECT * FROM ORDERS ORDER BY SALEPRICE DESC;

--========================
--(실습) 필요시 조인(JOIN)과 GROUP BY ~ HAVING 구문을 사용해서 처리

--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
SELECT C.NAME, COUNT(*) AS CNT, O.SALEPRICE,
       TRUNC(AVG(O.SALEPRICE)),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME, O.SALEPRICE
ORDER BY C.NAME
;

--2. 고객별로 주문한 도서의 총수량, 총판매액 구하기
SELECT C.NAME, COUNT(*) AS CNT, SUM(O.SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
;

--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT C.NAME, O.SALEPRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME, O.SALEPRICE
;

--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
SELECT C.NAME, SUM(O.SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME
;

--5. 고객별로 주문한 건수, 합계금액, 평균금액을 구하고(3권 보다 적게 구입한 사람 검색)
SELECT C.NAME, COUNT(*) AS CNT, SUM(O.SALEPRICE), TRUNC(AVG(O.SALEPRICE))
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) < 3
;

--(번외) 고객 중 한 권도 구입 안 한 사람은 누구??
SELECT C.NAME
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
--HAVING SUM(O.SALEPRICE) < 1000000
;
SELECT C.NAME
FROM CUSTOMER C LEFT OUTER JOIN ORDERS O
     ON C.CUSTID = O.CUSTID
WHERE O.CUSTID IS NULL
;
---------------------------
--쌤-----------------------------
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
----(별칭사용시주의) 빈칸, 특수문자 사용시 쌍따옴표("")로 묶어서 표기(한글 사용 자제)
SELECT COUNT(*) AS "TOTAL COUNT" --TOTAL_COUNT 사용권장
     , SUM(SALEPRICE) AS "판매액 합계" --한글 사용할 수 있지만 사용하지 말자
     , AVG(SALEPRICE) 평균값AVG --한글 사용할 수 있지만 사용하지 말자
     , MIN(SALEPRICE) 최저가_MIN --언더바(_) 사용가능
     , MAX(SALEPRICE) "최고가(MAX)" --특수문자 사용시 쌍따옴표("")로 묶기
FROM ORDERS
;
--2. 고객별로 주문한 도서의 총수량, 총판매액 구하기
SELECT C.NAME, COUNT(*) AS CNT, SUM(O.SALEPRICE) AS SUM_PRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID --조인조건
GROUP BY C.NAME
;
--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
;
--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
SELECT C.NAME, SUM(O.SALEPRICE) AS SUM_PRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID --조인조건
GROUP BY C.NAME
ORDER BY C.NAME
;
--5. 고객별로 주문한 건수, 합계금액, 평균금액을 구하고(3권 보다 적게 구입한 사람 검색)
SELECT C.NAME, COUNT(*) AS CNT, SUM(O.SALEPRICE) AS SUM_PRICE,
       TRUNC(AVG(O.SALEPRICE)) AS AVG_PRICE
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID --조인조건
GROUP BY C.NAME
HAVING COUNT(*) < 3
--ORDER BY SUM(O.SALEPRICE) DESC
--ORDER BY 3 DESC --컬럼 위치값 사용
ORDER BY SUM_PRICE DESC --컬럼 별칭 사용
;
--(번외) 고객 중 한 권도 구입 안 한 사람은 누구??
----고객테이블에는 있는데, 주문(판매) 테이블에 없는 사람
SELECT CUSTID FROM CUSTOMER;
SELECT DISTINCT CUSTID FROM ORDERS ORDER BY CUSTID;













