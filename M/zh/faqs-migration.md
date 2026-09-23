# A.8 MySQL 8.0 FAQ：迁移_MySQL 8.0 参考手册

A.8 MySQL 8.0 FAQ：迁移_MySQL 8.0 参考手册
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
A.8 MySQL 8.0 FAQ：迁移
A.8 MySQL 8.0 FAQ：迁移
A.8.1.
在哪里可以找到有关如何从 MySQL 5.7 迁移到 MySQL 8.0 的信息？
A.8.2.
与之前的版本相比，MySQL 8.0 中的存储引擎（表类型）支持有何变化？
A.8.1.
在哪里可以找到有关如何从 MySQL 5.7 迁移到 MySQL 8.0 的信息？
有关详细的升级信息，请参阅
第 2.11 节，“升级 MySQL”。升级时不要跳过大版本，而是一步步完成，每一步从一个大版本升级到下一个大版本。这可能看起来更复杂，但最终可以节省时间和麻烦。如果您在升级过程中遇到问题，它们的来源将更容易被您识别，或者，如果您有 MySQL Enterprise 订阅，则由 MySQL 支持人员识别。
A.8.2.
与之前的版本相比，MySQL 8.0 中的存储引擎（表类型）支持有何变化？
存储引擎支持更改如下：
ISAMMySQL 5.0 中删除了
对表的支持，您现在应该使用MyISAM存储引擎代替
ISAM. 要将表
tblname从
转换ISAM为MyISAM，只需发出如下语句：
ALTER TABLE tblname ENGINE=MYISAM;
Internal RAIDfor
MyISAMtables 也在 MySQL 5.0 中被移除。这以前用于允许不支持大于 2GB 文件大小的文件系统中的大型表。所有现代文件系统都允许更大的表；此外，现在还有其他解决方案，例如
MERGE表和视图。
列VARCHAR类型现在在所有存储引擎中保留尾随空格。
MEMORY表（以前称为
HEAP表）也可以包含
VARCHAR列。
© Mysql 中文网
