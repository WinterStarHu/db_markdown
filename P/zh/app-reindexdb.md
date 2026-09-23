# reindexdb

reindexdb
版本：
纠错本页面
搜索
目录导航
❮
❯
reindexdbreindexdb — 重新索引一个PostgreSQL数据库大纲reindexdb [connection-option...] [option...]
[
-S  |   --schema
schema
]
...
[
-t  |   --table
table
]
...
[
-i  |   --index
index
]
...
[
-s  |   --system
]
[
dbname  |   -a  |   --all
]描述
reindexdb是用于重建PostgreSQL数据库中索引的工具。
reindexdb是 SQL 命令REINDEX的一个包装器。
在通过这个工具和其他方法访问服务器来重新索引数据库之间没有实质性的区别。
选项
reindexdb 接受以下命令行参数：
-a--all
重新索引所有数据库。
--concurrently
使用CONCURRENTLY选项。参见
REINDEX, 其中详细说明了此选项的所有注意事项。
[-d] dbname[--dbname=]dbname
指定要重新索引的数据库名称，当未使用-a/--all时。
如果未指定，则从环境变量PGDATABASE读取数据库名称。
如果该变量未设置，则使用连接时指定的用户名。dbname可以是一个
连接字符串。如果是这样，连接字符串参数将覆盖任何冲突的命令行选项。
-e--echo
回显reindexdb生成并发送到服务器的命令。
-i index--index=index
仅重新创建index。
可以通过写多个-i开关来重新创建多个索引。
-j njobs--jobs=njobs
通过同时运行
njobs
个命令并行执行重新索引命令。此选项可能减少处理时间，
但也会增加数据库服务器的负载。
reindexdb 将打开
njobs 个连接到数据库，
因此请确保您的 max_connections
设置足够高以容纳所有连接。
注意此选项与--system选项不兼容。
-q--quiet
不显示进度消息。
-s--system
仅重新索引数据库的系统目录。
-S schema--schema=schema
仅重新索引schema。
可以通过编写多个-S开关来重新索引多个模式。
-t table--table=table
仅重新索引table。
可以通过编写多个-t开关来重新索引多个表。
--tablespace=tablespace
指定重建索引所在的表空间。（此名称作为双引号标识符进行处理。）
-v--verbose
在处理过程中打印详细信息。
-V--version
打印reindexdb版本并退出。
-?--help
显示关于reindexdb命令行参数的帮助信息，然后退出。
reindexdb 还接受以下用于连接参数的命令行参数：
-h host--host=host
指定服务器运行所在机器的主机名。如果值以斜杠开头，则用作
Unix 域套接字的目录。
-p port--port=port
指定服务器监听连接的 TCP 端口或本地 Unix 域套接字文件扩展名。
-U username--username=username
用于连接的用户名。
-w--no-password
永不提示输入密码。如果服务器要求密码认证且没有通过
其他方式（如.pgpass文件）提供密码，
连接尝试将失败。此选项在批处理作业和脚本中很有用，
因为没有用户输入密码。
-W--password
强制 reindexdb 在连接数据库前提示输入密码。
该选项通常不必需，因为 reindexdb 会在服务器
需要密码认证时自动提示输入密码。但 reindexdb 会
先尝试连接，发现服务器需要密码后才提示，这会浪费一次连接尝试。
在某些情况下，输入 -W 可以避免额外的连接尝试。
--maintenance-db=dbname
当使用 -a/--all 时，连接到此数据库以
收集要重建索引的数据库列表。如果未指定，则使用
postgres 数据库；如果该数据库不存在，则使用
template1。这可以是一个
连接字符串。如果是这样，
连接字符串参数将覆盖任何冲突的命令行选项。此外，除数据库名外的
连接字符串参数在连接其他数据库时也会被重用。
环境PGDATABASEPGHOSTPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
诊断
在有困难时，可以在REINDEX和psql中找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要重新索引数据库test：
$ reindexdb test
要重新索引名为abcd的数据库中的表foo和索引bar：
$ reindexdb --table=foo --index=bar abcd
参见REINDEX上一页 上一级 下一页psql 起始页 vacuumdb
