# 67.2. 事务与锁定

67.2. 事务与锁定
版本：
纠错本页面
搜索
目录导航
❮
❯
67.2. 事务与锁定 #
当前正在执行事务的事务ID显示在
pg_locks
的virtualxid和
transactionid列中。只读事务将具有
virtualxid，但transactionid
为NULL，而读写事务中这两列都将被设置。
一些锁类型会等待virtualxid，
而其他类型会等待transactionid。
行级读写锁直接记录在被锁定的行中，可以通过
pgrowlocks扩展进行检查。行级读锁可能还需要
分配多事务ID（mxid；参见第 24.1.5.1 节）。
上一页 上一级 下一页67.1. 事务和标识符 起始页 67.3. 子事务
