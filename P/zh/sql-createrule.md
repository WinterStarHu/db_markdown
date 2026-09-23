# CREATE RULE

CREATE RULE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE RULECREATE RULE — 定义一条新的重写规则大纲
CREATE [ OR REPLACE ] RULE name AS ON event
TO table_name [ WHERE condition ]
DO [ ALSO | INSTEAD ] { NOTHING | command | ( command ; command ... ) }
其中 event 可以是以下之一：
SELECT | INSERT | UPDATE | DELETE
描述
CREATE RULE定义一条应用于指定表或视图的新规则。CREATE OR REPLACE RULE将创建一条新规则，或者替换同一个表上具有同一名称的现有规则。
PostgreSQL规则系统允许我们定义针对数据库表中插入、更新或者删除动作上的替代动作。大约来说，当在一个给定表上执行给定命令时，一条规则会导致执行额外的命令。或者，INSTEAD规则可以用另一个命令替换给定的命令，或者导致一个命令根本不被执行。规则也被用来实现 SQL 视图。规则实际上是一种命令转换机制或者命令宏。这种转换会在命令的执行开始之前进行。如果你实际上想要为每一个物理行独立地触发一个操作，你可能更需要一个触发器而不是规则。更多有关规则系统的信息请见第 39 章。
目前，ON SELECT规则只能附加到视图上。这样的规则必须命名为"_RETURN"，必须是无条件的INSTEAD规则，并且必须具有一个由单个SELECT命令组成的操作。此命令定义了视图的可见内容。（视图本身基本上是一个没有存储的虚拟表。）最好将这样的规则视为一种实现细节。虽然可以通过CREATE OR REPLACE RULE "_RETURN" AS ...重新定义视图，但更好的做法是使用CREATE OR REPLACE VIEW。
可以通过定义ON INSERT、ON UPDATE以及ON DELETE规则（或者这些规则的任意子集）来创建可更新的视图，这些规则可以把视图上的更新动作替换为其他表上适当的更新动作。如果想要支持INSERT RETURNING等等，那么一定要在每一个这类规则中放上一个合适的RETURNING子句。
如果你尝试为复杂视图更新使用有条件的规则，有一点是很重要的：对于
你希望在该视图上允许的每一个动作，必须有一条
INSTEAD规则。如果该规则是有条件的，或者不是
INSTEAD，那么系统仍将拒绝尝试执行该更新动作，
因为它会认为在某些情况下它可能会尝试在该视图的傀儡表上执行动作。
如果你想处理有条件规则中的所有有用的情况，可以增加一条无条件的
DO INSTEAD NOTHING规则来确保系统理解它将
永远不会被调用来更新傀儡表。然后让有条件规则变成
非-INSTEAD；在它们适用的情况下，它们会加到
默认的INSTEAD NOTHING动作（不过，当前这种方法不
支持RETURNING查询）。
注意
足够简单的视图自动就是可更新的（见CREATE VIEW），它们不需要依靠用户创建的规则来变成可
更新的。不过还是可以创建一条显式规则，自动更新转换通常比显式规则效
率高。
另一种值得考虑的办法是使用INSTEAD OF触发器（见
CREATE TRIGGER）代替规则。
参数name
要创建的规则的名称。它必须与同一个表上任何其他规则的名称相区分。
同一个表上同一种事件类型的多条规则会按照其名称的字母顺序被应用。
event
事件是SELECT、
INSERT、UPDATE或者
DELETE之一。 注意包含ON
CONFLICT子句的INSERT
不能被用在具有INSERT或者
UPDATE规则的表上。那种情况下请考虑使用
可更新的视图。
table_name
规则适用的表或者视图的名称（可以是模式限定的）。
condition
任意的SQL条件表达式（返回
boolean）。该条件表达式不能引用除NEW以及
OLD之外的任何表，并且不能包含聚合函数。
INSTEADINSTEAD指示该命令应该取代
原始命令被执行。
ALSOALSO指示应该在原始命令
之外执行这些命令。
如果ALSO和INSTEAD都没有被指定，
默认是ALSO。
command
组成规则动作的命令。可用的命令有SELECT、
INSERT、UPDATE、
DELETE或NOTIFY。
在condition和
command中，名为
NEW和OLD的表可以被用来引用被
引用表中的值。在ON INSERT和
ON UPDATE规则中，NEW被用来
引用被插入或更新的新行。在ON UPDATE和
ON DELETE规则中，OLD被用来引
用被更新或删除的现有行。
备注
要在表上创建或修改规则，必须是表的拥有者。
在一条用于视图上INSERT、UPDATE
或者DELETE的规则中，可以增加一个RETURNING
子句来发出视图的列。如果该规则被一个INSERT RETURNING、
UPDATE RETURNING或者
DELETE RETURNING命令触发，这个子句将被用来计算输出。
当规则被一个没有RETURNING的命令触发时，该规则的
RETURNING子句将被忽略。当前的实现只允许无条件
INSTEAD规则包含RETURNING。此外，用于同一事件
的所有规则中至多只能有一个RETURNING子句（这确保了只有一个
候选RETURNING子句被用来计算结果）。如果在任何可用规则中都
没有RETURNING子句，视图上的RETURNING查询将
被拒绝。
避免循环规则非常重要。例如，尽管下面的两条规则定义都被
PostgreSQL所接受，
SELECT命令将导致
PostgreSQL报告一个错误，因为会产生一条
规则的递归扩展：
CREATE RULE "_RETURN" AS
ON SELECT TO t1
DO INSTEAD
SELECT * FROM t2;
CREATE RULE "_RETURN" AS
ON SELECT TO t2
DO INSTEAD
SELECT * FROM t1;
SELECT * FROM t1;
当前，如果一个规则动作包含一个NOTIFY命令，
该NOTIFY命令将被无条件执行，也就是说，即使
该规则不被应用到任何行上，也会发出NOTIFY。
例如，在
CREATE RULE notify_me AS ON UPDATE TO mytable DO ALSO NOTIFY mytable;
UPDATE mytable SET name = 'foo' WHERE id = 42;
中，UPDATE期间将发出一个
NOTIFY事件，不管是否有行匹配条件
id = 42。这是一种实现限制，它可能会在未来的发行中被修复。
兼容性
CREATE RULE是一种
PostgreSQL语言扩展，
整个查询重写系统也是这样。
其他参考ALTER RULE, DROP RULE上一页 上一级 下一页CREATE ROLE 起始页 CREATE SCHEMA
