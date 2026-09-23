# 52.15. pg_database

52.15. pg_database
版本：
纠错本页面
搜索
目录导航
❮
❯
52.15. pg_database #
目录pg_database存储有关可用数据库的信息。
数据库通过CREATE DATABASE命令创建。
更多关于一些参数的含义请查阅第 22 章。
和大部分系统目录不同，pg_database是在集簇的所有数据库之间共享的：在一个集簇中只有一份pg_database拷贝，而不是每个数据库一份。
表 52.15. pg_database 列
列类型
描述
oid oid
行标识符
datname name
数据库名称
datdba oid
(references pg_authid.oid)
数据库的拥有者，通常是创建它的用户
encoding int4
数据库的字符编码
(pg_encoding_to_char()可以将这个数字翻译为编码名称)
datlocprovider char
此数据库的区域设置提供者：b = 内置，c = libc，i = icu
datistemplate bool
如果为真，则此数据库可被任何具有CREATEDB特权的用户克隆；
如果为假，则只有超级用户或者该数据库的属主能够克隆它。
datallowconn bool
如果为假则没有人能连接到这个数据库。这可以用来保护template0数据库不被修改。
dathasloginevt bool
指示该数据库是否定义了登录事件触发器。此标志用于避免在每次后端启动时
对pg_event_trigger表进行额外查找。此标志由
PostgreSQL内部使用，不应手动更改或用于监控。
datconnlimit int4
设置可以连接到此数据库的最大并发连接数。-1表示没有限制，-2表示数据库无效。
datfrozenxid xid
在此之前的所有事务ID在数据库中已经被替换为一个永久的（“冻结的”) 事务ID。
这用于跟踪数据库是否需要被清理，以便防止事务ID回环或者允许pg_xact被收缩。
它是此数据库中所有表的pg_class.relfrozenxid值的最小值。
datminmxid xid
在此之前的所有多事务ID在数据库中已经被替换为一个事务ID。这用于跟踪数据库是否需要被
清理，以便防止多事务ID回环或者允许pg_multixact被收缩。它是此数据库中
所有表的pg_class.relminmxid值的最小值。
dattablespace oid
(references pg_tablespace.oid)
此数据库的默认表空间。
在此数据库中，所有pg_class.reltablespace为0的表都将被存储在这个表空间中；尤其是非共享系统目录都会在其中。
datcollate text
此数据库的 LC_COLLATE
datctype text
此数据库的 LC_CTYPE
datlocale text
此数据库的排序提供程序的区域设置名称。如果提供程序是libc，
datlocale为NULL；
取而代之的是使用datcollate和
datctype。
daticurules text
此数据库的 ICU 排序规则
datcollversion text
提供商特定的排序版本。在创建数据库时记录，然后在使用时检查，以检测排序定义的更改，这可能导致数据损坏。
datacl aclitem[]
访问权限；更多信息参见 第 5.8 节
上一页 上一级 下一页52.14. pg_conversion 起始页 52.16. pg_db_role_setting
