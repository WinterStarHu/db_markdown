# 19.3. 连接与认证

19.3. 连接与认证
版本：
纠错本页面
搜索
目录导航
❮
❯
19.3. 连接与认证 #19.3.1. 连接设置19.3.2. TCP 设置19.3.3. 认证19.3.4. SSL19.3.1. 连接设置 #listen_addresses (string)
#
指定服务器用于监听来自客户端应用程序的连接的TCP/IP地址。
该值采用逗号分隔的主机名和/或数字IP地址的形式。特殊条目*
对应于所有可用的IP接口。条目
0.0.0.0允许监听所有IPv4地址，::允许监听所有IPv6地址。
如果列表为空，则服务器不会在任何IP接口上监听，此时只能使用Unix域套接字进行连接。
如果列表不为空，则服务器将在至少一个TCP/IP地址上可以监听时启动。
对于任何无法打开的TCP/IP地址，将发出警告。
默认值为localhost，
仅允许进行本地TCP/IP“回环”连接。
在客户端认证（第 20 章）允许对谁可以访问服务器进行细粒度控制的同时，listen_addresses 控制哪些接口接受连接尝试，这可以帮助防止在不安全的网络接口上重复恶意连接请求。此参数只能在服务器启动时设置。
port (integer)
#
服务器监听的 TCP 端口；默认是 5432 。请注意服务器会使用同一个端口号监听所有的 IP 地址。这个参数只能在服务器启动时设置。
max_connections (integer)
#
决定数据库的最大并发连接数。默认值通常是 100 个连接，但是如果内核设置不支持（initdb时决定），可能会比这个值少。这个参数只能在服务器启动时设置。
PostgreSQL 根据
max_connections 的值直接调整某些资源的大小。
增加其值会导致更高的资源分配，包括共享内存。
当运行一个后备服务器时，你必须设置这个参数等于或大于主服务器上的参数。
否则，后备服务器上可能无法允许查询。
reserved_connections (integer)
#
确定为具有 pg_use_reserved_connections
角色权限的角色保留的连接 “槽” 的数量。
每当空闲连接槽的数量大于 superuser_reserved_connections，
但小于或等于 superuser_reserved_connections
和 reserved_connections 的总和时，
新连接将仅接受来自超级用户和具有
pg_use_reserved_connections 权限的角色。
如果可用的连接槽少于或等于 superuser_reserved_connections，
新连接将仅接受来自超级用户的请求。
默认值是零连接。该值必须小于
max_connections 减去
superuser_reserved_connections。此参数只能
在服务器启动时设置。
superuser_reserved_connections
(integer)
#
确定为“连接槽”保留的连接数量，这些连接由
PostgreSQL超级用户使用。最多
max_connections个连接可以同时处于活动状态。
每当活动的并发连接数至少达到
max_connections减去
superuser_reserved_connections时，
新的连接将仅接受超级用户。此参数保留的连接槽旨在作为
紧急情况下的最终保留，在
reserved_connections保留的槽用尽后使用。
默认值是三个连接。该值必须小于max_connections
减去reserved_connections。
此参数只能在服务器启动时设置。
unix_socket_directories (string)
#
指定服务器用于监听来自客户端应用的连接的 Unix 域套接字目录。通过列出用逗号分隔的多个目录可以建立多个套接字。
项之间的空白被忽略，如果你需要在名字中包括空白或逗号，在目录名周围放上双引号。
一个空值指定在任何 Unix 域套接字上都不监听，在这种情况下只能使用 TCP/IP 套接字来连接到服务器。
以@开头的值指定应创建一个抽象命名空间中的 Unix-domain 套接字（目前仅在Linux上支持）。
在这种情况下，此值不指定一个“目录”，而是一个前缀，从中计算实际套接字名称的方式与文件系统命名空间相同。
虽然抽象套接字名称前缀可以自由选择（因为它不是文件系统位置），但惯例上仍然使用类似文件系统的值，例如
@/tmp。
默认值通常是/tmp，但是在编译时可以被改变。
在Windows上，默认值为空，意味着默认不建立Unix域套接字。此参数只能在服务器启动时设置。
除了套接字文件本身（名为.s.PGSQL.nnnn，其中nnnn是服务器的端口号），一个名为.s.PGSQL.nnnn.lock的普通文件会在每一个unix_socket_directories目录中被创建。
任何一个都不应该被手工移除。
对于抽象命名空间，没有锁文件被建立。
unix_socket_group (string)
#
设置 Unix 域套接字的所属组（套接字的所属用户总是启动服务器的用户）。可以与参数unix_socket_permissions一起用于对 Unix 域连接进行访问控制。默认是一个空字符串，表示服务器用户的默认组。这个参数只能在服务器启动时设置。
Windows 上不支持这个参数。任何设置将被忽略。同样，抽象命名空间中的套接字没有文件属主，因此在这种情况下，这个设置也会被忽略。
unix_socket_permissions (integer)
#
设置 Unix 域套接字的访问权限。Unix 域套接字使用普通的 Unix 文件系统权限集。这个参数值应该是数字模式，以chmod和umask系统调用接受的格式指定。（如果使用自定义的八进制格式，数字必须以一个0（零）开头。）
默认的权限是0777，意思是任何人都可以连接。合理的替代方案是0770（只有用户和组，另见unix_socket_group）和0700（只有用户）。（请注意，对于 Unix 域套接字，只有写权限是重要的，因此没有必要设置或撤销读取或执行权限。）
这个访问控制机制与第 20 章中描述的机制是独立的。
这个参数只能在服务器启动时设置。
这个参数与完全忽略套接字权限的系统无关，尤其是自版本10以上的Solaris。
在那些系统上，可以通过把unix_socket_directories指向一个搜索权限
限制给指定用户的目录来实现相似的效果。
抽象命名空间中的套接字没有文件权限，所以这种情况下这个设置也会被忽略。
bonjour (boolean)
#
通过Bonjour广告服务器的存在。默认值是关闭。
这个参数只能在服务器启动时设置。
bonjour_name (string)
#
指定Bonjour服务名称。空字符串''（默认值）表示使用计算机名。 如果服务器未编译支持Bonjour，则将忽略此参数。这个参数只能在服务器启动时设置。
19.3.2. TCP 设置 #tcp_keepalives_idle (integer)
#
指定在没有网络活动后，操作系统应向客户端发送TCP保活消息的时间。
如果此值未指定单位，则默认为秒。值为0（默认值）时，将选择操作系统的默认值。
在Windows上，设置值为0会将此参数设置为2小时，因为Windows无法读取系统默认值。
此参数仅在支持TCP_KEEPIDLE或等效套接字选项的系统上以及
Windows上受支持；在其他系统上，必须为零。
在通过Unix域套接字连接的会话中，此参数将被忽略，并始终读取为零。
tcp_keepalives_interval (integer)
#
指定在客户端未确认的TCP保活消息之后应重新传输的时间量。
如果此值未指定单位，则以秒为单位。
值为0（默认值）将选择操作系统的默认值。
在Windows上，将值设置为0会将此参数设置为1秒，
因为Windows无法读取系统默认值。
此参数仅在支持TCP_KEEPINTVL或等效套接字选项的系统上
以及在Windows上受支持；在其他系统上，它必须为零。
在通过Unix域套接字连接的会话中，此参数将被忽略，并始终读取为零。
tcp_keepalives_count (integer)
#
指定在服务器认为与客户端的连接已断开之前，可以丢失的TCP保活消息数量。
值为0（默认值）时，选择操作系统的默认设置。
此参数仅在支持TCP_KEEPCNT或等效套接字选项的系统上受支持
（不包括Windows）；在其他系统上，必须为零。
在通过Unix域套接字连接的会话中，此参数被忽略，并始终读取为零。
tcp_user_timeout (integer)
#
指定传输数据在未被确认的情况下可以保留的时间长度，
超过此时间后TCP连接将被强制关闭。
如果此值未指定单位，则默认为毫秒。
值为0（默认值）表示选择操作系统的默认值。
此参数仅在支持TCP_USER_TIMEOUT的系统上受支持
（不包括Windows）；在其他系统上，必须为零。
在通过Unix域套接字连接的会话中，此参数被忽略，并始终读取为零。
client_connection_check_interval (integer)
#
在运行查询时，设置检查客户端是否保持连接的可选检查的时间间隔。
这个检查通过轮询套接字来执行，并且在内核报告该连接关闭时，允许长时间运行的查询尽快中止。
这个选项依赖于Linux、macOS、illumos和BSD家族操作系统暴露的内核事件，
目前在其他系统上不可用。
如果指定的值没有单位，则以毫秒为单位。
默认值为0，代表禁用连接检查。
没有连接检查，服务器将只在与套接字的下一次交互时检测连接的丢失，当它等待、接收或发送数据时。
为了让内核本身能够在包括网络故障在内的所有场景中，在已知的时间范围内可靠地检测丢失的TCP连接，它可能还需要调整操作系统的TCP保持连接设置，
或者PostgreSQL的tcp_keepalives_idle,  tcp_keepalives_interval 和 tcp_keepalives_count 设置。
19.3.3. 认证 #authentication_timeout (integer)
#
允许完成客户端认证的最长时间。如果一个客户端没有在这段时间里完成认证协议，服务器将关闭连接。
这样就避免了出问题的客户端无限制地占有一个连接。如果指定值时没有单位，则以秒为单位。
默认值是1分钟（1m）。这个参数只能在服务器命令行上或者在postgresql.conf文件中设置。
password_encryption (enum)
#
当在CREATE ROLE或者ALTER ROLE中指定了口令时，这个参数决定用于加密该口令的算法。
可能的值是 scram-sha-256，它将使用SCRAM-SHA-256加密口令，以及 md5，它将口令存储为MD5哈希。
默认为 scram-sha-256。
注意老的客户端可能缺少对SCRAM认证机制的支持，因此无法使用用SCRAM-SHA-256加密的口令。详情请参考第 20.5 节。
警告
对 MD5 加密密码的支持已被弃用，并将在未来的
PostgreSQL 版本中移除。有关迁移到
其他密码类型的详细信息，请参阅 第 20.5 节。
scram_iterations (integer)
#
使用SCRAM-SHA-256加密口令时要执行的计算迭代次数。默认值为
4096。更高的迭代次数可以为存储的口令提供额外的
防暴力破解保护，但会使身份验证变得更慢。更改该值对使用
SCRAM-SHA-256加密的现有口令没有影响，因为迭代次数在加密时
是固定的。为了使用更改后的值，必须设置一个新口令。
md5_password_warnings (boolean)
#
控制在 CREATE ROLE 或
ALTER ROLE 语句设置 MD5 加密口令时是否生成
关于 MD5 口令弃用的 WARNING。
默认值为 on。
krb_server_keyfile (string)
#
设置服务器的 Kerberos 密钥文件的位置。默认为FILE:/usr/local/pgsql/etc/krb5.keytab（其中目录部分是在构建时由sysconfdir指定的；用pg_config --sysconfdir来确定）。如果这个参数被设为空字符串，它将被忽略，并且系统依赖的默认值被应用。这个参数只能在postgresql.conf文件中或者服务器命令行上设置。详情请参考第 20.6 节。
krb_caseins_users (boolean)
#
设置是否应该以大小写不敏感的方式对待 GSSAPI 用户名。默认值是off（大小写敏感）。这个参数只能在postgresql.conf文件中或者服务器命令行上设置。
gss_accept_delegation (boolean)
#
设置是否应接受来自客户端的 GSSAPI 委派。默认值是off，这意味着不会接受来自客户端的凭据。将其更改为on将使服务器接受客户端委派给它的凭据。此参数只能在postgresql.conf文件中或服务器命令行上设置。
oauth_validator_libraries (string)
#
用于验证 OAuth 连接令牌的库。如果只提供一个验证器库，则默认情况下将用于任何 OAuth 连接；否则，所有oauth HBA 条目必须明确设置从此列表中选择的validator。如果设置为空字符串（默认），则将拒绝 OAuth 连接。此参数只能在postgresql.conf文件中设置。
验证器模块必须单独实现/获取；PostgreSQL不提供任何默认实现。有关实现 OAuth 验证器的更多信息，请参阅第 50 章。
19.3.4. SSL #
查看第 18.9 节以获取有关设置SSL的更多信息。
用TLS协议控制传输加密的配置参数被命名为ssl，出于历史原因，
尽管对SSL协议的支持已被弃用。
在这种情况下，SSL与TLS可互换使用。
ssl (boolean)
#
启用SSL连接。这个参数只能在postgresql.conf文件中或者服务器命令行上设置。默认值是off。
ssl_ca_file (string)
#
指定包含SSL服务器证书颁发机构（CA）的文件名。相对路径是相对于数据目录的。这个参数只能在postgresql.conf文件中或者服务器命令行上设置。默认值为空，表示没有载入CA文件，并且客户端证书验证没有被执行。
ssl_cert_file (string)
#
指定包含SSL服务器证书的文件名。相对路径是相对于数据目录的。这个参数只能在postgresql.conf文件中或者服务器命令行上设置。默认值是server.crt。
ssl_crl_file (string)
#
指定包含 SSL 客户端证书吊销列表（CRL）的文件名。
相对路径是相对于数据目录的。
此参数只能在 postgresql.conf 文件或服务器命令行中设置。
默认为空，表示不加载 CRL 文件（除非设置了 ssl_crl_dir）。
ssl_crl_dir (string)
#
指定包含 SSL 客户端证书吊销列表（CRL）的目录名称。相对路径是相对于数据目录的。
此参数只能在 postgresql.conf 文件或服务器命令行中设置。
默认为空，表示不使用 CRL（除非设置了 ssl_crl_file）。
该目录需要用 OpenSSL 命令 openssl rehash 或 c_rehash 来准备。
详请参阅相应文档。
当使用此设置时，在连接时会按需加载指定目录下的 CRLs。
新的 CRLs 可以添加到该目录中，并可以立即使用。
这与 ssl_crl_file 不同，后者会导致文件中的 CRL 在服务器启动时或重新加载配置时加载。
两个设置可以一起使用。
ssl_key_file (string)
#
指定包含 SSL 服务器私钥的文件名。相对路径是相对于数据目录的。
此参数只能在 postgresql.conf 文件中或服务器命令行上设置。
默认值是 server.key。
ssl_tls13_ciphers (string)
#
指定使用 TLS 版本 1.3 的连接允许的密码套件列表。
可以使用冒号分隔的列表指定多个密码套件。
如果留空，将使用 OpenSSL 中的默认密码套件。
这个参数只能在 postgresql.conf 文件中或者服务器命令行上设置。
ssl_ciphers (string)
#
指定允许使用 TLS 版本 1.2 及更低版本的连接的 SSL 密码列表，
有关 TLS 版本 1.3 连接的信息，请参见
ssl_tls13_ciphers。有关此设置的语法和支持值的列表，
请参见 ciphers
手册页，位于 OpenSSL 包中。默认值为
HIGH:MEDIUM:+3DES:!aNULL。默认值通常是一个合理的选择，
除非您有特定的安全要求。
这个参数只能在 postgresql.conf 文件中或者服务器命令行上设置。
默认值的解释：
HIGH #
使用 HIGH 组中的加密套件（例如，AES、Camellia、3DES）
MEDIUM #
使用 MEDIUM 组中的加密套件（例如，RC4、SEED）
+3DES #
OpenSSL 的默认 HIGH 顺序存在问题，
因为它将 3DES 的优先级排在 AES128 之前。这是错误的，因为 3DES 提供的安全性
低于 AES128，而且速度也慢得多。+3DES 将其重新排序到
所有其他 HIGH 和 MEDIUM 加密套件之后。
!aNULL #
禁用不进行身份验证的匿名加密套件。这类加密套件容易受到
MITM 攻击，因此不应使用。
可用的密码组细节可能会随着 OpenSSL 版本变化。
可使用命令 openssl ciphers -v 'HIGH:MEDIUM:+3DES:!aNULL' 来查看当前安装的 OpenSSL 版本的实际细节。
注意这个列表是根据服务器密钥类型在运行时过滤过的。
ssl_prefer_server_ciphers (boolean)
#
指定是否使用服务器的 SSL 密码首选项，而不是用客户端的。
这个参数只能在 postgresql.conf 文件中或在服务器命令行上设置。
默认值是 on。
PostgreSQL 9.4 之前的版本没有此设置，并且始终使用客户端的
偏好设置。此设置主要是为了与这些版本保持向后兼容。通常使用服务器的偏好设置会更
好，因为服务器更有可能被适当地配置。
ssl_groups (string)
#
指定在 ECDH 密钥交换中使用的曲线名称。它需要被所有连接的客户端支持。
可以通过使用冒号分隔的列表指定多个曲线。
它不需要与服务器的椭圆曲线密钥使用的曲线相同。
此参数只能在 postgresql.conf 文件中或在服务器命令行上设置。
默认值为 X25519:prime256v1。
OpenSSL为最常见的曲线命名为：
prime256v1（NIST P-256），
secp384r1（NIST P-384），
secp521r1（NIST P-521）。
可以使用命令 openssl ecparam -list_curves 显示可用组的
不完整列表。不过，并非所有这些组都可以与 TLS 一起使用，
并且许多支持的组名称和别名被省略。
在 PostgreSQL 18.0 之前的版本中，此设置被称为
ssl_ecdh_curve，并且只接受单个值。
ssl_min_protocol_version (enum)
#
设置要使用的最小SSL/TLS协议版本。当前的可用版本包括： TLSv1, TLSv1.1, TLSv1.2, TLSv1.3.
旧版本的 OpenSSL 库不支持所有值；如果选择了不支持的设置将会引发错误。
TLS 1.0之前的协议版本，也就是SSL版本2和3，总是禁用的。
默认为TLSv1.2，在本文撰写时的行业最佳实践。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
ssl_max_protocol_version (enum)
#
设定要使用的最大SSL/TLS协议版本。
有效的版本为 ssl_min_protocol_version，添加一个空字符串，允许任何协议版本。
默认为允许任何版本。设置最大协议版本主要用于测试，或者某个组件在与较新的协议配合工作时出现了问题。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
ssl_dh_params_file (string)
#
指定含有用于SSL密码的所谓临时DH家族的Diffie-Hellman参数的文件名。默认值为空，这种情况下将使用内置的默认DH参数。使用自定义的DH参数可以降低攻击者破解众所周知的内置DH参数的风险。可以用命令openssl dhparam -out dhparams.pem 2048创建自己的DH参数文件。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
ssl_passphrase_command (string)
#
设置当需要一个密码（例如一个私钥）来解密SSL文件时会调用的一个外部命令。默认情况下，这个参数为空，表示使用内置的提示机制。
该命令必须将密码打印到标准输出并且以代码0退出。在该参数值中，%p被替换为一个提示字符串（要得到文字%，应该写成%%）。注意该提示字符串将可能含有空格，因此要确保加上适当的引号。如果输出的末尾有单一的新行，它会被剥离掉。
该命令实际上并不一定要提示用户输入一个密码。它可以从文件中读取密码、从钥匙链得到密码等等。确保选中的机制足够安全是用户的责任。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
ssl_passphrase_command_supports_reload (boolean)
#
此参数决定在需要密码短语的情况下，是否在配置重新加载期间调用
ssl_passphrase_command。如果此参数为 off
（默认值），则在重新加载期间将忽略 ssl_passphrase_command，
如果需要密码短语，则不会重新加载 SSL 配置。该设置适用于需要 TTY 提示的命令，
当服务器运行时可能无法使用。将此参数设置为 on 可能是合适的，
例如，如果密码短语是从文件中获取的。
在 Windows 上运行时，此参数必须设置为
on，因为所有连接都将由于该平台不同的进程模型而执行配置重新加载。
这个参数只能在postgresql.conf文件中或通过服务器命令行进行设置。
上一页 上一级 下一页19.2. 文件位置 起始页 19.4. 资源消耗
