# 7.6.5 设置 MyISAM 表维护计划_MySQL 8.0 参考手册

7.6.5 设置 MyISAM 表维护计划_MySQL 8.0 参考手册
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
7.6.5 设置 MyISAM 表维护计划
7.6.5 设置 MyISAM 表维护计划
定期执行表检查而不是等待问题发生是个好主意。检查和修复MyISAM表的一种方法是使用
CHECK TABLEand
REPAIR TABLE语句。请参阅
第 13.7.3 节，“表维护语句”。
检查表的另一种方法是使用
myisamchk。出于维护目的，您可以使用myisamchk -s。该-s
选项（ 的缩写--silent）使myisamchk以静默模式运行，仅在发生错误时打印消息。
MyISAM启用自动表检查
也是一个好主意
。例如，每当机器在更新过程中重启时，您通常需要在进一步使用之前检查每个可能受到影响的表。（这些是“预期的崩溃表” 。 ）要使服务器自动检查
表，请使用
系统变量集MyISAM启动它。myisam_recover_options请参阅
第 5.1.8 节，“服务器系统变量”。
您还应该在正常的系统操作期间定期检查您的表格。例如，您可以运行一个cron
作业来每周检查一次重要的表，在crontab文件中使用如下一行：
35 0 * * 0 /path/to/myisamchk --fast --silent /path/to/datadir/*/*.MYI
这将打印出有关崩溃表的信息，以便您可以根据需要检查和修复它们。
首先，每晚在过去 24 小时内更新的所有表上执行myisamchk -s 。当您发现问题很少发生时，您可以将检查频率降低到每周一次左右。
通常，MySQL 表几乎不需要维护。如果您对MyISAM具有动态大小行的表（具有
VARCHAR、
BLOB或
TEXT列的表）执行许多更新，或者具有许多已删除行的表，您可能希望不时对表进行碎片整理/回收空间。您可以通过
OPTIMIZE TABLE在有问题的表上使用来执行此操作。或者，如果您可以暂时停止
mysqld服务器，请将位置更改为数据目录并在服务器停止时使用此命令：
$> myisamchk -r -s --sort-index --myisam_sort_buffer_size=16M */*.MYI
© Mysql 中文网
