# dblink_error_message

dblink_error_message
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_error_messagedblink_error_message — 获取命名连接上的最后一个错误消息大纲
dblink_error_message(text connname) returns text
描述
dblink_error_message为一个给定连接获取最近的远程
错误消息。
参数connname
要使用的连接名称。
返回值
返回最后一个错误消息，如果在这个连接上没有错误则返回OK。
注意事项
当异步查询由dblink_send_query启动时，
与连接相关的错误消息可能不会得到更新，直到服务器的响应消息被消费。
这通常意味着dblink_is_busy或dblink_get_result应在
dblink_error_message之前被调用，以使得异步查询产生的任何错误都是可见的。
示例
SELECT dblink_error_message('dtest1');
上一页 上一级 下一页dblink_get_connections 起始页 dblink_send_query
