# 52.42. pg_publication_rel

52.42. pg_publication_rel
版本：
纠错本页面
搜索
目录导航
❮
❯
52.42. pg_publication_rel #
目录pg_publication_rel包含数据库中关系和发布之间的映射。这是一种多对多映射。有关这些信息的更友好的视图，请参考第 53.18 节。
表 52.42. pg_publication_rel 列
列类型
描述
oid oid
行标识符
prpubid oid
(references pg_publication.oid)
对发布的引用
prrelid oid
(references pg_class.oid)
对关系的引用
prqual pg_node_tree
关系的发布限定条件的表达式树（采用nodeToString()表示法）。如果没有发布限定条件，则为空。
prattrs int2vector
(references pg_attribute.attnum)
这是一个值数组，指示哪些表列是发布的。例如，值为1 3表示第一和第三列被发布。空值表示所有列都被发布。
上一页 上一级 下一页52.41. pg_publication_namespace 起始页 52.43. pg_range
