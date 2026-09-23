# 7.6.1 使用 myisamchk 进行崩溃恢复_MySQL 8.0 参考手册

7.6.1 使用 myisamchk 进行崩溃恢复_MySQL 8.0 参考手册
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
7.6.1 使用 myisamchk 进行崩溃恢复
7.6.1 使用 myisamchk 进行崩溃恢复
本节介绍如何检查和处理 MySQL 数据库中的数据损坏。如果您的表经常损坏，您应该尝试找出原因。请参阅
第 B.3.3.3 节，“如果 MySQL 持续崩溃怎么办”。
有关MyISAM表如何损坏的解释，请参阅第 16.2.4 节，“MyISAM 表问题”。
如果在禁用外部锁定（默认）的情况下运行mysqld ，当mysqld使用同一个表时，您不能可靠地使用
myisamchk检查
表。如果您可以确定在
运行
myisamchk时没有人可以使用mysqld访问这些表，那么您只需
在开始检查表之前执行mysqladmin flush- tables。如果不能保证这一点，
则必须在检查表时停止mysqld 。如果你运行
myisamchk来检查
mysqld的表正在同时更新，您可能会收到一个表已损坏的警告，即使它没有。
如果服务器在启用外部锁定的情况下运行，您可以随时使用
myisamchk检查表。在这种情况下，如果服务器尝试更新
myisamchk正在使用的表，则服务器会等待
myisamchk完成后再继续。
如果您使用myisamchk来修复或优化表，您必须始终确保
mysqld服务器未使用该表（如果禁用外部锁定，这也适用）。如果您不停止mysqld，您至少应该在
运行myisamchk之前执行
mysqladmin flush-tables。如果服务器和
myisamchk同时访问表，
您的表可能会损坏。
执行崩溃恢复时，重要的是要了解数据库中的每个MyISAM表
tbl_name对应于下表所示的数据库目录中的三个文件。
文件
目的
tbl_name.MYD
数据文件
tbl_name.MYI
索引文件
这三种文件类型中的每一种都可能以各种方式损坏，但问题最常发生在数据文件和索引文件中。
myisamchk.MYD通过逐行创建数据文件的副本来工作
它通过删除旧.MYD文件并将新文件重命名为原始文件名来结束修复阶段。如果使用
--quick，
myisamchk不会创建临时
.MYD文件，而是假定该
.MYD文件是正确的并且只生成一个新的索引文件而不触及该.MYD
文件。这是安全的，因为myisamchk
会自动检测.MYD文件是否损坏并在损坏时中止修复。您还可以向myisamchk--quick指定该选项两次
。在这种情况下，
myisamchk不会因某些错误（例如重复键错误）而中止，而是尝试通过修改.MYD文件来解决它们。--quick通常，仅当可用磁盘空间太少而无法执行正常修复时，使用两个在这种情况下，您至少应该在运行myisamchk之前备份表。
© Mysql 中文网
