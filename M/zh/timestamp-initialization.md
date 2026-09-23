# 11.2.5 TIMESTAMP 和 DATETIME 的自动初始化和更新_MySQL 8.0 参考手册

11.2.5 TIMESTAMP 和 DATETIME 的自动初始化和更新_MySQL 8.0 参考手册
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
11.2.5 TIMESTAMP 和 DATETIME 的自动初始化和更新
11.2.5 TIMESTAMP 和 DATETIME 的自动初始化和更新
TIMESTAMP和
DATETIME列可以自动初始化并更新为当前日期和时间（即当前时间戳）。
对于表中的任何TIMESTAMP或
DATETIME列，您可以将当前时间戳指定为默认值、自动更新值或两者：
对于没有为该列指定值的插入行，自动初始化列设置为当前时间戳。
当行中任何其他列的值从其当前值更改时，自动更新列将自动更新为当前时间戳。如果所有其他列都设置为其当前值，则自动更新的列将保持不变。要防止自动更新的列在其他列更改时更新，请将其显式设置为其当前值。要更新自动更新的列，即使其他列没有更改，请将其显式设置为应有的值（例如，将其设置为
CURRENT_TIMESTAMP）。
此外，如果
explicit_defaults_for_timestamp
系统变量被禁用，您可以通过为其分配一个值来将任何
TIMESTAMP（但不是
DATETIME）列初始化或更新为当前日期和时间NULL，除非它已被定义NULL为允许NULL值的属性。
要指定自动属性，请在列定义中使用DEFAULT
CURRENT_TIMESTAMPand子句。ON UPDATE
CURRENT_TIMESTAMP子句的顺序无关紧要。如果两者都存在于列定义中，则其中一个可以先出现。的任何同义词CURRENT_TIMESTAMP都与 具有相同的含义
CURRENT_TIMESTAMP。这些是
CURRENT_TIMESTAMP(),
NOW(),
LOCALTIME,
LOCALTIME(),
LOCALTIMESTAMP和
LOCALTIMESTAMP()。
DEFAULT CURRENT_TIMESTAMPand
的
使用ON UPDATE CURRENT_TIMESTAMP特定于
TIMESTAMPand
DATETIME。该
DEFAULT子句还可用于指定常量（非自动）默认值（例如，
DEFAULT 0or DEFAULT '2000-01-01
00:00:00'）。
笔记
以下示例使用DEFAULT 0, 一个默认值，它可以产生警告或错误，具体取决于是否
NO_ZERO_DATE启用了严格 SQL 模式或 SQL 模式。请注意，
TRADITIONALSQL 模式包括严格模式和
NO_ZERO_DATE. 请参阅
第 5.1.11 节，“服务器 SQL 模式”。
TIMESTAMP或
DATETIME列定义可以为默认值和自动更新值指定当前时间戳，为一个而不为另一个指定当前时间戳，或者两者都不指定。不同的列可以有不同的自动属性组合。以下规则描述了可能性：
对于DEFAULT CURRENT_TIMESTAMP和
ON UPDATE CURRENT_TIMESTAMP，该列的默认值具有当前时间戳，并自动更新为当前时间戳。
CREATE TABLE t1 (
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
有DEFAULT子句但没有ON
UPDATE CURRENT_TIMESTAMP子句，该列具有给定的默认值，并且不会自动更新为当前时间戳。
默认值取决于
DEFAULT子句指定
CURRENT_TIMESTAMP的还是常量值。对于CURRENT_TIMESTAMP，默认值为当前时间戳。
CREATE TABLE t1 (
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
dt DATETIME DEFAULT CURRENT_TIMESTAMP
);
对于常量，默认值为给定值。在这种情况下，该列根本没有自动属性。
CREATE TABLE t1 (
ts TIMESTAMP DEFAULT 0,
dt DATETIME DEFAULT 0
);
使用ON UPDATE CURRENT_TIMESTAMP
子句和常量DEFAULT子句，列会自动更新为当前时间戳并具有给定的常量默认值。
CREATE TABLE t1 (
ts TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
dt DATETIME DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP
);
有ON UPDATE CURRENT_TIMESTAMP
子句但没有DEFAULT子句，该列会自动更新为当前时间戳，但没有当前时间戳作为其默认值。
这种情况下的默认值取决于类型。
TIMESTAMP除非使用属性定义，否则默认值为 0 NULL，在这种情况下，默认值为NULL.
CREATE TABLE t1 (
ts1 TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,     -- default 0
ts2 TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP -- default NULL
);
DATETIMENULL除非使用属性定义，
否则NOT
NULL默认值为 0，在这种情况下默认值为 0。
CREATE TABLE t1 (
dt1 DATETIME ON UPDATE CURRENT_TIMESTAMP,         -- default NULL
dt2 DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP -- default 0
);
TIMESTAMPDATETIME除非明确指定，否则列没有自动属性，但以下情况除外：如果
系统
explicit_defaults_for_timestamp
变量被禁用，则第一
TIMESTAMP列同时具有这两个
属性DEFAULT CURRENT_TIMESTAMP，ON
UPDATE CURRENT_TIMESTAMP如果两者都没有明确指定。要抑制第一
TIMESTAMP列的自动属性，请使用以下策略之一：
启用
explicit_defaults_for_timestamp
系统变量。在这种情况下，指定自动初始化和更新的DEFAULT
CURRENT_TIMESTAMP和ON UPDATE
CURRENT_TIMESTAMP子句可用，但不会分配给任何TIMESTAMP
列，除非明确包含在列定义中。
或者，如果
explicit_defaults_for_timestamp
禁用，请执行以下任一操作：
DEFAULT
使用指定常量默认值
的子句定义列。
指定NULL属性。这也会导致列允许NULL
值，这意味着您不能通过将列设置为来分配当前时间戳
NULL。分配
NULL将列设置为
NULL，而不是当前时间戳。要分配当前时间戳，请将列设置为
CURRENT_TIMESTAMP或同义词，例如NOW()。
考虑这些表定义：
CREATE TABLE t1 (
ts1 TIMESTAMP DEFAULT 0,
ts2 TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE t2 (
ts1 TIMESTAMP NULL,
ts2 TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE t3 (
ts1 TIMESTAMP NULL DEFAULT 0,
ts2 TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP);
这些表具有以下属性：
在每个表定义中，第一
TIMESTAMP列没有自动初始化或更新。
这些表在ts1列处理NULL值的方式上有所不同。对于
t1, ts1is
NOT NULL并为其分配一个值，
NULL将其设置为当前时间戳。对于t2and t3，
ts1允许NULL并为其赋值 将其NULL设置为
NULL。
t2和t3的默认值不同ts1。对于
t2,ts1被定义为 permit NULL，因此默认也是
NULL在没有显式
DEFAULT子句的情况下。对于
t3，ts1允许
NULL但具有明确的默认值 0。
如果TIMESTAMP或
DATETIME列定义在任何地方包含显式小数秒精度值，则必须在整个列定义中使用相同的值。这是允许的：
CREATE TABLE t1 (
ts TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
);
这是不允许的：
CREATE TABLE t1 (
ts TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(3)
);
TIMESTAMP 初始化和 NULL 属性
如果
explicit_defaults_for_timestamp
系统变量被禁用，
TIMESTAMP列默认为
NOT NULL, 不能包含
NULL值，并且分配
NULL分配当前时间戳。要允许TIMESTAMP列包含
，请使用属性NULL显式声明它
。NULL在这种情况下，默认值也变为NULL除非被DEFAULT指定不同默认值的子句覆盖。DEFAULT NULL可用于明确指定NULL为默认值。（对于未用属性
TIMESTAMP
声明的列，无效。）如果
列允许
NULLDEFAULT NULLTIMESTAMPNULL值，分配
NULL将其设置为NULL，而不是当前时间戳。
下表包含多个
TIMESTAMP允许
NULL值的列：
CREATE TABLE t
(
ts1 TIMESTAMP NULL DEFAULT NULL,
ts2 TIMESTAMP NULL DEFAULT 0,
ts3 TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
);TIMESTAMP允许
NULL值
的列在插入时不
采用当前时间戳，除非在以下情况之一：
它的默认值定义为
CURRENT_TIMESTAMP并且没有为该列指定值
CURRENT_TIMESTAMP或其任何同义词，例如NOW()is explicitly inserted into the column
换句话说，TIMESTAMP
定义为允许NULL值的列只有在其定义包括以下内容时才会自动初始化
DEFAULT CURRENT_TIMESTAMP：
CREATE TABLE t (ts TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);
如果TIMESTAMP列允许
NULL值但其定义不包括DEFAULT CURRENT_TIMESTAMP，则必须显式插入与当前日期和时间对应的值。假设表t1和
t2具有以下定义：
CREATE TABLE t1 (ts TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00');
CREATE TABLE t2 (ts TIMESTAMP NULL DEFAULT NULL);
要TIMESTAMP在插入时将任一表中的列设置为当前时间戳，请显式为其分配该值。例如：
INSERT INTO t2 VALUES (CURRENT_TIMESTAMP);
INSERT INTO t1 VALUES (NOW());
如果
explicit_defaults_for_timestamp
启用了系统变量，则
TIMESTAMP列
仅在使用属性NULL声明时才允许值
。NULL此外，
TIMESTAMP列不允许分配NULL以分配当前时间戳，无论是用NULLor
NOT NULL属性声明的。要分配当前时间戳，请将列设置为
CURRENT_TIMESTAMP或同义词，例如NOW()。
© Mysql 中文网
