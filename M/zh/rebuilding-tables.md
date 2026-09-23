# 2.11.13 重建或修复表或索引_MySQL 8.0 参考手册

2.11.13 重建或修复表或索引_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
2.12 降级MySQL
2.13 Perl 安装注意事项
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.13 重建或修复表或索引
2.11.13 重建或修复表或索引
本节介绍如何重建或修复表或索引，这可能需要：
更改 MySQL 处理数据类型或字符集的方式。例如，排序规则中的错误可能已得到更正，需要重建表以更新使用排序规则的字符列的索引。
mysqlcheck或
mysql_upgradeCHECK TABLE报告的
所需表修复或升级
。
重建表的方法包括：
转储和重新加载方法改变表方法修复表方法
转储和重新加载方法
如果因为不同版本的 MySQL 在二进制（就地）升级或降级后无法处理它们而重建表，则必须使用转储和重新加载方法。在使用原始版本的 MySQL 升级或降级之前转储表。然后在升级或降级
后重新加载表
。
如果使用dump-and-reload重建表的方式只是为了重建索引，则可以在升级或降级之前或之后进行dump。之后仍然必须重新加载。
如果InnoDB因为某个CHECK TABLE操作提示需要升级表而需要重建表，使用
mysqldump创建转储文件并
使用mysql重新加载该文件。如果
CHECK TABLE操作表明存在损坏或导致InnoDB
失败，请参阅第 15.21.3 节，“强制 InnoDB 恢复”以获取有关使用
innodb_force_recovery重新启动选项的信息InnoDB。要了解CHECK TABLE可能遇到的问题类型，请参阅第 13.7.3.2 节“CHECK TABLE 语句”InnoDB中的注释
。
要通过转储和重新加载表来重建表，请使用
mysqldump创建转储文件并
使用mysql重新加载文件：
mysqldump db_name t1 > dump.sql
mysql db_name < dump.sql
要重建单个数据库中的所有表，请指定不带任何以下表名的数据库名称：
mysqldump db_name > dump.sql
mysql db_name < dump.sql
要重建所有数据库中的所有表，请使用以下
--all-databases选项：
mysqldump --all-databases > dump.sql
mysql < dump.sql
改变表方法
要使用 重建表，请ALTER
TABLE使用“空”更改；也就是说， “更改”表以使用它已有的存储引擎的ALTER TABLE语句
。例如，如果是一个
表，使用这个语句：
t1InnoDBALTER TABLE t1 ENGINE = InnoDB;
如果不确定在
ALTER TABLE语句中指定哪个存储引擎，请使用
SHOW CREATE TABLE来显示表定义。
修复表方法
该REPAIR TABLE方法仅适用于MyISAM、
ARCHIVE和CSV表格。
REPAIR TABLE如果表检查操作表明存在损坏或需要升级，
您可以使用。例如，要修复
MyISAM表，请使用以下语句：
REPAIR TABLE t1;
mysqlcheck --repairREPAIR TABLE提供对
语句的命令行访问这可能是一种更方便的修复表的方法，因为您可以使用
--databases或
--all-databases选项分别修复特定数据库或所有数据库中的所有表：
mysqlcheck --repair --databases db_name ...
mysqlcheck --repair --all-databases
© Mysql 中文网
