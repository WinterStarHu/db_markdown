# COMMENT

COMMENT
版本：
纠错本页面
搜索
目录导航
❮
❯
COMMENTCOMMENT — 定义或更改一个对象的注释大纲
COMMENT ON
{
ACCESS METHOD object_name |
AGGREGATE aggregate_name ( aggregate_signature ) |
CAST (source_type AS target_type) |
COLLATION object_name |
COLUMN relation_name.column_name |
CONSTRAINT constraint_name ON table_name |
CONSTRAINT constraint_name ON DOMAIN domain_name |
CONVERSION object_name |
DATABASE object_name |
DOMAIN object_name |
EXTENSION object_name |
EVENT TRIGGER object_name |
FOREIGN DATA WRAPPER object_name |
FOREIGN TABLE object_name |
FUNCTION function_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
INDEX object_name |
LARGE OBJECT large_object_oid |
MATERIALIZED VIEW object_name |
OPERATOR operator_name (left_type, right_type) |
OPERATOR CLASS object_name USING index_method |
OPERATOR FAMILY object_name USING index_method |
POLICY policy_name ON table_name |
[ PROCEDURAL ] LANGUAGE object_name |
PROCEDURE procedure_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
PUBLICATION object_name |
ROLE object_name |
ROUTINE routine_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
RULE rule_name ON table_name |
SCHEMA object_name |
SEQUENCE object_name |
SERVER object_name |
STATISTICS object_name |
SUBSCRIPTION object_name |
TABLE object_name |
TABLESPACE object_name |
TEXT SEARCH CONFIGURATION object_name |
TEXT SEARCH DICTIONARY object_name |
TEXT SEARCH PARSER object_name |
TEXT SEARCH TEMPLATE object_name |
TRANSFORM FOR type_name LANGUAGE lang_name |
TRIGGER trigger_name ON table_name |
TYPE object_name |
VIEW object_name
} IS { string_literal | NULL }
其中 aggregate_signature 是：
* |
[ argmode ] [ argname ] argtype [ , ... ] |
[ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]
描述
COMMENT存储关于一个数据库对象的注释。
对每一个对象只保存一个注释字符串，因此为了修改一段注释，对同一个对象
发出一个新的COMMENT命令。要移除一段注释，可在文
本字符串的位置上写上NULL。当对象被删除时，其注释
也会被自动删除。
对要进行评论的对象进行了SHARE UPDATE EXCLUSIVE锁定。
对于大多数类型的对象，只有对象的所有者可以设置注释。
角色没有所有者，因此COMMENT ON ROLE的规则是，
你必须是超级用户才能对超级用户角色进行注释，或者拥有
CREATEROLE权限并被授予目标角色的
ADMIN OPTION。
同样，访问方法也没有所有者；你必须是超级用户才能对访问方法进行注释。
当然，超级用户可以对任何内容进行注释。
使用psql的\d
命令家族可以查看注释。其他检索注释的用户接口可以构建在
psql使用的内建函数之上，即
obj_description、col_description
以及shobj_description
（见表 9.82）。
参数object_namerelation_name.column_nameaggregate_nameconstraint_namefunction_nameoperator_namepolicy_nameprocedure_nameroutine_namerule_nametrigger_name
要被注释的对象的名称。驻留在模式（表、函数等）中的对象的名称可以是模式限定的。
在注释一列时，relation_name必须
引用一个表、视图、组合类型或外部表。
table_namedomain_name
当在一个约束、触发器、规则或策略上创建一段注释时，这些参数指定在其上定义
该对象的表或域的名称。
source_type
转换的源数据类型的名称。
target_type
转换的目标数据类型的名称。
argmode
一个函数、存储过程或聚集函数的参数的模式：IN、
OUT、INOUT或VARIADIC。
如果被省略，默认值是IN。注意
COMMENT并不真正关心
OUT参数，因为决定函数的身份只需要输入参数。因此
列出IN、INOUT和VARIADIC
参数就足够了。
argname
一个函数、存储过程或聚合函数参数的名称。注意
COMMENT并不真正关心参数名称，
因为决定函数的身份只需要参数数据类型。
argtype
一个函数、存储过程或聚合函数参数的数据类型。
large_object_oid
大对象的OID。
left_typeright_type
操作符的参数的数据类型（可以是模式限定的）。对一个前缀操作符
的缺失参数可以写NONE。
PROCEDURAL
这是一个噪声词。
type_name
该转换的数据类型的名称。
lang_name
该转换的语言的名称。
string_literal
新评论内容，以字符串字面量形式编写。
NULL
写入NULL以删除注释。
注释
当前对查看注释没有安全机制：任何连接到一个数据库的用户能够看到
该数据库中所有对象的注释。对于数据库、角色、表空间这类共享对象，
注释被全局存储，因此连接到集簇中任何数据库的任何用户可以看到共
享对象的所有注释。因此，不要在注释中放置有安全性风险的信息。
示例
为表mytable附加一段注释：
COMMENT ON TABLE mytable IS 'This is my table.';
移除它：
COMMENT ON TABLE mytable IS NULL;
更多示例：
COMMENT ON ACCESS METHOD gin IS 'GIN index access method';
COMMENT ON AGGREGATE my_aggregate (double precision) IS 'Computes sample variance';
COMMENT ON CAST (text AS int4) IS 'Allow casts from text to int4';
COMMENT ON COLLATION "fr_CA" IS 'Canadian French';
COMMENT ON COLUMN my_table.my_column IS 'Employee ID number';
COMMENT ON CONVERSION my_conv IS 'Conversion to UTF8';
COMMENT ON CONSTRAINT bar_col_cons ON bar IS 'Constrains column col';
COMMENT ON CONSTRAINT dom_col_constr ON DOMAIN dom IS 'Constrains col of domain';
COMMENT ON DATABASE my_database IS 'Development Database';
COMMENT ON DOMAIN my_domain IS 'Email Address Domain';
COMMENT ON EVENT TRIGGER abort_ddl IS 'Aborts all DDL commands';
COMMENT ON EXTENSION hstore IS 'implements the hstore data type';
COMMENT ON FOREIGN DATA WRAPPER mywrapper IS 'my foreign data wrapper';
COMMENT ON FOREIGN TABLE my_foreign_table IS 'Employee Information in other database';
COMMENT ON FUNCTION my_function (timestamp) IS 'Returns Roman Numeral';
COMMENT ON INDEX my_index IS 'Enforces uniqueness on employee ID';
COMMENT ON LANGUAGE plpython IS 'Python support for stored procedures';
COMMENT ON LARGE OBJECT 346344 IS 'Planning document';
COMMENT ON MATERIALIZED VIEW my_matview IS 'Summary of order history';
COMMENT ON OPERATOR ^ (text, text) IS 'Performs intersection of two texts';
COMMENT ON OPERATOR - (NONE, integer) IS 'Unary minus';
COMMENT ON OPERATOR CLASS int4ops USING btree IS '4 byte integer operators for btrees';
COMMENT ON OPERATOR FAMILY integer_ops USING btree IS 'all integer operators for btrees';
COMMENT ON POLICY my_policy ON mytable IS 'Filter rows by users';
COMMENT ON PROCEDURE my_proc (integer, integer) IS 'Runs a report';
COMMENT ON PUBLICATION alltables IS 'Publishes all operations on all tables';
COMMENT ON ROLE my_role IS 'Administration group for finance tables';
COMMENT ON ROUTINE my_routine (integer, integer) IS 'Runs a routine (which is a function or procedure)';
COMMENT ON RULE my_rule ON my_table IS 'Logs updates of employee records';
COMMENT ON SCHEMA my_schema IS 'Departmental data';
COMMENT ON SEQUENCE my_sequence IS 'Used to generate primary keys';
COMMENT ON SERVER myserver IS 'my foreign server';
COMMENT ON STATISTICS my_statistics IS 'Improves planner row estimations';
COMMENT ON SUBSCRIPTION alltables IS 'Subscription for all operations on all tables';
COMMENT ON TABLE my_schema.my_table IS 'Employee Information';
COMMENT ON TABLESPACE my_tablespace IS 'Tablespace for indexes';
COMMENT ON TEXT SEARCH CONFIGURATION my_config IS 'Special word filtering';
COMMENT ON TEXT SEARCH DICTIONARY swedish IS 'Snowball stemmer for Swedish language';
COMMENT ON TEXT SEARCH PARSER my_parser IS 'Splits text into words';
COMMENT ON TEXT SEARCH TEMPLATE snowball IS 'Snowball stemmer';
COMMENT ON TRANSFORM FOR hstore LANGUAGE plpython3u IS 'Transform between hstore and Python dict';
COMMENT ON TRIGGER my_trigger ON my_table IS 'Used for RI';
COMMENT ON TYPE complex IS 'Complex number data type';
COMMENT ON VIEW my_view IS 'View of departmental costs';
兼容性
SQL 标准中没有COMMENT命令。
上一页 上一级 下一页CLUSTER 起始页 COMMIT
