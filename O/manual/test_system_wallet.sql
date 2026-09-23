-- ============================================================
--  File:  test_system_wallet.sql
--  Topic: Oracle 23ai  UTL_HTTP.SET_WALLET('system:')  -- built-in system CA trust store
--  Env :  Oracle Database 23ai Free (sqlplus 23.26.0.0.0)
--         VM "Oracle AI Database 26ai Free"  (Oracle Linux 8 / UEK)
--  Run  :  sqlplus -S "sys/oracle as sysdba" @test_system_wallet.sql
--         (SYS is exempt from network ACL, so no DBMS_NETWORK_ACL_ADMIN grant is needed)
--
--  Part 1 (scenarios 1-3): self-contained, needs only public internet.
--  Part 2 (scenarios A-G): needs the local openssl s_server endpoints set up by
--                           setup_tls_servers.sh (run that shell script first).
--
--  ============================================================
SET SERVEROUTPUT ON SIZE UNLIMITED
SET LINES 220
SET FEEDBACK OFF

PROMPT ===== 0. environment =====
SELECT instance_name||' / '||status info FROM v$instance;
SELECT substr(banner_full,1,70) ver FROM v$version WHERE rownum=1;
SELECT 'wallet_root='||nvl(value,'(not set)') p FROM v$parameter WHERE name='wallet_root';

PROMPT ===== 1. WITHOUT wallet (expect ORA-29273 / ORA-29024) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet(NULL);
  utl_http.set_transfer_timeout(12);
  s := utl_http.request('https://www.example.com/');
  dbms_output.put_line('NO_WALLET -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('NO_WALLET -> ERR '||sqlcode||': '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== 2. SET_WALLET('system') missing colon (expect ORA-29248) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('system');
  utl_http.set_transfer_timeout(12);
  s := utl_http.request('https://www.example.com/');
  dbms_output.put_line('system(no colon) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('system(no colon) -> ERR '||sqlcode||': '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== 3. SET_WALLET('system:') -> public HTTPS hosts (system CA bundle) =====
BEGIN
  utl_http.set_wallet('system:');
  utl_http.set_transfer_timeout(12);
  FOR r IN (SELECT column_value host FROM table(sys.dbms_debug_vc2coll(
            'https://www.example.com/',
            'https://www.oracle.com/',
            'https://api.github.com/',
            'https://www.cloudflare.com/',
            'https://www.microsoft.com/',
            'https://www.baidu.com/',
            'https://www.bing.com/',
            'https://www.gov.cn/'))) LOOP
    BEGIN
      dbms_output.put_line(rpad(r.host,34)||' OK  len='||rpad(length(utl_http.request(r.host)),6));
    EXCEPTION WHEN OTHERS THEN
      dbms_output.put_line(rpad(r.host,34)||' ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
    END;
  END LOOP;
END;
/

PROMPT ===== = Part 2: TLS / cert / password edge cases (needs setup_tls_servers.sh) =====

PROMPT ===== A. system: + bogus password (expect OK -- password ignored) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('system:','ThisIsABogusPassword');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://www.example.com/');
  dbms_output.put_line('A system:+boguspw  example.com -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('A system:+boguspw  -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== B. file wallet + valid cert, TLS1.2 (expect OK) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('file:/home/oracle/wallet_tests');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://127.0.0.1:8543/');
  dbms_output.put_line('B file: valid TLS1.2  -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('B file: valid TLS1.2  -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== C. file wallet + TLS1.1-only server (expect ORA-29019 protocol version) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('file:/home/oracle/wallet_tests');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://127.0.0.1:8544/');
  dbms_output.put_line('C file: TLS1.1-only  -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('C file: TLS1.1-only  -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== D. file wallet + expired server cert (expect ORA-29024 validation failure) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('file:/home/oracle/wallet_tests');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://127.0.0.1:8545/');
  dbms_output.put_line('D file: expired cert -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('D file: expired cert -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== E. file wallet + hostname mismatch (expect ORA-24263 address mismatch) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('file:/home/oracle/wallet_tests');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://127.0.0.1:8546/');
  dbms_output.put_line('E file: hostname mis -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('E file: hostname mis -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== F. system: + self-signed cert (expect ORA-29024 unknown CA) =====
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('system:');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://127.0.0.1:8543/');
  dbms_output.put_line('F system: self-signed -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('F system: self-signed -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/

PROMPT ===== G. toggle _allow_system_wallet (session-level -- expect ORA-02096) =====
BEGIN
  EXECUTE IMMEDIATE 'alter session set "_allow_system_wallet"=false';
  dbms_output.put_line('G1 alter session _allow_system_wallet=false -> OK');
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('G1 alter session -> ERR '||sqlcode||' '||sqlerrm);
END;
/
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('system:');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://www.example.com/');
  dbms_output.put_line('G2 system: after toggle attempt -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('G2 system: after toggle attempt -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
