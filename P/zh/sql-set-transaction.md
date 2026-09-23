# SET TRANSACTION

SET TRANSACTION
版本：
纠错本页面
搜索
目录导航
❮
❯
SET TRANSACTIONSET TRANSACTION — 设置当前事务的特性大纲
SET TRANSACTION transaction_mode [, ...]
SET TRANSACTION SNAPSHOT snapshot_id
SET SESSION CHARACTERISTICS AS TRANSACTION transaction_mode [, ...]
其中 transaction_mode 是下列之一：
ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED }
READ WRITE | READ ONLY
[ NOT ] DEFERRABLE
描述
SET TRANSACTION命令设置当前
事务的特性。SET SESSION
CHARACTERISTICS设置一个会话后续事务的默认
事务特性。在个体事务中可以用
SET TRANSACTION覆盖这些默认值。
可用的事务特性是事务隔离级别、事务访问模式（读/写或只读）以及
可延迟模式。此外，可以选择一个快照，不过只能用于当前事务而不能
作为会话默认值。
一个事务的隔离级别决定当其他事务并行运行时该事务能看见什么数据：
READ COMMITTED
一个语句只能看到在它开始前提交的行。这是默认值。
REPEATABLE READ
当前事务的所有语句只能看到这个事务中执行的第一个查询或者
数据修改语句之前提交的行。
SERIALIZABLE
当前事务的所有语句只能看到这个事务中执行的第一个查询或者
数据修改语句之前提交的行。如果并发的可序列化事务间的读写
模式可能导致一种那些事务串行（一次一个）执行时不可能出现
的情况，其中之一将会被回滚并且得到一个
serialization_failure错误。
SQL 标准定义了一种额外的级别：READ
UNCOMMITTED。在
PostgreSQL中READ
UNCOMMITTED被视作
READ COMMITTED。
事务隔离级别在事务执行第一个查询或数据修改语句（SELECT，
INSERT，DELETE，
UPDATE，MERGE，
FETCH，或
COPY）后不能更改。有关事务隔离和并发控制的更多信息，请参见
第 13 章。
事务访问模式确定事务是读/写还是只读。读/写是默认值。当事务是只读时，以下SQL命令被禁止：INSERT，UPDATE，DELETE，MERGE和COPY FROM如果它们要写入的表不是临时表；所有CREATE，ALTER和DROP命令；COMMENT，GRANT，REVOKE，TRUNCATE；以及EXPLAIN ANALYZE和EXECUTE如果它们要执行的命令在列出的命令中。这是一个高级别的只读概念，不会阻止所有写入磁盘。
只有事务也是SERIALIZABLE以及
READ ONLY时，DEFERRABLE
事务属性才会有效。当一个事务的所有这三个属性都被选择时，该事务在
第一次获取其快照时可能会阻塞，在那之后它运行时就不会有
SERIALIZABLE事务的开销并且不会有任何风险
或者被一次序列化失败取消的风险。这种模式很适合于长时间运行的报表或者
备份。
SET TRANSACTION SNAPSHOT命令允许一个新的事务以与现有事务相同的快照运行。
预先存在的事务必须使用pg_export_snapshot函数导出其快照（参见第 9.28.5 节）。
该函数返回一个快照标识符，必须将其作为字符串文字写入SET TRANSACTION SNAPSHOT命令中，例如'00000003-0000001B-1'。
SET TRANSACTION SNAPSHOT只能在事务开始时执行，在事务的第一个查询或数据修改语句（SELECT、INSERT、DELETE、UPDATE、MERGE、FETCH或COPY）之前。
此外，事务必须已经设置为SERIALIZABLE或REPEATABLE READ隔离级别（否则，快照将立即被丢弃，因为READ COMMITTED模式为每个命令获取一个新的快照）。
如果导入事务使用SERIALIZABLE隔离级别，则导出快照的事务也必须使用该隔离级别。
此外，一个非只读的可序列化事务不能从只读事务导入快照。
注释
如果执行SET TRANSACTION之前没有
START TRANSACTION或者
BEGIN，它会发出一个警告并且不会有任何效果。
可以通过在BEGIN或者
START TRANSACTION中指定想要的transaction_modes来省掉
SET TRANSACTION。但是在
SET TRANSACTION SNAPSHOT中该选项不可用。
会话默认的事务模式也可以通过配置参数
default_transaction_isolation、
default_transaction_read_only和
default_transaction_deferrable来设置或检查（实际上
SET SESSION CHARACTERISTICS只是用
SET设置这些变量的冗长等效体）。这意味着可以通过配置文件、
ALTER DATABASE等方式设置默认值。详见
第 19 章。
当前事务的模式可以类似地通过配置参数transaction_isolation、transaction_read_only、和transaction_deferrable来设置或检查。
设置这其中一个参数的作用与相应的SET TRANSACTION选项相同，在它何时可以完成方面，也有相同的限制。
但是，这些参数不能在配置文件中设置，或者从活动SQL以外的任何来源来设置。
示例
要用一个已经存在的事务的同一快照开始一个新事务，首先要从该现有
事务导出快照。这将会返回快照标识符，例如：
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT pg_export_snapshot();
pg_export_snapshot
---------------------
00000003-0000001B-1
(1 row)
然后在一个新开始的事务的开头把该快照标识符用在一个
SET TRANSACTION
SNAPSHOT命令中：
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION SNAPSHOT '00000003-0000001B-1';
兼容性
这些命令在SQL标准中定义，不过
DEFERRABLE事务模式和
SET TRANSACTION SNAPSHOT形式除外，这两者是
PostgreSQL扩展。
SERIALIZABLE是标准中默认的事务隔离级别。在
PostgreSQL中默认值是普通的
READ COMMITTED，但是你可以按上述的方式更改。
在 SQL 标准中，可以用这些命令设置其他的事务特性：诊断区域
的尺寸。这个概念与嵌入式 SQL 有关，因此没有在
PostgreSQL服务器中实现。
SQL 标准要求连续的transaction_modes之间有逗号，
但是出于历史原因PostgreSQL允许省略逗号。
上一页 上一级 下一页SET SESSION AUTHORIZATION 起始页 SHOW
