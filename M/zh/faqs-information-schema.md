# A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA_MySQL 8.0 参考手册

A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA_MySQL 8.0 参考手册
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
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.7.1.
在哪里可以找到 MySQL INFORMATION_SCHEMA 数据库的文档？
A.7.2.
有 INFORMATION_SCHEMA 的讨论论坛吗？
A.7.3.
在哪里可以找到 INFORMATION_SCHEMA 的 ANSI SQL 2003 规范？
A.7.4.
Oracle 数据字典和 MySQL INFORMATION_SCHEMA 有什么区别？
A.7.5.
我可以添加或以其他方式修改在 INFORMATION_SCHEMA 数据库中找到的表吗？
A.7.1.
在哪里可以找到 MySQL
INFORMATION_SCHEMA数据库的文档？
请参阅第 26 章，INFORMATION_SCHEMA 表。
您可能还会发现
MySQL 用户论坛
很有帮助。
A.7.2.
有讨论论坛
INFORMATION_SCHEMA吗？
请参阅MySQL 用户论坛。
A.7.3.
在哪里可以找到 的 ANSI SQL 2003 规范
INFORMATION_SCHEMA？
不幸的是，官方规范不是免费提供的。（ANSI 提供它们可供购买。）但是，也有一些书籍提供了标准的全面概述，例如SQL-99 Complete, Really by Peter Gulutzan 和 Trudy Pelzer，包括
INFORMATION_SCHEMA.
A.7.4.
Oracle 数据字典和 MySQL 有什么区别INFORMATION_SCHEMA？
Oracle 和 MySQL 都在表中提供元数据。但是，Oracle 和 MySQL 使用不同的表名和列名。MySQL 实现更类似于 DB2 和 SQL Server 中的实现，它们也支持
INFORMATION_SCHEMASQL 标准中定义的。
A.7.5.
我可以添加或以其他方式修改
INFORMATION_SCHEMA数据库中的表吗？
不可以。由于应用程序可能依赖于某种标准结构，因此不应对其进行修改。因此，我们无法支持因修改
INFORMATION_SCHEMA表或数据而导致的错误或其他问题。
© Mysql 中文网
