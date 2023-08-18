--** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
--1) 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT *
FROM EMPLOYEES
WHERE employee_id = 100
;
--쌤-------------------------------------
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

--2) 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT *
FROM EMPLOYEES
WHERE salary >= 15000
;
--쌤-------------------------------------
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;

--3) 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
SELECT employee_id, LAST_NAME, hire_date, salary
FROM EMPLOYEES
WHERE salary >= 15000
;
--쌤-------------------------------------
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES 
WHERE SALARY >= 15000
;

--4) 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
SELECT employee_id, LAST_NAME, hire_date, salary
FROM EMPLOYEES
WHERE salary <= 10000
ORDER BY salary DESC
;
--쌤-------------------------------------
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES 
WHERE SALARY <= 10000
ORDER BY SALARY DESC
;

--5) 이름(first_name)이 john인 사원의 모든 정보 조회
SELECT *
FROM EMPLOYEES
WHERE LOWER(first_name) LIKE 'john'
;

SELECT *
FROM EMPLOYEES
WHERE first_name = 'John'
;
--쌤-------------------------------------
SELECT * 
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john') --데이터가 표준화 된 경우 입력값을 동일한 형태로
;
SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME), INITCAP(FIRST_NAME)
FROM EMPLOYEES
;

--6) 이름(first_name)이 john인 사원은 몇 명인가?
SELECT COUNT(*)
FROM EMPLOYEES
WHERE LOWER(first_name) LIKE 'john'
;
--쌤-------------------------------------
SELECT COUNT(*) 
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john') --데이터가 표준화 된 경우 입력값을 동일한 형태로
;

--7) 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
SELECT employee_id, CONCAT(CONCAT(first_name,  ' '),  last_name) AS NAME, salary
FROM EMPLOYEES
WHERE TO_CHAR(hire_date) LIKE '%2008%'
;
--쌤-------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('2008/01/01', 'YYYY/MM/DD') 
                    AND TO_DATE('2008-12-31', 'YYYY-MM-DD')
ORDER BY HIRE_DATE
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008' 
ORDER BY HIRE_DATE
;

--8) 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT employee_id, first_name || ' ' || last_name AS NAME, salary
FROM EMPLOYEES
WHERE salary BETWEEN 20000 AND 30000 
;
--쌤-------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY >= 20000 AND SALARY <= 30000
ORDER BY SALARY
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000
ORDER BY SALARY
;

--9) 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL
;
--쌤-------------------------------------
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL; --NULL 인 사람
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NOT NULL; -- MANAGER가 있는 사람

--10) 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(salary)
FROM EMPLOYEES
WHERE job_id = 'IT_PROG'
;
--쌤-------------------------------------
SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
ORDER BY SALARY DESC
;
SELECT 'IT_PROG' AS JOB_ID, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
;

---------------------------------
--11) 직종별 최대 월급여 검색
SELECT J.job_id, MAX(E.salary) 
FROM EMPLOYEES E, JOBS J 
WHERE E.job_id =  J.job_id 
GROUP BY J.job_id
;
--쌤-------------------------------------
SELECT JOB_ID, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
;
SELECT JOB_ID, COUNT(*), SUM(SALARY), AVG(SALARY), MIN(SALARY), MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
;

--12) 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
SELECT J.job_id, MAX(E.salary) 
FROM EMPLOYEES E, JOBS J 
WHERE E.job_id =  J.job_id 
AND E.salary >= 10000
GROUP BY J.job_id
;
--쌤-------------------------------------
SELECT JOB_ID, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING MAX(SALARY) >= 10000
ORDER BY MAX(SALARY)
;
-------------
SELECT JOB_ID, MAX(SALARY) AS MAX_SALARY
FROM EMPLOYEES
WHERE MAX(SALARY) >= 10000
GROUP BY JOB_ID
ORDER BY MAX(SALARY)
; -- 이렇게 해빙절 말고 웨어절에 넣으면 오류임. 왜때문이죠?

--13) 직종별 평균급여 이상인 직원 조회
SELECT J.job_id,(SUM(E.Salary)/COUNT(*)) AS AVG 
FROM EMPLOYEES E, JOBS J 
WHERE E.job_id =  J.job_id 
GROUP BY J.job_id
;
SELECT J.job_id, AVG(E.Salary) AS AVG 
FROM EMPLOYEES E, JOBS J 
WHERE E.job_id =  J.job_id 
GROUP BY J.job_id
;
SELECT M.*  -- 이렇게 하면 임폴로이만 전체 정보 나옴. 그냥 별만하면 J랑 M 모든 정보 다 나와버림
FROM(SELECT J.job_id,(SUM(E.Salary)/COUNT(*)) AS AVG FROM EMPLOYEES E, JOBS J WHERE E.job_id =  J.job_id GROUP BY J.job_id) A,
EMPLOYEES M
WHERE A.job_id = M.job_id
AND M.salary >= AVG
;
SELECT M.*  -- 이렇게 하면 임폴로이만 전체 정보 나옴. 그냥 별만하면 J랑 M 모든 정보 다 나와버림
FROM EMPLOYEES M,
    (SELECT J.job_id, AVG(E.Salary) AS AVG 
    FROM EMPLOYEES E, JOBS J
    WHERE E.job_id =  J.job_id 
    GROUP BY J.job_id) A
WHERE A.job_id = M.job_id
AND M.salary >= AVG
;
--쌤-------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
ORDER BY JOB_ID
;
-- 직종별 평균 급여
SELECT JOB_ID, AVG(SALARY) AVG_SALARY
FROM EMPLOYEES
GROUP BY JOB_ID
;
---- 조인(직원테이블 + 직종별 평균급여)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, E.SALARY
--     , A.JOB_ID AS AVG_JOB_ID
     , A.AVG_SALARY
FROM EMPLOYEES E,
     (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
      FROM EMPLOYEES
      GROUP BY JOB_ID) A --서브쿼리 : 가상테이블(인라인 뷰)
WHERE E.JOB_ID = A.JOB_ID --조인조건
  AND E.SALARY >= A.AVG_SALARY --검색(선택) 조건
; 
-----
-- 상관서브쿼리 방식으로 찾기
SELECT *
FROM EMPLOYEES E
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES 
                 WHERE JOB_ID = E.JOB_ID)
;
-- 아 이걸 웨어절에 넣어버렸군.




