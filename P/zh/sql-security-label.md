# SECURITY LABEL

SECURITY LABEL
版本：
纠错本页面
搜索
目录导航
❮
❯
SECURITY LABELSECURITY LABEL — 定义或更改应用到对象的安全标签大纲
SECURITY LABEL [ FOR provider ] ON
{
TABLE object_name |
COLUMN table_name.column_name |
AGGREGATE aggregate_name ( aggregate_signature ) |
DATABASE object_name |
DOMAIN object_name |
EVENT TRIGGER object_name |
FOREIGN TABLE object_name |
FUNCTION function_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
LARGE OBJECT large_object_oid |
MATERIALIZED VIEW object_name |
[ PROCEDURAL ] LANGUAGE object_name |
PROCEDURE procedure_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
PUBLICATION object_name |
ROLE object_name |
ROUTINE routine_name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] |
SCHEMA object_name |
SEQUENCE object_name |
SUBSCRIPTION object_name |
TABLESPACE object_name |
TYPE object_name |
VIEW object_name
} IS { string_literal | NULL }
其中 aggregate_signature 是：
* |
[ argmode ] [ argname ] argtype [ , ... ] |
[ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]
描述
SECURITY LABEL对一个数据库对象应用一个安全
标签。可以把任意数量的安全标签（每个标签提供者对应一个）关联到一个给定
的数据库对象。标签提供者是使用函数register_label_provider
注册自己的可装载模块。
注意
register_label_provider不是一个 SQL 函数；它只能在被载入
到后端的 C 代码中调用。
标签提供者决定一个给定标签是否合法并且它是否可以被分配该标签给一个给定
对象。一个给定标签的含义也同样由标签提供者判断。
PostgreSQL没有对一个标签提供者是否必须或者如何解释
安全标签做出限定，它仅仅只是提供了一种机制来存储它们。实际上，这个功能是
为了允许与基于标签的强制访问控制（MAC）系统集成（例如
SELinux）。这类系统会基于对象标签而不是传统的自主
访问控制（DAC）概念（例如用户和组）做出所有访问控制决定。
您必须拥有数据库对象才能使用 SECURITY LABEL。
参数object_nametable_name.column_nameaggregate_namefunction_nameprocedure_nameroutine_name
要被贴上标签的对象的名称。位于模式中的对象（表、函数等）的名称可以是模式限定的。
provider
这个标签相关联的提供者的名称。所提到的提供者必须已被载入并且必须同意所提出
的标签操作。如果正好只载入了一个提供者，可以出于简洁的需要忽略提供者的名称。
argmode
一个函数、存储过程或聚集函数参数的模式：IN、OUT、
INOUT或者VARIADIC。如果被忽略，默认值会是
IN。注意SECURITY LABEL并不真正
关心OUT参数，因为判断函数的身份时只需要输入参数。因此列出
IN、INOUT和VARIADIC参数足矣。
argname
一个函数、存储过程或聚集函数参数的名称。注意SECURITY LABEL
并不真正关心参数的名称，因为判断函数的身份时只需要参数的数据类型。
argtype
一个函数、存储过程或聚集函数参数的数据类型。
large_object_oid
大对象的OID。
PROCEDURAL
这是一个噪声词。
string_literal
新的安全标签设置，以字符串字面量形式表示。
NULL
写入NULL以删除安全标签。
示例
下面的示例显示了如何设置或更改表的安全标签：
SECURITY LABEL FOR selinux ON TABLE mytable IS 'system_u:object_r:sepgsql_table_t:s0';
要移除标签：
SECURITY LABEL FOR selinux ON TABLE mytable IS NULL;
兼容性
在 SQL 标准中没有SECURITY LABEL命令。
另见sepgsql, src/test/modules/dummy_seclabel上一页 上一级 下一页SAVEPOINT 起始页 SELECT
