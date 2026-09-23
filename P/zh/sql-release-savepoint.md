# RELEASE SAVEPOINT

RELEASE SAVEPOINT
版本：
纠错本页面
搜索
目录导航
❮
❯
RELEASE SAVEPOINTRELEASE SAVEPOINT — 释放先前定义的保存点大纲
RELEASE [ SAVEPOINT ] savepoint_name
描述
RELEASE SAVEPOINT 释放指定的保存点以及在该保存点之后创建的
所有活动保存点，并释放它们的资源。自保存点创建以来未被回滚的所有更改将
合并到创建保存点时活动的事务或保存点中。在RELEASE SAVEPOINT
之后进行的更改也将成为该活动事务或保存点的一部分。
参数savepoint_name
要释放的保存点的名称。
注释
指定一个之前未定义的保存点名称是错误。
当事务处于中止状态时，不可能释放保存点；要执行此操作，请使用
ROLLBACK TO SAVEPOINT。
如果多个保存点具有相同的名称，则只释放最近定义的未释放的保存点。重复的命令将逐渐释放更早的保存点。
示例
要创建并稍后释放一个保存点：
BEGIN;
INSERT INTO table1 VALUES (3);
SAVEPOINT my_savepoint;
INSERT INTO table1 VALUES (4);
RELEASE SAVEPOINT my_savepoint;
COMMIT;
上述事务将插入3和4。
一个更复杂的示例，包含多个嵌套的子事务：
BEGIN;
INSERT INTO table1 VALUES (1);
SAVEPOINT sp1;
INSERT INTO table1 VALUES (2);
SAVEPOINT sp2;
INSERT INTO table1 VALUES (3);
RELEASE SAVEPOINT sp2;
INSERT INTO table1 VALUES (4); -- 产生错误
在此示例中，应用程序请求释放保存点sp2，该保存点插入了3。
这将插入操作的事务上下文更改为sp1。当尝试插入值4的语句
产生错误时，值2和4的插入将丢失，因为它们处于同一个现已回滚的保存点中，
而值3处于相同的事务上下文中。应用程序现在只能选择以下两个命令之一，
因为所有其他命令都会被忽略：
ROLLBACK;
ROLLBACK TO SAVEPOINT sp1;
选择ROLLBACK将中止所有操作，包括值1，而选择
ROLLBACK TO SAVEPOINT sp1将保留值1并允许事务继续。
兼容性
这个命令符合SQL标准。该标准指定关键词
SAVEPOINT是强制需要的，但
PostgreSQL允许省略。
另见BEGIN, COMMIT, ROLLBACK, ROLLBACK TO SAVEPOINT, SAVEPOINT上一页 上一级 下一页REINDEX 起始页 RESET
