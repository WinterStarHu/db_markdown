# 53.18. pg_publication_tables

53.18. pg_publication_tables
版本：
纠错本页面
搜索
目录导航
❮
❯
53.18. pg_publication_tables #
视图 pg_publication_tables 提供了关于出版物与其包含的表信息之间映射的
相关信息。与底层目录
pg_publication_rel 不同，
此视图扩展了定义为
FOR ALL TABLES
和 FOR TABLES IN SCHEMA 的出版物，
因此对于此类出版物，每个符合条件的表都会有一行。
表 53.18. pg_publication_tables 列
列类型
描述
pubname name
(references pg_publication.pubname)
出版物名称
schemaname name
(references pg_namespace.nspname)
包含表的模式名称
tablename name
(references pg_class.relname)
表的名称
attnames name[]
(references pg_attribute.attname)
包含在出版物中的表列名。当用户没有为表指定列名列表时，此处包含表的所有列。
rowfilter text
表的发布资格条件的表达式
上一页 上一级 下一页53.17. pg_prepared_xacts 起始页 53.19. pg_replication_origin_status
