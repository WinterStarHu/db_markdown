# A.2 MySQL 8.0 FAQ：存储引擎_MySQL 8.0 参考手册

A.2 MySQL 8.0 FAQ：存储引擎_MySQL 8.0 参考手册
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
A.2 MySQL 8.0 FAQ：存储引擎
A.2 MySQL 8.0 FAQ：存储引擎
A.2.1.
我在哪里可以获得 MySQL 存储引擎的完整文档？
A.2.2.
MySQL 8.0 有新的存储引擎吗？
A.2.3.
MySQL 8.0 中是否删除了任何存储引擎？
A.2.4。
我可以阻止使用特定的存储引擎吗？
A.2.5。
与结合使用 InnoDB 和非 InnoDB 存储引擎相比，单独使用 InnoDB 存储引擎是否有优势？
A.2.6.
ARCHIVE 存储引擎有哪些独特优势？
A.2.1.
我在哪里可以获得 MySQL 存储引擎的完整文档？
请参阅第 16 章，替代存储引擎。该章包含了除
InnoDB存储引擎和
NDB存储引擎（用于MySQL Cluster）之外的所有MySQL存储引擎的信息。InnoDB在
第 15 章InnoDB 存储引擎中介绍。
NDB包含在
第 23 章，MySQL NDB Cluster 8.0中。
A.2.2.
MySQL 8.0 有新的存储引擎吗？
No.InnoDB是新表的默认存储引擎。有关详细信息，请参阅第 15.1 节，“InnoDB 简介”。
A.2.3.
MySQL 8.0 中是否删除了任何存储引擎？
提供分区支持的PARTITION存储引擎插件被本地分区处理程序取代。作为此更改的一部分，服务器不能再使用
-DWITH_PARTITION_STORAGE_ENGINE.
partition也不再显示在 的输出中SHOW PLUGINS或INFORMATION_SCHEMA.PLUGINS
表中。
为了支持给定表的分区，用于表的存储引擎现在必须提供自己的（“本机”）分区处理程序。
InnoDB是 MySQL 8.0 中唯一支持的包含本机分区处理程序的存储引擎。尝试使用任何其他存储引擎在 MySQL 8.0 中创建分区表失败。（
NDBMySQL Cluster 使用的存储引擎也提供了自己的分区处理程序，但目前 MySQL 8.0 不支持。）
A.2.4。
我可以阻止使用特定的存储引擎吗？
是的。配置
disabled_storage_engines
选项定义哪些存储引擎不能用于创建表或表空间。默认情况下，
disabled_storage_engines为空（未禁用任何引擎），但可以将其设置为一个或多个引擎的逗号分隔列表。
A.2.5。与混合使用非存储InnoDB
引擎相比，单独使用存储引擎
是否有优势
？
InnoDBInnoDB
是的。独占使用InnoDB表可以简化备份和恢复操作。MySQL Enterprise Backup 对使用存储引擎的所有表进行热备份。InnoDB对于使用MyISAM或其他非InnoDB存储引擎的表，它会进行
“热”备份，数据库继续运行，但这些表在备份时无法修改。请参阅
第 30.2 节，“MySQL 企业备份概述”。
A.2.6.ARCHIVE
存储引擎
的独特优势是什么？ARCHIVE存储引擎存储大量数据，没有索引
；它占地面积小，并使用表扫描执行选择。有关详细信息，请参阅
第 16.5 节，“ARCHIVE 存储引擎”。
© Mysql 中文网
