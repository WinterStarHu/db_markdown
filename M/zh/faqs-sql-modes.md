# A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式_MySQL 8.0 参考手册

A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式_MySQL 8.0 参考手册
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
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.3.1.
什么是服务器 SQL 模式？
A.3.2.
有多少种服务器 SQL 模式？
A.3.3.
如何确定服务器 SQL 模式？
A.3.4.
模式是否取决于数据库或连接？
A.3.5.
可以扩展严格模式的规则吗？
A.3.6.
严格模式会影响性能吗？
A.3.7.
MySQL 8.0安装时默认的server SQL模式是什么？
A.3.1.
什么是服务器 SQL 模式？
服务器 SQL 模式定义了 MySQL 应该支持什么样的 SQL 语法以及它应该执行什么样的数据验证检查。这使得在不同环境中使用 MySQL 以及与其他数据库服务器一起使用 MySQL 变得更加容易。MySQL 服务器将这些模式分别应用于不同的客户端。有关详细信息，请参阅第 5.1.11 节，“服务器 SQL 模式”。
A.3.2.
有多少种服务器 SQL 模式？
每种模式都可以独立打开和关闭。有关可用模式的完整列表，
请参阅
第 5.1.11 节，“服务器 SQL 模式” 。A.3.3.
如何确定服务器 SQL 模式？
您可以使用该选项
设置默认 SQL 模式（用于mysqld
启动） 。--sql-mode使用语句
，您可以从连接内更改设置，可以在本地连接到连接，也可以在全局范围内生效。您可以通过发出
语句来检索当前模式。
SET
[GLOBAL|SESSION]
sql_mode='modes'SELECT @@sql_modeA.3.4.
模式是否取决于数据库或连接？
模式不链接到特定数据库。可以在本地为会话（连接）设置模式，也可以为服务器全局设置模式。您可以使用更改这些设置
。
SET
[GLOBAL|SESSION]
sql_mode='modes'A.3.5.
可以扩展严格模式的规则吗？
当我们提到strict mode时，我们指的是至少
启用TRADITIONAL,
STRICT_TRANS_TABLES或
中的一种模式。STRICT_ALL_TABLES选项可以组合，因此您可以对模式添加限制。有关详细信息，请参阅第 5.1.11 节，“服务器 SQL 模式”。
A.3.6.
严格模式会影响性能吗？
与未完成验证相比，某些设置需要更多时间的输入数据密集验证。虽然对性能的影响不是很大，但如果您不需要这样的验证（也许您的应用程序已经处理了所有这些），那么 MySQL 会为您提供禁用严格模式的选项。但是，如果您确实需要它，严格模式可以提供此类验证。
A.3.7.
MySQL 8.0安装时默认的server SQL模式是什么？
MySQL 8.0 中默认的 SQL 模式包括这些模式：
ONLY_FULL_GROUP_BY、
STRICT_TRANS_TABLES、
NO_ZERO_IN_DATE、
NO_ZERO_DATE、
ERROR_FOR_DIVISION_BY_ZERO和NO_ENGINE_SUBSTITUTION。
有关所有可用模式和默认 MySQL 行为的信息，请参阅第 5.1.11 节，“服务器 SQL 模式”。
© Mysql 中文网
