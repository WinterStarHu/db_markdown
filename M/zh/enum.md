# 11.3.5 枚举类型_MySQL 8.0 参考手册

11.3.5 枚举类型_MySQL 8.0 参考手册
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
11.3 字符串数据类型
11.3.1 字符串数据类型语法1
11.3.2 CHAR 和 VARCHAR 类型1
11.3.3 BINARY 和 VARBINARY 类型1
11.3.4 BLOB 和 TEXT 类型1
11.3.5 枚举类型1
11.3.6 SET 类型1
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.3 字符串数据类型  /
11.3.5 枚举类型
11.3.5 枚举类型
AnENUM是一个字符串对象，其值选自创建表时在列规范中显式枚举的允许值列表。
有关
类型语法和长度限制
，
请参阅第 11.3.1 节，“字符串数据类型语法” 。ENUM
该ENUM类型具有以下优点：
在列具有一组有限的可能值的情况下紧凑的数据存储。您指定为输入值的字符串会自动编码为数字。有关该类型的存储要求，请参阅
第 11.7 节，“数据类型存储要求”ENUM。
可读的查询和输出。这些数字被翻译回查询结果中的相应字符串。
以及这些需要考虑的潜在问题：
如果您使枚举值看起来像数字，则很容易将文字值与其内部索引号混淆，如枚举限制中所述。
在子句中使用ENUM列ORDER
BY需要格外小心，如
枚举排序中所述。
创建和使用 ENUM 列枚举文字的索引值枚举文字的处理空或 NULL 枚举值枚举排序枚举限制
创建和使用 ENUM 列
枚举值必须是带引号的字符串文字。例如，您可以创建一个包含
ENUM如下列的表：
CREATE TABLE shirts (
name VARCHAR(40),
size ENUM('x-small', 'small', 'medium', 'large', 'x-large')
);
INSERT INTO shirts (name, size) VALUES ('dress shirt','large'), ('t-shirt','medium'),
('polo shirt','small');
SELECT name, size FROM shirts WHERE size = 'medium';
+---------+--------+
| name    | size   |
+---------+--------+
| t-shirt | medium |
+---------+--------+
UPDATE shirts SET size = 'small' WHERE size = 'large';
COMMIT;
向此表中插入 100 万行值为 的
'medium'行将需要 100 万字节的存储空间，而如果将实际字符串存储'medium'在
VARCHAR列中则需要 600 万字节。
枚举文字的索引值
每个枚举值都有一个索引：
列规范中列出的元素分配有索引号，从 1 开始。
空字符串错误值的索引值为 0。这意味着您可以使用以下
SELECT语句查找ENUM分配了无效值的行：
mysql> SELECT * FROM tbl_name WHERE enum_col=0;
该NULL值的索引是
NULL。
这里的术语“索引”是指枚举值列表中的位置。它与表索引无关。
例如，指定为的列ENUM('Mercury',
'Venus', 'Earth')可以具有此处显示的任何值。还显示了每个值的索引。
价值
指数
NULL
NULL
''
0
'Mercury'
1个
'Venus'
2个
'Earth'
3个
一ENUM列最多可以有 65,535 个不同的元素。
如果您ENUM在数字上下文中检索值，则会返回列值的索引。ENUM例如，您可以像这样从列
中检索数值
：mysql> SELECT enum_col+0 FROM tbl_name;
如有必要SUM()，
AVG()期望数字参数的函数将参数转换为数字。对于
ENUM值，索引号用于计算。
枚举文字的处理
ENUM创建表时，
会自动从表定义中的成员值中删除尾随空格
。
检索时，存储在ENUM
列中的值使用列定义中使用的字母大小写显示。请注意，ENUM可以为列分配字符集和排序规则。对于二进制或区分大小写的归类，在为列赋值时会考虑字母大小写。
如果将数字存储到ENUM列中，则该数字被视为可能值的索引，存储的值是具有该索引的枚举成员。（但是，这不适用于，
LOAD DATA它将所有输入都视为字符串。）如果数值被引用，并且在枚举值列表中没有匹配的字符串，它仍被解释为索引。由于这些原因，不建议ENUM使用看起来像数字的枚举值来定义列，因为这很容易造成混淆。例如，以下列的枚举成员的字符串值为
'0'、'1'和
'2'1，但是、2和
的数字索引值
3：
numbers ENUM('0','1','2')
如果存储2，它会被解释为索引值，并变为'1'（索引为 2 的值）。如果你存储'2'，它匹配一个枚举值，所以它被存储为
'2'。如果存储'3'，则它不匹配任何枚举值，因此将其视为索引并变为'2'（索引为3的值）。
mysql> INSERT INTO t (numbers) VALUES(2),('2'),('3');
mysql> SELECT * FROM t;
+---------+
| numbers |
+---------+
| 1       |
| 2       |
| 2       |
+---------+
要确定列的所有可能值，请
ENUM使用
并解析
输出列中的
定义
。SHOW COLUMNS
FROM tbl_name LIKE
'enum_col'ENUMType
在 C API 中，ENUM值以字符串形式返回。有关使用结果集元数据将它们与其他字符串区分开来的信息，请参阅
C API 基本数据结构。
空或 NULL 枚举值
枚举值也可以是空字符串 ( '') 或NULL在某些情况下：
如果将无效值插入 an
ENUM（即允许值列表中不存在的字符串），则会插入空字符串作为特殊错误值。该字符串的数值为 0，因此可以将该字符串与“普通”空字符串
区分开来。有关枚举值的数字索引的详细信息，请参阅枚举文字的索引值。
如果启用了严格的 SQL 模式，则尝试插入无效
ENUM值会导致错误。
如果ENUM列声明为 permit
NULL，则该NULL值为该列的有效值，默认值为
NULL。如果ENUM
声明了一个列NOT NULL，则其默认值是允许值列表的第一个元素。
枚举排序
ENUM值根据它们的索引号排序，这取决于枚举成员在列规范中列出的顺序。例如，
在for
'b'之前排序。空字符串排在非空字符串之前，值排在所有其他枚举值之前。
'a'ENUM('b', 'a')NULL
为防止ORDER
BY在列上使用子句时出现意外结果，请ENUM使用以下技术之一：
按字母顺序指定ENUM列表。
确保列按词法排序，而不是通过编码或
按索引号排序。
ORDER BY
CAST(col AS CHAR)ORDER BY
CONCAT(col)
枚举限制
枚举值不能是表达式，即使计算结果为字符串值也是如此。
例如，此CREATE TABLE
语句不起作用，因为该
CONCAT函数不能用于构造枚举值：
CREATE TABLE sizes (
size ENUM('small', CONCAT('med','ium'), 'large')
);
您也不能将用户变量用作枚举值。这对语句不起作用
：
SET @mysize = 'medium';
CREATE TABLE sizes (
size ENUM('small', @mysize, 'large')
);
我们强烈建议您不要使用数字作为枚举值，因为它不会在适当
TINYINT或
SMALLINT类型上节省存储空间，并且如果您很容易混淆字符串和基础数字值（可能不相同）错误地引用
ENUM值。如果确实使用数字作为枚举值，请始终将其括在引号中。如果省略引号，则该数字被视为索引。请参阅枚举文字的处理，了解如何将带引号的数字错误地用作数字索引值。
如果启用了严格的 SQL 模式，则定义中的重复值会导致警告或错误。
© Mysql 中文网
