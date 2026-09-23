# A.4 MySQL 8.0 FAQ：存储过程和函数_MySQL 8.0 参考手册

A.4 MySQL 8.0 FAQ：存储过程和函数_MySQL 8.0 参考手册
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
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.4 MySQL 8.0 FAQ：存储过程和函数
A.4 MySQL 8.0 FAQ：存储过程和函数
A.4.1.
MySQL 8.0 是否支持存储过程和函数？
A.4.2.
在哪里可以找到 MySQL 存储过程和存储函数的文档？
A.4.3.
是否有 MySQL 存储过程的讨论论坛？
A.4.4.
在哪里可以找到存储过程的 ANSI SQL 2003 规范？
A.4.5.
您如何管理存储的例程？
A.4.6.
有没有办法查看给定数据库中的所有存储过程和存储函数？
A.4.7.
存储过程存储在哪里？
A.4.8。
是否可以将存储过程或存储函数分组到包中？
A.4.9.
一个存储过程可以调用另一个存储过程吗？
A.4.10.
存储过程可以调用触发器吗？
A.4.11.
存储过程可以访问表吗？
A.4.12。
存储过程是否有引发应用程序错误的声明？
A.4.13.
存储过程是否提供异常处理？
A.4.14.
MySQL 8.0 存储例程可以返回结果集吗？
A.4.15。
存储过程是否支持 WITH RECOMPILE？
A.4.16.
是否有一个 MySQL 相当于使用 mod_plsql 作为 Apache 上的网关直接与数据库中的存储过程对话？
A.4.17.
我可以将数组作为输入传递给存储过程吗？
A.4.18。
我可以将游标作为 IN 参数传递给存储过程吗？
A.4.19.
我可以从存储过程中将游标作为 OUT 参数返回吗？
A.4.20。
我可以在存储的例程中打印出变量的值以进行调试吗？
A.4.21.
我可以在存储过程中提交或回滚事务吗？
A.4.22。
MySQL 8.0 存储过程和函数是否支持复制？
A.4.23。
在复制源服务器上创建的存储过程和函数是否复制到副本？
A.4.24。
如何复制存储过程和函数中发生的操作？
A.4.25。
将存储过程和函数与复制一起使用是否有特殊的安全要求？
A.4.26.
复制存储过程和函数操作存在哪些限制？
A.4.27.
上述限制是否会影响 MySQL 进行时间点恢复的能力？
A.4.28。
正在采取什么措施来纠正上述限制？
A.4.1.
MySQL 8.0 是否支持存储过程和函数？
是的。MySQL 8.0 支持两种类型的存储例程，存储过程和存储函数。
A.4.2.
在哪里可以找到 MySQL 存储过程和存储函数的文档？
请参阅第 25.2 节，“使用存储例程”。
A.4.3.
是否有 MySQL 存储过程的讨论论坛？
是的。请参阅
https://forums.mysql.com/list.php?98。
A.4.4.
在哪里可以找到存储过程的 ANSI SQL 2003 规范？
不幸的是，官方规范不能免费获得（ANSI 可以购买）。但是，有些书籍，如Peter Gulutzan 和 Trudy Pelzer 合着的SQL-99 Complete, Really，提供了标准的全面概述，包括存储过程的覆盖范围。
A.4.5.
您如何管理存储的例程？
为存储的例程使用清晰的命名方案始终是一个好习惯。CREATE [FUNCTION|PROCEDURE]您可以使用、ALTER
[FUNCTION|PROCEDURE]、DROP
[FUNCTION|PROCEDURE]和来管理存储过程
SHOW CREATE
[FUNCTION|PROCEDURE]。ROUTINES您可以使用数据库中的表
获取有关现有存储过程
的INFORMATION_SCHEMA信息（请参阅
第 26.3.30 节，“INFORMATION_SCHEMA ROUTINES 表”）。
A.4.6.
有没有办法查看给定数据库中的所有存储过程和存储函数？
是的。对于名为 的数据库dbname，对表使用此查询
INFORMATION_SCHEMA.ROUTINES：
SELECT ROUTINE_TYPE, ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA='dbname';
有关详细信息，请参阅
第 26.3.30 节，“INFORMATION_SCHEMA ROUTINES 表”。
可以使用
SHOW CREATE FUNCTION（对于存储函数）或SHOW CREATE
PROCEDURE（对于存储过程）查看存储例程的主体。有关详细信息，请参阅
第 13.7.7.9 节，“SHOW CREATE PROCEDURE 语句”。
A.4.7.
存储过程存储在哪里？
存储过程存储在
mysql.routines和
mysql.parameters表中，它们是数据字典的一部分。您不能直接访问这些表。相反，查询INFORMATION_SCHEMA
ROUTINES和
PARAMETERS表。请参阅
第 26.3.30 节，“INFORMATION_SCHEMA ROUTINES 表”和
第 26.3.20 节，“INFORMATION_SCHEMA 参数表”。
您还可以使用SHOW CREATE
FUNCTION获取有关存储函数的信息，以及SHOW CREATE PROCEDURE获取有关存储过程的信息。请参阅
第 13.7.7.9 节，“显示创建过程语句”。
A.4.8。
是否可以将存储过程或存储函数分组到包中？
否。MySQL 8.0 不支持此功能。
A.4.9.
一个存储过程可以调用另一个存储过程吗？
是的。
A.4.10.
存储过程可以调用触发器吗？
UPDATE存储过程可以执行导致触发器激活
的 SQL 语句，例如
。A.4.11.
存储过程可以访问表吗？
是的。存储过程可以根据需要访问一个或多个表。
A.4.12。
存储过程是否有引发应用程序错误的声明？
是的。MySQL 8.0 实现了 SQL 标准
SIGNAL和RESIGNAL
语句。请参阅第 13.6.7 节，“条件处理”。
A.4.13.
存储过程是否提供异常处理？
MySQLHANDLER
根据 SQL 标准实现定义。有关详细信息，请参阅
第 13.6.7.2 节，“DECLARE ... HANDLER 语句”。
A.4.14.
MySQL 8.0 存储例程可以返回结果集吗？
存储过程可以，但存储函数不能。如果
SELECT在一个存储过程里面执行一个普通的，结果集直接返回给客户端。您需要使用 MySQL 4.1（或更高版本）客户端/服务器协议才能工作。这意味着，例如，在 PHP 中，您需要使用
mysqli扩展而不是旧
mysql扩展。
A.4.15。
是否WITH RECOMPILE支持存储过程？
不在 MySQL 8.0 中。
A.4.16.
是否有一个 MySQL 相当于
mod_plsql用作 Apache 上的网关以直接与数据库中的存储过程对话？
MySQL 8.0 中没有等效项。
A.4.17.
我可以将数组作为输入传递给存储过程吗？
不在 MySQL 8.0 中。
A.4.18。
我可以将游标作为IN参数传递给存储过程吗？
在 MySQL 8.0 中，游标仅在存储过程中可用。
A.4.19.OUT我可以从存储过程
中将游标作为参数返回吗？
在 MySQL 8.0 中，游标仅在存储过程中可用。但是，如果您不在 a 上打开游标
SELECT，结果将直接发送到客户端。你也可以SELECT
INTO变量。请参阅第 13.2.10 节，“SELECT 语句”。
A.4.20。
我可以在存储的例程中打印出变量的值以进行调试吗？
是的，您可以在存储过程中执行此操作，但不能在存储函数中执行。如果
SELECT在一个存储过程里面执行一个普通的，结果集直接返回给客户端。您必须使用 MySQL 4.1（或更高版本）客户端/服务器协议才能工作。这意味着，例如，在 PHP 中，您需要使用
mysqli扩展而不是旧
mysql扩展。
A.4.21.
我可以在存储过程中提交或回滚事务吗？
是的。但是，您不能在存储函数中执行事务操作。
A.4.22。
MySQL 8.0 存储过程和函数是否支持复制？
是的，在存储过程和函数中执行的标准操作从复制源服务器复制到副本。第 25.7 节“存储程序二进制日志记录”中详细描述了一些限制。
A.4.23。
在复制源服务器上创建的存储过程和函数是否复制到副本？
是的，在复制源服务器上通过正常 DDL 语句执行的存储过程和函数的创建被复制到副本，因此对象存在于两个服务器上。ALTER存储过程和DROP
函数的语句也被复制。
A.4.24。
如何复制存储过程和函数中发生的操作？
MySQL 记录存储过程中发生的每个 DML 事件，并将这些单独的操作复制到副本。不会复制为执行存储过程而进行的实际调用。
更改数据的存储函数被记录为函数调用，而不是每个函数内部发生的 DML 事件。
A.4.25。
将存储过程和函数与复制一起使用是否有特殊的安全要求？
是的。因为副本有权执行从源的二进制日志中读取的任何语句，所以存在特殊的安全约束以将存储函数与复制一起使用。如果一般的复制或二进制日志记录（为了时间点恢复的目的）处于活动状态，那么 MySQL DBA 有两个安全选项可供选择：
任何希望创建存储函数的用户都必须被授予该SUPER
权限。
或者，DBA 可以将
log_bin_trust_function_creators
系统变量设置为 1，这样任何具有标准CREATE ROUTINE
权限的人都可以创建存储函数。
A.4.26.
复制存储过程和函数操作存在哪些限制？
存储过程中嵌入的非确定性（随机）或基于时间的操作可能无法正确复制。就其本质而言，随机产生的结果是不可预测的，也无法准确重现；因此，复制到副本的随机操作不会反映在源上执行的操作。将存储函数声明为DETERMINISTIC或将
log_bin_trust_function_creators
系统变量设置为 0 可防止随机操作产生随机值。
此外，基于时间的操作无法在副本上重现，因为存储过程中此类操作的时间无法通过用于复制的二进制日志重现。它只记录 DML 事件，不考虑时序约束。
最后，在大型 DML 操作（例如批量插入）期间发生错误的非事务性表可能会遇到复制问题，因为源可能会从 DML 活动中部分更新，但由于发生错误而不会对副本进行任何更新。解决方法是使用关键字执行函数的 DML 操作，
IGNORE以便忽略导致错误的源更新，并将不会导致错误的更新复制到副本。
A.4.27.
上述限制是否会影响 MySQL 进行时间点恢复的能力？
影响复制的相同限制会影响时间点恢复。
A.4.28。
正在采取什么措施来纠正上述限制？
您可以选择基于语句的复制或基于行的复制。最初的复制实现是基于基于语句的二进制日志记录。基于行的二进制日志记录解决了前面提到的限制。
也可以使用
混合--binlog-format=mixed复制（通过使用 启动服务器）。这种混合形式的复制“知道”是否可以安全地使用语句级复制，或者是否需要行级复制。
有关其他信息，请参阅
第 17.2.1 节，“复制格式”。
© Mysql 中文网
