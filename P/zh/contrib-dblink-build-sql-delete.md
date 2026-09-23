# dblink_build_sql_delete

dblink_build_sql_delete
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_build_sql_deletedblink_build_sql_delete — 使用所提供的主键字段值构建一个 DELETE 语句
大纲
dblink_build_sql_delete(text relname,
int2vector primary_key_attnums,
integer num_primary_key_atts,
text[] tgt_pk_att_vals_array) 返回 text
描述
dblink_build_sql_delete在选择性地将一个本地表复制到一个远程数据库时很有用。它构建一个 SQL DELETE命令，用来删除具有给定主键值的行。
参数relname
一个本地关系的名称，例如foo或者myschema.mytab。如果该名称是大小写混合的或包含特殊字符，要包括双引号，例如"FooBar"；如果没有引号，字符串将被折叠到小写形式。
primary_key_attnums
主键字段的属性号（从 1 开始），例如1 2。
num_primary_key_atts
主键字段的数量。
tgt_pk_att_vals_array
要用在结果DELETE命令中的主键字段值。每一个字段都被表示为文本形式。
返回值返回请求的 SQL 语句作为文本。备注
自PostgreSQL 9.0 开始，primary_key_attnums中的属性号被解释为逻辑列号，对应于列在SELECT * FROM relname中的位置。之前的版本将属性号解释为物理列位置。如果指示出的列的左边有任意列在该表的生命周期内被删除，这两种解释就有区别。
示例
SELECT dblink_build_sql_delete('"MyFoo"', '1 2', 2, '{"1", "b"}');
dblink_build_sql_delete
---------------------------------------------
DELETE FROM "MyFoo" WHERE f1='1' AND f2='b'
(1 row)
上一页 上一级 下一页dblink_build_sql_insert 起始页 dblink_build_sql_update
