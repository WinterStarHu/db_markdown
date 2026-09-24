#!/bin/bash
# ============================================================
#  return_info_response.sh
#  UTL_HTTP.GET_RESPONSE(r, return_info_response=>...) behavior.
#   R1: FALSE (default) -> skips 1xx, returns final 200 + body.
#   R2: TRUE once -> returns 1xx (100 Continue); then FALSE -> final 200 + body
#       (correct two-step usage).
#   R3: looping TRUE -> 1xx not advanced, accumulates open requests ->
#       ORA-29270 (too many open HTTP requests) -> ORA-03113 crash.
#  Run as oracle OS user: bash return_info_response.sh > return_info_response.out
# ============================================================
set -u
export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
export ORACLE_SID=FREE
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$ORACLE_HOME/bin:$PATH
unset TWO_TASK
SP=$ORACLE_HOME/bin/sqlplus

echo "===== R1. get_response(return_info_response=>FALSE) [default]: final 200 ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE req utl_http.req; resp utl_http.resp; data varchar2(32767);
BEGIN
  utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10); utl_http.set_follow_redirect(0);
  req := utl_http.begin_request('https://www.example.com/','GET',http_version=>'HTTP/1.1');
  resp := utl_http.get_response(req, return_info_response=>FALSE);
  dbms_output.put_line('R1 status='||resp.status_code||' '||nvl(resp.reason_phrase,''));
  utl_http.read_text(resp,data,2000);
  dbms_output.put_line('R1 body len='||length(data));
  utl_http.end_response(resp);
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('R1 ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== R2. TRUE -> 100; then FALSE -> 200 (correct two-step) ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE req utl_http.req; resp utl_http.resp; data varchar2(32767);
BEGIN
  utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10); utl_http.set_follow_redirect(0);
  req := utl_http.begin_request('https://www.example.com/','GET',http_version=>'HTTP/1.1');
  resp := utl_http.get_response(req, return_info_response=>TRUE);
  dbms_output.put_line('R2 TRUE  -> status='||resp.status_code||' '||nvl(resp.reason_phrase,''));
  resp := utl_http.get_response(req, return_info_response=>FALSE);
  dbms_output.put_line('R2 FALSE -> status='||resp.status_code||' '||nvl(resp.reason_phrase,''));
  utl_http.read_text(resp,data,2000);
  dbms_output.put_line('R2 body len='||length(data));
  utl_http.end_response(resp);
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('R2 ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

echo "===== R3. loop get_response(TRUE): 1xx not advanced -> ORA-29270 -> ORA-03113 crash ====="
$SP -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE
  req utl_http.req; resp utl_http.resp;
  i number := 0;
BEGIN
  utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10); utl_http.set_follow_redirect(0);
  req := utl_http.begin_request('https://www.example.com/','GET',http_version=>'HTTP/1.1');
  WHILE i < 20 LOOP
    i := i + 1;
    resp := utl_http.get_response(req, return_info_response=>TRUE);
    dbms_output.put_line('R3 iter#'||i||' status='||resp.status_code||' '||nvl(resp.reason_phrase,''));
    EXIT WHEN resp.status_code NOT BETWEEN 100 AND 199;
  END LOOP;
  utl_http.end_response(resp);
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('R3 caught: '||sqlcode||' '||utl_http.get_detailed_sqlerrm||' (after '||i||' iters)');
END;
/
EXIT
SQL

echo "===== DONE ====="
