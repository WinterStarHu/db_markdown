#!/bin/bash
# ============================================================
# setup_tls_servers.sh
# Spin up the local HTTPS endpoints used by test_system_wallet.sql
# scenarios C-G (TLS1.1-only / expired / hostname-mismatch / self-signed).
# Run on the Oracle DB host (same machine as the DB). Requires openssl.
# Cleanup: pkill -f 'openssl s_server'
# ============================================================
set -e
D=/tmp/tlssuite; rm -rf "$D"; mkdir -p "$D"; cd "$D"

# --- 1. self-signed CA ---
openssl req -x509 -newkey rsa:2048 -nodes -keyout ca.key -out ca.pem -days 2 \
  -subj "/CN=TLS Test CA" 2>/dev/null

# openssl ca DB (only needed to sign with explicit past dates for the expired cert)
mkdir -p caDb/newcerts caDb/private; echo 1000 > caDb/serial; : > caDb/index.txt
cat > ca.cnf <<'EOF'
[ca]
default_ca=ca_default
[ca_default]
dir=./caDb
database=$dir/index.txt
serial=$dir/serial
new_certs_dir=$dir/newcerts
certs=$dir
certificate=ca.pem
private_key=ca.key
default_md=sha256
policy=policy_any
[crlext]
[policy_any]
commonName=supplied
[req]
distinguished_name=dn
[dn]
[v3san]
subjectAltName=IP:127.0.0.1
EOF
printf 'subjectAltName=IP:127.0.0.1\n'        > san_valid.ext
printf 'subjectAltName=DNS:wronghost.example\n' > san_wrong.ext

# --- 2. server certs ---
# (a) valid, CN=127.0.0.1, SAN IP:127.0.0.1
openssl req -newkey rsa:2048 -nodes -keyout server.key -out server.csr -subj "/CN=127.0.0.1" 2>/dev/null
openssl x509 -req -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out server_valid.pem -days 2 -extfile san_valid.ext 2>/dev/null
# (b) EXPIRED (signed via openssl ca with explicit past dates)
openssl req -newkey rsa:2048 -nodes -keyout expired.key -out expired.csr -subj "/CN=127.0.0.1" 2>/dev/null
openssl ca -batch -config ca.cnf -in expired.csr -out expired.pem \
  -startdate 20200101000000Z -enddate 20200201000000Z -extensions v3san 2>/dev/null
# (c) hostname mismatch: CN=wronghost.example, SAN does NOT include 127.0.0.1
openssl req -newkey rsa:2048 -nodes -keyout mismatch.key -out mismatch.csr -subj "/CN=wronghost.example" 2>/dev/null
openssl x509 -req -in mismatch.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out mismatch.pem -days 2 -extfile san_wrong.ext 2>/dev/null

echo "expired cert window:"; openssl x509 -in expired.pem -noout -dates

# --- 3. Oracle wallet trusting the test CA (for scenarios B-E) ---
WL=/home/oracle/wallet_tests; rm -rf "$WL"; mkdir -p "$WL"
orapki wallet create -wallet "$WL" -auto_login -pwd Welcome1 2>/dev/null
orapki wallet add    -wallet "$WL" -trusted_cert -cert ca.pem -pwd Welcome1 2>/dev/null

# --- 4. start 4 s_server endpoints ---
nohup openssl s_server -accept 8543 -cert server_valid.pem -key server.key -www                       > s1.log 2>&1 &  # valid TLS1.2
nohup openssl s_server -accept 8544 -cert server_valid.pem -key server.key -www -tls1_1 -cipher 'DEFAULT:@SECLEVEL=0' > s2.log 2>&1 &  # TLS1.1-only
nohup openssl s_server -accept 8545 -cert expired.pem     -key expired.key -www                        > s3.log 2>&1 &  # expired cert
nohup openssl s_server -accept 8546 -cert mismatch.pem    -key mismatch.key -www                        > s4.log 2>&1 &  # hostname mismatch
sleep 2
ss -ltn 2>/dev/null | grep -E '854[3-6]'
echo "servers up: 8543(valid) 8544(tls1.1) 8545(expired) 8546(mismatch)"
echo "stop with: pkill -f 'openssl s_server'"
