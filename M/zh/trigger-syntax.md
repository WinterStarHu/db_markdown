# 25.3.1 触发器语法和示例_MySQL 8.0 参考手册

25.3.1 触发器语法和示例_MySQL 8.0 参考手册
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
25.3.1 触发器语法和示例1
25.3.2 触发器元数据1
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.3 使用触发器  /
25.3.1 触发器语法和示例
25.3.1 触发器语法和示例
要创建触发器或删除触发器，请使用
CREATE TRIGGERor
DROP TRIGGER语句，如第 13.1.22 节“CREATE TRIGGER 语句”和
第 13.1.34 节“DROP TRIGGER 语句”中所述。
这是一个将触发器与表相关联以激活INSERT操作的简单示例。触发器充当累加器，对插入到表的某一列中的值求和。
mysql> CREATE TABLE account (acct_num INT, amount DECIMAL(10,2));
Query OK, 0 rows affected (0.03 sec)
mysql> CREATE TRIGGER ins_sum BEFORE INSERT ON account
FOR EACH ROW SET @sum = @sum + NEW.amount;
Query OK, 0 rows affected (0.01 sec)
该CREATE TRIGGER语句创建一个名为的触发器，该触发器ins_sum与account表相关联。它还包括指定触发器动作时间、触发事件以及触发器激活时要执行的操作的子句：
该关键字BEFORE表示触发动作时间。在这种情况下，触发器在每一行插入表之前激活。这里另一个允许的关键字是AFTER。
关键字INSERT表示触发事件；即激活触发器的操作类型。在示例中，INSERT
操作导致触发器激活。您还可以为DELETE和
UPDATE操作创建触发器。
下面的语句FOR EACH ROW
定义了触发器主体；也就是说，每次触发器激活时执行的语句，对于受触发事件影响的每一行都会发生一次。在示例中，触发器主体是一个简单的触发器
SET
，它将插入到amount列中的值累积到用户变量中。该语句将列称为“要插入到新行中的列NEW.amount的
值”。”amount
要使用触发器，将累加器变量设置为零，执行一条INSERT语句，然后查看变量的值：
mysql> SET @sum = 0;
mysql> INSERT INTO account VALUES(137,14.98),(141,1937.50),(97,-100.00);
mysql> SELECT @sum AS 'Total amount inserted';
+-----------------------+
| Total amount inserted |
+-----------------------+
|               1852.48 |
+-----------------------+
在这种情况下，语句执行
@sum后的
值为, 或
。
INSERT14.98 + 1937.50 - 1001852.48
要销毁触发器，请使用DROP
TRIGGER语句。如果触发器不在默认架构中，则必须指定架构名称：
mysql> DROP TRIGGER test.ins_sum;
如果删除一个表，该表的所有触发器也会被删除。
触发器名称存在于模式命名空间中，这意味着所有触发器在模式中必须具有唯一名称。不同模式中的触发器可以具有相同的名称。
可以为具有相同触发事件和动作时间的给定表定义多个触发器。例如，您可以BEFORE UPDATE为一个表设置两个触发器。默认情况下，具有相同触发事件和动作时间的触发器按创建顺序激活。要影响触发器顺序，请在其后指定一个子句，该子句FOR EACH ROW指示FOLLOWS或
PRECEDES以及也具有相同触发器事件和操作时间的现有触发器的名称。使用
FOLLOWS，新触发器在现有触发器之后激活。使用PRECEDES，新触发器在现有触发器之前激活。
例如，以下触发器定义
BEFORE INSERT为表定义了另一个触发器
account：
mysql> CREATE TRIGGER ins_transaction BEFORE INSERT ON account
FOR EACH ROW PRECEDES ins_sum
SET
@deposits = @deposits + IF(NEW.amount>0,NEW.amount,0),
@withdrawals = @withdrawals + IF(NEW.amount<0,-NEW.amount,0);
Query OK, 0 rows affected (0.01 sec)
此触发器ins_transaction类似于，
ins_sum但分别累积存款和取款。它有一个PRECEDES
子句导致它在之前激活
ins_sum；如果没有该子句，它将在 之后激活，ins_sum因为它是在 之后创建的
ins_sum。
在触发器主体中，OLD和
NEW关键字使您能够访问受触发器影响的行中的列。OLD并且
NEW是触发器的 MySQL 扩展；它们不区分大小写。
在一个INSERT触发器中，只能
使用；没有旧行。在一个触发器中，只能
使用；没有新行。在
触发器中，您可以
在更新前
引用行的列，在更新后引用行的列。
NEW.col_nameDELETEOLD.col_nameUPDATEOLD.col_nameNEW.col_name
名为 with 的列OLD是只读的。您可以参考它（如果您有SELECT
权限），但不能修改它。NEW如果您有
权限，可以引用名为 with 的列SELECT。在
BEFORE触发器中，如果您有
权限，也可以更改它的值。这意味着您可以使用触发器来修改要插入到新行或用于更新行的值。（这样的
语句对触发器没有影响，因为行更改已经发生。）
SET NEW.col_name =
valueUPDATESETAFTER
在BEFORE触发器中，列的NEW
值为AUTO_INCREMENT0，而不是实际插入新行时自动生成的序列号。
通过使用该BEGIN ...
END构造，您可以定义一个执行多条语句的触发器。在BEGIN块内，您还可以使用存储例程中允许的其他语法，例如条件和循环。但是，和存储例程一样，如果使用mysql程序定义一个执行多条语句的触发器，则需要重新定义mysql语句分隔符，这样才能;在触发器定义内使用语句分隔符。下面的例子说明了这些要点。它定义了一个UPDATE
检查用于更新每一行的新值的触发器，并将值修改为在 0 到 100 的范围内。这必须是一个BEFORE触发器，因为在使用该值更新行之前必须检查该值：
mysql> delimiter //
mysql> CREATE TRIGGER upd_check BEFORE UPDATE ON account
FOR EACH ROW
BEGIN
IF NEW.amount < 0 THEN
SET NEW.amount = 0;
ELSEIF NEW.amount > 100 THEN
SET NEW.amount = 100;
END IF;
END;//
mysql> delimiter ;CALL单独定义存储过程然后使用简单的语句
从触发器调用它会更容易
。如果您想从多个触发器中执行相同的代码，这也是有利的。
触发器在激活时执行的语句中可以出现的内容有一些限制：
触发器不能使用该CALL
语句调用将数据返回给客户端或使用动态 SQL 的存储过程。（允许存储过程通过
OUT或INOUT
参数将数据返回给触发器。）
触发器不能使用显式或隐式开始或结束事务的语句，例如
START
TRANSACTION、COMMIT或ROLLBACK。（ROLLBACK to
SAVEPOINT是允许的，因为它不会结束事务。）。
另见第 25.8 节，“存储程序的限制”。
MySQL 在触发器执行过程中处理错误的方式如下：
如果BEFORE触发器失败，则不会执行对相应行的操作。
尝试BEFORE插入或修改行时会激活触发器
，而不管尝试随后是否成功
。AFTER仅当任何
BEFORE触发器和行操作成功
执行时，才会
执行触发器。BEFOREa或
触发器
期间的错误AFTER会导致导致触发器调用的整个语句失败。
对于事务表，一条语句的失败应该导致该语句执行的所有更改的回滚。触发器失败会导致语句失败，因此触发器失败也会导致回滚。对于非事务表，无法执行此类回滚，因此尽管语句失败，但在错误点之前执行的任何更改仍然有效。
触发器可以按名称包含对表的直接引用，例如testref本例中显示的触发器名称：
CREATE TABLE test1(a1 INT);
CREATE TABLE test2(a2 INT);
CREATE TABLE test3(a3 INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
CREATE TABLE test4(
a4 INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
b4 INT DEFAULT 0
);
delimiter |
CREATE TRIGGER testref BEFORE INSERT ON test1
FOR EACH ROW
BEGIN
INSERT INTO test2 SET a2 = NEW.a1;
DELETE FROM test3 WHERE a3 = NEW.a1;
UPDATE test4 SET b4 = b4 + 1 WHERE a4 = NEW.a1;
END;
|
delimiter ;
INSERT INTO test3 (a3) VALUES
(NULL), (NULL), (NULL), (NULL), (NULL),
(NULL), (NULL), (NULL), (NULL), (NULL);
INSERT INTO test4 (a4) VALUES
(0), (0), (0), (0), (0), (0), (0), (0), (0), (0);
假设您将以下值插入表
test1中，如下所示：
mysql> INSERT INTO test1 VALUES
(1), (3), (1), (7), (1), (8), (4), (4);
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0
结果，四个表包含以下数据：
mysql> SELECT * FROM test1;
+------+
| a1   |
+------+
|    1 |
|    3 |
|    1 |
|    7 |
|    1 |
|    8 |
|    4 |
|    4 |
+------+
8 rows in set (0.00 sec)
mysql> SELECT * FROM test2;
+------+
| a2   |
+------+
|    1 |
|    3 |
|    1 |
|    7 |
|    1 |
|    8 |
|    4 |
|    4 |
+------+
8 rows in set (0.00 sec)
mysql> SELECT * FROM test3;
+----+
| a3 |
+----+
|  2 |
|  5 |
|  6 |
|  9 |
| 10 |
+----+
5 rows in set (0.00 sec)
mysql> SELECT * FROM test4;
+----+------+
| a4 | b4   |
+----+------+
|  1 |    3 |
|  2 |    0 |
|  3 |    1 |
|  4 |    2 |
|  5 |    0 |
|  6 |    0 |
|  7 |    1 |
|  8 |    1 |
|  9 |    0 |
| 10 |    0 |
+----+------+
10 rows in set (0.00 sec)
© Mysql 中文网
