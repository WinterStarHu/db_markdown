# 53.23. pg_seclabels

53.23. pg_seclabels
版本：
纠错本页面
搜索
目录导航
❮
❯
53.23. pg_seclabels #
视图pg_seclabels提供有关安全标签的信息。它是
pg_seclabel目录的更易查询版本。
表 53.23. pg_seclabels 列
列类型
描述
objoid oid
(引用任何OID列)
该安全标签依附的对象的OID
classoid oid
(引用pg_class.oid)
该对象出现在的系统目录的OID
objsubid int4
对于一个在表列上的安全标签，这将是列号（objoid和classoid指表本身）。对于所有其他对象类型，本列为零。
objtype text
此标签应用的对象类型，以文本形式。
objnamespace oid
(引用pg_namespace.oid)
如果适用，为此对象的命名空间的OID；否则为空。
objname text
此标签应用的对象名，以文本形式。
provider text
(引用pg_seclabel.provider)
与此标签相关的标签提供者。
label text
(references pg_seclabel.label)
应用于此对象的安全标签。
上一页 上一级 下一页53.22. pg_rules 起始页 53.24. pg_sequences
