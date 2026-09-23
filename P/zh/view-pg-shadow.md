# 53.26. pg_shadow

53.26. pg_shadow
版本：
纠错本页面
搜索
目录导航
❮
❯
53.26. pg_shadow #
视图pg_shadow存在是为了向后兼容：它模拟了在PostgreSQL 8.1版本之前存在的目录。
它显示了在pg_authid中标记为rolcanlogin的所有角色的属性。
这个名称源于这个表格不应该被公众阅读，因为它包含密码。
pg_user
是一个公开可读的视图，显示了pg_shadow，并且将密码字段清空。
表 53.26. pg_shadow 列
列类型
描述
usename name
(references pg_authid.rolname)
用户名
usesysid oid
(references pg_authid.oid)
用户的ID
usecreatedb bool
用户可以创建数据库
usesuper bool
用户是一个超级用户
userepl bool
用户可以启动流复制并将系统设置为备份模式或取消备份模式。
usebypassrls bool
用户可以绕过所有的行级安全策略，详见
第 5.9 节 以获取更多信息。
passwd text
加密密码；如果没有则为 null。有关加密密码存储的详细信息，请参见
pg_authid
。
valuntil timestamptz
密码过期时间（仅用于密码认证）
useconfig text[]
运行时配置变量的会话默认值
上一页 上一级 下一页53.25. pg_settings 起始页 53.27. pg_shmem_allocations
