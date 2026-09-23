# 9.1.4 十六进制文字_MySQL 8.0 参考手册

9.1.4 十六进制文字_MySQL 8.0 参考手册
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
9.1 文字值
9.1.1 字符串文字1
9.1.2 数字文字1
9.1.3 日期和时间文字1
9.1.4 十六进制文字1
9.1.5 位值文字1
9.1.6 布尔文字1
9.1.7 空值1
9.2 模式对象名称
9.3 关键字和保留字
9.4 用户自定义变量
9.5 表达式
9.6 查询属性
9.7 评论
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
MySQL 8.0 参考手册  / 第9章语言结构  / 9.1 文字值  /
9.1.4 十六进制文字
9.1.4 十六进制文字
十六进制文字值使用
或
符号书写，其中包含十六进制数字 ( , )。数字和任何前导的字母都无关紧要。前导区分大小写，不能写成.
X'val'0xvalval0..9A..FX0x0X
合法的十六进制文字：
X'01AF'
X'01af'
x'01AF'
x'01af'
0x01AF
0x01af
非法的十六进制文字：
X'0G'   (G is not a hexadecimal digit)
0X01AF  (0X must be written as 0x)
使用符号书写的值
必须包含偶数个数字，否则会出现语法错误。要更正此问题，请用前导零填充该值：
X'val'mysql> SET @s = X'FFF';
ERROR 1064 (42000): You have an error in your SQL syntax;
check the manual that corresponds to your MySQL server
version for the right syntax to use near 'X'FFF''
mysql> SET @s = X'0FFF';
Query OK, 0 rows affected (0.00 sec)使用包含奇数位的符号
编写的值
被视为具有额外的前导. 例如，
被解释为
。
0xval00xaaa0x0aaa
默认情况下，十六进制文字是二进制字符串，其中每对十六进制数字代表一个字符：
mysql> SELECT X'4D7953514C', CHARSET(X'4D7953514C');
+---------------+------------------------+
| X'4D7953514C' | CHARSET(X'4D7953514C') |
+---------------+------------------------+
| MySQL         | binary                 |
+---------------+------------------------+
mysql> SELECT 0x5461626c65, CHARSET(0x5461626c65);
+--------------+-----------------------+
| 0x5461626c65 | CHARSET(0x5461626c65) |
+--------------+-----------------------+
| Table        | binary                |
+--------------+-----------------------+
十六进制文字可能有一个可选的字符集介绍符和COLLATE子句，以将其指定为使用特定字符集和排序规则的字符串：
[_charset_name] X'val' [COLLATE collation_name]
例子：
SELECT _latin1 X'4D7953514C';
SELECT _utf8mb4 0x4D7953514C COLLATE utf8mb4_danish_ci;
这些示例使用
符号，但符号也允许引入者。有关介绍人的信息，请参阅第 10.3.8 节，“字符集介绍人”。
X'val'0xval
在数字上下文中，MySQL 将十六进制文字视为
BIGINT UNSIGNED（64 位无符号整数）。为确保对十六进制文字进行数字处理，请在数字上下文中使用它。执行此操作的方法包括添加 0 或使用
CAST(... AS UNSIGNED). 例如，分配给用户定义变量的十六进制文字在默认情况下是二进制字符串。要将值分配为数字，请在数字上下文中使用它：
mysql> SET @v1 = X'41';
mysql> SET @v2 = X'41'+0;
mysql> SET @v3 = CAST(X'41' AS UNSIGNED);
mysql> SELECT @v1, @v2, @v3;
+------+------+------+
| @v1  | @v2  | @v3  |
+------+------+------+
| A    |   65 |   65 |
+------+------+------+
空的十六进制值 ( X'') 计算为零长度二进制字符串。转换为数字，它产生 0：
mysql> SELECT CHARSET(X''), LENGTH(X'');
+--------------+-------------+
| CHARSET(X'') | LENGTH(X'') |
+--------------+-------------+
| binary       |           0 |
+--------------+-------------+
mysql> SELECT X''+0;
+-------+
| X''+0 |
+-------+
|     0 |
+-------+
该
表示法基于标准 SQL。该
表示法基于 ODBC，十六进制字符串通常用于为
列提供值。
X'val'0xBLOB
要将字符串或数字转换为十六进制格式的字符串，请使用以下HEX()函数：
mysql> SELECT HEX('cat');
+------------+
| HEX('cat') |
+------------+
| 636174     |
+------------+
mysql> SELECT X'636174';
+-----------+
| X'636174' |
+-----------+
| cat       |
+-----------+
对于十六进制文字，位操作被认为是数字上下文，但位操作允许 MySQL 8.0 及更高版本中的数字或二进制字符串参数。要为十六进制文字显式指定二进制字符串上下文，
_binary请对至少一个参数使用介绍符：
mysql> SET @v1 = X'000D' | X'0BC0';
mysql> SET @v2 = _binary X'000D' | X'0BC0';
mysql> SELECT HEX(@v1), HEX(@v2);
+----------+----------+
| HEX(@v1) | HEX(@v2) |
+----------+----------+
| BCD      | 0BCD     |
+----------+----------+
两个位操作的显示结果看起来相似，但是没有的结果_binary是一个
BIGINT值，而有的结果
_binary是一个二进制字符串。由于结果类型的不同，显示的值也不同： 数值结果不显示高位0位。
© Mysql 中文网
