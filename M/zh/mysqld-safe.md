# 4.3.2 mysqld_safe — MySQL 服务器启动脚本_MySQL 8.0 参考手册

4.3.2 mysqld_safe — MySQL 服务器启动脚本_MySQL 8.0 参考手册
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
4.3.1 mysqld——MySQL 服务器1
4.3.2 mysqld_safe — MySQL 服务器启动脚本1
4.3.3 mysql.server——MySQL服务器启动脚本1
4.3.4 mysqld_multi — 管理多个 MySQL 服务器1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.3 服务器和服务器启动程序  /
4.3.2 mysqld_safe — MySQL 服务器启动脚本
4.3.2 mysqld_safe — MySQL 服务器启动脚本
mysqld_safe是在 Unix 上
启动mysqld服务器的推荐方式
mysqld_safe添加了一些安全功能，例如在发生错误时重新启动服务器以及将运行时信息记录到错误日志中。错误记录的描述将在本节后面给出。
笔记
对于某些 Linux 平台，从 RPM 或 Debian 软件包安装 MySQL 包括用于管理 MySQL 服务器启动和关闭的 systemd 支持。在这些平台上，
没有安装mysqld_safe，因为它是不必要的。有关详细信息，请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
在使用 systemd 进行服务器管理的平台上
不使用mysqld_safe
的一个含义
是不支持在选项文件中使用[mysqld_safe]或
[safe_mysqld]部分，并且可能导致意外行为。
mysqld_safe尝试启动名为mysqld的可执行文件。要覆盖默认行为并明确指定要运行的服务器的名称，请为mysqld_safe--mysqld指定一个
或--mysqld-version选项。您还可以使用
指示mysqld_safe应在其中查找服务器的目录。
--ledirmysqld_safe的
许多选项与mysqld的选项相同。请参阅
第 5.1.7 节，“服务器命令选项”。
mysqld_safe
未知的选项如果在命令行上指定则传递给
mysqld，但如果它们在
[mysqld_safe]选项文件组中指定则忽略。请参见
第 4.2.2.2 节，“使用选项文件”。
mysqld_safe[mysqld]从选项文件的、[server]和
[mysqld_safe]部分读取所有选项
例如，如果您指定这样的[mysqld]部分， mysqld_safe会查找并使用该
--log-error选项：
[mysqld]
log-error=error.log
为了向后兼容，mysqld_safe也读取[safe_mysqld]部分，但为了保持最新，您应该将这些部分重命名为
[mysqld_safe].
mysqld_safe接受命令行和选项文件中的选项，如下表所述。有关 MySQL 程序使用的选项文件的信息，请参阅
第 4.2.2.2 节，“使用选项文件”。
表 4.6 mysqld_safe 选项
选项名称
描述
--basedir
MySQL安装目录路径
--核心文件大小
mysqld 应该能够创建的核心文件的大小
--数据目录
数据目录路径
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
- 帮助
显示帮助信息并退出
--ledir
服务器所在目录路径
--日志错误
将错误日志写入命名文件
--malloc-lib
用于 mysqld 的替代 malloc 库
--mysqld
要启动的服务器程序的名称（在 ledir 目录中）
--mysqld-safe-log-timestamps
日志记录的时间戳格式
--mysqld-版本
服务器程序名称的后缀
- 好的
使用nice程序设置服务器调度优先级
--no-defaults
不读取选项文件
--打开文件限制
mysqld 应该能够打开的文件数
--pid 文件
服务器进程 ID 文件的路径名
--插件目录
安装插件的目录
- 港口
侦听 TCP/IP 连接的端口号
--skip-kill-mysqld
不要试图杀死杂散的 mysqld 进程
--skip-系统日志
不要将错误消息写入系统日志；使用错误日志文件
- 插座
侦听 Unix 套接字连接的套接字文件
--系统日志
将错误消息写入系统日志
--syslog-tag
写入系统日志的消息的标记后缀
- 时区
将 TZ 时区环境变量设置为命名值
- 用户
以具有名称 user_name 或数字用户 ID user_id 的用户身份运行 mysqld
--help
显示帮助信息并退出。
--basedir=dir_name
MySQL 安装目录的路径。
--core-file-size=size
mysqld
应该能够创建
的核心文件的大小。选项值传递给
ulimit -c。
笔记
该
innodb_buffer_pool_in_core_file
变量可用于减小支持它的操作系统上的核心文件的大小。有关详细信息，请参阅第 15.8.3.7 节，“从核心文件中排除缓冲池页面”。
--datadir=dir_name
数据目录的路径。
--defaults-extra-file=file_name
除了通常的选项文件外，还请阅读此选项文件。如果该文件不存在或无法访问，则服务器退出并出错。如果
file_name不是绝对路径名，则将其解释为相对于当前目录。如果使用它，这必须是命令行上的第一个选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--defaults-file=file_name
仅使用给定的选项文件。如果该文件不存在或无法访问，则服务器退出并出错。如果file_name不是绝对路径名，则将其解释为相对于当前目录。如果使用它，这必须是命令行上的第一个选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--ledir=dir_name
如果mysqld_safe找不到服务器，则使用此选项指示服务器所在目录的路径名。
此选项仅在命令行中被接受，在选项文件中不被接受。在使用 systemd 的平台上，可以在 的值中指定该值MYSQLD_OPTS。请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
--log-error=file_name
将错误日志写入给定文件。请参阅
第 5.4.2 节，“错误日志”。
--mysqld-safe-log-timestamps
此选项控制mysqld_safe生成的日志输出中时间戳的格式。以下列表描述了允许的值。对于任何其他值，
mysqld_safe记录警告并使用
UTC格式。
UTC,utc
ISO 8601 UTC 格式（与
--log_timestamps=UTC服务器相同）。这是默认设置。
SYSTEM,system
ISO 8601 本地时间格式（与
--log_timestamps=SYSTEM
服务器相同）。
HYPHEN,hyphen
YY-MM-DD h:mm:ss格式，如 MySQL 5.6 的mysqld_safe。
LEGACY,legacy
YYMMDD hh:mm:ss格式，如
MySQL 5.6 之前
的mysqld_safe 。
--malloc-lib=[lib_name]
用于内存分配而不是系统malloc()库的库的名称。选项值必须是目录
/usr/lib、
/usr/lib64、
/usr/lib/i386-linux-gnu或
之一/usr/lib/x86_64-linux-gnu。
该--malloc-lib选项通过修改LD_PRELOAD
环境值来影响动态链接，使加载程序能够在
mysqld运行时找到内存分配库：
如果未给出该选项，或者给出时没有值 ( --malloc-lib=)，
LD_PRELOAD则不会修改并且不会尝试使用tcmalloc.
在 MySQL 8.0.21 之前，如果选项为
--malloc-lib=tcmalloc，
mysqld_safe会
tcmalloc在
/usr/lib. 如果
tmalloc找到，则将其路径名添加到
mysqldLD_PRELOAD值
的开头。如果
未找到，
mysqld_safe将因错误而中止。
tcmalloc
从 MySQL 8.0.21 开始，tcmalloc不是该
--malloc-lib选项的允许值。
如果选项给出为
，则完整路径将添加到
值的开头。如果完整路径指向不存在或不可读的文件，
则mysqld_safe会因错误而中止。
--malloc-lib=/path/to/some/libraryLD_PRELOAD
对于mysqld_safe添加路径名到 的情况LD_PRELOAD，它将路径添加到变量已有的任何现有值的开头。
笔记
在使用 systemd 管理服务器的系统上，
mysqld_safe不可用。相反，通过在 中设置
LD_PRELOAD来
指定分配库/etc/sysconfig/mysql。
Linux 用户可以
在安装了软件包的libtcmalloc_minimal.so任何平台上使用该库，方法是将这些行添加到文件中：
tcmalloc/usr/libmy.cnf[mysqld_safe]
malloc-lib=tcmalloc
要使用特定tcmalloc库，请指定其完整路径名。例子：
[mysqld_safe]
malloc-lib=/opt/lib/libtcmalloc_minimal.so
--mysqld=prog_name
ledir要启动
的服务器程序（在目录中）的名称
。如果您使用 MySQL 二进制分发版但数据目录位于二进制分发版之外，则需要此选项。如果mysqld_safe
找不到服务器，则使用该
--ledir选项指示服务器所在目录的路径名。
此选项仅在命令行中被接受，在选项文件中不被接受。在使用 systemd 的平台上，可以在 的值中指定该值MYSQLD_OPTS。请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
--mysqld-version=suffix
此选项类似于
--mysqld选项，但您只指定服务器程序名称的后缀。基本名称假定为mysqld。例如，如果您使用
--mysqld-version=debug，
mysqld_safe将启动目录中的
mysqld-debug程序
ledir。如果参数
--mysqld-version为空，mysqld_safe使用
目录中的mysqldledir
。
此选项仅在命令行中被接受，在选项文件中不被接受。在使用 systemd 的平台上，可以在 的值中指定该值MYSQLD_OPTS。请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
--nice=priority
使用该nice程序将服务器的调度优先级设置为给定值。
--no-defaults
不要读取任何选项文件。如果程序启动因从选项文件中读取未知选项而失败，
--no-defaults可用于防止它们被读取。如果使用它，这必须是命令行上的第一个选项。
有关此选项和其他选项文件选项的其他信息，请参阅第 4.2.2.3 节，“影响选项文件处理的命令行选项”。
--open-files-limit=count
mysqld应该能够打开
的文件数。选项值传递给ulimit -n。
笔记
您必须启动mysqld_safe as
root才能正常运行。
--pid-file=file_name
mysqld应该用于其进程 ID 文件
的路径名。
--plugin-dir=dir_name
插件目录的路径名。
--port=port_num
服务器在侦听 TCP/IP 连接时应使用的端口号。除非服务器由
root操作系统用户启动，否则端口号必须为 1024 或更高。
--skip-kill-mysqld
不要试图在启动时杀死杂散的mysqld进程。此选项仅适用于 Linux。
--socket=path
服务器在侦听本地连接时应使用的 Unix 套接字文件。
--syslog,
--skip-syslog
--syslog导致错误消息被发送到syslog支持记录器程序的系统上。
--skip-syslog禁止使用
syslog; 消息被写入错误日志文件。
当syslog用于错误记录时，daemon.err设施/严重性用于所有日志消息。
不推荐使用这些选项来控制mysqld
日志记录。要将错误日志输出写入系统日志，请使用
第 5.4.2.8 节“将错误记录到系统日志”中的说明。要控制设施，请使用服务器
log_syslog_facility系统变量。
--syslog-tag=tag
为了记录到syslog，来自
mysqld_safe和mysqld的消息
分别用 和 的标识符
mysqld_safe写入
mysqld。要为标识符指定后缀，请使用
，它将标识符修改为
和
。
--syslog-tag=tagmysqld_safe-tagmysqld-tag
不推荐使用此选项来控制mysqld
日志记录。请改用服务器
log_syslog_tag系统变量。请参阅第 5.4.2.8 节，“错误记录到系统日志”。
--timezone=timezone
将TZ时区环境变量设置为给定的选项值。有关合法时区规范格式，请参阅您的操作系统文档。
--user={user_name|user_id}
以具有名称或数字用户 ID 的用户身份
运行mysqld服务器。（在此上下文中的“用户”指的是系统登录帐户，而不是授权表中列出的 MySQL 用户。）
user_nameuser_id
如果使用
或
选项执行mysqld_safe来命名选项文件，则选项必须是命令行上给出的第一个选项，否则不使用选项文件。例如，此命令不使用命名选项文件：
--defaults-file--defaults-extra-filemysql> mysqld_safe --port=port_num --defaults-file=file_name
相反，请使用以下命令：
mysql> mysqld_safe --defaults-file=file_name --port=port_num编写mysqld_safe脚本使其通常可以启动从 MySQL 的源代码或二进制分发版安装的服务器，即使这些类型的分发版通常将服务器安装在稍微不同的位置
。（参见
第 2.1.5 节，“安装布局”。）
mysqld_safe期望以下条件之一为真：
服务器和数据库可以相对于工作目录（
调用mysqld_safe的目录）找到。对于二进制发行版，mysqld_safe在其工作目录下查找bin和
data目录。对于源代码分发，它会查找libexec和
var目录。如果从 MySQL 安装目录执行mysqld_safe（例如，
/usr/local/mysql对于二进制分发）
，则应该满足此条件。
如果找不到相对于工作目录的服务器和数据库，mysqld_safe会尝试通过绝对路径名来定位它们。典型位置是
/usr/local/libexec和
/usr/local/var。实际位置由构建时配置到分布中的值确定。如果 MySQL 安装在配置时指定的位置，它们应该是正确的。
因为mysqld_safe试图找到相对于它自己的工作目录的服务器和数据库，所以你可以在任何地方安装 MySQL 的二进制分发版，只要你从 MySQL 安装目录
运行mysqld_safe ：cd mysql_installation_directory
bin/mysqld_safe &
如果mysqld_safe失败，即使从 MySQL 安装目录调用，指定
--ledir和
--datadir选项以指示服务器和数据库在您的系统中所在的目录。
mysqld_safe尝试使用
睡眠和日期系统实用程序来确定它每秒尝试启动的次数。如果存在这些实用程序并且每秒尝试启动的次数大于 5，则
mysqld_safe在再次启动之前等待 1 整秒。这是为了防止在重复出现故障时过度使用 CPU。（缺陷 #11761530，缺陷 #54035）
当您使用mysqld_safe启动
mysqld时，mysqld_safe
安排来自其自身和来自
mysqld的错误（和通知）消息到达相同的目的地。
有几个mysqld_safe选项用于控制这些消息的目的地：
--log-error=file_name: 将错误信息写入指定的错误文件。
--syslog：将错误消息写入syslog支持记录器程序的系统。
--skip-syslog: 不要将错误信息写入syslog. 消息被写入默认错误日志文件（host_name.err
在数据目录中），或者如果
--log-error给出选项则写入命名文件。
如果没有给出这些选项，则默认为
--skip-syslog.
当mysqld_safe写入消息时，通知会转到日志记录目的地（syslog或错误日志文件）和stdout. 错误转到日志记录目标和stderr。
笔记
从
mysqld_safe
控制mysqld日志记录已弃用。请改用服务器的本机支持。有关详细信息，请参阅第 5.4.2.8 节，“错误记录到系统日志”。
syslog
© Mysql 中文网
