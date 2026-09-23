# 52.34. pg_operator

52.34. pg_operator
版本：
纠错本页面
搜索
目录导航
❮
❯
52.34. pg_operator #
目录pg_operator存储关于操作符的信息。详见CREATE OPERATOR和第 36.14 节。
表 52.34. pg_operator 列
列类型
描述
oid oid
行标识符
oprname name
操作符的名称
oprnamespace oid
(references pg_namespace.oid)
包含此操作符的名字空间的OID
oprowner oid
(references pg_authid.oid)
操作符的拥有者
oprkind char
b = 中缀操作符 (“两者”),
或l = 前缀操作符 (“左”)
oprcanmerge bool
该操作符支持归并连接
oprcanhash bool
该操作符支持哈希连接
oprleft oid
(references pg_type.oid)
左操作数类型（对于前缀操作符为零）
oprright oid
(references pg_type.oid)
右操作数类型
oprresult oid
(references pg_type.oid)
结果类型（对于尚未定义的“shell”操作符为零）
oprcom oid
(references pg_operator.oid)
该操作符的交换子（如没有则为零）
oprnegate oid
(references pg_operator.oid)
该操作符的否定（如没有则为零）
oprcode regproc
(references pg_proc.oid)
实现该操作符的函数（对于尚未定义的“shell”操作符为零）
oprrest regproc
(references pg_proc.oid)
该操作符的限制选择性估算函数（如果没有则为零）
oprjoin regproc
(references pg_proc.oid)
该操作符的连接选择性估算函数（如果没有则为零）
上一页 上一级 下一页52.33. pg_opclass 起始页 52.35. pg_opfamily
