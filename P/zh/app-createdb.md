# createdb

createdb
版本：
纠错本页面
搜索
目录导航
❮
❯
createdbcreatedb — 创建一个新的PostgreSQL数据库大纲createdb [connection-option...] [option...] [dbname
[description]]描述
createdb 创建一个新的PostgreSQL
数据库。
通常，执行这个命令的数据库用户将成为新数据库的所有者。
但是，如果执行用户具有合适的权限，可以通过-O
选项指定一个不同的所有者。
createdb 是 SQL 命令CREATE DATABASE的一个包装器。
在通过这个工具和其他方法访问服务器来创建数据库之间没有实质性的区别。
选项
createdb 接受以下命令行参数：
dbname
指定要创建的数据库的名称。该名称必须在此集群中所有PostgreSQL数据库中是唯一的。
默认情况下，将创建一个与当前系统用户名称相同的数据库。
description
指定与新创建的数据库关联的注释。
-D tablespace--tablespace=tablespace
指定数据库的默认表空间。（此名称将被处理为双引号标识符。）
-e--echo
回显createdb生成并发送到服务器的命令。
-E encoding--encoding=encoding
指定在此数据库中使用的字符编码方案。PostgreSQL服务器支持的字符集在第 23.3.1 节中描述。
-l locale--locale=locale
指定要在此数据库中使用的区域设置。这相当于将
--lc-collate、--lc-ctype 和
--icu-locale 设置为相同的值。一些区域设置仅对
ICU有效，必须使用--icu-locale设置。
--lc-collate=locale
指定在此数据库中使用的LC_COLLATE设置。
--lc-ctype=locale
指定在此数据库中使用的LC_CTYPE设置。
--builtin-locale=locale
指定使用内置提供程序时的区域设置名称。区域设置支持详见
第 23.1 节。
--icu-locale=locale
指定在选择ICU区域设置提供程序时在此数据库中使用的ICU区域设置ID。
--icu-rules=rules
指定额外的排序规则以自定义此数据库默认排序的行为。这仅支持ICU。
--locale-provider={builtin|libc|icu}
指定数据库默认排序规则的区域设置提供程序。
-O owner--owner=owner
指定将拥有新数据库的数据库用户。
（此名称将被处理为双引号标识符。）
-S strategy--strategy=strategy
指定数据库创建策略。查看CREATE DATABASE STRATEGY获取更多详细信息。
-T template--template=template
指定用于构建此数据库的模板数据库。（此名称将被处理为双引号标识符。）
-V--version
打印createdb的版本并退出。
-?--help
显示关于createdb命令行参数的帮助信息，并退出。
选项-D、-l、-E、
-O和
-T对应于底层 SQL 命令CREATE DATABASE的选项，关于这些选项的信息可见该命令的内容。
createdb也接受下列命令行参数用于连接参数：
-h host--host=host
指定运行服务器的机器的主机名。如果该值以一个斜线开始，它被用作 Unix 域套接字的目录。
-p port--port=port
指定服务器正在监听连接的 TCP 端口或本地 Unix 域套接字文件扩展。
-U username--username=username
要作为哪个用户连接。
-w--no-password
从不发出一个口令提示。如果服务器要求口令认证并且没有其他方式提供口令（例如一个.pgpass文件），那儿连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W--password
强制createdb在连接到一个数据库之前提示要求一个口令。
这个选项不是必不可少的，因为如果服务器要求口令认证，createdb将自动提示要求一个口令。但是，createdb将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下值得用-W来避免额外的连接尝试。
--maintenance-db=dbname
指定要连接到的数据库名，以便创建新数据库。如果没有指定，将使用postgres数据库；如果它也不存在（或者如果它就是要创建新数据库的名称），将使用template1。
环境PGDATABASE
如果被设置，就是要创建的数据库名，除非在命令行中覆盖。
PGHOSTPGPORTPGUSER
默认连接参数。如果没有在命令行或PGDATABASE指定要创建的数据库名，PGUSER也决定要创建的数据库名。
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为 always，auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq支持的环境变量（见第 32.15 节）。
诊断
在遇到困难时，可以在CREATE DATABASE和psql中找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要使用默认数据库服务器创建数据库demo：
$ createdb demo
要在主机eden、端口5000上使用template0
模板数据库创建数据库demo，这里是命令行命令和底层SQL命令：
$ createdb -p 5000 -h eden -T template0 -e demo
CREATE DATABASE demo TEMPLATE template0;
另请参阅dropdb, CREATE DATABASE上一页 上一级 下一页clusterdb 起始页 createuser
