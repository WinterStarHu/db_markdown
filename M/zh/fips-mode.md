# 6.8 FIPS 支持_MySQL 8.0 参考手册

6.8 FIPS 支持_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 6 章 安全  /
6.8 FIPS 支持
6.8 FIPS 支持
如果使用 OpenSSL 1.0.2 编译，MySQL 支持 FIPS 模式，并且 OpenSSL 库和 FIPS 对象模块在运行时可用。
服务器端的 FIPS 模式适用于服务器执行的加密操作。这包括在服务器内运行的复制（源/副本和组复制）和 X 插件。FIPS 模式也适用于客户端连接到服务器的尝试。
以下部分描述了 FIPS 模式以及如何在 MySQL 中利用它：
FIPS 概述MySQL 中 FIPS 模式的系统要求在 MySQL 中配置 FIPS 模式
FIPS 概述
联邦信息处理标准 140-2 (FIPS 140-2) 描述了联邦（美国政府）机构可能要求的用于保护敏感或有价值信息的加密模块的安全标准。要被视为可接受的此类联邦用途，加密模块必须通过 FIPS 140-2 认证。如果旨在保护敏感数据的系统缺少适当的 FIPS 140-2 证书，联邦机构将无法购买。
OpenSSL 等产品可在 FIPS 模式下使用，尽管 OpenSSL 库本身未针对 FIPS 进行验证。相反，OpenSSL 库与 OpenSSL FIPS 对象模块一起使用，以使基于 OpenSSL 的应用程序能够在 FIPS 模式下运行。
有关 FIPS 及其在 OpenSSL 中的实现的一般信息，这些参考资料可能会有所帮助：
美国国家标准技术研究院 FIPS PUB 140-2
OpenSSL FIPS 140-2 安全策略
OpenSSL FIPS 对象模块 v2.0 用户指南
重要的
FIPS 模式对加密操作施加条件，例如对可接受的加密算法的限制或对更长密钥长度的要求。对于 OpenSSL，确切的 FIPS 行为取决于 OpenSSL 版本。有关详细信息，请参阅 OpenSSL FIPS 用户指南。
MySQL 中 FIPS 模式的系统要求
要使 MySQL 支持 FIPS 模式，必须满足以下系统要求：
在构建时，MySQL 必须使用 OpenSSL 进行编译。如果编译使用不同于 OpenSSL 的 SSL 库，则不能在 MySQL 中使用 FIPS 模式。
此外，MySQL 必须使用经认证可用于 FIPS 的 OpenSSL 版本进行编译。OpenSSL 1.0.2 已通过认证，但 OpenSSL 1.1.1 未通过认证。最新版本的 MySQL 的二进制分发版是在某些平台上使用 OpenSSL 1.1.1 编译的，这意味着它们未通过 FIPS 认证。根据系统和 MySQL 配置，这会导致可用 MySQL 功能的权衡：
使用具有 OpenSSL 1.0.2 和所需 FIPS 对象模块的系统。在这种情况下，如果您使用使用 OpenSSL 1.0.2 编译的二进制分发版，或者使用 OpenSSL 1.0.2 从源代码编译 MySQL，则可以为 MySQL 启用 FIPS 模式。但是，在这种情况下，您不能使用 TLSv1.3 协议或密码套件（需要 OpenSSL 1.1.1）。此外，您使用的 OpenSSL 版本在 2019 年底达到了生命周期终止状态。
使用具有 OpenSSL 1.1.1 或更高版本的系统。在这种情况下，您可以使用二进制包安装 MySQL，并且可以使用 TLSv1.3 协议和密码套件，以及其他已经支持的 TLS 协议。但是，您不能为 MySQL 启用 FIPS 模式。
在运行时，OpenSSL 库和 OpenSSL FIPS 对象模块必须作为共享（动态链接）对象可用。可以构建静态链接的 OpenSSL 对象，但 MySQL 不能使用它们。
FIPS 模式已经在 EL7 上针对 MySQL 进行了测试，但也可能适用于其他系统。
如果您的平台或操作系统提供 OpenSSL FIPS 对象模块，您可以使用它。否则，您可以从源代码构建 OpenSSL 库和 FIPS 对象模块。使用 OpenSSL FIPS 用户指南中的说明（请参阅
FIPS 概述）。
在 MySQL 中配置 FIPS 模式
MySQL 在服务器端和客户端启用 FIPS 模式控制：
系统ssl_fips_mode变量控制服务器是否以 FIPS 模式运行。
client 选项控制给定的--ssl-fips-modeMySQL 客户端是否以 FIPS 模式运行。
系统ssl_fips_mode变量和--ssl-fips-mode
客户端选项允许这些值：
OFF: 禁用 FIPS 模式。
ON：启用 FIPS 模式。
STRICT：启用“严格” FIPS 模式。
在服务器端，数值
ssl_fips_mode0、1、2分别相当于OFF、
ON、STRICT。
重要的
通常，STRICT比 强加更多的限制ON，但 MySQL 本身除了向 OpenSSL 指定 FIPS 模式值外没有特定于 FIPS 的代码。FIPS 模式的确切行为
ON或STRICT取决于 OpenSSL 版本。有关详细信息，请参阅 OpenSSL FIPS 用户指南（请参阅FIPS 概述）。
笔记
如果 OpenSSL FIPS 对象模块不可用，则
ssl_fips_mode和
的唯一允许值--ssl-fips-mode是
OFF. 尝试将 FIPS 模式设置为不同的值时会发生错误。
服务器端的 FIPS 模式适用于服务器执行的加密操作。这包括在服务器内运行的复制（源/副本和组复制）和 X 插件。
FIPS 模式也适用于客户端连接到服务器的尝试。启用后，在客户端或服务器端，它会限制可以选择哪些受支持的加密密码。但是，启用 FIPS 模式并不要求必须使用加密连接或必须加密用户凭据。例如，如果启用 FIPS 模式，则需要更强的加密算法。特别是，MD5 受到限制，因此尝试使用加密密码建立加密连接是RC4-MD5行不通的。但是 FIPS 模式并没有阻止建立未加密的连接。（为此，您可以使用REQUIRE子句 for
CREATE USERor
ALTER USER对于特定用户帐户，或设置
require_secure_transport系统变量以影响所有帐户。）
© Mysql 中文网
