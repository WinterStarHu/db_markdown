# vacuumlo

vacuumlo
版本：
纠错本页面
搜索
目录导航
❮
❯
vacuumlovacuumlo — 从PostgreSQL数据库中移除孤立的大对象大纲vacuumlo [option...]  dbname... 描述
vacuumlo是一个简单的实用程序，用于从PostgreSQL数据库中移除任何“孤立”的大对象。一个孤立的大对象（LO）是指其OID不出现在数据库的任何oid或lo数据列中。
如果你使用该程序，你也许还会对lo模块中的lo_manage触发器感兴趣。lo_manage对于避免创建孤立的LO非常有用。
在命令行中提到的所有数据库都将被处理。
选项
vacuumlo接受下列命令行参数：
-l limit--limit=limit
在每个事务中移除不超过limit个大对象（默认值为1000）。因为移除每个LO时服务器都将要求一个锁，所以在一个事务中移除过多的LO会有超过max_locks_per_transaction的风险。如果你想在一个事务中完成所有的移除工作，请将这个限制设置为0。
-n--dry-run不移除任何东西，只是显示将会做什么。-v--verbose写很多进度消息。-V--version
打印vacuumlo的版本并退出。
-?--help
显示关于vacuumlo的命令行参数，并且退出。
vacuumlo也接受下列命令行参数用于连接：
-h host--host=host数据库服务器的主机名。-p port--port=port数据库服务器的端口。-U username--username=username用于连接的用户名。-w--no-password
不要发出一个密码提示。如果服务器要求密码认证并且没有其他方式可以提供一个密码（例如一个.pgpass文件），连接尝试将会失败。这个选项可用于批处理任务以及脚本，因为在这些情况下不会有用户输入密码。
-W--password
强制vacuumlo在连接到数据库之前提示要求一个密码。
这个选项不是不可缺少的，因为如果服务器要求密码认证，vacuumlo会自动提示要求一个密码。但是，vacuumlo将会浪费一次连接尝试来了解到服务器需要密码。在某些情况下，值得用-W来避免这种额外的连接尝试。
环境PGHOSTPGPORTPGUSER
默认连接参数。
这个实用程序，像其他大多数PostgreSQL实用程序，也使用 libpq 支持的环境变量(参见 第 32.15 节)。
环境变量 PG_COLOR 指定是否在诊断消息中使用颜色。可能的值是 always、auto 和 never。
说明
vacuumlo按照下列方法工作：首先vacuumlo建立一个临时表，其中包含所选择数据库中所有大对象的OID。然后它会扫描数据库中所有类型为oid或lo的列，并且从临时表中移除在这些列中出现过的OID（注意：只有类型为这些名字的才被考虑，特别是，在这些类型之上的域是不被考虑的）。临时表中剩下的项就标识了孤立的LO。它们将被移除。
作者
Peter Mount <peter@retep.org.uk>
上一页 上一级 下一页oid2name 起始页 G.2. 服务器应用程序
