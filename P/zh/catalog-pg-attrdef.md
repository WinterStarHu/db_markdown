# 52.6. pg_attrdef

52.6. pg_attrdef
版本：
纠错本页面
搜索
目录导航
❮
❯
52.6. pg_attrdef #
系统目录 pg_attrdef 存储列默认表达式和生成表达式。
列的主要信息存储在 pg_attribute 中。
只有显式设置了默认表达式或生成表达式的列才会在此有条目。
表 52.6. pg_attrdef Columns
列类型
描述
oid oid
行标识符
adrelid oid
(references pg_class.oid)
该列所属的表
adnum int2
(references pg_attribute.attnum)
列的编号
adbin pg_node_tree
列默认值或生成表达式，以 nodeToString()
表示。使用 pg_get_expr(adbin, adrelid)
可将其转换为 SQL 表达式。
上一页 上一级 下一页52.5. pg_amproc 起始页 52.7. pg_attribute
