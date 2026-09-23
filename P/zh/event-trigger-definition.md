# 38.1. 事件触发器行为总览

38.1. 事件触发器行为总览
版本：
纠错本页面
搜索
目录导航
❮
❯
38.1. 事件触发器行为总览 #38.1.1. login38.1.2. ddl_command_start38.1.3. ddl_command_end38.1.4. sql_drop38.1.5. 表重写38.1.6. 在中止事务中的事件触发器38.1.7. 创建事件触发器
事件触发器在与其关联的事件发生在定义它的数据库中时触发。
当前，支持的事件有
login、
ddl_command_start、
ddl_command_end、
table_rewrite
和 sql_drop。
未来版本可能会添加对其他事件的支持。
38.1.1. login #
当经过身份验证的用户登录系统时，会发生login事件。该事件的触发过程中的任何
错误都可能导致无法成功登录系统。可以通过在连接字符串或配置文件中将
event_triggers设置为false来规避此类错误。
或者，您也可以在单用户模式下重启系统（因为事件触发器在此模式下被禁用）。
有关使用单用户模式的详细信息，请参阅postgres参考页面。
login事件也会在备用服务器上触发。为了防止服务器变得不可访问，
这些触发器在备用服务器上运行时必须避免向数据库写入任何内容。
此外，建议避免在login事件触发器中执行长时间运行的查询。
注意，例如，在psql中取消连接不会取消正在进行的
login触发器。
有关如何使用 login 事件触发器的示例，
请参见 第 38.5 节。
38.1.2. ddl_command_start #
ddl_command_start 事件发生在 DDL 命令执行之前。
在此上下文中，DDL 命令包括：
CREATEALTERDROPCOMMENTGRANTIMPORT FOREIGN SCHEMAREINDEXREFRESH MATERIALIZED VIEWREVOKESECURITY LABEL
ddl_command_start 也会在执行 SELECT INTO 命令之前发生，
因为这相当于 CREATE TABLE AS。
作为例外，此事件不会发生在针对共享对象的 DDL 命令上：
数据库角色（角色定义和角色成员）表空间参数权限ALTER SYSTEM
此事件也不会发生在针对事件触发器本身的命令上。
在事件触发器触发之前，不会检查受影响对象是否存在。
38.1.3. ddl_command_end #
ddl_command_end 事件发生在与 ddl_command_start 相同的一组命令执行之后。
要获取有关发生的 DDL 操作的更多详细信息，
请使用从 ddl_command_end 事件触发器代码中返回的集合函数
pg_event_trigger_ddl_commands()（参见
第 9.30 节）。请注意，触发器在操作发生后触发
（但在事务提交之前），因此系统目录可以被视为已经更改。
38.1.4. sql_drop #
sql_drop 事件发生在任何删除数据库对象的操作的
ddl_command_end 事件触发器之前。请注意，除了明显的
DROP 命令外，一些 ALTER 命令也可能触发
sql_drop 事件。
要列出已删除的对象，请使用从
sql_drop 事件触发器代码中返回的集合函数
pg_event_trigger_dropped_objects()（参见
第 9.30 节）。请注意，
触发器在对象从系统目录中删除后执行，因此无法再查找它们。
38.1.5. 表重写 #
table_rewrite 事件发生在表被
ALTER TABLE 和
ALTER TYPE 命令的某些操作重写之前。虽然还有其他
控制语句可用于重写表，
如 CLUSTER 和 VACUUM，
但 table_rewrite 事件并不会被它们触发。
要查找被重写表的 OID，请使用函数
pg_event_trigger_table_rewrite_oid()，要发现
重写的原因，请使用函数
pg_event_trigger_table_rewrite_reason()（参见 第 9.30 节）。
38.1.6. 在中止事务中的事件触发器 #
事件触发器（其他函数也一样）不能在一个中止的事务中执行。因此，如果一个
DDL 命令出现错误失败，将不会执行任何相关的
ddl_command_end触发器。反过来，如果一个
ddl_command_start触发器出现错误失败，将不会引发进一步的
事件触发器，并且不会尝试执行该命令本身。类似地，如果一个
ddl_command_end触发器出现错误失败，DDL 命令的效果将被
回滚，就像其他包含事务中止的情况中那样。
38.1.7. 创建事件触发器 #
事件触发器通过命令CREATE EVENT TRIGGER创建。为了
创建一个事件触发器，你必须首先创建一个有特殊返回类型
event_trigger的函数。这个函数不一定需要返回一个值，
该返回类型仅仅是作为一种信号表示该函数要被作为一个事件触发器调用。
如果对于一个特定的事件定义了多个事件触发器，它们将按照触发器名称
的字母表顺序被引发。
一个触发器定义也可以指定一个WHEN条件，这样事件触
发器（例如ddl_command_start触发器）就可以只对用户
希望介入的特定命令触发。这类触发器的常见用法是用于限制用户可能执行的
DDL 操作的范围。
上一页 上一级 下一页第 38 章 事件触发器 起始页 38.2. 用 C 编写事件触发器函数
