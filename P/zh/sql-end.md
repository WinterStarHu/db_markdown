# END

END
版本：
纠错本页面
搜索
目录导航
❮
❯
ENDEND — 提交当前事务大纲
END [ WORK | TRANSACTION ] [ AND [ NO ] CHAIN ]
描述
END 提交当前事务。所有该事务做的更改便得对他人可见并且被保证发生崩溃时仍然是持久的。这个命令是一种PostgreSQL扩展，它等效于COMMIT。
参数WORKTRANSACTION
可选关键词。它们没有效果。
AND CHAIN
如果规定了AND CHAIN，则立即启动与刚完成事务具有相同事务特征（参见 SET TRANSACTION）的新事务。否则，没有新事务被启动。
注释
使用ROLLBACK就可以中止一个事务。
当不在一个事务中时发出END没有危害，但是会
产生一个警告消息。
示例
要提交当前事务并让所有更改持久化：
END;
兼容性
END是一种PostgreSQL扩展，它提供和COMMIT等效的功能，后者在 SQL 标准中指定。
另见BEGIN, COMMIT, ROLLBACK上一页 上一级 下一页DROP VIEW 起始页 EXECUTE
