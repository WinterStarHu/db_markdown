#!/bin/bash
# ============================================================
#  system_wallet_tls11.sh
#  C-system scenario: UTL_HTTP.SET_WALLET('system:') against a TLS1.1-only
#  self-signed HTTPS server.
#
#  The cert is untrusted by system: (self-signed), but TLS version is negotiated
#  BEFORE cert validation, so the expected error is ORA-29019 (protocol version),
#  NOT ORA-29024 (cert). This proves system: also enforces the min TLS version.
#
#  Run as oracle OS user (needs openssl + sqlplus; OS auth / as sysdba).
#  Cleanup: pkill -f 'openssl s_server'
# ============================================================
set -e
export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
export ORACLE_SID=FREE
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$ORACLE_HOME/bin:$PATH
unset TWO_TASK

D=/tmp/sysc; rm -rf "$D"; mkdir -p "$D"; cd "$D"
# self-signed cert (CN=127.0.0.1, SAN IP:127.0.0.1)
openssl req -x509 -newkey rsa:2048 -nodes -keyout k.pem -out c.pem -days 2 \
  -subj "/CN=127.0.0.1" -addext "subjectAltName=IP:127.0.0.1" 2>/dev/null

pkill -f 'openssl s_server' 2>/dev/null; sleep 1
# TLS1.1-only server (lower SECLEVEL so TLS1.1 is allowed by openssl)
nohup openssl s_server -accept 8553 -cert c.pem -key k.pem -www \
  -tls1_1 -cipher 'DEFAULT:@SECLEVEL=0' > sc.log 2>&1 &
sleep 2
ss -ltn 2>/dev/null | grep 8553 || { echo "8553 not listening"; exit 1; }

$ORACLE_HOME/bin/sqlplus -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://127.0.0.1:8553/');
  dbms_output.put_line('C-system: TLS1.1 self-signed -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('C-system: TLS1.1 self-signed -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL

pkill -f 'openssl s_server' 2>/dev/null
