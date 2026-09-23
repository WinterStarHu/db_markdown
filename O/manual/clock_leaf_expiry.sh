#!/bin/bash
# ============================================================
#  clock_leaf_expiry.sh
#  D-system scenario (CLEAN leaf-only expiry via system:):
#  Jump the system clock past example.com's LEAF notAfter (2026-10-27) but BEFORE
#  its root's notAfter (2040s), so ONLY the leaf is expired while the root is still
#  valid and trusted via system:. UTL_HTTP.SET_WALLET('system:') -> ORA-29024.
#
#  Contrast with the clock->2049 test (all roots expired): here the root is fine,
#  so the failure is attributable to the leaf expiry alone.
#
#  Restores the clock via NTP re-sync afterwards (trap). The Oracle instance stays
#  up throughout (a few seconds). Run as the oracle OS user (needs sudo for timedatectl).
#  Companion SQL: clock_leaf_expiry.sql
# ============================================================
set -e
export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
export ORACLE_SID=FREE
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$ORACLE_HOME/bin:$PATH
unset TWO_TASK
SUDO() { echo oracle | sudo -S -p '' "$@" 2>/dev/null; }
restore_clock() { SUDO timedatectl set-ntp true; SUDO systemctl restart chronyd; }
trap restore_clock EXIT

# Pick a date AFTER the leaf notAfter and well BEFORE the root notAfter.
# example.com leaf notAfter = 2026-10-27 (re-check below); root valid until ~2040s.
# Adjust TARGET if example.com renews (re-run the openssl check).
TARGET="2026-11-15 12:00:00"

echo "=== example.com leaf notAfter ==="
echo | openssl s_client -connect www.example.com:443 -servername www.example.com 2>/dev/null \
  | openssl x509 -noout -enddate 2>/dev/null

echo "=== jump clock to $TARGET (leaf expired, root still valid) ==="
SUDO timedatectl set-ntp false
SUDO timedatectl set-time "$TARGET"
echo "clock: $(date -u)"

$ORACLE_HOME/bin/sqlplus -S -L "/ as sysdba" @clock_leaf_expiry.sql

echo "=== restore clock (NTP re-sync) ==="
restore_clock
sleep 4
echo "clock: $(date -u)"

$ORACLE_HOME/bin/sqlplus -S -L "/ as sysdba" <<'SQL'
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('https://www.example.com/'); dbms_output.put_line('VERIFY system: (clock restored) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('VERIFY -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm); END;
/
EXIT
SQL
