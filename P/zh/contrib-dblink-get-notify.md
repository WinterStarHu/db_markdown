# dblink_get_notify

dblink_get_notify
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_get_notifydblink_get_notify — 在连接上检索异步通知大纲
dblink_get_notify() returns setof (notify_name text, be_pid int, extra text)
dblink_get_notify(text connname) returns setof (notify_name text, be_pid int, extra text)
描述
dblink_get_notify在一个未命名连接或者一个指定的命名连接上检索通知。要通过 dblink 接收通知，首先必须使用 dblink_exec 发出 LISTEN。详见 LISTEN 和 NOTIFY。
参数connname
要在其上接收通知的命名连接的名称。
Return Value返回 setof (notify_name text, be_pid int, extra text)，或一个空集。Examples
SELECT dblink_exec('LISTEN virtual');
dblink_exec
-------------
LISTEN
(1 row)
SELECT * FROM dblink_get_notify();
notify_name | be_pid | extra
-------------+--------+-------
(0 rows)
NOTIFY virtual;
NOTIFY
SELECT * FROM dblink_get_notify();
notify_name | be_pid | extra
-------------+--------+-------
virtual     |   1229 |
(1 row)
上一页 上一级 下一页dblink_is_busy 起始页 dblink_get_result
