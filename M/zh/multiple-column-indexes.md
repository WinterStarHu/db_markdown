# 8.3.6 多列索引_MySQL 8.0 参考手册

8.3.6 多列索引_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.3.1 MySQL如何使用索引1
8.3.2 主键优化1
8.3.3 空间索引优化1
8.3.4 外键优化1
8.3.5 列索引1
8.3.6 多列索引1
8.3.7 验证索引使用1
8.3.8 InnoDB和MyISAM索引统计收集1
8.3.9 B-Tree和哈希索引的比较1
8.3.10 索引扩展的使用1
8.3.11 优化器使用生成的列索引1
8.3.12 不可见索引1
8.3.13 降序索引1
8.3.14 从 TIMESTAMP 列进行索引查找1
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.3 优化和索引  /
8.3.6 多列索引
8.3.6 多列索引
MySQL 可以创建复合索引（即多列索引）。一个索引最多可包含 16 列。对于某些数据类型，您可以索引列的前缀（请参阅
第 8.3.5 节，“列索引”）。
MySQL 可以将多列索引用于测试索引中所有列的查询，或仅测试第一列、前两列、前三列等的查询。如果在索引定义中以正确的顺序指定列，单个复合索引可以加速对同一个表的多种查询。
多列索引可以被认为是一个排序数组，其中的行包含通过连接索引列的值创建的值。
笔记
作为复合索引的替代方案，您可以引入一个基于其他列的信息“散列”的列。如果此列很短、相当独特且已建立索引，则它可能比许多列上的“宽”索引更快。在 MySQL 中，很容易使用这个额外的列：
SELECT * FROM tbl_name
WHERE hash_col=MD5(CONCAT(val1,val2))
AND col1=val1 AND col2=val2;
假设一个表具有以下规范：
CREATE TABLE test (
id         INT NOT NULL,
last_name  CHAR(30) NOT NULL,
first_name CHAR(30) NOT NULL,
PRIMARY KEY (id),
INDEX name (last_name,first_name)
);
该name索引是对
last_name和first_name
列的索引。该索引可用于查询中的查找，这些查询在已知范围内为
last_name和值的组合指定first_name
值。它也可以用于只指定一个
last_name值的查询，因为该列是索引的最左边的前缀（如本节后面所述）。因此，该name索引用于以下查询中的查找：
SELECT * FROM test WHERE last_name='Jones';
SELECT * FROM test
WHERE last_name='Jones' AND first_name='John';
SELECT * FROM test
WHERE last_name='Jones'
AND (first_name='John' OR first_name='Jon');
SELECT * FROM test
WHERE last_name='Jones'
AND first_name >='M' AND first_name < 'N';
但是，该name索引
不用于以下查询中的查找：
SELECT * FROM test WHERE first_name='John';
SELECT * FROM test
WHERE last_name='Jones' OR first_name='John';
假设您发出以下
SELECT语句：
SELECT * FROM tbl_name
WHERE col1=val1 AND col2=val2;col1如果和
上存在多列索引col2，则可以直接获取适当的行。col1如果和上存在单独的单列索引
col2，优化器会尝试使用索引合并优化（请参阅
第 8.2.1.3 节，“索引合并优化”），或尝试通过确定哪个索引排除更多行并使用来找到限制性最强的索引该索引以获取行。
如果表有一个多列索引，那么优化器可以使用索引的任何最左边的前缀来查找行。例如，如果您在 上有一个三列索引，则您在、和
(col1,
col2, col3)上具有索引搜索功能
。
(col1)(col1, col2)(col1, col2, col3)
如果列不构成索引的最左前缀，则 MySQL 无法使用索引执行查找。假设您有SELECT此处显示的语句：
SELECT * FROM tbl_name WHERE col1=val1;
SELECT * FROM tbl_name WHERE col1=val1 AND col2=val2;
SELECT * FROM tbl_name WHERE col2=val2;
SELECT * FROM tbl_name WHERE col2=val2 AND col3=val3;
如果 上存在索引(col1, col2, col3)，则只有前两个查询使用该索引。第三个和第四个查询确实涉及索引列，但不使用索引来执行查找，因为(col2)和
(col2, col3)不是 的最左边前缀
(col1, col2, col3)。
© Mysql 中文网
