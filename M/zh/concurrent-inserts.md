# 8.11.3 并发插入_MySQL 8.0 参考手册

8.11.3 并发插入_MySQL 8.0 参考手册
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
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.11.1 内部锁定方法1
8.11.2 表锁定问题1
8.11.3 并发插入1
8.11.4 元数据锁定1
8.11.5 外部锁定1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.11 优化锁定操作  /
8.11.3 并发插入
8.11.3 并发插入
MyISAM存储引擎支持并发插入以减少给定表的读写器之间的争用：如果
表MyISAM在数据文件中没有空洞（中间删除行），
INSERT则可以执行一条语句将行添加到表的末尾同时，
SELECT语句正在从表中读取行。如果有多个
INSERT语句，它们将与
SELECT语句同时排队并按顺序执行。并发的结果INSERT可能不会立即可见。
concurrent_insert可以设置系统变量来修改并发插入处理
。默认情况下，该变量设置为AUTO（或 1），并发插入如前所述进行处理。如果
concurrent_insert设置为
NEVER（或 0），并发插入将被禁用。如果该变量设置为ALWAYS
（或 2），则即使对于已删除行的表，也允许在表末尾进行并发插入。另见concurrent_insert系统变量的说明。
如果您使用的是二进制日志，则并发插入将转换为CREATE ...
SELECTor
INSERT ...
SELECT语句的普通插入。这样做是为了确保您可以通过在备份操作期间应用日志来重新创建表的精确副本。请参阅第 5.4.4 节，“二进制日志”。此外，对于那些语句，读锁被放置在 selected-from 表上，从而阻止插入到该表中。结果是该表的并发插入也必须等待。
有了LOAD DATA，如果你指定
CONCURRENT一个MyISAM
满足并发插入条件的表（即中间没有空闲块），其他会话可以在LOAD
DATA执行时从表中检索数据。使用该
CONCURRENT选项会
LOAD DATA稍微影响性能，即使没有其他会话同时使用该表也是如此。
如果您指定HIGH_PRIORITY，如果服务器是使用该选项启动的，它将覆盖该选项的效果
--low-priority-updates。它还会导致不使用并发插入。
对于，和LOCK
TABLE之间的区别在于，
允许
在持有锁的同时执行非冲突语句（并发插入）。但是，如果您打算在持有锁的同时使用服务器外部的进程来操作数据库，则不能使用此方法。
READ
LOCALREADREAD LOCALINSERT
© Mysql 中文网
