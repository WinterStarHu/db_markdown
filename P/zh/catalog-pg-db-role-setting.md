# 52.16. pg_db_role_setting

52.16. pg_db_role_setting
版本：
纠错本页面
搜索
目录导航
❮
❯
52.16. pg_db_role_setting #
目录 pg_db_role_setting 记录为每一个角色和数据库组合设置的运行时配置变量的默认值。
和大部分系统目录不同，pg_db_role_setting是在集簇的所有数据库之间共享的：在一个集簇中只有一份pg_db_role_setting拷贝，而不是每个数据库一份。
表 52.16. pg_db_role_setting 列
列类型
描述
setdatabase oid
(references pg_database.oid)
此设置可用的数据库OID，如果不与具体数据库相关则为0
setrole oid
(references pg_authid.oid)
此设置可用的角色OID，如果不与具体角色相关则为0
setconfig text[]
运行时配置变量的默认值
上一页 上一级 下一页52.15. pg_database 起始页 52.17. pg_default_acl
