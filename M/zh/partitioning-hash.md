# 24.2.4 哈希分区_MySQL 8.0 参考手册

24.2.4 哈希分区_MySQL 8.0 参考手册
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
24.1 MySQL分区概述
24.2 分区类型
24.2.1 范围分区1
24.2.2 列表分区1
24.2.3 列分区1
24.2.4 哈希分区1
24.2.4.1 线性哈希分区
24.2.5 KEY分区1
24.2.6 子分区1
24.2.7 MySQL分区如何处理NULL1
24.3 分区管理
24.4 分区修剪
24.5 分区选择
24.6 分区的约束和限制
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
MySQL 8.0 参考手册  / 第24章分区  / 24.2 分区类型  /
24.2.4 哈希分区
24.2.4 哈希分区
24.2.4.1 线性哈希分区
分区依据HASH主要用于确保数据在预定数量的分区之间均匀分布。对于范围或列表分区，您必须明确指定给定列值或列值集应存储在哪个分区中；使用散列分区，这个决定是为你考虑的，你只需要根据要散列的列值和分区表要划分的分区数指定一个列值或表达式。
要使用分区对表进行HASH分区，必须在CREATE
TABLE语句后附加一个子句，其中
是一个返回整数的表达式。这可以只是一个列的名称，其类型是 MySQL 的整数类型之一。此外，您很可能希望在此之后加上，其中
是一个正整数，表示要将表划分为的分区数。
PARTITION BY HASH
(expr)exprPARTITIONS
numnum
笔记
为简单起见，以下示例中的表不使用任何键。您应该知道，如果一个表有任何唯一键，则该表的分区表达式中使用的每一列都必须是每个唯一键的一部分，包括主键。有关更多信息，请参阅
第 24.6.1 节，“分区键、主键和唯一键”。
以下语句创建一个表，该表在
store_id列上使用散列并分为 4 个分区：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT,
store_id INT
)
PARTITION BY HASH(store_id)
PARTITIONS 4;
如果不包含PARTITIONS子句，则分区数默认为1；使用PARTITIONS后面没有数字的关键字会导致语法错误。
您还可以使用为 返回整数的 SQL 表达式
expr。例如，您可能希望根据雇用员工的年份进行分区。这可以如下所示完成：
CREATE TABLE employees (
id INT NOT NULL,
fname VARCHAR(30),
lname VARCHAR(30),
hired DATE NOT NULL DEFAULT '1970-01-01',
separated DATE NOT NULL DEFAULT '9999-12-31',
job_code INT,
store_id INT
)
PARTITION BY HASH( YEAR(hired) )
PARTITIONS 4;
expr必须返回一个非常量、非随机整数值（换句话说，它应该是可变的但确定的），并且不得包含任何禁止的构造，如
第 24.6 节“分区的限制和限制”中所述。您还应该记住，每次插入或更新（或可能删除）行时都会评估此表达式；这意味着非常复杂的表达式可能会引起性能问题，尤其是在执行一次影响大量行的操作（例如批量插入）时。
最有效的散列函数是对单个表列进行操作并且其值与列值一致地增加或减少的函数，因为这允许对分区范围进行
“修剪”。也就是说，表达式与其所基于的列的值变化得越紧密，MySQL 就可以越有效地使用该表达式进行散列分区。
例如，其中date_col是类型为 的列DATE，则表达式
TO_DAYS(date_col)直接随 的值变化date_col，因为对于 的值的每一次变化，date_col表达式的值都以一致的方式变化。关于 的表达式的方差
YEAR(date_col)不像
date_col的那么直接
TO_DAYS(date_col)，因为不是每一个可能的变化都会date_col产生等价的变化
YEAR(date_col)。即便如此，
YEAR(date_col)它还是哈希函数的一个很好的候选者，因为它直接随一部分变化，date_col并且不可能发生变化date_col这会在 中产生不成比例的变化
YEAR(date_col)。
作为对比，假设您有一个名为 的列
int_col，其类型为
INT。现在考虑表达式
POW(5-int_col,3) + 6。对于散列函数来说，这将是一个糟糕的选择，因为int_col不能保证 值的变化会产生表达式值的比例变化。按给定数量更改 的值int_col可能会在表达式的值中产生大不相同的变化。例如，将int_colfrom
更改为5会使表达式的值发生变化，但将from
的值更改为会导致表达式的变化6-1int_col67-7在表达式值中。
换句话说，列值与表达式值的关系图越接近直线（如 为某个非零常数的方程所描绘的
）
，表达式越适合散列。这与这样一个事实有关，即表达式越非线性，它倾向于生成的分区之间的数据分布就越不均匀。
y=cxc
理论上，对于涉及多个列值的表达式也可以进行剪枝，但是确定哪些表达式是合适的可能非常困难且耗时。因此，不特别推荐使用涉及多列的散列表达式。
使用PARTITION BY HASH时，存储引擎根据
num表达式结果的模数确定使用分区中的哪个分区。换句话说，对于给定的表达式expr，存储记录的分区是分区号
N，其中
. 假设该表
定义如下，因此它有 4 个分区：
N =
MOD(expr,
num)t1CREATE TABLE t1 (col1 INT, col2 CHAR(5), col3 DATE)
PARTITION BY HASH( YEAR(col3) )
PARTITIONS 4;
如果插入一条值为 的记录t1，
col3则
'2005-09-15'其存储的分区确定如下：
MOD(YEAR('2005-09-01'),4)
=  MOD(2005,4)
=  1HASHMySQL 8.0 还支持称为
线性哈希
的分区变体，
它使用更复杂的算法来确定插入分区表的新行的位置。有关此算法的说明，
请参阅
第 24.2.4.1 节，“线性散列分区” 。
每次插入或更新记录时都会评估用户提供的表达式。视情况而定，也可以在删除记录时对其进行评估。
© Mysql 中文网
