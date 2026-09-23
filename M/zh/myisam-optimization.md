# 7.6.4 MyISAM表优化_MySQL 8.0 参考手册

7.6.4 MyISAM表优化_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.4 使用 mysqldump 进行备份
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
7.6.1 使用 myisamchk 进行崩溃恢复1
7.6.2 如何检查 MyISAM 表的错误1
7.6.3 如何修复 MyISAM 表1
7.6.4 MyISAM表优化1
7.6.5 设置 MyISAM 表维护计划1
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.6 MyISAM表维护和崩溃恢复  /
7.6.4 MyISAM表优化
7.6.4 MyISAM表优化
要合并碎片化的行并消除因删除或更新行而导致的空间浪费，
请在恢复模式下
运行myisamchk ：$> myisamchk -r tbl_name
您可以使用
OPTIMIZE TABLESQL 语句以相同的方式优化表。
OPTIMIZE TABLE进行表修复和键分析，并对索引树进行排序，以便键查找更快。实用程序和服务器之间也不存在不需要的交互的可能性，因为在您使用OPTIMIZE
TABLE. 请参阅第 13.7.3.4 节，“OPTIMIZE TABLE 语句”。
myisamchk有许多其他选项可用于提高表的性能：
--analyze或
-a：执行密钥分布分析。这通过使连接优化器更好地选择连接表的顺序以及它应该使用哪些索引来提高连接性能。
--sort-indexor
-S: 对索引块进行排序。这优化了查找并使使用索引的表扫描更快。
--sort-records=index_num
or ：根据给定索引对数据行进行排序。这使您的数据更加本地化，​​并可能加快
使用该索引
的基于范围的操作和操作。-R index_numSELECTORDER
BY
有关所有可用选项的完整描述，请参阅
第 4.6.4 节，“myisamchk — MyISAM 表维护实用程序”。
© Mysql 中文网
