# dblink_get_connections

dblink_get_connections
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_get_connectionsdblink_get_connections — 返回所有打开的命名dblink连接的名称大纲
dblink_get_connections() returns text[]
描述
dblink_get_connections返回一个数组，其中是所有打开的命名dblink连接的名称。
返回值返回一个连接名称的文本数组，如果没有则为 NULL。示例
SELECT dblink_get_connections();
上一页 上一级 下一页dblink_close 起始页 dblink_error_message
