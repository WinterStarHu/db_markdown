# 2.11.3 MySQL升级过程升级了什么_MySQL 8.0 参考手册

2.11.3 MySQL升级过程升级了什么_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
2.12 降级MySQL
2.13 Perl 安装注意事项
第 3 章教程
第 4 章 MySQL 程序
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.3 MySQL升级过程升级了什么
2.11.3 MySQL升级过程升级了什么
安装新版本的 MySQL 可能需要升级现有安装的这些部分：
mysql系统模式，其中包含存储 MySQL 服务器运行时所需信息的表（请参阅
第5.3 节，“mysql 系统模式”）。
mysql模式表分为两大类：
存储数据库对象元数据的数据字典表。
系统表（即剩余的非数据字典表），用于其他操作目的。
其他模式，其中一些是内置的并且可能被服务器“拥有”，而另一些则不是：
性能模式、、、
INFORMATION_SCHEMA和
ndbinfo模式
sys。
用户模式。
两个不同的版本号与可能需要升级的安装部分相关联：
数据字典版本。这适用于数据字典表。
服务器版本，也称为 MySQL 版本。这适用于其他模式中的系统表和对象。
在这两种情况下，数据字典中都存储了适用于现有MySQL安装的实际版本，并将当前期望的版本编译成新版本的MySQL。当实际版本低于当前预期版本时，与该版本关联的那些安装部分必须升级到当前版本。如果两个版本都指示需要升级，则必须首先升级数据字典。
作为刚才提到的两个不同版本的反映，升级分两步进行：
第一步：数据字典升级。
这一步升级：
mysql
架构
中的数据字典表。如果实际数据字典版本低于当前预期版本，服务器将创建具有更新定义的数据字典表，将持久化的元数据复制到新表中，以原子方式用新表替换旧表，并重新初始化数据字典。
性能模式
INFORMATION_SCHEMA，和
ndbinfo。
第二步：服务器升级。
此步骤包括所有其他升级任务。如果现有 MySQL 安装的服务器版本低于新安装的 MySQL 版本，则必须升级其他所有内容：
架构中的系统表mysql（其余非数据字典表）。
sys架构
。
用户模式。
数据字典升级（步骤 1）是服务器的责任，它在启动时根据需要执行此任务，除非使用阻止它这样做的选项调用。该选项--upgrade=NONE从 MySQL 8.0.16 开始，--no-dd-upgrade在 MySQL 8.0.16 之前。
如果数据字典已过期但服务器无法升级它，则服务器不会运行，而是退出并出现错误。例如：
[ERROR] [MY-013381] [Server] Server shutting down because upgrade is
required, yet prohibited by the command line option '--upgrade=NONE'.
[ERROR] [MY-010334] [Server] Failed to initialize DD Storage Engine
[ERROR] [MY-010020] [Server] Data Dictionary initialization failed.
MySQL 8.0.16 中对步骤 2 的职责进行了一些更改：
在 MySQL 8.0.16 之前，mysql_upgrade 会
升级 Performance Schema、
和步骤 2 中描述的对象。DBA需要在启动服务器后手动
INFORMATION_SCHEMA调用
mysql_upgrade 。
从 MySQL 8.0.16 开始，服务器执行以前由mysql_upgrade处理的所有任务。虽然升级仍然是一个两步操作，但服务器同时执行这两个操作，从而使过程更简单。
根据您要升级到的 MySQL 版本，就地升级和
逻辑升级中的说明指示服务器是否执行所有升级任务，或者您是否还必须
在服务器启动后
调用mysql_upgrade 。
笔记
因为服务器
INFORMATION_SCHEMA从 MySQL 8.0.16 升级了 Performance Schema 和步骤 2 中描述的对象，所以不需要mysql_upgrade
并且从该版本开始不推荐使用；希望在未来的 MySQL 版本中将其删除。
在第 2 步中发生的大多数方面在 MySQL 8.0.16 之前和之后都是相同的，尽管可能需要不同的命令选项来实现特定的效果。
从 MySQL 8.0.16 开始，--upgrade
服务器选项控制服务器是否以及如何在启动时执行自动升级：
在没有选项或有
--upgrade=AUTO的情况下，服务器升级它确定为过时的任何内容（步骤 1 和 2）。
使用--upgrade=NONE，服务器不升级任何内容（跳过步骤 1 和 2），但如果必须升级数据字典，也会退出并出错。无法使用过时的数据字典运行服务器；服务器坚持升级或退出。
使用--upgrade=MINIMAL，服务器升级数据字典、性能模式和INFORMATION_SCHEMA，如有必要（步骤 1）。请注意，使用此选项升级后，无法启动组复制，因为复制内部所依赖的系统表未更新，并且其他区域的功能减少也可能很明显。
使用--upgrade=FORCE，服务器升级数据字典、性能模式和INFORMATION_SCHEMA，如果有必要（步骤 1），并强制升级其他所有内容（步骤 2）。使用此选项预计服务器启动时间会更长，因为服务器会检查所有模式中的所有对象。
FORCE如果服务器认为不需要执行第 2 步的操作，这对于强制执行它们很有用。FORCE与 不同的一种方式AUTO
是，FORCE如果缺少帮助表或时区表，服务器会重新创建系统表。
以下列表显示了 MySQL 8.0.16 之前的升级命令以及 MySQL 8.0.16 及更高版本的等效命令：
执行正常升级（必要时执行第 1 步和第 2 步）：
MySQL 8.0.16 之前：mysqld后跟mysql_upgrade
从 MySQL 8.0.16 开始：mysqld
必要时仅执行第 1 步：
在 MySQL 8.0.16 之前：不可能执行第 1 步中描述的所有升级任务，同时排除第 2 步中描述的任务。但是，您可以避免升级用户模式和sys使用
mysqld后跟
带有
和
选项
的mysql_upgrade的模式。--upgrade-system-tables--skip-sys-schema
从 MySQL 8.0.16 开始：mysqld --upgrade= MINIMAL
根据需要执行步骤 1，并强制执行步骤 2：
在 MySQL 8.0.16 之前：mysqld后跟mysql_upgrade --force
从 MySQL 8.0.16 开始：mysqld --upgrade=FORCE
在 MySQL 8.0.16 之前，某些mysql_upgrade
选项会影响它执行的操作。下表显示--upgrade了从 MySQL 8.0.16 开始使用哪些服务器选项值来实现类似的效果。（这些不一定是完全等价的，因为给定的
--upgrade选项值可能有额外的效果。）
mysql_upgrade 选项
服务器选项
--skip-sys-schema
--upgrade=NONE或者
--upgrade=MINIMAL
--upgrade-system-tables
--upgrade=NONE或者
--upgrade=MINIMAL
--force
--upgrade=FORCE
有关升级步骤 2 期间发生的情况的附加说明：
sys如果未安装模式，则
步骤 2 安装该模式，否则将其升级到当前版本。sys如果模式存在但没有视图，则会发生错误version，假设它的不存在表示用户创建的模式：
A sys schema exists with no sys.version view. If
you have a user created sys schema, this must be renamed for the
upgrade to succeed.
要在这种情况下升级，请先删除或重命名现有
sys架构。然后再次执行升级过程。（可能需要强制执行第 2 步。）
为了防止sys架构检查：
从 MySQL 8.0.16 开始：使用
--upgrade=NONE或
--upgrade=MINIMAL选项启动服务器。
在 MySQL 8.0.16 之前：
使用
选项调用mysql_upgrade--skip-sys-schema
。
第 2 步升级系统表以确保它们具有当前结构。无论服务器还是
mysql_upgrade执行该步骤都是如此。关于帮助表和时区表的内容，mysql_upgrade不加载任何类型的表，而服务器加载帮助表，但不加载时区表。（也就是说，在MySQL 8.0.16之前，服务器只在数据目录初始化时加载帮助表。从MySQL 8.0.16开始，它在初始化和升级时加载帮助表。）加载时区表的过程依赖于平台，需要 DBA 做出决策，因此无法自动完成。
从 MySQL 8.0.30 开始，当 Step 2 在升级 schema 中的系统表时，
、
和
表mysql的主键中的列顺序更改为将主机名和用户名列放在一起。将主机名和用户名放在一起意味着可以使用索引查找，这可以提高
、 和
语句的性能，
以及对具有多个权限的多个用户进行 ACL 检查的性能。删除并重新创建索引是必要的，如果系统具有大量用户和权限，则可能需要一些时间。
mysql.dbmysql.tables_privmysql.columns_privmysql.procs_privCREATE USERDROP USERRENAME USER
第 2 步根据需要处理所有用户模式中的所有表。表检查可能需要很长时间才能完成。每个表都被锁定，因此在处理时对其他会话不可用。检查和修复操作可能很耗时，尤其是对于大型表。表检查使用语句的FOR UPGRADE选项
。CHECK TABLE有关此选项的详细信息，请参阅
第 13.7.3.2 节，“CHECK TABLE 语句”。
为了防止表检查：
从 MySQL 8.0.16 开始：使用
--upgrade=NONE或
--upgrade=MINIMAL选项启动服务器。
在 MySQL 8.0.16 之前：
使用
选项调用mysql_upgrade--upgrade-system-tables
。
强制表检查：
从 MySQL 8.0.16 开始：使用该
--upgrade=FORCE选项启动服务器。
在 MySQL 8.0.16 之前：
使用
选项调用mysql_upgrade--force。
第 2 步将 MySQL 版本号保存在
mysql_upgrade_info数据目录中命名的文件中。
要忽略该mysql_upgrade_info文件并执行检查，请执行以下操作：
从 MySQL 8.0.16 开始：使用该
--upgrade=FORCE选项启动服务器。
在 MySQL 8.0.16 之前：
使用
选项调用mysql_upgrade--force。
笔记
该mysql_upgrade_info文件已弃用；希望在未来的 MySQL 版本中将其删除。
第 2 步用当前 MySQL 版本号标记所有检查和修复的表。这确保了下次对相同版本的服务器进行升级检查时，可以确定是否需要再次检查或修复给定的表。
© Mysql 中文网
