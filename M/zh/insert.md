# 13.2.6 插入语句_MySQL 8.0 参考手册

13.2.6 插入语句_MySQL 8.0 参考手册
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
第 13 章 SQL 语句
13.1 数据定义语句
13.2 数据操作语句
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.6.1 INSERT ... SELECT 语句
13.2.6.2 INSERT ... ON DUPLICATE KEY UPDATE 语句
13.2.6.3 插入延迟语句
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.11 子查询1
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.6 插入语句
13.2.6 插入语句
13.2.6.1 INSERT ... SELECT 语句13.2.6.2 INSERT ... ON DUPLICATE KEY UPDATE 语句13.2.6.3 插入延迟语句
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name
[PARTITION (partition_name [, partition_name] ...)]
[(col_name [, col_name] ...)]
{ {VALUES | VALUE} (value_list) [, (value_list)] ... }
[AS row_alias[(col_alias [, col_alias] ...)]]
[ON DUPLICATE KEY UPDATE assignment_list]
INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name
[PARTITION (partition_name [, partition_name] ...)]
SET assignment_list
[AS row_alias[(col_alias [, col_alias] ...)]]
[ON DUPLICATE KEY UPDATE assignment_list]
INSERT [LOW_PRIORITY | HIGH_PRIORITY] [IGNORE]
[INTO] tbl_name
[PARTITION (partition_name [, partition_name] ...)]
[(col_name [, col_name] ...)]
{ SELECT ...
| TABLE table_name
| VALUES row_constructor_list
}
[ON DUPLICATE KEY UPDATE assignment_list]
value:
{expr | DEFAULT}
value_list:
value [, value] ...
row_constructor_list:
ROW(value_list)[, ROW(value_list)][, ...]
assignment:
col_name =
value
| [row_alias.]col_name
| [tbl_name.]col_name
| [row_alias.]col_alias
assignment_list:
assignment [, assignment] ...
INSERT将新行插入到现有表中。语句的INSERT
... VALUES、
INSERT ... VALUES
ROW()和
INSERT ... SET
形式根据明确指定的值插入行。该INSERT
... SELECT表单插入从另一个表或多个表中选择的行。您还可以
INSERT ... TABLE
在 MySQL 8.0.19 及更高版本中使用它来从单个表中插入行。
如果要插入的行会导致索引或中出现重复值， INSERTwithON
DUPLICATE KEY UPDATE子句可以更新现有行
。在 MySQL 8.0.19 及更高版本中，可以使用带有一个或多个可选列别名的行别名来引用要插入的行。
UNIQUEPRIMARY KEYON DUPLICATE KEY
UPDATE
有关
INSERT ...
SELECTand
的更多信息INSERT ... ON
DUPLICATE KEY UPDATE，请参阅
第 13.2.6.1 节，“INSERT ... SELECT 语句”和
第 13.2.6.2 节，“INSERT ... ON DUPLICATE KEY UPDATE 语句”。
在 MySQL 8.0 中，DELAYED关键字被服务器接受但被忽略。为此，请参阅第 13.2.6.3 节，“插入延迟语句”，
插入表需要表的
INSERT权限。如果ON DUPLICATE KEY UPDATE使用该子句并且重复键导致UPDATE执行 an，则该语句需要
UPDATE更新列的权限。对于已读取但未修改的列，您只需要特权（例如，对于仅在
子句
中=
赋值SELECT的右侧引用的列
）。col_nameexprON DUPLICATE KEY UPDATE
插入分区表时，您可以控制哪些分区和子分区接受新行。该
PARTITION子句采用表的一个或多个分区或子分区（或两者）的逗号分隔名称列表。如果给定语句要插入的任何行与INSERT列出的分区之一不匹配，则
INSERT语句失败并显示错误Found a row not matching the given partition set。有关更多信息和示例，请参阅
第 24.5 节，“分区选择”。
tbl_name是应该插入行的表。指定语句为其提供值的列，如下所示：
在表名后提供一个用括号括起来的以逗号分隔的列名列表。在这种情况下，每个命名列的值必须由VALUES列表、
VALUES ROW()
列表或SELECT语句提供。对于INSERT TABLE表单，源表中的列数必须与要插入的列数匹配。
如果您没有为
INSERT ...
VALUES或
指定列名列表INSERT ...
SELECT，则表中每一列的值都必须由VALUES列表、
SELECT语句或
TABLE语句提供。如果您不知道表中列的顺序，请使用
查找。
DESCRIBE
tbl_name
子句通过SET名称显式指示列，以及分配给每个列的值。
可以通过多种方式给出列值：
如果未启用严格 SQL 模式，则任何未显式指定值的列都将设置为其默认（显式或隐式）值。例如，如果您指定的列列表未命名表中的所有列，则未命名的列将设置为其默认值。默认值分配在
第 11.6 节，“数据类型默认值”中描述。另见
第 1.7.3.3 节，“对无效数据的强制约束”。
如果启用了严格的 SQL 模式，如果
INSERT语句没有为没有默认值的每个列指定显式值，则会生成错误。请参阅
第 5.1.11 节，“服务器 SQL 模式”。
如果列列表和VALUES列表都为空，则INSERT创建一行并将每一列设置为其默认值：
INSERT INTO tbl_name () VALUES();
如果未启用严格模式，则 MySQL 对没有显式定义默认值的任何列使用隐式默认值。如果启用了严格模式，则如果任何列没有默认值，则会发生错误。
使用关键字DEFAULT将列显式设置为其默认值。这使得编写
INSERT为除少数列之外的所有列赋值的语句变得更加容易，因为它使您能够避免编写VALUES不包含表中每一列的值的不完整列表。否则，您必须提供与列表中每个值对应的列名VALUES
列表。
如果显式插入生成的列，则唯一允许的值为DEFAULT. 有关生成的列的信息，请参阅
第 13.1.20.8 节，“CREATE TABLE 和生成的列”。
在表达式中，您可以使用
来生成列的默认值
。
DEFAULT(col_name)col_nameexpr如果表达式数据类型与列数据类型不匹配，则可能会发生提供列值
的表达式的类型转换
。根据列类型的不同，给定值的转换可能会导致不同的插入值。例如，将字符串'1999.0e-2'
插入INT、
FLOAT、
DECIMAL(10,6)或
YEAR列会分别插入值
1999、19.9921、
19.992100或1999。INT和
YEAR列中
存储的
值为1999因为字符串到数字的转换只查看字符串的初始部分，因为它可能被认为是有效的整数或年份。对于
FLOAT和
DECIMAL列，字符串到数字的转换将整个字符串视为有效数值。
表达式expr可以引用先前在值列表中设置的任何列。例如，您可以这样做，因为 for 的值col2
引用了col1之前已分配的值：
INSERT INTO tbl_name (col1,col2) VALUES(15,col1*2);
但是下面是不合法的，因为 for 的值是
col1指col2，它是在 之后赋值的col1：
INSERT INTO tbl_name (col1,col2) VALUES(col2*2,15);AUTO_INCREMENT包含值
的列发生异常
。因为
AUTO_INCREMENT值是在其他赋值之后生成的，所以
AUTO_INCREMENT对赋值中列的任何引用都会返回一个0.
INSERT使用
VALUES语法的语句可以插入多行。为此，包括多个以逗号分隔的列值列表，列表用括号括起来并以逗号分隔。例子：
INSERT INTO tbl_name (a,b,c)
VALUES(1,2,3), (4,5,6), (7,8,9);
每个值列表必须包含与每行要插入的值一样多的值。以下语句无效，因为它包含一个包含九个值的列表，而不是三个包含三个值的列表：
INSERT INTO tbl_name (a,b,c) VALUES(1,2,3,4,5,6,7,8,9);
VALUEVALUES在这种情况下是同义词
。既不暗示值列表的数量，也不暗示每个列表的值的数量。无论是单个值列表还是多个列表，并且无论每个列表的值数量如何，都可以使用两者之一。
INSERT使用
VALUES ROW()
语法的语句也可以插入多行。在这种情况下，每个值列表必须包含在一个ROW()（行构造函数）中，如下所示：
INSERT INTO tbl_name (a,b,c)
VALUES ROW(1,2,3), ROW(4,5,6), ROW(7,8,9);INSERT可以使用
ROW_COUNT()SQL 函数或
mysql_affected_rows()C API 函数获取
an 的 affected-rows 值
。请参阅第 12.16 节，“信息函数”和
mysql_affected_rows()。
如果您将INSERT ...
VALUESorINSERT ... VALUES ROW()
与多个值列表一起使用，或者
INSERT ...
SELECTor INSERT ... TABLE，该语句将返回以下格式的信息字符串：
Records: N1 Duplicates: N2 Warnings: N3
如果您使用的是 C API，则可以通过调用该mysql_info()
函数来获取信息字符串。请参阅mysql_info()。
Records指示语句处理的行数。（这不一定是实际插入的行数，因为Duplicates可以为非零。）Duplicates表示无法插入的行数，因为它们会复制某些现有的唯一索引值。Warnings指示尝试插入以某种方式出现问题的列值的次数。在以下任何情况下都可能出现警告：
插入NULL到已声明的列中NOT NULL。对于多行
INSERT语句或
INSERT INTO ...
SELECT语句，列设置为列数据类型的隐式默认值。这适用
0于数字类型，空字符串 ( '') 适用于字符串类型，
“零”值适用于日期和时间类型。
INSERT INTO ...
SELECT语句的处理方式与多行插入相同，因为服务器不会检查结果集SELECT以查看它是否返回单行。（对于单行
INSERT，当
NULL插入到NOT
NULL柱子。相反，该语句因错误而失败。）
将数字列设置为位于列范围之外的值。该值被裁剪到范围的最近端点。
'10.34 a'为数字列
分配一个值，例如。尾随的非数字文本被剥离，剩余的数字部分被插入。如果字符串值没有前导数字部分，则该列设置为
0。
将字符串插入超过列最大长度的字符串列（ CHAR、
VARCHAR、
TEXT或
）。BLOB该值被截断为列的最大长度。
向日期或时间列中插入对于数据类型非法的值。该列被设置为适合该类型的零值。
有关列值
的INSERT示例
，请参阅第 3.6.9 节，“使用 AUTO_INCREMENT”。
AUTO_INCREMENT
如果INSERT将一行插入到具有一列的表中，您可以使用SQL 函数或C API 函数
AUTO_INCREMENT找到用于该列的值
。LAST_INSERT_ID()mysql_insert_id()
笔记
这两个函数的行为并不总是相同。INSERT语句关于AUTO_INCREMENT列
的行为在第 12.16 节，“信息函数”和
mysql_insert_id()中进一步讨论。
该INSERT语句支持以下修饰符：
如果您使用LOW_PRIORITY修饰符，则执行INSERT会延迟，直到没有其他客户端从表中读取。这包括在现有客户正在阅读和INSERT
LOW_PRIORITY声明正在等待时开始阅读的其他客户。因此，发出INSERT
LOW_PRIORITY声明的客户端可能会等待很长时间。
LOW_PRIORITY仅影响仅使用表级锁定的存储引擎（例如
MyISAM、MEMORY和
MERGE）。
笔记
LOW_PRIORITY通常不应与MyISAM表一起使用，因为这样做会禁用并发插入。请参阅
第 8.11.3 节，“并发插入”。
如果您指定HIGH_PRIORITY，如果服务器是使用该选项启动的，它将覆盖该选项的效果
--low-priority-updates。它还会导致不使用并发插入。请参阅
第 8.11.3 节，“并发插入”。
HIGH_PRIORITY仅影响仅使用表级锁定的存储引擎（例如
MyISAM、MEMORY和
MERGE）。
如果使用IGNORE修饰符，则忽略执行
INSERT语句时发生的可忽略错误。例如，如果没有IGNORE，复制表中现有UNIQUE索引或
PRIMARY KEY值的行会导致重复键错误并且语句被中止。使用
IGNORE，该行被丢弃并且不会发生错误。忽略的错误会生成警告。
IGNORE对于未找到与给定值匹配的分区的分区表的插入具有类似的效果。如果没有IGNORE，此类
INSERT语句将因错误而中止。使用时
INSERT
IGNORE，对于包含不匹配值的行，插入操作会静默失败，但会插入匹配的行。有关示例，请参阅
第 24.2.2 节，“LIST 分区”。
IGNORE如果未指定
，将触发错误的数据转换将中止语句。使用
IGNORE，将无效值调整为最接近的值并插入；产生警告但语句不会中止。您可以使用
mysql_info()C API 函数确定实际插入表中的行数。
有关详细信息，请参阅
IGNORE 对语句执行的影响。
您可以使用REPLACEinstead of
INSERT来覆盖旧行。
REPLACE对应
INSERT
IGNORE于处理包含重复旧行的唯一键值的新行：新行替换旧行而不是被丢弃。请参阅
第 13.2.9 节，“REPLACE 语句”。
如果您指定ON DUPLICATE KEY UPDATE，并且插入的行会导致
UNIQUE索引或中出现重复值PRIMARY
KEY，UPDATE则会出现旧行。如果该行作为新行插入，则每行的 affected-rows 值为 1；如果更新现有行，则为 2；如果现有行设置为其当前值，则为 0。如果在连接到mysqldCLIENT_FOUND_ROWS时将标志指定给
mysql_real_connect()C API 函数，并且将现有行设置为其当前值，则受影响的行值为 1（而不是 0）。参见第 13.2.6.2 节，“INSERT ... ON DUPLICATE KEY UPDATE 语句”。
INSERT DELAYED在 MySQL 5.6 中已弃用，并计划最终删除。在 MySQL 8.0 中，DELAYED修饰符被接受但被忽略。使用INSERT(without
DELAYED) 代替。请参阅
第 13.2.6.3 节，“插入延迟语句”。
© Mysql 中文网
