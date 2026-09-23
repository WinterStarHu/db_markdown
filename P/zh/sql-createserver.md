# CREATE SERVER

CREATE SERVER
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE SERVERCREATE SERVER — 定义一个新的外部服务器大纲
CREATE SERVER [ IF NOT EXISTS ] server_name [ TYPE 'server_type' ] [ VERSION 'server_version' ]
FOREIGN DATA WRAPPER fdw_name
[ OPTIONS ( option 'value' [, ... ] ) ]
描述
CREATE SERVER 定义一个新的外部服务器。定义该服务器的用户会成为拥有者。
外部服务器通常包装了外部数据包装器用来访问一个外部数据源所需的连接信息。额外的用户相关的连接信息可以通过用户映射的方式来指定。
服务器名称在数据库中必须唯一。
创建服务器要求所使用的外部数据包装器上的 USAGE 特权。
参数IF NOT EXISTS
如果已经存在同名的服务器，不要抛出错误。在这种情况下发出一个通知。
请注意，不能保证现有服务器与要创建的服务器类似。
server_name
要创建的外部服务器的名称。
server_type
可选的服务器类型，可能对外部数据包装器有用。
server_version
可选的服务器版本，可能对外部数据包装器有用。
fdw_name
管理该服务器的外部数据包装器的名称。
OPTIONS ( option 'value' [, ... ] )
这个子句为服务器指定选项。这些选项通常定义该服务器的连接细节，
但是实际的名称和值取决于该服务器的外部数据包装器。
备注
在使用dblink模块时，一个外部服务器的名称可以被
用作dblink_connect函数的一个参数来指示
连接参数。以这种方式使用外部服务器，需要在其上具有
USAGE特权。
如果外部服务器支持排序下推，那么它必须与本地服务器具有相同的排序顺序。
示例
创建使用外部数据包装器postgres_fdw
的服务器myserver：
CREATE SERVER myserver FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'foo', dbname 'foodb', port '5432');
详见postgres_fdw。
兼容性
CREATE SERVER符合 ISO/IEC 9075-9 (SQL/MED)。
另见ALTER SERVER, DROP SERVER, CREATE FOREIGN DATA WRAPPER, CREATE FOREIGN TABLE, CREATE USER MAPPING上一页 上一级 下一页CREATE SEQUENCE 起始页 CREATE STATISTICS
