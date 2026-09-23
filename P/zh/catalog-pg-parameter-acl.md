# 52.36. pg_parameter_acl

52.36. pg_parameter_acl
版本：
纠错本页面
搜索
目录导航
❮
❯
52.36. pg_parameter_acl #
目录pg_parameter_acl记录已授予一个或多个角色权限的配置参数。
不会为具有默认权限的参数创建条目。
与大多数系统目录不同，pg_parameter_acl在集群的所有数据库中共享：
每个集群只有一个pg_parameter_acl副本，而不是每个数据库一个。
表 52.36. pg_parameter_acl 列
列类型
描述
oid oid
行标识符
parname text
为其授予权限的配置参数的名称
paracl aclitem[]
访问权限；详细信息请参见第 5.8 节
上一页 上一级 下一页52.35. pg_opfamily 起始页 52.37. pg_partitioned_table
