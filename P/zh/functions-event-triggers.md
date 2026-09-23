# 9.30. 事件触发器函数

9.30. 事件触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.30. 事件触发器函数 #9.30.1. 在命令结束处捕捉更改9.30.2. 处理被 DDL 命令删除的对象9.30.3. 处理表重写事件
PostgreSQL提供了这些助手函数来从事件触发器检索信息。
更多有关事件触发器的信息，请见第 38 章。
9.30.1. 在命令结束处捕捉更改 #
pg_event_trigger_ddl_commands () → setof record
当在一个ddl_command_end事件触发器的函数中调用时，pg_event_trigger_ddl_commands返回被每一个用户动作执行的DDL命令的列表。
如果在其他任何环境中调用这个函数，会发生错误。
pg_event_trigger_ddl_commands为每一个被执行的基本命令返回一行，某些只有一个单一 SQL 句子的命令可能会返回多于一行。
这个函数返回下面的列：
名称类型描述classidoid对象所属的目录的 OIDobjidoid对象本身的 OIDobjsubidinteger子对象 ID（例如列的属性号）command_tagtext命令标签object_typetext对象的类型schema_nametext
该对象所属的模式的名称（如果有），如果没有则为NULL。
没有引号。
object_identitytext
对象标识的文本表现形式，用模式限定。如果必要，出现在
该标识中的每一个标识符都会被引用。
in_extensionboolean如果该命令是一个扩展脚本的一部分则为真commandpg_ddl_command
以内部格式表达的该命令的一个完整表现形式。这不能被直接输出，
但是可以把它传递给其他函数来得到有关于该命令不同部分的信息。
9.30.2. 处理被 DDL 命令删除的对象 #
pg_event_trigger_dropped_objects () → setof record
pg_event_trigger_dropped_objects返回被调用sql_drop事件的命令删除的所有对象的列表。
如果调用在任何其他上下文中，会引发一个错误。这个函数返回以下列:
名称类型描述classidoid对象所属的目录的 OIDobjidoid对象本身的 OIDobjsubidinteger子对象 ID（如列的属性号）originalboolean如果这是删除中的一个根对象则为真normalboolean
如果在依赖图中有一个普通依赖关系指向该对象则为真
is_temporaryboolean
如果该对象是一个临时对象则为真
object_typetext对象的类型schema_nametext
对象所属模式的名称（如果存在）；否则为NULL。不应用引用。
object_nametext
如果模式和名称的组合能被用于对象的一个唯一标识符，则是对象的名称；否则是NULL。不应用引用，并且名称不是模式限定的。
object_identitytext
对象身份的文本表现，模式限定的。每一个以及所有身份中出现的标识符在必要时加引号。
address_namestext[]
一个数组，它可以和object_type及address_args，
一起通过pg_get_object_address函数在一台包含有同类相同名称对象的远程服务器上重建该对象地址。
address_argstext[]
上述address_names的补充。
pg_event_trigger_dropped_objects可以被这样用在一个事件触发器中：
CREATE FUNCTION test_event_trigger_for_drops()
RETURNS event_trigger LANGUAGE plpgsql AS $$
DECLARE
obj record;
BEGIN
FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
LOOP
RAISE NOTICE '% dropped object: % %.% %',
tg_tag,
obj.object_type,
obj.schema_name,
obj.object_name,
obj.object_identity;
END LOOP;
END;
$$;
CREATE EVENT TRIGGER test_event_trigger_for_drops
ON sql_drop
EXECUTE FUNCTION test_event_trigger_for_drops();
9.30.3. 处理表重写事件 #
表 9.111
中所示的函数提供刚刚被调用过table_rewrite
事件的表的信息。如果在任何其他环境中调用，会发生错误。
表 9.111. 表重写信息函数
函数
描述
pg_event_trigger_table_rewrite_oid ()
→ oid
返回将要重写的表的OID。
pg_event_trigger_table_rewrite_reason ()
→ integer
返回一个代码，用于解释重写的原因。该值是从以下值构建的位图：
1（表的持久性已更改），2（列的默认值已更改），
4（列具有新的数据类型）以及8（表的访问方法已更改）。
这些函数可以在事件触发器中使用，就像这样:
CREATE FUNCTION test_event_trigger_table_rewrite_oid()
RETURNS event_trigger
LANGUAGE plpgsql AS
$$
BEGIN
RAISE NOTICE 'rewriting table % for reason %',
pg_event_trigger_table_rewrite_oid()::regclass,
pg_event_trigger_table_rewrite_reason();
END;
$$;
CREATE EVENT TRIGGER test_table_rewrite_oid
ON table_rewrite
EXECUTE FUNCTION test_event_trigger_table_rewrite_oid();
上一页 上一级 下一页9.29. 触发器函数 起始页 9.31. 统计信息函数
