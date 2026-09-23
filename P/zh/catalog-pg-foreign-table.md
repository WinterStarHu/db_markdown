# 52.25. pg_foreign_table

52.25. pg_foreign_table
版本：
纠错本页面
搜索
目录导航
❮
❯
52.25. pg_foreign_table #
目录pg_foreign_table包含关于外部表的辅助信息。
一个外部表和普通表一样，主要由一个pg_class项表示。
它的pg_foreign_table项包含仅与外部表相关的信息，而不是任何其他类型的关系。
表 52.25. pg_foreign_table 列
列类型
描述
ftrelid oid
(references pg_class.oid)
此外部表的pg_class项的OID
ftserver oid
(references pg_foreign_server.oid)
此外部表的外部服务器的OID
ftoptions text[]
外部表选项，以“keyword=value”字符串形式
上一页 上一级 下一页52.24. pg_foreign_server 起始页 52.26. pg_index
