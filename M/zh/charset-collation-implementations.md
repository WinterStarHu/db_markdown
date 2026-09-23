# 10.14.1 归类实现类型_MySQL 8.0 参考手册

10.14.1 归类实现类型_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.14.1 归类实现类型1
10.14.2 选择归类 ID1
10.14.3 向 8 位字符集添加简单归类1
10.14.4 向 Unicode 字符集添加 UCA 归类1
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.14 向字符集添加归类  /
10.14.1 归类实现类型
10.14.1 归类实现类型
MySQL 实现了几种类型的排序规则：
8 位字符集的简单排序规则
这种排序规则是使用一个包含 256 个权重的数组来实现的，该数组定义了从字符代码到权重的一对一映射。latin1_swedish_ci是一个例子。它是不区分大小写的排序规则，因此字符的大写和小写版本具有相同的权重，并且它们比较相等。
mysql> SET NAMES 'latin1' COLLATE 'latin1_swedish_ci';
Query OK, 0 rows affected (0.01 sec)
mysql> SELECT HEX(WEIGHT_STRING('a')), HEX(WEIGHT_STRING('A'));
+-------------------------+-------------------------+
| HEX(WEIGHT_STRING('a')) | HEX(WEIGHT_STRING('A')) |
+-------------------------+-------------------------+
| 41                      | 41                      |
+-------------------------+-------------------------+
1 row in set (0.01 sec)
mysql> SELECT 'a' = 'A';
+-----------+
| 'a' = 'A' |
+-----------+
|         1 |
+-----------+
1 row in set (0.12 sec)
有关实现说明，请参阅
第 10.14.3 节，“将简单排序规则添加到 8 位字符集”。
8 位字符集的复杂排序规则
这种排序规则是使用 C 源文件中的函数实现的，这些函数定义了如何对字符进行排序，如
第 10.13 节“添加字符集”中所述。
非 Unicode 多字节字符集的排序规则
对于这种类型的归类，8 位（单字节）和多字节字符的处理方式不同。对于 8 位字符，字符代码以不区分大小写的方式映射到权重。（例如单字节字符'a'和
'A'的权重都是
0x41。）对于多字节字符，字符编码和权重有两种关系：
权重等于字符代码。
sjis_japanese_ci是这种归类的一个例子。多字节字符
'ぢ'的字符代码为
0x82C0，权重也为
0x82C0。
mysql> CREATE TABLE t1
(c1 VARCHAR(2) CHARACTER SET sjis COLLATE sjis_japanese_ci);
Query OK, 0 rows affected (0.01 sec)
mysql> INSERT INTO t1 VALUES ('a'),('A'),(0x82C0);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0
mysql> SELECT c1, HEX(c1), HEX(WEIGHT_STRING(c1)) FROM t1;
+------+---------+------------------------+
| c1   | HEX(c1) | HEX(WEIGHT_STRING(c1)) |
+------+---------+------------------------+
| a    | 61      | 41                     |
| A    | 41      | 41                     |
| ぢ    | 82C0    | 82C0                   |
+------+---------+------------------------+
3 rows in set (0.00 sec)
字符代码与权重一一对应，但代码不一定等于权重。
gbk_chinese_ci是这种归类的一个例子。多字节字符
'膰'的字符代码为 ，
0x81B0但权重为
0xC286.
mysql> CREATE TABLE t1
(c1 VARCHAR(2) CHARACTER SET gbk COLLATE gbk_chinese_ci);
Query OK, 0 rows affected (0.33 sec)
mysql> INSERT INTO t1 VALUES ('a'),('A'),(0x81B0);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0
mysql> SELECT c1, HEX(c1), HEX(WEIGHT_STRING(c1)) FROM t1;
+------+---------+------------------------+
| c1   | HEX(c1) | HEX(WEIGHT_STRING(c1)) |
+------+---------+------------------------+
| a    | 61      | 41                     |
| A    | 41      | 41                     |
| 膰    | 81B0    | C286                   |
+------+---------+------------------------+
3 rows in set (0.00 sec)
有关实现说明，请参阅
第 10.13 节，“添加字符集”。
Unicode 多字节字符集的归类
其中一些归类基于 Unicode 归类算法 (UCA)，其他则不是。
非 UCA 归类具有从字符代码到权重的一对一映射。在 MySQL 中，此类排序规则不区分大小写和重音。utf8mb4_general_ci是一个例子：'a', 'A',
'À', 并且'á'每个都有不同的字符代码，但都具有权重
0x0041并且比较相等。
mysql> SET NAMES 'utf8mb4' COLLATE 'utf8mb4_general_ci';
Query OK, 0 rows affected (0.00 sec)
mysql> CREATE TABLE t1
(c1 CHAR(1) CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci);
Query OK, 0 rows affected (0.01 sec)
mysql> INSERT INTO t1 VALUES ('a'),('A'),('À'),('á');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0
mysql> SELECT c1, HEX(c1), HEX(WEIGHT_STRING(c1)) FROM t1;
+------+---------+------------------------+
| c1   | HEX(c1) | HEX(WEIGHT_STRING(c1)) |
+------+---------+------------------------+
| a    | 61      | 0041                   |
| A    | 41      | 0041                   |
| À    | C380    | 0041                   |
| á    | C3A1    | 0041                   |
+------+---------+------------------------+
4 rows in set (0.00 sec)
MySQL 中基于 UCA 的排序规则具有以下属性：
如果字符有权重，则每个权重使用 2 个字节（16 位）。
角色可能具有零权重（或空权重）。在这种情况下，该字符是可忽略的。示例：“U+0000 NULL”没有权重，可以忽略。
一个角色可能有一个权重。示例：
'a'权重为
0x0E33.
mysql> SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
Query OK, 0 rows affected (0.05 sec)
mysql> SELECT HEX('a'), HEX(WEIGHT_STRING('a'));
+----------+-------------------------+
| HEX('a') | HEX(WEIGHT_STRING('a')) |
+----------+-------------------------+
| 61       | 0E33                    |
+----------+-------------------------+
1 row in set (0.02 sec)
一个角色可能有很多权重。这是一个扩展。示例：德语字母'ß'（SZ 连字或 SHARP S）的权重为
0x0FEA0FEA.
mysql> SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
Query OK, 0 rows affected (0.11 sec)
mysql> SELECT HEX('ß'), HEX(WEIGHT_STRING('ß'));
+-----------+--------------------------+
| HEX('ß')  | HEX(WEIGHT_STRING('ß'))  |
+-----------+--------------------------+
| C39F      | 0FEA0FEA                 |
+-----------+--------------------------+
1 row in set (0.00 sec)
许多字符可能只有一种权重。这是收缩。示例：'ch'是捷克语中的单个字母，权重为0x0EE2.
mysql> SET NAMES 'utf8mb4' COLLATE 'utf8mb4_czech_ci';
Query OK, 0 rows affected (0.09 sec)
mysql> SELECT HEX('ch'), HEX(WEIGHT_STRING('ch'));
+-----------+--------------------------+
| HEX('ch') | HEX(WEIGHT_STRING('ch')) |
+-----------+--------------------------+
| 6368      | 0EE2                     |
+-----------+--------------------------+
1 row in set (0.00 sec)
多字符到多权重映射也是可能的（这是扩展收缩），但 MySQL 不支持。
有关实现说明，对于非 UCA 归类，请参阅
第 10.13 节，“添加字符集”。对于 UCA 归类，请参阅
第 10.14.4 节，“将 UCA 归类添加到 Unicode 字符集”。
杂项整理
还有一些排序规则不属于上述任何类别。
© Mysql 中文网
