# ALTER SERVER

ALTER SERVER
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER SERVERALTER SERVER — 更改外部服务器的定义大纲
ALTER SERVER name [ VERSION 'new_version' ]
[ OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ] ) ]
ALTER SERVER name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER SERVER name RENAME TO new_name
描述
ALTER SERVER更改外部服务器的定义。第一种形式更改该服务器的版本字符串或该服务器的一般选项（至少要求一个子句）。第二种形式更改该服务器的拥有者。
要更改服务器，您必须是该服务器的所有者。此外，要更改所有者，您必须能够SET ROLE为新的拥有角色，并且您必须拥有服务器的外部数据包装器的USAGE权限。（请注意，超级用户会自动满足所有这些条件。）
参数name
现有服务器的名称。
new_version
新服务器版本。
OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ] )
更改服务器的选项。ADD、SET和
DROP指定要执行的操作。如果没有显式地指定操作，
将会假定为ADD。选项名称必须唯一，名称和值也会
使用服务器的外部数据包装器库进行验证。
new_owner
外部服务器的新拥有者的用户名。
new_name
外部服务器的新名称。
示例
修改服务器foo，增加连接选项：
ALTER SERVER foo OPTIONS (host 'foo', dbname 'foodb');
修改服务器foo，更改版本，
更改host选项：
ALTER SERVER foo VERSION '8.4' OPTIONS (SET host 'baz');
兼容性
ALTER SERVER符合 ISO/IEC 9075-9 (SQL/MED)。
OWNER TO和RENAME形式是
PostgreSQL 扩展。
另请参阅CREATE SERVER, DROP SERVER上一页 上一级 下一页ALTER SEQUENCE 起始页 ALTER STATISTICS
