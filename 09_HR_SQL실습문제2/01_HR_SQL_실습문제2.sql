/* ***** HR DB 데이터 조회 실습 *****************
■1 HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
  사원정보(Employees) 테이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 
  이름과 성(Name으로 별칭) 및 급여를 급여가 적은 순서로 출력하시오
*/
Select first_name || ' ' || last_name As Name, salary
From Employees
Where Salary Between 7000 and 10000
Order by salary
;
--쌤----------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < 7000 OR SALARY > 10000
ORDER BY SALARY;
-----
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 7000 AND 10000
ORDER BY SALARY;
/*
■2 HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
  수당을 받는 모든 사원의 이름과 성(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 
  이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
*/
Select first_name || ' ' || last_name As Name, salary, Job_id, commission_pct
From Employees
Where commission_pct is not null
Order by salary Desc, commission_pct Desc
;
--쌤----------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, SALARY,
       JOB_ID, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC
;
/*  
■3 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 
  이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 
  60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 
  보고서는 사원번호, 성과 이름(Name으로 별칭), 급여, 인상된 급여(Increase Salary로 별칭)순으로 출력하시오
*/  
Select Employee_id, first_name || ' ' || last_name As Name, Salary, ROUND(Salary * 1.123) As "Increase Salary"
From Employees
Where Department_id = '60'
Order by Employee_id, Name, Salary, "Increase Salary"
;
Select Employee_id, first_name || ' ' || last_name As Name, Salary, ROUND(Salary * 1.123) As "Increase Salary"
From Departments D, Employees E
Where D.Department_id = E.Department_id
--Department_id = '60' And Department_name = 'IT'
And D.Department_id = '60'
Order by salary Desc, commission_pct Desc
;
--쌤----------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, SALARY
     , SALARY * 1.123 AS "Increase Salary"
     , ROUND(SALARY * 1.123) AS "Increase Salary(ROUND)"
     , ROUND(SALARY * 0.123) AS "순수인상금액"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60
;

/*
■4 각 사원의 성(last_name)이 's'로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 
  출력 시 이름(first_name)과 성(last_name)은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 
  머리글(조회컬럼명)은 Employee JOBs.로 표시하시오
  예) FIRST_NAME  LAST_NAME  Employee JOBs.
      Shelley     Higgins    AC_MGR
*/
Select INITCAP(first_name) As FIRST_NAME,  INITCAP(last_name) As LAST_NAME, UPPER(Job_id) As "Employee JOBs"
From Employees
Where last_name Like '%s'
;
--쌤----------------------------------------
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%s'
;
SELECT INITCAP(FIRST_NAME) AS FIRST_NAME, INITCAP(LAST_NAME) AS LAST_NAME
     , UPPER(JOB_ID) AS "Employee JOBs."
FROM EMPLOYEES
WHERE LOWER(LAST_NAME) LIKE '%s' --LAST_NAME 값이 대소문자 섞여있는 경우
;
/*
■5 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 
  보고서에 사원의 이름과 성(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 
  수당여부는 수당이 있으면 "Salary + Commission", 수당이 없으면 "Salary only"라고 표시하고, 
  별칭은 적절히 붙이시오. 또한 출력 시 연봉이 높은 순으로 정렬하시오
*/
Select first_name || ' ' || last_name As Name, Salary, 
    DECODE(commission_pct, null, 'Salary only',  'Salary + Commission')As Commission
From Employees
;
--쌤----------------------------------------
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, SALARY,
       COMMISSION_PCT
     , DECODE(COMMISSION_PCT, NULL, 'Salary only', 'Salary + Commission') AS COMMISSION_YN   
     , SALARY * (1 + NVL(COMMISSION_PCT, 0)) AS SALARY_COMMISSION
     , SALARY * (1 + NVL(COMMISSION_PCT, 0)) * 12 AS SALARY12
FROM EMPLOYEES
--ORDER BY 7 DESC --위치값 사용
ORDER BY SALARY12 DESC --컬럼별칭 사용
;
/*
■6 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최댓값, 급여 최솟값을 집계하고자 한다. 
  계산된 출력값은 여섯 자리와 세 자리 구분기호, $표시와 함께 출력($123,456) 
  단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고, 출력 시 머리글은 별칭(alias) 처리하시오
*/    
Select D.Department_name As alias, 
TO_CHAR(Sum(E.Salary), '$999,999') As Sum,
TO_CHAR(TRUNC(Avg(E.Salary)), '$999,999') As Avg,
TO_CHAR(Max(E.Salary), '$999,999') As Max,
TO_CHAR(Min(E.Salary), '$999,999') As Min
From Employees E, Departments D
Where E.Department_id = D.Department_id
Group by D.Department_name
;
--쌤----------------------------------------
SELECT DEPARTMENT_ID, 
       COUNT(*) AS CNT,
       TO_CHAR(SUM(SALARY), '$999,999') AS SUM_SALARY,
       TO_CHAR(TRUNC(AVG(SALARY)),'$999,999') AS AVG_SALARY,
       TO_CHAR(MAX(SALARY), '$999,999') AS MAX_SALARY,
       TO_CHAR(MIN(SALARY), '$999,999') AS MIN_SALARY
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
;
/*
■7 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 
    업무별 급여 평균을 출력하시오. 
  단 업무에 CLERK이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오
*/
Select D.Department_name As alias, TO_CHAR(TRUNC(Avg(E.Salary)), '$999,999') As Avg
From Employees E, Departments D
Where E.Department_id = D.Department_id
Group by D.Department_name
Having Avg(E.Salary) >= 10000
Order by Avg(E.Salary) Desc
;
--쌤----------------------------------------
SELECT DISTINCT JOB_ID --DISTINCT 중복값 제거하고 1개만 표시
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE '%CLERK%'
;
SELECT JOB_ID, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
WHERE JOB_ID NOT LIKE '%CLERK%'
GROUP BY JOB_ID
HAVING AVG(SALARY) > 10000
ORDER BY AVG_SALARY DESC
;
/*
■8 HR 스키마에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후 
  Oxford에 근무하는 사원의 이름과 성(Name으로 별칭), 업무, 부서이름, 도시이름을 출력하시오. 
  이때 첫 번째 열은 회사이름인 'HR-Company'이라는 상수값이 출력되도록 하시오
*/
Select 'HR-Company' As Company, E.first_name || ' ' || E.last_name As Name, E.Job_id, 
    D.Department_name,
    L.City
From Employees E, Departments D, Locations L
Where E.Department_id = D.Department_id
And D.Location_id = L.Location_id
And L.City = 'Oxford'
;
--쌤----------------------------------------
SELECT 'HR-Company' AS COMPANY_NAME, 
       E.EMPLOYEE_ID, E.FIRST_NAME ||' '|| E.LAST_NAME AS NAME, E.JOB_ID,
       D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L --조인테이블
WHERE e.department_id = d.department_id --조인조건
  AND d.location_id = l.location_id --조인조건
  AND L.CITY = 'Oxford'
;
-- 뷰(VIEW) 사용
SELECT 'HR-Company' AS COMPANY_NAME, 
       EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS NAME, JOB_ID,
       DEPARTMENT_NAME, CITY
FROM emp_details_view
WHERE CITY = 'Oxford'
;
/*
■9 HR 스키마에 있는 Employees, Departments 테이블의 구조를 파악한 후 
  사원수가 다섯 명 이상인 부서의 부서이름과 사원 수를 출력하시오. 
  이때 사원 수가 많은 순으로 정렬하시오
*/
Select D.Department_name, Count(E.Department_id) As Num
From Employees E, departments D
Where E.Department_id = D.Department_id
Group by D. Department_name, E. Department_id
Having Count(E.Department_id) > 5
Order by D.Department_name
;
--쌤----------------------------------------
SELECT E.department_id, d.department_name, COUNT(*) AS CNT
FROM Employees E, Departments D
WHERE e.department_id = d.department_id
GROUP BY E.department_id, d.department_name
HAVING COUNT(*) >= 5
ORDER BY CNT DESC
;
/*
■10 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 
  급여 등급은 Job_Grades 테이블에 표시된다. 해당 테이블의 구조를 살펴본 후 
  사원의 이름과 성(Name으로 별칭), 업무, 부서이름, 입사일, 급여, 급여등급을 출력하시오.
  
CREATE TABLE JOB_GRADES (
    GRADE_LEVEL VARCHAR2(3),
    LOWEST_SAL NUMBER,
    HIGHEST_SAL NUMBER
);
INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);
COMMIT;
********************************/
Select E.first_name || ' ' || E.last_name As Name, E.Job_id, D.Department_Name, E.salary, 
  CASE WHEN E.salary <= 2999 And E.salary >= 1000 THEN 'A' ELSE
        CASE WHEN E.salary <= 5999 And E.salary >= 3000 THEN 'B' ELSE
                 CASE WHEN E.salary <= 9999 And E.salary >= 6000 THEN 'C' ELSE
                     CASE WHEN E.salary <= 14999 And E.salary >= 10000 THEN 'D' ELSE
                          CASE WHEN E.salary <= 24999 And E.salary >= 15000 THEN 'E' ELSE
                                 CASE WHEN E.salary <= 40000 And E.salary >= 25000 THEN 'F'
                                    ELSE '너무비싸다'
                               END
                         END
                    END
                END
        END
 END AS "Job_Grades"
From Employees E, Departments D
Where E.Department_id = D.Department_id
;

CREATE TABLE JOB_GRADES (
    GRADE_LEVEL VARCHAR2(3),
    LOWEST_SAL NUMBER,
    HIGHEST_SAL NUMBER
);
INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);
COMMIT;

Select E.*,
CASE WHEN E.salary <= g.highest_sal And E.salary >= g.lowest_sal  THEN g.grade_level 
  ELSE NULL
  END AS "Job_Grades"
from Employees E, JOB_GRADES G
;
SELECT E.first_name || ' ' || E.last_name As Name, E.Job_id,  E.salary, 
       CASE WHEN E.salary <= G.highest_sal AND E.salary >= G.lowest_sal THEN G.grade_level
            ELSE NULL
       END AS "Job_Grades"
FROM Employees E
JOIN JOB_GRADES G ON E.salary <= G.highest_sal AND E.salary >= G.lowest_sal;
--- 이게 내가 지피티한테 물어본 코드임

Select E.first_name || ' ' || E.last_name As Name, E.Job_id,  E.salary, 
    D.Department_Name,
  CASE WHEN E.salary <= g.highest_sal And E.salary >= g.lowest_sal  THEN g.grade_level 
  ELSE  '너무비싸다'
  END AS "Job_Grades"
From Employees E, Departments D, JOB_GRADES G
Where E.Department_id = D.Department_id
;  -- 이건 망한 코드

SELECT CONCAT(FIRST_NAME,' '||LAST_NAME) AS NAME, E.JOB_ID , D.DEPARTMENT_NAME,
            E.HIRE_DATE, E.SALARY, J.GRADE_LEVEL
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT OUTER JOIN JOB_GRADES J
    ON E.SALARY BETWEEN LOWEST_SAL AND HIGHEST_SAL
; -- 지원이 코드임

--쌤----------------------------------------
SELECT E.EMPLOYEE_ID, E.FIRST_NAME ||' '|| E.LAST_NAME AS NAME, JOB_ID,
       d.department_name,
       E.HIRE_DATE, E.SALARY
     , J.GRADE_LEVEL
     , J.LOWEST_SAL, J.HIGHEST_SAL
FROM EMPLOYEES E, DEPARTMENTS D, JOB_GRADES J
WHERE e.department_id = D.DEPARTMENT_ID(+)
  AND E.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL
;




