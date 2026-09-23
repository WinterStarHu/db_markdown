#!/bin/bash
# ============================================================
#  tamper_ca_bundle.sh
#  OS CA bundle tampering experiments for UTL_HTTP.SET_WALLET('system:').
#
#  TA: replace bundle with a self-built CA -> system: now trusts self-signed server
#      (proves system: trusts whatever is IN the bundle).
#  TB: mTLS server (requires client cert); vary bundle content -> crash vs graceful.
#  TC: inject a non-CERTIFICATE block (private key / CSR / PKCS7 / binary) into the
#      real bundle -> system: crashes (ORA-03113) on ANY HTTPS.
#
#  Backup + trap restore of the real bundle. Run as oracle OS user (openssl + sudo).
#  Capture: bash tamper_ca_bundle.sh > tamper_ca_bundle.out   (stdout-only, clean)
# ============================================================
set -u
export ORACLE_HOME=/opt/oracle/product/26ai/dbhomeFree
export ORACLE_SID=FREE
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$ORACLE_HOME/bin:$PATH
unset TWO_TASK
SUDO() { echo oracle | sudo -S -p '' "$@" 2>/dev/null; }
SP=$ORACLE_HOME/bin/sqlplus
B=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
restore() { SUDO cp -a /tmp/real-bundle.bak "$B"; }
trap restore EXIT
SUDO cp -a "$B" /tmp/real-bundle.bak
REAL=/tmp/real-bundle.bak
echo "original bundle certs: $(grep -c 'BEGIN CERTIFICATE' "$REAL")"

# ---- build tamper CA + server cert + client cert/key ----
D=/tmp/tamper; rm -rf "$D"; mkdir -p "$D"; cd "$D"
openssl req -x509 -newkey rsa:2048 -nodes -keyout ca.key -out ca.pem -subj "/CN=Tamper CA" -days 2 2>/dev/null
printf 'subjectAltName=IP:127.0.0.1\n' > san.ext
openssl req -newkey rsa:2048 -nodes -keyout srv.key -out srv.csr -subj "/CN=127.0.0.1" 2>/dev/null
openssl x509 -req -in srv.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out srv.pem -days 2 -extfile san.ext 2>/dev/null
openssl req -newkey rsa:2048 -nodes -keyout cli.key -out cli.csr -subj "/CN=oracle-client" 2>/dev/null
openssl x509 -req -in cli.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out cli.pem -days 2 2>/dev/null

# ---- inject blocks for TC ----
I=/tmp/inj; rm -rf "$I"; mkdir -p "$I"
printf 'this is not a pem\njust garbage lines\n' > "$I/garbage.pem"
openssl genrsa 2048 2>/dev/null > "$I/rsa.key"
openssl ecparam -genkey -name prime256v1 2>/dev/null > "$I/ec.key"
openssl pkcs8 -topk8 -in "$I/rsa.key" -nocrypt 2>/dev/null > "$I/pkcs8.key"
openssl req -new -newkey rsa:2048 -nodes -keyout /dev/null -out "$I/csr.pem" -subj "/CN=x" 2>/dev/null
openssl crl2pkcs7 -nocrl -certfile ca.pem -out "$I/p7.pem" 2>/dev/null
head -c 500 /dev/urandom > "$I/bin.bin"

# ---- servers: 8555 plain TLS (tamper-CA signed), 8556 mTLS (require client cert) ----
pkill -f 'openssl s_server' 2>/dev/null || true; sleep 1
nohup openssl s_server -accept 8555 -cert srv.pem -key srv.key -www > s8555.log 2>&1 &
nohup openssl s_server -accept 8556 -cert srv.pem -key srv.key -CAfile ca.pem -Verify 1 -www > s8556.log 2>&1 &
sleep 2; ss -ltn 2>/dev/null | grep -E '855[56]'

req() {  # $1=label $2=url
  R=$(sed "s#__URL__#$2#" <<'SQL' | $SP -S -L "/ as sysdba"
SET SERVEROUTPUT ON
DECLARE s VARCHAR2(32767);
BEGIN utl_http.set_wallet('system:'); utl_http.set_transfer_timeout(10);
  s:=utl_http.request('__URL__');
  dbms_output.put_line('OK len='||length(s));
EXCEPTION WHEN OTHERS THEN dbms_output.put_line('ERR '||sqlcode||' '||utl_http.get_detailed_sqlerrm);
END;
/
EXIT
SQL
)
  echo "[$1] $R" | tr '\n' ' '; echo
}

echo "===== TA: replace bundle with self CA -> system: trusts self-signed ====="
SUDO cp ca.pem "$B"
req TA1-selfsigned-srv 'https://127.0.0.1:8555/'
req TA2-example-com  'https://www.example.com/'

echo "===== TB: mTLS server (require client cert); vary bundle ====="
cat ca.pem cli.pem cli.key > /tmp/bA.pem; SUDO cp /tmp/bA.pem "$B"; req TB-A-CA+cert+KEY   'https://127.0.0.1:8556/'
SUDO cp ca.pem "$B";                                   req TB-B-CA-only      'https://127.0.0.1:8556/'
cat ca.pem cli.pem > /tmp/bC.pem;       SUDO cp /tmp/bC.pem "$B"; req TB-C-CA+cert-noKEY 'https://127.0.0.1:8556/'
cat ca.pem cli.key > /tmp/bD.pem;       SUDO cp /tmp/bD.pem "$B"; req TB-D-CA+KEY-noCERT 'https://127.0.0.1:8556/'

echo "===== TC: inject non-cert block into REAL bundle -> system: example.com ====="
for inj in garbage.pem rsa.key ec.key pkcs8.key csr.pem p7.pem bin.bin; do
  cat "$REAL" "$I/$inj" > /tmp/bI.pem; SUDO cp /tmp/bI.pem "$B"
  req "TC-$inj" 'https://www.example.com/'
done

pkill -f 'openssl s_server' 2>/dev/null || true
restore
echo "restored certs: $(grep -c 'BEGIN CERTIFICATE' "$B")"
echo "===== DONE ====="
