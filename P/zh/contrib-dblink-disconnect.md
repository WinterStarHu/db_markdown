# dblink_disconnect

dblink_disconnect
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_disconnectdblink_disconnect — 关闭到远程数据库的持久连接大纲
dblink_disconnect() returns text
dblink_disconnect(text connname) returns text
描述
dblink_disconnect()关闭一个之前被dblink_connect()打开的连接。 不带参数的形式关闭一个未命名连接。
参数connname
要关闭的命名连接的名称。
返回值
返回状态，它总是OK（因为任何错误会导致该函数抛出错误而不是返回）。
示例
SELECT dblink_disconnect();
dblink_disconnect
-------------------
OK
(1 row)
SELECT dblink_disconnect('myconn');
dblink_disconnect
-------------------
OK
(1 row)
上一页 上一级 下一页dblink_connect_u 起始页 dblink
