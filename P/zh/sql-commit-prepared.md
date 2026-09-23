# COMMIT PREPARED

COMMIT PREPARED
版本：
纠错本页面
搜索
目录导航
❮
❯
COMMIT PREPAREDCOMMIT PREPARED — 提交一个早前为两阶段提交准备的事务大纲
COMMIT PREPARED transaction_id
描述
COMMIT PREPARED 就可以提交一个处于预备状态的事务。
参数transaction_id
要被提交的事务的事务标识符。
备注
要提交一个预备的事务，你必须是原先执行该事务的同一用户或者超级用户。
但是不需要处于执行该事务的同一会话中。
这个命令不能在一个事务块中执行。该预备事务将被立即提交。
所有当前可用的预备事务都列在
pg_prepared_xacts
系统视图中。
示例
提交由事务标识符foobar标识的事务：
COMMIT PREPARED 'foobar';
兼容性
COMMIT PREPARED是一种
PostgreSQL扩展。其意图是用于
外部事务管理系统，其中有些已经被标准涵盖（例如 X/Open XA），
但是那些系统的 SQL 方面未被标准化。
另见PREPARE TRANSACTION, ROLLBACK PREPARED上一页 上一级 下一页COMMIT 起始页 COPY
