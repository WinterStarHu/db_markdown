# UPDATE

UPDATE
版本：
纠错本页面
搜索
目录导航
❮
❯
UPDATEUPDATE — 更新表的行大纲
[ WITH [ RECURSIVE ] with_query [, ...] ]
更新 [ ONLY ] table_name [ * ] [ [ AS ] alias ]
SET { column_name = { expression | DEFAULT } |
( column_name [, ...] ) = [ ROW ] ( { expression | DEFAULT } [, ...] ) |
( column_name [, ...] ) = ( sub-SELECT )
} [, ...]
[ FROM from_item [, ...] ]
[ WHERE condition | WHERE CURRENT OF cursor_name ]
[ RETURNING [ WITH ( { OLD | NEW } AS output_alias [, ...] ) ]
{ * | output_expression [ [ AS ] output_name ] } [, ...] ]
描述
UPDATE更改满足条件的所有行中指定列
的值。只有要被修改的列需要在SET子句中提及，
没有被显式修改的列保持它们之前的值。
有两种方法使用包含在数据库其他表中的信息来修改一个表：使用子选择
或者在FROM子句中指定额外的表。这种技术更适合
特定的环境。
可选的 RETURNING 子句使 UPDATE
计算并返回基于每一行实际更新的值。
任何使用表的列和/或在 FROM 中提到的其他
表的列的表达式都可以计算。
默认情况下，使用表的列的新（更新后）值，
但也可以请求旧（更新前）值。
RETURNING 列表的语法与 SELECT
的输出列表相同。
你必须拥有该表上的UPDATE特权，或者至少拥有
要被更新的列上的该特权。如果任何一列的值需要被
expressions或者
condition读取，
你还必须拥有该列上的SELECT特权。
参数with_query
WITH子句允许你指定一个或多个在
UPDATE中可用其名称引用的子查询。详见
第 7.8 节和SELECT。
table_name
要更新的表的名称（可以是模式限定的）。如果在表名前指定了
ONLY，只会更新所提及表中的匹配行。如果没有指定
ONLY，任何从所提及表继承得到的表中的匹配行也会
被更新。可选地，在表名之后指定*可以显式地指示要
把后代表也包括在内。
alias
目标表的一个替代名称。在提供了一个别名时，它会完全隐藏表的真实
名称。例如，给定UPDATE foo AS f，
UPDATE语句的剩余部分必须用
f而不是foo来引用该表。
column_name
table_name
所指定的表的一列的名称。如果需要，该列名可以用一个子域名称或者
数组下标限定。不要在目标列的说明中包括表的名称 — 例如
UPDATE table_name SET table_name.col = 1是非法的。
expression
要被赋值给该列的一个表达式。该表达式可以使用该表中这一列或者
其他列的旧值。
DEFAULT
将该列设置为它的默认值（如果没有为它指定默认值表达式，默认值
将会为 NULL）。标识列将设置为关联序列生成的新值。
对于生成的列，允许指定此项，但仅指定从其生成表达式计算列的正常行为。
sub-SELECT
一个SELECT子查询，它产生和在它之前的圆括号中列列表中
一样多的输出列。被执行时，该子查询必须得到不超过一行。如果它得到
一行，其列值会被赋予给目标列。如果它得不到行，NULL 值将被赋予给
目标列。该子查询可以引用被更新表中当前行的旧值。
from_item
表表达式允许来自其他表的列出现在WHERE条件和更新表达式中。这使用与
SELECT语句的FROM
子句相同的语法；例如，可以指定表名的别名。不要将目标表作为from_item
重复，除非你想做自连接（这种情况下它必须以别名出现在from_item中）。
condition
一个返回boolean类型值的表达式。只有当这个
表达式返回true时，相关的行将会被更新。
cursor_name
要在WHERE CURRENT OF条件中使用的游标名。
要被更新的是从这个游标中最近取出的行。该游标必须是一个
在UPDATE目标表上的非分组查询。注意
WHERE CURRENT OF不能和一个布尔条件一起
指定。有关对游标使用WHERE CURRENT OF的
更多信息请见DECLARE。
output_alias
RETURNING列中OLD或NEW行的可选替代名称。
默认情况下，可以通过写OLD.column_name
或OLD.*返回目标表中的旧值，通过写
NEW.column_name
或NEW.*返回新值。当提供别名时，这些名称会被隐藏，
旧行或新行必须使用别名引用。例如RETURNING WITH (OLD AS o, NEW AS n) o.*, n.*。
output_expression
在每一行被更新后，要被UPDATE命令计算并且返回
的表达式。该表达式可以使用
table_name指定
的表或者FROM列出的表中的任何列名。写*
可以返回所有列。
列名或*可以使用
OLD或NEW进行限定，或者使用
对应的output_alias来
返回旧值或新值。未限定的列名，或
*，或使用目标表名或别名限定的列名或
*将返回新值。
output_name
用于返回列的名称。
输出
成功完成时，一个UPDATE命令返回形如
UPDATE count
的命令标签。
count是被更新的行数，
包括值没有更改的匹配行。注意，当更新被一个BEFORE UPDATE
触发器抑制时，这个数量可能比匹配
condition的行数少。如果
count为0，没有行被该查询更新（这不是一个错误）。
如果UPDATE命令包含一个RETURNING
子句，其结果将类似于一个包含RETURNING列表中定义的
列和值的SELECT语句（在被该命令更新的行上计算）
的结果。
注意事项
当存在FROM子句时，实际发生的是：目标表被连接到
from_item列表中的表，并且该连接的每一个输出行
表示对目标表的一个更新操作。在使用FROM时，你应该确保
该连接对每一个要修改的行产生至多一个输出行。换句话说，一个目标行不
应该连接到来自其他表的多于一行上。如果发生这种情况，则只有一个连接行
将被用于更新目标行，但是将使用哪一行是很难预测的。
由于这种不确定性，只在一个子选择中引用其他表更安全，不过这种语句
通常很难写并且也比使用连接慢。
在分区表的情况下，更新一行有可能导致它不再满足其所在分区的分区约束。
此时，如果该行满足分区树中某个其他分区的分区约束，那么该行会被移动
到那个分区。如果没有这样的分区，则会发生错误。在后台，行的移动实际上
是一次DELETE操作和一次INSERT操作。
在移动的行上的并发UPDATE或DELETE可能会收到序列化失败错误。
假设会话1正在分区键上执行UPDATE，同时，对可访问该行的并发会话2在此行上执行UPDATE或DELETE操作。
在这种情况下，会话2的UPDATE或DELETE将检测行移动并引发序列化失败错误（该错误始终返回SQLSTATE代码'40001'）。
如果发生这种情况，应用程序可能希望重试事务。
在通常情况下，表没有分区或没有行移动，会话2将标识新更新的行，并执行UPDATE/DELETE在此新行版本中。
请注意，虽然行可以从本地分区移动到外表分区（如果外数据包装器支持元组路由），但它们不能从外表分区移动到另一个分区。
如果在尝试将一行从一个分区移动到另一个分区时，发现直接引用源分区祖先的外键与在UPDATE查询中提到的祖先不同，则操作将失败。
示例
把表films的列kind
中的单词Drama改成Dramatic：
UPDATE films SET kind = 'Dramatic' WHERE kind = 'Drama';
在表weather的一行中调整温度项并且
把降水量重置为它的默认值：
UPDATE weather SET temp_lo = temp_lo+1, temp_hi = temp_lo+15, prcp = DEFAULT
WHERE city = 'San Francisco' AND date = '2003-07-03';
执行相同的操作并返回更新的条目，以及旧的
降水值：
UPDATE weather SET temp_lo = temp_lo+1, temp_hi = temp_lo+15, prcp = DEFAULT
WHERE city = 'San Francisco' AND date = '2003-07-03'
RETURNING temp_lo, temp_hi, prcp, old.prcp AS old_prcp;
使用另一种列列表语法来做同样的更新：
UPDATE weather SET (temp_lo, temp_hi, prcp) = (temp_lo+1, temp_lo+15, DEFAULT)
WHERE city = 'San Francisco' AND date = '2003-07-03';
为管理Acme Corporation账户的销售人员增加销售量，使用
FROM子句语法：
UPDATE employees SET sales_count = sales_count + 1 FROM accounts
WHERE accounts.name = 'Acme Corporation'
AND employees.id = accounts.sales_person;
执行相同的操作，在
WHERE子句中使用子查询：
UPDATE employees SET sales_count = sales_count + 1 WHERE id =
(SELECT sales_person FROM accounts WHERE name = 'Acme Corporation');
更新账户表中的联系人姓名，使其与当前分配的销售人员匹配：
UPDATE accounts SET (contact_first_name, contact_last_name) =
(SELECT first_name, last_name FROM employees
WHERE employees.id = accounts.sales_person);
可以通过连接实现类似的结果：
UPDATE accounts SET contact_first_name = first_name,
contact_last_name = last_name
FROM employees WHERE employees.id = accounts.sales_person;
然而，如果employees.id不是唯一键，第二个查询可能会产生意外结果，
而第一个查询保证在存在多个id匹配时会引发错误。此外，如果某个特定accounts.sales_person条目没有匹配，
第一个查询将把相应的姓名字段设置为NULL，而第二个查询将不会更新该行。
更新一个统计表中的统计数据以匹配当前数据：
UPDATE summary s SET (sum_x, sum_y, avg_x, avg_y) =
(SELECT sum(x), sum(y), avg(x), avg(y) FROM data d
WHERE d.group_id = s.group_id);
尝试插入一个新库存项及其库存量。如果该项已经存在，则转而更新
已有项的库存量。要这样做并且不让整个事务失败，可以使用保存点：
BEGIN;
-- 其他操作
SAVEPOINT sp1;
INSERT INTO wines VALUES('Chateau Lafite 2003', '24');
-- 假定上述语句由于唯一键冲突失败，
-- 那么现在我们发出这些命令：
ROLLBACK TO sp1;
UPDATE wines SET stock = stock + 24 WHERE winename = 'Chateau Lafite 2003';
-- 继续其他操作，并且最终
COMMIT;
更改表films中光标c_films当前所在行的
kind列：
UPDATE films SET kind = 'Dramatic' WHERE CURRENT OF c_films;
更新影响许多行可能会对系统
性能产生负面影响，例如表膨胀、增加的副本延迟和增加的
锁争用。在这种情况下，分批执行操作可能是合理的，
可能在批次之间对表执行 VACUUM 操作。
虽然 UPDATE 没有 LIMIT 子句，
但可以通过使用
公共表表达式 和自连接来获得类似的效果。
使用标准的 PostgreSQL
表访问方法，在系统
列 ctid 上进行自连接是非常
高效的：
WITH exceeded_max_retries AS (
SELECT w.ctid FROM work_item AS w
WHERE w.status = 'active' AND w.num_retries > 10
ORDER BY w.retry_timestamp
FOR UPDATE
LIMIT 5000
)
UPDATE work_item SET status = 'failed'
FROM exceeded_max_retries AS emr
WHERE work_item.ctid = emr.ctid;
此命令需要重复执行，直到没有行剩余需要更新。
（这种使用 ctid 的方式是安全的，因为
查询会反复运行，避免了 ctid 变化的问题。）
使用 ORDER BY 子句允许命令
优先更新哪些行；如果其他更新操作使用相同的排序，
也可以防止死锁。
如果锁争用是一个问题，则可以将 SKIP LOCKED
添加到 CTE 中，以防止多个命令
更新同一行。然而，随后需要一个
不带 SKIP LOCKED
或 LIMIT 的最终 UPDATE，
以确保没有匹配的行被忽略。
兼容性
这个命令符合SQL标准，不过
FROM和RETURNING子句是
PostgreSQL扩展，把
WITH用于UPDATE也是扩展。
有些其他数据库系统提供了一个FROM选项，在其中目标表
可以在FROM中被再次列出。但
PostgreSQL不是这样解释
FROM的。在移植使用这种扩展的应用时要小心。
根据标准，一个目标列名的圆括号子列表的来源值可以是任意行值表达式，
该表达式返回正确的列数。PostgreSQL只允许来源值是一个
行构造器或者一个子-SELECT。一个列的
被更新值可以在行构造器的情况下被指定为DEFAULT，但在
子-SELECT的情况下不能这样做。
上一页 上一级 下一页UNLISTEN 起始页 VACUUM
