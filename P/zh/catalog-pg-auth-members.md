# 52.9. pg_auth_members

52.9. pg_auth_members
版本：
纠错本页面
搜索
目录导航
❮
❯
52.9. pg_auth_members #
目录pg_auth_members展示了角色之间的成员关系。允许任何非循环的关系集合。
由于用户标识符是集簇范围的，pg_auth_members在一个集簇的所有数据库之间共享：在一个集簇中只有一份pg_auth_members拷贝，而不是每个数据库一份。
表 52.9. pg_auth_members 列
列类型
描述
oid oid
行标识符
roleid oid
(references pg_authid.oid)
拥有成员的角色的ID
member oid
(references pg_authid.oid)
roleid的成员角色的ID
grantor oid
(references pg_authid.oid)
授权此成员关系的角色的ID
admin_option bool
如果member能把roleid的成员关系授予他人，则为真
inherit_option bool
如果成员会自动继承被授予角色的权限，则为真
set_option bool
如果成员可以
SET ROLE
为被授予的角色，则为真
上一页 上一级 下一页52.8. pg_authid 起始页 52.10. pg_cast
