# 5.9.4 DBUG 包_MySQL 8.0 参考手册

5.9.4 DBUG 包_MySQL 8.0 参考手册
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
5.5 MySQL组件
5.6 MySQL 服务器插件
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
5.9.1 调试 MySQL 服务器1
5.9.2 调试 MySQL 客户端1
5.9.3 LOCK_ORDER 工具1
5.9.4 DBUG 包1
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.9 调试 MySQL  /
5.9.4 DBUG 包
5.9.4 DBUG 包
MySQL 服务器和大多数 MySQL 客户端都是使用最初由 Fred Fish 创建的 DBUG 包编译的。当您配置 MySQL 进行调试时，此包可以获取程序正在执行的操作的跟踪文件。请参阅
第 5.9.1.2 节，“创建跟踪文件”。
本节总结了您可以在命令行的调试选项中为已使用调试支持构建的 MySQL 程序指定的参数值。
可以通过使用
或
选项调用程序来使用 DBUG 包。如果您指定或
选项没有
值，大多数 MySQL 程序使用默认值。服务器默认
在 Unix 和
Windows 上。这个默认的效果是：
--debug[=debug_options]-# [debug_options]--debug-#debug_optionsd:t:i:o,/tmp/mysqld.traced:t:i:O,\mysqld.trace
d：为所有调试宏启用输出
t: 跟踪函数调用和退出
i: 添加 PID 到输出线
o,/tmp/mysqld.trace,
O,\mysqld.trace: 设置调试输出文件。
无论平台如何，
大多数客户端程序都使用默认
debug_options值
。d:t:o,/tmp/program_name.trace
以下是一些示例调试控制字符串，因为它们可能在 shell 命令行上指定：
--debug=d:t
--debug=d:f,main,subr1:F:L:t,20
--debug=d,input,output,files:n
--debug=d:t:i:O,\\mysqld.trace
对于mysqld，还可以通过设置
debug系统变量在运行时更改 DBUG 设置。此变量具有全局值和会话值：
mysql> SET GLOBAL debug = 'debug_options';
mysql> SET SESSION debug = 'debug_options';
更改全局debug值需要足够的权限来设置全局系统变量。更改会话debug值需要足够的权限来设置受限会话系统变量。请参阅第 5.1.9.1 节，“系统变量权限”。
该debug_options值是一系列以冒号分隔的字段：
field_1:field_2:...:field_N
值中的每个字段都包含一个强制性标志字符，前面可以有一个+或
-字符，后面可以有一个逗号分隔的修饰符列表：
[+|-]flag[,modifier,modifier,...,modifier]
下表描述了允许的标志字符。无法识别的标志字符将被静默忽略。
旗帜
描述
d
XXX
为当前状态
启用 DBUG_ 宏的输出。可能后跟一个关键字列表，它只为具有该关键字的 DBUG 宏启用输出。空的关键字列表启用所有宏的输出。
在 MySQL 中，要启用的常见调试宏关键字是
enter、exit、
error、warning、
info和loop。
D
在每个调试器输出行之后延迟。参数是延迟，以十分之一秒为单位，取决于机器的能力。例如，D,20
指定两秒的延迟。
f
将调试、跟踪和分析限制在命名函数列表中。空列表启用所有功能。
仍然必须给出适当的d或标志；t此标志仅在启用时限制它们的操作。
F
确定每行调试或跟踪输出的源文件名。
i
使用每行调试或跟踪输出的 PID 或线程 ID 标识进程。
L
确定每行调试或跟踪输出的源文件行号。
n
打印每行调试或跟踪输出的当前函数嵌套深度。
N
对每行调试输出进行编号。
o
将调试器输出流重定向到指定文件。默认输出是stderr.
O
喜欢o，但是文件在每次写入之间确实被刷新了。需要时，文件会在每次写入之间关闭并重新打开。
p
将调试器操作限制为指定的进程。一个进程必须用
DBUG_PROCESS宏标识并与列表中的一个相匹配，以便调试器操作发生。
P
打印每行调试或跟踪输出的当前进程名称。
r
推送新状态时，不要继承前一个状态的函数嵌套层级。当输出从左边距开始时很有用。
S
_sanity(_file_,_line_)在每个调试的函数上
执行函数，直到_sanity()
返回不同于 0 的值。
t
启用函数调用/退出跟踪行。可能后跟一个列表（仅包含一个修饰符），给出一个数字最大跟踪级别，超过此级别，调试或跟踪宏都不会出现任何输出。默认是编译时选项。
修饰符的前导+或-字符和尾随列表用于标志字符，例如dorf可以为所有适用的修饰符或其中的一些启用调试操作：
没有前导+or -，标志值被设置为给定的修饰符列表。
使用前导+or -，列表中的修饰符被添加到当前修饰符列表或从中减去。
以下示例显示了这对
d标志的作用。所有调试宏的空d列表启用输出。非空列表只允许输出列表中的宏关键字。
这些语句将d值设置为给定的修饰符列表：
mysql> SET debug = 'd';
mysql> SELECT @@debug;
+---------+
| @@debug |
+---------+
| d       |
+---------+
mysql> SET debug = 'd,error,warning';
mysql> SELECT @@debug;
+-----------------+
| @@debug         |
+-----------------+
| d,error,warning |
+-----------------+
A leading +or-添加到当前值或从当前d值中减去：
mysql> SET debug = '+d,loop';
mysql> SELECT @@debug;
+----------------------+
| @@debug              |
+----------------------+
| d,error,warning,loop |
+----------------------+
mysql> SET debug = '-d,error,loop';
mysql> SELECT @@debug;
+-----------+
| @@debug   |
+-----------+
| d,warning |
+-----------+
添加到“所有启用的宏”结果没有变化：
mysql> SET debug = 'd';
mysql> SELECT @@debug;
+---------+
| @@debug |
+---------+
| d       |
+---------+
mysql> SET debug = '+d,loop';
mysql> SELECT @@debug;
+---------+
| @@debug |
+---------+
| d       |
+---------+
禁用所有启用的宏会d
完全禁用该标志：
mysql> SET debug = 'd,error,loop';
mysql> SELECT @@debug;
+--------------+
| @@debug      |
+--------------+
| d,error,loop |
+--------------+
mysql> SET debug = '-d,error,loop';
mysql> SELECT @@debug;
+---------+
| @@debug |
+---------+
|         |
+---------+
© Mysql 中文网
