# CREATE TRIGGER

CREATE TRIGGER
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TRIGGERCREATE TRIGGER — 定义一个新触发器大纲
CREATE [ OR REPLACE ] [ CONSTRAINT ] TRIGGER name { BEFORE | AFTER | INSTEAD OF } { event [ OR ... ] }
ON table_name
[ FROM referenced_table_name ]
[ NOT DEFERRABLE | [ DEFERRABLE ] [ INITIALLY IMMEDIATE | INITIALLY DEFERRED ] ]
[ REFERENCING { { OLD | NEW } TABLE [ AS ] transition_relation_name } [ ... ] ]
[ FOR [ EACH ] { ROW | STATEMENT } ]
[ WHEN ( condition ) ]
EXECUTE { FUNCTION | PROCEDURE } function_name ( arguments )
这里的event可以是下列之一：
INSERT
UPDATE [ OF column_name [, ... ] ]
DELETE
TRUNCATE
描述
CREATE TRIGGER创建一个新触发器。
CREATE OR REPLACE TRIGGER 将创建一个新触发器，或者替换一个已有的触发器。
该触发器将被关联到指定的表、视图或者外部表，并且在表上发生特定操作时将执行指定的函数function_name。
要替换已有触发器的当前定义，使用CREATE OR REPLACE TRIGGER，指定已有触发器的名称和父表。
所有其他的属性会被替换。
该触发器可以被指定为在一行上尝试该操作之前触发（在约束被检查并且INSERT、UPDATE或者DELETE被尝试之前）；也可以在该操作完成之后触发（在约束被检查并且INSERT、UPDATE或者DELETE完成之后）；或者取代该操作（在对一个视图插入、更新或删除的情况中）。如果该触发器在事件之前触发或者取代事件，该触发器可以跳过对当前行的操作或者改变正在被插入的行（只对INSERT以及UPDATE操作）。如果该触发器在事件之后触发，所有更改（包括其他触发器的效果）对该触发器“可见”。
一个被标记为FOR EACH ROW的触发器会对该操作修改的每一行都调用一次。例如，一个影响 10 行的DELETE将导致在目标关系上的任何ON DELETE触发器被独立调用 10 次，也就是为每一个被删除的行调用一次。与此相反，一个被标记为FOR EACH STATEMENT的触发器只会为任何给定的操作执行一次，不管该操作修改多少行（特别地，一个修改零行的操作将仍会导致任何可用的FOR EACH STATEMENT触发器被执行）。
被指定为要触发INSTEAD OF触发器事件的触发器必须被标记为FOR EACH ROW，并且只能被定义在视图上。BEFORE和AFTER触发器必须被标记为FOR EACH STATEMENT。
此外，触发器可以被定义为触发TRUNCATE，但只能是FOR EACH STATEMENT。
下面的表格总结了哪些触发器类型可以被用在表、视图和外部表上：
何时事件行级语句级BEFOREINSERT/UPDATE/DELETE表和外部表表、视图和外部表TRUNCATE—表和外部表AFTERINSERT/UPDATE/DELETE表和外部表表、视图和外部表TRUNCATE—表和外部表INSTEAD OFINSERT/UPDATE/DELETE视图—TRUNCATE——
还有，一个触发器定义可以指定一个布尔的WHEN条件，它将被测试来看看该触发器是否应该被触发。在行级触发器中，WHEN条件可以检查该行的列的新旧值。语句级触发器也可以有WHEN条件，尽管该特性对于它们不是很有用（因为条件不能引用表中的任何值）。
如果有多个同种触发器被定义为相同事件触发，它们将按照名称的字母顺序被触发。
当指定CONSTRAINT选项时，此命令将创建一个约束触发器。
这与常规触发器相同，只是触发器触发的时机可以使用SET CONSTRAINTS进行调整。
约束触发器必须是普通表（而非外部表）上的AFTER ROW触发器。
它们可以在引发触发事件的语句结束时触发，也可以在包含事务结束时触发；在后一种情况下，它们被称为延迟触发器。
通过使用SET CONSTRAINTS，也可以强制触发挂起的延迟触发器立即发生。
预期约束触发器在违反其实施的约束时引发异常。
REFERENCING 选项启用对 过渡关系 的收集，
这些关系是包含当前 SQL 语句插入、删除或修改的所有行的行集。
此功能使触发器能够看到语句所做的全局视图，而不仅仅是一行。
此选项仅允许用于普通表上的 AFTER 触发器（而不是外部表）。
触发器不应是约束触发器。此外，如果触发器是 UPDATE 触发器，
则在使用此选项时不得指定 column_name 列表。
OLD TABLE 只能指定一次，并且仅适用于可以在 UPDATE
或 DELETE 上触发的触发器；它创建一个包含语句更新或删除的所有行的
before-images 的过渡关系。
类似地，NEW TABLE 只能指定一次，并且仅适用于可以在
UPDATE 或 INSERT 上触发的触发器；
它创建一个包含语句更新或插入的所有行的 after-images 的过渡关系。
SELECT不修改任何行，因此你无法创建SELECT触发器。规则和视图可以为需要SELECT触发器的问题提供可行的解决方案。
请参阅第 37 章以获取有关触发器的更多信息。
参数name
给新触发器的名称。这必须与同一个表上的任何其他触发器相区别。
名称不能是模式限定的 — 该触发器会继承它所在表的模式。
对于一个约束触发器，这也是使用SET CONSTRAINTS修改触发器行为时要用到的名称。
BEFOREAFTERINSTEAD OF
决定该函数是要在事件之前、之后被调用还是会取代该事件。
一个约束触发器只能被指定为AFTER。
event
INSERT、UPDATE、DELETE或TRUNCATE之一，
这指定了将要引发该触发器的事件。多个事件可以用OR指定，
但在请求传递关系时除外。
对于UPDATE事件，可以使用下面的语法指定一个列的列表：
UPDATE OF column_name1 [, column_name2 ... ]
只有当至少一个被列出的列出现在UPDATE命令的目标中时，
或者如果列出的列之一是生成的列且依赖于UPDATE的目标，该触发器才会触发。
INSTEAD OF UPDATE事件不允许列的列表。
在请求传递关系时，也不能指定列的列表。
table_name
要使用该触发器的表、视图或外部表的名称（可选地是模式限定的）。
referenced_table_name
约束引用的另一个表的名称（可能是模式限定的）。这个选项用于外键约束，并且不推荐用于一般的用途。这只能为约束触发器指定。
DEFERRABLENOT DEFERRABLEINITIALLY IMMEDIATEINITIALLY DEFERRED
该触发器的默认时机。有关这些约束选项的详细信息，请参见CREATE TABLE文档。这只能为约束触发器指定。
REFERENCING
这个关键词紧接在一个或两个关系名的声明之前，这些关系提供对触发语句的过渡关系的访问。
OLD TABLENEW TABLE
这个子句指示接下来的关系名是用于前映像过渡关系还是后映像过渡关系。
transition_relation_name
在该触发器中这个过渡关系要使用的（未限定）名称。
FOR EACH ROWFOR EACH STATEMENT
这指定该触发器函数是应该为该触发器事件影响的每一行被引发一次，还是只为每个 SQL 语句被引发一次。如果都没有被指定，FOR EACH STATEMENT会是默认值。约束触发器只能被指定为FOR EACH ROW。
condition
一个决定该触发器函数是否将被实际执行的布尔表达式。如果指定了WHEN，只有condition返回true时才会调用该函数。在FOR EACH ROW触发器中，WHEN条件可以分别写OLD.column_name或者NEW.column_name来引用列的新旧行值。当然，INSERT触发器不能引用OLD，而DELETE触发器不能引用NEW。
INSTEAD OF触发器不支持WHEN条件。
当前，WHEN 表达式不能包含子查询。
注意对于约束触发器，WHEN 条件的计算不会被延迟，而是直接在行更新操作被执行之后立刻发生。如果该条件计算得不到真，那么该触发器就不会被放在延迟执行的队列中。
function_name
一个用户提供的函数，它被声明为不带参数并且返回类型 trigger，当触发器引发时会执行该函数。
在 CREATE TRIGGER 的语法中，关键词 FUNCTION 和 PROCEDURE 是等效的，但是任何情况下被引用的函数必须是一个函数而不是过程。这里，关键词 PROCEDURE 的使用是有历史原因的并且已经被废弃。
arguments
一个可选的逗号分隔的参数列表，它在该触发器被执行时会被提供给该函数。参数是字符串常量。简单的名称和数字常量也可以被写在这里，但是它们将全部被转换成字符串。请检查该触发器函数的实现语言的描述来找出在函数内部如何访问这些参数，这可能与普通函数参数不同。
注释
要在一个表上创建或替换一个触发器，用户必须具有该表上的 TRIGGER 特权。用户还必须具有在触发器函数上的 EXECUTE 特权。
使用 DROP TRIGGER 移除一个触发器。
在分区表上创建行级触发器将导致在每个它的已有分区上创建相同的“clone”触发器；以后创建或附加的任何分区也将具有相同的触发器。
如果子分区上已经有冲突命名的触发器，则会发生错误，除非使用CREATE OR REPLACE
TRIGGER，在这种情况下，该触发器将由一个克隆触发器替换。
当一个分区从其父分区脱离时，它的克隆触发器将被删除。
当一个列相关的触发器（使用UPDATE OF column_name语法定义的触发器）的列被列为UPDATE命令的SET列表目标时，它会被触发。即便该触发器没有被引发，一个列的值也可能改变，因为BEFORE UPDATE触发器对行内容所作的改变不会被考虑。相反，一个诸如UPDATE ... SET x = x ...的命令将引发一个位于列x上的触发器，即便该列的值没有改变。
在一个BEFORE触发器中，WHEN条件正好在函数被或者将被执行之前被计算，因此使用WHEN与在触发器函数的开始测试同一个条件没有实质上的区别。特别注意该条件看到的NEW行是当前值，虽然可能已被早前的触发器所修改。还有，一个BEFORE触发器的WHEN条件不允许检查NEW行的系统列（例如ctid），因为那些列还没有被设置。
在一个AFTER触发器中，WHEN条件正好在行更新发生之后被计算，并且它决定一个事件是否要被放入队列以便在语句的末尾引发该触发器。因此当一个AFTER触发器的WHEN条件不返回真时，没有必要把一个事件放入队列或者在语句末尾重新取得该行。如果触发器只需要为一些行被引发，就能够显著地加快修改很多行的语句的速度。
在一些情况下，单一的SQL命令可能会引发多种触发器。例如，一个带有ON CONFLICT DO UPDATE子句的INSERT可能同时导致插入和更新操作，因此它将根据需要引发这两种触发器。提供给触发器的传递关系与它们的事件类型有关，因此INSERT触发器将只看到被插入的行，而UPDATE触发器将只看到被更新的行。
由外键强制动作导致的行更新或删除（例如ON UPDATE CASCADE或ON DELETE SET NULL）被当做导致它们的SQL命令的一部分（注意这些动作从不被延迟）。受影响的表上的相关触发器将被引发，这样就提供了另一种方法让SQL命令引发不直接匹配其类型的触发器。在简单的情况中，请求传递关系的触发器将在一个传递关系中看到由原始SQL命令在其表中做出的所有改变。不过，有些情况中一个请求传递关系的AFTER ROW触发器的存在将导致由单个SQL命令触发的外键强制动作被分成多步，每一步都有其自己的传递关系。在这种情况下，创建一个传递关系集合时都会引发存在的所有语句级触发器，确保那些触发器能够在一个传递关系中看到每个受影响的行一次，并且只看到一次。
只有当视图上的动作被一个行级INSTEAD OF触发器处理时才会引发视图上的语句级触发器。如果动作被一个INSTEAD规则处理，那么该语句发出的任何语句都会代替提及该视图的原始语句执行，这样将被引发的触发器是替换语句中提及的表上的那些触发器。类似地，如果视图是自动可更新的，则该动作将被处理为把该语句自动重写成在视图基表上的一个动作，这样基表的语句级触发器就是要被引发的。
修改分区表或者带有继承子表的表会引发挂接到显式提及表的语句级触发器，但不会引发其分区或子表的语句级触发器。
相反，行级触发器会在受影响的分区或子表上引发，即便它们在查询中没有被明确提及。
如果一个语句级触发器用REFERENCING子句定义有传递关系，则来自所有受影响分区或子表中的行的前后映像都是可见的。
在继承子表的情况中，行映像仅包括该触发器所附属的表中存在的列。
当前，有过渡关系的行级触发器不能在分区或继承的子表上定义。
此外，分区表上的触发器不能是INSTEAD OF。
当前，OR REPLACE选项不支持约束触发器。
不建议在已经对触发器的表执行过更新操作的事务中替换已有的触发器。
触发器触发决策，或部分触发决策，已经做出的将不会被重新考虑，所以效果可能会令人惊讶。
有少量内置触发器函数可以用于解决常见问题而无需编写自己的触发器代码；参见第 9.29 节。
示例
只要表accounts的一行即将要被更新时会执行函数check_account_update：
CREATE TRIGGER check_update
BEFORE UPDATE ON accounts
FOR EACH ROW
EXECUTE FUNCTION check_account_update();
修改该触发器定义，使其仅在UPDATE命令中将balance列指定为目标时执行函数：
CREATE OR REPLACE TRIGGER check_update
BEFORE UPDATE OF balance ON accounts
FOR EACH ROW
EXECUTE FUNCTION check_account_update();
这种形式只有列balance确实改变值时才执行该函数：
CREATE TRIGGER check_update
BEFORE UPDATE ON accounts
FOR EACH ROW
WHEN (OLD.balance IS DISTINCT FROM NEW.balance)
EXECUTE FUNCTION check_account_update();
调用一个函数来记录accounts的更新，但是只在有变化时才调用：
CREATE TRIGGER log_update
AFTER UPDATE ON accounts
FOR EACH ROW
WHEN (OLD.* IS DISTINCT FROM NEW.*)
EXECUTE FUNCTION log_account_update();
为每一个要插入到视图底层表中的行执行函数view_insert_row：
CREATE TRIGGER view_insert
INSTEAD OF INSERT ON my_view
FOR EACH ROW
EXECUTE FUNCTION view_insert_row();
为每个语句执行函数check_transfer_balances_to_zero以确认transfer的行净值为零：
CREATE TRIGGER transfer_insert
AFTER INSERT ON transfer
REFERENCING NEW TABLE AS inserted
FOR EACH STATEMENT
EXECUTE FUNCTION check_transfer_balances_to_zero();
为每一行执行函数check_matching_pairs以确认（同一个语句）同时对匹配对做了更改：
CREATE TRIGGER paired_items_update
AFTER UPDATE ON paired_items
REFERENCING NEW TABLE AS newtab OLD TABLE AS oldtab
FOR EACH ROW
EXECUTE FUNCTION check_matching_pairs();
第 37.4 节包含一个用C编写的触发器函数的完整示例。
兼容性
PostgreSQL中的CREATE TRIGGER语句实现了SQL标准的一个子集。目前缺少下列功能：
虽然AFTER触发器的过渡表名是以标准的方式用REFERENCING子句指定，但REFERENCING子句中不能指定FOR EACH ROW触发器中用到的行变量。它们以依赖于编写该触发器函数的语言的方式可用，但是对任意一种语言来说是固定的。一些语言实际上的行为就像有包含OLD ROW AS OLD NEW ROW AS NEW的REFERENCING子句存在一样。
标准允许把过渡表与和列相关的UPDATE触发器一起使用，那么应该在过渡表中可见的行集合取决于该触发器的列列表。当前PostgreSQL没有实现这一点。
PostgreSQL只允许为被触发动作执行一个用户定义的函数。标准允许执行许多其他的 SQL 命令作为被触发的动作，例如CREATE TABLE。这种限制可以很容易地通过创建一个执行想要的命令的用户定义函数来绕过。
SQL 指定多个触发器应该以被创建时间的顺序触发。PostgreSQL则使用名称顺序，这被认为更加方便。
SQL 指定级联删除上的BEFORE DELETE触发器在级联的DELETE完成之后引发。PostgreSQL的行为则是BEFORE DELETE总是在删除动作之前引发，即使是一个级联删除。这被认为更加一致。如果BEFORE触发器修改行或者在引用动作引起的更新期间阻止更新，这也是非标准行为。这能导致约束违背或者被存储的数据不遵从引用约束。
使用OR为一个单一触发器指定多个动作的能力是PostgreSQL对 SQL 标准的扩展。
为TRUNCATE引发触发器的能力是PostgreSQL对 SQL 标准的扩展，在视图上定义语句级触发器的能力也是一样。
CREATE CONSTRAINT TRIGGER是SQL标准的一个PostgreSQL扩展。
OR REPLACE选项也是如此。
参见ALTER TRIGGER, DROP TRIGGER, CREATE FUNCTION, SET CONSTRAINTS上一页 上一级 下一页CREATE TRANSFORM 起始页 CREATE TYPE
