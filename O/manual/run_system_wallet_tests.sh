#!/bin/bash
# ============================================================
#  run_system_wallet_tests.sh
#  ONE self-contained script for all UTL_HTTP.SET_WALLET('system:') scenarios.
#  No DB restart (params excluded). Run as oracle OS user (needs openssl + sudo for the clock part).
#  Usage:  bash run_system_wallet_tests.sh            # stdout = the .out
#          bash run_system_wallet_tests.sh > run_system_wallet_tests.out 2>&1
# ============================================================
set -u
export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
export ORACLE_SID=FREE
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$ORACLE_HOME/bin:$PATH
unset TWO_TASK
SP=$ORACLE_HOME/bin/sqlplus
SUDO() { echo oracle | sudo -S -p '' "$@" 2>/dev/null; }

echo "===== S0. environment ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET LINES 220 PAGES 0
SELECT instance_name||' / '||status info FROM v$instance;
SELECT substr(banner_full,1,70) ver FROM v$version WHERE rownum=1;
SELECT 'wallet_root='||nvl(value,'(not set)') p FROM v$parameter WHERE name='wallet_root';
EXIT
SQL

echo "===== S1. no wallet (expect ORA-29024) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet(NULL); utl_http.set_transfer_timeout(12);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('S1 no-wallet -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S1 no-wallet -> ERR '||sqlcode||': '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== S2. SET_WALLET('system') missing colon (expect ORA-29248) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system'); utl_http.set_transfer_timeout(12);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('S2 system(no colon) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S2 system(no colon) -> ERR '||sqlcode||': '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== S3. SET_WALLET('system:') -> public HTTPS hosts ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
BEGIN
  utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(20);
  FOR r IN (SELECT column_value host FROM table(sys.dbms_debug_vc2coll(
            'https://www.example.com/','https://www.oracle.com/','https://api.github.com/',
            'https://www.cloudflare.com/','https://www.huawei.com/',
            'https://www.baidu.com/','https://www.bing.com/','https://www.gov.cn/'))) LOOP
    BEGIN
      dbms_output.put_line(rpad(r.host,34)||' OK  len='||rpad(length(utl_http.request(r.host)),6));
    EXCEPTION WHEN OTHERS THEN
      dbms_output.put_line(rpad(r.host,34)||' ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
    END;
  END LOOP;
END;
/
EXIT
SQL

echo "===== S4. system: + bogus password (expect OK -- password ignored) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:','ThisIsABogusPassword'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('S4 system:+boguspw -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S4 system:+boguspw -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== S6. system: + hostname mismatch (baidu via IP, expect ORA-24263) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://36.152.44.132/');   -- baidu v4 IP; cert CN=*.baidu.com != IP
  dbms_output.put_line('S6 system: baidu via IP -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S6 system: baidu via IP -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== S5. file: -> non-wallet paths (OS bundle dir & non-existent; expect ORA-28759) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN
  FOR r IN (SELECT column_value p FROM table(sys.dbms_debug_vc2coll(
            'file:/etc/pki/ca-trust/extracted/pem','file:/tmp/no_such_wallet_xyz'))) LOOP
    BEGIN
      utl_http.set_wallet(r.p); utl_http.set_transfer_timeout(10);
      s:=utl_http.request('https://www.example.com/');
      dbms_output.put_line(rpad(r.p,42)||' -> OK len='||length(s));
    EXCEPTION WHEN OTHERS THEN
      dbms_output.put_line(rpad(r.p,42)||' -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
    END;
  END LOOP;
END;
/
EXIT
SQL

echo "===== S7. malformed wallet paths (expect errors) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN
  FOR r IN (SELECT column_value p FROM table(sys.dbms_debug_vc2coll(
            'garbage','file:','/etc/nonexistent','http://x','ldap:','SYSTEM:','System:'))) LOOP
    BEGIN
      utl_http.set_wallet(r.p); utl_http.set_transfer_timeout(8);
      s:=utl_http.request('https://www.example.com/');
      dbms_output.put_line(rpad(r.p,18)||' -> OK len='||length(s));
    EXCEPTION WHEN OTHERS THEN
      dbms_output.put_line(rpad(r.p,18)||' -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
    END;
  END LOOP;
END;
/
EXIT
SQL

echo "===== S8. non-https (HTTP) URL with system: (wallet irrelevant for HTTP) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_follow_redirect(0); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('http://www.example.com/');
  dbms_output.put_line('S8 system: + HTTP (non-https) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('S8 HTTP -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== C-system: TLS1.1-only self-signed (expect ORA-29019, version before cert) ====="
D=/tmp/sysc; rm -rf "$D"; mkdir -p "$D"; cd "$D"
openssl req -x509 -newkey rsa:2048 -nodes -keyout k.pem -out c.pem -days 2 \
  -subj "/CN=127.0.0.1" -addext "subjectAltName=IP:127.0.0.1" 2>/dev/null
pkill -f 'openssl s_server' 2>/dev/null || true; sleep 1
nohup openssl s_server -accept 8553 -cert c.pem -key k.pem -www \
  -tls1_1 -cipher 'DEFAULT:@SECLEVEL=0' > sc.log 2>&1 &
sleep 2
ss -ltn 2>/dev/null | grep 8553 || echo "8553 not listening"
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://127.0.0.1:8553/');
  dbms_output.put_line('C-system: TLS1.1 self-signed -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('C-system: TLS1.1 self-signed -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL
pkill -f 'openssl s_server' 2>/dev/null || true

echo "===== F-system: self-signed valid cert, TLS1.2 (expect ORA-29024 unknown CA) ====="
nohup openssl s_server -accept 8554 -cert c.pem -key k.pem -www > sf.log 2>&1 &
sleep 2
ss -ltn 2>/dev/null | grep 8554 || echo "8554 not listening"
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://127.0.0.1:8554/');
  dbms_output.put_line('F-system: self-signed TLS1.2 -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('F-system: self-signed TLS1.2 -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL
pkill -f 'openssl s_server' 2>/dev/null || true

echo "===== D-system: clock -> 2026-11-15 (leaf expired, root valid; expect ORA-29024) ====="
REAL_EPOCH=$(date -u +%s)   # capture real time BEFORE jump, to restore instantly
restore_clock() { SUDO date -s "@$REAL_EPOCH" >/dev/null 2>&1; SUDO timedatectl set-ntp true; SUDO systemctl restart chronyd; }
trap restore_clock EXIT
echo "example.com leaf notAfter:"
echo | openssl s_client -connect www.example.com:443 -servername www.example.com 2>/dev/null \
  | openssl x509 -noout -enddate 2>/dev/null
SUDO systemctl stop chronyd 2>/dev/null
SUDO timedatectl set-ntp false
SUDO timedatectl set-time "2026-11-15 12:00:00"
sleep 1
echo "clock: $(date -u)"
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://www.example.com/');
  dbms_output.put_line('D-system: example.com @2026-11-15 (leaf expired, root valid) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('D-system: example.com @2026-11-15 -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL
echo "=== restore clock (instant set back + NTP fine-sync) ==="
restore_clock
sleep 2
echo "clock: $(date -u)"
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://www.example.com/'); dbms_output.put_line('VERIFY system: (clock restored) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('VERIFY -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm); END;
/
EXIT
SQL
trap - EXIT
echo "===== DONE ====="
