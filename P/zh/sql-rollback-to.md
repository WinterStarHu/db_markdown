# ROLLBACK TO SAVEPOINT

ROLLBACK TO SAVEPOINT
版本：
纠错本页面
搜索
目录导航
❮
❯
ROLLBACK TO SAVEPOINTROLLBACK TO SAVEPOINT — 回滚到保存点大纲
ROLLBACK [ WORK | TRANSACTION ] TO [ SAVEPOINT ] savepoint_name
描述
回滚在保存点建立后执行的所有命令，然后在相同的事务级别启动一个新的子事务。
保存点仍然有效，并且如果需要，可以稍后再次回滚到该保存点。
ROLLBACK TO SAVEPOINT隐式地销毁在所提及的保存点
之后建立的所有保存点。
参数savepoint_name
要回滚到的保存点。
注释
使用RELEASE SAVEPOINT销毁一个保存点而
不抛弃在它建立之后被执行的命令的效果。
指定一个没有被建立的保存点是一种错误。
相对于保存点，游标有一点非事务的行为。在保存点被回滚时，任何在该保存点
内被打开的游标将会被关闭。如果一个先前打开的游标在一个保存点内被
FETCH或MOVE命令所影响，而该保存点
后来又被回滚，那么该游标将保持FETCH使它指向的位置（也
就是说由FETCH导致的游标动作不会被回滚）。回滚也不能
撤销关闭一个游标。不过，其他由游标查询导致的副作用（例如
被该查询所调用的易变函数的副作用）
会被回滚，只要它们发生在一个后来被回滚的保存点期间。
如果一个游标的执行导致事务中止，它会被置于一种不能被执行的状态，这样当
事务被用ROLLBACK TO SAVEPOINT恢复后，该游标也不再能
被使用。
示例
要撤销在my_savepoint建立后执行的命令的效果：
ROLLBACK TO SAVEPOINT my_savepoint;
游标位置不受保存点回滚的影响:
BEGIN;
DECLARE foo CURSOR FOR SELECT 1 UNION SELECT 2;
SAVEPOINT foo;
FETCH 1 FROM foo;
?column?
----------
1
ROLLBACK TO SAVEPOINT foo;
FETCH 1 FROM foo;
?column?
----------
2
COMMIT;
兼容性
SQL标准指定关键词
SAVEPOINT是强制的，但是PostgreSQL
和Oracle允许省略它。SQL 只允许WORK而
不是TRANSACTION作为ROLLBACK之后的噪声词。
另外，SQL 有一个可选的子句
AND [ NO ] CHAIN，当前
PostgreSQL并不支持。在其他方面，这个命令符合 SQL 标准。
另见BEGIN, COMMIT, RELEASE SAVEPOINT, ROLLBACK, SAVEPOINT上一页 上一级 下一页ROLLBACK PREPARED 起始页 SAVEPOINT
