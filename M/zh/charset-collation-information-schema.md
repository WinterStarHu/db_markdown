# 10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则_MySQL 8.0 参考手册

10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.8.1 在 SQL 语句中使用 COLLATE1
10.8.2 COLLATE 子句优先级1
10.8.3 字符集和排序规则兼容性1
10.8.4 表达式中的排序规则强制性1
10.8.5 二进制排序规则与 _bin 排序规则的比较1
10.8.6 整理效果示例1
10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则1
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.8 整理问题  /
10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则
10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则
表中的字符串列具有不区分大小写INFORMATION_SCHEMA的排序规则。utf8mb3_general_ci但是，对于对应于文件系统中表示的对象的值，例如数据库和表，
INFORMATION_SCHEMA字符串列中的搜索可以区分大小写或不区分大小写，具体取决于底层文件系统的特性和
lower_case_table_names系统变量设置. 例如，如果文件系统区分大小写，则搜索可能区分大小写。本节描述此行为以及如何在必要时修改它。
假设查询在
SCHEMATA.SCHEMA_NAME列中
搜索test数据库。在 Linux 上，文件系统区分大小写，因此
SCHEMATA.SCHEMA_NAME与
'test'匹配的比较，但与
'TEST'不匹配的比较：
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'test';
+-------------+
| SCHEMA_NAME |
+-------------+
| test        |
+-------------+
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'TEST';
Empty set (0.00 sec)
这些结果在
lower_case_table_names系统变量设置为 0 时出现。
lower_case_table_names设置为 1 或 2 会导致第二个查询返回与第一个查询相同的（非空）结果。
笔记
禁止
lower_case_table_names
使用与服务器初始化时使用的设置不同的设置启动服务器。
在 Windows 或 macOS 上，文件系统不区分大小写，因此比较匹配'test'和
'TEST'：
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'test';
+-------------+
| SCHEMA_NAME |
+-------------+
| test        |
+-------------+
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'TEST';
+-------------+
| SCHEMA_NAME |
+-------------+
| TEST        |
+-------------+
的值
lower_case_table_names在这种情况下没有区别。
出现上述行为是因为
在搜索与文件系统中表示的对象相对应的值时，utf8mb3_general_ci排序规则不用于
INFORMATION_SCHEMA查询。
如果列上的字符串操作的结果
INFORMATION_SCHEMA与预期不同，解决方法是使用显式
COLLATE子句强制进行合适的排序规则（请参阅第 10.8.1 节，“在 SQL 语句中使用 COLLATE”）。例如，要执行不区分大小写的搜索，请使用COLLATE列INFORMATION_SCHEMA名：
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME COLLATE utf8mb3_general_ci = 'test';
+-------------+
| SCHEMA_NAME |
+-------------+
| test        |
+-------------+
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME COLLATE utf8mb3_general_ci = 'TEST';
+-------------+
| SCHEMA_NAME |
+-------------+
| test        |
+-------------+
您还可以使用UPPER()or
LOWER()函数：
WHERE UPPER(SCHEMA_NAME) = 'TEST'
WHERE LOWER(SCHEMA_NAME) = 'test'
尽管不区分大小写的比较甚至可以在具有区分大小写的文件系统的平台上执行，如刚才所示，但它不一定总是正确的做法。在这样的平台上，可能有多个名称仅在字母大小写上不同的对象。例如，名为
city、CITY和
的表City可以同时存在。考虑搜索应该匹配所有这样的名字还是只匹配一个并相应地编写查询。以下比较中的第一个（与utf8mb3_bin）区分大小写；其他不是：
WHERE TABLE_NAME COLLATE utf8mb3_bin = 'City'
WHERE TABLE_NAME COLLATE utf8mb3_general_ci = 'city'
WHERE UPPER(TABLE_NAME) = 'CITY'
WHERE LOWER(TABLE_NAME) = 'city'
在INFORMATION_SCHEMA字符串列中搜索引用INFORMATION_SCHEMA
自身的值确实使用utf8mb3_general_ci
排序规则，因为文件系统中没有INFORMATION_SCHEMA表示
“虚拟”数据库。例如，与
SCHEMATA.SCHEMA_NAMEmatch
'information_schema'或
'INFORMATION_SCHEMA'不管平台的比较：
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'information_schema';
+--------------------+
| SCHEMA_NAME        |
+--------------------+
| information_schema |
+--------------------+
mysql> SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'INFORMATION_SCHEMA';
+--------------------+
| SCHEMA_NAME        |
+--------------------+
| information_schema |
+--------------------+
© Mysql 中文网
