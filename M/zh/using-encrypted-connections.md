# 6.3.1 配置 MySQL 使用加密连接_MySQL 8.0 参考手册

6.3.1 配置 MySQL 使用加密连接_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.3.1 配置 MySQL 使用加密连接1
6.3.2 加密连接 TLS 协议和密码1
6.3.3 创建 SSL 和 RSA 证书和密钥1
6.3.4 使用 SSH 从 Windows 远程连接到 MySQL1
6.3.5 重用 SSL 会话1
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.3 使用加密连接  /
6.3.1 配置 MySQL 使用加密连接
6.3.1 配置 MySQL 使用加密连接
有几个配置参数可用于指示是否使用加密连接，并指定适当的证书和密钥文件。本节提供有关为加密连接配置服务器和客户端的一般指导：
加密连接的服务器端启动配置加密连接的服务器端运行时配置和监控加密连接的客户端配置将加密连接配置为强制
加密连接也可用于其他上下文，如以下附加部分中所述：
在源和副本复制服务器之间。请参阅
第 17.3.1 节，“设置复制以使用加密连接”。
在组复制服务器中。请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”。
通过基于 MySQL C API 的客户端程序。请参阅
支持加密连接。
第 6.3.3 节“创建 SSL 和 RSA 证书和密钥”
中提供了创建任何所需证书和密钥文件的说明。
加密连接的服务器端启动配置
在服务器端，该--ssl
选项指定服务器允许但不需要加密连接。默认情况下启用此选项，因此无需明确指定。
要要求客户端使用加密连接进行连接，请启用
require_secure_transport系统变量。请参阅将加密连接配置为强制性的。
服务器端的这些系统变量指定服务器在允许客户端建立加密连接时使用的证书和密钥文件：
ssl_ca：证书颁发机构 (CA) 证书文件的路径名。(ssl_capath类似但指定了 CA 证书文件目录的路径名。)
ssl_cert: 服务器公钥证书文件的路径名。该证书可以发送到客户端并根据它拥有的 CA 证书进行身份验证。
ssl_key: 服务器私钥文件的路径名。
例如，要为服务器启用加密连接，请使用my.cnf
文件中的这些行启动它，并根据需要更改文件名：
[mysqld]
ssl_ca=ca.pem
ssl_cert=server-cert.pem
ssl_key=server-key.pem
要另外指定客户端需要使用加密连接，请启用
require_secure_transport系统变量：
[mysqld]
ssl_ca=ca.pem
ssl_cert=server-cert.pem
ssl_key=server-key.pem
require_secure_transport=ON
每个证书和密钥系统变量以 PEM 格式命名一个文件。如果您需要创建所需的证书和密钥文件，请参阅第 6.3.3 节，“创建 SSL 和 RSA 证书和密钥”。使用 OpenSSL 编译的 MySQL 服务器可以在启动时自动生成丢失的证书和密钥文件。请参阅
第 6.3.3.1 节，“使用 MySQL 创建 SSL 和 RSA 证书和密钥”。或者，如果您有 MySQL 源代码分发版，则可以使用其mysql-test/std_data目录中的演示证书和密钥文件来测试您的设置。
服务器执行证书和密钥文件自动发现。--ssl如果除了（可能连同
）配置加密连接之外没有给出明确的加密连接选项
ssl_cipher，服务器会尝试在启动时自动启用加密连接支持：
ca.pem如果服务器在数据目录中发现名为、
server-cert.pem和
的
有效证书和密钥文件server-key.pem，它会启用对客户端加密连接的支持。（这些文件不需要自动生成；重要的是它们具有这些名称并且是有效的。）
如果服务器在数据目录中找不到有效的证书和密钥文件，它会继续执行但不支持加密连接。
如果服务器自动启用加密连接支持，它会在错误日志中写入一条注释。如果服务器发现 CA 证书是自签名的，它会在错误日志中写入一条警告。（如果由服务器自动创建或使用
mysql_ssl_rsa_setup手动创建，则该证书是自签名的。）
MySQL 还为服务器端加密连接控制提供了这些系统变量：
ssl_cipher：用于连接加密的允许密码列表。
ssl_crl：包含证书吊销列表的文件的路径名。（ssl_crlpath类似但指定了证书吊销列表文件目录的路径名。）
tls_version,
tls_ciphersuites: 服务器允许哪些加密协议和密码套件用于加密连接；参见
第 6.3.2 节，“加密连接 TLS 协议和密码”。例如，您可以配置
tls_version为防止客户端使用安全性较低的协议。
如果服务器无法从服务器端加密连接控制的系统变量创建有效的 TLS 上下文，则服务器将在不支持加密连接的情况下执行。
加密连接的服务器端运行时配置和监控
在 MySQL 8.0.16 之前，配置加密连接支持的
和
系统变量只能在服务器启动时设置。因此，这些系统变量决定了服务器用于所有新连接的 TLS 上下文。
tls_xxxssl_xxx
从 MySQL 8.0.16 开始，
和
系统变量是动态的，可以在运行时设置，而不仅仅是在启动时。如果更改为
，则新值仅在服务器重新启动之前适用。如果使用 更改
，新值也会延续到后续服务器重新启动。请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。但是，如本节后面所述，对这些变量的运行时更改不会立即影响新连接的 TLS 上下文。
tls_xxxssl_xxxSET
GLOBALSET
PERSIST
随着 MySQL 8.0.16 中允许对 TLS 上下文相关系统变量进行运行时更改的更改，服务器允许对用于新连接的实际 TLS 上下文进行运行时更新。此功能可能很有用，例如，可以避免重新启动运行时间过长以致其 SSL 证书已过期的 MySQL 服务器。
为了创建初始 TLS 上下文，服务器使用上下文相关的系统变量在启动时具有的值。为了公开上下文值，服务器还初始化一组相应的状态变量。下表显示了定义 TLS 上下文的系统变量和公开当前活动上下文值的相应状态变量。
表 6.12 服务器主连接接口 TLS 上下文的系统和状态变量
系统变量名称
对应的状态变量名
ssl_ca
Current_tls_ca
ssl_capath
Current_tls_capath
ssl_cert
Current_tls_cert
ssl_cipher
Current_tls_cipher
ssl_crl
Current_tls_crl
ssl_crlpath
Current_tls_crlpath
ssl_key
Current_tls_key
tls_ciphersuites
Current_tls_ciphersuites
tls_version
Current_tls_version
从 MySQL 8.0.21 开始，那些活动的 TLS 上下文值也作为性能模式
tls_channel_status表中的属性公开，以及任何其他活动 TLS 上下文的属性。
要在运行时重新配置 TLS 上下文，请使用以下过程：
将每个应更改为新值的 TLS 上下文相关系统变量设置为新值。
执行ALTER INSTANCE RELOAD
TLS。此语句从 TLS 上下文相关系统变量的当前值重新配置活动 TLS 上下文。它还设置与上下文相关的状态变量以反映新的活动上下文值。该语句需要
CONNECTION_ADMIN特权。
执行后建立的新连接
ALTER INSTANCE RELOAD TLS使用新的 TLS 上下文。现有连接不受影响。如果应终止现有连接，请使用该
KILL语句。
由于重新配置过程的工作方式，每对系统和状态变量的成员可能暂时具有不同的值：
之前对系统变量的
ALTER INSTANCE RELOAD TLS更改不会更改 TLS 上下文。此时，这些更改对新连接没有影响，相应的上下文相关系统和状态变量可能具有不同的值。ALTER INSTANCE RELOAD TLS
这使您能够对单个系统变量进行任何所需的更改，然后在完成所有系统变量更改后
自动更新活动 TLS 上下文
。
之后ALTER INSTANCE RELOAD
TLS，相应的系统和状态变量具有相同的值。在下一次更改系统变量之前，这一直是正确的。
在某些情况下，ALTER INSTANCE RELOAD
TLS它本身就足以重新配置 TLS 上下文，而无需更改任何系统变量。假设名为 的文件中的证书
ssl_cert已过期。用未过期的证书替换现有文件内容并执行ALTER
INSTANCE RELOAD TLS以使新文件内容被读取并用于新连接就足够了。
从 MySQL 8.0.21 开始，服务器为管理连接接口实现了独立的连接加密配置。请参阅
加密连接的管理界面支持。此外，ALTER INSTANCE RELOAD
TLS使用一个子句进行扩展，该FOR CHANNEL
子句允许指定为其重新加载 TLS 上下文的通道（接口）。请参阅第 13.1.5 节，“ALTER INSTANCE 语句”。没有状态变量来公开管理界面 TLS 上下文，但性能模式
tls_channel_status表公开了主界面和管理界面的 TLS 属性。请参阅
第 27.12.21.8 节，“tls_channel_status 表”。
更新主界面 TLS 上下文具有以下效果：
此更新更改了用于主连接接口上新连接的 TLS 上下文。
更新还会更改用于管理界面上新连接的 TLS 上下文，除非为该界面配置了一些非默认 TLS 参数值。
此更新不会影响其他已启用的服务器插件或组件（例如 Group Replication 或 X 插件）使用的 TLS 上下文：
要将主界面重新配置应用于 Group Replication 的组通信连接，这些连接从服务器的 TLS 上下文相关系统变量中获取它们的设置，您必须执行，
STOP GROUP_REPLICATION
然后START
GROUP_REPLICATION停止并重新启动 Group Replication。
X 插件在插件初始化时初始化其 TLS 上下文，如
第 20.5.3 节“使用 X 插件的加密连接”中所述。此上下文此后不会更改。
默认情况下，RELOAD TLS如果配置值不允许创建新的 TLS 上下文，则该操作会返回错误并且无效。以前的上下文值继续用于新连接。如果给出了可选
NO ROLLBACK ON ERROR子句并且无法创建新上下文，则不会发生回滚。相反，会生成一条警告，并为应用该语句的接口上的新连接禁用加密。
在连接接口上启用或禁用加密连接的选项仅在启动时有效。例如，--ssl选项
--admin-ssl仅在启动时影响主界面和管理界面是否支持加密连接。此类选项将被忽略，并且对运行时的操作没有影响ALTER
INSTANCE RELOAD TLS。例如，您可以使用--ssl=OFF在主界面上禁用加密连接来启动服务器，然后重新配置 TLS 并执行ALTER INSTANCE
RELOAD TLS以在运行时启用加密连接。
加密连接的客户端配置
有关与建立加密连接相关的客户端选项的完整列表，请参阅加密连接的
命令选项。
默认情况下，如果服务器支持加密连接，MySQL 客户端程序会尝试建立加密连接，并通过以下
--ssl-mode选项进一步控制：
在没有
--ssl-mode选项的情况下，客户端会尝试使用加密进行连接，如果无法建立加密连接，则会回退到未加密的连接。这也是具有显式
--ssl-mode=PREFERRED选项的行为。
使用--ssl-mode=REQUIRED，客户端需要加密连接，如果无法建立则失败。
对于--ssl-mode=DISABLED，客户端使用未加密的连接。
使用--ssl-mode=VERIFY_CA或
--ssl-mode=VERIFY_IDENTITY，客户端需要加密连接，并且还针对服务器 CA 证书和（使用
VERIFY_IDENTITY）针对其证书中的服务器主机名执行验证。
重要的
如果其他默认设置未更改，
--ssl-mode=PREFERRED则默认设置 会生成加密连接。但是，为了帮助防止复杂的中间人攻击，客户端验证服务器的身份很重要。这些设置
是比默认设置更好的选择--ssl-mode=VERIFY_CA，
--ssl-mode=VERIFY_IDENTITY
有助于防止此类攻击。VERIFY_CA使客户端检查服务器的证书是否有效。
VERIFY_IDENTITY使客户端检查服务器证书是否有效，并使客户端检查客户端使用的主机名是否与服务器证书中的身份匹配。要实施这些设置之一，您必须首先确保服务器的 CA 证书对您环境中使用它的所有客户端可靠可用，否则将导致可用性问题。因此，它们不是默认设置。
require_secure_transport如果在服务器端启用系统变量导致服务器需要加密连接，
则尝试建立未加密的连接会失败
。请参阅
将加密连接配置为强制性的。
客户端的以下选项标识客户端在与服务器建立加密连接时使用的证书和密钥文件。它们类似于服务器端使用的
ssl_ca、
ssl_cert和
ssl_key系统变量，但
标识客户端公钥--ssl-cert和
--ssl-key私钥：
--ssl-ca：证书颁发机构 (CA) 证书文件的路径名。如果使用此选项，则必须指定服务器使用的相同证书。(--ssl-capath类似但指定了 CA 证书文件目录的路径名。)
--ssl-cert：客户端公钥证书文件的路径名。
--ssl-key: 客户端私钥文件的路径名。
为了相对于默认加密提供的额外安全性，客户端可以提供与服务器使用的证书相匹配的 CA 证书并启用主机名身份验证。通过这种方式，服务器和客户端信任同一个 CA 证书，并且客户端验证它连接到的主机是预期的主机：
要指定 CA 证书，请使用
--ssl-ca（或
--ssl-capath），然后指定
--ssl-mode=VERIFY_CA.
要同时启用主机名身份验证，请使用
--ssl-mode=VERIFY_IDENTITY
而不是
--ssl-mode=VERIFY_CA.
笔记
主机名身份验证
VERIFY_IDENTITY不适用于由服务器自动创建或使用
mysql_ssl_rsa_setup手动创建的自签名证书（请参阅
第 6.3.3.1 节，“使用 MySQL 创建 SSL 和 RSA 证书和密钥”）。此类自签名证书不包含服务器名称作为 Common Name 值。
在 MySQL 8.0.12 之前，主机名身份验证也不适用于使用通配符指定 Common Name 的证书，因为该名称会逐字与服务器名称进行比较。
MySQL 还为客户端加密连接控制提供了这些选项：
--ssl-cipher：用于连接加密的允许密码列表。
--ssl-crl：包含证书吊销列表的文件的路径名。（--ssl-crlpath类似但指定了证书吊销列表文件目录的路径名。）
--tls-version,
--tls-ciphersuites: 允许的加密协议和密码套件；参见
第 6.3.2 节，“加密连接 TLS 协议和密码”。
根据客户端使用的 MySQL 帐户的加密要求，客户端可能需要指定某些选项以使用加密连接到 MySQL 服务器。
假设您要使用没有特殊加密要求的帐户或使用
CREATE USER包含该REQUIRE SSL子句的语句创建的帐户进行连接。假设服务器支持加密连接，客户端可以使用不带
--ssl-mode选项或带显式--ssl-mode=PREFERRED
选项的加密连接：
mysql
或者：
mysql --ssl-mode=PREFERRED
对于使用REQUIRE SSL
子句创建的帐户，如果无法建立加密连接，则连接尝试失败。对于没有特殊加密要求的帐户，如果无法建立加密连接，则尝试回退到未加密的连接。为防止在无法获得加密连接时回退和失败，请像这样连接：
mysql --ssl-mode=REQUIRED
如果账户有更严格的安全要求，则必须指定其他选项来建立加密连接：
对于使用REQUIRE X509
子句创建的帐户，客户必须至少指定
--ssl-cert和
--ssl-key。此外，
建议使用--ssl-ca(or
--ssl-capath) 以便验证服务器提供的公共证书。例如（在一行中输入命令）：
mysql --ssl-ca=ca.pem
--ssl-cert=client-cert.pem
--ssl-key=client-key.pem
对于使用REQUIRE
ISSUERorREQUIRE SUBJECT
子句创建的帐户，加密要求与 相同
REQUIRE X509，但证书必须分别与帐户定义中指定的问题或主题相匹配。
有关该REQUIRE
子句的其他信息，请参阅第 13.7.1.3 节，“CREATE USER 语句”。
MySQL 服务器可以生成客户端证书和密钥文件，客户端可以使用这些文件连接到 MySQL 服务器实例。请参阅
第 6.3.3 节，“创建 SSL 和 RSA 证书和密钥”。
重要的
如果连接到 MySQL 服务器实例的客户端使用带有extendedKeyUsage
扩展名（X.509 v3 扩展名）的 SSL 证书，则扩展密钥用法必须包括客户端身份验证 ( clientAuth)。如果指定SSL证书仅用于服务器端认证（serverAuth）等非客户端证书用途，则证书校验失败，客户端连接MySQL服务器实例失败。MySQL 服务器生成的 SSL 证书中没有extendedKeyUsage
扩展（如
第 6.3.3.1 节“使用 MySQL 创建 SSL 和 RSA 证书和密钥”中所述），以及使用
openssl创建的 SSL 证书按照第 6.3.3.2 节“使用 openssl 创建 SSL 证书和密钥”中的说明执行命令。如果您使用以其他方式创建的自己的客户端证书，请确保任何extendedKeyUsage扩展都包含客户端身份验证。
要防止使用加密并覆盖其他
选项，请使用以下命令调用客户端程序
：
--ssl-xxx--ssl-mode=DISABLEDmysql --ssl-mode=DISABLED
要确定当前与服务器的连接是否使用加密，请检查
Ssl_cipher状态变量的会话值。如果该值为空，则连接未加密。否则，连接被加密并且该值指示加密密码。例如：
mysql> SHOW SESSION STATUS LIKE 'Ssl_cipher';
+---------------+---------------------------+
| Variable_name | Value                     |
+---------------+---------------------------+
| Ssl_cipher    | DHE-RSA-AES128-GCM-SHA256 |
+---------------+---------------------------+
对于mysql客户端，另一种方法是使用STATUSor\s
命令并检查该SSL行：
mysql> \s
...
SSL: Not in use
...
或者：
mysql> \s
...
SSL: Cipher in use is DHE-RSA-AES128-GCM-SHA256
...
将加密连接配置为强制
对于某些 MySQL 部署，使用加密连接可能不仅是可取的，而且是强制性的（例如，为了满足法规要求）。本节讨论使您能够执行此操作的配置设置。这些控制级别可用：
您可以将服务器配置为要求客户端使用加密连接进行连接。
您可以调用单独的客户端程序来要求加密连接，即使服务器允许但不要求加密也是如此。
您可以将单个 MySQL 帐户配置为仅可通过加密连接使用。
要要求客户端使用加密连接进行连接，请启用
require_secure_transport系统变量。例如，将这些行放在服务器
my.cnf文件中：
[mysqld]
require_secure_transport=ON
或者，要在运行时设置和保留该值，请使用以下语句：
SET PERSIST require_secure_transport=ON;
SET
PERSIST为正在运行的 MySQL 实例设置一个值。它还会保存该值，使其用于后续服务器重新启动。请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。
启用后，客户端与require_secure_transport
服务器的连接需要使用某种形式的安全传输，并且服务器仅允许使用 SSL 的 TCP/IP 连接，或使用套接字文件（在 Unix 上）或共享内存（在 Windows 上）的连接。服务器拒绝不安全的连接尝试，这些尝试会因
ER_SECURE_TRANSPORT_REQUIRED
错误而失败。
要调用客户端程序以使其无论服务器是否需要加密都需要加密连接，请使用
--ssl-mode选项值
REQUIRED、VERIFY_CA或
VERIFY_IDENTITY。例如：
mysql --ssl-mode=REQUIRED
mysqldump --ssl-mode=VERIFY_CA
mysqladmin --ssl-mode=VERIFY_IDENTITY
要将 MySQL 帐户配置为仅可用于加密连接，请在创建帐户REQUIRE的语句中包含一个子句，并
在该子句中指定您需要的加密特征。CREATE USER例如，要要求加密连接和使用有效的 X.509 证书，请使用REQUIRE X509：
CREATE USER 'jeffrey'@'localhost' REQUIRE X509;
有关该REQUIRE
子句的其他信息，请参阅第 13.7.1.3 节，“CREATE USER 语句”。
要修改没有加密要求的现有帐户，请使用该ALTER USER
语句。
© Mysql 中文网
