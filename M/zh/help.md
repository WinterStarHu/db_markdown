# 13.8.3 帮助声明_MySQL 8.0 参考手册

13.8.3 帮助声明_MySQL 8.0 参考手册
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
13.8 效用语句
13.8.1 描述语句1
13.8.2 EXPLAIN 语句1
13.8.3 帮助声明1
13.8.4 USE 语句1
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.8 效用语句  /
13.8.3 帮助声明
13.8.3 帮助声明
HELP 'search_string'
该HELP语句返回 MySQL 参考手册中的在线信息。它的正确操作需要mysql
使用帮助主题信息初始化数据库中的帮助表（请参阅
第 5.1.17 节，“服务器端帮助支持”）。
该HELP语句在帮助表中搜索给定的搜索字符串并显示搜索结果。搜索字符串不区分大小写。
搜索字符串可以包含通配符
%和_。这些与使用运算符执行的模式匹配操作具有相同的含义
LIKE。例如，
HELP 'rep%'返回以 开头的主题列表rep。
HELP 语句理解几种类型的搜索字符串：
在最一般的级别，用于contents检索顶级帮助类别的列表：
HELP 'contents'
对于给定帮助类别中的主题列表，例如
Data Types，使用类别名称：
HELP 'data types'
有关特定帮助主题（例如
ASCII()函数或
CREATE TABLE语句）的帮助，请使用关联的一个或多个关键字：
HELP 'ascii'
HELP 'create table'
换句话说，搜索字符串匹配一个类别、多个主题或单个主题。您不一定能提前判断给定的搜索字符串是返回项目列表还是返回单个帮助主题的帮助信息。HELP但是，您可以通过检查结果集中的行数和列数来
判断返回的响应类型。
以下说明指示结果集可以采用的形式。示例语句的输出使用您在使用mysql客户端时看到的熟悉的“表格”或“垂直”格式显示，但请注意，mysql本身
以不同的方式重新格式化结果集。
HELP
清空结果集
找不到搜索字符串的匹配项。
结果集包含单行三列
这意味着搜索字符串产生了对帮助主题的命中。结果包含三列：
name: 主题名称。
description：该主题的描述性帮助文本。
example：用法示例或示例。此列可能为空。
例子：HELP 'replace'
产量：
name: REPLACE
description: Syntax:
REPLACE(str,from_str,to_str)
Returns the string str with all occurrences of the string from_str
replaced by the string to_str. REPLACE() performs a case-sensitive
match when searching for from_str.
example: mysql> SELECT REPLACE('www.mysql.com', 'w', 'Ww');
-> 'WwWwWw.mysql.com'
结果集包含多行和两列
这意味着搜索字符串与许多帮助主题相匹配。结果集表示帮助主题名称：
name: 帮助主题名称。
is_it_category：Y如果名称代表帮助类别，N
如果不是。如果不是，
name当指定为HELP
语句的参数时，该值应该产生一个单行结果集，其中包含对命名项的描述。
例子：HELP 'status'
产量：
+-----------------------+----------------+
| name                  | is_it_category |
+-----------------------+----------------+
| SHOW                  | N              |
| SHOW ENGINE           | N              |
| SHOW MASTER STATUS    | N              |
| SHOW PROCEDURE STATUS | N              |
| SHOW SLAVE STATUS     | N              |
| SHOW STATUS           | N              |
| SHOW TABLE STATUS     | N              |
+-----------------------+----------------+
结果集包含多行三列
这意味着搜索字符串匹配一个类别。结果集包含类别条目：
source_category_name：帮助类别名称。
name：类别或主题名称
is_it_category：Y如果名称代表帮助类别，N
如果不是。如果不是，
name当指定为HELP
语句的参数时，该值应该产生一个单行结果集，其中包含对命名项的描述。
例子：HELP 'functions'
产量：
+----------------------+-------------------------+----------------+
| source_category_name | name                    | is_it_category |
+----------------------+-------------------------+----------------+
| Functions            | CREATE FUNCTION         | N              |
| Functions            | DROP FUNCTION           | N              |
| Functions            | Bit Functions           | Y              |
| Functions            | Comparison operators    | Y              |
| Functions            | Control flow functions  | Y              |
| Functions            | Date and Time Functions | Y              |
| Functions            | Encryption Functions    | Y              |
| Functions            | Information Functions   | Y              |
| Functions            | Logical operators       | Y              |
| Functions            | Miscellaneous Functions | Y              |
| Functions            | Numeric Functions       | Y              |
| Functions            | String Functions        | Y              |
+----------------------+-------------------------+----------------+
© Mysql 中文网
