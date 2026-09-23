# 25.7 存储程序二进制日志记录_MySQL 8.0 参考手册

25.7 存储程序二进制日志记录_MySQL 8.0 参考手册
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
25.1 定义存储程序
25.2 使用存储例程
25.3 使用触发器
25.4 使用事件调度器
25.5 使用视图
25.6 存储对象访问控制
25.7 存储程序二进制日志记录
25.8 存储程序的限制
25.9 视图限制
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
MySQL 8.0 参考手册  / 第25章存储对象  /
25.7 存储程序二进制日志记录
25.7 存储程序二进制日志记录
二进制日志包含有关修改数据库内容的 SQL 语句的信息。此信息以描述修改的“事件”形式存储。（二进制日志事件不同于计划事件存储对象。）二进制日志有两个重要用途：
对于复制，二进制日志在源复制服务器上用作要发送到副本服务器的语句的记录。源将其二进制日志中包含的事件发送到其副本，副本执行这些事件以进行与在源上所做的相同的数据更改。请参阅
第 17.2 节，“复制实现”。
某些数据恢复操作需要使用二进制日志。备份文件恢复后，会重新执行备份后记录在二进制日志中的事件。这些事件使数据库从备份点开始更新。请参见
第 7.3.2 节，“使用备份进行恢复”。
但是，如果日志记录发生在语句级别，则存在与存储程序（存储过程和函数、触发器和事件）相关的某些二进制日志记录问题：
在某些情况下，一条语句可能会影响源和副本上的不同行集。
在副本上执行的复制语句由副本的应用程序线程处理。除非您实施复制权限检查，这在 MySQL 8.0.18 中可用（请参阅
第 17.3.3 节，“复制权限检查”），否则应用程序线程具有完全权限。在这种情况下，过程可能会在源服务器和副本服务器上遵循不同的执行路径，因此用户可以编写包含仅在副本服务器上执行的危险语句的例程。
如果修改数据的存储程序是不确定的，则它是不可重复的。这可能导致源和副本上的数据不同，或者导致恢复的数据与原始数据不同。
本节描述 MySQL 如何处理存储程序的二进制日志记录。它说明了实现对存储程序使用的当前条件，以及您可以采取哪些措施来避免日志记录问题。它还提供了有关这些情况的原因的其他信息。
除非另有说明，否则此处的注释假定在服务器上启用了二进制日志（请参阅
第 5.4.4 节，“二进制日志”。）如果未启用二进制日志，则无法进行复制，二进制日志也不可用于数据恢复。从 MySQL 8.0 开始，二进制日志记录默认启用，只有在启动时指定
--skip-log-bin
或
--disable-log-bin
选项时才会禁用。
通常，当二进制日志记录发生在 SQL 语句级别（基于语句的二进制日志记录）时，会导致此处描述的问题。如果您使用基于行的二进制日志记录，则日志包含由于执行 SQL 语句而对各个行所做的更改。当例程或触发器执行时，记录行更改，而不是进行更改的语句。对于存储过程，这意味着
CALL不记录该语句。对于存储函数，记录函数内所做的行更改，而不是函数调用。对于触发器，记录触发器所做的行更改。在副本端，只能看到行更改，看不到存储的程序调用。
混合格式二进制日志记录 ( binlog_format=MIXED) 使用基于语句的二进制日志记录，但只有基于行的二进制日志记录才能保证产生正确结果的情况除外。对于混合格式，当存储函数、存储过程、触发器、事件或准备好的语句包含任何对基于语句的二进制日志记录不安全的内容时，整个语句将被标记为不安全并以行格式记录。用于创建和删除过程、函数、触发器和事件的语句始终是安全的，并以语句格式记录。有关基于行、混合和基于语句的日志记录以及如何确定安全和不安全语句的更多信息，请参阅
第 17.2.1 节，“复制格式”。
MySQL中存储函数的使用条件可以归纳如下。这些条件不适用于存储过程或事件计划程序事件，除非启用二进制日志记录，否则它们不适用。
要创建或更改存储函数，除了通常需要的
或权限之外
，您还必须具有
SET_USER_ID权限（或已弃用的权限）。（取决于
函数定义中的值，
或者
无论是否启用二进制日志记录都可能需要。请参阅
第 13.1.17 节，“CREATE PROCEDURE 和 CREATE FUNCTION 语句”。）
SUPERCREATE ROUTINEALTER ROUTINEDEFINERSET_USER_IDSUPER
创建存储函数时，必须声明它是确定性的或不修改数据。否则，数据恢复或复制可能不安全。
默认情况下，要接受一条语句，必须明确指定、或CREATE
FUNCTION中的至少一个
。否则会出现错误：
DETERMINISTICNO SQLREADS SQL DATAERROR 1418 (HY000): This function has none of DETERMINISTIC, NO SQL,
or READS SQL DATA in its declaration and binary logging is enabled
(you *might* want to use the less safe log_bin_trust_function_creators
variable)
这个函数是确定性的（并且不修改数据），所以它是安全的：
CREATE FUNCTION f1(i INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
RETURN i;
END;
此函数使用UUID()，它不是确定性的，因此该函数也不是确定性的并且不安全：
CREATE FUNCTION f2()
RETURNS CHAR(36) CHARACTER SET utf8mb4
BEGIN
RETURN UUID();
END;
此函数修改数据，因此可能不安全：
CREATE FUNCTION f3(p_id INT)
RETURNS INT
BEGIN
UPDATE t SET modtime = NOW() WHERE id = p_id;
RETURN ROW_COUNT();
END;
功能性质的评估基于创建者的
“诚实”。MySQL 不检查声明的函数DETERMINISTIC是否没有产生不确定结果的语句。
当您尝试执行存储函数时，如果
binlog_format=STATEMENT设置了DETERMINISTIC关键字，则必须在函数定义中指定关键字。如果不是这种情况，则会生成错误并且函数不会运行，除非
log_bin_trust_function_creators=1
指定覆盖此检查（见下文）。对于递归函数调用，DETERMINISTIC关键字仅在最外层调用中是必需的。如果正在使用基于行或混合二进制日志记录，则即使在没有
DETERMINISTIC关键字的情况下定义该函数，也会接受并复制该语句。
因为 MySQL 不会在创建时检查函数是否真的是确定性的，所以使用DETERMINISTIC关键字调用存储函数可能会执行对基于语句的日志记录不安全的操作，或者调用包含不安全语句的函数或过程。如果在
binlog_format=STATEMENT设置时发生这种情况，则会发出警告消息。如果正在使用基于行或混合二进制日志记录，则不会发出警告，并且语句将以基于行的格式复制。
要放宽前面创建函数的条件（您必须具有SUPER
特权并且函数必须声明为确定性或不修改数据），请将全局
log_bin_trust_function_creators
系统变量设置为 1。默认情况下，该变量的值为 0，但是你可以这样改变它：
mysql> SET GLOBAL log_bin_trust_function_creators = 1;
您还可以在服务器启动时设置此变量。
如果未启用二进制日志记录，
log_bin_trust_function_creators
则不适用。SUPER函数创建不需要它，除非如前所述，DEFINER函数定义中的值需要它。
有关可能对复制不安全的内置函数（并因此导致使用它们的存储函数也不安全）的信息，请参阅
第 17.5.1 节，“复制功能和问题”。
触发器类似于存储函数，因此前面关于函数的评论也适用于触发器，但有以下例外：CREATE TRIGGER没有可选DETERMINISTIC特性，因此假定触发器始终是确定性的。然而，这种假设在某些情况下可能是无效的。例如，该
UUID()函数是不确定的（并且不复制）。在触发器中使用此类函数时要小心。
CREATE
TRIGGER触发器可以更新表，因此如果您没有所需的权限
，则会出现类似于存储函数的错误消息。在副本端，副本使用触发器
DEFINER属性来确定哪个用户被认为是触发器的创建者。
本节的其余部分提供了有关日志记录实现及其影响的更多详细信息。除非您对存储例程使用的当前日志记录相关条件的基本原理背景感兴趣，否则无需阅读它。此讨论仅适用于基于语句的日志记录，而不适用于基于行的日志记录，但第一项除外：
无论日志记录模式如何CREATE，DROP语句都作为语句记录。
服务器将CREATE EVENT,
CREATE PROCEDURE,
CREATE FUNCTION,
ALTER EVENT,
ALTER PROCEDURE,
ALTER FUNCTION,
DROP EVENT,
DROP PROCEDURE, 和
DROP FUNCTION语句写入二进制日志。
SELECT如果函数更改数据并且发生在不会以其他方式记录的语句中，则
存储函数调用将记录为
语句。这可以防止由于在非日志语句中使用存储函数而导致的数据更改的非复制。例如，SELECT
语句不会写入二进制日志，但
SELECT可能会调用进行更改的存储函数。为了处理这个问题，当给定的函数发生变化时，一条语句被写入二进制日志。假设在源服务器上执行如下语句：
SELECT
func_name()CREATE FUNCTION f1(a INT) RETURNS INT
BEGIN
IF (a < 3) THEN
INSERT INTO t2 VALUES (a);
END IF;
RETURN 0;
END;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT f1(a) FROM t1;
当SELECT语句执行时，该函数f1()被调用 3 次。其中两次调用插入一行，MySQLSELECT为它们中的每一次记录一条语句。即MySQL将如下语句写入二进制日志：
SELECT f1(1);
SELECT f1(2);SELECT
当函数调用导致错误的存储过程时，
服务器还会记录存储函数调用的语句。在这种情况下，服务器将SELECT
语句连同预期的错误代码写入日志。在副本上，如果发生相同的错误，这是预期的结果，复制将继续。否则，复制停止。
记录存储的函数调用而不是函数执行的语句对复制具有安全隐患，这源于两个因素：
一个函数可以在源服务器和副本服务器上遵循不同的执行路径。
在副本上执行的语句由副本的应用程序线程处理。除非您实施复制权限检查，这在 MySQL 8.0.18 中可用（请参阅第 17.3.3 节，“复制权限检查”），否则应用程序线程具有完全权限。
这意味着尽管用户必须拥有
CREATE ROUTINE创建函数的权限，但用户可以编写包含危险语句的函数，该语句仅在副本上执行，副本由具有完全权限的线程处理。例如，如果源服务器和副本服务器的服务器 ID 值分别为 1 和 2，则源服务器上的用户可以创建和调用不安全的函数
unsafe_func()，如下所示：
mysql> delimiter //
mysql> CREATE FUNCTION unsafe_func () RETURNS INT
-> BEGIN
->   IF @@server_id=2 THEN dangerous_statement; END IF;
->   RETURN 1;
-> END;
-> //
mysql> delimiter ;
mysql> INSERT INTO t VALUES(unsafe_func());
和语句被写入二进制日志，因此副本执行它们CREATE FUNCTION。
INSERT因为副本的applier线程拥有全部权限，所以它执行了危险的语句。因此，函数调用对源和副本有不同的影响，并且不是复制安全的。
为了防止启用了二进制日志记录的服务器存在这种危险，存储函数创建者
SUPER除了需要通常的CREATE ROUTINE
权限外，还必须拥有该权限。同样，要使用
，除了特权之外ALTER FUNCTION，还必须拥有特权。没有权限，会出现错误：
SUPERALTER ROUTINESUPERERROR 1419 (HY000): You do not have the SUPER privilege and
binary logging is enabled (you *might* want to use the less safe
log_bin_trust_function_creators variable)
如果您不想要求函数创建者拥有
SUPER权限（例如，如果CREATE
ROUTINE您系统上所有具有权限的用户都是经验丰富的应用程序开发人员），请将全局
log_bin_trust_function_creators
系统变量设置为 1。您也可以在服务器启动时设置此变量。如果未启用二进制日志记录，
log_bin_trust_function_creators
则不适用。SUPER函数创建不需要它，除非如前所述，DEFINER函数定义中的值需要它。
无论您对函数创建者的权限做出什么选择，都建议使用复制权限检查（从 MySQL 8.0.18 开始）。可以设置复制权限检查以确保只有预期的和相关的操作才被授权用于复制通道。有关执行此操作的说明，请参阅
第 17.3.3 节，“复制权限检查”。
如果执行更新的函数是不确定的，那么它就是不可重复的。这可能会产生两个不良影响：
它会导致副本与源不同。
恢复的数据与原始数据不匹配。
为了解决这些问题，MySQL 强制执行以下要求：在源服务器上，除非声明函数是确定性的或不修改数据，否则拒绝创建和更改函数。两组功能特性适用于此：
和特征表示一个函数是否总是对给定DETERMINISTIC的NOT
DETERMINISTIC输入产生相同的结果。NOT DETERMINISTIC如果没有给出任何特征，则为默认值。要声明一个函数是确定性的，您必须
DETERMINISTIC明确指定。
、CONTAINS SQL、NO
SQL和特性提供有关函数是读取还是写入数据的信息READS SQL DATA。
MODIFIES SQL DATAor表示函数不更改数据，但您必须明确指定其中之一，因为默认情况下NO SQL没有
给出特征。
READS SQL DATACONTAINS
SQL
默认情况下，要接受一条语句，必须明确指定、或CREATE
FUNCTION中的至少一个
。否则会出现错误：
DETERMINISTICNO SQLREADS SQL DATAERROR 1418 (HY000): This function has none of DETERMINISTIC, NO SQL,
or READS SQL DATA in its declaration and binary logging is enabled
(you *might* want to use the less safe log_bin_trust_function_creators
variable)
如果设置
log_bin_trust_function_creators
为 1，则函数是确定性的或不修改数据的要求将被删除。
存储过程调用记录在语句级别而不是CALL级别。也就是说，服务器不记录
CALL语句，它记录实际执行的过程中的那些语句。因此，发生在源服务器上的相同更改也会发生在副本服务器上。这可以防止可能因过程在不同机器上具有不同执行路径而导致的问题。
通常，在存储过程中执行的语句使用与以独立方式执行的语句相同的规则写入二进制日志。记录过程语句时要特别小心，因为过程中的语句执行与非过程上下文中的语句执行不完全相同：
要记录的语句可能包含对本地过程变量的引用。这些变量不存在于存储过程上下文之外，因此不能按字面记录引用此类变量的语句。相反，出于日志目的，每个对局部变量的引用都被此构造替换：
NAME_CONST(var_name, var_value)
var_name是局部变量名称，并且var_value是一个常量，指示变量在记录语句时具有的值。
NAME_CONST()的值为
var_value，
“名称”为
var_name。因此，如果你直接调用这个函数，你会得到这样的结果：
mysql> SELECT NAME_CONST('myname', 14);
+--------+
| myname |
+--------+
|     14 |
+--------+
NAME_CONST()使记录的独立语句在副本上执行，其效果与存储过程中在源上执行的原始语句相同。
当源列表达式引用局部变量时，
使用NAME_CONST()可能会导致语句出现问题
。CREATE TABLE
... SELECT将这些引用转换为NAME_CONST()
表达式可能会导致源服务器和副本服务器上的列名称不同，或者名称太长而不能成为合法的列标识符。解决方法是为引用局部变量的列提供别名。myvar当值为 1
时考虑以下语句：CREATE TABLE t1 SELECT myvar;
重写如下：
CREATE TABLE t1 SELECT NAME_CONST(myvar, 1);
为确保源表和副本表具有相同的列名，请编写如下语句：
CREATE TABLE t1 SELECT myvar AS myvar;
重写后的语句变为：
CREATE TABLE t1 SELECT NAME_CONST(myvar, 1) AS myvar;
要记录的语句可能包含对用户定义变量的引用。为了处理这个问题，MySQL
SET
向二进制日志写入一条语句，以确保副本上存在与源上具有相同值的变量。例如，如果一条语句引用一个变量
@my_var，则该语句在二进制日志中的前面是以下语句，其中
value是
@my_var源上的值：
SET @my_var = value;
过程调用可以发生在已提交或回滚的事务中。考虑了事务上下文，以便正确复制过程执行的事务方面。也就是说，服务器会在实际执行和修改数据的过程中记录这些语句，并在必要时记录
BEGIN、
COMMIT和
ROLLBACK
语句。例如，如果过程仅更新事务表并在回滚的事务中执行，则不会记录这些更新。如果该过程发生在已提交的事务中，
BEGIN
并且COMMIT语句与更新一起记录。对于在回滚事务中执行的过程，其语句使用与语句以独立方式执行时相同的规则进行记录：
不记录对事务表的更新。
记录对非事务性表的更新，因为回滚不会取消它们。
事务性和非事务性表的混合更新被记录在
BEGIN
和
中，ROLLBACK
以便副本进行与源相同的更改和回滚。
如果存储过程调用是从存储函数中调用的，则存储过程调用不会在语句级别写入二进制日志。在这种情况下，唯一记录的是调用函数的语句（如果它出现在已记录的语句中）或
DO语句（如果它出现在未记录的语句中）。出于这个原因，在使用调用过程的存储函数时应该小心，即使过程本身是安全的。
© Mysql 中文网
