# 47.10. 对逻辑解码的两阶段提交支持

47.10. 对逻辑解码的两阶段提交支持
版本：
纠错本页面
搜索
目录导航
❮
❯
47.10. 对逻辑解码的两阶段提交支持 #
使用基本输出插件回调（例如，begin_cb，
change_cb，commit_cb 和
message_cb）两阶段提交命令像
PREPARE TRANSACTION、COMMIT PREPARED
和 ROLLBACK PREPARED 不被解码。
当 PREPARE TRANSACTION 被忽略时，
COMMIT PREPARED 被解码为 COMMIT
而 ROLLBACK PREPARED 被解码为
ROLLBACK。
为了支持两阶段命令的流，输出插件需要提供附加的回调。
有多个需要的两阶段提交回调（begin_prepare_cb，
prepare_cb，commit_prepared_cb，
rollback_prepared_cb 和 stream_prepare_cb）
以及一个可选的回调（filter_prepare_cb）。
如果提供了解码两阶段提交命令的输出插件回调，那么在PREPARE TRANSACTION时，该事务的更改被解码，传递给输出插件，并调用prepare_cb回调。
这与只有在提交事务时才将更改传递给输出插件的基本解码设置不同。
准备好的事务的开始由begin_prepare_cb回调指示。
当使用ROLLBACK PREPARED回滚一个准备好的事务时，则调用rollback_prepared_cb回调；当准备好的事务使用COMMIT PREPARED提交时，则调用commit_prepared_cb回调。
可选地，输出插件还可以通过filter_prepare_cb定义过滤规则，以在两个阶段中只解码特定的事务。
这可以通过在gid上进行模式匹配或通过使用xid查找来实现。
想要解码准备好的事务的用户，需要注意以下提到的几点：
如果准备的事务排它地锁定了[user]目录表，那么解码准备可以阻塞，直到主事务被提交。
用此特性构建分布式两阶段提交的逻辑复制解决方案可能会死锁，如果准备好的事务排它地锁定了[user]目录表的话。
为了避免这种情况，用户必须避免在这样的事务中在目录表上加锁（例如显式的LOCK命令）。
详请参阅第 47.8.2 节。
上一页 上一级 下一页47.9. 用于逻辑解码的大事务的流式传输 起始页 第 48 章 复制进度跟踪
