# 52.5. pg_amproc

52.5. pg_amproc
版本：
纠错本页面
搜索
目录导航
❮
❯
52.5. pg_amproc #
目录pg_amproc存储关于访问方法操作符族相关的支持函数。属于一个操作符族的每一个支持函数在这个目录中都有一行。
表 52.5. pg_amproc 列
列类型
描述
oid oid
行标识符
amprocfamily oid
(references pg_opfamily.oid)
此项对应的操作符系列
amproclefttype oid
(references pg_type.oid)
相关操作符的左侧输入数据类型
amprocrighttype oid
(references pg_type.oid)
相关操作符的右侧输入数据类型
amprocnum int2
支持函数编号
amproc regproc
(references pg_proc.oid)
函数的OID
amproclefttype和amprocrighttype字段的通常解释是它们标识了一个特定支持函数所支持的操作符的左右输入类型。对于某些访问方法，它们与支持函数本身的输入数据类型相匹配，而对于其他方法则不匹配。对于一个索引，有一个“默认”支持函数的概念，这些支持函数的amproclefttype和amprocrighttype都等于索引操作符类的opcintype。
上一页 上一级 下一页52.4. pg_amop 起始页 52.6. pg_attrdef
