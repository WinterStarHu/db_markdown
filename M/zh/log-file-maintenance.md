# 5.4.6 服务器日志维护_MySQL 8.0 参考手册

5.4.6 服务器日志维护_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.4.1 选择通用查询日志和慢查询日志输出目的地1
5.4.2 错误日志1
5.4.3 一般查询日志1
5.4.4 二进制日志1
5.4.5 慢查询日志1
5.4.6 服务器日志维护1
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.4 MySQL 服务器日志  /
5.4.6 服务器日志维护
5.4.6 服务器日志维护
如第 5.4 节“MySQL 服务器日志”中所述，MySQL 服务器可以创建几个不同的日志文件来帮助您查看正在发生的活动。但是，您必须定期清理这些文件，以确保日志不会占用过多的磁盘空间。
在启用日志记录的情况下使用 MySQL 时，您可能希望不时备份和删除旧日志文件，并告诉 MySQL 开始记录到新文件。请参阅第 7.2 节，“数据库备份方法”。
在 Linux (Red Hat) 安装上，您可以使用该
mysql-log-rotate脚本进行日志维护。如果你从 RPM 发行版安装 MySQL，这个脚本应该已经自动安装。如果您使用二进制日志进行复制，请小心使用此脚本。在确定二进制日志的内容已被所有副本处理之前，不应删除二进制日志。
在其他系统上，您必须自己安装一个从cron（或等效程序）启动的短脚本来处理日志文件。
二进制日志文件在服务器的二进制日志到期期限后自动删除。删除文件可以在启动时和刷新二进制日志时进行。默认的二进制日志有效期为 30 天。要指定替代有效期，请使用
binlog_expire_logs_seconds系统变量。如果您正在使用复制，您应该指定一个不低于您的副本可能滞后于源的最长时间的到期期限。要按需删除二进制日志，请使用PURGE BINARY
LOGS语句（请参阅
第 13.4.1.1 节，“PURGE BINARY LOGS 语句”）。
要强制 MySQL 开始使用新的日志文件，请刷新日志。当您执行FLUSH
LOGS语句或mysqladmin flush-logs、mysqladmin refresh、
mysqldump --flush-logs或mysqldump --master-data命令时，会发生日志刷新。参见第 13.7.8.3 节，“FLUSH 语句”，
第 4.5.2 节，“mysqladmin——一个 MySQL 服务器管理程序”，和第 4.5.4 节，“mysqldump——一个数据库备份程序”。此外，当当前二进制日志文件大小达到
max_binlog_size系统变量的值时，服务器会自动刷新二进制日志。
FLUSH LOGS支持可选的修饰符以启用个别日志的选择性刷新（例如，FLUSH BINARY LOGS）。请参阅
第 13.7.8.3 节，“FLUSH 语句”。
日志刷新操作具有以下效果：
如果启用了二进制日志记录，服务器将关闭当前的二进制日志文件并打开一个具有下一个序列号的新日志文件。
如果启用了将一般查询日志记录或慢速查询日志记录到日志文件，服务器将关闭并重新打开日志文件。
如果服务器启动时带有将
--log-error错误日志写入文件的选项，则服务器将关闭并重新打开日志文件。
执行日志刷新语句或命令需要使用具有
RELOAD特权的帐户连接到服务器。在 Unix 和类 Unix 系统上，刷新日志的另一种方法是向服务器发送信号，这可以由root
拥有服务器进程的帐户完成。（请参阅
第 4.10 节，“MySQL 中的 Unix 信号处理”。）信号使日志刷新无需连接到服务器即可执行：
SIGHUP信号刷新所有日志
。但是，SIGHUP除了可能不需要的日志刷新之外，还有其他影响。
从 MySQL 8.0.19 开始，SIGUSR1导致服务器刷新错误日志、一般查询日志和慢速查询日志。如果您只对刷新那些日志感兴趣，
SIGUSR1可以将其用作更
“轻量级”的信号，它不具有
SIGHUP与日志无关的效果。
如前所述，刷新二进制日志会创建一个新的二进制日志文件，而刷新一般查询日志、慢速查询日志或错误日志只是关闭并重新打开日志文件。对于后面的日志，要在 Unix 上创建新的日志文件，请先重命名当前日志文件，然后再刷新它。在刷新时，服务器使用原始名称打开新的日志文件。例如，如果一般查询日志、慢查询日志和错误日志文件名为mysql.log、
mysql-slow.log和
err.log，您可以在命令行中使用如下一系列命令：
cd mysql-data-directory
mv mysql.log mysql.log.old
mv mysql-slow.log mysql-slow.log.old
mv err.log err.log.old
mysqladmin flush-logs
在 Windows 上，使用重命名而不是
mv。
此时，您可以对
、 和
进行备份mysql.log.old，
然后将它们从磁盘中删除。
mysql-slow.log.olderr.log.old
要在运行时重命名一般查询日志或慢查询日志，首先连接到服务器并禁用日志：
SET GLOBAL general_log = 'OFF';
SET GLOBAL slow_query_log = 'OFF';
在禁用日志的情况下，从外部重命名日志文件（例如，从命令行）。然后再次启用日志：
SET GLOBAL general_log = 'ON';
SET GLOBAL slow_query_log = 'ON';
此方法适用于任何平台，不需要重启服务器。
笔记
为使服务器在您从外部重命名文件后重新创建给定的日志文件，文件位置必须可由服务器写入。情况可能并非总是如此。例如，在 Linux 上，服务器可能将错误日志写为
/var/log/mysqld.log, where
/var/logis owned by
rootand not writable by
mysqld。在这种情况下，日志刷新操作无法创建新的日志文件。
要处理这种情况，您必须在重命名原始日志文件后手动创建具有适当所有权的新日志文件。例如，将这些命令执行为
root：
mv /var/log/mysqld.log /var/log/mysqld.log.old
install -omysql -gmysql -m0644 /dev/null /var/log/mysqld.log
© Mysql 中文网
