-- ============================================================
--  system_wallet_basic.sql
--  UTL_HTTP.SET_WALLET('system:') scenarios that need NO local server and NO clock change.
--  Run:  unset TWO_TASK; export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
--        sqlplus -S -L "/ as sysdba" @system_wallet_basic.sql
--  (SYS is exempt from network ACL. Needs outbound internet for public hosts.)
-- ============================================================
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 220
SET FEEDBACK OFF

PROMPT ===== S0. environment =====
SELECT instance_name||' / '||status info FROM v$instance;
SELECT substr(banner_full,1,70) ver FROM v$version WHERE rownum=1;
SELECT 'wallet_root='||nvl(value,'(not set)') p FROM v$parameter WHERE name='wallet_root';

PROMPT ===== S1. no wallet (expect ORA-29024) =====
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet(NULL); utl_http.set_transfer_timeout(12);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('S1 no-wallet -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S1 no-wallet -> ERR '||sqlcode||': '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== S2. SET_WALLET('system') missing colon (expect ORA-29248) =====
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system'); utl_http.set_transfer_timeout(12);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('S2 system(no colon) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S2 system(no colon) -> ERR '||sqlcode||': '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== S3. SET_WALLET('system:') -> public HTTPS hosts =====
BEGIN
  utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(12);
  FOR r IN (SELECT column_value host FROM table(sys.dbms_debug_vc2coll(
            'https://www.example.com/','https://www.oracle.com/','https://api.github.com/',
            'https://www.cloudflare.com/','https://www.microsoft.com/',
            'https://www.baidu.com/','https://www.bing.com/','https://www.gov.cn/'))) LOOP
    BEGIN
      dbms_output.put_line(rpad(r.host,34)||' OK  len='||rpad(length(utl_http.request(r.host)),6));
    EXCEPTION WHEN OTHERS THEN
      dbms_output.put_line(rpad(r.host,34)||' ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
    END;
  END LOOP;
END;
/

PROMPT ===== S4. system: + bogus password (expect OK -- password ignored) =====
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:','ThisIsABogusPassword'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('S4 system:+boguspw -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S4 system:+boguspw -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== S6. system: + hostname mismatch (public site via IP, expect ORA-24263) =====
-- baidu v4 IP at test time (re-resolve if stale): getent ahostsv4 www.baidu.com
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://36.152.44.132/');   -- cert CN=*.baidu.com != IP
  dbms_output.put_line('S6 system: baidu via IP -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S6 system: baidu via IP -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
