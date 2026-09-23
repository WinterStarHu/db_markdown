# DELETE

DELETE
版本：
纠错本页面
搜索
目录导航
❮
❯
DELETEDELETE — 删除表中的行大纲
[ WITH [ RECURSIVE ] with_query [, ...] ]
DELETE FROM [ ONLY ] table_name [ * ] [ [ AS ] alias ]
[ USING from_item [, ...] ]
[ WHERE condition | WHERE CURRENT OF cursor_name ]
[ RETURNING [ WITH ( { OLD | NEW } AS output_alias [, ...] ) ]
{ * | output_expression [ [ AS ] output_name ] } [, ...] ]
描述
DELETE从指定表中删除满足
WHERE子句的行。如果WHERE
子句缺失，效果是删除表中的所有行。结果是一个合法的空表。
提示
TRUNCATE提供一个
更快速的机制来移除表中的所有行。
有两种方式可以使用数据库中其他表中包含的信息来删除表中的行：
使用子查询，或者在USING子句中指定额外的表。
哪种技术更合适取决于具体情况。
可选的RETURNING子句使DELETE
基于实际被删除的每一行计算并返回值。任何使用表的列和/或
在USING中提到的其他表的列的表达式都可以被计算。
RETURNING列表的语法与SELECT的
输出列表语法相同。
要从表中删除行，你必须具有其上的DELETE特权，
以及USING子句中任何表以及其值在condition中被读取的表上的
SELECT特权。
参数with_query
WITH子句允许你指定一个或多个子查询，在
DELETE查询中可以用子查询的名字来引用它们。
详见第 7.8 节和SELECT。
table_name
要从其中删除行的表名（可以是模式限定的）。如果在表名前指定
ONLY，只会从提到的表中删除匹配的行。如果没有指定
ONLY，还会删除该表的任何继承表中的匹配行。可选地，
可以在表名后面指定*来显式指定要包括继承表。
alias
目标表的一个别名。提供别名时，它会完全隐藏该表的真实名称。例如，
对于DELETE FROM foo AS f，
DELETE语句的剩余部分都会用
f而不是foo来引用该表。
from_item
一个表的表达式允许在WHERE条件中出现
来自其他表的列。这使用与SELECT语法的
FROM子句相同的语法；
例如，可以指定表名的别名。除非您希望建立自联接（在这种情况下，它必须与
from_item中的别名一起出现），否则不要
将目标表重复为from_item。
condition
一个返回boolean类型值的表达式。只有让这个
表达式返回true的行才将被删除。
cursor_name
要在WHERE CURRENT OF条件中使用的游标
的名称。最近一次从这个游标中取出的行将被删除。该游标
必须是DELETE的目标表上的非分组查询。
注意不能在使用WHERE CURRENT OF的同时
指定一个布尔条件。有关将游标用于
WHERE CURRENT OF的更多信息请见
DECLARE。
output_alias
RETURNING 列中 OLD 或 NEW 行的可选替代名称。
默认情况下，可以通过写 OLD.column_name
或 OLD.* 返回目标表中的旧值，通过写
NEW.column_name
或 NEW.* 返回新值。当提供别名时，这些名称会被隐藏，
旧行或新行必须使用别名引用。例如 RETURNING WITH (OLD AS o, NEW AS n) o.*, n.*。
output_expression
在每一行被删除后，会被DELETE计算并返回的表达式。
该表达式可以使用table_name
以及USING中的表的任何列。写成*可以返回所有列。
列名或 * 可以使用 OLD 或 NEW 进行限定，
或使用对应的 output_alias 来返回旧值或新值。
未限定的列名，或 *，或使用目标表名或别名限定的列名或 * 将返回旧值。
对于简单的 DELETE，所有新值将为 NULL。
然而，如果 ON DELETE 规则导致执行 INSERT 或 UPDATE，
新值可能不是 NULL。
output_name
用于返回列的名称。
输出
在成功完成时，一个DELETE命令会返回以下形式
的命令标签：
DELETE count
count是被删除行的数目。
注意如果有一个BEFORE DELETE触发器抑制删除，那么该数目
可能小于匹配condition
的行数。如果count为 0，
表示查询没有删除行（这并非一种错误）。
如果DELETE命令包含RETURNING子句，
则结果会与包含有SELECT语句结果相似，该语句
包含RETURNING列表中定义的列和值，这些结果是在被
该命令删除的行上计算得来。
注释
PostgreSQL允许通过在USING
子句中指定其他表，在WHERE条件中引用其他表的列。
例如，要删除由给定制片人制作的所有电影，可以这样做：
DELETE FROM films USING producers
WHERE producer_id = producers.id AND producers.name = 'foo';
这里实际发生的事情是在films和
producers之间进行连接，然后删除
所有成功连接的films行。这种语法不
属于标准。更标准的方式是：
DELETE FROM films
WHERE producer_id IN (SELECT id FROM producers WHERE name = 'foo');
在一些情况下，连接形式比子查询形式更容易书写或者执行更快。
示例
删除所有电影，但音乐剧除外：
DELETE FROM films WHERE kind <> 'Musical';
清空表films：
DELETE FROM films;
删除已完成的任务，返回被删除行的详细信息：
DELETE FROM tasks WHERE status = 'DONE' RETURNING *;
删除光标c_tasks当前所在的tasks行：
DELETE FROM tasks WHERE CURRENT OF c_tasks;
虽然 DELETE 没有 LIMIT 子句，
但可以使用在 文档中描述的相同方法 来获得类似的效果：
WITH delete_batch AS (
SELECT l.ctid FROM user_logs AS l
WHERE l.status = 'archived'
ORDER BY l.creation_date
FOR UPDATE
LIMIT 10000
)
DELETE FROM user_logs AS dl
USING delete_batch AS del
WHERE dl.ctid = del.ctid;
这种使用 ctid 的方式是安全的，因为
查询是重复运行的，避免了 ctid 变化的问题。
兼容性
这个命令符合SQL标准，不过
USING和RETURNING子句是
PostgreSQL扩展，在
DELETE中使用WITH也是扩展。
另见TRUNCATE上一页 上一级 下一页DECLARE 起始页 DISCARD
