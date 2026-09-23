# 9.2.5 函数名解析解析_MySQL 8.0 参考手册

9.2.5 函数名解析解析_MySQL 8.0 参考手册
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
9.2 模式对象名称
9.2.1 标识符长度限制1
9.2.2 标识符限定符1
9.2.3 标识符区分大小写1
9.2.4 标识符到文件名的映射1
9.2.5 函数名解析解析1
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
MySQL 8.0 参考手册  / 第9章语言结构  / 9.2 模式对象名称  /
9.2.5 函数名解析解析
9.2.5 函数名解析解析
MySQL 支持内置（本机）函数、可加载函数和存储函数。本节介绍服务器如何识别内置函数的名称是用作函数调用还是用作标识符，以及在存在具有给定名称的不同类型的函数时服务器如何确定使用哪个函数。
内置函数名解析函数名解析
内置函数名解析
解析器使用默认规则来解析内置函数的名称。可以通过启用
IGNORE_SPACESQL 模式来更改这些规则。
当解析器遇到作为内置函数名称的词时，它必须确定该名称是表示函数调用还是对标识符（例如表名或列名）的非表达式引用。例如，在以下语句中，第一个引用
count是函数调用，而第二个引用是表名：
SELECT COUNT(*) FROM mytable;
CREATE TABLE count (i INT);
解析器应该仅在解析预期为表达式的内容时将内置函数的名称识别为指示函数调用。也就是说，在非表达式上下文中，函数名称被允许作为标识符。
但是，一些内置函数有特殊的解析或实现注意事项，因此解析器默认使用以下规则来区分它们的名称是用作函数调用还是用作非表达式上下文中的标识符：
要将名称用作表达式中的函数调用，名称和后面的
(括号字符之间不能有空格。
相反，要将函数名称用作标识符，则不能紧跟括号。
函数调用在名称和括号之间没有空格的要求仅适用于有特殊考虑的内置函数。
COUNT就是这样一个名字。sql/lex.h源文件列出了这些特殊函数的名称，后面的空格决定了它们的解释：名称由数组中的
宏
定义
SYM_FN()。
symbols[]
下面的列表列出了 MySQL 8.0 中受
设置影响并在源文件IGNORE_SPACE中列为特殊的函数。sql/lex.h您可能会发现将无空格要求应用于所有函数调用最简单。
ADDDATE
BIT_AND
BIT_OR
BIT_XOR
CAST
COUNT
CURDATE
CURTIME
DATE_ADD
DATE_SUB
EXTRACT
GROUP_CONCAT
MAX
MID
MIN
NOW
POSITION
SESSION_USER
STD
STDDEV
STDDEV_POP
STDDEV_SAMP
SUBDATE
SUBSTR
SUBSTRING
SUM
SYSDATE
SYSTEM_USER
TRIM
VARIANCE
VAR_POP
VAR_SAMP
对于未在 中列为特殊的函数
sql/lex.h，空格无关紧要。它们仅在表达式上下文中使用时才被解释为函数调用，否则可以自由用作标识符。ASCII就是这样一个名字。但是，对于这些不受影响的函数名称，表达式上下文中的解释可能会有所不同：
func_name ()如果存在具有给定名称的函数，则解释为内置函数；如果不是，
func_name ()则解释为可加载函数或存储函数（如果存在具有该名称的函数）。
IGNORE_SPACESQL 模式可用于修改解析器如何处理对空格敏感的函数名称
：
如果禁用，当IGNORE_SPACE
名称和后面的括号之间没有空格时，解析器将名称解释为函数调用。即使在非表达式上下文中使用函数名称也会发生这种情况：
mysql> CREATE TABLE count(i INT);
ERROR 1064 (42000): You have an error in your SQL syntax ...
near 'count(i INT)'
要消除错误并使名称被视为标识符，请在名称后使用空格或将其写为带引号的标识符（或两者）：
CREATE TABLE count (i INT);
CREATE TABLE `count`(i INT);
CREATE TABLE `count` (i INT);
启用后，解析器放宽了IGNORE_SPACE
函数名称和后面的括号之间没有空格的要求。这为编写函数调用提供了更大的灵活性。例如，以下任一函数调用都是合法的：
SELECT COUNT(*) FROM mytable;
SELECT COUNT (*) FROM mytable;
但是，启用
IGNORE_SPACE也有副作用，即解析器将受影响的函数名称视为保留字（请参阅
第 9.3 节，“关键字和保留字”）。这意味着名称后面的空格不再表示它用作标识符。该名称可用于带或不带空格的函数调用，但除非它被引用，否则会在非表达式上下文中导致语法错误。例如，IGNORE_SPACE
启用后，以下两个语句都会因语法错误而失败，因为解析器将其解释
count为保留字：
CREATE TABLE count(i INT);
CREATE TABLE count (i INT);
要在非表达式上下文中使用函数名称，请将其写为带引号的标识符：
CREATE TABLE `count`(i INT);
CREATE TABLE `count` (i INT);
要启用IGNORE_SPACE
SQL 模式，请使用以下语句：
SET sql_mode = 'IGNORE_SPACE';
IGNORE_SPACE某些其他复合模式也可以启用，例如将
ANSI其包含在它们的值中：
SET sql_mode = 'ANSI';
检查第 5.1.11 节，“服务器 SQL 模式”，查看哪些复合模式启用IGNORE_SPACE。
要最大限度地减少 SQL 代码对
IGNORE_SPACE设置的依赖性，请使用以下准则：
避免创建与内置函数同名的可加载函数或存储函数。
避免在非表达式上下文中使用函数名称。例如，这些语句使用count
（受 影响的受影响的函数名称之一
IGNORE_SPACE），因此如果
IGNORE_SPACE启用，它们会在名称后面有或没有空格的情况下失败：
CREATE TABLE count(i INT);
CREATE TABLE count (i INT);
如果必须在非表达式上下文中使用函数名称，请将其写为带引号的标识符：
CREATE TABLE `count`(i INT);
CREATE TABLE `count` (i INT);
函数名解析
以下规则描述了服务器如何为函数创建和调用解析对函数名称的引用：
内置函数和可加载函数
如果您尝试创建与内置函数同名的可加载函数，则会发生错误。
IF NOT EXISTS（从 MySQL 8.0.29 开始可用）在这种情况下无效。有关详细信息，请参阅
第 13.7.4.1 节，“可加载函数的 CREATE FUNCTION 语句”。
内置函数和存储函数
可以创建与内置函数同名的存储函数，但要调用存储函数，必须使用模式名称对其进行限定。例如，如果您创建一个
PI在test
模式中命名的存储函数，调用它是test.PI()因为服务器在没有限定符的情况下解析PI()
为对内置函数的引用。如果存储的函数名称与内置函数名称冲突，服务器会生成警告。警告可以用 显示SHOW
WARNINGS。
IF NOT EXISTS（MySQL 8.0.29 及更高版本）在这种情况下无效；参见
第 13.1.17 节，“CREATE PROCEDURE 和 CREATE FUNCTION 语句”。
可加载函数和存储函数
可以创建与现有可加载函数同名的存储函数，反之亦然。如果建议的存储函数名称与现有的可加载函数名称冲突，或者如果建议的可加载函数名称与现有存储函数的名称相同，则服务器会生成警告。在任何一种情况下，一旦两个函数都存在，之后调用它时就必须用模式名称限定存储的函数；在这种情况下，服务器假定非限定名称指的是可加载函数。
从 MySQL 8.0.29 开始，IF NOT
EXISTS支持 with
CREATE FUNCTIONstatements，但在这种情况下无效。
在 MySQL 8.0.28 之前，可以创建一个与现有可加载函数同名的存储函数，但反之则不行（错误#33301931）。
前面的函数名称解析规则对升级到实现新内置函数的 MySQL 版本有影响：
如果您已经创建了具有给定名称的可加载函数并将 MySQL 升级到实现具有相同名称的新内置函数的版本，则可加载函数将无法访问。要更正此问题，请使用
DROP FUNCTION删除可加载函数并CREATE
FUNCTION使用不同的非冲突名称重新创建可加载函数。然后修改任何受影响的代码以使用新名称。
如果新版本的 MySQL 实现了与现有存储函数同名的内置函数或可加载函数，您有两种选择：重命名存储函数以使用不冲突的名称，或更改对不冲突的函数的任何调用这样做已经使用模式限定符（
语法）。在任何一种情况下，相应地修改任何受影响的代码。
schema_name.func_name()
© Mysql 中文网
