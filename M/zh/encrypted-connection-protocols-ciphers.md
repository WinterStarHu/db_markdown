# 6.3.2 加密连接 TLS 协议和密码_MySQL 8.0 参考手册

6.3.2 加密连接 TLS 协议和密码_MySQL 8.0 参考手册
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
6.3.2 加密连接 TLS 协议和密码
6.3.2 加密连接 TLS 协议和密码
MySQL 支持多种 TLS 协议和密码，并允许配置允许加密连接的协议和密码。还可以确定当前会话使用的协议和密码。
支持的 TLS 协议取消对 TLSv1 和 TLSv1.1 协议的支持连接 TLS 协议配置连接密码配置连接 TLS 协议协商监控当前客户端会话 TLS 协议和密码
支持的 TLS 协议
允许连接到给定 MySQL 服务器实例的协议集受以下多个因素的影响：
MySQL 服务器发布
MySQL 8.0.15 及之前版本，MySQL 支持 TLSv1、TLSv1.1 和 TLSv1.2 协议。
从 MySQL 8.0.16 开始，MySQL 也支持 TLSv1.3 协议。要使用 TLSv1.3，MySQL 服务器和客户端应用程序都必须使用 OpenSSL 1.1.1 或更高版本进行编译。组复制组件支持 MySQL 8.0.18 中的 TLSv1.3（有关详细信息，请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”）。
从 MySQL 8.0.26 开始，不推荐使用 TLSv1 和 TLSv1.1 协议。这些协议版本较旧，分别于 1996 年和 2006 年发布，使用的算法弱且过时。有关背景信息，请参阅 IETF 备忘录
Deprecating TLSv1.0 and TLSv1.1。
从 MySQL 8.0.28 开始，MySQL 不再支持 TLSv1 和 TLSv1.1 协议。从此版本开始，客户端无法将协议设置为 TLSv1 或 TLSv1.1 来建立 TLS/SSL 连接。有关详细信息，请参阅
删除对 TLSv1 和 TLSv1.1 协议的支持。
表 6.13 MySQL 服务器 TLS 协议支持
MySQL 服务器版本
支持的 TLS 协议
MySQL 8.0.15 及以下版本
TLSv1、TLSv1.1、TLSv1.2
MySQL 8.0.16 和 MySQL 8.0.17
TLSv1、TLSv1.1、TLSv1.2、TLSv1.3（组复制除外）
MySQL 8.0.18 到 MySQL 8.0.25
TLSv1、TLSv1.1、TLSv1.2、TLSv1.3（包括组复制）
MySQL 8.0.26 和 MySQL 8.0.27
TLSv1（已弃用）、TLSv1.1（已弃用）、TLSv1.2、TLSv1.3
MySQL 8.0.28 及以上版本
TLSv1.2、TLSv1.3
SSL库
如果 SSL 库不支持特定协议，则 MySQL 也不支持，并且以下讨论中指定该协议的任何部分都不适用。特别要注意，要使用 TLSv1.3，MySQL 服务器和客户端应用程序都必须使用 OpenSSL 1.1.1 或更高版本进行编译。MySQL Server 在启动时检查 OpenSSL 的版本，如果它低于 1.1.1，则从与 TLS 版本（ 、 和 ）相关的服务器系统变量的默认值中tls_version删除
admin_tls_versionTLSv1.3
group_replication_recovery_tls_version。
MySQL实例配置
允许的 TLS 协议可以在服务器端和客户端配置为仅包含受支持的 TLS 协议的子集。双方的配置必须至少包含一个共同的协议，否则连接尝试无法协商要使用的协议。有关详细信息，请参阅
连接 TLS 协议协商。
系统范围的主机配置
主机系统可能只允许某些 TLS 协议，这意味着 MySQL 连接不能使用未经许可的协议，即使 MySQL 本身允许它们：
假设 MySQL 配置允许 TLSv1、TLSv1.1 和 TLSv1.2，但您的主机系统配置只允许使用 TLSv1.2 或更高版本的连接。在这种情况下，您无法建立使用 TLSv1 或 TLSv1.1 的 MySQL 连接，即使 MySQL 配置为允许它们，因为主机系统不允许它们。
如果 MySQL 配置允许 TLSv1、TLSv1.1 和 TLSv1.2，但您的主机系统配置只允许使用 TLSv1.3 或更高版本的连接，则您根本无法建立 MySQL 连接，因为主机不允许使用 MySQL 允许的任何协议系统。
此问题的解决方法包括：
更改系统范围的主机配置以允许其他 TLS 协议。有关说明，请参阅您的操作系统文档。例如，您的系统可能有一个
/etc/ssl/openssl.cnf包含以下行的文件，用于将 TLS 协议限制为 TLSv1.2 或更高版本：
[system_default_sect]
MinProtocol = TLSv1.2
将值更改为较低的协议版本或
None使系统更加宽松。此解决方法的缺点是允许较低（不太安全）的协议可能会产生不利的安全后果。
如果您不能或不想更改主机系统 TLS 配置，请更改 MySQL 应用程序以使用主机系统允许的更高（更安全）的 TLS 协议。对于仅支持较低协议版本的旧版本 MySQL，这可能是不可能的。例如，TL​​Sv1 是 MySQL 5.6.46 之前唯一受支持的协议，因此即使客户端来自支持更高协议版本的较新 MySQL 版本，尝试连接到 5.6.46 之前的服务器也会失败。在这种情况下，可能需要升级到支持其他 TLS 版本的 MySQL 版本。
取消对 TLSv1 和 TLSv1.1 协议的支持
从 MySQL 8.0.28 开始，删除了对 TLSv1 和 TLSv1.1 连接协议的支持。这些协议已从 MySQL 8.0.26 中弃用。有关背景信息，请参阅 IETF 备忘录
Deprecating TLSv1.0 and TLSv1.1。建议使用更安全的 TLSv1.2 和 TLSv1.3 协议建立连接。TLSv1.3 要求 MySQL 服务器和客户端应用程序都使用 OpenSSL 1.1.1 进行编译。
删除了对 TLSv1 和 TLSv1.1 的支持，因为这些协议版本较旧，分别于 1996 年和 2006 年发布。使用的算法薄弱且过时。除非您使用的是非常旧版本的 MySQL 服务器或连接器，否则您不太可能使用 TLSv1.0 或 TLSv1.1 建立连接。MySQL 连接器和客户端默认选择可用的最高 TLS 版本。
在不支持 TLSv1 和 TLSv1.1 连接协议的版本中（从 MySQL 8.0.28 开始），支持
--tls-version指定用于连接 MySQL 服务器的 TLS 协议的选项的客户端（包括 MySQL Shell）无法建立 TLS/SSL 连接协议设置为 TLSv1 或 TLSv1.1。如果客户端尝试使用这些协议进行连接，对于 TCP 连接，连接将失败，并向客户端返回一个错误。对于套接字连接，如果
--ssl-mode设置为
REQUIRED，则连接失败，否则建立连接但禁用 TLS/SSL。
在服务器端，从 MySQL 8.0.28 开始更改了以下设置：
tls_version服务器和
系统变量
的默认值
admin_tls_version不再包括 TLSv1 和 TLSv1.1。
Group Replication 系统变量的默认值
group_replication_recovery_tls_version
不再包括 TLSv1 和 TLSv1.1。
对于异步复制，副本不能将连接到源服务器的协议设置为 TLSv1 或 TLSv1.1（语句的SOURCE_TLS_VERSION选项CHANGE REPLICATION SOURCE
TO）。
在不推荐使用 TLSv1 和 TLSv1.1 连接协议的版本（MySQL 8.0.26 和 MySQL 8.0.27）中，如果它们包含在tls_versionor
admin_tls_version
系统变量的值中，并且如果客户端使用它们成功连接。如果您在运行时设置已弃用的协议并使用ALTER
INSTANCE RELOAD TLS语句实现它们，也会返回警告。客户端，包括为连接到源服务器指定 TLS 协议的副本和为分布式恢复连接指定 TLS 协议的组复制组成员，如果它们被配置为允许弃用的 TLS 协议，则不会发出警告。
有关详细信息，请参阅
MySQL 8.0 是否支持 TLS 1.0 和 1.1？
连接 TLS 协议配置
在服务器端，
tls_version系统变量的值决定了 MySQL 服务器允许哪些 TLS 协议进行加密连接。该
tls_version值适用于来自客户端的连接、此服务器实例为源的常规源/副本复制连接、组复制组通信连接以及此服务器实例为施主的组复制分布式恢复连接。管理连接接口的配置类似，但使用
admin_tls_version系统变量（请参阅
第 5.1.12.2 节，“管理连接管理”）。此讨论也适用于
admin_tls_version。
该tls_version值是一个或多个以逗号分隔的 TLS 协议版本的列表，不区分大小写。默认情况下，此变量列出用于编译 MySQL 的 SSL 库和 MySQL 服务器版本支持的所有协议。因此，默认设置如表 6.14，“MySQL 服务器 TLS 协议默认设置”所示。
表 6.14 MySQL 服务器 TLS 协议默认设置
MySQL 服务器版本
tls_version默认设置
MySQL 8.0.15 及以下版本
TLSv1,TLSv1.1,TLSv1.2
MySQL 8.0.16 和 MySQL 8.0.17
TLSv1,TLSv1.1,TLSv1.2,TLSv1.3 (with OpenSSL
1.1.1)
TLSv1,TLSv1.1,TLSv1.2 (otherwise)
组复制不支持 TLSv1.3
MySQL 8.0.18 到 MySQL 8.0.25
TLSv1,TLSv1.1,TLSv1.2,TLSv1.3 (with OpenSSL
1.1.1)
TLSv1,TLSv1.1,TLSv1.2 (otherwise)
Group Replication 支持 TLSv1.3
MySQL 8.0.26 和 MySQL 8.0.27
TLSv1,TLSv1.1,TLSv1.2,TLSv1.3 (with OpenSSL
1.1.1)
TLSv1,TLSv1.1,TLSv1.2 (otherwise)
TLSv1 和 TLSv1.1 已弃用
MySQL 8.0.28 及以上版本
TLSv1.2,TLSv1.3
要在运行时确定 的值
tls_version，请使用以下语句：
mysql> SHOW GLOBAL VARIABLES LIKE 'tls_version';
+---------------+-----------------------+
| Variable_name | Value                 |
+---------------+-----------------------+
| tls_version   | TLSv1.2,TLSv1.3       |
+---------------+-----------------------+
要更改 的值
tls_version，请在服务器启动时设置它。例如，要允许使用 TLSv1.2 或 TLSv1.3 协议的连接，但禁止使用不太安全的 TLSv1 和 TLSv1.1 协议的连接，请在服务器my.cnf文件中使用以下行：
[mysqld]
tls_version=TLSv1.2,TLSv1.3
要更加严格并仅允许 TLSv1.3 连接，请tls_version像这样设置：
[mysqld]
tls_version=TLSv1.3
从 MySQL 8.0.16 开始，tls_version可以在运行时更改。请参阅
服务器端运行时配置和监控加密连接。
在客户端，该
--tls-version选项指定客户端程序允许哪些 TLS 协议连接到服务器。选项值的格式与tls_version前面描述的系统变量相同（一个或多个逗号分隔的协议版本的列表）。
对于此服务器实例是副本的源/副本复制连接，
SOURCE_TLS_VERSION|
语句（来自 MySQL 8.0.23）或语句（MySQL 8.0.23 之前）MASTER_TLS_VERSION的选项
指定副本允许哪些 TLS 协议连接到源。选项值的格式与前面描述的系统变量的格式相同
。请参阅
第 17.3.1 节，“设置复制以使用加密连接”。
CHANGE REPLICATION SOURCE TOCHANGE
MASTER TOtls_versionSOURCE_TLS_VERSION|
可以指定的协议
MASTER_TLS_VERSION依赖于 SSL 库。tls_version此选项独立于服务器值且不受其影响
。例如，充当副本的服务器可以配置
tls_version为 TLSv1.3 以仅允许使用 TLSv1.3 的传入连接，但也可以配置SOURCE_TLS_VERSION|
MASTER_TLS_VERSION设置为 TLSv1.2 以仅允许 TLSv1.2 用于到源的传出副本连接。
对于组复制分布式恢复连接，其中此服务器实例是启动分布式恢复的加入成员（即客户端），
group_replication_recovery_tls_version
系统变量指定客户端允许哪些协议。同样，此选项独立于服务器值且不受其影响，
tls_version当此服务器实例是捐赠者时适用。组复制服务器通常在其组成员身份期间作为捐赠者和加入成员参与分布式恢复，因此应设置这两个系统变量。请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”。
TLS 协议配置会影响给定连接使用的协议，如
连接 TLS 协议协商中所述。
应选择允许的协议，例如不要在列表中留下
“漏洞”。例如，这些服务器配置值没有漏洞：
tls_version=TLSv1,TLSv1.1,TLSv1.2,TLSv1.3
tls_version=TLSv1.1,TLSv1.2,TLSv1.3
tls_version=TLSv1.2,TLSv1.3
tls_version=TLSv1.3
这些值确实有漏洞，不应使用：
tls_version=TLSv1,TLSv1.2       (TLSv1.1 is missing)
tls_version=TLSv1.1,TLSv1.3     (TLSv1.2 is missing)
对空洞的禁止也适用于其他配置上下文，例如客户端或副本。
除非您打算禁用加密连接，否则允许的协议列表不应为空。如果将 TLS 版本参数设置为空字符串，则无法建立加密连接：
tls_version: 服务器不允许加密传入连接。
--tls-version：客户端不允许到服务器的加密传出连接。
SOURCE_TLS_VERSION|
MASTER_TLS_VERSION：副本不允许到源的加密传出连接。
group_replication_recovery_tls_version：加入成员不允许加密连接到分布式恢复连接。
连接密码配置
一组默认密码适用于加密连接，可以通过显式配置允许的密码来覆盖它。在连接建立期间，连接的双方必须允许一些共同的密码，否则连接失败。在双方通用的允许密码中，SSL 库选择所提供证书支持的具有最高优先级的密码。
要指定适用于使用 TLS 协议直至 TLSv1.2 的加密连接的一个或多个密码：
在服务器端设置ssl_cipher系统变量，并使用
--ssl-cipher客户端程序的选项。
对于常规源/副本复制连接，此服务器实例是源，设置
ssl_cipher系统变量。如果此服务器实例是副本，请使用
SOURCE_SSL_CIPHER|
语句（来自 MySQL 8.0.23）或语句（MySQL 8.0.23 之前）MASTER_SSL_CIPHER的选项
。请参阅
第 17.3.1 节，“设置复制以使用加密连接”。
CHANGE REPLICATION SOURCE TOCHANGE
MASTER TO
对于 Group Replication 组成员，对于 Group Replication 组通信连接以及此服务器实例是 donor 的 Group Replication 分布式恢复连接，设置
ssl_cipher系统变量。对于此服务器实例是加入成员的组复制分布式恢复连接，请使用
group_replication_recovery_ssl_cipher
系统变量。请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”。
对于使用 TLSv1.3 的加密连接，OpenSSL 1.1.1 及更高版本支持以下密码套件，其中前三个默认启用：
TLS_AES_128_GCM_SHA256
TLS_AES_256_GCM_SHA384
TLS_CHACHA20_POLY1305_SHA256
TLS_AES_128_CCM_SHA256
TLS_AES_128_CCM_8_SHA256
要显式配置允许的 TLSv1.3 密码套件，请设置以下参数。在每种情况下，配置值都是零个或多个以冒号分隔的密码套件名称的列表。
在服务器端，使用
tls_ciphersuites系统变量。如果未设置此变量，则其默认值为
NULL，这意味着服务器允许默认的密码套件集。如果该变量设置为空字符串，则不会启用任何密码套件，并且无法建立加密连接。
在客户端，使用该
--tls-ciphersuites选项。如果未设置此选项，则客户端允许使用默认的密码套件集。如果该选项设置为空字符串，则不会启用任何密码套件，并且无法建立加密连接。
对于常规源/副本复制连接，此服务器实例是源，请使用
tls_ciphersuites系统变量。如果此服务器实例是副本，请使用
SOURCE_TLS_CIPHERSUITES|
语句（来自 MySQL 8.0.23）或语句（MySQL 8.0.23 之前）MASTER_TLS_CIPHERSUITES的选项
。请参阅
第 17.3.1 节，“设置复制以使用加密连接”。
CHANGE REPLICATION SOURCE TOCHANGE
MASTER TO
对于 Group Replication 组成员，对于 Group Replication 组通信连接以及此服务器实例是施主的 Group Replication 分布式恢复连接，请使用
tls_ciphersuites系统变量。对于此服务器实例是加入成员的组复制分布式恢复连接，请使用
group_replication_recovery_tls_ciphersuites
系统变量。请参阅
第 18.6.2 节，“使用安全套接字层 (SSL) 保护组通信连接”。
笔记
Ciphersuite 支持从 MySQL 8.0.16 开始可用，但要求 MySQL 服务器和客户端应用程序都使用 OpenSSL 1.1.1 或更高版本进行编译。
在 MySQL 8.0.16 到 8.0.18 中，
group_replication_recovery_tls_ciphersuites
系统变量和
SOURCE_TLS_CIPHERSUITES|
MASTER_TLS_CIPHERSUITES语句的选项
CHANGE REPLICATION SOURCE TO
（来自 MySQL 8.0.23）或CHANGE
MASTER TO语句（MySQL 8.0.23 之前）不可用。在这些版本中，如果 TLSv1.3 用于源/副本复制连接，或用于分布式恢复的组复制（从 MySQL 8.0.18 支持），则复制源或组复制捐赠者服务器必须允许使用至少一个 TLSv1 .3 默认启用的密码套件。从 MySQL 8.0.19 开始，您可以使用选项为任何选择的密码套件配置客户端支持，如果需要，仅包括非默认密码套件。
给定的密​​码可能仅适用于特定的 TLS 协议，这会影响 TLS 协议协商过程。请参阅
连接 TLS 协议协商。
Ssl_cipher_list要确定给定服务器支持哪些密码，请检查状态变量
的会话值
：SHOW SESSION STATUS LIKE 'Ssl_cipher_list';
status 变量列出了可能的Ssl_cipher_listSSL 密码（对于非 SSL 连接为空）。如果 MySQL 支持 TLSv1.3，则该值包括可能的 TLSv1.3 密码套件。
笔记
ECDSA 密码只能与使用 ECDSA 进行数字签名的 SSL 证书结合使用，而不能与使用 RSA 的证书结合使用。MySQL Server 的 SSL 证书自动生成过程不会生成 ECDSA 签名证书，它只会生成 RSA 签名证书。除非您有可用的 ECDSA 证书，否则不要选择 ECDSA 密码。
对于使用 TLS.v1.3 的加密连接，MySQL 使用 SSL 库默认密码套件列表。
对于通过 TLSv1.2 使用 TLS 协议的加密连接，MySQL 将以下默认密码列表传递给 SSL 库。
ECDHE-ECDSA-AES128-GCM-SHA256
ECDHE-ECDSA-AES256-GCM-SHA384
ECDHE-RSA-AES128-GCM-SHA256
ECDHE-RSA-AES256-GCM-SHA384
ECDHE-ECDSA-AES128-SHA256
ECDHE-RSA-AES128-SHA256
ECDHE-ECDSA-AES256-SHA384
ECDHE-RSA-AES256-SHA384
DHE-RSA-AES128-GCM-SHA256
DHE-DSS-AES128-GCM-SHA256
DHE-RSA-AES128-SHA256
DHE-DSS-AES128-SHA256
DHE-DSS-AES256-GCM-SHA384
DHE-RSA-AES256-SHA256
DHE-DSS-AES256-SHA256
ECDHE-RSA-AES128-SHA
ECDHE-ECDSA-AES128-SHA
ECDHE-RSA-AES256-SHA
ECDHE-ECDSA-AES256-SHA
DHE-DSS-AES128-SHA
DHE-RSA-AES128-SHA
TLS_DHE_DSS_WITH_AES_256_CBC_SHA
DHE-RSA-AES256-SHA
AES128-GCM-SHA256
DH-DSS-AES128-GCM-SHA256
ECDH-ECDSA-AES128-GCM-SHA256
AES256-GCM-SHA384
DH-DSS-AES256-GCM-SHA384
ECDH-ECDSA-AES256-GCM-SHA384
AES128-SHA256
DH-DSS-AES128-SHA256
ECDH-ECDSA-AES128-SHA256
AES256-SHA256
DH-DSS-AES256-SHA256
ECDH-ECDSA-AES256-SHA384
AES128-SHA
DH-DSS-AES128-SHA
ECDH-ECDSA-AES128-SHA
AES256-SHA
DH-DSS-AES256-SHA
ECDH-ECDSA-AES256-SHA
DHE-RSA-AES256-GCM-SHA384
DH-RSA-AES128-GCM-SHA256
ECDH-RSA-AES128-GCM-SHA256
DH-RSA-AES256-GCM-SHA384
ECDH-RSA-AES256-GCM-SHA384
DH-RSA-AES128-SHA256
ECDH-RSA-AES128-SHA256
DH-RSA-AES256-SHA256
ECDH-RSA-AES256-SHA384
ECDHE-RSA-AES128-SHA
ECDHE-ECDSA-AES128-SHA
ECDHE-RSA-AES256-SHA
ECDHE-ECDSA-AES256-SHA
DHE-DSS-AES128-SHA
DHE-RSA-AES128-SHA
TLS_DHE_DSS_WITH_AES_256_CBC_SHA
DHE-RSA-AES256-SHA
AES128-SHA
DH-DSS-AES128-SHA
ECDH-ECDSA-AES128-SHA
AES256-SHA
DH-DSS-AES256-SHA
ECDH-ECDSA-AES256-SHA
DH-RSA-AES128-SHA
ECDH-RSA-AES128-SHA
DH-RSA-AES256-SHA
ECDH-RSA-AES256-SHA
DES-CBC3-SHA
这些密码限制已到位：
以下密码永久受限：
!DHE-DSS-DES-CBC3-SHA
!DHE-RSA-DES-CBC3-SHA
!ECDH-RSA-DES-CBC3-SHA
!ECDH-ECDSA-DES-CBC3-SHA
!ECDHE-RSA-DES-CBC3-SHA
!ECDHE-ECDSA-DES-CBC3-SHA
以下类别的密码受到永久限制：
!aNULL
!eNULL
!EXPORT
!LOW
!MD5
!DES
!RC2
!RC4
!PSK
!SSLv3
如果服务器启动时将
ssl_cert系统变量设置为使用上述任何受限密码或密码类别的证书，则服务器启动时会禁用对加密连接的支持。
连接 TLS 协议协商
MySQL 中的连接尝试协商使用双方可用的最高 TLS 协议版本，双方都可以使用协议兼容的加密密码。协商过程取决于用于编译服务器和客户端的 SSL 库、TLS 协议和加密密码配置以及使用的密钥大小等因素：
为使连接尝试成功，服务器和客户端 TLS 协议配置必须允许某些通用协议。
同样，服务器和客户端加密密码配置必须允许一些共同的密码。给定的密​​码可能只适用于特定的 TLS 协议，因此除非也有兼容的密码，否则不会选择可用于协商过程的协议。
如果 TLSv1.3 可用，则尽可能使用它。（这意味着服务器和客户端配置都必须允许 TLSv1.3，并且都必须允许一些与 TLSv1.3 兼容的加密密码。）否则，MySQL 继续遍历可用协议列表，如果可能则使用 TLSv1.2，依此类推向前。协商从更安全的协议进行到更不安全的协议。协商顺序与配置协议的顺序无关。例如，无论是否
tls_version具有
TLSv1,TLSv1.1,TLSv1.2,TLSv1.3或
的值，协商顺序都是相同的TLSv1.3,TLSv1.2,TLSv1.1,TLSv1。
TLSv1.2 不适用于密钥大小为 512 位或更小的所有密码。要将此协议与此类密钥一起使用，请ssl_cipher在服务器端设置系统变量或使用
--ssl-cipher客户端选项明确指定密码名称：
AES128-SHA
AES128-SHA256
AES256-SHA
AES256-SHA256
CAMELLIA128-SHA
CAMELLIA256-SHA
DES-CBC3-SHA
DHE-RSA-AES256-SHA
RC4-MD5
RC4-SHA
SEED-SHA
为提高安全性，请使用 RSA 密钥大小至少为 2048 位的证书。
如果服务器和客户端没有共同的允许协议和共同的协议兼容密码，则服务器终止连接请求。例子：
如果服务器配置为
tls_version=TLSv1.1,TLSv1.2：
--tls-version=TLSv1对于使用 调用的客户端以及仅支持 TLSv1 的旧客户端，
连接尝试失败
。
同样，对于配置有MASTER_TLS_VERSION =
'TLSv1'的副本以及仅支持 TLSv1 的旧副本，连接尝试失败。
如果服务器配置有
tls_version=TLSv1或者是仅支持 TLSv1 的旧服务器：
使用 调用的客户端的连接尝试失败
--tls-version=TLSv1.1,TLSv1.2。
同样，对于配置有 的副本，连接尝试失败MASTER_TLS_VERSION =
'TLSv1.1,TLSv1.2'。
MySQL 允许指定要支持的协议列表。该列表直接向下传递到底层 SSL 库，并最终由该库决定它从提供的列表中实际启用了哪些协议。请参阅 MySQL 源代码和 OpenSSL
SSL_CTX_new()
文档，了解有关 SSL 库如何处理此问题的信息。
监控当前客户端会话 TLS 协议和密码
要确定当前客户端会话使用哪种加密 TLS 协议和密码，请检查
Ssl_version和
Ssl_cipher状态变量的会话值：
mysql> SELECT * FROM performance_schema.session_status
WHERE VARIABLE_NAME IN ('Ssl_version','Ssl_cipher');
+---------------+---------------------------+
| VARIABLE_NAME | VARIABLE_VALUE            |
+---------------+---------------------------+
| Ssl_cipher    | DHE-RSA-AES128-GCM-SHA256 |
| Ssl_version   | TLSv1.2                   |
+---------------+---------------------------+
如果连接未加密，则两个变量都为空值。
© Mysql 中文网
