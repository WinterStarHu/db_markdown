-- ============================================================
--  clock_leaf_expiry.sql
--  Invoked by clock_leaf_expiry.sh while the system clock is jumped forward
--  past example.com's LEAF notAfter (but before its root's notAfter), so only
--  the leaf is expired while the root stays valid and trusted via system:.
--  Expected: ORA-29024 (leaf expired).
-- ============================================================
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN
  utl_http.set_wallet('system:');
  utl_http.set_transfer_timeout(10);
  s := utl_http.request('https://www.example.com/');
  dbms_output.put_line('D-system: example.com @clock-future (leaf expired, root valid via system:) -> OK len='||length(s));
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line('D-system: example.com @clock-future -> ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
