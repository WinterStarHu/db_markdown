# 4.4.5 mysql_upgrade — 检查和升级 MySQL 表_MySQL 8.0 参考手册

4.4.5 mysql_upgrade — 检查和升级 MySQL 表_MySQL 8.0 参考手册
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
4.4.1 comp_err——编译MySQL错误信息文件1
4.4.2 mysql_secure_installation——提高MySQL安装安全性1
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件1
4.4.4 mysql_tzinfo_to_sql — 加载时区表1
4.4.5 mysql_upgrade — 检查和升级 MySQL 表1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.4 安装相关程序  /
4.4.5 mysql_upgrade — 检查和升级 MySQL 表
4.4.5 mysql_upgrade — 检查和升级 MySQL 表
笔记
从 MySQL 8.0.16 开始，MySQL 服务器执行以前由mysql_upgrade处理的升级任务
（有关详细信息，请参阅
第 2.11.3 节，“MySQL 升级过程升级的内容”）。因此，
不需要mysql_upgrade并且从该版本开始已弃用；希望在未来的 MySQL 版本中将其删除。因为mysql_upgrade不再执行升级任务，它无条件地以状态 0 退出。
每次升级 MySQL 时，都应该执行
mysql_upgrade，它会查找与升级后的 MySQL 服务器的不兼容性：
它升级
mysql模式中的系统表，以便您可以利用可能已添加的新特权或功能。
它升级了 Performance Schema
INFORMATION_SCHEMA、 和
sysschema。
它检查用户模式。
如果mysql_upgrade发现一个表可能不兼容，它会执行表检查，如果发现问题，则尝试修复表。如果表无法修复，请参阅第 2.11.13 节“重建或修复表或索引”以了解手动表修复策略。
mysql_upgrade直接与 MySQL 服务器通信，向其发送执行升级所需的 SQL 语句。
警告
在执行升级之前
，您应该始终备份当前的 MySQL 安装
。请参阅
第 7.2 节，“数据库备份方法”。
在升级 MySQL 安装和运行mysql_upgrade之前，
一些升级不兼容性可能需要特殊处理
。请参阅
第 2.11 节，“升级 MySQL”，以获取有关确定任何此类不兼容性是否适用于您的安装以及如何处理它们的说明。
像这样使用mysql_upgrade：
确保服务器正在运行。
调用mysql_upgrade升级schema中的系统表，mysql检查修复其他schema中的表：
mysql_upgrade [options]
停止服务器并重新启动它以使任何系统表更改生效。
如果您有多个 MySQL 服务器实例要升级，
请使用适合连接到每个所需服务器的连接参数调用mysql_upgrade 。例如，对于在 3306 到 3308 部分的本地主机上运行的服务器，通过连接到适当的端口来升级它们中的每一个：
mysql_upgrade --protocol=tcp -P 3306 [other_options]
mysql_upgrade --protocol=tcp -P 3307 [other_options]
mysql_upgrade --protocol=tcp -P 3308 [other_options]
对于 Unix 上的本地主机连接，该
--protocol=tcp选项强制使用 TCP/IP 而不是 Unix 套接字文件进行连接。
默认情况下，mysql_upgrade作为 MySQL
root用户运行。如果在root
运行
mysql_upgrade时密码已过期，它会显示一条消息，表明您的密码已过期，因此
mysql_upgrade失败。要更正此问题，请重置root密码以解除它的过期并再次运行mysql_upgrade。首先，连接到服务器root：
$> mysql -u root -p
Enter password: ****  <- enter root password here
使用以下方法重置密码ALTER
USER：
mysql> ALTER USER USER() IDENTIFIED BY 'root-password';
然后退出mysql，再次运行
mysql_upgrade：
$> mysql_upgrade [options]
笔记
如果您在
disabled_storage_engines
系统变量设置为禁用某些存储引擎（例如，MyISAM）的情况下运行服务器，
mysql_upgrade可能会失败并出现如下错误：
mysql_upgrade: [ERROR] 3161: Storage engine MyISAM is disabled
(Table creation is disallowed).
要处理此问题，请重新启动已
disabled_storage_engines
禁用的服务器。然后你应该能够成功运行
mysql_upgrade。之后，重新启动服务器
disabled_storage_engines并将其设置为原始值。
除非使用该
--upgrade-system-tables
选项调用，否则mysql_upgrade 会根据需要处理所有用户模式中的所有表。表检查可能需要很长时间才能完成。每个表都被锁定，因此在处理时对其他会话不可用。检查和修复操作可能很耗时，尤其是对于大型表。表检查使用语句的FOR UPGRADE选项。CHECK TABLE有关此选项的详细信息，请参阅
第 13.7.3.2 节，“CHECK TABLE 语句”。
mysql_upgrade用当前 MySQL 版本号标记所有检查和修复的表。这确保下次您使用相同版本的服务器运行mysql_upgrade时，可以确定是否需要再次检查或修复给定的表。
mysql_upgrade将 MySQL 版本号保存在mysql_upgrade_info数据目录中命名的文件中。这用于快速检查是否已检查此版本的所有表，以便可以跳过表检查。要忽略此文件并执行检查，请使用该--force选项。
笔记
该mysql_upgrade_info文件已弃用；希望在未来的 MySQL 版本中将其删除。
mysql_upgrade检查
mysql.user系统表行，并且对于任何具有空plugin列的行，'mysql_native_password'如果凭据使用与该插件兼容的哈希格式，则将该列设置为。具有 pre-4.1 密码哈希的行必须手动升级。
mysql_upgrade不升级时区表或帮助表的内容。有关升级说明，请参阅第 5.1.15 节，“MySQL 服务器时区支持”和
第 5.1.17 节，“服务器端帮助支持”。
除非使用该
--skip-sys-schema选项
调用，否则mysql_upgrade会安装
sys模式（如果未安装），否则将其升级到当前版本。sys如果模式存在但没有
视图，则会发生错误version，假设它的不存在表示用户创建的模式：
A sys schema exists with no sys.version view. If
you have a user created sys schema, this must be renamed for the
upgrade to succeed.
要在这种情况下升级，请先删除或重命名现有
sys架构。
mysql_upgrade支持以下选项，可以在命令行或
选项文件的组中指定[mysql_upgrade]。
[client]有关 MySQL 程序使用的选项文件的信息，请参阅
第 4.2.2.2 节，“使用选项文件”。
表 4.10 mysql_upgrade 选项
选项名称
描述
介绍
弃用
--绑定地址
使用指定的网络接口连接到 MySQL 服务器
--字符集目录
安装字符集的目录
- 压缩
压缩客户端和服务器之间发送的所有信息
8.0.18
--压缩算法
允许的服务器连接压缩算法
8.0.18
--调试
写调试日志
--调试检查
程序退出时打印调试信息
- 调试信息
程序退出时打印调试信息、内存和 CPU 统计信息
--default-auth
要使用的身份验证插件
--默认字符集
指定默认字符集
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
--defaults-group-suffix
选项组后缀值
- 力量
即使已经为当前 MySQL 版本执行了 mysql_upgrade，也强制执行
--get-server-public-key
从服务器请求 RSA 公钥
- 帮助
显示帮助信息并退出
- 主持人
MySQL 服务器所在的主机
--登录路径
从 .mylogin.cnf 读取登录路径选项
--最大允许数据包
发送到服务器或从服务器接收的最大数据包长度
--net-buffer-length
TCP/IP 和套接字通信的缓冲区大小
--no-defaults
不读取选项文件
- 密码
连接到服务器时使用的密码
- 管道
使用命名管道连接到服务器（仅限 Windows）
--插件目录
安装插件的目录
- 港口
用于连接的 TCP/IP 端口号
--print-defaults
打印默认选项
- 协议
使用的传输协议
--server-public-key-path
包含 RSA 公钥的文件的路径名
--shared-memory-base-name
共享内存连接的共享内存名称（仅限 Windows）
--skip-sys-schema
不要安装或升级 sys 架构
- 插座
要使用的 Unix 套接字文件或 Windows 命名管道
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
--升级系统表
只更新系统表，不更新用户模式
- 用户
连接到服务器时使用的 MySQL 用户名
--冗长
详细模式
--版本检查
检查正确的服务器版本
--write-binlog
将所有语句写入二进制日志
--zstd-压缩级别
使用 zstd 压缩的服务器连接的压缩级别
8.0.18
--help
显示一条简短的帮助消息并退出。
--bind-address=ip_address
在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
--character-sets-dir=dir_name
安装字符集的目录。请参阅
第 10.15 节，“字符集配置”。
--compress,
-C
如果可能，压缩客户端和服务器之间发送的所有信息。请参阅
第 4.2.8 节，“连接压缩控制”。
从 MySQL 8.0.18 开始，不推荐使用此选项。预计它会在 MySQL 的未来版本中被删除。请参阅
配置传统连接压缩。
--compression-algorithms=value
允许的连接到服务器的压缩算法。可用算法与
protocol_compression_algorithms
系统变量相同。默认值为
uncompressed。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
--debug[=debug_options],
-#
[debug_options]
写调试日志。典型的
debug_options字符串是
. 默认值为
。
d:t:o,file_named:t:O,/tmp/mysql_upgrade.trace
--debug-check
程序退出时打印一些调试信息。
--debug-info,
-T
程序退出时打印调试信息以及内存和 CPU 使用统计信息。
--default-auth=plugin
关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
--default-character-set=charset_name
用作charset_name默认字符集。请参阅第 10.15 节，“字符集配置”。
--defaults-extra-file=file_name
在全局选项文件之后但（在 Unix 上）在用户选项文件之前读取此选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-file=file_name
仅使用给定的选项文件。如果该文件不存在或无法访问，则会发生错误。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-group-suffix=str
不仅要阅读通常的选项组，还要阅读具有通常名称和后缀
str. 例如，
mysql_upgrade通常会读取
[client]和
[mysql_upgrade]组。如果此选项作为 给出
--defaults-group-suffix=_other，
mysql_upgrade还会读取
[client_other]和
[mysql_upgrade_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--force
mysql_upgrade_info即使已经为当前版本的 MySQL 执行了
mysql_upgrade ，也
忽略该文件并强制执行。
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
连接到给定主机上的 MySQL 服务器。
--login-path=name
从登录路径文件中指定的登录路径读取选项
.mylogin.cnf。“
登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--max-allowed-packet=value
客户端/服务器通信缓冲区的最大大小。默认值为 24MB。最小值和最大值分别为 4KB 和 2GB。
--net-buffer-length=value
客户端/服务器通信缓冲区的初始大小。默认值为 1MB − 1KB。最小值和最大值分别为 4KB 和 16MB。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults可用于防止它们被读取。
例外情况是.mylogin.cnf
文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在
--no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--password[=password],
-p[password]
用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出，
mysql_upgrade会提示输入一个。如果给定，则后面
的密码之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysql_upgrade不应提示输入密码，请使用该
--skip-password
选项。
--pipe,
-W
在 Windows 上，使用命名管道连接到服务器。仅当服务器启动时
named_pipe启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--plugin-dir=dir_name
在其中查找插件的目录。如果该
--default-auth选项用于指定身份验证插件但
mysql_upgrade未找到它，请指定此选项。请参阅
第 6.2.17 节，“可插入身份验证”。
--port=port_num,
-P port_num
对于 TCP/IP 连接，要使用的端口号。
--print-defaults
打印程序名称和它从选项文件中获取的所有选项。
--protocol={TCP|SOCKET|PIPE|MEMORY}
用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅
第 4.2.7 节“连接传输协议”。
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
--shared-memory-base-name=name
在 Windows 上，用于使用共享内存与本地服务器建立连接的共享内存名称。默认值为MYSQL。共享内存名称区分大小写。
仅当服务器启动时
shared_memory启用了支持共享内存连接的系统变量时，此选项才适用。
--skip-sys-schema
默认情况下，如果未安装模式，mysql_upgrade将安装
sys模式，否则将其升级到当前版本。该
--skip-sys-schema
选项会抑制此行为。
--socket=path,
-S path
对于与 的连接localhost，要使用的 Unix 套接字文件，或者在 Windows 上，要使用的命名管道的名称。
在 Windows 上，仅当服务器启动时named_pipe
启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--ssl*
以 开头的选项--ssl指定是否使用加密连接到服务器并指示在哪里可以找到 SSL 密钥和证书。请参阅
加密连接的命令选项。
--ssl-fips-mode={OFF|ON|STRICT}
控制是否在客户端启用 FIPS 模式。该
--ssl-fips-mode选项与其他
选项的不同之处在于它不用于建立加密连接，而是用于影响允许哪些加密操作。请参见第 6.8 节 “FIPS 支持”。
--ssl-xxx
这些--ssl-fips-mode
值是允许的：
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
--tls-ciphersuites=ciphersuite_list
使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
这个选项是在 MySQL 8.0.16 中添加的。
--tls-version=protocol_list
加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
--upgrade-system-tables,
-s
仅升级架构中的系统表
mysql，不升级用户架构。
--user=user_name,
-u user_name
用于连接到服务器的 MySQL 帐户的用户名。默认用户名为
root。
--verbose
详细模式。打印有关程序功能的更多信息。
--version-check,
-k
检查
mysql_upgrade连接到的服务器的版本以验证它与
mysql_upgrade构建的版本相同。如果不是，
mysql_upgrade退出。默认情况下启用此选项；要禁用检查，请使用
--skip-version-check.
--write-binlog
默认情况下，
禁用mysql_upgrade的二进制日志记录。--write-binlog如果您希望将其操作写入二进制日志，请
调用该程序
。
当服务器在启用全局事务标识符 (GTID) 的情况下运行时 ( gtid_mode=ON)，不要通过mysql_upgrade启用二进制日志记录。
--zstd-compression-level=level
用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
© Mysql 中文网
