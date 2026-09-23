# 11.1.1 数字数据类型语法_MySQL 8.0 参考手册

11.1.1 数字数据类型语法_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.1.1 数字数据类型语法1
11.1.2 整数类型（精确值）——INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT1
11.1.3 定点类型（精确值）——DECIMAL、NUMERIC1
11.1.4 浮点类型（近似值）——FLOAT、DOUBLE1
11.1.5 比特值类型——BIT1
11.1.6 数值类型属性1
11.1.7 超出范围和溢出处理1
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.1 数值数据类型  /
11.1.1 数字数据类型语法
11.1.1 数字数据类型语法
对于整数数据类型，M指示最大显示宽度。最大显示宽度为 255。显示宽度与类型可以存储的值范围无关，如
第 11.1.6 节“数字类型属性”中所述。
对于浮点和定点数据类型，
M是可以存储的总位数。
从 MySQL 8.0.17 开始，不推荐使用整数数据类型的显示宽度属性；你应该期望在未来版本的 MySQL 中删除对它的支持。
如果您ZEROFILL为数字列指定，MySQL 会自动将UNSIGNED
属性添加到该列。
从 MySQL 8.0.17 开始，ZEROFILL不推荐使用数字数据类型的属性；你应该期望在未来版本的 MySQL 中删除对它的支持。考虑使用替代方法来产生此属性的效果。例如，应用程序可以使用该
LPAD()函数将数字补零到所需的宽度，或者它们可以将格式化后的数字存储在CHAR
列中。
UNSIGNED
允许该属性
的数字数据类型也允许SIGNED. 但是，默认情况下这些数据类型是有符号的，因此该
SIGNED属性无效。
从 MySQL 8.0.17 开始，不推荐使用,
, and
（以及任何同义词）UNSIGNED类型的列的属性
；你应该期望在未来版本的 MySQL 中删除对它的支持。考虑对此类列使用简单的
约束。
FLOATDOUBLEDECIMALCHECK
SERIAL是 的别名BIGINT
UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE。
SERIAL DEFAULT VALUE在整数列的定义中是 . 的别名NOT NULL AUTO_INCREMENT
UNIQUE。
警告
当您在类型为 的整数值之间使用减法时，除非启用了 SQL 模式，UNSIGNED否则结果是无符号的
。NO_UNSIGNED_SUBTRACTION请参阅第 12.11 节，“Cast 函数和运算符”。
BIT[(M)]
位值类型。M指示每个值的位数，从 1 到 64。如果
M省略，则默认为 1。
TINYINT[(M)]
[UNSIGNED] [ZEROFILL]
一个非常小的整数。有符号的范围是
-128到127。无符号范围是0到
255。
BOOL,
BOOLEAN
这些类型是
TINYINT(1). 零值被认为是错误的。非零值被认为是真的：
mysql> SELECT IF(0, 'true', 'false');
+------------------------+
| IF(0, 'true', 'false') |
+------------------------+
| false                  |
+------------------------+
mysql> SELECT IF(1, 'true', 'false');
+------------------------+
| IF(1, 'true', 'false') |
+------------------------+
| true                   |
+------------------------+
mysql> SELECT IF(2, 'true', 'false');
+------------------------+
| IF(2, 'true', 'false') |
+------------------------+
| true                   |
+------------------------+
但是，值TRUE和
FALSE分别只是 和 的别名
1，0如下所示：
mysql> SELECT IF(0 = FALSE, 'true', 'false');
+--------------------------------+
| IF(0 = FALSE, 'true', 'false') |
+--------------------------------+
| true                           |
+--------------------------------+
mysql> SELECT IF(1 = TRUE, 'true', 'false');
+-------------------------------+
| IF(1 = TRUE, 'true', 'false') |
+-------------------------------+
| true                          |
+-------------------------------+
mysql> SELECT IF(2 = TRUE, 'true', 'false');
+-------------------------------+
| IF(2 = TRUE, 'true', 'false') |
+-------------------------------+
| false                         |
+-------------------------------+
mysql> SELECT IF(2 = FALSE, 'true', 'false');
+--------------------------------+
| IF(2 = FALSE, 'true', 'false') |
+--------------------------------+
| false                          |
+--------------------------------+
最后两个语句显示所示结果，因为
2既不等于
1也不等于0。
SMALLINT[(M)]
[UNSIGNED] [ZEROFILL]
一个小整数。有符号的范围是
-32768到32767。无符号范围是0到
65535。
MEDIUMINT[(M)]
[UNSIGNED] [ZEROFILL]
一个中等大小的整数。有符号的范围是
-8388608到8388607。无符号范围是0到
16777215。
INT[(M)]
[UNSIGNED] [ZEROFILL]
一个正常大小的整数。有符号的范围是
-2147483648到
2147483647。无符号范围是
0到4294967295。
INTEGER[(M)]
[UNSIGNED] [ZEROFILL]
此类型是 的同义词
INT。
BIGINT[(M)]
[UNSIGNED] [ZEROFILL]
一个大整数。有符号的范围是
-9223372036854775808到
9223372036854775807。无符号范围是0到
18446744073709551615。
SERIAL是 的别名BIGINT
UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE。
BIGINT关于列
，您应该注意的一些事项
：
所有算术都是使用有符号
BIGINT或
值完成的，因此除了位函数外DOUBLE，您不应使用大于（63 位）的无符号大整数
！9223372036854775807如果这样做，结果中的某些最后数字可能会出错，因为在将
BIGINT值转换为
DOUBLE.
MySQL 可以处理BIGINT
以下情况：
使用整数在BIGINT列中存储大的无符号值时。
在
or
中，其中指的是列。
MIN(col_name)MAX(col_name)col_nameBIGINT
使用两个操作数都是整数的运算符（+、
-、
*等）时。
您始终可以
BIGINT通过使用字符串来存储列中的精确整数值。在这种情况下，MySQL 执行不涉及中间双精度表示的字符串到数字的转换。
当
两个操作数都是整数值时-，
+、 和
*
运算符使用算术。BIGINT这意味着如果您将两个大整数（或返回整数的函数的结果）相乘，当结果大于 时，您可能会得到意想不到的结果
9223372036854775807。
DECIMAL[(M[,D])]
[UNSIGNED] [ZEROFILL]
一个压缩的“精确”定点数。
M是总位数（精度），D是小数点后的位数（比例）。小数点和（对于负数）
-符号不计入
M. 如果
D为 0，则值没有小数点或小数部分。The maximum number of digits ( M) for
DECIMALis 65. The maximum number of supported decimals ( D) is 30. 如果D省略，则默认为 0。如果M省略，默认为 10。（文字文本的长度也有限制DECIMAL；请参阅第 12.25.3 节，“表达式处理”。）
UNSIGNED, 如果指定，则不允许负值。从 MySQL 8.0.17 开始，
UNSIGNED不推荐使用类型列DECIMAL（和任何同义词）的属性；你应该期望在未来版本的 MySQL 中删除对它的支持。考虑对此类列使用简单的CHECK约束。
所有包含列的基本计算 ( +, -, *, /)
DECIMAL都以 65 位的精度完成。
DEC[(M[,D])]
[UNSIGNED] [ZEROFILL],
,
NUMERIC[(M[,D])]
[UNSIGNED] [ZEROFILL]FIXED[(M[,D])]
[UNSIGNED] [ZEROFILL]
这些类型是
DECIMAL. 同义词可
FIXED用于与其他数据库系统兼容。
FLOAT[(M,D)]
[UNSIGNED] [ZEROFILL]
一个小的（单精度）浮点数。允许的值为-3.402823466E+38
to -1.175494351E-38、
0和1.175494351E-38
to 3.402823466E+38。这些是基于 IEEE 标准的理论限制。根据您的硬件或操作系统，实际范围可能会略小。
M是总位数，D是小数点后的位数。如果省略M
和D，则值将存储到硬件允许的限制范围内。单精度浮点数精确到大约 7 位小数。
FLOAT(M,D)
是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此语法已弃用，您应该期望在未来的 MySQL 版本中删除对它的支持。
UNSIGNED, 如果指定，则不允许负值。从 MySQL 8.0.17 开始，
UNSIGNED不推荐使用类型列FLOAT（和任何同义词）的属性，您应该期望在未来版本的 MySQL 中删除对它的支持。考虑对此类列使用简单的CHECK约束。
使用FLOAT可能会给您带来一些意想不到的问题，因为 MySQL 中的所有计算都是以双精度完成的。请参阅
第 B.3.4.7 节，“解决没有匹配行的问题”。
FLOAT(p)
[UNSIGNED] [ZEROFILL]
一个浮点数。p
表示以位为单位的精度，但 MySQL 使用此值仅用于确定是否使用
FLOAT或
DOUBLE用于结果数据类型。如果p是从 0 到 24，则数据类型变为FLOAT没有M或
D值。如果
p是从 25 到 53，则数据类型变为DOUBLE没有
M或D
值。结果列的范围与本节前面描述
的单精度FLOAT或双精度数据类型相同。DOUBLE
UNSIGNED, 如果指定，则不允许负值。从 MySQL 8.0.17 开始，
UNSIGNED不推荐使用类型列FLOAT（和任何同义词）的属性，您应该期望在未来版本的 MySQL 中删除对它的支持。考虑对此类列使用简单的CHECK约束。
FLOAT(p)
语法是为了 ODBC 兼容性而提供的。
DOUBLE[(M,D)]
[UNSIGNED] [ZEROFILL]
一个正常大小（双精度）的浮点数。允许的值为
-1.7976931348623157E+308to
-2.2250738585072014E-308、
0和
2.2250738585072014E-308to
1.7976931348623157E+308。这些是基于 IEEE 标准的理论限制。根据您的硬件或操作系统，实际范围可能会略小。
M是总位数，D是小数点后的位数。如果省略M
和D，则值将存储到硬件允许的限制范围内。双精度浮点数精确到大约 15 位小数。
DOUBLE(M,D)
是一个非标准的 MySQL 扩展。从 MySQL 8.0.17 开始，此语法已弃用，您应该期望在未来的 MySQL 版本中删除对它的支持。
UNSIGNED, 如果指定，则不允许负值。从 MySQL 8.0.17 开始，
UNSIGNED不推荐使用类型列DOUBLE（和任何同义词）的属性，您应该期望在未来版本的 MySQL 中删除对它的支持。考虑对此类列使用简单的CHECK约束。
DOUBLE
PRECISION[(M,D)]
[UNSIGNED] [ZEROFILL],
REAL[(M,D)]
[UNSIGNED] [ZEROFILL]
这些类型是
DOUBLE. 例外：如果
REAL_AS_FLOAT启用了 SQL 模式，REAL则 是 的同义词，FLOAT而不是
DOUBLE。
© Mysql 中文网
