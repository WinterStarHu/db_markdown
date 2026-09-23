# 2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装_MySQL 8.0 参考手册

2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装_MySQL 8.0 参考手册
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
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装
本节介绍如何在 Unix/Linux 上升级 MySQL 二进制和基于包的安装。描述了就地和逻辑升级方法。
就地升级逻辑升级MySQL集群升级
就地升级
就地升级涉及关闭旧的 MySQL 服务器，用新的替换旧的 MySQL 二进制文件或包，在现有数据目录上重新启动 MySQL，以及升级现有安装中需要升级的任何剩余部分。有关可能需要升级的详细信息，请参阅
第 2.11.3 节，“MySQL 升级过程升级了什么”。
笔记
如果您要升级最初通过安装多个 RPM 包生成的安装，请升级所有包，而不仅仅是部分包。例如，如果您之前安装了服务器和客户端 RPM，请不要只升级服务器 RPM。
对于某些 Linux 平台，从 RPM 或 Debian 软件包安装 MySQL 包括用于管理 MySQL 服务器启动和关闭的 systemd 支持。在这些平台上，
未安装mysqld_safe 。在这种情况下，请使用 systemd 来启动和关闭服务器，而不是以下说明中使用的方法。请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
有关 MySQL Cluster 安装的升级，另请参阅
MySQL Cluster Upgrade。
要执行就地升级：
查看
第 2.11.1 节“开始之前”中的信息。
通过完成
第 2.11.5 节“准备升级安装”中的初步检查，确保安装的升级准备就绪。
如果将 XA 事务与 一起使用InnoDB，请在升级前运行XA
RECOVER以检查未提交的 XA 事务。如果返回结果，则通过发出
XA
COMMITor
XA
ROLLBACK语句提交或回滚 XA 事务。
如果您从 MySQL 5.7.11 或更早版本升级到 MySQL 8.0，并且有加密
InnoDB的表空间，请通过执行以下语句轮换密钥环主密钥：
ALTER INSTANCE ROTATE INNODB MASTER KEY;
如果您通常运行配置
innodb_fast_shutdown为
2（冷关闭）的 MySQL 服务器，请通过执行以下任一语句将其配置为执行快速或慢速关闭：
SET GLOBAL innodb_fast_shutdown = 1; -- fast shutdown
SET GLOBAL innodb_fast_shutdown = 0; -- slow shutdown
通过快速或慢速关闭，InnoDB
使其撤消日志和数据文件处于可以在版本之间文件格式差异的情况下处理的状态。
关闭旧的 MySQL 服务器。例如：
mysqladmin -u root -p shutdown
升级 MySQL 二进制文件或包。如果升级二进制安装，请解压新的 MySQL 二进制分发包。请参阅
获取和解压分发。对于基于包的安装，请安装新包。
使用现有数据目录启动 MySQL 8.0 服务器。例如：
mysqld_safe --user=mysql --datadir=/path/to/existing-datadir &
如果有加密InnoDB
的表空间，请使用该
--early-plugin-load选项加载密钥环插件。
当你启动MySQL 8.0服务器时，它会自动检测数据字典表是否存在。如果没有，服务器会在数据目录中创建它们，用元数据填充它们，然后继续其正常的启动顺序。在此过程中，服务器升级所有数据库对象的元数据，包括数据库、表空间、系统和用户表、视图和存储程序（存储过程和函数、触发器和事件调度程序事件）。服务器还会删除以前用于元数据存储的文件。例如，从 MySQL 5.7 升级到 MySQL 8.0 后，您可能会注意到表不再有
.frm文件。
如果此步骤失败，服务器将恢复对数据目录的所有更改。在这种情况下，您应该删除所有重做日志文件，在同一数据目录上启动 MySQL 5.7 服务器，并修复任何错误的原因。然后再执行一次5.7服务器慢关机，启动MySQL 8.0服务器再试。
在上一步中，服务器根据需要升级数据字典。现在有必要执行任何剩余的升级操作：
从 MySQL 8.0.16 开始，服务器将这样做作为上一步的一部分，
mysql在 MySQL 5.7 和 MySQL 8.0 之间对系统数据库进行所需的任何更改，以便您可以利用新的特权或功能。它还为 MySQL 8.0 更新了 Performance Schema、
INFORMATION_SCHEMA和
sys数据库，并检查所有用户数据库是否与当前版本的 MySQL 不兼容。
在 MySQL 8.0.16 之前，服务端只会在上一步升级数据字典。MySQL 8.0服务器启动成功后，执行
mysql_upgrade执行剩余的升级任务：
mysql_upgrade -u root -p
然后关闭并重新启动 MySQL 服务器以确保对系统表所做的任何更改生效。例如：
mysqladmin -u root -p shutdown
mysqld_safe --user=mysql --datadir=/path/to/existing-datadir &
第一次启动 MySQL 8.0 服务器时（在较早的步骤中），您可能会注意到错误日志中有关未升级表的消息。如果
mysql_upgrade运行成功，第二次启动服务器应该不会有这样的信息。
笔记
升级过程不会升级时区表的内容。有关升级说明，请参阅
第 5.1.15 节，“MySQL 服务器时区支持”。
如果升级过程使用mysql_upgrade
（即 MySQL 8.0.16 之前的版本），则该过程也不会升级帮助表的内容。有关这种情况下的升级说明，请参阅
第 5.1.17 节，“服务器端帮助支持”。
逻辑升级
逻辑升级涉及使用备份或导出实用程序（如
mysqldump或mysqlpump ）从旧 MySQL 实例导出 SQL ，安装新的 MySQL 服务器，并将 SQL 应用到新的 MySQL 实例。有关可能需要升级的详细信息，请参阅第 2.11.3 节，“MySQL 升级过程升级了什么”。
笔记
对于某些 Linux 平台，从 RPM 或 Debian 软件包安装 MySQL 包括用于管理 MySQL 服务器启动和关闭的 systemd 支持。在这些平台上，
未安装mysqld_safe 。在这种情况下，请使用 systemd 来启动和关闭服务器，而不是以下说明中使用的方法。请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
警告
将从以前的 MySQL 版本中提取的 SQL 应用到新的 MySQL 版本可能会由于新的、更改的、弃用的或删除的特性和功能引入的不兼容性而导致错误。因此，从以前的 MySQL 版本中提取的 SQL 可能需要修改以启用逻辑升级。
要在升级到最新的 MySQL 8.0 版本之前识别不兼容性，请执行
第 2.11.5 节，“准备升级安装”中描述的步骤。
要执行逻辑升级：
查看
第 2.11.1 节“开始之前”中的信息。
从以前的 MySQL 安装中导出现有数据：
mysqldump -u root -p
--add-drop-table --routines --events
--all-databases --force > data-for-upgrade.sql
笔记
如果您的数据库包含存储程序，请将--routines和
--events选项与
mysqldump一起使用（如上所示）。该
--all-databases选项包括转储中的所有数据库，包括
mysql保存系统表的数据库。
重要的
如果您有包含生成列的表，请使用
MySQL 5.7.9 或更高版本提供的mysqldump实用程序来创建转储文件。早期版本中提供的
mysqldump实用程序对生成的列定义使用不正确的语法（缺陷 #20769542）。您可以使用该
INFORMATION_SCHEMA.COLUMNS
表来识别具有生成列的表。
关闭旧的 MySQL 服务器。例如：
mysqladmin -u root -p shutdown
安装 MySQL 8.0。有关安装说明，请参阅第 2 章，安装和升级 MySQL。
初始化一个新的数据目录，如
第 2.10.1 节“初始化数据目录”中所述。例如：
mysqld --initialize --datadir=/path/to/8.0-datadir'root'@'localhost'
将显示在屏幕上或写入错误日志
的临时密码复制下来供以后使用。
使用新的数据目录启动 MySQL 8.0 服务器。例如：
mysqld_safe --user=mysql --datadir=/path/to/8.0-datadir &
重置root密码：
$> mysql -u root -p
Enter password: ****  <- enter temporary root passwordmysql> ALTER USER USER() IDENTIFIED BY 'your new password';
将先前创建的转储文件加载到新的 MySQL 服务器中。例如：
mysql -u root -p --force < data-for-upgrade.sql
笔记
gtid_mode=ON如果您的转储文件包含系统表，
则不建议在服务器 ( ) 上启用 GTID 时加载转储文件。mysqldump为使用非事务性 MyISAM 存储引擎的系统表发出 DML 指令，并且在启用 GTID 时不允许这种组合。另请注意，将转储文件从启用了 GTID 的服务器加载到另一台启用了 GTID 的服务器中，会导致生成不同的事务标识符。
执行任何剩余的升级操作：
在 MySQL 8.0.16 及更高版本中，关闭服务器，然后使用
--upgrade=FORCE执行剩余升级任务的选项重新启动它：
mysqladmin -u root -p shutdown
mysqld_safe --user=mysql --datadir=/path/to/8.0-datadir --upgrade=FORCE &
使用 重新启动后
--upgrade=FORCE，服务器会在 MySQL 5.7 和 MySQL 8.0 之间的系统模式中进行所需的任何更改
mysql，以便您可以利用新的特权或功能。它还为 MySQL 8.0 带来了 Performance Schema
INFORMATION_SCHEMA和
sysschema 更新，并检查所有用户模式是否与当前版本的 MySQL 不兼容。
在 MySQL 8.0.16 之前，执行
mysql_upgrade执行剩余的升级任务：
mysql_upgrade -u root -p
然后关闭并重新启动 MySQL 服务器以确保对系统表所做的任何更改生效。例如：
mysqladmin -u root -p shutdown
mysqld_safe --user=mysql --datadir=/path/to/8.0-datadir &
笔记
升级过程不会升级时区表的内容。有关升级说明，请参阅
第 5.1.15 节，“MySQL 服务器时区支持”。
如果升级过程使用mysql_upgrade
（即 MySQL 8.0.16 之前的版本），则该过程也不会升级帮助表的内容。有关这种情况下的升级说明，请参阅
第 5.1.17 节，“服务器端帮助支持”。
笔记
加载包含 MySQL 5.7
mysql模式的转储文件会重新创建两个不再使用的表：event和
proc. （对应的MySQL 8.0表是events和routines，都是数据字典表，都是保护的。）当你确信升级成功后，你可以通过执行以下SQL语句
删除event和
表：procDROP TABLE mysql.event;
DROP TABLE mysql.proc;
MySQL集群升级
本节中的信息是
In-Place Upgrade中描述的 in-place 升级过程的附件，用于升级 MySQL Cluster。
从 MySQL 8.0.16 开始，MySQL Cluster 升级可以作为常规滚动升级执行，遵循通常的三个有序步骤：
升级 MGM 节点。
一次升级一个数据节点。
一次升级一个 API 节点（包括 MySQL 服务器）。
升级每个节点的方式与 MySQL 8.0.16 之前几乎相同，因为升级数据字典和升级系统表是分开的。升级每个人有两个步骤
mysqld：
导入数据字典。
--upgrade=MINIMAL使用升级数据字典而不是系统表
的选项启动新服务器
。这与启动服务器而不调用
mysql_upgrade的 MySQL 8.0.16 之前的操作基本相同。
必须连接到 MySQL 服务器才能NDB
完成此阶段。如果存在任何NDB或
NDBINFO表，并且服务器无法连接到集群，它将退出并显示一条错误消息：
Failed to Populate DD tables.
升级系统表。
在 MySQL 8.0.16 之前，DBA 调用
mysql_upgrade客户端来升级系统表。从 MySQL 8.0.16 开始，服务器执行此操作：要升级系统表，请在没有
选项
的情况下重新启动每个单独的mysqld 。--upgrade=MINIMAL
© Mysql 中文网
