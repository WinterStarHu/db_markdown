# dropdb

dropdb
版本：
纠错本页面
搜索
目录导航
❮
❯
dropdbdropdb — 移除一个PostgreSQL数据库大纲dropdb [connection-option...] [option...]  dbname 说明
dropdb毁掉一个现有的PostgreSQL数据库。
执行这个命令的用户必须是一个数据库超级用户或该数据库的拥有者。
dropdb是SQL命令
DROP DATABASE的一个包装器。
在通过这个工具和其他方法访问服务器来删除数据库之间没有实质性的区别。
选项
dropdb接受下列命令行参数：
dbname
指定要被移除的数据库的名字。
-e---echo
回显dropdb生成并发送给服务器的命令。
-f---force
在删除目标数据库之前，尝试终止与该数据库的所有现有连接。
有关此选项的详细信息，请参见DROP DATABASE。
-i---interactive
在做任何破坏性的工作之前发出一个验证提示。
-V---version
打印dropdb版本并退出。
---if-exists
如果数据库不存在也不抛出一个错误。在这种情况下会发出一个提示。
-?---help
显示有关dropdb命令行参数的帮助并退出。
dropdb也接受下列命令行参数作为连接参数：
-h host---host=host
指定运行服务器的机器的主机名。如果该值以一个斜线开始，它被用作Unix域套接字的目录。
-p port---port=port
指定服务器正在监听连接的TCP端口或本地Unix域套接字文件扩展。
-U username---username=username
要作为哪个用户连接。
-w---no-password
不发出口令提示。如果服务器要求口令认证并且没有可用的口令（例如一个.pgpass文件），那么连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W---password
强制dropdb在连接到一个数据库之前提示要求一个口令。
这个选项不是必不可少的，因为如果服务器要求口令认证，dropdb将自动提示要求一个口令。
但是，dropdb将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下值得用-W来避免额外的连接尝试。
---maintenance-db=dbname
指定一个数据库的名称，将连接到这个数据库以便删除目标数据库。如果没有指定，将使用postgres数据库。而如果它也不存在（或者它就是正在被删除的目标数据库），将使用template1。这个值可以是一个连接字符串。 如果是这样，连接字符串参数将覆盖任何有冲突的命令行选项。
环境PGHOSTPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
诊断
在有困难时，可以在DROP DATABASE和psql中找找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要在默认数据库服务器上删除数据库demo：
$ dropdb demo
要使用在主机eden、端口5000上的服务器中删除数据库demo，并带有验证和回显，看看下面的命令：
$ dropdb -p 5000 -h eden -i -e demo
Database "demo" will be permanently deleted.
Are you sure? (y/n) y
DROP DATABASE demo;
其他参考createdb, DROP DATABASE上一页 上一级 下一页createuser 起始页 dropuser
