# dblink_cancel_query

dblink_cancel_query
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_cancel_querydblink_cancel_query — 在命名连接上取消任何活动查询大纲
dblink_cancel_query(text connname) returns text
描述
dblink_cancel_query尝试取消命名连接上正在进行的任何查询。注意这不一定会成功（例如，远程查询可能已经结束）。一个取消请求仅仅提高了该查询将很快失败的几率。你仍必须完成正常的查询协议，例如通过调用dblink_get_result。
参数connname
要使用的连接名称。
返回值
如果取消请求已经被发送，则返回OK；如果失败，则返回错误消息的文本。
示例
SELECT dblink_cancel_query('dtest1');
上一页 上一级 下一页dblink_get_result 起始页 dblink_get_pkey
