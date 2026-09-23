# 52.4. pg_amop

52.4. pg_amop
版本：
纠错本页面
搜索
目录导航
❮
❯
52.4. pg_amop #
目录pg_amop存储关于与访问方法操作符族相关的操作符信息。对于一个操作符族中的每一个成员即操作符都在这个目录中有一行。一个成员可以是一个搜索操作符或者一个排序操作符。一个操作符可以出现在多个族中，但在同一个族中既不能出现在多个搜索位置也不能出现在多个排序位置（虽然不太可能出现，但允许一个操作符同时用于搜索和排序目的）。
表 52.4. pg_amop 列
列类型
描述
oid oid
行标识符
amopfamily oid
(references pg_opfamily.oid)
该项所对应的操作符系列
amoplefttype oid
(references pg_type.oid)
操作符的左侧输入数据类型
amoprighttype oid
(references pg_type.oid)
操作符的右侧输入数据类型
amopstrategy int2
操作符策略编号
amoppurpose char
操作符目的，s表示搜索，o表示排序
amopopr oid
(references pg_operator.oid)
操作符的OID
amopmethod oid
(references pg_am.oid)
此操作符系列对应的索引访问方法
amopsortfamily oid
(references pg_opfamily.oid)
如果是一个排序操作符，该项会根据这个B树操作符系列进行排序；如果是一个搜索操作符则为0
一个“搜索”操作符项意味着该操作符族的一个索引可以被搜索来查找所有满足如下条件的行：
WHERE
indexed_column
operator
constant。
显然，这样的一个操作符必须返回boolean，且它的左手输入类型必须匹配索引列的数据类型。
一个“排序”操作符项意味着该操作符族的一个索引可以被扫描来返回以如下顺序排列的行：
ORDER BY
indexed_column
operator
constant。
这样一个操作符能够返回任何可排序数据类型，尽管它的左手输入类型必须匹配索引列的数据类型。
ORDER BY的准确语义由amopsortfamily列指定，它必须引用一个适合于操作符结果类型的B树操作符族。
注意
目前，一个排序操作符的排序顺序被假设为其引用的操作符族的默认值，即ASC NULLS LAST。未来可能会通过增加额外的列来显式地指定排序选项。
一个项的amopmethod必须和它所包含的操作符族的opfmethod相匹配（这里包括amopmethod是一个为了性能原因而故意对目录结构做的反规范化）。
此外，amoplefttype和amoprighttype也必须匹配被引用的pg_operator项的oprleft和oprright域。
上一页 上一级 下一页52.3. pg_am 起始页 52.5. pg_amproc
