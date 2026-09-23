# 52.17. pg_default_acl

52.17. pg_default_acl
版本：
纠错本页面
搜索
目录导航
❮
❯
52.17. pg_default_acl #
目录pg_default_acl存储要分配给新创建对象的初始权限。
表 52.17. pg_default_acl Columns
列类型
描述
oid oid
行标识符
defaclrole oid
(references pg_authid.oid)
与此项相关的角色的OID
defaclnamespace oid
(references pg_namespace.oid)
与此项相关的命名空间的OID，如果没有则为零
defaclobjtype char
该条目适用的对象类型：
r = 关系（表、视图），
S = 序列，
f = 函数，
T = 类型，
n = 模式，
L = 大对象
defaclacl aclitem[]
此类对象在创建时应具有的访问权限
一个pg_default_acl项展示了要分配给属于一个指定用户的对象的初始权限。
当前有两类项：defaclnamespace = 零的“全局”项和引用一个特殊模式的“per-schema”项。
如果一个全局项存在，则它重载该对象类型的普通默认权限。
一个每模式项如果存在，表示权限将被加入到全局或默认权限中。
注意，当另一个目录中的 ACL 条目为空时，它代表该对象
的硬编码默认权限，而不是 pg_default_acl
中当前可能存在的任何内容。pg_default_acl
仅在对象创建时被查询。
上一页 上一级 下一页52.16. pg_db_role_setting 起始页 52.18. pg_depend
