# 11.2.1 日期和时间数据类型语法_MySQL 8.0 参考手册

11.2.1 日期和时间数据类型语法_MySQL 8.0 参考手册
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
11.2 日期和时间数据类型
11.2.1 日期和时间数据类型语法1
11.2.2 DATE、DATETIME 和 TIMESTAMP 类型1
11.2.3 时间类型1
11.2.4 YEAR 类型1
11.2.5 TIMESTAMP 和 DATETIME 的自动初始化和更新1
11.2.6 时间值中的小数秒1
11.2.7 日期和时间类型之间的转换1
11.2.8 日期中的两位数年份1
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.2 日期和时间数据类型  /
11.2.1 日期和时间数据类型语法
11.2.1 日期和时间数据类型语法
表示时间值的日期和时间数据类型有DATE、
TIME、
DATETIME、
TIMESTAMP和
YEAR。
对于范围描述，
DATE“
支持”意味着尽管早期的值可能有效，但不能保证。
DATETIME
MySQL 允许
、 和
值的小数秒TIME，
精度可达微秒（6 位）。要定义包含小数秒部分的列，请使用语法
，其中is
、
或
，并且
是小数秒精度。例如：
DATETIMETIMESTAMPtype_name(fsp)type_nameTIMEDATETIMETIMESTAMPfspCREATE TABLE t1 (t TIME(3), dt DATETIME(6), ts TIMESTAMP(0));
该fsp值（如果给定）必须在 0 到 6 的范围内。值 0 表示没有小数部分。如果省略，则默认精度为 0。（这与标准 SQL 默认值 6 不同，以与以前的 MySQL 版本兼容。）
表中的任何TIMESTAMP或
DATETIME列都可以具有自动初始化和更新属性；参见
第 11.2.5 节，“TIMESTAMP 和 DATETIME 的自动初始化和更新”。
DATE
一个约会。支持的范围是
'1000-01-01'到
'9999-12-31'. MySQL
DATE以格式显示值
，但允许使用字符串或数字
将值分配给
列。'YYYY-MM-DD'DATE
DATETIME[(fsp)]
日期和时间组合。支持的范围是
'1000-01-01 00:00:00.000000'到
'9999-12-31 23:59:59.999999'. MySQLDATETIME以格式显示值
，但允许使用字符串或数字
将值分配给
列。'YYYY-MM-DD
hh:mm:ss[.fraction]'DATETIME
可以给出 0 到 6 范围内的可选fsp值以指定小数秒精度。值为 0 表示没有小数部分。如果省略，则默认精度为 0。
DATETIME可以使用DEFAULT和
列定义子句指定列
的自动初始化和更新到当前日期和时间ON UPDATE，如第 11.2.5 节“TIMESTAMP 和 DATETIME 的自动初始化和更新”中所述。
TIMESTAMP[(fsp)]
一个时间戳。范围是'1970-01-01
00:00:01.000000'UTC 到'2038-01-19
03:14:07.999999'UTC。
值存储为自纪元（ UTC）TIMESTAMP以来的秒数。'1970-01-01 00:00:00'A
TIMESTAMP不能表示该值'1970-01-01 00:00:00'，因为它相当于从纪元开始的 0 秒，而值 0 保留用于表示“'0000-00-00
00:00:00'零”值
TIMESTAMP。
可以给出 0 到 6 范围内的可选fsp值以指定小数秒精度。值为 0 表示没有小数部分。如果省略，则默认精度为 0。
服务器处理TIMESTAMP
定义的方式取决于
explicit_defaults_for_timestamp
系统变量的值（请参阅
第 5.1.8 节，“服务器系统变量”）。
如果
explicit_defaults_for_timestamp
启用，则不会自动将
DEFAULT CURRENT_TIMESTAMP或ON
UPDATE CURRENT_TIMESTAMP属性分配给任何
TIMESTAMP列。它们必须显式包含在列定义中。此外，任何
TIMESTAMP未明确声明为NOT NULL允许
NULL值。
如果
explicit_defaults_for_timestamp
禁用，服务器处理TIMESTAMP
如下：
除非另有说明，否则表中的第一
TIMESTAMP列被定义为自动设置为最近修改的日期和时间（如果未明确分配值）。这TIMESTAMP
对于记录
INSERTor
UPDATE操作的时间戳很有用。您还可以TIMESTAMP通过为其分配一个值来将任何列设置为当前日期和时间
NULL，除非它已被定义NULL为允许
NULL值的属性。
可以使用列定义子句指定自动初始化DEFAULT
CURRENT_TIMESTAMP和更新到当前日期和时间。ON UPDATE
CURRENT_TIMESTAMP默认情况下，第一TIMESTAMP
列具有这些属性，如前所述。但是，TIMESTAMP表中的任何列都可以定义为具有这些属性。
TIME[(fsp)]
一个时间。范围'-838:59:59.000000'
是'838:59:59.000000'. MySQL
TIME以格式显示值
，但允许使用字符串或数字
将值分配给
列。'hh:mm:ss[.fraction]'TIME
可以给出 0 到 6 范围内的可选fsp值以指定小数秒精度。值为 0 表示没有小数部分。如果省略，则默认精度为 0。
YEAR[(4)]
4 位数格式的年份。MySQL
YEAR以格式显示值
，但允许
使用字符串或数字YYYY将值分配给列。YEAR值显示为
1901,2155或
0000。
有关
YEAR显示格式和输入值解释的其他信息，请参阅第 11.2.4 节，“YEAR 类型”。
笔记
从 MySQL 8.0.19 开始，
YEAR(4)不推荐使用具有显式显示宽度的数据类型；你应该期望在未来版本的 MySQL 中删除对它的支持。相反，使用YEAR不带显示宽度，这具有相同的含义。
MySQL 8.0 不支持
YEAR(2)旧版本 MySQL 中允许的 2 位数据类型。有关转换为 4-digit 的说明YEAR，请参阅
MySQL 5.7 Reference Manual中
的 2-Digit YEAR(2) Limitations and Migrating to 4-Digit YEAR。
和聚合函数SUM()不适
AVG()用于时间值。（他们将值转换为数字，在第一个非数字字符之后丢失所有内容。）要解决此问题，请转换为数字单位，执行聚合操作，然后转换回时间值。例子：
SELECT SEC_TO_TIME(SUM(TIME_TO_SEC(time_col))) FROM tbl_name;
SELECT FROM_DAYS(SUM(TO_DAYS(date_col))) FROM tbl_name;
© Mysql 中文网
