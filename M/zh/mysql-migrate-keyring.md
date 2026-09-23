# 4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序_MySQL 8.0 参考手册

4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序_MySQL 8.0 参考手册
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
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
6.4.4.1 密钥环组件与密钥环插件
6.4.4.2 密钥环组件安装
6.4.4.3 密钥环插件安装
6.4.4.4 使用 component_keyring_file 基于文件的密钥环组件
6.4.4.5 使用 component_keyring_encrypted_file 加密文件密钥环组件
6.4.4.6 使用 keyring_file 基于文件的密钥环插件
6.4.4.7 使用 keyring_encrypted_file 加密文件密钥环插件
6.4.4.8 使用 keyring_okv KMIP 插件
6.4.4.9 使用 keyring_aws 亚马逊网络服务密钥环插件
6.4.4.10 使用 HashiCorp Vault 密钥环插件
6.4.4.11 使用 Oracle Cloud Infrastructure Vault 密钥环组件
6.4.4.12 使用 Oracle Cloud Infrastructure Vault Keyring 插件
6.4.4.13 支持的密钥环密钥类型和长度
6.4.4.14 在密钥环密钥库之间迁移密钥
6.4.4.15 通用密钥环密钥管理函数
6.4.4.16 插件特定的密钥环密钥管理函数
6.4.4.17 密钥环元数据
6.4.4.18 密钥环命令选项
6.4.4.19 密钥环系统变量
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序
mysql_migrate_keyring实用程序在一个密钥环组件和另一个密钥环组件之间迁移密钥。它支持离线和在线迁移。
像这样调用mysql_migrate_keyring（在一行中输入命令）：
mysql_migrate_keyring
--component-dir=dir_name
--source-keyring=name
--destination-keyring=name
[other options]
有关密钥迁移的信息和描述如何使用
mysql_migrate_keyring和其他方法执行它们的说明，请参阅
第 6.4.4.14 节，“在密钥环密钥库之间迁移密钥”。
mysql_migrate_keyring支持以下选项，可以在命令行或
[mysql_migrate_keyring]选项文件组中指定。有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。
表 4.21 mysql_migrate_keyring 选项
选项名称
描述
介绍
--组件目录
密钥环组件目录
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
--defaults-group-suffix
选项组后缀值
--目的地钥匙圈
目标密钥环组件名称
--destination-keyring-configuration-dir
目标密钥环组件配置目录
--get-server-public-key
从服务器请求 RSA 公钥
- 帮助
显示帮助信息并退出
- 主持人
MySQL 服务器所在的主机
--登录路径
从 .mylogin.cnf 读取登录路径选项
--no-defaults
不读取选项文件
--在线迁移
迁移源是活动服务器
- 密码
连接到服务器时使用的密码
- 港口
用于连接的 TCP/IP 端口号
--print-defaults
打印默认选项
--server-public-key-path
包含 RSA 公钥的文件的路径名
- 插座
要使用的 Unix 套接字文件或 Windows 命名管道
--源密钥环
源密钥环组件名称
--source-keyring-configuration-dir
源密钥环组件配置目录
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
--tls-版本
加密连接允许的 TLS 协议
- 用户
连接到服务器时使用的 MySQL 用户名
--冗长
详细模式
- 版本
显示版本信息并退出
--help,
-h
显示帮助信息并退出。
--component-dir=dir_name
密钥环组件所在的目录。这通常是
plugin_dir本地 MySQL 服务器的系统变量值。
笔记
--component-dir、
--source-keyring和
是mysql_migrate_keyring--destination-keyring
执行的所有密钥环迁移操作所必需的。此外，源组件和目标组件必须不同，并且两个组件都必须正确配置，以便mysql_migrate_keyring可以加载和使用它们。
--defaults-extra-file=file_name
在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-file=file_name
仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
例外：即使有
--defaults-file，客户端程序也会读取.mylogin.cnf.
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-group-suffix=str
不仅要阅读通常的选项组，还要阅读具有通常名称和后缀
str. 例如，
mysql_migrate_keyring通常会读取该
[mysql_migrate_keyring]组。如果此选项作为 给出
--defaults-group-suffix=_other，
mysql_migrate_keyring也会读取该
[mysql_migrate_keyring_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--destination-keyring=name
密钥迁移的目标密钥环组件。选项值的格式和解释与选项描述的相同
--source-keyring
。
笔记
--component-dir、
--source-keyring和
是mysql_migrate_keyring--destination-keyring
执行的所有密钥环迁移操作所必需的。此外，源组件和目标组件必须不同，并且两个组件都必须正确配置，以便mysql_migrate_keyring可以加载和使用它们。
--destination-keyring-configuration-dir=dir_name
此选项仅在目标密钥环组件全局配置文件包含
时适用"read_local_config": true，表示组件配置包含在本地配置文件中。选项值指定包含该本地文件的目录。
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
--host=host_name,
-h host_name
当前正在使用密钥迁移密钥库之一的正在运行的服务器的主机位置。迁移始终发生在本地主机上，因此该选项始终指定连接到本地服务器的值，例如
localhost、127.0.0.1、
::1或本地主机 IP 地址或主机名。
--login-path=name
从登录路径文件中指定的登录路径读取选项
.mylogin.cnf。“
登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults
可用于防止它们被读取。
例外情况是.mylogin.cnf
文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在
--no-defaults
使用 时也是如此。要创建.mylogin.cnf，请使用mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--online-migration
当正在运行的服务器使用密钥环时，此选项是必需的。它告诉mysql_migrate_keyring
执行在线密钥迁移。该选项具有以下效果：
mysql_migrate_keyring使用指定的任何连接选项连接到服务器；这些选项将被忽略。
mysql_migrate_keyring连接到服务器后，它告诉服务器暂停密钥环操作。当密钥复制完成时，
mysql_migrate_keyring告诉服务器它可以在断开连接之前恢复密钥环操作。
--password[=password],
-p[password]
用于连接到当前正在使用密钥迁移密钥库之一的正在运行的服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出，mysql_migrate_keyring会提示输入一个。如果给定，则后面
的密码
之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysql_migrate_keyring不应提示输入密码，请使用该
--skip-password
选项。
--port=port_num,
-P port_num
对于 TCP/IP 连接，用于连接到当前正在使用其中一个密钥迁移密钥库的正在运行的服务器的端口号。
--print-defaults
打印程序名称和它从选项文件中获取的所有选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--server-public-key-path=file_name
PEM 格式文件的路径名，其中包含服务器所需的公钥客户端副本，用于基于 RSA 密钥对的密码交换。此选项适用于使用
sha256_password或
caching_sha2_password身份验证插件进行身份验证的客户端。对于未使用其中一个插件进行身份验证的帐户，将忽略此选项。如果不使用基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
如果
给出并指定一个有效的公钥文件，它优先于
.
--server-public-key-path=file_name--get-server-public-key
对于sha256_password，此选项仅适用于使用 OpenSSL 构建 MySQL 的情况。
有关sha256_password
和caching_sha2_password插件的信息，请参阅
第 6.4.1.3 节，“SHA-256 可插入身份验证”和
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。
--socket=path,
-S path
对于 Unix 套接字文件或 Windows 命名管道连接，用于连接到当前正在使用密钥迁移密钥库之一的正在运行的服务器的套接字文件或命名管道。
在 Windows 上，仅当服务器启动时named_pipe
启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--source-keyring=name
用于密钥迁移的源密钥环组件。这是指定的组件库文件名，没有任何特定于平台的扩展名，例如.so
或.dll. 例如，要使用库文件为 的组件
component_keyring_file.so，请将选项指定为
--source-keyring=component_keyring_file。
笔记
--component-dir、
--source-keyring和
是mysql_migrate_keyring--destination-keyring
执行的所有密钥环迁移操作所必需的。此外，源组件和目标组件必须不同，并且两个组件都必须正确配置，以便mysql_migrate_keyring可以加载和使用它们。
--source-keyring-configuration-dir=dir_name
该选项仅在源密钥环组件全局配置文件包含
时适用"read_local_config": true，表示组件配置包含在本地配置文件中。选项值指定包含该本地文件的目录。
--ssl*
以 开头的选项--ssl指定是否使用加密连接到服务器并指示在哪里可以找到 SSL 密钥和证书。请参阅
加密连接的命令选项。
--ssl-fips-mode={OFF|ON|STRICT}
控制是否在客户端启用 FIPS 模式。该
--ssl-fips-mode
选项与其他
选项的不同之处在于它不用于建立加密连接，而是用于影响允许哪些加密操作。请参见第 6.8 节 “FIPS 支持”。
--ssl-xxx
这些
--ssl-fips-mode
值是允许的：
OFF: 禁用 FIPS 模式。
ON：启用 FIPS 模式。
STRICT：启用“严格”
FIPS 模式。
笔记
如果 OpenSSL FIPS 对象模块不可用，则唯一允许的
--ssl-fips-mode
值为OFF. 在这种情况下，设置
--ssl-fips-mode
为ON或STRICT
会导致客户端在启动时发出警告并在非 FIPS 模式下运行。
--tls-ciphersuites=ciphersuite_list
使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
--tls-version=protocol_list
加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
--user=user_name,
-u user_name
用于连接到当前正在使用密钥迁移密钥库之一的正在运行的服务器的 MySQL 帐户的用户名。
--verbose,
-v
详细模式。产生更多关于程序做什么的输出。
--version,
-V
显示版本信息并退出。
© Mysql 中文网
