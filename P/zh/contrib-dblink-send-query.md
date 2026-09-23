# dblink_send_query

dblink_send_query
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_send_querydblink_send_query — 发送一个异步查询到远程数据库大纲
dblink_send_query(text connname, text sql) returns int
描述
dblink_send_query 发送一个要被异步执行的查询，也就是不需要立即等待结果。在该连接上不能有还在处理中的异步查询。
在成功地派送一个异步查询后，可以用 dblink_is_busy 检查完成状态，并且结果最终由 dblink_get_result 收集。也可以使用 dblink_cancel_query 尝试取消一个活动中的异步查询。
参数connname
要使用的连接名称。
sql
你希望在远程数据库中执行的 SQL 语句，例如select * from pg_class。
返回值
如果查询成功派送，则返回 1，否则返回 0。
示例
SELECT dblink_send_query('dtest1', 'SELECT * FROM foo WHERE f1 < 3');
上一页 上一级 下一页dblink_error_message 起始页 dblink_is_busy
