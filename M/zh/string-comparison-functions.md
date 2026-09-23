# 12.8.1 字符串比较函数和运算符_MySQL 8.0 参考手册

12.8.1 字符串比较函数和运算符_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.8.1 字符串比较函数和运算符1
12.8.2 正则表达式1
12.8.3 函数结果的字符集和整理1
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.8 字符串函数和运算符  /
12.8.1 字符串比较函数和运算符
12.8.1 字符串比较函数和运算符
表 12.13 字符串比较函数和运算符
姓名
描述
LIKE
简单模式匹配
NOT LIKE
简单模式匹配的否定
STRCMP()
比较两个字符串
如果给字符串函数一个二进制字符串作为参数，则生成的字符串也是一个二进制字符串。转换为字符串的数字被视为二进制字符串。这仅影响比较。
通常，如果字符串比较中的任何表达式区分大小写，则比较以区分大小写的方式执行。
如果从
mysql客户端中调用字符串函数，二进制字符串将使用十六进制表示法显示，具体取决于
--binary-as-hex. 有关该选项的更多信息，请参阅第 4.5.1 节，“mysql — MySQL 命令行客户端”。
expr
LIKE pat [ESCAPE
'escape_char']
使用 SQL 模式的模式匹配。返回
1( TRUE) 或
0( FALSE)。如果
expr或
pat是NULL，则结果是NULL。
模式不必是文字字符串。例如，它可以指定为字符串表达式或表列。在后一种情况下，该列必须定义为 MySQL 字符串类型之一（请参阅第 11.3 节，“字符串数据类型”）。
根据 SQL 标准，LIKE
在每个字符的基础上执行匹配，因此它可以产生与
=比较运算符不同的结果：
mysql> SELECT 'ä' LIKE 'ae' COLLATE latin1_german2_ci;
+-----------------------------------------+
| 'ä' LIKE 'ae' COLLATE latin1_german2_ci |
+-----------------------------------------+
|                                       0 |
+-----------------------------------------+
mysql> SELECT 'ä' = 'ae' COLLATE latin1_german2_ci;
+--------------------------------------+
| 'ä' = 'ae' COLLATE latin1_german2_ci |
+--------------------------------------+
|                                    1 |
+--------------------------------------+
特别是，尾随空格始终很重要。这不同于使用运算符执行的比较
，对于后者，非二进制字符串（ 、
和值）=中尾随空格的重要性
取决于用于比较的排序规则的 pad 属性。有关详细信息，请参阅
比较中的尾随空格处理。
CHARVARCHARTEXT
您可以在LIKE模式中使用以下两个通配符：
%匹配任意数量的字符，甚至零个字符。
_恰好匹配一个字符。
mysql> SELECT 'David!' LIKE 'David_';
-> 1
mysql> SELECT 'David!' LIKE '%D%v%';
-> 1
要测试通配符的文字实例，请在其前面加上转义字符。如果不指定ESCAPE字符，
\则假定为，除非
NO_BACKSLASH_ESCAPES启用了 SQL 模式。在这种情况下，不使用转义字符。
\%匹配一个%
字符。
\_匹配一个_
字符。
mysql> SELECT 'David!' LIKE 'David\_';
-> 0
mysql> SELECT 'David_' LIKE 'David\_';
-> 1
要指定不同的转义字符，请使用
ESCAPE子句：
mysql> SELECT 'David_' LIKE 'David|_' ESCAPE '|';
-> 1
转义序列应为一个字符长以指定转义字符，或为空以指定不使用转义字符。表达式必须在执行时计算为常量。如果
NO_BACKSLASH_ESCAPES开启了SQL模式，序列不能为空。
以下两个语句说明字符串比较不区分大小写，除非其中一个操作数区分大小写（使用区分大小写的排序规则或者是二进制字符串）：
mysql> SELECT 'abc' LIKE 'ABC';
-> 1
mysql> SELECT 'abc' LIKE _utf8mb4 'ABC' COLLATE utf8mb4_0900_as_cs;
-> 0
mysql> SELECT 'abc' LIKE _utf8mb4 'ABC' COLLATE utf8mb4_bin;
-> 0
mysql> SELECT 'abc' LIKE BINARY 'ABC';
-> 0
作为标准 SQL 的扩展，MySQL 允许
LIKE使用数字表达式。
mysql> SELECT 10 LIKE '1%';
-> 1
笔记
MySQL 在字符串中使用 C 转义语法（例如，
\n表示换行符）。如果你想让一个LIKE字符串包含一个文字\，你必须将它加倍。（除非
NO_BACKSLASH_ESCAPES启用了 SQL 模式，在这种情况下不使用转义字符。）例如，要搜索\n，请将其指定为\\n。要搜索
\，请将其指定为
\\\\；这是因为反斜杠被解析器剥离一次，并在进行模式匹配时再次剥离，留下一个反斜杠进行匹配。
例外：在模式字符串的末尾，反斜杠可以指定为\\. 在字符串的末尾，反斜杠代表它自己，因为后面没有要转义的内容。假设一个表包含以下值：
mysql> SELECT filename FROM t1;
+--------------+
| filename     |
+--------------+
| C:           |
| C:\          |
| C:\Programs  |
| C:\Programs\ |
+--------------+
要测试以反斜杠结尾的值，您可以使用以下任一模式匹配这些值：
mysql> SELECT filename, filename LIKE '%\\' FROM t1;
+--------------+---------------------+
| filename     | filename LIKE '%\\' |
+--------------+---------------------+
| C:           |                   0 |
| C:\          |                   1 |
| C:\Programs  |                   0 |
| C:\Programs\ |                   1 |
+--------------+---------------------+
mysql> SELECT filename, filename LIKE '%\\\\' FROM t1;
+--------------+-----------------------+
| filename     | filename LIKE '%\\\\' |
+--------------+-----------------------+
| C:           |                     0 |
| C:\          |                     1 |
| C:\Programs  |                     0 |
| C:\Programs\ |                     1 |
+--------------+-----------------------+
expr
NOT LIKE pat [ESCAPE
'escape_char']
这与.
NOT
(expr LIKE
pat [ESCAPE
'escape_char'])
笔记
NOT
LIKE涉及与包含的列进行比较的
聚合查询NULL可能会产生意外结果。例如，考虑下表和数据：
CREATE TABLE foo (bar VARCHAR(10));
INSERT INTO foo VALUES (NULL), (NULL);
查询SELECT COUNT(*) FROM foo WHERE bar LIKE
'%baz%';返回0。您可能会认为那SELECT COUNT(*) FROM foo WHERE bar
NOT LIKE '%baz%';会返回
2。然而，情况并非如此：第二个查询返回0。这是因为
总是返回
，而不管 的值如何
。对于涉及使用
or进行比较的聚合查询也是如此。在这种情况下，您必须明确测试使用
（而不是
），如下所示：
NULL NOT LIKE
exprNULLexprNULLNOT
RLIKENOT
REGEXPNOT NULLORANDSELECT COUNT(*) FROM foo WHERE bar NOT LIKE '%baz%' OR bar IS NULL;
STRCMP(expr1,expr2)
STRCMP()0如果字符串相同，
-1如果根据当前排序顺序第一个参数小于第二个参数，并且
NULL任一参数为
，则返回
NULL。1
否则
返回。mysql> SELECT STRCMP('text', 'text2');
-> -1
mysql> SELECT STRCMP('text2', 'text');
-> 1
mysql> SELECT STRCMP('text', 'text');
-> 0
STRCMP()使用参数的排序规则执行比较。
mysql> SET @s1 = _utf8mb4 'x' COLLATE utf8mb4_0900_ai_ci;
mysql> SET @s2 = _utf8mb4 'X' COLLATE utf8mb4_0900_ai_ci;
mysql> SET @s3 = _utf8mb4 'x' COLLATE utf8mb4_0900_as_cs;
mysql> SET @s4 = _utf8mb4 'X' COLLATE utf8mb4_0900_as_cs;
mysql> SELECT STRCMP(@s1, @s2), STRCMP(@s3, @s4);
+------------------+------------------+
| STRCMP(@s1, @s2) | STRCMP(@s3, @s4) |
+------------------+------------------+
|                0 |               -1 |
+------------------+------------------+
如果排序规则不兼容，则必须将其中一个参数转换为与另一个兼容。请参阅
第 10.8.4 节，“表达式中的整理强制性”。
mysql> SET @s1 = _utf8mb4 'x' COLLATE utf8mb4_0900_ai_ci;
mysql> SET @s2 = _utf8mb4 'X' COLLATE utf8mb4_0900_ai_ci;
mysql> SET @s3 = _utf8mb4 'x' COLLATE utf8mb4_0900_as_cs;
mysql> SET @s4 = _utf8mb4 'X' COLLATE utf8mb4_0900_as_cs;
-->
mysql> SELECT STRCMP(@s1, @s3);
ERROR 1267 (HY000): Illegal mix of collations (utf8mb4_0900_ai_ci,IMPLICIT)
and (utf8mb4_0900_as_cs,IMPLICIT) for operation 'strcmp'
mysql> SELECT STRCMP(@s1, @s3 COLLATE utf8mb4_0900_ai_ci);
+---------------------------------------------+
| STRCMP(@s1, @s3 COLLATE utf8mb4_0900_ai_ci) |
+---------------------------------------------+
|                                           0 |
+---------------------------------------------+
© Mysql 中文网
