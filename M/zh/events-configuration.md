# 25.4.2 事件调度器配置_MySQL 8.0 参考手册

25.4.2 事件调度器配置_MySQL 8.0 参考手册
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
25.1 定义存储程序
25.2 使用存储例程
25.3 使用触发器
25.4 使用事件调度器
25.4.1 事件调度器概述1
25.4.2 事件调度器配置1
25.4.3 事件语法1
25.4.4 事件元数据1
25.4.5 事件调度程序状态1
25.4.6 事件调度器和 MySQL 权限1
25.5 使用视图
25.6 存储对象访问控制
25.7 存储程序二进制日志记录
25.8 存储程序的限制
25.9 视图限制
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.4 使用事件调度器  /
25.4.2 事件调度器配置
25.4.2 事件调度器配置
事件由一个特殊的事件调度程序线程执行；当我们提到 Event Scheduler 时，实际上是指这个线程。运行时，事件调度程序线程及其当前状态可由PROCESS在 的输出中具有特权的用户看到SHOW PROCESSLIST，如以下讨论所示。
全局event_scheduler系统变量确定事件调度程序是否在服务器上启用和运行。它具有以下值之一，这些值会影响所描述的事件调度：
ON：事件调度程序已启动；事件调度程序线程运行并执行所有计划的事件。
ON是默认
event_scheduler值。
当 Event Scheduler 为ON时，事件调度程序线程在 的输出中
SHOW PROCESSLIST列为守护进程，其状态表示如下所示：
mysql> SHOW PROCESSLIST\G
*************************** 1. row ***************************
Id: 1
User: root
Host: localhost
db: NULL
Command: Query
Time: 0
State: NULL
Info: show processlist
*************************** 2. row ***************************
Id: 2
User: event_scheduler
Host: localhost
db: NULL
Command: Daemon
Time: 3
State: Waiting for next activation
Info: NULL
2 rows in set (0.00 sec)
可以通过将 的值设置为 来停止事件
event_scheduler调度
OFF。
OFF：事件调度程序已停止。事件调度程序线程未运行，未显示在 的输出中SHOW PROCESSLIST，并且没有计划的事件执行。
当 Event Scheduler 停止（event_scheduleris
OFF）时，可以通过设置 to 的值来启动event_scheduler它
ON。（见下一项。）
DISABLED：此值使事件计划程序无法运行。当 Event Scheduler 为
DISABLED时，事件调度程序线程不会运行（因此不会出现在 的输出中
SHOW PROCESSLIST）。此外，Event Scheduler 状态不能在运行时更改。
如果 Event Scheduler 状态尚未设置为
DISABLED，
则可以在和event_scheduler之间切换（使用
）。设置此变量时也可以使用for
和for
。因此，可以在mysql
客户端中使用以下4条语句中的任意一条来开启Event Scheduler：
ONOFFSET0OFF1ONSET GLOBAL event_scheduler = ON;
SET @@GLOBAL.event_scheduler = ON;
SET GLOBAL event_scheduler = 1;
SET @@GLOBAL.event_scheduler = 1;
同样，这 4 个语句中的任何一个都可用于关闭事件调度程序：
SET GLOBAL event_scheduler = OFF;
SET @@GLOBAL.event_scheduler = OFF;
SET GLOBAL event_scheduler = 0;
SET @@GLOBAL.event_scheduler = 0;
笔记
如果启用了事件调度程序，则启用
super_read_only系统变量会阻止它更新数据字典表中的事件“最后执行”
时间戳。events这会导致 Event Scheduler 在将消息写入服务器错误日志后，在下次尝试执行计划的事件时停止。（在这种情况下，
event_scheduler系统变量不会从 更改ON为
OFF。这意味着该变量拒绝启用或禁用事件调度程序的 DBA意图，其中启动或停止的实际状态可能不同。）。如果
super_read_only在启用后随后被禁用，从 MySQL 8.0.26 开始，服务器会根据需要自动重新启动 Event Scheduler。在 MySQL 8.0.26 之前，需要通过再次启用来手动重启 Event Scheduler。
尽管ON和OFF具有等效的数字，但
or显示event_scheduler的
值始终是、
或之一。
没有数字等价物。出于这个原因，通常
优先于
设置此变量。
SELECTSHOW
VARIABLESOFFONDISABLEDDISABLEDONOFF10
请注意，尝试设置
event_scheduler而不将其指定为全局变量会导致错误：
mysql< SET @@event_scheduler = OFF;
ERROR 1229 (HY000): Variable 'event_scheduler' is a GLOBAL
variable and should be set with SET GLOBAL
重要的
可以将事件调度程序设置为
DISABLED仅在服务器启动时。如果
event_scheduler是
ON或OFF，则不能DISABLED在运行时将其设置为。此外，如果 Event Scheduler 设置为DISABLEDat startup，则无法更改
event_schedulerat runtime 的值。
要禁用事件调度程序，请使用以下两种方法之一：
作为启动服务器时的命令行选项：
--event-scheduler=DISABLED
在服务器配置文件（my.cnf，或my.ini在 Windows 系统上）中，包括服务器可以读取的行（例如，在一个
[mysqld]部分中）：
event_scheduler=DISABLED
要启用事件计划程序，请在不使用
--event-scheduler=DISABLED
命令行选项的情况下重新启动服务器，或者在删除或注释掉event-scheduler=DISABLED
服务器配置文件中包含的行后（视情况而定）。或者，您可以在启动服务器时
使用ON(or 1) 或
OFF(or 0) 代替
值。DISABLED
笔记
event_scheduler当设置为
时，您可以发出事件操作语句
DISABLED。在这种情况下不会生成警告或错误（前提是语句本身有效）。ON但是，在将此变量设置为（或
1）之前，计划的事件无法执行。完成此操作后，事件调度程序线程将执行所有满足调度条件的事件。
--skip-grant-tables使用选项
启动 MySQL 服务器
导致event_scheduler设置为
，覆盖在命令行或or
文件DISABLED中设置的任何其他值（错误 #26807）。
my.cnfmy.ini
对于用于创建、更改和删除事件的 SQL 语句，请参阅
第 25.4.3 节，“事件语法”。
MySQLEVENTS在数据库中提供了一个表
INFORMATION_SCHEMA。可以查询此表以获取有关已在服务器上定义的计划事件的信息。有关更多信息，请参阅第 25.4.4 节，“事件元数据”和第 26.3.14 节，“INFORMATION_SCHEMA 事件表”。
有关事件调度​​和 MySQL 特权系统的信息，请参阅第 25.4.6 节，“事件调度程序和 MySQL 特权”。
© Mysql 中文网
