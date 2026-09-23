# ALTER SEQUENCE

ALTER SEQUENCE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER SEQUENCEALTER SEQUENCE —
更改序列生成器的定义
大纲
ALTER SEQUENCE [ IF EXISTS ] name
[ AS data_type ]
[ INCREMENT [ BY ] increment ]
[ MINVALUE minvalue | NO MINVALUE ] [ MAXVALUE maxvalue | NO MAXVALUE ]
[ [ NO ] CYCLE ]
[ START [ WITH ] start ]
[ RESTART [ [ WITH ] restart ] ]
[ CACHE cache ]
[ OWNED BY { table_name.column_name | NONE } ]
ALTER SEQUENCE [ IF EXISTS ] name SET { LOGGED | UNLOGGED }
ALTER SEQUENCE [ IF EXISTS ] name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER SEQUENCE [ IF EXISTS ] name RENAME TO new_name
ALTER SEQUENCE [ IF EXISTS ] name SET SCHEMA new_schema
描述
ALTER SEQUENCE更改现有序列生成器的参数。
任何没有在ALTER SEQUENCE命令中明确设置的参数
保持它们之前的设置。
您必须拥有该序列才能使用ALTER SEQUENCE。
要更改序列的模式，您还必须在新模式上拥有CREATE
权限。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须在序列的模式上拥有CREATE
权限。
（这些限制确保更改所有者不会执行您通过删除和重新创建序列
无法完成的操作。然而，超级用户仍然可以更改任何序列的所有权。）
参数
name
要更改的序列的名称（可选地包含模式限定符）。
IF EXISTS
如果序列不存在，则不会抛出错误。在这种情况下会发出通知。
data_type
可选的子句AS data_type
改变了序列的数据类型。有效的类型包括
smallint，integer，
和bigint。
更改数据类型会自动更改序列的最小和最大值，前提是先前的最小和最大值是旧数据类型的最小值或最大值（换句话说，如果序列是使用NO MINVALUE或NO MAXVALUE隐式或显式创建的）。否则，最小和最大值将被保留，除非在同一命令的一部分中给出新值。如果最小和最大值不适合新数据类型，将生成错误。
increment
子句INCREMENT BY increment是可选的。一个正值将创建一个升序序列，一个负值将创建一个降序序列。如果未指定，旧的增量值将被保留。
minvalueNO MINVALUE
可选子句MINVALUE minvalue确定序列可以生成的最小值。
如果指定了NO MINVALUE，则将分别使用升序和降序序列的默认值1和数据类型的最小值。
如果没有指定任何选项，则将保持当前最小值。
maxvalueNO MAXVALUE
可选子句MAXVALUE maxvalue确定序列的最大值。
如果指定了NO MAXVALUE，则将分别使用数据类型的最大值和升序和降序序列的默认值-1。
如果没有指定任何选项，则将保持当前最大值。
CYCLE
可选的CYCLE关键字可用于在maxvalue或minvalue被升序或降序序列达到时使序列环绕。如果达到限制，生成的下一个数字将分别是minvalue或maxvalue。
NO CYCLE
如果指定了可选的NO CYCLE关键字，则在序列达到最大值后调用nextval将返回错误。
如果既没有指定CYCLE也没有指定NO CYCLE，则将保持旧的循环行为。
start
可选子句START WITH start会改变序列的记录起始值。
这不会影响当前序列值；它只是设置未来ALTER SEQUENCE RESTART命令将使用的值。
restart
可选子句RESTART [ WITH restart ]会改变序列的当前值。
这类似于使用setval函数并将is_called = false：
指定的值将在nextval的下一个调用中返回。
使用没有restart值的RESTART等同于提供由CREATE SEQUENCE记录的起始值
或由ALTER SEQUENCE START WITH上次设置的值。
与setval调用相比，对序列执行RESTART操作是事务性的，
并且会阻止并发事务从同一序列获取数字。如果这不是期望的操作模式，
应该使用setval。
cache
该子句CACHE cache允许预先分配序列号并存储在内存中以加快访问速度。最小值为1（一次只能生成一个值，即无缓存）。
如果未指定，则将保留旧的缓存值。
SET { LOGGED | UNLOGGED }
这个表单将序列从未记录更改为已记录，反之亦然（参见CREATE SEQUENCE）。
不能应用于临时序列。
OWNED BY table_name.column_nameOWNED BY NONE
OWNED BY选项会导致序列与特定表列相关联，如果该列（或整个表）被删除，序列也将被自动删除。
如果指定了此关联，它将替换序列的任何先前指定的关联。指定的表必须与序列具有相同的所有者并且在相同的模式中。
指定OWNED BY NONE会移除任何现有关联，使序列成为“独立的”。
new_owner
新所有者的用户名。
new_name
序列的新名称。
new_schema
序列的新架构。
注释
ALTER SEQUENCE将不会立即影响除当前后端外
其他后端中的nextval结果，因为它们有预分配（缓存）的序列
值。在注意到序列生成参数被更改之前它们将用尽所有缓存的值。当前后端将被
立即影响。
ALTER SEQUENCE不会影响该序列的
currval状态（在
PostgreSQL 8.3之前有时会影响）。
ALTER SEQUENCE阻塞并发nextval、
currval、lastval和
setval调用。
由于历史原因，ALTER TABLE也可以被用于序列，
但是只有等效于上述形式的ALTER TABLE变体才被
允许用于序列。
示例
在 105 重启一个被称为 serial 的序列：
ALTER SEQUENCE serial RESTART WITH 105;
兼容性
ALTER SEQUENCE 符合 SQL
标准，不过 AS、START WITH、
OWNED BY、OWNER TO、RENAME TO
以及 SET SCHEMA 子句是
PostgreSQL 扩展。
另见CREATE SEQUENCE, DROP SEQUENCE上一页 上一级 下一页ALTER SCHEMA 起始页 ALTER SERVER
