# 52.26. pg_index

52.26. pg_index
版本：
纠错本页面
搜索
目录导航
❮
❯
52.26. pg_index #
目录pg_index包含关于索引的部分信息。
其他信息大部分在pg_class中。
表 52.26. pg_index 列
列类型
描述
indexrelid oid
(references pg_class.oid)
此索引的pg_class项的OID
indrelid oid
(references pg_class.oid)
此索引所对应的基表的pg_class项的OID
indnatts int2
索引中的总列数（与pg_class.relnatts重复）；这个数目包括键和被包括的属性
indnkeyatts int2
索引中键列的数量，不计入任何的内含列，它们只是被存储但不参与索引的语义
indisunique bool
如果为真，这是唯一索引
indnullsnotdistinct bool
这个值仅用于唯一索引。如果为 false，则此唯一索引将认为 null 值是不同的（因此索引可以包含列中的多个 null 值，这是默认的 PostgreSQL 行为）。
如果为 true，则将认为 null 值相等（因此索引只能包含列中的一个 null 值）。
indisprimary bool
如果为 true，表示索引为表的主键（如果此列为 true，indisunique 也总是为 true）
indisexclusion bool
如果为 true，此索引支持一个排他约束
indimmediate bool
如果为 true，唯一性检查在插入时立即被执行（如果 indisunique 为 false，此列无关）
indisclustered bool
如果为 true，表示表最后以此索引进行了集簇
indisvalid bool
如果为 true，此索引当前可以用于查询。
为 false 表示此索引可能不完整：它肯定还在被 INSERT/UPDATE 操作所修改，但它不能安全地被用于查询。
如果索引是唯一索引，唯一性属性也不能被保证。
indcheckxmin bool
如果为 true，查询必须不使用该索引，直到这个 pg_index 行的 xmin
低于其 TransactionXmin 事件视界，因为表可能
包含损坏的 HOT 链（这其中包含了他们可以看到的不兼容行）
indisready bool
如果为 true，表示此索引当前可以用于插入。
为 false 表示索引必须被 INSERT/UPDATE 操作忽略。
indislive bool
如果为假，索引正处于被删除过程中，并且必须被所有目的忽略（包括HOT安全的决策）
indisreplident bool
如果为真，这个索引被选择为使用ALTER TABLE ... REPLICA IDENTITY USING INDEX ...的“replica identity”
indkey int2vector
(references pg_attribute.attnum)
这是一个包含indnatts值的数组，用于指示该索引为哪些表列建立索引。
例如，1 3的值表示第一个和第三个表列组成索引条目。
关键列位于非关键（包含）列之前。此数组中的零表示相应的索引属性是表列上的表达式，而不是简单的列引用。
indcollation oidvector
(references pg_collation.oid)
对于索引键（indnkeyatts值）中的每一列，这包含要用于该索引的排序规则的OID，如果该列不是一种可排序数据类型则为零。
indclass oidvector
(references pg_opclass.oid)
对于索引键中的每一列（indnkeyatts值），这里包含了要使用的操作符类的OID。详见pg_opclass。
indoption int2vector
这是一个indnkeyatts值的数组，用于存储每列的标志位。位的意义由索引的访问方法定义。
indexprs pg_node_tree
非简单列引用索引属性的表达式树（以nodeToString()形式）。对于indkey中每一个为0的项，这个列表中都有一个元素。如果所有的索引属性都是简单引用，此列为空。
indpred pg_node_tree
部分索引谓词的表达式树（以nodeToString()形式）。如果不是部分索引，此列为空。
上一页 上一级 下一页52.25. pg_foreign_table 起始页 52.27. pg_inherits
