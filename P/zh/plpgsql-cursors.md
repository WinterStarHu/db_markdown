# 41.7. 游标

41.7. 游标
版本：
纠错本页面
搜索
目录导航
❮
❯
41.7. 游标 #41.7.1. 声明游标变量41.7.2. 打开游标41.7.3. 使用游标41.7.4. 通过游标的结果循环
和一次执行整个查询不同，可以建立一个游标来封装该查询，并且接着一次读取该查询结果的一些行。这样做的原因之一是在结果中包含大量行时避免内存不足（不过，PL/pgSQL用户通常不需要担心这些，因为FOR循环在内部会自动使用一个游标来避免内存问题）。一种更有趣的用法是返回一个函数已经创建的游标的引用，允许调用者读取行。这提供了一种有效的方法从函数中返回大型行集。
41.7.1. 声明游标变量 #
所有在PL/pgSQL中对游标的访问都会通过游标变量，它总是特殊的数据类型refcursor。创建游标变量的一种方法是把它声明为一个类型为refcursor的变量。另外一种方法是使用游标声明语法，通常是：
name [ [ NO ] SCROLL ] CURSOR [ ( arguments ) ] FOR query;
（为了对Oracle的兼容性，可以用IS替代FOR）。如果指定了SCROLL，那么游标可以反向滚动；如果指定了NO SCROLL，那么反向取的动作会被拒绝；如果二者都没有被指定，那么能否进行反向取就取决于查询。如果指定了arguments， 那么它是一个逗号分隔的name datatype对的列表， 它们定义在给定查询中要被参数值替换的名称。实际用于替换这些名字的值将在游标被打开之后指定。
一些例子：
DECLARE
curs1 refcursor;
curs2 CURSOR FOR SELECT * FROM tenk1;
curs3 CURSOR (key integer) FOR SELECT * FROM tenk1 WHERE unique1 = key;
所有这三个变量都是refcursor类型，但是第一个可以用于任何查询，而第二个已经被绑定了一个完全指定的查询，并且最后一个被绑定了一个参数化查询。（游标被打开时，key将被一个整数参数值替换）。变量curs1被称为未绑定，因为它没有被绑定到任何特定查询。
当游标的查询使用FOR UPDATE/SHARE时，不能使用SCROLL选项。此外，最好在涉及可变函数的查询中使用NO SCROLL。SCROLL的实现假定重新读取查询的输出将返回一致的结果，而易失性函数可能无法做到这一点。
41.7.2. 打开游标 #
在使用游标检索行之前，必须先打开它。（这相当于 SQL
命令DECLARE
CURSOR的操作。）
PL/pgSQL有三种形式的OPEN
语句，其中两种使用未绑定的游标变量，而第三种使用绑定的游标变量。
注意
绑定的游标变量也可以在不显式打开游标的情况下使用，
通过FOR语句，如
第 41.7.4 节中所述。
一个FOR循环会打开游标，
并在循环完成时再次关闭它。
打开游标涉及创建一个名为门户的服务器内部数据结构，
它保存游标查询的执行状态。门户有一个名称，在门户存在期间，该名称在会话中
必须是唯一的。默认情况下，PL/pgSQL会为它创建的
每个门户分配一个唯一的名称。然而，如果您为游标变量分配一个非空字符串值，
该字符串将被用作其门户名称。可以按照
第 41.7.3.5 节中描述的方式使用此功能。
41.7.2.1. OPEN FOR query #
OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR query;
该游标变量被打开并且被给定要执行的查询。游标不能是已经打开的，并且它必须已经被声明为一个未绑定的游标变量（也就是声明为一个简单的refcursor变量）。该查询必须是一条SELECT或者其他返回行的东西（例如EXPLAIN）。该查询会按照其他PL/pgSQL中的 SQL 命令同等的方式对待：先代换PL/pgSQL变量名，并且执行计划会被缓存用于可能的重用。当一个PL/pgSQL变量被替换到游标查询中时，替换的值是在OPEN时它所具有的值。对该变量后续的改变不会影响游标的行为。对于一个已经绑定的游标，SCROLL和NO SCROLL选项具有相同的含义。
一个例子：
OPEN curs1 FOR SELECT * FROM foo WHERE key = mykey;
41.7.2.2. OPEN FOR EXECUTE #
OPEN unbound_cursorvar [ [ NO ] SCROLL ] FOR EXECUTE query_string
[ USING expression [, ... ] ];
打开游标变量并且执行指定的查询。该游标不能是已打开的，并且必须已经被声明为一个未绑定的游标变量（也就是声明为一个简单的refcursor变量）。该查询以和EXECUTE中相同的方式被指定为一个字符串表达式。照例，这提供了灵活性，因此查询计划可以在两次运行之间变化（见第 41.11.2 节），并且它也意味着在该命令字符串上还没有完成变量替换。正如EXECUTE，可以通过format()和USING将参数值插入到动态命令中。SCROLL和NO SCROLL选项具有和已绑定游标相同的含义。
一个例子：
OPEN curs1 FOR EXECUTE format('SELECT * FROM %I WHERE col1 = $1',tabname) USING keyvalue;
在这个例子中，表名被通过format()插入到查询中。
col1的比较值被通过一个USING参数插入，
所以它不需要引用。
41.7.2.3. 打开一个已绑定的游标 #
OPEN bound_cursorvar [ ( [ argument_name { := | => } ] argument_value [, ...] ) ];
这种形式的OPEN被用于打开一个游标变量，它的查询是在声明时绑定的。该游标不能是已经打开的。当且仅当该游标被声明为接收参数时，才必须出现一个实际参数值表达式的列表。这些值将被替换到查询中。
一个已绑定游标的查询计划总是被认为是可缓存的，在这种情况下没有EXECUTE的等效形式。注意SCROLL和NO SCROLL不能在OPEN中指定，因为游标的滚动行为已经被确定。
参数值可以使用 位置
或 命名 语法传递。在位置
语法中，所有参数按顺序指定。在命名语法中，
每个参数的名称使用 :=
或 => 来
与参数表达式分隔。与调用
函数类似，描述在 第 4.3 节 中，
也允许混合使用位置和命名语法。
示例（这些使用上面的游标声明示例）：
OPEN curs2;
OPEN curs3(42);
OPEN curs3(key := 42);
OPEN curs3(key => 42);
因为在一个已绑定游标的查询上已经完成了变量替换，实际有两种方式将值传到游标中：给OPEN一个显式参数，或者在查询中隐式引用一个PL/pgSQL变量。不过，只有在已绑定游标之前声明的变量才将会被替换到游标中。在两种情况下，要被传递的值都是在OPEN时确定的。例如，得到上例中curs3相同效果的另一种方式是
DECLARE
key integer;
curs4 CURSOR FOR SELECT * FROM tenk1 WHERE unique1 = key;
BEGIN
key := 42;
OPEN curs4;
41.7.3. 使用游标 #
一旦一个游标已经被打开，那么就可以用这里描述的语句操作它。
这些操作不需要在打开游标的同一个函数中进行。您可以返回一个
refcursor值，并让调用者操作该游标。
（在内部，refcursor值只是包含游标活动查询的门户的字符串
名称。这个名称可以被传递、分配给其他refcursor变量，
等等，而不会影响门户。）
所有门户会在事务的结尾被隐式地关闭。因此一个refcursor值只能在该事务结束前用于引用一个打开的游标。
41.7.3.1. FETCH #
FETCH [ direction { FROM | IN } ] cursor INTO target;
FETCH从游标中（按照指定的方向）检索下一行到目标中，
目标可以是一个行变量、一个记录变量，或者一个用逗号分隔的简单变量列表，
就像SELECT INTO一样。如果没有合适的行，目标将被设置为
NULL(s)。与SELECT INTO一样，可以检查特殊变量
FOUND以查看是否获取到了一行。如果没有获取到行，
游标将根据移动方向定位到最后一行之后或第一行之前。
direction子句可以是 SQL FETCH命令中允许的任何变体，除了那些能够取得多于一行的。即它可以是
NEXT、
PRIOR、
FIRST、
LAST、
ABSOLUTE count、
RELATIVE count、
FORWARD或者
BACKWARD。
省略direction和指定NEXT是一样的。在使用count的形式中，count可以是任意的整数值表达式（与SQL命令FETCH不一样，FETCH仅允许整数常量）。除非游标被使用SCROLL选项声明或打开，否则要求反向移动的direction值很可能会失败。
cursor必须是一个引用已打开游标门户的refcursor变量名。
示例：
FETCH curs1 INTO rowvar;
FETCH curs2 INTO foo, bar, baz;
FETCH LAST FROM curs3 INTO x, y;
FETCH RELATIVE -2 FROM curs4 INTO x;
41.7.3.2. MOVE #
MOVE [ direction { FROM | IN } ] cursor;
MOVE重新定位光标而不检索任何数据。 MOVE的工作方式类似于
FETCH命令，只是它仅重新定位光标而不返回移动到的行。
direction子句可以是SQL FETCH
命令中允许的任何变体，包括那些可以获取多行的变体；光标将定位到最后一行。
（然而，在PL/pgSQL中，direction子句仅为
count表达式且没有关键字的情况已被弃用。
该语法与完全省略direction子句的情况是模糊的，
因此如果count不是常量，可能会失败。）
与SELECT INTO一样，可以检查特殊变量FOUND以查看是否有行可以移动到。
如果没有这样的行，光标将根据移动方向定位到最后一行之后或第一行之前。
示例：
MOVE curs1;
MOVE LAST FROM curs3;
MOVE RELATIVE -2 FROM curs4;
MOVE FORWARD 2 FROM curs4;
41.7.3.3. UPDATE/DELETE WHERE CURRENT OF #
UPDATE table SET ... WHERE CURRENT OF cursor;
DELETE FROM table WHERE CURRENT OF cursor;
当一个游标被定位到一个表行上时，使用该游标标识该行就可以对它进行更新或删除。
对于游标的查询可以是什么是有限制的（尤其是不能有分组），并且最好在游标中使用FOR UPDATE。
详见DECLARE参考页。
一个例子：
UPDATE foo SET dataval = myval WHERE CURRENT OF curs1;
41.7.3.4. CLOSE #
CLOSE cursor;
CLOSE关闭一个已打开游标的底层入口。这样就可以在事务结束之前释放资源，或者释放掉该游标变量以便再次打开。
一个例子：
CLOSE curs1;
41.7.3.5. 返回游标 #
PL/pgSQL函数可以向调用者返回游标。这对于返回多行或多列，特别是巨大的结果集很有用。要想这么做，该函数打开游标并且把该游标的名字返回给调用者（或者简单地使用调用者指定的或已知的入口名打开游标）。调用者接着可以从游标中取得行。游标可以由调用者关闭，或者是在事务关闭时自行关闭。
游标使用的门户名称可以由程序员指定，也可以自动生成。要指定门户名称，只需在打开游标之前将一个字符串分配给refcursor变量。refcursor变量的字符串值将被OPEN用作底层门户的名称。然而，如果refcursor变量的值为null（默认情况下会是null），那么OPEN会自动生成一个不会与任何现有门户冲突的名称，并将其分配给refcursor变量。
注意
在 PostgreSQL 16 之前，绑定的游标变量会被初始化为包含它们自己的名称，而不是被设置为 null，这样底层的门户名称默认会与游标变量的名称相同。此行为被更改，因为它在不同函数中具有相似名称的游标之间可能导致过多的冲突风险。
下面的例子显示了一个调用者提供游标名字的方法：
CREATE TABLE test (col text);
INSERT INTO test VALUES ('123');
CREATE FUNCTION reffunc(refcursor) RETURNS refcursor AS '
BEGIN
OPEN $1 FOR SELECT col FROM test;
RETURN $1;
END;
' LANGUAGE plpgsql;
BEGIN;
SELECT reffunc('funccursor');
FETCH ALL IN funccursor;
COMMIT;
下面的例子使用了自动游标名生成：
CREATE FUNCTION reffunc2() RETURNS refcursor AS '
DECLARE
ref refcursor;
BEGIN
OPEN ref FOR SELECT col FROM test;
RETURN ref;
END;
' LANGUAGE plpgsql;
-- 需要在一个事务中使用游标。
BEGIN;
SELECT reffunc2();
reffunc2
--------------------
<unnamed cursor 1>
(1 row)
FETCH ALL IN "<unnamed cursor 1>";
COMMIT;
下面的例子展示了从一个函数中返回多个游标的一种方法：
CREATE FUNCTION myfunc(refcursor, refcursor) RETURNS SETOF refcursor AS $$
BEGIN
OPEN $1 FOR SELECT * FROM table_1;
RETURN NEXT $1;
OPEN $2 FOR SELECT * FROM table_2;
RETURN NEXT $2;
END;
$$ LANGUAGE plpgsql;
-- 需要在一个事务中使用游标。
BEGIN;
SELECT * FROM myfunc('a', 'b');
FETCH ALL FROM a;
FETCH ALL FROM b;
COMMIT;
41.7.4. 通过游标的结果循环 #
有一种 FOR 语句的变体，允许
迭代游标返回的行。语法为：
[ <<label>> ]
FOR recordvar IN bound_cursorvar [ ( [ argument_name { := | => } ] argument_value [, ...] ) ] LOOP
statements
END LOOP [ label ];
游标变量在声明时必须绑定到某个查询，并且它 不能 已经打开。
FOR 语句会自动打开游标，并在循环退出时关闭游标。
如果游标被声明为接受参数，则必须出现实际参数值表达式的列表。
这些值将在查询中替换，就像在 OPEN 时一样（见 第 41.7.2.3 节）。
变量recordvar会被自动定义为record类型，并且只存在于循环内部（循环中该变量名任何已有定义都会被忽略）。每一个由游标返回的行都会被陆续地赋值给这个记录变量并且执行循环体。
上一页 上一级 下一页41.6. 控制结构 起始页 41.8. 事务管理
