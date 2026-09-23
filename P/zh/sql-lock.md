# LOCK

LOCK
版本：
纠错本页面
搜索
目录导航
❮
❯
LOCKLOCK — 锁定表大纲
LOCK [ TABLE ] [ ONLY ] name [ * ] [, ...] [ IN lockmode MODE ] [ NOWAIT ]
其中 lockmode 是以下之一：
ACCESS SHARE | ROW SHARE | ROW EXCLUSIVE | SHARE UPDATE EXCLUSIVE
| SHARE | SHARE ROW EXCLUSIVE | EXCLUSIVE | ACCESS EXCLUSIVE
描述
LOCK TABLE获得一个表级锁，必要时会
等待任何冲突锁被释放。如果指定了NOWAIT，
LOCK TABLE不会等待以获得想要的锁：
如果它不能立刻得到，该命令会被中止并且发出一个错误。一旦获取到，
该锁会在当前事务中一直持有（没有UNLOCK
TABLE命令，锁总是在事务结束时被释放）。
当一个视图被锁定时，出现在该视图定义查询中的所有关系也将被使用同样的锁模式递归地锁住。
在为引用表的命令自动获取锁时，
PostgreSQL总是尽可能使用最不严格的
锁模式。提供LOCK TABLE是用于想要更严格
的锁定的情况。例如，假设一个应用运行一个READ COMMITTED
隔离级别的事务，
并且需要确保一个表中的数据在该事务的期间保持稳定。要实现这个目的，
你可以在查询之前在表上获得SHARE锁模式。这将阻止并发的
数据更改并且确保该表的后续读操作会看到已提交数据的一个稳定视图，
因为SHARE锁模式与写入者所要求的
ROW EXCLUSIVE锁有冲突，并且你的
LOCK TABLE name IN SHARE MODE
语句将等待，直到任何并发持有ROW
EXCLUSIVE模式锁的持有者提交或者回滚。因此，一旦得到锁，
就不会有未提交的写入还没有解决；更进一步，在释放该锁之前，任何
人都不能开始。
要在运行在REPEATABLE READ或SERIALIZABLE
隔离级别的事务中得到类似的效果，你必须在执行任何
SELECT或者数据修改语句之前执行
LOCK TABLE语句。一个
REPEATABLE READ或者SERIALIZABLE事务的
数据视图将在它的第一个SELECT或者数据修改语句开始
时被冻结。在该事务中稍后的一个LOCK TABLE仍将阻止并发写
— 但它不会确保该事务读到的内容对应于最新的已提交值。
如果一个此类事务正要修改表中的数据，那么它应该使用
SHARE ROW EXCLUSIVE锁模式来取代
SHARE模式。这会保证一次只有一个此类事务运行。如果
不用这种模式，死锁就可能出现：两个事务可能都获得
SHARE模式，并且都不能获得
ROW EXCLUSIVE模式来真正地执行它们的更新（注意一个
事务所拥有的锁不会冲突，因此一个事务可以在它持有SHARE
模式时获得ROW EXCLUSIVE模式 — 但是如果有其他
人持有SHARE模式时则不能）。为了避免死锁，确保所有的
事务在同样的对象上以相同的顺序获得锁，并且如果在一个对象上涉及多
种锁模式，事务应该总是首先获得最严格的那种模式。
更多关于锁模式和锁策略的信息可见第 13.3 节。
参数name
要锁定的一个现有表的名称（可以是模式限定的）。如果在表名前指定了
ONLY，只有该表会被锁定。如果没有指定
ONLY，该表和它所有的后代表（如果有）都会被锁定。可选
地，在表名后指定*来显式地表示把后代表包括在内。
命令LOCK TABLE a, b;等效于
LOCK TABLE a; LOCK TABLE b;。这些表会被按照在
LOCK TABLE中指定的顺序一个一个
被锁定。
lockmode
锁模式指定这个锁和哪些锁冲突。锁模式在第 13.3 节中描述。
如果没有指定锁模式，那么将使用最严格的模式ACCESS
EXCLUSIVE。
NOWAIT
指定LOCK TABLE不等待任何冲突锁被释放：
如果所指定的锁不能立即获得，那么事务就会中止。
注释
要锁定一个表，用户必须拥有指定lockmode的正确权限。
如果用户对该表拥有MAINTAIN、UPDATE、DELETE或
TRUNCATE权限，则允许任何lockmode。
如果用户对该表拥有INSERT权限，则允许ROW EXCLUSIVE
MODE（或如第 13.3 节中所述的冲突较少的模式）。如果用户对该表拥有
SELECT权限，则允许ACCESS SHARE MODE。
在视图上执行锁定操作的用户必须具有视图上相应的权限。此外，默认情况下，视图的所有者必须
对底层基本关系具有相关权限，而执行锁定操作的用户不需要对底层基本关系具有任何权限。
但是，如果视图的security_invoker设置为true
(参见CREATE VIEW)，
执行锁定操作的用户，而不是视图所有者，必须对底层基本关系具有相关权限。
LOCK TABLE在一个事务块外部没有用处：锁将只保持到语句完成。因此如果在一个事务块外部使用了LOCK，PostgreSQL会报告一个错误。使用BEGIN和COMMIT（或者ROLLBACK）定义一个事务块。
LOCK TABLE只处理表级锁，因此涉及到
ROW的模式名称在这里都是不当的。这些模式名称应该通常
被解读为用户在被锁定表中获取行级锁的意向。还有，
ROW EXCLUSIVE模式是一个可共享的表锁。记住就
LOCK TABLE而言，所有的锁模式都具有相同的语义，
只有模式的冲突规则有所不同。关于如何获取一个真正的行级锁的信息，
请见SELECT文档中的
第 13.3.2 节和The Locking Clause。
示例
在将要向一个外键表中执行插入时在主键表上获得一个
SHARE锁：
BEGIN WORK;
LOCK TABLE films IN SHARE MODE;
SELECT id FROM films
WHERE name = 'Star Wars: Episode I - The Phantom Menace';
-- 如果记录没有被返回就做 ROLLBACK
INSERT INTO films_user_comments VALUES
(_id_, 'GREAT! I was waiting for it for so long!');
COMMIT WORK;
在将要执行一次删除操作前在主键表上取一个
SHARE ROW EXCLUSIVE锁：
BEGIN WORK;
LOCK TABLE films IN SHARE ROW EXCLUSIVE MODE;
DELETE FROM films_user_comments WHERE id IN
(SELECT id FROM films WHERE rating < 5);
DELETE FROM films WHERE rating < 5;
COMMIT WORK;
兼容性
在 SQL 标准中没有LOCK TABLE，SQL 标准中使用
SET TRANSACTION指定事务上的并发级别。
PostgreSQL也支持这样做，详见
SET TRANSACTION。
除ACCESS SHARE、ACCESS EXCLUSIVE和
SHARE UPDATE EXCLUSIVE锁模式之外，
PostgreSQL锁模式和
LOCK TABLE语法与
Oracle中的兼容。
上一页 上一级 下一页LOAD 起始页 MERGE
