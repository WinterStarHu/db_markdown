# 13.2.13 更新语句_MySQL 8.0 参考手册

13.2.13 更新语句_MySQL 8.0 参考手册
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
13.2.13 更新语句
13.2.13 更新语句
UPDATE是修改表中行的 DML 语句。
UPDATE语句可以以子句开头，
以WITH定义可在
UPDATE. 请参阅第 13.2.15 节，“WITH（公用表表达式）”。
单表语法：
UPDATE [LOW_PRIORITY] [IGNORE] table_reference
SET assignment_list
[WHERE where_condition]
[ORDER BY ...]
[LIMIT row_count]
value:
{expr | DEFAULT}
assignment:
col_name = value
assignment_list:
assignment [, assignment] ...
多表语法：
UPDATE [LOW_PRIORITY] [IGNORE] table_references
SET assignment_list
[WHERE where_condition]
对于单表语法，该
UPDATE语句使用新值更新命名表中现有行的列。该
SET子句指示要修改的列以及应为其提供的值。每个值都可以作为表达式或关键字给出，DEFAULT以将列显式设置为其默认值。该
WHERE子句（如果给定）指定标识要更新的行的条件。如果没有
WHERE子句，所有行都会更新。如果指定了该
ORDER BY子句，则行将按照指定的顺序更新。该
LIMIT子句限制了可以更新的行数。
对于多表语法，
UPDATE更新每个table_references满足条件的表中的行。每个匹配行都会更新一次，即使它多次匹配条件也是如此。对于多表语法，
ORDER BY不能LIMIT使用。
对于分区表，该语句的单表和多表形式都支持使用
PARTITION子句作为表引用的一部分。此选项采用一个或多个分区或子分区（或两者）的列表。仅检查列出的分区（或子分区）是否匹配，并且不更新不在任何这些分区或子分区中的行，无论它是否满足where_condition。
笔记
PARTITION与使用
INSERTor
REPLACE语句
的情况不同，UPDATE ... PARTITION即使列出的分区（或子分区）中没有行与
where_condition.
有关更多信息和示例，请参阅
第 24.5 节，“分区选择”。
where_condition是一个表达式，对于要更新的​​每一行计算结果为真。有关表达式语法，请参阅第 9.5 节，“表达式”。
table_references并
按照第 13.2.10 节，“SELECT 语句”where_condition中的描述进行指定。
您仅需要对
实际更新的 中UPDATE引用的列的权限。UPDATE您只需要
SELECT对任何已读取但未修改的列的权限。
该UPDATE语句支持以下修饰符：
使用LOW_PRIORITY修饰符，将UPDATE延迟执行，直到没有其他客户端从表中读取。这只会影响仅使用表级锁定的存储引擎（例如
MyISAM、MEMORY和
MERGE）。
使用IGNORE修饰符，即使在更新期间发生错误，更新语句也不会中止。不会更新在唯一键值上发生重复键冲突的行。更新为会导致数据转换错误的值的行将更新为最接近的有效值。有关详细信息，请参阅
IGNORE 对语句执行的影响。
UPDATE IGNORE
语句，包括那些带有ORDER BY
子句的语句，被标记为对基于语句的复制不安全。（这是因为更新行的顺序决定了哪些行被忽略。）这些语句在使用基于语句的模式时会在错误日志中产生警告，并在使用
MIXED模式时使用基于行的格式写入二进制日志. （错误 #11758262，错误 #50439）有关更多信息，请参阅
第 17.2.1.3 节“确定二进制日志中安全和不安全的语句”。
如果您访问要在表达式中更新的表中的列，则UPDATE使用该列的当前值。例如，以下语句设置
col1为比其当前值大 1：
UPDATE t1 SET col1 = col1 + 1;
以下语句中的第二个赋值设置
col2为当前（更新）
col1值，而不是原始
col1值。结果是
col1和col2具有相同的值。此行为不同于标准 SQL。
UPDATE t1 SET col1 = col1 + 1, col2 = col1;
单表UPDATE赋值一般是从左到右求值。对于多表更新，不能保证分配以任何特定顺序执行。
如果您将列设置为其当前具有的值，MySQL 会注意到这一点并且不会更新它。
如果更新已NOT
NULL通过设置声明的列，则在NULL启用严格 SQL 模式的情况下会发生错误；否则，列被设置为列数据类型的隐式默认值，并且警告计数增加。隐式默认值适用
0于数字类型，空字符串 ( '') 适用于字符串类型，
“零”值适用于日期和时间类型。请参阅
第 11.6 节，“数据类型默认值”。
如果显式更新生成的列，则唯一允许的值为DEFAULT. 有关生成的列的信息，请参阅
第 13.1.20.8 节，“CREATE TABLE 和生成的列”。
UPDATE返回实际更改的行数。C API 函数返回匹配和更新的
mysql_info()行数以及
UPDATE.
您可以使用来限制. 子句是
行匹配限制。一旦找到
满足该
子句的行，该语句就会停止，无论它们是否实际被更改。
LIMIT
row_countUPDATELIMITrow_countWHERE
如果UPDATE语句包含一个
ORDER BY子句，则行将按照该子句指定的顺序进行更新。这在某些可能会导致错误的情况下很有用。假设一个表t包含一个id
具有唯一索引的列。以下语句可能因重复键错误而失败，具体取决于更新行的顺序：
UPDATE t SET id = id + 1;
例如表中包含1和2的
id列，在2更新为3之前先将1更新为2，就会报错。为避免此问题，添加一个
ORDER BY子句使具有较大值的行在具有较小
id值的行之前被更新：
UPDATE t SET id = id + 1 ORDER BY id DESC;
您还可以执行UPDATE
涵盖多个表的操作。但是，您不能将
ORDER BYorLIMIT与多表一起使用UPDATE。该
table_references子句列出了连接中涉及的表。它的语法在
第 13.2.10.2 节，“JOIN 子句”中描述。这是一个例子：
UPDATE items,month SET items.price=month.price
WHERE items.id=month.id;
前面的示例显示了使用逗号运算符的内部联接，但多表UPDATE
语句可以使用语句中允许的任何类型的联接
SELECT，例如
LEFT JOIN.
如果您使用涉及具有外键约束的
表的多表UPDATE
语句，则 MySQL 优化器可能会以与其父/子关系不同的顺序处理表。InnoDB在这种情况下，语句失败并回滚。相反，更新单个表并依赖提供的
ON UPDATE功能
InnoDB来导致其他表进行相应的修改。请参阅
第 13.1.20.5 节，“外键约束”。
您不能更新表并直接从子查询中的同一个表中进行选择。您可以通过使用多表更新来解决此问题，其中一个表派生自您实际希望更新的表，并使用别名引用派生表。假设您希望更新一个名为
itemswhich 的表，该表是使用此处显示的语句定义的：
CREATE TABLE items (
id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
wholesale DECIMAL(6,2) NOT NULL DEFAULT 0.00,
retail DECIMAL(6,2) NOT NULL DEFAULT 0.00,
quantity BIGINT NOT NULL DEFAULT 0
);
要降低加价幅度为 30% 或更高且库存少于 100 的任何商品的零售价，您可以尝试使用如下语句，该语句在子句UPDATE中使用子查询
。WHERE如此处所示，此语句不起作用：
mysql> UPDATE items
> SET retail = retail * 0.9
> WHERE id IN
>     (SELECT id FROM items
>         WHERE retail / wholesale >= 1.3 AND quantity > 100);
ERROR 1093 (HY000): You can't specify target table 'items' for update in FROM clause
相反，您可以使用多表更新，其中子查询被移动到要更新的表列表中，使用别名在最外层WHERE子句中引用它，如下所示：
UPDATE items,
(SELECT id FROM items
WHERE id IN
(SELECT id FROM items
WHERE retail / wholesale >= 1.3 AND quantity < 100))
AS discounted
SET items.retail = items.retail * 0.9
WHERE items.id = discounted.id;
因为优化器默认尝试将派生表合并
discounted到最外层的查询块中，所以这仅在您强制派生表的具体化时才有效。您可以通过
在运行更新之前将系统变量的derived_merge标志
设置为 来执行此操作，或者使用优化器提示来执行此操作，如下所示：
optimizer_switchoffNO_MERGEUPDATE /*+ NO_MERGE(discounted) */ items,
(SELECT id FROM items
WHERE retail / wholesale >= 1.3 AND quantity < 100)
AS discounted
SET items.retail = items.retail * 0.9
WHERE items.id = discounted.id;
在这种情况下使用优化器提示的优点是它只适用于使用它的查询块内，因此
optimizer_switch在执行
UPDATE.
另一种可能性是重写子查询，使其不使用INor EXISTS，如下所示：
UPDATE items,
(SELECT id, retail / wholesale AS markup, quantity FROM items)
AS discounted
SET items.retail = items.retail * 0.9
WHERE discounted.markup >= 1.3
AND discounted.quantity < 100
AND items.id = discounted.id;
在这种情况下，子查询默认具体化而不是合并，因此没有必要禁用派生表的合并。
© Mysql 中文网
