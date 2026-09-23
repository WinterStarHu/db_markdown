# 25.5.1 查看语法_MySQL 8.0 参考手册

25.5.1 查看语法_MySQL 8.0 参考手册
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
25.1 定义存储程序
25.2 使用存储例程
25.3 使用触发器
25.4 使用事件调度器
25.5 使用视图
25.5.1 查看语法1
25.5.2 视图处理算法1
25.5.3 可更新和可插入视图1
25.5.4 WITH CHECK OPTION 子句的视图1
25.5.5 查看元数据1
25.6 存储对象访问控制
25.7 存储程序二进制日志记录
25.8 存储程序的限制
25.9 视图限制
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.5 使用视图  /
25.5.1 查看语法
25.5.1 查看语法
该CREATE VIEW语句创建一个新视图（请参阅第 13.1.23 节，“CREATE VIEW 语句”）。要更改视图的定义或删除视图，请使用
ALTER VIEW（请参阅
第 13.1.11 节，“ALTER VIEW 语句”），或DROP
VIEW（请参阅第 13.1.35 节，“DROP VIEW 语句”）。
可以从多种
SELECT语句创建视图。它可以引用基表或其他视图。它可以使用连接、
UNION查询和子查询。SELECT甚至不需要参考任何表格。
以下示例定义了一个视图，该视图从另一个表中选择两列，以及根据这些列计算的表达式：
mysql> CREATE TABLE t (qty INT, price INT);
mysql> INSERT INTO t VALUES(3, 50), (5, 60);
mysql> CREATE VIEW v AS SELECT qty, price, qty*price AS value FROM t;
mysql> SELECT * FROM v;
+------+-------+-------+
| qty  | price | value |
+------+-------+-------+
|    3 |    50 |   150 |
|    5 |    60 |   300 |
+------+-------+-------+
mysql> SELECT * FROM v WHERE qty = 5;
+------+-------+-------+
| qty  | price | value |
+------+-------+-------+
|    5 |    60 |   300 |
+------+-------+-------+
© Mysql 中文网
