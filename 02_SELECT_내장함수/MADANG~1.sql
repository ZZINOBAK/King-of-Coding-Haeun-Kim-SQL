SELECT ABS(-15) FROM DUAL;
-- 15

SELECT CEIL(15.7) FROM DUAL;
-- 16

SELECT COS(3.14159) FROM DUAL;
-- 0.99999999999647923060461239250850048324

SELECT FLOOR(15.7) FROM DUAL;
-- 15

SELECT LOG(10,100) FROM DUAL;
-- 2

SELECT MOD(11,4) FROM DUAL;
-- 3

SELECT POWER(3,2) FROM DUAL;
-- 9

SELECT ROUND(15.7) FROM DUAL;
-- 16

SELECT SIGN(-15) FROM DUAL;
-- -1

SELECT TRUNC(15.7) FROM DUAL;
-- 15

SELECT CHR(67) FROM DUAL;
-- C

SELECT CONCAT('HAPPY', 'Birthday') FROM DUAL;
-- HAPPYBirthday

SELECT TO_CHAR(123) FROM DUAL;
-- 123

SELECT TO_DATE('12 05 2014', 'DD MM YYYY') FROM DUAL;
-- 2014/05/12

SELECT LTRIM('Page 1', 'ae') FROM DUAL;
-- Page 1

SELECT REPLACE('JACK', 'J', 'BL') FROM DUAL;
-- BLACK

SELECT RPAD('Page 1', 15, '*.') FROM DUAL;
-- Page 1*.*.*.*.*

SELECT RTRIM('Page 1', 'ae') FROM DUAL;
-- Page 1

SELECT SUBSTR('ABCDEFG', 3, 4) FROM DUAL;
-- CDEF

SELECT TRIM(LEADING 0 FROM '00AA00') FROM DUAL;
-- AA00

SELECT UPPER('Birthday') FROM DUAL;
-- BIRTHDAY

SELECT ASCII('A') FROM DUAL;
-- 65

SELECT INSTR('CORPORATE FLOOR', 'OR', 3, 2) FROM DUAL;
-- 14

SELECT LENGTH('Birthday') FROM DUAL;
-- 8

SELECT ADD_MONTHS('14/05/21', 1) FROM DUAL;
-- 0014/06/21

SELECT LAST_DAY(SYSDATE) FROM DUAL;
-- 2023/08/31

SELECT NEXT_DAY(SYSDATE, '화') FROM DUAL;
-- 2023/08/15

SELECT ROUND(SYSDATE) FROM DUAL;
-- 2023/08/10

SELECT SYSDATE FROM DUAL;
-- 2023/08/09

SELECT TO_CHAR(SYSDATE) FROM DUAL;
-- 2023/08/09

SELECT TO_CHAR(123) FROM DUAL;
-- 123

SELECT TO_DATE('12 05 2014', 'DD MM YYYY') FROM DUAL;
-- 2014/05/12

SELECT TO_NUMBER('12.3') FROM DUAL;
-- 12.3

SELECT DECODE(1,1, 'aa', 'bb') FROM DUAL;
-- aa

SELECT NULLIF(123, 345) FROM DUAL;
-- 123

SELECT NVL(NULL, 123) FROM DUAL;
-- 123