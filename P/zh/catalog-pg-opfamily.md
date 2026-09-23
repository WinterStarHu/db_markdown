# 52.35. pg_opfamily

52.35. pg_opfamily
版本：
纠错本页面
搜索
目录导航
❮
❯
52.35. pg_opfamily #
目录pg_opfamily定义了操作符族。每一个操作符族是操作符和相关支持例程的集合，支持例程用于实现一个特定索引访问方法的语义。此外，按照访问方法指定的某种方式，一个族内的操作符都是“兼容的”。操作符族概念允许在索引中使用跨数据类型操作符，并可以使用访问方法语义的知识推导出。
操作符族在第 36.16 节中有详细描述。
表 52.35. pg_opfamily 列
列类型
描述
oid oid
行标识符
opfmethod oid
(references pg_am.oid)
索引访问方法操作符族适用
opfname name
该操作符族的名称
opfnamespace oid
(references pg_namespace.oid)
该操作符族的名字空间
opfowner oid
(references pg_authid.oid)
操作符族的所有者
定义操作符族的主要信息不在它的pg_opfamily行，而是在相关的pg_amop、pg_amproc和pg_opclass行中。
上一页 上一级 下一页52.34. pg_operator 起始页 52.36. pg_parameter_acl
