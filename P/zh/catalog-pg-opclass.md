# 52.33. pg_opclass

52.33. pg_opclass
版本：
纠错本页面
搜索
目录导航
❮
❯
52.33. pg_opclass #
目录pg_opclass定义索引访问方法的操作符类。每个操作符类定义了一种特定数据类型和一种特定索引访问方法的索引列的语义。一个操作符类实际上指定了一个特定的操作符族可以用于一个特定可索引列数据类型。该族中可用于索引列的操作符能够接受该列的数据类型作为它们的左输入。
操作符类详见第 36.16 节。
表 52.33. pg_opclass Columns
列类型
描述
oid oid
行标识符
opcmethod oid
(references pg_am.oid)
索引访问方法的操作符类
opcname name
操作符类的名称
opcnamespace oid
(references pg_namespace.oid)
操作符类所属的命名空间
opcowner oid
(references pg_authid.oid)
操作符类的拥有者
opcfamily oid
(references pg_opfamily.oid)
包含此操作符类的操作符族
opcintype oid
(references pg_type.oid)
操作符类索引的数据类型
opcdefault bool
如果此操作符类为opcintype的默认值则为真
opckeytype oid
(references pg_type.oid)
存储在索引中的数据类型，如果值为0表示与opcintype相同
一个操作符类的opcmethod必须匹配包含它的操作符族的opfmethod。
而且，对于任何给定的opcmethod和opcintype组合，只有不超过一个pg_opclass行的opcdefault值为真。
上一页 上一级 下一页52.32. pg_namespace 起始页 52.34. pg_operator
