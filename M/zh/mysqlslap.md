# 4.5.8 mysqlslap — 负载仿真客户端_MySQL 8.0 参考手册

4.5.8 mysqlslap — 负载仿真客户端_MySQL 8.0 参考手册
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
4.5.8 mysqlslap — 负载仿真客户端
4.5.8 mysqlslap — 负载仿真客户端
mysqlslap是一个诊断程序，旨在模拟 MySQL 服务器的客户端负载并报告每个阶段的时间。它的工作方式就好像多个客户端正在访问服务器一样。
像这样调用mysqlslap：
mysqlslap [options]
某些选项（例如--create
或）--query使您能够指定包含 SQL 语句的字符串或包含语句的文件。如果您指定一个文件，默认情况下它必须每行包含一个语句。（也就是说，隐式语句定界符是换行符。）使用该
--delimiter选项指定不同的定界符，这使您能够指定跨越多行的语句或将多个语句放在一行上。您不能在文件中包含注释；
mysqlslap不理解它们。
mysqlslap分三个阶段运行：
创建架构、表和可选的任何存储的程序或数据以用于测试。此阶段使用单个客户端连接。
运行负载测试。这个阶段可以使用很多客户端连接。
清理（​​断开连接，如果指定则删除表）。此阶段使用单个客户端连接。
例子：
提供您自己的创建和查询 SQL 语句，50 个客户端查询，每个客户端 200 个选择（在一行中输入命令）：
mysqlslap --delimiter=";"
--create="CREATE TABLE a (b int);INSERT INTO a VALUES (23)"
--query="SELECT * FROM a" --concurrency=50 --iterations=200
让mysqlslapINT用两列和三列的表构建查询SQL语句VARCHAR。使用五个客户端，每个客户端查询 20 次。不创建表或插入数据（即使用之前测试的模式和数据）：
mysqlslap --concurrency=5 --iterations=20
--number-int-cols=2 --number-char-cols=3
--auto-generate-sql
告诉程序从指定的文件中加载create、insert、query SQL语句，
create.sql文件中有多个以.分隔的建表语句';'和多个以.分隔的insert语句';'。该
--query文件应包含多个由 分隔的查询';'。运行所有加载语句，然后使用五个客户端（每个客户端五次）运行查询文件中的所有查询：
mysqlslap --concurrency=5
--iterations=5 --query=query.sql --create=create.sql
--delimiter=";"
mysqlslap支持以下选项，可以在命令行或
选项文件的组中指定[mysqlslap]。[client]有关 MySQL 程序使用的选项文件的信息，请参阅第 4.2.2.2 节，“使用选项文件”。
表 4.18 mysqlslap 选项
选项名称
描述
介绍
弃用
--auto-generate-sql
未在文件中提供或使用命令选项时自动生成 SQL 语句
--auto-generate-sql-add-autoincrement
将 AUTO_INCREMENT 列添加到自动生成的表中
--auto-generate-sql-execute-number
指定自动生成多少查询
--auto-generate-sql-guid-primary
将基于 GUID 的主键添加到自动生成的表中
--auto-generate-sql-load-type
指定测试负载类型
--auto-generate-sql-secondary-indexes
指定要添加到自动生成的表中的二级索引的数量
--auto-generate-sql-unique-query-number
为自动测试生成多少不同的查询
--auto-generate-sql-unique-write-number
为 --auto-generate-sql-write-number 生成多少个不同的查询
--auto-generate-sql-write-number
在每个线程上执行多少行插入
- 犯罪
提交前要执行多少条语句
- 压缩
压缩客户端和服务器之间发送的所有信息
8.0.18
--压缩算法
允许的服务器连接压缩算法
8.0.18
--并发
发出 SELECT 语句时要模拟的客户端数
- 创造
包含用于创建表的语句的文件或字符串
--create-schema
运行测试的模式
--csv
以逗号分隔值格式生成输出
--调试
写调试日志
--调试检查
程序退出时打印调试信息
- 调试信息
程序退出时打印调试信息、内存和 CPU 统计信息
--default-auth
要使用的身份验证插件
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
--defaults-group-suffix
选项组后缀值
--分隔符
在 SQL 语句中使用的定界符
- 分离
在每 N 个语句之后分离（关闭并重新打开）每个连接
--启用明文插件
启用明文身份验证插件
- 引擎
用于创建表的存储引擎
--get-server-public-key
从服务器请求 RSA 公钥
- 帮助
显示帮助信息并退出
- 主持人
MySQL 服务器所在的主机
--迭代
运行测试的次数
--登录路径
从 .mylogin.cnf 读取登录路径选项
--no-defaults
不读取选项文件
- 没有下降
不要删除在测试运行期间创建的任何模式
--number-char-cols
如果指定了 --auto-generate-sql，则使用的 VARCHAR 列数
--number-int-cols
如果指定了 --auto-generate-sql，则使用的 INT 列数
--查询次数
将每个客户端限制为大约此数量的查询
--only-打印
不要连接到数据库。mysqlslap 只打印它会做的事情
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
--查询后
包含测试完成后要执行的语句的文件或字符串
--后系统
测试完成后使用 system() 执行的字符串
--预查询
包含运行测试前要执行的语句的文件或字符串
--预系统
在运行测试之前使用 system() 执行的字符串
--print-defaults
打印默认选项
- 协议
使用的传输协议
- 询问
包含用于检索数据的 SELECT 语句的文件或字符串
--server-public-key-path
包含 RSA 公钥的文件的路径名
--shared-memory-base-name
共享内存连接的共享内存名称（仅限 Windows）
- 沉默的
静音模式
- 插座
要使用的 Unix 套接字文件或 Windows 命名管道
--sql模式
为客户端会话设置 SQL 模式
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
--auto-generate-sql,
-a
未在文件中提供或使用命令选项时自动生成 SQL 语句。
--auto-generate-sql-add-autoincrement
AUTO_INCREMENT向自动生成的表中
添加一列。
--auto-generate-sql-execute-number=N
指定要自动生成多少查询。
--auto-generate-sql-guid-primary
将基于 GUID 的主键添加到自动生成的表中。
--auto-generate-sql-load-type=type
指定测试负载类型。允许的值为
read（扫描表）、
write（插入表）、
key（读取主键）、
update（更新主键）或
mixed（一半插入，一半扫描选择）。默认值为mixed。
--auto-generate-sql-secondary-indexes=N
指定要添加到自动生成的表中的二级索引的数量。默认情况下，不添加任何内容。
--auto-generate-sql-unique-query-number=N
为自动测试生成多少不同的查询。例如，如果您运行key执行 1000 次选择的测试，则可以使用此选项，值为 1000 以运行 1000 个唯一查询，或使用值为 50 以执行 50 次不同的选择。默认值为 10。
--auto-generate-sql-unique-write-number=N
为 生成多少不同的查询
--auto-generate-sql-write-number。默认值为 10。
--auto-generate-sql-write-number=N
要执行多少行插入。默认值为 100。
--commit=N
提交前要执行多少条语句。默认值为 0（未完成任何提交）。
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
--concurrency=N,
-c N
要模拟的并行客户端数。
--create=value
包含用于创建表的语句的文件或字符串。
--create-schema=value
运行测试的模式。
笔记
如果
--auto-generate-sql
还给出了该选项，mysqlslap会在测试运行结束时删除模式。为避免这种情况，请--no-drop同时使用该选项。
--csv[=file_name]
以逗号分隔值格式生成输出。输出到命名文件，如果没有给出文件，则输出到标准输出。
--debug[=debug_options],
-#
[debug_options]
写调试日志。典型的
debug_options字符串是
. 默认值为
。
d:t:o,file_named:t:o,/tmp/mysqlslap.trace
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--debug-check
程序退出时打印一些调试信息。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
--debug-info,
-T
程序退出时打印调试信息以及内存和 CPU 使用统计信息。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
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
mysqlslap通常读取
[client]和
[mysqlslap]组。如果此选项作为 给出
--defaults-group-suffix=_other，
mysqlslap还会读取
[client_other]和
[mysqlslap_other]组。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--delimiter=str,
-F str
在文件中提供或使用命令选项的 SQL 语句中使用的分隔符。
--detach=N
N在每个语句
之后分离（关闭并重新打开）每个连接
。默认值为 0（不分离连接）。
--enable-cleartext-plugin
启用mysql_clear_password明文身份验证插件。（请参阅
第 6.4.1.4 节，“客户端明文可插入身份验证”。）
--engine=engine_name,
-e engine_name
用于创建表的存储引擎。
--get-server-public-key
从服务器请求它用于基于密钥对的密码交换的 RSA 公钥。caching_sha2_password此选项适用于使用通过身份验证插件进行身份验证的帐户连接到服务器的客户端
。对于此类帐户的连接，除非请求，否则服务器不会将公钥发送给客户端。对于未使用该插件进行身份验证的帐户，该选项将被忽略。如果不需要基于 RSA 的密码交换，它也会被忽略，就像客户端使用安全连接连接到服务器时的情况一样。
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
--iterations=N,
-i N
运行测试的次数。
--login-path=name
从登录路径文件中指定的登录路径读取选项
.mylogin.cnf。“
登录路径”是一个选项组，其中包含指定要连接到哪个 MySQL 服务器以及要以哪个帐户进行身份验证的选项。要创建或修改登录路径文件，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--no-drop
防止mysqlslap删除它在测试运行期间创建的任何模式。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults可用于防止它们被读取。
例外情况是.mylogin.cnf
文件在所有情况下都会被读取（如果存在）。这允许以比在命令行上更安全的方式指定密码，即使在
--no-defaults使用 时也是如此。要创建.mylogin.cnf，请使用
mysql_config_editor实用程序。请参阅
第 4.6.7 节，“mysql_config_editor — MySQL 配置实用程序”。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--number-char-cols=N,
-x N
如果指定
了VARCHAR要使用
的列数。--auto-generate-sql
--number-int-cols=N,
-y N
如果指定
了INT要使用
的列数。--auto-generate-sql
--number-of-queries=N
将每个客户端限制为大约这么多查询。查询计数考虑了语句定界符。例如，如果您按如下方式调用mysqlslap; ，则会识别定界符，以便查询字符串的每个实例都计为两个查询。结果，插入了 5 行（不是 10 行）。
mysqlslap --delimiter=";" --number-of-queries=10
--query="use test;insert into t values(null)"
--only-print
不要连接到数据库。mysqlslap
只打印它会做的事情。
--password[=password],
-p[password]
用于连接到服务器的 MySQL 帐户的密码。密码值是可选的。如果没有给出，
mysqlslap会提示输入一个。如果给定，则后面
的密码之间
不能有空格。如果未指定密码选项，则默认为不发送密码。
--password=-p
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlslap不应提示输入密码，请使用该
--skip-password
选项。
--password1[=pass_val]
用于连接服务器的 MySQL 帐户的多因素身份验证因子 1 的密码。密码值是可选的。如果没有给出，
mysqlslap会提示输入一个。如果给定，则后面的密码和密码之间
不能有空格--password1=。如果未指定密码选项，则默认为不发送密码。
在命令行上指定密码应该被认为是不安全的。为避免在命令行中提供密码，请使用选项文件。请参阅
第 6.1.2.1 节，“密码安全的最终用户指南”。
要明确指定没有密码并且
mysqlslap不应提示输入密码，请使用该
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
在其中查找插件的目录。如果该
--default-auth选项用于指定身份验证插件但
mysqlslap未找到它，请指定此选项。请参阅
第 6.2.17 节，“可插入身份验证”。
--port=port_num,
-P port_num
对于 TCP/IP 连接，要使用的端口号。
--post-query=value
包含测试完成后要执行的语句的文件或字符串。此执行不计入计时目的。
--post-system=str
system()
测试完成后
要执行的字符串。此执行不计入计时目的。
--pre-query=value
包含要在运行测试之前执行的语句的文件或字符串。此执行不计入计时目的。
--pre-system=str
system()
在运行测试之前
要执行的字符串。此执行不计入计时目的。
--print-defaults
打印程序名称和它从选项文件中获取的所有选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--protocol={TCP|SOCKET|PIPE|MEMORY}
用于连接到服务器的传输协议。当其他连接参数通常导致使用您想要的协议以外的协议时，它很有用。有关允许值的详细信息，请参阅
第 4.2.7 节“连接传输协议”。
--query=value,
-q value
SELECT包含用于检索数据
的语句的文件或字符串
。
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
静音模式。无输出。
--socket=path,
-S path
对于与 的连接localhost，要使用的 Unix 套接字文件，或者在 Windows 上，要使用的命名管道的名称。
在 Windows 上，仅当服务器启动时named_pipe
启用了支持命名管道连接的系统变量时，此选项才适用。此外，进行连接的用户必须是
named_pipe_full_access_group
系统变量指定的 Windows 组的成员。
--sql-mode=mode
为客户端会话设置 SQL 模式。
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
--verbose,
-v
详细模式。打印有关程序功能的更多信息。该选项可以多次使用以增加信息量。
--version,
-V
显示版本信息并退出。
--zstd-compression-level=level
用于连接到使用zstd压缩算法的服务器的压缩级别。允许的级别从 1 到 22，值越大表示压缩级别越高。默认
zstd压缩级别为 3。压缩级别设置对不使用zstd压缩的连接没有影响。
有关更多信息，请参阅
第 4.2.8 节，“连接压缩控制”。
这个选项是在 MySQL 8.0.18 中添加的。
© Mysql 中文网
