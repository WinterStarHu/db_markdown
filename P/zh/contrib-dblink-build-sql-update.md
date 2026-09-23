# dblink_build_sql_update

dblink_build_sql_update
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_build_sql_updatedblink_build_sql_update — 使用一个本地元组构建一个 UPDATE 语句，将主键字段值替换为提供的值
大纲
dblink_build_sql_update(text relname,
int2vector primary_key_attnums,
integer num_primary_key_atts,
text[] src_pk_att_vals_array,
text[] tgt_pk_att_vals_array) 返回 text
描述
dblink_build_sql_update在选择性地将一个本地表复制到一个远程数据库时很有用。它从本地表基于主键选择一行，并且接着构建一个 SQL UPDATE命令来复制该行，但是其中的主键值被替换为最后一个参数中的值（要创建该行的一个准确拷贝，只要为最后两个参数指定相同的值）。UPDATE命令总是为该行的所有字段赋值 — 这个函数与dblink_build_sql_insert之间的主要区别是它假定目标行已经存在于远程表中。
参数relname
一个本地关系的名称，例如foo或
myschema.mytab。如果该名称是大小写混合的或包含特殊字符，要包括双引号，例如"FooBar"；如果没有引号，字符串将被折叠到小写形式。
primary_key_attnums
主键字段的属性号（从 1 开始），例如1 2。
num_primary_key_atts
主键字段的数量。
src_pk_att_vals_array
要用来查找本地元组的主键字段值。每个字段都以文本形式表示。如果没有行具有这些主键值，则抛出一个错误。
tgt_pk_att_vals_array
要放入结果UPDATE命令中的主键字段值。每个字段都以文本形式表示。
返回值将请求的 SQL 语句返回为文本。备注
自PostgreSQL 9.0 开始，primary_key_attnums中的属性号被解释为逻辑列号，对应于列在SELECT * FROM relname中的位置。之前的版本将属性号解释为物理列位置。如果指示出的列的左边有任意列在该表的生存期内被删除，这两种解释就有区别。
示例
SELECT dblink_build_sql_update('foo', '1 2', 2, '{"1", "a"}', '{"1", "b"}');
dblink_build_sql_update
-------------------------------------------------------------
UPDATE foo SET f1='1',f2='b',f3='1' WHERE f1='1' AND f2='b'
(1 row)
上一页 上一级 下一页dblink_build_sql_delete 起始页 F.12. dict_int —
示例全文搜索字典用于整数
