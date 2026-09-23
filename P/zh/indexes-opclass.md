# 11.10. 操作符类和操作符族

11.10. 操作符类和操作符族
版本：
纠错本页面
搜索
目录导航
❮
❯
11.10. 操作符类和操作符族 #
一个索引定义可以为索引中的每一列都指定一个操作符类。
CREATE INDEX name ON table (column opclass [ ( opclass_options ) ] [sort options] [, ...]);
操作符类标识该列上索引要使用的操作符。例如，一个int4类型上的B树索引会使用int4_ops类；这个操作符类包括用于int4类型值的比较函数。实际上列的数据类型的默认操作符类通常就足够了。存在多个操作符类的原因是，对于某些数据类型可能会有多于一种的有意义的索引行为。例如，我们可能想要对一种复数数据类型按照绝对值排序或者按照实数部分排序。我们可以通过为该数据类型定义两个操作符类来实现，并且在创建一个索引时选择合适的类。操作符类会决定基本的排序顺序（可以通过增加排序选项COLLATE、
ASC/DESC和/或
NULLS FIRST/NULLS LAST来修改）。
除了默认的操作符类，还有一些内建的操作符类：
操作符类text_pattern_ops、varchar_pattern_ops和
bpchar_pattern_ops分别支持类型text、varchar和
char上的B树索引。它们与默认操作符类的区别是值的比较是严格按照字符进行而不是根据区域相关的排序规则。这使得这些操作符类适合于当一个数据库没有使用标准“C”区域时被使用在涉及模式匹配表达式（LIKE或POSIX正则表达式）的查询中。一个例子是，你可以这样索引一个varchar列：
CREATE INDEX test_index ON test_table (col varchar_pattern_ops);
注意如果你希望涉及到<、<=、>或>=比较的查询使用一个索引，你也应该创建一个使用默认操作符类的索引。这些查询不能使用xxx_pattern_ops操作符类（但是普通的等值比较可以使用这些操作符类）。可以在同一个列上创建多个使用不同操作符类的索引。如果你正在使用C区域，你并不需要xxx_pattern_ops操作符类，因为在C区域中的模式匹配查询可以用带有默认操作符类的索引。
下面的查询展示了所有已定义的操作符类：
SELECT am.amname AS index_method,
opc.opcname AS opclass_name,
opc.opcintype::regtype AS indexed_type,
opc.opcdefault AS is_default
FROM pg_am am, pg_opclass opc
WHERE opc.opcmethod = am.oid
ORDER BY index_method, opclass_name;
一个操作符类实际上只是一个更大的被称为操作符族的结构的一个子集。在多种数据类型具有相似行为的情况下，常常会定义跨数据类型的操作符并且允许索引使用它们。为了实现该目的，这些类型的操作符类必须被分组到同一个操作符族中。跨类型的操作符是该族的成员，但是并不与族内任意一个单独的类相关联。
前一个查询的扩展版本展示了每个操作符类所属的操作符族：
SELECT am.amname AS index_method,
opc.opcname AS opclass_name,
opf.opfname AS opfamily_name,
opc.opcintype::regtype AS indexed_type,
opc.opcdefault AS is_default
FROM pg_am am, pg_opclass opc, pg_opfamily opf
WHERE opc.opcmethod = am.oid AND
opc.opcfamily = opf.oid
ORDER BY index_method, opclass_name;
这个查询展示所有已定义的操作符族和每一个族中包含的所有操作符：
SELECT am.amname AS index_method,
opf.opfname AS opfamily_name,
amop.amopopr::regoperator AS opfamily_operator
FROM pg_am am, pg_opfamily opf, pg_amop amop
WHERE opf.opfmethod = am.oid AND
amop.amopfamily = opf.oid
ORDER BY index_method, opfamily_name, opfamily_operator;
提示
psql has
commands \dAc, \dAf,
and \dAo, which provide slightly more sophisticated
versions of these queries.
上一页 上一级 下一页11.9. 只用索引的扫描和覆盖索引 起始页 11.11. 索引和排序规则
