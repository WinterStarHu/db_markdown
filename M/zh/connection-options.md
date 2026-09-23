# 4.2.3 连接服务器的命令选项_MySQL 8.0 参考手册

4.2.3 连接服务器的命令选项_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.2.1 调用MySQL程序1
4.2.2 指定程序选项1
4.2.3 连接服务器的命令选项1
4.2.4 使用命令选项连接到 MySQL 服务器1
4.2.5 使用类似 URI 的字符串或键值对连接到服务器1
4.2.6 使用 DNS SRV 记录连接到服务器1
4.2.7 连接传输协议1
4.2.8 连接压缩控制1
4.2.9 设置环境变量1
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
第 5 章 MySQL 服务器管理
第 6 章 安全
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.2 使用 MySQL 程序  /
4.2.3 连接服务器的命令选项
4.2.3 连接服务器的命令选项
本节介绍大多数 MySQL 客户端程序支持的选项，这些选项控制客户端程序如何与服务器建立连接、是否加密连接以及是否压缩连接。这些选项可以在命令行或选项文件中给出。
连接建立的命令选项加密连接的命令选项连接压缩的命令选项
连接建立的命令选项
本节描述控制客户端程序如何与服务器建立连接的选项。有关显示如何使用它们的其他信息和示例，请参阅
第 4.2.4 节，“使用命令选项连接到 MySQL 服务器”。
表 4.3 连接建立选项总结
选项名称
描述
介绍
--default-auth
要使用的身份验证插件
- 主持人
MySQL 服务器所在的主机
- 密码
连接到服务器时使用的密码
--密码1
连接到服务器时使用的第一个多因素身份验证密码
8.0.27
--密码2
连接到服务器时使用的第二个多因素身份验证密码
8.0.27
--密码3
连接到服务器时使用的第三个多重身份验证密码
8.0.27
- 管道
使用命名管道连接到服务器（仅限 Windows）
--插件目录
安装插件的目录
- 港口
用于连接的 TCP/IP 端口号
- 协议
使用的传输协议
--shared-memory-base-name
共享内存连接的共享内存名称（仅限 Windows）
- 插座
要使用的 Unix 套接字文件或 Windows 命名管道
- 用户
连接到服务器时使用的 MySQL 用户名
--default-auth=plugin
关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
--host=host_name,
-h host_name
运行 MySQL 服务器的主机。该值可以是主机名、IPv4 地址或 IPv6 地址。默认值为localhost。
--password[=pass_val],
-p[pass_val]
用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出，客户端程序会提示输入一个。如果给定，则
后面
的密码之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且客户端程序不应提示输入密码，请使用该
--skip-password
选项。
--password1[=pass_val]
用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出，客户端程序会提示输入一个。如果给定，则后面的密码和密码之间
不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且客户端程序不应提示输入密码，请使用该
--skip-password1
选项。
--password1and
--password是同义词，就像
--skip-password1
and
一样--skip-password。
--password2[=pass_val]
用于连接到服务器的 MySQL 帐户的多因素身份验证因子 2 的密码。此选项的语义类似于 ; 的语义
--password1。有关详细信息，请参阅该选项的说明。
--password3[=pass_val]
用于连接服务器的 MySQL 帐户的多重身份验证因子 3 的密码。此选项的语义类似于 ; 的语义
--password1。有关详细信息，请参阅该选项的说明。
--pipe,-W
在 Windows 上，使用命名管道连接到服务器。仅当服务器启动时
named_pipe启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--plugin-dir=dir_name
在其中查找插件的目录。如果该--default-auth
选项用于指定身份验证插件但客户端程序找不到它，请指定此选项。请参阅
第 6.2.17 节，“可插入身份验证”。
--port=port_num,
-P port_num
对于 TCP/IP 连接，要使用的端口号。默认端口号为 3306。
--protocol={TCP|SOCKET|PIPE|MEMORY}
此选项明确指定用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。例如，在 Unix 上localhost默认使用 Unix 套接字文件建立连接：
mysql --host=localhost
要强制改用 TCP/IP 传输，请指定一个
--protocol选项：
mysql --host=localhost --protocol=TCP
下表显示了允许的
--protocol选项值，并指出了每个值的适用平台。这些值不区分大小写。
--protocol价值
使用的传输协议
适用平台
TCP
到本地或远程服务器的 TCP/IP 传输
全部
SOCKET
Unix 套接字文件传输到本地服务器
Unix 和类 Unix 系统
PIPE
命名管道传输到本地服务器
视窗
MEMORY
到本地服务器的共享内存传输
视窗
另见第 4.2.7 节，“连接传输协议”
--shared-memory-base-name=name
在 Windows 上，用于使用共享内存与本地服务器建立连接的共享内存名称。默认值为MYSQL。共享内存名称区分大小写。
仅当服务器启动时
shared_memory启用了支持共享内存连接的系统变量时，此选项才适用。
--socket=path,
-S path
在 Unix 上，用于使用命名管道与本地服务器建立连接的 Unix 套接字文件的名称。默认的 Unix 套接字文件名为
/tmp/mysql.sock.
在 Windows 上，用于连接到本地服务器的命名管道的名称。默认的 Windows 管道名称是MySQL. 管道名称不区分大小写。
在 Windows 上，仅当服务器启动时named_pipe
启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--user=user_name,
-u user_name
用于连接到服务器的 MySQL 帐户的用户名。默认用户名ODBC
在 Windows 上或在 Unix 上是您的 Unix 登录名。
加密连接的命令选项
本节介绍客户端程序的选项，这些选项指定是否使用与服务器的加密连接、证书和密钥文件的名称以及与加密连接支持相关的其他参数。有关建议使用的示例以及如何检查连接是否加密，请参阅
第 6.3.1 节，“配置 MySQL 以使用加密连接”。
笔记
这些选项仅对使用受加密传输协议的连接有效；即 TCP/IP 和 Unix 套接字文件连接。请参阅
第 4.2.7 节，“连接传输协议”
有关从 MySQL C API 使用加密连接的信息，请参阅支持加密连接。
表 4.4 连接加密选项总结
选项名称
描述
介绍
--get-server-public-key
从服务器请求 RSA 公钥
--server-public-key-path
包含 RSA 公钥的文件的路径名
--ssl-ca
包含可信 SSL 证书颁发机构列表的文件
--ssl-capath
包含受信任的 SSL 证书颁发机构证书文件的目录
--ssl证书
包含 X.509 证书的文件
--ssl密码
连接加密的允许密码
--ssl-crl
包含证书吊销列表的文件
--ssl-crlpath
包含证书吊销列表文件的目录
--ssl-fips-模式
客户端是否开启FIPS模式
--ssl-密钥
包含 X.509 密钥的文件
--ssl模式
连接到服务器的所需安全状态
--ssl 会话数据
包含 SSL 会话数据的文件
8.0.29
--ssl-session-data-continue-on-failed-reuse
session重用失败是否建立连接
8.0.29
--tls-密码套件
用于加密连接的允许的 TLSv1.3 密码套件
8.0.16
--tls-版本
加密连接允许的 TLS 协议
--get-server-public-key
从服务器请求基于 RSA 密钥对的密码交换所需的公钥。此选项适用于使用
caching_sha2_password身份验证插件进行身份验证的客户端。对于该插件，除非请求，否则服务器不会发送公钥。对于未使用该插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于
.
--server-public-key-path=file_name--get-server-public-key
有关
caching_sha2_password插件的信息，请参阅
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
--server-public-key-path=file_name
PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。此选项适用于使用
sha256_password或
caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于
.
--server-public-key-path=file_name--get-server-public-key
仅当使用 OpenSSL 构建 MySQL 时，此选项才可用。
有关sha256_password
和caching_sha2_password插件的信息，请参阅
第 6.4.1.3 节，“SHA-256 可插入身份验证”和
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
--ssl-ca=file_name
PEM 格式的证书颁发机构 (CA) 证书文件的路径名。该文件包含受信任的 SSL 证书颁发机构列表。
要告诉客户端在与服务器建立加密连接时不要对服务器证书进行身份验证，请既不指定
--ssl-ca也不
指定--ssl-capath。服务器仍然根据为客户帐户建立的任何适用要求验证客户端，并且它仍然使用服务器端指定的任何ssl_ca或
ssl_capath系统变量值。
要为服务器指定 CA 文件，请设置
ssl_ca系统变量。
--ssl-capath=dir_name
包含 PEM 格式的可信 SSL 证书颁发机构 (CA) 证书文件的目录的路径名。
要告诉客户端在与服务器建立加密连接时不要对服务器证书进行身份验证，请既不指定
--ssl-ca也不
指定--ssl-capath。服务器仍然根据为客户帐户建立的任何适用要求验证客户端，并且它仍然使用服务器端指定的任何ssl_ca或
ssl_capath系统变量值。
要为服务器指定 CA 目录，请设置
ssl_capath系统变量。
--ssl-cert=file_name
PEM 格式的客户端 SSL 公钥证书文件的路径名。
要指定服务器 SSL 公钥证书文件，请设置ssl_cert系统变量。
笔记
v8.0.30 中添加了链式 SSL 证书支持；以前只读取第一个证书。
--ssl-cipher=cipher_list
通过 TLSv1.2 使用 TLS 协议的连接的允许加密密码列表。如果列表中的密码均不受支持，则使用这些 TLS 协议的加密连接将不起作用。
为了最大的可移植性，
cipher_list应该是一个或多个密码名称的列表，用冒号分隔。例子：
--ssl-cipher=AES128-SHA
--ssl-cipher=DHE-RSA-AES128-GCM-SHA256:AES128-SHAOpenSSL 支持https://www.openssl.org/docs/manmaster/man1/ciphers.html
上的 OpenSSL 文档中描述的用于指定密码的语法
。
有关 MySQL 支持哪些加密密码的信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
要为服务器指定加密密码，请设置
ssl_cipher系统变量。
--ssl-crl=file_name
包含 PEM 格式的证书吊销列表的文件的路径名。
如果既未--ssl-crl给出也未
--ssl-crlpath给出，则不执行 CRL 检查，即使 CA 路径包含证书吊销列表。
要为服务器指定吊销列表文件，请设置
ssl_crl系统变量。
--ssl-crlpath=dir_name
包含 PEM 格式的证书吊销列表文件的目录的路径名。
如果既未--ssl-crl给出也未
--ssl-crlpath给出，则不执行 CRL 检查，即使 CA 路径包含证书吊销列表。
要为服务器指定吊销列表目录，请设置ssl_crlpath系统变量。
--ssl-fips-mode={OFF|ON|STRICT}
控制是否在客户端启用 FIPS 模式。该
--ssl-fips-mode选项与其他
选项的不同之处在于它不用于建立加密连接，而是用于影响允许哪些加密操作。请参见第 6.8 节 “FIPS 支持”。
--ssl-xxx
这些--ssl-fips-mode值是允许的：
OFF: 禁用 FIPS 模式。
ON：启用 FIPS 模式。
STRICT：启用“严格”
FIPS 模式。
笔记
如果 OpenSSL FIPS 对象模块不可用，则唯一允许的
--ssl-fips-mode值为
OFF. 在这种情况下，设置
--ssl-fips-mode为
ON或STRICT会导致客户端在启动时发出警告并在非 FIPS 模式下运行。
要为服务器指定 FIPS 模式，请设置
ssl_fips_mode系统变量。
--ssl-key=file_name
PEM 格式的客户端 SSL 私钥文件的路径名。为提高安全性，请使用 RSA 密钥大小至少为 2048 位的证书。
如果密钥文件受密码保护，则客户端程序会提示用户输入密码。密码必须交互给出；它不能存储在文件中。如果密码不正确，程序将继续运行，就好像它无法读取密钥一样。
要指定服务器 SSL 私钥文件，请设置
ssl_key系统变量。
--ssl-mode=mode
此选项指定与服务器的连接所需的安全状态。按照严格程度递增的顺序，这些模式值是允许的：
DISABLED：建立未加密的连接。
PREFERRED：如果服务器支持加密连接，则建立加密连接，如果无法建立加密连接，则回退到未加密连接。--ssl-mode如果未指定，
则这是默认值。
通过 Unix 套接字文件的连接未使用PREFERRED. 要对 Unix 套接字文件连接实施加密，请使用REQUIRED或更严格的模式。（但是，套接字文件传输在默认情况下是安全的，因此加密套接字文件连接会使其不再安全并增加 CPU 负载。）
REQUIRED：如果服务器支持加密连接，则建立加密连接。如果无法建立加密连接，则连接尝试失败。
VERIFY_CA：与
REQUIRED配置的 CA 证书类似，但另外验证服务器证书颁发机构 (CA) 证书。如果未找到有效的匹配 CA 证书，连接尝试将失败。
VERIFY_IDENTITY：与 一样
VERIFY_CA，但通过检查客户端用于连接到服务器的主机名与服务器发送给客户端的证书中的身份来另外执行主机名身份验证：
从 MySQL 8.0.12 开始，如果客户端使用 OpenSSL 1.0.2 或更高版本，客户端会检查它用于连接的主机名是否与服务器证书中的主题备用名称值或通用名称值匹配。主机名身份验证也适用于使用通配符指定通用名称的证书。
否则，客户端会检查它用于连接的主机名是否与服务器证书中的 Common Name 值相匹配。
如果不匹配，连接将失败。对于加密连接，此选项有助于防止中间人攻击。
笔记
主机名身份验证
VERIFY_IDENTITY不适用于由服务器自动创建或使用
mysql_ssl_rsa_setup手动创建的自签名证书（请参阅
第 6.3.3.1 节，“使用 MySQL 创建 SSL 和 RSA 证书和密钥”）。此类自签名证书不包含服务器名称作为 Common Name 值。
重要的
如果其他默认设置未更改，
--ssl-mode=PREFERRED则默认设置 会生成加密连接。但是，为了帮助防止复杂的中间人攻击，客户端验证服务器的身份很重要。设置
--ssl-mode=VERIFY_CA和
--ssl-mode=VERIFY_IDENTITY
是比默认设置更好的选择，有助于防止此类攻击。要实施这些设置之一，您必须首先确保服务器的 CA 证书对您环境中使用它的所有客户端可靠可用，否则将导致可用性问题。因此，它们不是默认设置。
该--ssl-mode选项与 CA 证书选项交互，如下所示：
如果--ssl-mode未明确设置，则使用
--ssl-ca或
--ssl-capath暗示
--ssl-mode=VERIFY_CA。
对于or
的--ssl-mode值
，
VERIFY_CAor
也是必需的，以提供与服务器使用的证书相匹配的 CA 证书。
VERIFY_IDENTITY--ssl-ca--ssl-capath具有or
--ssl-mode
以外值
的显式选项连同显式or
选项会产生一条警告，即尽管指定了 CA 证书选项，但仍未执行服务器证书验证。
VERIFY_CAVERIFY_IDENTITY--ssl-ca--ssl-capath
要要求 MySQL 帐户使用加密连接，请使用CREATE USER创建带有REQUIRE SSL子句的帐户，或使用
ALTER USER现有帐户添加REQUIRE SSL子句。这会导致使用该帐户的客户端的连接尝试被拒绝，除非 MySQL 支持加密连接并且可以建立加密连接。
该REQUIRE条款允许其他与加密相关的选项，这些选项可用于执行比REQUIRE
SSL. 有关使用使用各种选项配置的帐户连接的客户端可以或必须指定哪些命令选项的更多详细信息
REQUIRE，请参阅
CREATE USER SSL/TLS 选项。
--ssl-session-data=file_name
PEM 格式的客户端 SSL 会话数据文件的路径名，用于会话重用。
当您使用该选项调用 MySQL 客户端程序时
--ssl-session-data，客户端会尝试从文件中反序列化会话数据（如果提供），然后使用它来建立新连接。如果您提供了一个文件，但会话没有被重用，那么除非您
--ssl-session-data-continue-on-failed-reuse
在调用客户端程序时还在命令行上指定了该选项，否则连接将失败。
mysql命令
ssl_session_data_print生成会话数据文件（请参阅
第4.5.1.2 节，“mysql 客户端命令”）。
ssl-session-data-continue-on-failed-reuse
控制是否启动新连接以替换已尝试但未能重用
--ssl-session-data
命令行选项指定的会话数据的尝试连接。默认情况下，
--ssl-session-data-continue-on-failed-reuse
命令行选项处于关闭状态，这会导致客户端程序在提供会话数据但未重新使用时返回连接失败。
为确保在会话重用静默失败后打开一个新的、不相关的连接，请使用
--ssl-session-data和
--ssl-session-data-continue-on-failed-reuse
命令行选项调用 MySQL 客户端程序。
--tls-ciphersuites=ciphersuite_list
此选项指定客户端允许哪些密码套件用于使用 TLSv1.3 的加密连接。该值是零个或多个以冒号分隔的密码套件名称的列表。例如：
mysql --tls-ciphersuites="suite1:suite2:suite3"
可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。如果未设置此选项，则客户端允许使用默认的密码套件集。如果该选项设置为空字符串，则不会启用任何密码套件，并且无法建立加密连接。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
这个选项是在 MySQL 8.0.16 中添加的。
要指定服务器允许哪些密码套件，请设置
tls_ciphersuites系统变量。
--tls-version=protocol_list
此选项指定客户端允许加密连接的 TLS 协议。该值是一个或多个以逗号分隔的协议版本的列表。例如：
mysql --tls-version="TLSv1.2,TLSv1.3"
可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库，以及 MySQL 服务器版本。
重要的
从 MySQL 8.0.28 开始，对 TLSv1 和 TLSv1.1 连接协议的支持已从 MySQL 服务器中删除。这些协议已从 MySQL 8.0.26 中弃用，但如果使用已弃用的 TLS 协议版本，MySQL 服务器客户端不会向用户返回警告。从 MySQL 8.0.28 开始，客户端，包括 MySQL Shell，支持
--tls-version选项无法与协议设置为 TLSv1 或 TLSv1.1 建立 TLS/SSL 连接。如果客户端尝试使用这些协议进行连接，对于 TCP 连接，连接将失败，并向客户端返回一个错误。对于套接字连接，如果
--ssl-mode设置为
REQUIRED，则连接失败，否则建立连接但禁用 TLS/SSL。有关详细信息，请参阅
取消对 TLSv1 和 TLSv1.1 协议的支持
。
从 MySQL 8.0.16 开始，MySQL Server 支持 TLSv1.3 协议，前提是 MySQL Server 是使用 OpenSSL 1.1.1 或更高版本编译的。服务端在启动时会检查OpenSSL的版本，如果低于1.1.1，则将TLS版本相关的服务端系统变量（如
tls_version系统变量）的默认值去掉TLSv1.3。
应选择允许的协议，例如不要在列表中留下
“漏洞”。例如，这些值没有孔：
--tls-version="TLSv1,TLSv1.1,TLSv1.2,TLSv1.3"
--tls-version="TLSv1.1,TLSv1.2,TLSv1.3"
--tls-version="TLSv1.2,TLSv1.3"
--tls-version="TLSv1.3"
From MySQL 8.0.28, only the last two values are suitable.
这些值确实有漏洞，不应使用：
--tls-version="TLSv1,TLSv1.2"
--tls-version="TLSv1.1,TLSv1.3"
有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
要指定服务器允许哪些 TLS 协议，请设置
tls_version系统变量。
连接压缩的命令选项
本节描述使客户端程序能够控制对服务器连接的压缩使用的选项。有关显示如何使用它们的其他信息和示例，请参阅
第 4.2.8 节，“连接压缩控制”。
表 4.5 连接压缩选项总结
选项名称
描述
介绍
弃用
- 压缩
压缩客户端和服务器之间发送的所有信息
8.0.18
--压缩算法
允许的服务器连接压缩算法
8.0.18
--zstd-压缩级别
使用 zstd 压缩的服务器连接的压缩级别
8.0.18
--compress,
-C
如果可能，压缩客户端和服务器之间发送的所有信息。
从 MySQL 8.0.18 开始，不推荐使用此选项。预计它会在 MySQL 的未来版本中被删除。请参阅
配置传统连接压缩。
--compression-algorithms=value
允许的连接到服务器的压缩算法。可用算法与
protocol_compression_algorithms
系统变量相同。默认值为
uncompressed。
这个选项是在 MySQL 8.0.18 中添加的。
--zstd-compression-level=level
用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
这个选项是在 MySQL 8.0.18 中添加的。
© Mysql 中文网
