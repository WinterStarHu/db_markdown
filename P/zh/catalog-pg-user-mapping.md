# 52.65. pg_user_mapping

52.65. pg_user_mapping
版本：
纠错本页面
搜索
目录导航
❮
❯
52.65. pg_user_mapping #
目录pg_user_mapping存储从本地用户到远程的映射。对这个目录的访问对普通用户有限制，可以使用视图pg_user_mappings替代。
表 52.66. pg_user_mapping 列
列类型
描述
oid oid
行标识符
umuser oid
(引用 pg_authid.oid)
将要被映射的本地角色的OID，如果用户映射是公共的则为零
umserver oid
(引用 pg_foreign_server.oid)
包含此映射的外部服务器的OID
umoptions text[]
用户映射特定的选项，以“keyword=value”字符串形式
上一页 上一级 下一页52.64. pg_type 起始页 第 53 章 系统视图
