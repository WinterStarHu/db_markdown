# 13.7.7 显示语句_MySQL 8.0 参考手册

13.7.7 显示语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.7.1 账户管理报表1
13.7.2 资源组管理语句1
13.7.3 表维护语句1
13.7.4 组件、插件和可加载函数语句1
13.7.5 CLONE 语句1
13.7.6 SET 语句1
13.7.7 显示语句1
13.7.8 其他行政报表1
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.7 数据库管理语句  /
13.7.7 显示语句
13.7.7 显示语句
13.7.7.1 显示二进制日志语句13.7.7.2 SHOW BINLOG EVENTS语句13.7.7.3 显示字符集语句13.7.7.4 SHOW COLLATION 语句13.7.7.5 显示列语句13.7.7.6 显示创建数据库语句13.7.7.7 显示创建事件语句13.7.7.8 显示创建函数语句13.7.7.9 显示创建过程语句13.7.7.10 显示 CREATE TABLE 语句13.7.7.11 显示创建触发器语句13.7.7.12 显示创建用户语句13.7.7.13 显示创建视图语句13.7.7.14 显示数据库语句13.7.7.15 显示引擎语句13.7.7.16 SHOW ENGINES 语句13.7.7.17 显示错误语句13.7.7.18 SHOW EVENTS 声明13.7.7.19 显示函数代码语句13.7.7.20 显示函数状态语句13.7.7.21 SHOW GRANTS 语句13.7.7.22 SHOW INDEX 语句13.7.7.23 SHOW MASTER STATUS 语句13.7.7.24 SHOW OPEN TABLES 语句13.7.7.25 显示插件声明13.7.7.26 显示特权声明13.7.7.27 显示过程代码语句13.7.7.28 SHOW PROCEDURE STATUS 语句13.7.7.29 SHOW PROCESSLIST 语句13.7.7.30 SHOW PROFILE 语句13.7.7.31 显示配置文件声明13.7.7.32 SHOW RELAYLOG EVENTS 语句13.7.7.33 显示副本声明13.7.7.34 显示从主机 | 显示副本声明13.7.7.35 显示副本状态语句13.7.7.36 显示奴隶 | 副本状态声明13.7.7.37 显示状态语句13.7.7.38 显示表状态语句13.7.7.39 SHOW TABLES 语句13.7.7.40 显示触发器语句13.7.7.41 显示变量语句13.7.7.42 显示警告语句
SHOW有许多表单提供有关数据库、表、列或服务器状态信息的信息。本节介绍以下内容：
SHOW {BINARY | MASTER} LOGS
SHOW BINLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count]
SHOW {CHARACTER SET | CHARSET} [like_or_where]
SHOW COLLATION [like_or_where]
SHOW [FULL] COLUMNS FROM tbl_name [FROM db_name] [like_or_where]
SHOW CREATE DATABASE db_name
SHOW CREATE EVENT event_name
SHOW CREATE FUNCTION func_name
SHOW CREATE PROCEDURE proc_name
SHOW CREATE TABLE tbl_name
SHOW CREATE TRIGGER trigger_name
SHOW CREATE VIEW view_name
SHOW DATABASES [like_or_where]
SHOW ENGINE engine_name {STATUS | MUTEX}
SHOW [STORAGE] ENGINES
SHOW ERRORS [LIMIT [offset,] row_count]
SHOW EVENTS
SHOW FUNCTION CODE func_name
SHOW FUNCTION STATUS [like_or_where]
SHOW GRANTS FOR user
SHOW INDEX FROM tbl_name [FROM db_name]
SHOW MASTER STATUS
SHOW OPEN TABLES [FROM db_name] [like_or_where]
SHOW PLUGINS
SHOW PROCEDURE CODE proc_name
SHOW PROCEDURE STATUS [like_or_where]
SHOW PRIVILEGES
SHOW [FULL] PROCESSLIST
SHOW PROFILE [types] [FOR QUERY n] [OFFSET n] [LIMIT n]
SHOW PROFILES
SHOW RELAYLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,] row_count]
SHOW {REPLICAS | SLAVE HOSTS}
SHOW {REPLICA | SLAVE} STATUS [FOR CHANNEL channel]
SHOW [GLOBAL | SESSION] STATUS [like_or_where]
SHOW TABLE STATUS [FROM db_name] [like_or_where]
SHOW [FULL] TABLES [FROM db_name] [like_or_where]
SHOW TRIGGERS [FROM db_name] [like_or_where]
SHOW [GLOBAL | SESSION] VARIABLES [like_or_where]
SHOW WARNINGS [LIMIT [offset,] row_count]
like_or_where: {
LIKE 'pattern'
| WHERE expr
}
如果给定SHOW
语句的语法包含一部分，
则为可以包含 SQL和
通配符的字符串。该模式对于将语句输出限制为匹配值很有用。
LIKE
'pattern''pattern'%_
一些SHOW语句还接受一个WHERE子句，该子句在指定要显示的行方面提供了更大的灵活性。请参阅
第 26.8 节，“SHOW 语句的扩展”。
在SHOW语句结果中，用户名和主机名使用反引号 (`) 引起来。
许多 MySQL API（例如 PHP）使您能够像对待来自;SHOW的结果集一样对待从语句
返回的结果。SELECT有关详细信息，请参阅
第 29 章连接器和 API或您的 API 文档。此外，您可以在 SQL 中处理对
INFORMATION_SCHEMA数据库中的表进行查询的结果，而这是您无法轻松处理SHOW
语句结果的。请参阅第 26 章，INFORMATION_SCHEMA 表。
© Mysql 中文网
