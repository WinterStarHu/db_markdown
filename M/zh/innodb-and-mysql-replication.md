# 15.19 InnoDB和MySQL复制_MySQL 8.0 参考手册

15.19 InnoDB和MySQL复制_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.19 InnoDB和MySQL复制
15.19 InnoDB和MySQL复制
可以以副本上的存储引擎与源上的存储引擎不同的方式使用复制。例如，您可以
InnoDB将对源上表的
修改复制到MyISAM副本上的表。有关详细信息，请参阅第 17.4.4 节，“使用具有不同源和副本存储引擎的复制”。
有关设置副本的信息，请参阅
第 17.1.2.6 节，“设置副本”和
第 17.1.2.5 节，“选择数据快照的方法”。要在不删除源或现有副本的情况下创建新副本，请使用
MySQL Enterprise Backup产品。
源上失败的事务不会影响复制。MySQL复制是基于二进制日志的，MySQL在其中写入修改数据的SQL语句。失败的事务（例如，因为违反外键，或者因为它被回滚）不会写入二进制日志，因此不会发送到副本。请参阅
第 13.3.1 节，“START TRANSACTION、COMMIT 和 ROLLBACK 语句”。
复制和级联。 仅当共享外键关系的表
同时在源和副本上使用时，才会InnoDB在副本上执行源上表的
级联操作。无论您使用的是基于语句还是基于行的复制，都是如此。假设你已经开始复制，然后在源上创建两个表，其中
定义为默认存储引擎，使用以下
语句：
InnoDBInnoDBCREATE TABLECREATE TABLE fc1 (
i INT PRIMARY KEY,
j INT
);
CREATE TABLE fc2 (
m INT PRIMARY KEY,
n INT,
FOREIGN KEY ni (n) REFERENCES fc1 (i)
ON DELETE CASCADE
);
如果副本已MyISAM定义为默认存储引擎，则在副本上创建相同的表，但它们使用MyISAM存储引擎，并且该
FOREIGN KEY选项将被忽略。现在我们将一些行插入到源上的表中：
source> INSERT INTO fc1 VALUES (1, 1), (2, 2);
Query OK, 2 rows affected (0.09 sec)
Records: 2  Duplicates: 0  Warnings: 0
source> INSERT INTO fc2 VALUES (1, 1), (2, 2), (3, 1);
Query OK, 3 rows affected (0.19 sec)
Records: 3  Duplicates: 0  Warnings: 0
此时，在源和副本上，表
fc1包含 2 行，表
fc2包含 3 行，如下所示：
source> SELECT * FROM fc1;
+---+------+
| i | j    |
+---+------+
| 1 |    1 |
| 2 |    2 |
+---+------+
2 rows in set (0.00 sec)
source> SELECT * FROM fc2;
+---+------+
| m | n    |
+---+------+
| 1 |    1 |
| 2 |    2 |
| 3 |    1 |
+---+------+
3 rows in set (0.00 sec)
replica> SELECT * FROM fc1;
+---+------+
| i | j    |
+---+------+
| 1 |    1 |
| 2 |    2 |
+---+------+
2 rows in set (0.00 sec)
replica> SELECT * FROM fc2;
+---+------+
| m | n    |
+---+------+
| 1 |    1 |
| 2 |    2 |
| 3 |    1 |
+---+------+
3 rows in set (0.00 sec)
现在假设您
DELETE在源上执行以下语句：
source> DELETE FROM fc1 WHERE i=1;
Query OK, 1 row affected (0.09 sec)
由于级联，fc2源上的表现在仅包含 1 行：
source> SELECT * FROM fc2;
+---+---+
| m | n |
+---+---+
| 2 | 2 |
+---+---+
1 row in set (0.00 sec)
但是，级联不会在副本上传播，因为在副本上DELETEfor
fc1不会删除任何行fc2。副本的副本fc2仍然包含最初插入的所有行：
replica> SELECT * FROM fc2;
+---+---+
| m | n |
+---+---+
| 1 | 1 |
| 3 | 1 |
| 2 | 2 |
+---+---+
3 rows in set (0.00 sec)
这种差异是由于级联删除是由InnoDB存储引擎在内部处理的，这意味着没有任何更改被记录下来。
© Mysql 中文网
