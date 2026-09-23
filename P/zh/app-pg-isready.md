# pg_isready

pg_isready
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_isreadypg_isready — 检查PostgreSQL服务器的连接状态大纲pg_isready [connection-option...] [option...]描述
pg_isready是一个用来检查PostgreSQL数据库服务器的连接状态的工具。其退出状态指定了连接检查的结果。
选项-d dbname--dbname=dbname
指定要连接的数据库名。dbname可以是一个connection string。如果是这样，连接字符串参数将覆盖任何冲突的命令行选项。
-h hostname--host=hostname
指定运行服务器的机器的主机名。如果该值以斜线开始，它将被用作Unix域套接字的目录。
-p port--port=port
指定服务器正在监听连接的TCP端口或本地Unix域套接字文件扩展。默认值取自PGPORT环境变量。如果环境变量没有设置，则默认值使用编译时指定的端口（通常是5432）。
-q--quiet
不显示状态消息。这在脚本编程时很有用。
-t seconds--timeout=seconds
尝试连接时，在返回服务器不响应之前等待的最大秒数。设置为 0 则禁用。默认值是 3 秒。
-U username--username=username
作为用户username连接数据库，而不是使用默认用户。
-V--version
打印pg_isready版本并退出。
-?--help
显示有关pg_isready命令行参数的帮助并退出。
退出状态
pg_isready返回0给 shell，如果服务器
正常接受连接；如果服务器拒绝连接（例如处于启动阶段），则返回1；如果连接尝试没有响应，则返回2；如果没有尝试（例如由于非法参数），则返回3。
环境
pg_isready，和大部分其他PostgreSQL
工具相似，也使用libpq支持的环境变量
（见第 32.15 节）。
环境变量PG_COLOR规定在诊断消息中是否使用颜色。可能的值为
always、auto和
never。
备注
要获得服务器状态，不一定需要提供正确的用户名、密码或数据库名。
不过，如果提供了不正确的值，服务器将会记录一次失败的连接尝试。
示例
标准用法：
$ pg_isready
/tmp:5432 - accepting connections
$ echo $?
0
使用连接参数运行连接到处于启动中的PostgreSQL集簇：
$ pg_isready -h localhost -p 5433
localhost:5433 - rejecting connections
$ echo $?
1
使用连接参数运行连接到无响应的PostgreSQL集簇：
$ pg_isready -h someremotehost
someremotehost:5432 - no response
$ echo $?
2
上一页 上一级 下一页pg_dumpall 起始页 pg_receivewal
