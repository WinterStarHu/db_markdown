# 25.2.1 存储例程语法_MySQL 8.0 参考手册

25.2.1 存储例程语法_MySQL 8.0 参考手册
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
25.2.1 存储例程语法1
25.2.2 存储例程和 MySQL 权限1
25.2.3 存储例程元数据1
25.2.4 存储过程、函数、触发器和 LAST_INSERT_ID()1
25.3 使用触发器
25.4 使用事件调度器
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.2 使用存储例程  /
25.2.1 存储例程语法
25.2.1 存储例程语法
存储例程是过程或函数。存储例程是使用CREATE
PROCEDUREandCREATE
FUNCTION语句创建的（请参阅
第 13.1.17 节，“CREATE PROCEDURE 和 CREATE FUNCTION 语句”）。使用CALL语句调用过程（请参阅
第 13.2.1 节，“CALL 语句”），并且只能使用输出变量传回值。可以像任何其他函数一样从语句内部调用函数（即，通过调用函数的名称），并且可以返回标量值。存储例程的主体可以使用复合语句（请参阅
第 13.6 节，“复合语句语法”）。
可以使用DROP
PROCEDUREandDROP
FUNCTION语句删除存储例程（请参阅
第 13.1.29 节，“DROP PROCEDURE 和 DROP FUNCTION 语句”），并使用
ALTER PROCEDUREand
ALTER FUNCTION语句进行更改（请参阅
第 13.1.7 节，“ALTER PROCEDURE 语句”）。
存储过程或函数与特定数据库相关联。这有几个含义：
调用例程时，将执行隐式（并在例程终止时撤消）。
存储例程中的语句是不允许的。
USE
db_nameUSE
您可以使用数据库名称限定例程名称。这可用于引用不在当前数据库中的例程。例如，要调用
与数据库关联的存储过程p或函数，您可以说or
。
ftestCALL test.p()test.f()
删除数据库时，所有与其关联的存储例程也将被删除。
存储函数不能递归。
存储过程中的递归是允许的，但默认情况下是禁用的。要启用递归，请将
max_sp_recursion_depth服务器系统变量设置为大于零的值。存储过程递归增加了对线程堆栈空间的需求。如果增加 的值
max_sp_recursion_depth，则可能需要通过增加
thread_stack服务器启动时的值来增加线程堆栈大小。有关详细信息，请参阅第 5.1.8 节，“服务器系统变量”。
MySQL 支持一个非常有用的扩展，它允许在SELECT存储过程中使用常规语句（即不使用游标或局部变量）。这种查询的结果集直接发送给客户端。多SELECT
条语句会产生多个结果集，因此客户端必须使用支持多结果集的MySQL客户端库。这意味着客户端必须使用至少最新版本为 4.1 的 MySQL 的客户端库。客户端还应
CLIENT_MULTI_RESULTS在连接时指定该选项。对于 C 程序，这可以通过
mysql_real_connect()C API 函数来完成。请参阅mysql_real_connect()和
多语句执行支持。
在 MySQL 8.0.22 及更高版本中，存储过程中的语句引用的用户变量在第一次调用该过程时确定其类型，并在以后每次调用该过程时保留该类型。
© Mysql 中文网
