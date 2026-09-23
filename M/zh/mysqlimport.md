# 4.5.5 mysqlimport——一个数据导入程序_MySQL 8.0 参考手册

4.5.5 mysqlimport——一个数据导入程序_MySQL 8.0 参考手册
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
4.5.5 mysqlimport——一个数据导入程序
4.5.5 mysqlimport——一个数据导入程序
mysqlimportLOAD
DATA客户端为SQL 语句
提供命令行界面。mysqlimport的大多数选项
直接对应于
LOAD DATA语法子句。请参阅
第 13.2.7 节，“加载数据语句”。
像这样调用mysqlimport：
mysqlimport [options] db_name textfile1 [textfile2 ...]
对于在命令行上命名的每个文本文件，
mysqlimport从文件名中去除任何扩展名，并使用结果来确定要将文件内容导入到其中的表的名称。例如，名为patient.txt、
patient.text和
patientall 的文件将导入到名为 的表中patient。
mysqlimport支持以下选项，可以在命令行或
选项文件的组中指定[mysqlimport]。[client]有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。
表 4.15 mysqlimport 选项
选项名称
描述
介绍
弃用
--绑定地址
使用指定的网络接口连接到 MySQL 服务器
- 列
此选项将以逗号分隔的列名列表作为其值
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
- 删除
在导入文本文件之前清空表格
--启用明文插件
启用明文身份验证插件
--fields-enclosed-by
此选项与 LOAD DATA 的相应子句含义相同
--fields-escaped-by
此选项与 LOAD DATA 的相应子句含义相同
--fields-optionally-enclosed-by
此选项与 LOAD DATA 的相应子句含义相同
--fields-terminated-by
此选项与 LOAD DATA 的相应子句含义相同
- 力量
即使出现 SQL 错误也继续
--get-server-public-key
从服务器请求 RSA 公钥
- 帮助
显示帮助信息并退出
- 主持人
MySQL 服务器所在的主机
- 忽视
请参阅 --replace 选项的说明
--忽略行
忽略数据文件的前 N ​​行
--lines-terminated-by
此选项与 LOAD DATA 的相应子句含义相同
- 当地的
从客户端主机本地读取输入文件
--锁表
在处理任何文本文件之前锁定所有表以进行写入
--登录路径
从 .mylogin.cnf 读取登录路径选项
- 低优先级
加载表时使用 LOW_PRIORITY
--no-defaults
不读取选项文件
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
- 代替
--replace 和 --ignore 选项控制在唯一键值上复制现有行的输入行的处理
--server-public-key-path
包含 RSA 公钥的文件的路径名
--shared-memory-base-name
共享内存连接的共享内存名称（仅限 Windows）
- 沉默的
仅在发生错误时产生输出
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
--使用线程
并行文件加载的线程数
- 用户
连接到服务器时使用的 MySQL 用户名
--冗长
详细模式
- 版本
显示版本信息并退出
--zstd-压缩级别
使用 zstd 压缩的服务器连接的压缩级别
8.0.18
--help,
-?
显示帮助信息并退出。
--bind-address=ip_address
在具有多个网络接口的计算机上，使用此选项来选择用于连接到 MySQL 服务器的接口。
--character-sets-dir=dir_name
安装字符集的目录。请参阅
第 10.15 节，“字符集配置”。
--columns=column_list,
-c column_list
此选项将逗号分隔的列名列表作为其值。列名的顺序指示如何将数据文件列与表列匹配。
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
--default-auth=plugin
关于使用哪个客户端身份验证插件的提示。请参阅第 6.2.17 节，“可插入身份验证”。
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
mysqlimport通常读取
[client]和
[mysqlimport]组。如果此选项作为 给出
--defaults-group-suffix=_other，
则mysqlimport还会读取
[client_other]和
[mysqlimport_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--delete,
-D
在导入文本文件之前清空表格。
--enable-cleartext-plugin
启用mysql_clear_password明文身份验证插件。（请参阅
第 6.4.1.4 节，“客户端明文可插入身份验证”。）
--fields-terminated-by=...,
--fields-enclosed-by=...,
--fields-optionally-enclosed-by=...,
--fields-escaped-by=...
这些选项与 的相应子句具有相同的含义LOAD DATA。请参阅
第 13.2.7 节，“加载数据语句”。
--force,
-f
忽略错误。例如，如果文本文件的表不存在，则继续处理任何剩余的文件。没有
，如果表不存在
--force，
mysqlimport将退出。
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
将数据导入给定主机上的 MySQL 服务器。默认主机是localhost.
--ignore,
-i
请参阅
--replace选项的说明。
--ignore-lines=N
忽略数据文件的第一N行。
--lines-terminated-by=...
此选项与 的相应子句具有相同的含义LOAD DATA。例如，要导入行以回车符/换行符对结尾的 Windows 文件，请使用
--lines-terminated-by="\r\n". （您可能必须将反斜杠加倍，具体取决于您的命令解释器的转义约定。）请参阅
第 13.2.7 节，“加载数据语句”。
--local,
-L
默认情况下，文件由服务器主机上的服务器读取。使用此选项，mysqlimport在客户端主机上本地读取输入文件。
在mysqlimport
中成功使用LOCAL加载操作还需要服务器允许本地加载；参见
第 6.1.6 节，“LOAD DATA LOCAL 的安全注意事项”
--lock-tables,
-l
在处理任何文本文件之前锁定所有用于写入的表。这确保所有表在服务器上同步。
--login-path=name
从登录路径文件中指定的登录路径读取选项
.mylogin.cnf。“
登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--low-priority
LOW_PRIORITY加载表格时
使用。这只会影响仅使用表级锁定的存储引擎（例如MyISAM、
MEMORY和MERGE）。
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
mysqlimport会提示输入一个。如果给定，则后面
的密码之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlimport不应提示输入密码，请使用该
--skip-password
选项。
--password1[=pass_val]
用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出，
mysqlimport会提示输入一个。如果给定，则后面的密码和密码之间
不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlimport不应提示输入密码，请使用该
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
mysqlimport找不到它，请指定此选项。请参阅
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
--replace,
-r
--replace和
--ignore选项控制对在唯一键值上复制现有行的输入行的处理
。如果您指定
--replace，新行将替换具有相同唯一键值的现有行。如果您指定--ignore，将跳过在唯一键值上复制现有行的输入行。如果您未指定任何一个选项，则在找到重复的键值时会发生错误，并且文本文件的其余部分将被忽略。
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
静音模式。仅在发生错误时才产生输出。
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
--user=user_name,
-u user_name
用于连接到服务器的 MySQL 帐户的用户名。
--use-threads=N
N
使用线程
并行加载文件。
--verbose,
-v
详细模式。打印有关程序功能的更多信息。
--version,
-V
显示版本信息并退出。
--zstd-compression-level=level
用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
这是一个示例会话，演示了
mysqlimport的使用：
$> mysql -e 'CREATE TABLE imptest(id INT, n VARCHAR(30))' test
$> ed
a
100     Max Sydow
101     Count Dracula
.
w imptest.txt
32
q
$> od -c imptest.txt
0000000   1   0   0  \t   M   a   x       S   y   d   o   w  \n   1   0
0000020   1  \t   C   o   u   n   t       D   r   a   c   u   l   a  \n
0000040
$> mysqlimport --local test imptest.txt
test.imptest: Records: 2  Deleted: 0  Skipped: 0  Warnings: 0
$> mysql -e 'SELECT * FROM imptest' test
+------+---------------+
| id   | n             |
+------+---------------+
|  100 | Max Sydow     |
|  101 | Count Dracula |
+------+---------------+
© Mysql 中文网
