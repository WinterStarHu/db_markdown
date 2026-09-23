# 26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表_MySQL 8.0 参考手册

26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表_MySQL 8.0 参考手册
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
26.1 简介
26.2 INFORMATION_SCHEMA 表参考
26.3 INFORMATION_SCHEMA 总表
26.4 INFORMATION_SCHEMA InnoDB 表
26.4.1 INFORMATION_SCHEMA InnoDB 表参考1
26.4.2 INFORMATION_SCHEMA INNODB_BUFFER_PAGE 表1
26.4.3 INFORMATION_SCHEMA INNODB_BUFFER_PAGE_LRU 表1
26.4.4 INFORMATION_SCHEMA INNODB_BUFFER_POOL_STATS 表1
26.4.5 INFORMATION_SCHEMA INNODB_CACHED_INDEXES 表1
26.4.6 INFORMATION_SCHEMA INNODB_CMP 和 INNODB_CMP_RESET 表1
26.4.7 INFORMATION_SCHEMA INNODB_CMPMEM 和 INNODB_CMPMEM_RESET 表1
26.4.8 INFORMATION_SCHEMA INNODB_CMP_PER_INDEX 和 INNODB_CMP_PER_INDEX_RESET 表1
26.4.9 INFORMATION_SCHEMA INNODB_COLUMNS 表1
26.4.10 INFORMATION_SCHEMA INNODB_DATAFILES 表1
26.4.11 INFORMATION_SCHEMA INNODB_FIELDS 表1
26.4.12 INFORMATION_SCHEMA INNODB_FOREIGN 表1
26.4.13 INFORMATION_SCHEMA INNODB_FOREIGN_COLS 表1
26.4.14 INFORMATION_SCHEMA INNODB_FT_BEING_DELETED 表1
26.4.15 INFORMATION_SCHEMA INNODB_FT_CONFIG 表1
26.4.16 INFORMATION_SCHEMA INNODB_FT_DEFAULT_STOPWORD 表1
26.4.17 INFORMATION_SCHEMA INNODB_FT_DELETED 表1
26.4.18 INFORMATION_SCHEMA INNODB_FT_INDEX_CACHE 表1
26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表1
26.4.20 INFORMATION_SCHEMA INNODB_INDEXES 表1
26.4.21 INFORMATION_SCHEMA INNODB_METRICS 表1
26.4.22 INFORMATION_SCHEMA INNODB_SESSION_TEMP_TABLESPACES 表1
26.4.23 INFORMATION_SCHEMA INNODB_TABLES 表1
26.4.24 INFORMATION_SCHEMA INNODB_TABLESPACES 表1
26.4.25 INFORMATION_SCHEMA INNODB_TABLESPACES_BRIEF 表1
26.4.26 INFORMATION_SCHEMA INNODB_TABLESTATS 视图1
26.4.27 INFORMATION_SCHEMA INNODB_TEMP_TABLE_INFO 表1
26.4.28 INFORMATION_SCHEMA INNODB_TRX 表1
26.4.29 INFORMATION_SCHEMA INNODB_VIRTUAL 表1
26.5 INFORMATION_SCHEMA线程池表
26.6 INFORMATION_SCHEMA 连接控制表
26.7 INFORMATION_SCHEMA MySQL 企业防火墙表
26.8 SHOW 语句的扩展
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
MySQL 8.0 参考手册  / 第 26 章 INFORMATION_SCHEMA 表  / 26.4 INFORMATION_SCHEMA InnoDB 表  /
26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表
26.4.19 INFORMATION_SCHEMA INNODB_FT_INDEX_TABLE 表
该INNODB_FT_INDEX_TABLE表提供有关用于处理针对表FULLTEXT索引的
文本搜索的倒排索引的信息InnoDB。
该表最初是空的。在查询之前，将innodb_ft_aux_table系统变量的值设置为包含FULLTEXT索引的表的名称（包括数据库名称）（例如，
test/articles）。
有关相关的使用信息和示例，请参阅
第 15.15.4 节，“InnoDB INFORMATION_SCHEMA FULLTEXT 索引表”。
该INNODB_FT_INDEX_TABLE表有以下列：
WORD
从属于 a 的列的文本中提取的单词FULLTEXT。
FIRST_DOC_ID
该词出现在
FULLTEXT索引中的第一个文档 ID。
LAST_DOC_ID
该词出现在
FULLTEXT索引中的最后一个文档 ID。
DOC_COUNT
该词在
FULLTEXT索引中出现的行数。同一个词可以在缓存表中出现多次，每个DOC_ID和
POSITION值的组合出现一次。
DOC_ID
包含单词的行的文档 ID。该值可能反映您为基础表定义的 ID 列的值，或者它可以是InnoDB当表不包含合适的列时生成的序列值。
POSITION
单词的这个特定实例在由
DOC_ID值标识的相关文档中的位置。
笔记
该表最初是空的。在查询之前，将
innodb_ft_aux_table系统变量的值设置为包含FULLTEXT索引的表的名称（包括数据库名称）（例如，test/articles）。以下示例演示如何使用
innodb_ft_aux_table系统变量来显示有关
FULLTEXT指定表的索引的信息。在新插入行的信息出现在 中之前
INNODB_FT_INDEX_TABLE，
FULLTEXT必须将索引缓存刷新到磁盘。这是通过
OPTIMIZE TABLE在索引表上运行一个操作来完成的
innodb_optimize_fulltext_only
启用系统变量。（该示例最后再次禁用该变量，因为它只是暂时启用。）
mysql> USE test;
mysql> CREATE TABLE articles (
id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(200),
body TEXT,
FULLTEXT (title,body)
) ENGINE=InnoDB;
mysql> INSERT INTO articles (title,body) VALUES
('MySQL Tutorial','DBMS stands for DataBase ...'),
('How To Use MySQL Well','After you went through a ...'),
('Optimizing MySQL','In this tutorial we show ...'),
('1001 MySQL Tricks','1. Never run mysqld as root. 2. ...'),
('MySQL vs. YourSQL','In the following database comparison ...'),
('MySQL Security','When configured properly, MySQL ...');
mysql> SET GLOBAL innodb_optimize_fulltext_only=ON;
mysql> OPTIMIZE TABLE articles;
+---------------+----------+----------+----------+
| Table         | Op       | Msg_type | Msg_text |
+---------------+----------+----------+----------+
| test.articles | optimize | status   | OK       |
+---------------+----------+----------+----------+
mysql> SET GLOBAL innodb_ft_aux_table = 'test/articles';
mysql> SELECT WORD, DOC_COUNT, DOC_ID, POSITION
FROM INFORMATION_SCHEMA.INNODB_FT_INDEX_TABLE LIMIT 5;
+------------+-----------+--------+----------+
| WORD       | DOC_COUNT | DOC_ID | POSITION |
+------------+-----------+--------+----------+
| 1001       |         1 |      4 |        0 |
| after      |         1 |      2 |       22 |
| comparison |         1 |      5 |       44 |
| configured |         1 |      6 |       20 |
| database   |         2 |      1 |       31 |
+------------+-----------+--------+----------+
mysql> SET GLOBAL innodb_optimize_fulltext_only=OFF;
您必须具有PROCESS
查询此表的权限。
使用INFORMATION_SCHEMA
COLUMNS表或
SHOW COLUMNS语句查看有关此表的列的其他信息，包括数据类型和默认值。
有关InnoDB
FULLTEXT搜索的更多信息，请参阅
第 15.6.2.4 节，“InnoDB 全文索引”和
第 12.10 节，“全文搜索功能”。
© Mysql 中文网
