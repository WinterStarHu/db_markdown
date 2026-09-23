# 11.3.1 字符串数据类型语法_MySQL 8.0 参考手册

11.3.1 字符串数据类型语法_MySQL 8.0 参考手册
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
11.3.1 字符串数据类型语法
11.3.1 字符串数据类型语法
字符串数据类型为CHAR,
VARCHAR,
BINARY,
VARBINARY,
BLOB,
TEXT,
ENUM和
SET。
CREATE
TABLE在某些情况下，MySQL 可能会将字符串列更改为与orALTER TABLE
语句
中给定的类型不同的类型。请参阅第 13.1.20.7 节，“静默列规范更改”。
对于字符串列（CHAR、
VARCHAR和
TEXT类型）的定义，MySQL 以字符单位解释长度规范。对于二进制字符串列（BINARY、
VARBINARY和
BLOB类型）的定义，MySQL 以字节为单位解释长度规范。
字符串数据类型
CHAR（ 、
VARCHAR、
TEXT类型、
ENUM、
SET和任何同义词）的列定义可以指定列字符集和排序规则：
CHARACTER SET指定字符集。如果需要，可以使用该COLLATE属性以及任何其他属性指定字符集的排序规则。例如：
CREATE TABLE t
(
c1 VARCHAR(20) CHARACTER SET utf8mb4,
c2 TEXT CHARACTER SET latin1 COLLATE latin1_general_cs
);
此表定义创建一个名为的列
，该列c1的字符集
utf8mb4为该字符集的默认排序规则，以及一个名为的列，该列c2
的字符集为latin1，排序规则区分大小写 ( _cs)。
第 10.3.5 节，“列字符集和排序规则”CHARACTER SET中描述了
当COLLATE缺少
一个或两个属性时分配字符集和排序规则的规则。
CHARSET是的同义词
CHARACTER SET。
指定CHARACTER SET binary
字符串数据类型的属性会导致将列创建为相应的二进制字符串数据类型：
CHAR成为
BINARY、
VARCHAR成为
VARBINARY和
TEXT成为
BLOB。对于
ENUMand
SET数据类型，这不会发生；它们是按照声明创建的。假设您使用此定义指定一个表：
CREATE TABLE t
(
c1 VARCHAR(10) CHARACTER SET binary,
c2 TEXT CHARACTER SET binary,
c3 ENUM('a','b','c') CHARACTER SET binary
);
结果表具有以下定义：
CREATE TABLE t
(
c1 VARBINARY(10),
c2 BLOB,
c3 ENUM('a','b','c') CHARACTER SET binary
);
该BINARY属性是一个非标准的 MySQL 扩展，它是指定_bin列字符集（如果未指定列字符集，则为表默认字符集）的二进制 () 排序规则的简写。在这种情况下，比较和排序基于数字字符代码值。假设您使用此定义指定一个表：
CREATE TABLE t
(
c1 VARCHAR(10) CHARACTER SET latin1 BINARY,
c2 TEXT BINARY
) CHARACTER SET utf8mb4;
结果表具有以下定义：
CREATE TABLE t (
c1 VARCHAR(10) CHARACTER SET latin1 COLLATE latin1_bin,
c2 TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) CHARACTER SET utf8mb4;
在 MySQL 8.0 中，该
BINARY属性的这种非标准使用是不明确的，因为
utf8mb4字符集有多个
_bin排序规则。从 MySQL 8.0.17 开始，该
BINARY属性已弃用，您应该期望在未来的 MySQL 版本中删除对它的支持。应调整应用程序以改为使用显式_bin排序规则。
使用BINARY指定数据类型或字符集保持不变。
该ASCII属性是 的简写
CHARACTER SET latin1。在较旧的 MySQL 版本中受支持，ASCII在 MySQL 8.0.28 及更高版本中已弃用；改用CHARACTER SET
。
该UNICODE属性是 的简写
CHARACTER SET ucs2。在较旧的 MySQL 版本中受支持，UNICODE在 MySQL 8.0.28 及更高版本中已弃用；改用CHARACTER SET
。
字符列比较和排序基于分配给该列的排序规则。对于
CHAR、
VARCHAR、
TEXT、
ENUM和
SET数据类型，您可以声明一个具有二进制 ( _bin) 排序规则或
BINARY属性的列，以进行比较和排序以使用基础字符代码值而不是词法排序。
有关在 MySQL 中使用字符集的其他信息，请参阅第 10 章，字符集、排序规则、Unicode。
[NATIONAL] CHAR[(M)]
[CHARACTER SET charset_name]
[COLLATE
collation_name]
一个固定长度的字符串，在存储时总是用空格向右填充到指定的长度。
M表示以字符为单位的列长度。取值范围M为0~255 M，省略则长度为1。
笔记
除非启用 SQL 模式，
CHAR否则在检索值
时会删除尾随空格
。PAD_CHAR_TO_FULL_LENGTH
CHAR是 的简写
CHARACTER。
NATIONAL CHAR（或其等效的缩写形式，NCHAR）是定义
CHAR列应使用某些预定义字符集的标准 SQL 方式。MySQL 使用
utf8mb3这个预定义的字符集。
第 10.3.7 节，“国家字符集”。
CHAR BYTE数据类型是数据类型的
别名BINARY。这是一个兼容性功能。
MySQL 允许您创建类型的列
CHAR(0)。这主要在您必须与依赖于列的存在但实际上不使用其值的旧应用程序兼容时有用。CHAR(0)当您需要一个只能取两个值的列时也非常好：定义为CHAR(0) NULL仅占用一位并且只能取值
NULL和''（空字符串）的列。
[NATIONAL] VARCHAR(M)
[CHARACTER SET charset_name]
[COLLATE
collation_name]
可变长度字符串。M
表示以字符为单位的最大列长度。的范围M是 0 到 65,535。a 的有效最大长度
VARCHAR取决于最大行大小（65,535 字节，由所有列共享）和使用的字符集。例如，
utf8mb3字符每个字符最多需要三个字节，因此
VARCHAR使用该
utf8mb3字符集的列可以声明为最多 21,844 个字符。请参阅
第 8.4.7 节，“表列数和行大小的限制”。
MySQL 将VARCHAR值存储为 1 字节或 2 字节长度的前缀加上数据。长度前缀指示值中的字节数。如果值需要不超过 255 个字节，一
VARCHAR列使用一个长度字节，如果值可能需要超过 255 个字节，则使用两个长度字节。
笔记
MySQL 遵循标准 SQL 规范，不会
从VARCHAR值
中删除尾随空格
。
VARCHAR是 的简写
CHARACTER VARYING。
NATIONAL VARCHAR是定义
VARCHAR列应使用某些预定义字符集的标准 SQL 方法。MySQL 使用
utf8mb3这个预定义的字符集。
第 10.3.7 节，“国家字符集”。
NVARCHAR是 的简写
NATIONAL VARCHAR。
BINARY[(M)]
BINARY类型类似于类型
，CHAR但存储二进制字节字符串而不是非二进制字符串。可选长度M表示以字节为单位的列长度。如果省略，
M则默认为 1。
VARBINARY(M)
VARBINARY类型类似于类型
，VARCHAR但存储二进制字节字符串而不是非二进制字符串。M表示以字节为单位的最大列长度。
TINYBLOB
BLOB最大长度为 255 (2 8 − 1) 个字节
的列。每个TINYBLOB值都使用 1 字节长度的前缀存储，该前缀指示值中的字节数。
TINYTEXT
[CHARACTER SET charset_name]
[COLLATE
collation_name]
TEXT最大长度为 255 (2 8 − 1) 个字符
的列。如果值包含多字节字符，则有效最大长度会更短。每个
TINYTEXT值都使用 1 字节长度的前缀存储，该前缀指示值中的字节数。
BLOB[(M)]
BLOB最大长度为 65,535 (2 16 − 1) 字节
的列。每个BLOB值都使用 2 字节长度的前缀存储，该前缀指示值中的字节数。
M可以为这种类型给出
一个可选的长度。如果这样做，MySQL 将创建该列作为最小的BLOB类型，其大小足以容纳值M字节长。
TEXT[(M)]
[CHARACTER SET charset_name]
[COLLATE
collation_name]
TEXT最大长度为 65,535 (2 16 − 1) 个字符
的列。如果值包含多字节字符，则有效最大长度会更短。每个
TEXT值都使用 2 字节长度的前缀存储，该前缀指示值中的字节数。
M可以为这种类型给出
一个可选的长度。如果这样做，MySQL 将创建该列作为最小的TEXT类型，其大小足以容纳值M
字符的长度。
MEDIUMBLOB
BLOB最大长度为 16,777,215 (2 24 − 1) 字节
的列。每个MEDIUMBLOB
值都使用 3 字节长度的前缀存储，该前缀指示值中的字节数。
MEDIUMTEXT
[CHARACTER SET charset_name]
[COLLATE
collation_name]
TEXT最大长度为 16,777,215 (2 24 − 1) 个字符
的列。如果值包含多字节字符，则有效最大长度会更短。每个
MEDIUMTEXT值都使用 3 字节长度的前缀存储，该前缀指示值中的字节数。
LONGBLOB
BLOB最大长度为 4,294,967,295 或 4GB (2 32 − 1) 字节
的列。列的有效最大长度
LONGBLOB取决于客户端/服务器协议中配置的最大数据包大小和可用内存。每个
LONGBLOB值都使用 4 字节长度前缀存储，该前缀指示值中的字节数。
LONGTEXT
[CHARACTER SET charset_name]
[COLLATE
collation_name]
TEXT最大长度为 4,294,967,295 或 4GB (2 32 − 1) 个字符
的列。如果值包含多字节字符，则有效最大长度会更短。列的有效最大长度
LONGTEXT
还取决于客户端/服务器协议中配置的最大数据包大小和可用内存。每个
LONGTEXT
值都使用 4 字节长度前缀存储，该前缀指示值中的字节数。
ENUM('value1','value2',...)
[CHARACTER SET charset_name]
[COLLATE
collation_name]
枚举。一个字符串对象，它只能有一个值，从值列表
、 、或
特殊
错误值中选择。
值在内部表示为整数。
'value1''value2'...NULL''ENUM
一ENUM列最多可以有 65,535 个不同的元素。
单个
ENUM元素的最大支持长度为
M<= 255 且 ( Mx
w) <= 1020，其中
M是元素文字长度，
w是字符集中最大长度字符所需的字节数。
SET('value1','value2',...)
[CHARACTER SET charset_name]
[COLLATE
collation_name]
一套。可以具有零个或多个值的字符串对象，
每个值都必须从值列表中选择
，
值在内部表示为整数。
'value1''value2'... SET
一个SET列最多可以有 64 个不同的成员。
单个
SET元素的最大支持长度为
M<= 255 且 ( Mx
w) <= 1020，其中
M是元素文字长度，
w是字符集中最大长度字符所需的字节数。
© Mysql 中文网
