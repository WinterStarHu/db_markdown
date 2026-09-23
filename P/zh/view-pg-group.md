# 53.9. pg_group

53.9. pg_group
版本：
纠错本页面
搜索
目录导航
❮
❯
53.9. pg_group #
视图pg_group存在是为了向后兼容性：它模拟了在PostgreSQL版本8.1之前存在的目录。
它显示了所有被标记为非rolcanlogin的角色的名称和成员，这是对被用作组的角色集合的近似。
表 53.9. pg_group 列
列类型
描述
groname name
(references pg_authid.rolname)
组的名称
grosysid oid
(references pg_authid.oid)
组ID
grolist oid[]
(references pg_authid.oid)
包含此组中角色ID的数组
上一页 上一级 下一页53.8. pg_file_settings 起始页 53.10. pg_hba_file_rules
