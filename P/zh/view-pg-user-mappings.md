# 53.36. pg_user_mappings

53.36. pg_user_mappings
版本：
纠错本页面
搜索
目录导航
❮
❯
53.36. pg_user_mappings #
视图pg_user_mappings提供了关于用户映射的信息。这本质上是一个公开可读的视图，
pg_user_mapping，
如果用户没有权限使用它，则省略选项字段。
表 53.36. pg_user_mappings 列
列类型
描述
umid oid
(references pg_user_mapping.oid)
用户映射的OID
srvid oid
(references pg_foreign_server.oid)
包含该映射的外部服务器的OID
srvname name
(references pg_foreign_server.srvname)
外部服务器的名称
umuser oid
(references pg_authid.oid)
将要被映射的本地角色的OID，如果用户映射是公共的则为零
usename name
要映射的本地用户名
umoptions text[]
用户映射特定的选项，以“keyword=value”字符串形式
为了保护存储为用户映射选项的密码信息，umoptions列将读取为null，除非以下情况之一适用：
当前用户是被映射的用户，并拥有服务器或在其上拥有USAGE权限
当前用户是服务器所有者，映射是为PUBLIC而进行的
当前用户是超级用户
上一页 上一级 下一页53.35. pg_user 起始页 53.37. pg_views
