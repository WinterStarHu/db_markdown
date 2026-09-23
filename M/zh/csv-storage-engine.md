# 16.4 CSV存储引擎_MySQL 8.0 参考手册

16.4 CSV存储引擎_MySQL 8.0 参考手册
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
16.4.1 修复和检查 CSV 表1
16.4.2 CSV 限制1
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
16.4 CSV存储引擎
16.4 CSV存储引擎
16.4.1 修复和检查 CSV 表16.4.2 CSV 限制
CSV存储引擎使用逗号分隔值格式将数据存储在文本文件中
。CSV存储引擎总是被编译到 MySQL 服务器中
。
要检查CSV引擎的源代码，请查看storage/csvMySQL 源代码分发目录。
创建CSV表时，服务器会创建一个纯文本数据文件，其名称以表名开头并带有.CSV扩展名。当您将数据存储到表中时，存储引擎会将其以逗号分隔值格式保存到数据文件中。
mysql> CREATE TABLE test (i INT NOT NULL, c CHAR(10) NOT NULL)
ENGINE = CSV;
Query OK, 0 rows affected (0.06 sec)
mysql> INSERT INTO test VALUES(1,'record one'),(2,'record two');
Query OK, 2 rows affected (0.05 sec)
Records: 2  Duplicates: 0  Warnings: 0
mysql> SELECT * FROM test;
+---+------------+
| i | c          |
+---+------------+
| 1 | record one |
| 2 | record two |
+---+------------+
2 rows in set (0.00 sec)
创建CSV表还会创建一个相应的图元文件，用于存储表的状态和表中存在的行数。该文件的名称与表的名称相同，扩展名为CSM.
如果检查test.CSV执行上述语句创建的数据库目录中的文件，其内容应如下所示：
"1","record one"
"2","record two"
这种格式可以被 Microsoft Excel 等电子表格应用程序读取，甚至写入。
© Mysql 中文网
