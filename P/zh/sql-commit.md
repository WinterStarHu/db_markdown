# COMMIT

COMMIT
版本：
纠错本页面
搜索
目录导航
❮
❯
COMMITCOMMIT — 提交当前事务大纲
COMMIT [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]
描述
COMMIT 提交当前事务。所有由该
事务所作的更改会变得对他人可见并且被保证在崩溃发生时仍能
持久。
参数WORKTRANSACTION #
可选的关键词。它们没有效果。
AND CHAIN #
如果指定了AND CHAIN，则立即启动与刚刚完成的事务具有相同事务特征（参见SET TRANSACTION）的新事务。
否则，没有新事务被启动。
注释
使用ROLLBACK中止一个事务。
当不在一个事务内时发出COMMIT不会
产生危害，但是它会产生一个警告消息。当COMMIT AND CHAIN不在事务内时是一个错误。
示例
要提交当前事务并让所有更改持久化：
COMMIT;
兼容性
命令COMMIT符合 SQL 标准。
表单COMMIT TRANSACTION为PostgreSQL扩展。
另请参阅BEGIN, ROLLBACK上一页 上一级 下一页COMMENT 起始页 COMMIT PREPARED
