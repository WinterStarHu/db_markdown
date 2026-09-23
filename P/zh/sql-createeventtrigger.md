# CREATE EVENT TRIGGER

CREATE EVENT TRIGGER
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE EVENT TRIGGERCREATE EVENT TRIGGER — 定义一个新的事件触发器大纲
CREATE EVENT TRIGGER name
ON event
[ WHEN filter_variable IN (filter_value [, ... ]) [ AND ... ] ]
EXECUTE { FUNCTION | PROCEDURE } function_name()
描述
CREATE EVENT TRIGGER 创建一个新的事件触发器。
只要指定的事件发生并且与该触发器相关的 WHEN 条件（如果有）被
满足，该触发器的函数将被执行。关于事件触发器的一般性介绍可见
第 38 章。创建事件触发器的用户会成为它的拥有者。
参数name
给新触发器的名称。这个名称在数据库中必须唯一。
event
会触发对给定函数调用的事件名称。更多事件名称的信息请见
第 38.1 节。
filter_variable
用来过滤事件的变量名称。这可以用来限制触发器只为它支持的那一部分
情况引发。当前唯一支持的
filter_variable
是TAG。
filter_value
与该触发器要为其引发的
filter_variable相关联
的一个值列表。对于TAG，这表示一个命令标签列表（例如
'DROP FUNCTION'）。
function_name
一个用户提供的函数，它被声明为没有参数并且返回类型
event_trigger。
在CREATE EVENT TRIGGER的语法中，关键字
FUNCTION和PROCEDURE是
等效的，但是被引用的函数在任何情况下都必须是函数，
而不是过程。此处关键字PROCEDURE的使用是历史性的，已弃用。
Notes
只有超级用户可以创建事件触发器。
事件触发器在单用户模式下被禁用（参见 postgres），以及当
event_triggers 设置为 false 时也被禁用。
如果错误的事件触发器导致数据库严重受损，甚至无法删除该触发器，
请重新启动并将 event_triggers 设置为 false，
以临时禁用事件触发器，或者在单用户模式下启动，这样你就可以执行删除操作。
Examples
禁止执行任何DDL命令：
CREATE OR REPLACE FUNCTION abort_any_command()
RETURNS event_trigger
LANGUAGE plpgsql
AS $$
BEGIN
RAISE EXCEPTION 'command % is disabled', tg_tag;
END;
$$;
CREATE EVENT TRIGGER abort_ddl ON ddl_command_start
EXECUTE FUNCTION abort_any_command();
兼容性
在 SQL 标准中没有
CREATE EVENT TRIGGER语句。
另见ALTER EVENT TRIGGER, DROP EVENT TRIGGER, CREATE FUNCTION上一页 上一级 下一页CREATE DOMAIN 起始页 CREATE EXTENSION
