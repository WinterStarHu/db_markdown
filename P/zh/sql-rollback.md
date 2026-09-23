# ROLLBACK

ROLLBACK
版本：
纠错本页面
搜索
目录导航
❮
❯
ROLLBACKROLLBACK — 中止当前事务大纲
ROLLBACK [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]
描述
ROLLBACK回滚当前事务并导致
该事务所作的所有更新都被抛弃。
参数WORKTRANSACTION #
可选关键字，没有效果。
AND CHAIN #
如果指定了AND CHAIN，则会立即启动一个具有相同事务特性
（参见SET TRANSACTION）的新事务（未中止的）。
否则，不会启动新事务。
注释
使用COMMIT就可以
成功地终止一个事务。
在一个事务块之外发出ROLLBACK会发出一个警告并且不会有效果。
事务块之外的ROLLBACK AND CHAIN是一个错误。
示例
要中止所有更改：
ROLLBACK;
兼容性
命令ROLLBACK符合 SQL 标准。形式ROLLBACK TRANSACTION是一个PostgreSQL扩展。
另见BEGIN, COMMIT, ROLLBACK TO SAVEPOINT上一页 上一级 下一页REVOKE 起始页 ROLLBACK PREPARED
