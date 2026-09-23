# 47.9. 用于逻辑解码的大事务的流式传输

47.9. 用于逻辑解码的大事务的流式传输
版本：
纠错本页面
搜索
目录导航
❮
❯
47.9. 用于逻辑解码的大事务的流式传输 #
基本输出插件回调（例如，begin_cb、change_cb、commit_cb 和
message_cb）只在事务实际提交时调用。更改仍然从事务日志中解码，但只在提交时传递给输出插件（如果事务中止，则丢弃）。
这意味着虽然解码是增量进行的，并且可能溢出到磁盘以保持内存使用是可控的，
当事务最终提交时（或者更准确地说，当提交已从事务日志中解码时），必须传送所有已解码的更改。
根据事务的大小和网络带宽，传输时间可能会显著增加应用延迟。
为了减少大事务引起的应用延迟，输出插件可以提供额外的回调来支持正在进行中事务的增量流式传输。
有多个必需的流式传输回调（stream_start_cb、stream_stop_cb、
stream_abort_cb、stream_commit_cb和stream_change_cb），
以及两个可选的回调（stream_message_cb和stream_truncate_cb）。
此外，如果要支持两阶段命令的流式传输，则必须提供额外的回调。（有关详细信息，请参见第 47.10 节）。
当流式传输正在进行的事务时，更改（和消息）以由stream_start_cb和stream_stop_cb回调标记的块进行流式传输。
一旦所有解码的更改被传输，事务可以使用stream_commit_cb回调提交
（或可能使用stream_abort_cb回调中止）。
如果支持两阶段提交，事务可以使用stream_prepare_cb回调准备，
使用COMMIT PREPARED并使用commit_prepared_cb回调或使用rollback_prepared_cb中止。
一个事务的流式回调调用示例可能如下所示：
stream_start_cb(...);   <-- 开始第一个更改块
stream_change_cb(...);
stream_change_cb(...);
stream_message_cb(...);
stream_change_cb(...);
...
stream_change_cb(...);
stream_stop_cb(...);    <-- 结束第一个更改块
stream_start_cb(...);   <-- 开始第二个更改块
stream_change_cb(...);
stream_change_cb(...);
stream_change_cb(...);
...
stream_message_cb(...);
stream_change_cb(...);
stream_stop_cb(...);    <-- 结束第二个更改块
[a. 使用普通提交时]
stream_commit_cb(...);    <-- 提交流式事务
[b. 使用两阶段提交时]
stream_prepare_cb(...);   <-- 准备流式事务
commit_prepared_cb(...);  <-- 提交准备好的事务
当然，回调调用的实际顺序可能更复杂。
可能会有多个流事务的块，一些事务也许会被中止，等等。
与溢出到磁盘的行为类似，流会被触发，当从WAL（对于所有正在进行的事务）解码的更改总数超过logical_decoding_work_mem设置定义的限制时。
此时，最大的顶级事务（通过当前用于解码更改的内存量来衡量）会被选择并流式处理。
然而，在某些情况下，即使启用了流，我们仍然必须溢出到磁盘，因为我们超过了内存阈值，但仍然没有解码完整的元组，例如，只解码toast表插入，但没有主表插入。
即使在流式处理大型事务时，更改仍然按照提交顺序应用，保留了与非流式模式相同的保证。
上一页 上一级 下一页47.8. 逻辑解码的同步复制支持 起始页 47.10. 对逻辑解码的两阶段提交支持
