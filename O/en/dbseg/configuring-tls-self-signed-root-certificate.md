# Configuring TLS with a Self-Signed Root Certificate

Using a self-signed root certificate is very similar to the above use case, except you must create a root wallet and sign the database certificate with the self-signed root certificate.
## Create the Root Wallet
```
orapki wallet create -wallet <root wallet directory> -pwd <root wallet password> -auto_login
```
- Create the root wallet:
```
orapki wallet display -wallet <root wallet directory>
```
- View the contents of the wallet, it should be empty:
```
orapki wallet add -wallet <root wallet directory> -dn <certificate_DN> -keysize 2048 -sign_alg sha256 -self_signed -validity 365 -pwd <root wallet password>
```
- Create the self-signed certificate for the root CA wallet:
```
ls -l <root wallet directory>
```
- The directory should now have cwallet.sso and ewallet.p12 files:
```
orapki wallet display -wallet <root wallet directory>
```
- View the contents of the wallet, it should have a user and a trusted certificate:
```
orapki wallet export -wallet <root wallet directory> -dn <certificate_DN> -cert <root wallet directory>/rootCA.crt -pwd <root wallet password>
```
- Export the root CA trusted certificate for use in creating the DB wallet:
```
cat <root wallet directory>/rootCA.crt
```
- View the contents of the rootCA.crt file:
## Create the Server and Listener Wallet
To get a certificate signed by the self-signed root certificate, follow the same steps as in the prior use case, where you create the wallets and export a certificate signing request (CSR).
- Login to the host where the database is installed.
```
orapki wallet create -wallet <wallet location> -pwd <wallet password> -auto_login
```
- Create the wallet.
```
orapki wallet add -wallet <wallet location> -trusted_cert -cert <trusted root certificate location>/rootCA.crt -pwd <wallet password>
```
- Add the trusted root certificate to the wallet (get this from your certificate administrator).
```
orapki wallet add -wallet <wallet location> -keysize 2048 -dn <certificate_dn> -pwd <wallet password>
```
- Create a private key and certificate request in the wallet.
```
orapki wallet export -wallet <wallet location> -dn <certificate_dn> -request <certificate signing request location>/<file_name>.csr -pwd <wallet password>
```
- Export the certificate request to get it signed.
```
orapki wallet display -wallet <wallet_location>
```
- Display the contents of the wallet. There will be an entry under Requested Certificates.
```
cat <certificate_signing_request_location>/<file_name>.csr
```
- View the contents of the CSR (certificate signing request) file.
## Sign the database server certificate signing request (CSR) file
```
orapki cert create -wallet <root wallet directory> -request <CSR directory>/example.csr -cert <wallet location>/example-signed.crt -validity 365 -sign_alg sha256 -pwd <root wallet password>
```
- Sign the CSR using the self-signed root wallet:
```
cat <wallet location>/example-signed.crt
```
- View the signed server user certificate:
- Import the s…3314 tokens truncated…LS connection regardless of this parameter setting.
- Log in to the client for the Oracle database.
``````
****``````````
```
TLS_CLIENT_AUTHENTICATION=FALSE
```
````````
- Set TLS_CLIENT_AUTHENTICATION in the sqlnet.ora file to FALSE. Note: To bring Oracle parameters in accord with the actual encryption and authentication methods for network connections, Oracle is deprecating all connect parameters prefixed with SSL_ in favor of parameters prefixed with TLS_. During this deprecation period, if both TLS_CLIENT_AUTHENTICATION and SSL_CLIENT_AUTHENTICATION parameters are configured, then the SSL_CLIENT_AUTHENTICATION parameter is ignored. Setting this parameter in sqlnet.ora to FALSE, will block sending a client side user certificate for all the connections. You can override this for a particular connection by setting TLS_CLIENT_AUTHENTICATION=TRUE in the connection string in tnsnames.ora so that connection will use the client-side user certificate. The connection string parameter will take precedence over the sqlnet.ora parameter setting. This setting is optional and only required if you have a client-side user certificate and you don’t want to use it for an mTLS connection.
``````
- In order to preserve existing mTLS connections that use the client-side wallet and user certificate and also to establish one-way TLS connection without using the user certificate, set TLS_CLIENT_AUTHENTICATION=TRUE, which is the default setting, in sqlnet.ora. Then for every connection that you want to use without a client-side user wallet, add TLS_CLIENT_AUTHENTICATION=FALSE in the connect string.
## Connect to the database
Connect to the database using the connection name with the tcps protocol.
```
sqlplus <user_name>@<PDB_name>
```
## Verify the connection
```
select sys_context ('userenv','NETWORK_PROTOCOL') from dual;
```
- Run the following command: This will show ‘tcps’ if TLS is enabled and ‘tcp’ if TLS is not enabled.
```
select sys_context ('userenv','TLS_VERSION') from dual;
```
- Run the following command: This will show the TLS protocol for the connection ending at the database server.
```
select sys_context ('userenv','TLS_CIPHERSUITE') from dual;
```
- Run the following command: This will show the TLS ciphersuite for the connection ending at the database server.
