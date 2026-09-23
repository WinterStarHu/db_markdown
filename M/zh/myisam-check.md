# 7.6.2 如何检查 MyISAM 表的错误_MySQL 8.0 参考手册

7.6.2 如何检查 MyISAM 表的错误_MySQL 8.0 参考手册
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
7.6.2 如何检查 MyISAM 表的错误
7.6.2 如何检查 MyISAM 表的错误
要检查MyISAM表，请使用以下命令：
myisamchk
tbl_name
这会发现 99.99% 的错误。它找不到的是仅涉及数据文件的损坏（这很不寻常）。如果你想检查一个表，你通常应该不带选项或带（静默）选项
运行myisamchk 。-s
myisamchk -m
tbl_name
这会找到 99.999% 的所有错误。它首先检查所有索引条目是否有错误，然后读取所有行。它计算行中所有键值的校验和，并验证校验和是否与索引树中键的校验和匹配。
myisamchk -e
tbl_name
这会对所有数据进行全面彻底的检查（-e意思是“扩展检查”）。它对每一行的每个键进行检查读取，以验证它们确实指向正确的行。对于具有许多索引的大表，这可能需要很长时间。通常，
myisamchk在发现第一个错误后停止。如果您想获得更多信息，可以添加-v（详细）选项。这导致
myisamchk继续运行，最多出现 20 个错误。
myisamchk -e -i
tbl_name
这类似于前面的命令，但
-i选项告诉
myisamchk打印额外的统计信息。
在大多数情况下，一个简单的myisamchk命令，除了表名之外没有任何参数就足以检查一个表。
© Mysql 中文网
