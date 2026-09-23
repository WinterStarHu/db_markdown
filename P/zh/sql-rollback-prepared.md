# ROLLBACK PREPARED

ROLLBACK PREPARED
版本：
纠错本页面
搜索
目录导航
❮
❯
ROLLBACK PREPAREDROLLBACK PREPARED — 取消一个之前为两阶段提交准备的事务大纲
ROLLBACK PREPARED transaction_id
描述
ROLLBACK PREPARED回滚一个处于准备状态的事务。
参数transaction_id
要回滚的事务的事务标识符。
注意事项
要回滚一个准备好的事务，你必须是原先执行该事务的同一个用户或者
是一个超级用户。但是你不必处在执行该事务的同一个会话中。
这个命令不能在一个事务块内被执行。准备好的事务会被立即回滚。
pg_prepared_xacts
系统视图中列出了当前可用的所有准备好的事务。
示例
用事务标识符foobar回滚对应的事务：
ROLLBACK PREPARED 'foobar';
兼容性
ROLLBACK PREPARED是一种
PostgreSQL扩展。其意图是用于
外部事务管理系统，其中有些已经被标准涵盖（例如 X/Open XA），
但是那些系统的 SQL 方面未被标准化。
另见PREPARE TRANSACTION, COMMIT PREPARED上一页 上一级 下一页ROLLBACK 起始页 ROLLBACK TO SAVEPOINT
