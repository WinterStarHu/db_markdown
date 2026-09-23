# dblink_build_sql_insert

dblink_build_sql_insert
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_build_sql_insertdblink_build_sql_insert —
使用一个本地元组构建一个 INSERT 语句，将主键字段值替换为提供的值
大纲
dblink_build_sql_insert(text relname,
int2vector primary_key_attnums,
integer num_primary_key_atts,
text[] src_pk_att_vals_array,
text[] tgt_pk_att_vals_array) 返回 text
描述
dblink_build_sql_insert在选择性地将一个本地表复制到一个远程数据库时很有用。它基于主键从本地表选择一行，并且接着构建一个INSERT命令来复制该行，但主键值被替换为最后一个参数中的值（要创建该行的准确拷贝，只需为最后两个参数指定相同的值）。
参数relname
一个本地关系的名称，例如foo或者myschema.mytab。如果该名称是大小写混合的或包含特殊字符，要包括双引号，例如"FooBar"；如果没有引号，字符串将被折叠到小写形式。
primary_key_attnums
主键字段的属性号（从 1 开始），例如1 2。
num_primary_key_atts
主键字段的数量。
src_pk_att_vals_array
要被用来查找本地元组的主键字段值。每一个字段都被表示为文本形式。如果没有行具有这些主键值，则抛出一个错误。
tgt_pk_att_vals_array
要被替换到结果INSERT命令中的主键字段值。每一个字段被表示为文本形式。
返回值将请求的 SQL 语句返回为文本。备注
自PostgreSQL 9.0 开始，primary_key_attnums中的属性号被解释为逻辑列号，对应于列在SELECT * FROM relname中的位置。之前的版本将属性号解释为物理列位置。如果指示出的列的左边有任意列在该表的生命周期内被删除，这两种解释就有区别。
示例
SELECT dblink_build_sql_insert('foo', '1 2', 2, '{"1", "a"}', '{"1", "b''a"}');
dblink_build_sql_insert
--------------------------------------------------
INSERT INTO foo(f1,f2,f3) VALUES('1','b''a','1')
(1 row)
上一页 上一级 下一页dblink_get_pkey 起始页 dblink_build_sql_delete
