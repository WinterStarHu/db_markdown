# F.11. dblink — 连接到其他 PostgreSQL 数据库

F.11. dblink — 连接到其他 PostgreSQL 数据库
版本：
纠错本页面
搜索
目录导航
❮
❯
F.11. dblink — 连接到其他 PostgreSQL 数据库 #dblink_connect — 打开一个持久连接到远程数据库dblink_connect_u — 不安全地打开一个持久连接到远程数据库dblink_disconnect — 关闭到远程数据库的持久连接dblink — 在远程数据库中执行查询dblink_exec — 在远程数据库中执行命令dblink_open — 在远程数据库中打开游标dblink_fetch — 从一个远程数据库中的打开的游标返回行dblink_close — 关闭远程数据库中的游标dblink_get_connections — 返回所有打开的命名dblink连接的名称dblink_error_message — 获取命名连接上的最后一个错误消息dblink_send_query — 发送一个异步查询到远程数据库dblink_is_busy — 检查连接是否正在忙于异步查询dblink_get_notify — 在连接上检索异步通知dblink_get_result — 获取一个异步查询结果dblink_cancel_query — 在命名连接上取消任何活动查询dblink_get_pkey — 返回一个关系的主键字段的位置和字段名称
dblink_build_sql_insert —
使用一个本地元组构建一个 INSERT 语句，将主键字段值替换为提供的值
dblink_build_sql_delete — 使用所提供的主键字段值构建一个 DELETE 语句
dblink_build_sql_update — 使用一个本地元组构建一个 UPDATE 语句，将主键字段值替换为提供的值
dblink是一个支持在一个数据库会话中连接到其他PostgreSQL数据库的模块。
dblink can report the following wait events under the wait
event type Extension.
DblinkConnect
正在等待与远程服务器建立连接。
DblinkGetConnect
等待建立与远程服务器的连接时，发现该服务器不在已打开连接的列表中。
DblinkGetResult
正在等待从远程服务器接收查询结果。
还可以看看postgres_fdw，它以一种更现代和更加兼容标准的架构提供了相同的功能。
上一页 上一级 下一页F.10. cube — 一种多维立方体数据类型 起始页 dblink_connect
