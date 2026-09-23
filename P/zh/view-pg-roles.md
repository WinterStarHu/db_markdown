# 53.21. pg_roles

53.21. pg_roles
版本：
纠错本页面
搜索
目录导航
❮
❯
53.21. pg_roles #
视图pg_roles提供了关于数据库角色的信息。这只是一个公开可读的视图，
pg_authid，
它会将密码字段清空。
表 53.21. pg_roles 列
列类型
描述
rolname name
角色名
rolsuper bool
角色有超级用户权限
rolinherit bool
如果本角色是另一个角色的成员，本角色会自动继承该角色的权限
rolcreaterole bool
角色能创建更多角色
rolcreatedb bool
角色能创建数据库
rolcanlogin bool
角色能登录。即此角色可以作为初始会话授权标识符
rolreplication bool
角色是一个复制角色。复制角色可以启动复制连接并且创建和删除复制槽。
rolconnlimit int4
对于可以登录的角色，本列设置该角色可以同时发起的最大连接数。-1表示无限制。
rolpassword text
不是密码（总是读作********）
rolvaliduntil timestamptz
密码过期时间（仅用于密码认证）；如果没有过期则为null
rolbypassrls bool
角色是否可以绕过所有的行级安全策略，详见
第 5.9 节以获取更多信息。
rolconfig text[]
角色特定的运行时配置变量默认值
oid oid
(references pg_authid.oid)
角色的ID
上一页 上一级 下一页53.20. pg_replication_slots 起始页 53.22. pg_rules
