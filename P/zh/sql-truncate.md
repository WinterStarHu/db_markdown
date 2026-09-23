# TRUNCATE

TRUNCATE
版本：
纠错本页面
搜索
目录导航
❮
❯
TRUNCATETRUNCATE — 清空一个表或一组表大纲
TRUNCATE [ TABLE ] [ ONLY ] name [ * ] [, ... ]
[ RESTART IDENTITY | CONTINUE IDENTITY ] [ CASCADE | RESTRICT ]
描述
TRUNCATE可以从一组表中快速地移除所有行。
它具有和在每个表上执行无条件DELETE相同的
效果，不过它会更快，因为它没有实际扫描表。此外，它会立刻回收磁盘空间，
而不是要求一个后续的VACUUM操作。在大表上
它最有用。
参数name
要截断的表的名字（可以是模式限定的）。如果在表名前指定了
ONLY，则只会截断该表。如果没有指定ONLY，
该表及其所有后代表（如果有）都会被截断。可选地，可以在表名后指定
*来显式地包括后代表。
RESTART IDENTITY
自动重新开始被截断表的列所拥有的序列。
CONTINUE IDENTITY
不更改序列的值。这是默认值。
CASCADE
自动截断所有对任何所命名表有外键引用的表，或由于
CASCADE而被添加到组中的任何表。
RESTRICT
如果任一表上具有来自命令中没有列出的表的外键引用，则拒绝截断。这是默认值。
注释
要截断一个表，你必须具有其上的TRUNCATE特权。
TRUNCATE在要操作的表上获取一个
ACCESS EXCLUSIVE锁，这会阻塞所有其他在该表上的
并发操作。当指定RESTART IDENTITY时，任何需要被
重新开始的序列也会被排他地锁住。如果要求表上的并发访问，那么
应该使用DELETE命令。
TRUNCATE不能用于被其他表外键引用的表，
除非所有这些表也在同一个命令中被截断。在这种情况下检查有效性
将需要表扫描，而这样做的目的正是为了避免扫描。CASCADE
选项可以用来自动包括所有依赖表 — 但使用此选项时要非常
小心，否则你可能会丢失未曾打算丢失的数据！
特别注意，当要被截断的表是一个分区时，兄弟分区将保持不变，
但所有引用表及其所有分区将会发生级联。
TRUNCATE将不会引发表上可能存在的任何
ON DELETE触发器。但是它将会引发
ON TRUNCATE触发器。如果在这些表的任意一个
上定义了ON TRUNCATE触发器，那么所有的
BEFORE TRUNCATE触发器将在任何截断发生之前
被引发，而所有AFTER TRUNCATE触发器将在最后
一次截断完成并且所有序列被重置之后引发。触发器将按表被处理的顺
序引发（首先是那些被列在命令中的，然后是由于级联被添加的）。
TRUNCATE不是 MVCC 安全的。截断之后，
如果并发事务使用的是一个在截断发生前取得的快照，
表将对这些并发事务呈现为空。详见第 13.6 节。
从表中数据的角度来说，TRUNCATE是事务安全的：
如果所在的事务没有提交，截断将会被安全地回滚。
在指定了RESTART IDENTITY时，隐含的
ALTER SEQUENCE RESTART操作也会被事务性地完成。
也就是说，如果所在事务没有提交，它们也将被回滚。注意如果
事务回滚前在被重启序列上还做了额外的序列操作，这些操作在序列上的效果
也将被回滚，但是它们在currval()上的效果不会被回滚。也就
是说，在事务之后，currval()将继续反映在失败事务内得到的
最后一个序列值，即使序列本身可能已经不再与此一致。这和失败事务之后
currval()的通常行为类似。
TRUNCATE可以用于被外部数据封装器支持的外部表，
例如，参见postgres_fdw。
示例
截断表bigtable和
fattable：
TRUNCATE bigtable, fattable;
做同样的事情，并且还重置任何相关联的序列生成器：
TRUNCATE bigtable, fattable RESTART IDENTITY;
截断表othertable，并级联截断任何通过
外键约束引用othertable的表：
TRUNCATE othertable CASCADE;
兼容性
SQL:2008 标准包括了一个TRUNCATE命令，
语法是TRUNCATE TABLE
tablename。子句
CONTINUE IDENTITY/RESTART IDENTITY
也出现在了该标准中，但是含义有些不同。这个命令的一些并发行为被标准
留给实现来定义，因此如果必要应该考虑上述注解并且与其他实现进行比较。
另请参阅DELETE上一页 上一级 下一页START TRANSACTION 起始页 UNLISTEN
