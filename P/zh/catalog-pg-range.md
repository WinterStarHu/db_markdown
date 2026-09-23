# 52.43. pg_range

52.43. pg_range
版本：
纠错本页面
搜索
目录导航
❮
❯
52.43. pg_range #
目录pg_range存储关于范围类型的信息。这是类型在pg_type中的项的补充。
表 52.43. pg_range 列
列类型
描述
rngtypid oid
(references pg_type.oid)
范围类型的OID
rngsubtype oid
(references pg_type.oid)
该范围类型的元素类型（子类型）的OID
rngmultitypid oid
(references pg_type.oid)
该范围类型的多范围类型的OID
rngcollation oid
(references pg_collation.oid)
用于范围比较的排序规则的OID，如果没有则为零
rngsubopc oid
(references pg_opclass.oid)
用于范围比较的子类型的操作符类的OID
rngcanonical regproc
(references pg_proc.oid)
将一个范围值转换为规范形式的函数的OID，如果没有则为零
rngsubdiff regproc
(references pg_proc.oid)
返回两个元素值之间差异的函数的OID，结果为double precision，如果没有则为零
rngsubopc （加上rngcollation，如果元素类型是可排序的）决定了被该范围类型所使用的排序顺序。rngcanonical用于离散类型的元素类型。rngsubdiff是可选的，但是提供它可以提高范围类型上的GiST索引性能。
上一页 上一级 下一页52.42. pg_publication_rel 起始页 52.44. pg_replication_origin
