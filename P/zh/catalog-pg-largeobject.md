# 52.30. pg_largeobject

52.30. pg_largeobject
版本：
纠错本页面
搜索
目录导航
❮
❯
52.30. pg_largeobject #
目录pg_largeobject保存构成“大对象”的数据。一个大对象在被创建时会被分配一个OID。每个大对象被分解成段或“页”，以便小到可以被方便地作为行存储在pg_largeobject中。每页中的数据量被定义为LOBLKSIZE（目前是BLCKSZ/4，或是2 kB）。
在PostgreSQL 9.0之前，大对象没有相关的权限结构。作为结果，pg_largeobject是公共可读的并且可以用来获得系统中所有大对象的OID（和内容）。但现在不是这样了，可使用pg_largeobject_metadata来获得大对象OID的列表。
表 52.30. pg_largeobject 列
列类型
描述
loid oid
(references pg_largeobject_metadata.oid)
包含此页的大对象的标识符
pageno int4
此页在它所属大对象中的页号（从零开始计数）
data bytea
实际存储在大对象中的数据。它从不会超过LOBLKSIZE字节，也可能更少。
pg_largeobject的每一行保存一个大对象的一个页的数据，从对象内部的字节偏移量（pageno * LOBLKSIZE）开始。现在的实现允许稀疏存储：页面可能丢失，并且可能比LOBLKSIZE字节短，即便不是最后一页。一个大对象中丢失的区域会被读出为0。
上一页 上一级 下一页52.29. pg_language 起始页 52.31. pg_largeobject_metadata
