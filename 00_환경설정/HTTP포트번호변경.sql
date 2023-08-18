-- SQL에서 한 줄 주석 부호(--)
-- HTTP 포트 변경 : 8080 -> 8090
SELECT DBMS_XDB.getHttpPort() FROM dual;
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
-- 데이터가 아닌 건 대소문자 구분 안함.

-- HTTP 포트 8090 으로 변경
exec dbms_xdb.setHttpPort(8090);

SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;
-- 실행 시키면 변경 된거 확인 가능.
