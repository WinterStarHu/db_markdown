# 52.12. pg_collation

52.12. pg_collation
版本：
纠错本页面
搜索
目录导航
❮
❯
52.12. pg_collation #
目录pg_collation描述了可用的排序规则，其本质是从一个SQL名字到操作系统区域设置分类的映射。
更多信息参见第 23.2 节。
表 52.12. pg_collation 列
列类型
描述
oid oid
行标识符
collname name
排序规则名称（在每个命名空间和编码中唯一）
collnamespace oid
(references pg_namespace.oid)
包含该排序规则的命名空间的OID
collowner oid
(references pg_authid.oid)
排序规则的拥有者
collprovider char
排序规则的提供者：d = 数据库默认，
b = 内置，c = libc，
i = icu
collisdeterministic bool
排序规则是确定性的吗？
collencoding int4
该排序规则可应用的编码，或以-1表示它可用于任何编码
collcollate text
LC_COLLATE 用于此排序对象。如果提供者不是
libc，则 collcollate 为
NULL，改用 colllocale。
collctype text
LC_CTYPE 是此排序对象的值。如果提供者不是
libc，则 collctype 为
NULL，改用 colllocale。
colllocale text
此排序对象的排序提供程序区域设置名称。如果提供程序是libc，
colllocale为NULL；
collcollate和
collctype将被使用。
collicurules text
此排序对象的ICU排序规则
collversion text
排序规则的提供者相关的版本。这是在排序规则创建时记录下来的，并且在使用排序规则时会被检查以检测可能导致数据损坏的排序规则定义的改变。
注意在这个目录中的唯一键是（collname、
collencoding、 collnamespace）， 不仅仅是（collname，collnamespace）。
所有collencoding不等于当前数据库编码或-1的排序规则通常都会被PostgreSQL忽略，且禁止创建和collencoding = -1的项重名的项。因此使用一个合格的SQL名字（schema.name）来标识一个排序规则是足够的，即使这根据目录定义是不唯一的。以这种方式定义这个目录的原因是initdb会在集簇初始化时使用系统上所有可用的locale填充这个目录，所以它必须能够为所有可能在集簇中使用的编码保持项。
在template0数据库中，创建与数据库编码不匹配的排序规则是有用的，因为它们可以匹配后面从template0克隆的数据库的编码。这在目前必须手动完成。
上一页 上一级 下一页52.11. pg_class 起始页 52.13. pg_constraint
