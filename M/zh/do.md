# 13.2.3 DO 声明_MySQL 8.0 参考手册

13.2.3 DO 声明_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.11 子查询1
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.3 DO 声明
13.2.3 DO 声明
DO expr [, expr] ...
DO执行表达式但不返回任何结果。在大多数方面，
DO是 的简写，但优点是当您不关心结果时它会稍微快一些。
SELECT
expr, ...
DO主要用于有副作用的函数，例如
RELEASE_LOCK().
示例：此SELECT语句暂停，但也会生成结果集：
mysql> SELECT SLEEP(5);
+----------+
| SLEEP(5) |
+----------+
|        0 |
+----------+
1 row in set (5.02 sec)
DO，另一方面，暂停而不产生结果集。：
mysql> DO SLEEP(5);
Query OK, 0 rows affected (4.99 sec)
这可能很有用，例如在存储函数或触发器中，它们禁止生成结果集的语句。
DO只执行表达式。它不能在所有可以使用的情况下SELECT使用。例如，DO id FROM t1无效，因为它引用了一个表。
© Mysql 中文网
