# 16.1 设置存储引擎_MySQL 8.0 参考手册

16.1 设置存储引擎_MySQL 8.0 参考手册
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
16.1 设置存储引擎
16.2 MyISAM 存储引擎
16.3 MEMORY存储引擎
16.4 CSV存储引擎
16.5 ARCHIVE存储引擎
16.6 BLACKHOLE存储引擎
16.7 MERGE存储引擎
16.8 联合存储引擎
16.9 示例存储引擎
16.10 其他存储引擎
16.11 MySQL存储引擎架构概述
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
MySQL 8.0 参考手册  / 第 16 章替代存储引擎  /
16.1 设置存储引擎
16.1 设置存储引擎
创建新表时，可以通过在语句
中添加ENGINE表选项来
指定使用哪个存储引擎：CREATE TABLE-- ENGINE=INNODB not needed unless you have set a different
-- default storage engine.
CREATE TABLE t1 (i INT) ENGINE = INNODB;
-- Simple table definitions can be switched from one to another.
CREATE TABLE t2 (i INT) ENGINE = CSV;
CREATE TABLE t3 (i INT) ENGINE = MEMORY;
当您省略该ENGINE选项时，将使用默认存储引擎。默认引擎
InnoDB在 MySQL 8.0 中。您可以使用
--default-storage-engine服务器启动选项或通过
在配置文件
中设置该default-storage-engine选项来指定默认引擎。my.cnf
您可以通过设置
default_storage_engine变量为当前会话设置默认存储引擎：
SET default_storage_engine=NDBCLUSTER;通过在启动时或运行时设置 ，
可以将TEMPORARY创建
的表的存储引擎与CREATE
TEMPORARY TABLE永久表的引擎分开设置
。default_tmp_storage_engine
要将表从一个存储引擎转换为另一个存储引擎，请使用
ALTER TABLE指示新引擎的语句：
ALTER TABLE t ENGINE = InnoDB;
请参阅第 13.1.20 节，“CREATE TABLE 语句”和
第 13.1.9 节，“ALTER TABLE 语句”。
如果您尝试使用未编译或已编译但停用的存储引擎，则 MySQL 会使用默认存储引擎创建一个表。例如，在复制设置中，也许您的源服务器使用InnoDB
表来获得最大的安全性，但副本服务器使用其他存储引擎来提高速度，但会牺牲持久性或并发性。
默认情况下，每当
CREATE TABLE或
ALTER TABLE不能使用默认存储引擎时都会生成警告。为防止在所需引擎不可用时发生混乱的意外行为，请启用
NO_ENGINE_SUBSTITUTIONSQL 模式。如果所需的引擎不可用，此设置会产生错误而不是警告，并且不会创建或更改表。请参阅第 5.1.11 节，“服务器 SQL 模式”。
MySQL 可以将表的索引和数据存储在一个或多个其他文件中，具体取决于存储引擎。表和列定义存储在 MySQL 数据字典中。各个存储引擎创建它们管理的表所需的任何附加文件。如果表名包含特殊字符，则表文件的名称包含这些字符的编码版本，如
第 9.2.4 节，“标识符到文件名的映射”中所述。
© Mysql 中文网
