# dblink_is_busy

dblink_is_busy
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_is_busydblink_is_busy — 检查连接是否正在忙于异步查询大纲
dblink_is_busy(text connname) returns int
描述
dblink_is_busy 测试是否一个异步查询正在进行中。
参数connname
要检查的连接名称。
返回值
如果连接正忙则返回 1，如果不忙则返回 0。如果这个函数返回 0，dblink_get_result 将被保证不会阻塞。
示例
SELECT dblink_is_busy('dtest1');
上一页 上一级 下一页dblink_send_query 起始页 dblink_get_notify
