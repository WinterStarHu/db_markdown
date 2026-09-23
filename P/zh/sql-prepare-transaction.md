# PREPARE TRANSACTION

PREPARE TRANSACTION
版本：
纠错本页面
搜索
目录导航
❮
❯
PREPARE TRANSACTIONPREPARE TRANSACTION — 为两阶段提交准备当前事务大纲
PREPARE TRANSACTION transaction_id
描述
PREPARE TRANSACTION为两阶段提交准备
当前事务。在这个命令之后，该事务不再与当前会话关联。相反，它的状态
被完全存储在磁盘上，并且有很高的可能性它会被提交成功（即便在请求提
交前发生数据库崩溃）。
一旦被准备好，事务稍后就可以分别用COMMIT PREPARED或者ROLLBACK PREPARED提交或者回滚。
可以从任何会话而不仅仅是执行原始事务的会话中发出这些命令。
从发出命令的会话的角度来看，PREPARE
TRANSACTION不像ROLLBACK命令：
在执行它之后，就没有活跃的当前事务，并且该预备事务的效果也不再可见（
如果该事务被提交，效果将重新变得可见）。
如果由于任何原因PREPARE TRANSACTION
命令失败，它会变成一个ROLLBACK：当前事务会被取消。
参数transaction_id
一个任意的事务标识符，
COMMIT PREPARED或者ROLLBACK PREPARED
以后将用这个标识符来标识这个事务。该标识符必须写成一个字符串，
并且长度必须小于 200 字节。它不能与任何当前已经准备好的事务的标识符相同。
备注
PREPARE TRANSACTION并不是设计为在应用或者交互式
会话中使用。它的目的是允许一个外部事务管理器在多个数据库或者其他事务性
资源之间执行原子的全局事务。除非你在编写一个事务管理器，否则你可能不应该
用到PREPARE TRANSACTION。
这个命令必须在一个事务块中使用。事务块用BEGIN开始。
当前在已经执行过任何涉及到临时表或者会话的临时命名空间、创建带
WITH HOLD的游标或者执行
LISTEN、UNLISTEN或NOTIFY的
事务中，不允许PREPARE该事务。这些特性与当前会话
绑定得太过紧密，所以对一个要被准备的事务来说没有什么用处。
如果用SET（不带LOCAL选项）修改过事务的
任何运行时参数，这些效果会持续到
PREPARE TRANSACTION之后，并且将不会被后续的任何
COMMIT PREPARED或
ROLLBACK PREPARED所影响。因此，在这一
方面PREPARE TRANSACTION的行为更像
COMMIT而不是ROLLBACK。
所有当前可用的准备好事务被列在pg_prepared_xacts系统视图中。
小心
让一个事务处于准备好状态太久是不明智的。这将会干扰
VACUUM回收存储的能力，并且在极限情况下可能导致
数据库关闭以阻止事务 ID 回绕（见第 24.1.5 节）。还要记住，该事务会继续持有
它已经持有的锁。该特性的设计用法是，只要一个外部事务管理器已经验证
其他数据库也准备好了要提交，一个准备好的事务将被正常地提交或者回滚。
如果没有建立一个外部事务管理器来跟踪准备好的事务并且确保它们被迅速地
结束，最好禁用准备好事务特性（设置
max_prepared_transactions为零）。这将
防止意外创建准备好的事务，不然该事务有可能被忘记并且最终导致问题。
示例
为两阶段提交准备当前事务，使用foobar作为事务标识符：
PREPARE TRANSACTION 'foobar';
兼容性
PREPARE TRANSACTION是一种
PostgreSQL扩展。其意图是用于
外部事务管理系统，其中有些已经被标准涵盖（例如 X/Open XA），
但是那些系统的 SQL 方面未被标准化。
另见COMMIT PREPARED, ROLLBACK PREPARED上一页 上一级 下一页PREPARE 起始页 REASSIGN OWNED
