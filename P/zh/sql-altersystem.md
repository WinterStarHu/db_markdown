# ALTER SYSTEM

ALTER SYSTEM
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER SYSTEMALTER SYSTEM — 更改服务器配置参数大纲
ALTER SYSTEM SET configuration_parameter { TO | = } { value [, ...] | DEFAULT }
ALTER SYSTEM RESET configuration_parameter
ALTER SYSTEM RESET ALL
描述
ALTER SYSTEM被用来在整个数据库集簇范围内更改
服务器配置参数。它比传统的手动编辑postgresql.conf
文件的方法更方便。ALTER SYSTEM会把给出的参数
设置写入到postgresql.auto.conf文件中，该文件会随着
postgresql.conf一起被读入。把一个参数设置为
DEFAULT，或者使用RESET变体，可以
把该配置项从postgresql.auto.conf文件中移除。使用
RESET ALL可以移除所有这类配置项。
用ALTER SYSTEM设置的值将在下一次重载服务器
配置后生效，那些只能在服务器启动时更改的参数则会在下一次服务器重启后生效。
重载服务器配置可以通过以下做法实现：调用 SQL 函数pg_reload_conf()，
运行pg_ctl reload或者向主服务器进程发送一个SIGHUP信号。
只有超级用户和被授予ALTER SYSTEM权限的用户才能使用ALTER SYSTEM更改它。
另外，由于这个命令直接作用于文件系统且无法回滚，所以不允许在事务块或函数内部使用。
参数configuration_parameter
可设置配置参数的名称。可用的参数在第 19 章中有文档记录。
value
参数的新值。值可以指定为字符串常量、标识符、数字或逗号分隔的这些列表，
适用于特定参数。既不是数字也不是有效标识符的值必须用引号括起来。
DEFAULT可以写入以指定从postgresql.auto.conf中删除参数及其值。
对于一些接受列表的参数，引用值将产生双引号输出，以保留空格和逗号；对于其他参数，
在单引号字符串内部必须使用双引号才能获得这种效果。
备注
该命令不能用于设置 data_directory、
allow_alter_system，
也不能用于设置不允许出现在 postgresql.conf 中的参数
（例如，预设选项）。
其他设置参数的方法见第 19.1 节。
ALTER SYSTEM可以通过将 allow_alter_system 设置为
off来禁用，但这不是一种安全机制（如本参数文档中详细说明）。
示例
设置wal_level：
ALTER SYSTEM SET wal_level = replica;
撤销以上的设置，恢复postgresql.conf中有效的设置：
ALTER SYSTEM RESET wal_level;
兼容性
ALTER SYSTEM语句是一种
PostgreSQL扩展。
另见SET, SHOW上一页 上一级 下一页ALTER SUBSCRIPTION 起始页 ALTER TABLE
