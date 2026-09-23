# 8.13.1&nbsp;Measuring the Speed of Expressions and Functions_MySQL 8.0 参考手册

8.13.1 Measuring the Speed of Expressions and Functions_MySQL 8.0 参考手册
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
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.13.1 Measuring the Speed of Expressions and Functions1
8.13.2 使用你自己的基准1
8.13.3 使用 performance_schema 测量性能1
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
MySQL 8.0 参考手册  / 第8章优化  / 8.13 测量性能（基准测试）  /
8.13.1 Measuring the Speed of Expressions and Functions
8.13.1 Measuring the Speed of Expressions and Functions
To measure the speed of a specific MySQL expression or function,
invoke the BENCHMARK() function
using the mysql client program. Its syntax is
BENCHMARK(loop_count,expr).
The return value is always zero, but mysql
prints a line displaying approximately how long the statement
took to execute. For example:
mysql> SELECT BENCHMARK(1000000,1+1);
+------------------------+
| BENCHMARK(1000000,1+1) |
+------------------------+
|                      0 |
+------------------------+
1 row in set (0.32 sec)
This result was obtained on a Pentium II 400MHz system. It shows
that MySQL can execute 1,000,000 simple addition expressions in
0.32 seconds on that system.
The built-in MySQL functions are typically highly optimized, but
there may be some exceptions.
BENCHMARK() is an excellent tool
for finding out if some function is a problem for your queries.
© Mysql 中文网
