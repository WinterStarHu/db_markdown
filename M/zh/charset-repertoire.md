# 10.2.1 字符集指令表_MySQL 8.0 参考手册

10.2.1 字符集指令表_MySQL 8.0 参考手册
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
10.2.1 字符集指令表1
10.2.2 元数据的 UTF-81
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.2 MySQL 中的字符集和排序规则  /
10.2.1 字符集指令表
10.2.1 字符集指令表
字符集
的指令表是字符集中字符的集合。
字符串表达式有一个 repertoire 属性，它可以有两个值：
ASCII: 表达式只能包含 ASCII 字符；也就是说，Unicode 范围内的字符
U+0000到U+007F.
UNICODE: 表达式可以包含 Unicode 范围内的字符U+0000到
U+10FFFF. 这包括基本多语言平面 (BMP) 范围内的字符 ( U+0000to U+FFFF) 和 BMP 范围外的补充字符 ( U+10000to U+10FFFF)。
ASCII范围是范围的子集
，UNICODE因此
ASCII可以将具有指令的字符串安全地转换为任何具有指令的字符串的字符集而不会丢失信息UNICODE。它还可以安全地转换为作为字符集超集的任何
ascii字符集。（所有 MySQL 字符集都是 的超集，ascii除了swe7，它为瑞典重音字符重用了一些标点符号。）
在许多情况下，使用 repertoire 可以在表达式中进行字符集转换，否则当排序规则可强制性规则不足以解决歧义时
，MySQL 会返回
“非法排序规则混合”错误。（有关强制性的信息，请参阅
第 10.8.4 节，“表达式中的整理强制性”。）
以下讨论提供了表达式及其指令集的示例，并描述了指令集的使用如何更改字符串表达式评估：
字符串常量的指令表取决于字符串内容，并且可能与字符串字符集的指令表不同。考虑这些陈述：
SET NAMES utf8mb4; SELECT 'abc';
SELECT _utf8mb4'def';
虽然字符集在前面的每一种情况下，但字符串实际上不
utf8mb4包含 ASCII 范围之外的任何字符，因此它们的全部内容是.
ASCIIUNICODE
具有字符集的列因其字符集而ascii具有保留曲目。ASCII在下表中，c1
有ASCII保留曲​​目：
CREATE TABLE t1 (c1 CHAR(1) CHARACTER SET ascii);
下面的示例说明了在没有指令表的情况下发生错误的情况下指令表如何使结果得以确定：
CREATE TABLE t1 (
c1 CHAR(1) CHARACTER SET latin1,
c2 CHAR(1) CHARACTER SET ascii
);
INSERT INTO t1 VALUES ('a','b');
SELECT CONCAT(c1,c2) FROM t1;
没有保留曲目，出现这个错误：
ERROR 1267 (HY000): Illegal mix of collations (latin1_swedish_ci,IMPLICIT)
and (ascii_general_ci,IMPLICIT) for operation 'concat'
使用曲目，可以发生子集到超集（ascii到latin1）的转换并返回结果：
+---------------+
| CONCAT(c1,c2) |
+---------------+
| ab            |
+---------------+
带有一个字符串参数的函数继承了它们参数的全部内容。结果
UPPER(_utf8mb4'abc')有
ASCII保留曲目，因为它的论证有
ASCII保留曲目。（尽管有
_utf8mb4介绍者，该字符串
'abc'不包含 ASCII 范围之外的字符。）
对于返回字符串但没有字符串参数并
character_set_connection用作结果字符集的函数，结果指令是
ASCIIif
character_set_connectionis
ascii，UNICODE
否则：
FORMAT(numeric_column, 4);
使用 repertoire 改变了 MySQL 评估以下示例的方式：
SET NAMES ascii;
CREATE TABLE t1 (a INT, b VARCHAR(10) CHARACTER SET latin1);
INSERT INTO t1 VALUES (1,'b');
SELECT CONCAT(FORMAT(a, 4), b) FROM t1;
没有保留曲目，出现这个错误：
ERROR 1267 (HY000): Illegal mix of collations (ascii_general_ci,COERCIBLE)
and (latin1_swedish_ci,IMPLICIT) for operation 'concat'
有了repertoire，返回一个结果：
+-------------------------+
| CONCAT(FORMAT(a, 4), b) |
+-------------------------+
| 1.0000b                 |
+-------------------------+
具有两个或更多字符串参数的函数使用
“最宽”的参数表作为结果表，其中UNICODE比
ASCII. 考虑以下
CONCAT()调用：
CONCAT(_ucs2 X'0041', _ucs2 X'0042')
CONCAT(_ucs2 X'0041', _ucs2 X'00C2')
对于第一次调用，曲目是
ASCII因为两个参数都在 ASCII 范围内。对于第二次调用，曲目是
UNICODE因为第二个参数超出了 ASCII 范围。
函数返回值的指令表仅根据影响结果字符集和排序规则的那些参数的指令表来确定。
IF(column1 < column2, 'smaller', 'greater')
结果曲目是ASCII因为两个字符串参数（第二个参数和第三个参数）都有ASCII曲目。第一个参数对于结果指令集无关紧要，即使表达式使用字符串值也是如此。
© Mysql 中文网
