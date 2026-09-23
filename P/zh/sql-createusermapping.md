# CREATE USER MAPPING

CREATE USER MAPPING
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE USER MAPPINGCREATE USER MAPPING — 定义一个用户到外部服务器的新映射大纲
CREATE USER MAPPING [ IF NOT EXISTS ] FOR { user_name | USER | CURRENT_ROLE | CURRENT_USER | PUBLIC }
SERVER server_name
[ OPTIONS ( option 'value' [ , ... ] ) ]
描述
CREATE USER MAPPING 定义一个用户
到外部服务器的映射。一个用户映射通常会包含连接信息，外部数据包装器
会使用这些连接信息和外部服务器中包含的信息一起来访问外部数据源。
外部服务器的拥有者可以为该服务器的任何用户创建用户映射。此外，
如果用户被授予了服务器上的 USAGE 特权，该用户可以
为自己的用户名创建用户映射。
参数IF NOT EXISTS
如果给定用户到给定外部服务器的映射已经存在，则不要抛出错误。
在这种情况下会发出通知。请注意，不能保证现有的用户映射与要创建的映射完全相同。
user_name
要映射到外部服务器的一个现有用户的名称。
CURRENT_ROLE、CURRENT_USER和USER匹配当前用户的名称。
当PUBLIC被指定时，一个所谓的公共映射会被创建，当没有
特定用户的映射可用时将会使用它。
server_name
将为其创建用户映射的现有服务器的名称。
OPTIONS ( option 'value' [, ... ] )
这个子句指定用户映射的选项。这些选项通常定义该映射实际的用户名和
密码。选项名必须唯一。允许的选项名和值与该服务器的外部数据包装器
有关。
示例
为用户bob、服务器foo创建一个用户映射：
CREATE USER MAPPING FOR bob SERVER foo OPTIONS (user 'bob', password 'secret');
兼容性
CREATE USER MAPPING符合 ISO/IEC 9075-9 (SQL/MED)。
其他参考ALTER USER MAPPING, DROP USER MAPPING, CREATE FOREIGN DATA WRAPPER, CREATE SERVER上一页 上一级 下一页CREATE USER 起始页 CREATE VIEW
