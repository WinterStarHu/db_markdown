# 18.9. 用 SSL 进行安全的 TCP/IP 连接

18.9. 用 SSL 进行安全的 TCP/IP 连接
版本：
纠错本页面
搜索
目录导航
❮
❯
18.9. 用 SSL 进行安全的 TCP/IP 连接 #18.9.1. 基本设置18.9.2. OpenSSL 配置18.9.3. 使用客户端证书18.9.4. SSL 服务器文件使用18.9.5. 创建证书
PostgreSQL 有一个对使用 SSL 连接加密客户端/服务器通信的本地支持，它可以增加安全性。这个特性要求在客户端和服务器端都安装 OpenSSL 并且在编译 PostgreSQL 时启用这个支持（见 第 17 章）。
术语 SSL 和 TLS 经常被互换使用，意思是使用 TLS 协议的安全加密连接。 SSL 协议是 TLS 协议的前身，即使 SSL 协议不再受支持，术语 SSL 仍然用于加密连接。在 PostgreSQL 中， SSL 与 TLS 可以互换使用。
18.9.1. 基本设置 #
使用已编译支持SSL的PostgreSQL服务器可以通过在postgresql.conf中将参数ssl设置为on来启用对使用TLS协议的加密连接的支持。服务器将在同一TCP端口上同时监听普通连接和SSL连接，并将与任何连接的客户端协商是否使用SSL。默认情况下，这取决于客户端的选择；请参阅第 20.1 节了解如何设置服务器以要求对某些或所有连接使用SSL。
要在SSL模式中启动服务器，包含服务器证书和私钥的文件必须存在。默认情况下，这些文件应该分别被命名为server.crt和server.key并且被放在服务器的数据目录中，但是可以通过配置参数ssl_cert_file和ssl_key_file指定其他名称和位置。
在 Unix 系统上，server.key上的权限必须不允许所有人或组的任何访问，通过命令chmod 0600 server.key可以做到。或者，该文件可以由 root 所拥有并且具有组读访问（也就是0640权限）。这种设置适用于由操作系统管理证书和密钥文件的安装。用于运行PostgreSQL服务器的用户应该被作为能够访问那些证书和密钥文件的组成员。
如果数据目录允许组读取访问，则证书文件可能需要位于数据目录之外，以符合上面概述的安全要求。通常，启用组访问权限是为了允许非特权用户备份数据库，在这种情况下，备份软件将无法读取证书文件，并且可能会出错。
如果私钥被一个密码保护着，服务器将提示要求这个密码，并且在它被输入前不会启动。
默认情况下，使用密码禁用在不重启服务器的情况下更改服务器的SSL配置的功能，并且参见 ssl_passphrase_command_supports_reload。
此外，密码保护的私钥在Windows上根本无法使用。
server.crt中的第一个证书必须是服务器的证书，因为它必须与服务器的私钥匹配。
“intermediate”证书颁发机构的证书也可以追加到文件。
假设根证书和中间证书是使用v3_ca扩展名创建的，那么这样做避免了在客户端上存储中间证书的必要。
（这将证书的 CA 的基本约束设置为 true。）这使得中间证书更容易到期。
无需将根证书添加到server.crt。相反，客户端必须具有服务器证书链的根证书。
18.9.2. OpenSSL 配置 #
PostgreSQL读取系统范围的OpenSSL配置文件。默认情况下，该文件被命名为openssl.cnf并位于openssl version -d报告的目录中。通过将环境变量设置OPENSSL_CONF为所需配置文件的名称，可以覆盖此默认值。
OpenSSL支持各种强度不同的密码和身份验证算法。虽然可以在OpenSSL的配置文件中指定密码，您可以通过修改ssl_ciphers在postgresql.conf中专门为数据库服务器指定密码。
注意
使用NULL-SHA或NULL-MD5可以得到身份验证但没有加密开销。
不过，中间人能够读取和传递客户端和服务器之间的通信。
此外，加密开销相比身份验证的开销是最小的。
出于这些原因，我们建议不要使用 NULL 密码。
18.9.3. 使用客户端证书 #
要求客户端提供受信任的证书，把您信任的根证书颁发机构（CA）的证书放置在数据目录文件中。
并且修改postgresql.conf中的参数ssl_ca_file到新的文件名，
还要把认证选项 clientcert=verify-ca或clientcert=verify-full加入到pg_hba.conf文件中合适的hostssl行上。
然后将在 SSL 连接启动时从客户端请求该证书（有关如何在客户端设置证书的描述请见第 32.19 节）。
对于具有 clientcert=verify-ca 的hostssl条目，服务器将验证客户端的证书是否由一个受信任的证书颁发机构签署。
如果指定了 clientcert=verify-full，则服务器不仅将验证证书链，还将检查用户名或其映射是否与所提供的证书的 cn（通用名称）相匹配。
请注意，在使用 cert 身份验证方法时，要始终确保证书链验证（参见 第 20.12 节）。
中间证书链到现有根证书，如果您希望避免在客户端上存储它们，也可以出现在ssl_ca_file文件中
（假设根证书和中间证书是使用v3_ca扩展创建的）。如果设置了参数ssl_crl_file或
ssl_crl_dir，还会检查证书吊销列表（CRL）条目。
clientcert认证选项适用于所有的认证方法，但仅适用于pg_hba.conf中用hostssl指定的行。
当clientcert没有指定，服务器仅在客户端证书存在并且CA被配置的时候，通过客户端的CA文件来查证客户端证书。
有两种方法可以强制用户在登录时提供证书。
第一种方法是对pg_hba.conf文件中的hostssl条目使用cert身份验证方法，这样证书本身可以用于身份验证，同时提供ssl连接安全性。详细信息请参阅第 20.12 节。（在使用cert身份验证方法时，不需要显式指定任何clientcert选项。）在这种情况下，证书中cn（通用名称）将针对用户名或适用的映射进行检查。
第二种方法是将对hostssl条目的任何身份验证方法和客户端证书的验证相结合，通过将clientcert身份验证选项设置为verify-ca或verify-full。前一个选项仅强制证书有效，而后者还确保证书中的cn（通用名称）匹配用户名或适用的映射。
18.9.4. SSL 服务器文件使用 #
表 18.2总结了与服务器上SSL配置有关的文件。（显示的文件名是默认的名称。本地配置的名称可能会不同。）
表 18.2. SSL 服务器文件使用文件内容效果ssl_cert_file ($PGDATA/server.crt)服务器证书发送给客户端以指示服务器的身份ssl_key_file ($PGDATA/server.key)服务器私钥证明服务器证书是其所有者发送的，并不说明证书所有者是可信的ssl_ca_file可信的证书颁发机构检查客户端证书是由一个可信的证书颁发机构签名的ssl_crl_file被证书颁发机构撤销的证书客户端证书不能出现在这个列表中
服务器在服务器启动时以及服务器配置重新加载时读取这些文件。在Windows系统上，只要为新客户端连接生成新的后端进程，它们也会重新读取。
如果在服务器启动时检测到这些文件中的错误，服务器将拒绝启动。但是，如果在配置重新加载过程中检测到错误，则会忽略这些文件，并继续使用旧的SSL配置。在Windows系统上，如果在后端启动时检测到这些文件中存在错误，则该后端将无法建立SSL连接。在所有这些情况下，错误情况都会在服务器日志中报告。
18.9.5. 创建证书 #
要为服务器创建一个有效期为365天的简单自签名证书，可以使用下面的OpenSSL命令，将dbhost.yourdomain.com替换为服务器的主机名：
openssl req -new -x509 -days 365 -nodes -text -out server.crt \
-keyout server.key -subj "/CN=dbhost.yourdomain.com"
然后执行：
chmod og-rwx server.key
如果文件的权限比这个更宽松，服务器将拒绝该文件。要了解更多关于如何创建你的服务器私钥和证书的细节，请参考OpenSSL文档。
尽管可以使用自签名证书进行测试，但是在生产中应该使用由证书颁发机构（CA）（通常是企业范围的根CA）签名的证书。
要创建其身份可以被客户端验证的服务器证书，请首先创建一个证书签名请求（CSR）和一个公共/私有密钥文件：
openssl req -new -nodes -text -out root.csr \
-keyout root.key -subj "/CN=root.yourdomain.com"
chmod og-rwx root.key
然后，使用密钥对请求进行签名以创建根证书颁发机构（使用Linux上的默认OpenSSL配置文件位置）：
openssl x509 -req -in root.csr -text -days 3650 \
-extfile /etc/ssl/openssl.cnf -extensions v3_ca \
-signkey root.key -out root.crt
最后，创建由新的根证书颁发机构签名的服务器证书：
openssl req -new -nodes -text -out server.csr \
-keyout server.key -subj "/CN=dbhost.yourdomain.com"
chmod og-rwx server.key
openssl x509 -req -in server.csr -text -days 365 \
-CA root.crt -CAkey root.key -CAcreateserial \
-out server.crt
server.crt和server.key应该存储在服务器上，并且root.crt应该存储在客户端上，以便客户端可以验证服务器的叶证书已由其受信任的根证书签名。root.key应该离线存储以用于创建将来的证书。
也可以创建一个包括中间证书的信任链：
# root
openssl req -new -nodes -text -out root.csr \
-keyout root.key -subj "/CN=root.yourdomain.com"
chmod og-rwx root.key
openssl x509 -req -in root.csr -text -days 3650 \
-extfile /etc/ssl/openssl.cnf -extensions v3_ca \
-signkey root.key -out root.crt
# intermediate
openssl req -new -nodes -text -out intermediate.csr \
-keyout intermediate.key -subj "/CN=intermediate.yourdomain.com"
chmod og-rwx intermediate.key
openssl x509 -req -in intermediate.csr -text -days 1825 \
-extfile /etc/ssl/openssl.cnf -extensions v3_ca \
-CA root.crt -CAkey root.key -CAcreateserial \
-out intermediate.crt
# leaf
openssl req -new -nodes -text -out server.csr \
-keyout server.key -subj "/CN=dbhost.yourdomain.com"
chmod og-rwx server.key
openssl x509 -req -in server.csr -text -days 365 \
-CA intermediate.crt -CAkey intermediate.key -CAcreateserial \
-out server.crt
server.crt和intermediate.crt应连接成一个证书文件包并存储在服务器上。server.key还应该存储在服务器上。root.crt应存储在客户端上，以便客户端可以验证服务器的叶证书是否已由链接到其受信任根证书的证书链签名。root.key和intermediate.key应离线存储以用于创建将来的证书。
上一页 上一级 下一页18.8. 加密选项 起始页 18.10. 使用 GSSAPI 加密的安全 TCP/IP 连接
