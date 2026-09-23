# 10.8.5 二进制排序规则与 _bin 排序规则的比较_MySQL 8.0 参考手册

10.8.5 二进制排序规则与 _bin 排序规则的比较_MySQL 8.0 参考手册
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
10.8.1 在 SQL 语句中使用 COLLATE1
10.8.2 COLLATE 子句优先级1
10.8.3 字符集和排序规则兼容性1
10.8.4 表达式中的排序规则强制性1
10.8.5 二进制排序规则与 _bin 排序规则的比较1
10.8.6 整理效果示例1
10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则1
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.8 整理问题  /
10.8.5 二进制排序规则与 _bin 排序规则的比较
10.8.5 二进制排序规则与 _bin 排序规则的比较
本节介绍二进制字符串的排序规则与非binary
二进制字符串的排序规则的比较_bin
。
二进制字符串（使用 、 和 数据类型存储
BINARY）
VARBINARY有
BLOB一个名为binary. 二进制字符串是字节序列，这些字节的数值决定比较和排序顺序。请参阅
第 10.10.8 节，“二进制字符集”。
非二进制字符串（使用 、 和 数据类型存储
CHAR）
VARCHAR的
TEXT字符集和排序规则不是binary. 一个给定的非二进制字符集可以有多个排序规则，每个排序规则为该集中的字符定义一个特定的比较和排序顺序。对于大多数字符集，其中之一是二进制排序规则，由_bin
排序规则名称中的后缀表示。例如， 和 的二进制排序规则分别
命名为latin1和。
是一个具有两个二进制排序规则的异常，并且
; 看
big5latin1_binbig5_binutf8mb4utf8mb4_binutf8mb4_0900_bin第 10.10.1 节，“Unicode 字符集”。
binary排序规则在几个方面不同于
排序规则，
将_bin在以下部分中讨论：
比较排序单元字符集转换字母大小写转换比较中的尾随空格处理插入和检索的尾随空间处理
比较排序单元
二进制字符串是字节序列。对于
binary排序规则，比较和排序基于数字字节值。非二进制字符串是字符序列，可能是多字节的。非二进制字符串的排序规则定义用于比较和排序的字符值的顺序。对于_bin
排序规则，此排序基于数字字符代码值，这类似于二进制字符串的排序，只是字符代码值可能是多字节。
字符集转换
非二进制字符串具有一个字符集，并且在许多情况下会自动转换为另一个字符集，即使该字符串具有_bin排序规则：
将列值分配给具有不同字符集的另一列时：
UPDATE t1 SET utf8mb4_bin_column=latin1_column;
INSERT INTO t1 (latin1_column) SELECT utf8mb4_bin_column FROM t2;INSERT为或
UPDATE使用字符串文字
分配列值时
：SET NAMES latin1;
INSERT INTO t1 (utf8mb4_bin_column) VALUES ('string-in-latin1');
将结果从服务器发送到客户端时：
SET NAMES latin1;
SELECT utf8mb4_bin_column FROM t2;
对于二进制字符串列，不会发生转换。对于与前面类似的情况，字符串值是按字节复制的。
字母大小写转换
非二进制字符集的归类提供有关字符字母大小写的信息，因此非二进制字符串中的字符可以从一种字母转换为另一种，即使对于_bin忽略字母大小写排序的归类也是如此：
mysql> SET NAMES utf8mb4 COLLATE utf8mb4_bin;
mysql> SELECT LOWER('aA'), UPPER('zZ');
+-------------+-------------+
| LOWER('aA') | UPPER('zZ') |
+-------------+-------------+
| aa          | ZZ          |
+-------------+-------------+
字母大小写的概念不适用于二进制字符串中的字节。要执行字母大小写转换，必须首先使用适合字符串中存储的数据的字符集将字符串转换为非二进制字符串：
mysql> SET NAMES binary;
mysql> SELECT LOWER('aA'), LOWER(CONVERT('aA' USING utf8mb4));
+-------------+------------------------------------+
| LOWER('aA') | LOWER(CONVERT('aA' USING utf8mb4)) |
+-------------+------------------------------------+
| aA          | aa                                 |
+-------------+------------------------------------+
比较中的尾随空格处理
MySQL 排序规则有一个 pad 属性，它的值为
PAD SPACEor NO PAD：
大多数 MySQL 排序规则都有一个 pad 属性PAD
SPACE。
基于 UCA 9.0.0 及更高版本的 Unicode 归类具有 pad 属性NO PAD；参见
第 10.10.1 节，“Unicode 字符集”。
对于非二进制字符串（CHAR、
VARCHAR和TEXT
值），字符串归类垫属性决定了比较字符串末尾尾随空格时的处理方式：
对于PAD SPACE排序规则，尾随空格在比较中是微不足道的；比较字符串时不考虑尾随空格。
NO PAD排序规则将尾随空格视为比较中的重要字符，就像任何其他字符一样。
可以使用两个
utf8mb4二进制排序规则来演示不同的行为，其中一个是
PAD SPACE，另一个是
NO PAD。该示例还展示了如何使用该INFORMATION_SCHEMA
COLLATIONS表来确定排序规则的 pad 属性。
mysql> SELECT COLLATION_NAME, PAD_ATTRIBUTE
FROM INFORMATION_SCHEMA.COLLATIONS
WHERE COLLATION_NAME LIKE 'utf8mb4%bin';
+------------------+---------------+
| COLLATION_NAME   | PAD_ATTRIBUTE |
+------------------+---------------+
| utf8mb4_bin      | PAD SPACE     |
| utf8mb4_0900_bin | NO PAD        |
+------------------+---------------+
mysql> SET NAMES utf8mb4 COLLATE utf8mb4_bin;
mysql> SELECT 'a ' = 'a';
+------------+
| 'a ' = 'a' |
+------------+
|          1 |
+------------+
mysql> SET NAMES utf8mb4 COLLATE utf8mb4_0900_bin;
mysql> SELECT 'a ' = 'a';
+------------+
| 'a ' = 'a' |
+------------+
|          0 |
+------------+
笔记
在此上下文中的“比较”不包括LIKE模式匹配运算符，无论排序规则如何，尾随空格都很重要。
对于二进制字符串（BINARY、
VARBINARY和BLOB
值），所有字节在比较中都很重要，包括尾随空格：
mysql> SET NAMES binary;
mysql> SELECT 'a ' = 'a';
+------------+
| 'a ' = 'a' |
+------------+
|          0 |
+------------+
插入和检索的尾随空间处理
CHAR(N)列存储非二进制字符串N
字符长。对于插入，短于
N字符的值用空格扩展。对于检索，删除尾随空格。
BINARY(N)
列存储二进制字符串N
字节长。对于插入，短于
N字节的值用字节扩展
0x00。对于检索，不会删除任何内容；始终返回声明长度的值。
mysql> CREATE TABLE t1 (
a CHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
b BINARY(10)
);
mysql> INSERT INTO t1 VALUES ('x','x');
mysql> INSERT INTO t1 VALUES ('x ','x ');
mysql> SELECT a, b, HEX(a), HEX(b) FROM t1;
+------+------------------------+--------+----------------------+
| a    | b                      | HEX(a) | HEX(b)               |
+------+------------------------+--------+----------------------+
| x    | 0x78000000000000000000 | 78     | 78000000000000000000 |
| x    | 0x78200000000000000000 | 78     | 78200000000000000000 |
+------+------------------------+--------+----------------------+
© Mysql 中文网
