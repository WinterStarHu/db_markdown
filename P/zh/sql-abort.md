# ABORT

ABORT
版本：
纠错本页面
搜索
目录导航
❮
❯
ABORTABORT — 中止当前事务大纲
ABORT [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]
描述
ABORT回滚当前事务并导致由该事务所作的所有更新被丢弃。
这个命令的行为与标准SQL命令
ROLLBACK的行为一样，
并且只是为了历史原因存在。
参数WORKTRANSACTION
可选关键词。它们没有效果。
AND CHAIN
如果规定了AND CHAIN，新事务立即启动，具有与刚刚完成的事务相同的事务特征（参见 SET TRANSACTION）。否则，
不会启动新事务。
注释
使用COMMIT 成功终止一个事务。
在一个事务块之外发出ABORT会发出一个警告并且不会产生效果。
示例
中止所有更改：
ABORT;
兼容性
这个命令是一个因为历史原因而存在的PostgreSQL扩展。ROLLBACK是等效的标准 SQL 命令。
另请参阅BEGIN, COMMIT, ROLLBACK上一页 上一级 下一页SQL 命令 起始页 ALTER AGGREGATE
