# 53.35. pg_user

53.35. pg_user
版本：
纠错本页面
搜索
目录导航
❮
❯
53.35. pg_user #
视图pg_user提供了关于数据库用户的信息。这只是一个公开可读的视图，
pg_shadow的一个简单版本，
该视图将密码字段清空。
表 53.35. pg_user 列
列类型
描述
usename name
用户名
usesysid oid
该用户的ID
usecreatedb bool
用户可以创建数据库
usesuper bool
用户是超级用户
userepl bool
用户可以启动流复制并将系统设置为备份模式或取消备份模式。
usebypassrls bool
用户可以绕过所有行级安全策略，详见第 5.9 节。
passwd text
不是密码（总是显示为********）
valuntil timestamptz
密码过期时间（仅用于密码认证）
useconfig text[]
运行时配置变量的会话默认值
上一页 上一级 下一页53.34. pg_timezone_names 起始页 53.36. pg_user_mappings
