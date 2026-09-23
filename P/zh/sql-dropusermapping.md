# DROP USER MAPPING

DROP USER MAPPING
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP USER MAPPINGDROP USER MAPPING — 移除一个用户映射用于外部服务器大纲
DROP USER MAPPING [ IF EXISTS ] FOR { user_name | USER | CURRENT_ROLE | CURRENT_USER | PUBLIC } SERVER server_name
说明
DROP USER MAPPING从外部服务器移除一个已有的用户映射。
一个外部服务器的拥有者可以为该服务器的任何用户删除用户映射。也可以，如果USAGE特权已授予该用户，用户可以删除用于他们自己用户名的用户映射。
参数IF EXISTS
如果用户映射不存在则不要抛出错误，这种情况下会发出一个提示。
user_name
该映射的用户名。CURRENT_ROLE, CURRENT_USER和USER匹配当前用户的名称。PUBLIC用于匹配系统中所有现存和未来的用户名。
server_name
用户映射的服务器名称。
示例
删除一个用于服务器foo的用户映射bob（如果它存在）：
DROP USER MAPPING IF EXISTS FOR bob SERVER foo;
兼容性
DROP USER MAPPING符合 ISO/IEC 9075-9 (SQL/MED)。IF EXISTS子句是一个PostgreSQL扩展。
另见CREATE USER MAPPING, ALTER USER MAPPING上一页 上一级 下一页DROP USER 起始页 DROP VIEW
