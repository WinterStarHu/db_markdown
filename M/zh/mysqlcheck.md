# 4.5.3 mysqlcheck——表维护程序_MySQL 8.0 参考手册

4.5.3 mysqlcheck——表维护程序_MySQL 8.0 参考手册
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
4.5.1 mysql——MySQL 命令行客户端1
4.5.2 mysqladmin——一个 MySQL 服务器管理程序1
4.5.3 mysqlcheck——表维护程序1
4.5.4 mysqldump——数据库备份程序1
4.5.5 mysqlimport——一个数据导入程序1
4.5.6 mysqlpump——数据库备份程序1
4.5.7 mysqlshow——显示数据库、表和列信息1
4.5.8 mysqlslap — 负载仿真客户端1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.5 客户端程序  /
4.5.3 mysqlcheck——表维护程序
4.5.3 mysqlcheck——表维护程序
mysqlcheck客户端执行表维护：它检查、修复、优化或分析表。
每个表都被锁定，因此在处理时对其他会话不可用，尽管对于检查操作，该表READ仅使用锁锁定（请参阅
第 13.3.6 节，“锁定表和解锁表语句”，了解更多信息
READ和WRITE锁）。表维护操作可能很耗时，尤其是对于大型表。如果您使用
--databasesor
--all-databases选项来处理一个或多个数据库中的所有表，则调用
mysqlcheck可能需要很长时间。（对于 MySQL 升级过程也是如此，如果它确定需要进行表检查，因为它以相同的方式处理表。）
mysqld服务器运行时必须使用
mysqlcheck，这意味着您不必停止服务器来执行表维护。
mysqlcheck以方便用户的方式使用 SQL 语句
CHECK TABLE,
REPAIR TABLE,
ANALYZE TABLE, 和
OPTIMIZE TABLE它确定要执行的操作要使用哪些语句，然后将语句发送到要执行的服务器。有关每个语句使用哪些存储引擎的详细信息，请参阅
第 13.7.3 节，“表维护语句”。
所有的存储引擎都不一定支持所有四种维护操作。在这种情况下，会显示一条错误消息。例如，如果test.t是一个
MEMORY表，尝试检查它会产生以下结果：
$> mysqlcheck test t
test.t
note     : The storage engine for the table doesn't support check
如果mysqlcheck无法修复表，请参阅第 2.11.13 节，“重建或修复表或索引”以了解手动表修复策略。例如，对于
InnoDB可以使用 进行检查
CHECK TABLE但不能使用 进行修复的表，情况就是如此REPAIR TABLE。
警告
最好在执行表修复操作之前对表进行备份；在某些情况下，该操作可能会导致数据丢失。可能的原因包括但不限于文件系统错误。
调用mysqlcheck
的一般方法有以下三种
：
mysqlcheck [options] db_name [tbl_name ...]
mysqlcheck [options] --databases db_name ...
mysqlcheck [options] --all-databases
如果您没有在后面命名任何表，
db_name或者如果您使用
--databases或
--all-databases选项，则会检查整个数据库。
与其他客户端程序相比， mysqlcheck有一个特殊的功能。检查表 (--check) 的默认行为可以通过重命名二进制文件来更改。如果你想要一个默认修复表的工具，你应该只制作一个
名为
mysqlrepair的mysqlcheck的副本，或者创建一个名为
mysqlrepair的mysqlcheck的符号链接
。如果您调用
mysqlrepair，它会修复表。
下表中显示的名称可用于更改
mysqlcheck默认行为。
命令
意义
mysql修复
默认选项是--repair
mysql分析
默认选项是--analyze
mysql优化
默认选项是--optimize
mysqlcheck支持以下选项，可以在命令行或
选项文件的组中指定[mysqlcheck]。[client]有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。
表 4.13 mysqlcheck 选项
选项名称
描述
介绍
弃用
--所有数据库
检查所有数据库中的所有表
--多合一
为每个数据库执行一条语句，命名该数据库中的所有表
- 分析
分析表
- 自动修理
如果已检查的表已损坏，则自动修复它
--绑定地址
使用指定的网络接口连接到 MySQL 服务器
--字符集目录
安装字符集的目录
- 查看
检查表格是否有错误
--check-only-changed
仅检查自上次检查以来更改过的表
--检查升级
使用 FOR UPGRADE 选项调用 CHECK TABLE
- 压缩
压缩客户端和服务器之间发送的所有信息
8.0.18
--压缩算法
允许的服务器连接压缩算法
8.0.18
--数据库
将所有参数解释为数据库名称
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
--启用明文插件
启用明文身份验证插件
--扩展
检查和修理桌子
- 快速地
只检查没有正确关闭的表
- 力量
即使出现 SQL 错误也继续
--get-server-public-key
从服务器请求 RSA 公钥
- 帮助
显示帮助信息并退出
- 主持人
MySQL 服务器所在的主机
--登录路径
从 .mylogin.cnf 读取登录路径选项
--medium-check
执行比 --extended 操作更快的检查
--no-defaults
不读取选项文件
--优化
优化表
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
--print-defaults
打印默认选项
- 协议
使用的传输协议
- 快的
最快的检查方法
- 修理
执行修复几乎可以修复任何东西，除了不唯一的唯一键
--server-public-key-path
包含 RSA 公钥的文件的路径名
--shared-memory-base-name
共享内存连接的共享内存名称（仅限 Windows）
- 沉默的
静音模式
--跳过数据库
从执行的操作中省略此数据库
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
--表格
覆盖 --databases 或 -B 选项
--tls-密码套件
用于加密连接的允许的 TLSv1.3 密码套件
8.0.16
--tls-版本
加密连接允许的 TLS 协议
--use-frm
用于 MyISAM 表的修复操作
- 用户
连接到服务器时使用的 MySQL 用户名
--冗长
详细模式
- 版本
显示版本信息并退出
--write-binlog
将 ANALYZE、OPTIMIZE、REPAIR 语句记录到二进制日志中。--skip-write-binlog 将 NO_WRITE_TO_BINLOG 添加到这些语句中
--zstd-压缩级别
使用 zstd 压缩的服务器连接的压缩级别
8.0.18
--help,
-?
显示帮助信息并退出。
--all-databases,
-A
检查所有数据库中的所有表。这与--databases在命令行中使用选项和命名所有数据库相同，只是不检查INFORMATION_SCHEMA和
数据库。performance_schema可以通过使用选项明确命名它们来检查它们--databases。
--all-in-1,
-1
不是为每个表发出一条语句，而是为每个数据库执行一条语句，命名该数据库中要处理的所有表。
--analyze,
-a
分析表格。
--auto-repair
如果已检查的表已损坏，则自动修复它。检查完所有表格后，将进行任何必要的维修。
--bind-address=ip_address
在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
--character-sets-dir=dir_name
安装字符集的目录。请参阅
第 10.15 节，“字符集配置”。
--check,
-c
检查表格是否有错误。这是默认操作。
--check-only-changed,
-C
仅检查自上次检查后发生更改或未正确关闭的表。
--check-upgrade,
-g
调用选项CHECK TABLE以
FOR UPGRADE检查表是否与服务器的当前版本不兼容。
--compress
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
--databases,
-B
处理指定数据库中的所有表。通常，
mysqlcheck将命令行上的第一个名称参数视为数据库名称，并将任何后续名称视为表名。使用此选项，它将所有名称参数视为数据库名称。
--debug[=debug_options],
-#
[debug_options]
写调试日志。典型的
debug_options字符串是
. 默认值为。
d:t:o,file_named:t:o
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--debug-check
程序退出时打印一些调试信息。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--debug-info
程序退出时打印调试信息以及内存和 CPU 使用统计信息。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--default-character-set=charset_name
用作charset_name默认字符集。请参阅第 10.15 节，“字符集配置”。
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
mysqlcheck通常读取
[client]和
[mysqlcheck]组。如果此选项作为 给出
--defaults-group-suffix=_other，
则 mysqlcheck还会读取
[client_other]和
[mysqlcheck_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--extended,
-e
如果您使用此选项来检查表，它可以确保它们 100% 一致但需要很长时间。
如果您使用此选项修复表，它会运行扩展修复，这不仅可能需要很长时间才能执行，而且还可能产生大量垃圾行！
--default-auth=plugin
关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
--enable-cleartext-plugin
启用mysql_clear_password明文身份验证插件。（请参阅
第 6.4.1.4 节，“客户端明文可插入身份验证”。）
--fast,
-F
仅检查未正确关闭的表。
--force,
-f
即使出现 SQL 错误也继续。
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
--medium-check,
-m
进行比
--extended操作更快的检查。这只能找到所有错误的 99.99%，这在大多数情况下应该足够好了。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults可用于防止它们被读取。
例外情况是.mylogin.cnf
文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在
--no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--optimize,
-o
优化表格。
--password[=password],
-p[password]
用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出，
mysqlcheck会提示输入一个。如果给定，则后面
的密码之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlcheck不应提示输入密码，请使用该
--skip-password
选项。
--password1[=pass_val]
用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出，
mysqlcheck会提示输入一个。如果给定，则后面的密码和密码之间
不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlcheck不应提示输入密码，请使用该
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
--pipe,
-W
在 Windows 上，使用命名管道连接到服务器。仅当服务器启动时
named_pipe启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--plugin-dir=dir_name
在其中查找插件的目录。如果
--default-auth选项用于指定身份验证插件但
mysqlcheck未找到它，请指定此选项。请参阅
第 6.2.17 节，“可插入身份验证”。
--port=port_num,
-P port_num
对于 TCP/IP 连接，要使用的端口号。
--print-defaults
打印程序名称和它从选项文件中获取的所有选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--protocol={TCP|SOCKET|PIPE|MEMORY}
用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅
第 4.2.7 节“连接传输协议”。
--quick,
-q
如果您使用此选项检查表，它会阻止检查扫描行以检查不正确的链接。这是最快的检查方法。
如果您使用此选项修复表，它会尝试仅修复索引树。这是最快的修复方法。
--repair,
-r
执行修复几乎可以修复任何东西，除了不唯一的唯一键。
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
--silent,
-s
静音模式。仅打印错误消息。
--skip-database=db_name
不要在mysqlcheck
执行的操作中包括指定的数据库（区分大小写）。
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
--tables
覆盖--databases
or-B选项。选项后面的所有名称参数都被视为表名。
--tls-ciphersuites=ciphersuite_list
使用 TLSv1.3 的加密连接的允许密码套件。该值是一个或多个以冒号分隔的密码套件名称的列表。可以为此选项命名的密码套件取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
这个选项是在 MySQL 8.0.16 中添加的。
--tls-version=protocol_list
加密连接允许的 TLS 协议。该值是一个或多个以逗号分隔的协议名称的列表。可以为此选项命名的协议取决于用于编译 MySQL 的 SSL 库。有关详细信息，请参阅
第 6.3.2 节，“加密连接 TLS 协议和密码”。
--use-frm
对于MyISAM表的修复操作，从数据字典中获取表结构，这样即使表.MYI
头损坏也可以修复表。
--user=user_name,
-u user_name
用于连接到服务器的 MySQL 帐户的用户名。
--verbose,
-v
详细模式。打印有关程序运行各个阶段的信息。
--version,
-V
显示版本信息并退出。
--write-binlog
默认情况下启用此选项，以便将
mysqlcheck生成的 、 和 statementsANALYZE TABLE写入
OPTIMIZE TABLE二进制
日志。用于
导致添加到语句中，以便不记录它们。当使用
二进制日志从备份中恢复时，这些语句不应发送到副本或运行时使用。
REPAIR TABLE--skip-write-binlogNO_WRITE_TO_BINLOG--skip-write-binlog
--zstd-compression-level=level
用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
© Mysql 中文网
