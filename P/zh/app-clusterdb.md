# clusterdb

clusterdb
版本：
纠错本页面
搜索
目录导航
❮
❯
clusterdbclusterdb — 聚簇一个PostgreSQL数据库大纲clusterdb [connection-option...] [option...]
[
--table  |   -t
table
]
...  [
dbname  |   -a  |   --all
]描述
clusterdb是一个工具，它用来对一个PostgreSQL数据库中的表进行重新聚簇。它会寻找之前已经被聚簇过的表，并且再次在最后使用过的同一个索引上对它们重新聚簇。没有被聚簇过的表将不会被影响。
clusterdb是 SQL 命令CLUSTER的一个包装器。在通过这个工具和其他方法访问服务器来聚簇数据库之间没有实质性的区别。
选项
clusterdb接受下列命令行参数：
-a--all
聚簇所有数据库。
[-d] dbname[--dbname=]dbname
当不使用-a/--all时，指定要被聚簇的数据库名称。
如果数据库名称未指定，则从环境变量PGDATABASE中读取数据库名称。
如果该环境变量也没有被设置，则使用为连接指定的用户名作数据库名。
dbname可以是connection string。
如果是这样，连接时的字符串参数将覆盖所有冲突的命令行选项。
-e--echo
回显clusterdb生成并发送给服务器的命令。
-q--quiet
不显示进度消息。
-t table--table=table
只聚簇table。可以通过写多个-t开关来聚簇多个表。
-v--verbose
在处理期间打印详细信息。
-V--version
打印clusterdb版本并退出。
-?--help
显示关于clusterdb命令行参数的帮助并退出。
clusterdb 还接受以下用于连接参数的命令行参数：
-h host--host=host
指定服务器运行所在机器的主机名。如果值以斜杠开头，则用作
Unix 域套接字的目录。
-p port--port=port
指定服务器监听连接的 TCP 端口或本地 Unix 域套接字文件扩展名。
-U username--username=username
用于连接的用户名。
-w--no-password
永不提示输入密码。如果服务器要求密码认证且无法通过
其他方式（如.pgpass文件）获得密码，
连接尝试将失败。此选项在批处理作业和脚本中很有用，
因为没有用户输入密码。
-W--password
强制 clusterdb 在连接数据库前提示输入密码。
该选项通常不是必需的，因为
clusterdb 会在服务器要求密码认证时自动提示密码。
但是，clusterdb 会浪费一次连接尝试来确认服务器是否需要密码。
在某些情况下，输入 -W 可以避免额外的连接尝试。
--maintenance-db=dbname
当使用 -a/--all 时，连接到此数据库以获取要聚簇的数据库列表。
如果未指定，则使用 postgres 数据库，
如果该数据库不存在，则使用 template1。
这可以是一个 连接字符串。
如果是，连接字符串参数将覆盖任何冲突的命令行选项。
此外，除数据库名本身外的连接字符串参数将在连接其他数据库时重用。
环境PGDATABASEPGHOSTPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可选的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
诊断
在有困难时，可以在CLUSTER和psql中找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要聚簇数据库test：
$ clusterdb test
要在数据库xyzzy中聚簇一个表foo：
$ clusterdb --table=foo xyzzy
另请参阅CLUSTER上一页 上一级 下一页PostgreSQL 客户端应用程序 起始页 createdb
