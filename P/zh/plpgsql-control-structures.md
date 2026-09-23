# 41.6. 控制结构

41.6. 控制结构
版本：
纠错本页面
搜索
目录导航
❮
❯
41.6. 控制结构 #41.6.1. 从函数返回41.6.2. 从过程返回41.6.3. 调用存储过程41.6.4. 条件41.6.5. 简单循环41.6.6. 通过查询结果循环41.6.7. 循环通过数组41.6.8. 捕获错误41.6.9. 获取执行位置信息
控制结构可能是PL/pgSQL中最有用的（以及最重要）的部分。利用PL/pgSQL的控制结构，你可以以非常灵活而且强大的方式操纵PostgreSQL的数据。
41.6.1. 从函数返回 #
有两个命令让你能够从函数中返回数据：RETURN和RETURN NEXT。
41.6.1.1. RETURN #
RETURN expression;
带有一个表达式的RETURN用于终止函数并把expression的值返回给调用者。这种形式被用于不返回集合的PL/pgSQL函数。
如果一个函数返回一个标量类型，表达式的结果将被自动转换成函数的返回类型。但是要返回一个复合（行）值，你必须写一个正好产生所需列集合的表达式。这可能需要使用显式转换。
如果你声明带输出参数的函数，那么就只需要写不带表达式的RETURN。输出参数变量的当前值将被返回。
如果你声明函数返回void，一个RETURN语句可以用来提前退出函数；但是不要在RETURN后面写一个表达式。
一个函数的返回值不能是未定义。如果控制到达了函数最顶层的块而没有碰到一个RETURN语句，那么会发生一个运行时错误。不过，这个限制不适用于带输出参数的函数以及返回void的函数。在这些情况下，如果顶层的块结束，将自动执行一个RETURN语句。
一些例子：
-- 返回一个标量类型的函数
RETURN 1 + 2;
RETURN scalar_var;
-- 返回一个组合类型的函数
RETURN composite_type_var;
RETURN (1, 2, 'three'::text);  -- 必须将列转换为正确的类型
41.6.1.2. RETURN NEXT和RETURN QUERY #
RETURN NEXT expression;
RETURN QUERY query;
RETURN QUERY EXECUTE command-string [ USING expression [, ... ] ];
当一个PL/pgSQL函数被声明为返回SETOF sometype，那么遵循的过程则略有不同。在这种情况下，要返回的个体项被用一系列RETURN NEXT或RETURN QUERY命令指定，并且接着会用一个不带参数的最终RETURN命令来指示这个函数已经完成执行。RETURN NEXT可以用于标量和复合数据类型；对于复合结果类型，将返回一个完整的“表”。RETURN QUERY将执行查询的结果追加到函数的结果集中。在一个单一的返回集合的函数中，RETURN NEXT和RETURN QUERY可以自由混合，这样它们的结果将被串接起来。
RETURN NEXT和RETURN QUERY实际上不会从函数中返回 — 它们简单地向函数的结果集中追加零或多行。然后会继续执行PL/pgSQL函数中的下一条语句。随着后继的RETURN NEXT和RETURN QUERY命令的执行，结果集就建立起来了。最后一个RETURN（应该没有参数）会导致控制退出该函数（或者你可以让控制到达函数的结尾）。
RETURN QUERY有一种变体RETURN QUERY EXECUTE，它可以动态指定要被执行的查询。可以通过USING向计算出的查询字符串插入参数表达式，这和在EXECUTE命令中的方式相同。
如果你声明函数带有输出参数，只需要写不带表达式的RETURN NEXT。在每一次执行时，输出参数变量的当前值将被保存下来用于最终返回为结果的一行。注意为了创建一个带有输出参数的集合返回函数，在有多个输出参数时，你必须声明函数为返回SETOF record；或者如果只有一个类型为sometype的输出参数时，声明函数为SETOF sometype。
下面是一个使用RETURN NEXT的函数例子：
CREATE TABLE foo (fooid INT, foosubid INT, fooname TEXT);
INSERT INTO foo VALUES (1, 2, 'three');
INSERT INTO foo VALUES (4, 5, 'six');
CREATE OR REPLACE FUNCTION get_all_foo() RETURNS SETOF foo AS
$BODY$
DECLARE
r foo%rowtype;
BEGIN
FOR r IN
SELECT * FROM foo WHERE fooid > 0
LOOP
-- 这里可以做一些处理
RETURN NEXT r; -- 返回当前行的 SELECT
END LOOP;
RETURN;
END;
$BODY$
LANGUAGE plpgsql;
SELECT * FROM get_all_foo();
这里是一个使用RETURN QUERY的函数的例子：
CREATE FUNCTION get_available_flightid(date) RETURNS SETOF integer AS
$BODY$
BEGIN
RETURN QUERY SELECT flightid
FROM flight
WHERE flightdate >= $1
AND flightdate < ($1 + 1);
-- 因为执行还未结束，我们可以检查是否有行被返回
-- 如果没有就抛出异常。
IF NOT FOUND THEN
RAISE EXCEPTION 'No flight at %.', $1;
END IF;
RETURN;
END;
$BODY$
LANGUAGE plpgsql;
-- 返回可用的航班或者在没有可用航班时抛出异常。
SELECT * FROM get_available_flightid(CURRENT_DATE);
注意
如上所述，目前RETURN NEXT和RETURN QUERY的实现在从函数返回之前会把整个结果集都保存起来。这意味着如果一个PL/pgSQL函数生成一个非常大的结果集，性能可能会很差：数据将被写到磁盘上以避免内存耗尽，但是函数本身在整个结果集都生成之前不会退出。将来的PL/pgSQL版本可能会允许用户定义没有这种限制的集合返回函数。目前，数据开始被写入到磁盘的时机由配置变量work_mem控制。拥有足够内存来存储大型结果集的管理员可以考虑增大这个参数。
41.6.2. 从过程返回 #
过程没有返回值。因此，过程的结束可以不用RETURN语句。
如果想用一个RETURN语句提前退出代码，只需写一个没有表达式的RETURN。
如果过程有输出参数，那么输出参数最终的值将被返回给调用者。
41.6.3. 调用存储过程 #
PL/pgSQL函数，存储过程或DO块可以使用
CALL调用存储过程。输出参数的处理方式与纯SQL中CALL的工作方式不同。
存储过程的每个OUT 或者 INOUT参数必须和CALL语句中的变量对应，
并且无论存储过程返回什么，都会在返回后赋值给该变量。
例如：
CREATE PROCEDURE triple(INOUT x int)
LANGUAGE plpgsql
AS $$
BEGIN
x := x * 3;
END;
$$;
DO $$
DECLARE myvar int := 5;
BEGIN
CALL triple(myvar);
RAISE NOTICE 'myvar = %', myvar;  -- prints 15
END;
$$;
与输出参数相对应的变量可以是一个简单的变量或一个组合型变量的字段。 目前，它不能是一个数组的元素。
41.6.4. 条件 #
IF和CASE语句让你可以根据某种条件执行二选其一的命令。PL/pgSQL有三种形式的IF：
IF ... THEN ... END IFIF ... THEN ... ELSE ... END IFIF ... THEN ... ELSIF ... THEN ... ELSE ... END IF
以及两种形式的CASE：
CASE ... WHEN ... THEN ... ELSE ... END CASECASE WHEN ... THEN ... ELSE ... END CASE
41.6.4.1. IF-THEN #
IF boolean-expression THEN
statements
END IF;
IF-THEN语句是IF的最简单形式。 如果条件为真，在THEN和END IF之间的语句将被执行。否则，将被跳过。
例子：
IF v_user_id <> 0 THEN
UPDATE users SET email = v_email WHERE user_id = v_user_id;
END IF;
41.6.4.2. IF-THEN-ELSE #
IF boolean-expression THEN
statements
ELSE
statements
END IF;
IF-THEN-ELSE语句对IF-THEN进行了增加，它让你能够指定一组在条件不为真时应该被执行的语句（注意这也包括条件评估为 NULL 的情况）。
例子：
IF parentid IS NULL OR parentid = ''
THEN
RETURN fullname;
ELSE
RETURN hp_true_filename(parentid) || '/' || fullname;
END IF;
IF v_count > 0 THEN
INSERT INTO users_count (count) VALUES (v_count);
RETURN 't';
ELSE
RETURN 'f';
END IF;
41.6.4.3. IF-THEN-ELSIF #
IF boolean-expression THEN
statements
[ ELSIF boolean-expression THEN
statements
[ ELSIF boolean-expression THEN
statements
...
]
]
[ ELSE
statements ]
END IF;
有时会有多于两种选择。IF-THEN-ELSIF提供了一个简便的方法来检查多个条件。IF条件会被一个接一个测试，直到找到第一个为真的。然后执行相关语句，然后控制会被交给END IF之后的下一个语句（后续的任何IF条件不会被测试）。如果没有一个IF条件为真，那么ELSE块（如果有）将被执行。
这里有一个例子：
IF number = 0 THEN
result := 'zero';
ELSIF number > 0 THEN
result := 'positive';
ELSIF number < 0 THEN
result := 'negative';
ELSE
-- 嗯，唯一的其他可能性是数字为空
result := 'NULL';
END IF;
关键词ELSIF也可以被拼写成ELSEIF。
另一个可以完成相同任务的方法是嵌套IF-THEN-ELSE语句，如下例：
IF demo_row.sex = 'm' THEN
pretty_sex := 'man';
ELSE
IF demo_row.sex = 'f' THEN
pretty_sex := 'woman';
END IF;
END IF;
不过，这种方法需要为每个IF都写一个匹配的END IF，因此当有很多选择时，这种方法比使用ELSIF要麻烦得多。
41.6.4.4. 简单CASE #
CASE search-expression
WHEN expression [, expression [ ... ]] THEN
statements
[ WHEN expression [, expression [ ... ]] THEN
statements
... ]
[ ELSE
statements ]
END CASE;
CASE的简单形式提供了基于操作数等值判断的有条件执行。search-expression会被计算（一次）并且一个接一个地与WHEN子句中的每个expression比较。如果找到一个匹配，那么相应的statements会被执行，并且接着控制会传递给END CASE之后的下一个语句（后续的WHEN表达式不会被计算）。如果没有找到匹配，ELSE statements会被执行。但是如果ELSE不存在，将会抛出一个CASE_NOT_FOUND异常。
这里是一个简单的例子：
CASE x
WHEN 1, 2 THEN
msg := 'one or two';
ELSE
msg := 'other value than one or two';
END CASE;
41.6.4.5. 搜索CASE #
CASE
WHEN boolean-expression THEN
statements
[ WHEN boolean-expression THEN
statements
... ]
[ ELSE
statements ]
END CASE;
CASE的搜索形式基于布尔表达式真假的有条件执行。每一个WHEN子句的boolean-expression会被依次计算，直到找到一个得到true的。然后相应的statements会被执行，并且接下来控制会传递给END CASE之后的下一个语句（后续的WHEN表达式不会被计算）。如果没有找到为真的结果，ELSE statements会被执行。但是如果ELSE不存在，那么将会抛出一个CASE_NOT_FOUND异常。
这里是一个例子：
CASE
WHEN x BETWEEN 0 AND 10 THEN
msg := 'value is between zero and ten';
WHEN x BETWEEN 11 AND 20 THEN
msg := 'value is between eleven and twenty';
END CASE;
这种形式的CASE整体上等价于IF-THEN-ELSIF，不同之处在于到达一个被忽略的ELSE子句时会导致一个错误而不是什么也不做。
41.6.5. 简单循环 #
使用LOOP、EXIT、CONTINUE、WHILE、FOR和FOREACH语句，你可以安排PL/pgSQL函数重复一系列命令。
41.6.5.1. LOOP #
[ <<label>> ]
LOOP
statements
END LOOP [ label ];
LOOP定义一个无条件的循环，它会无限重复直到被EXIT或RETURN语句终止。可选的label可以被EXIT和CONTINUE语句用在嵌套循环中指定这些语句引用的是哪一层循环。
41.6.5.2. EXIT #
EXIT [ label ] [ WHEN boolean-expression ];
如果没有给出label，那么最内层的循环会被终止，然后跟在END LOOP后面的语句会被执行。如果给出了label，那么它必须是当前或更高层的嵌套循环或块的标签。然后该命名循环或块会被终止，并且控制会转移到该循环/块相应的END之后的语句上。
如果指定了WHEN，只有boolean-expression为真时才会发生循环退出。否则，控制会转移到EXIT之后的语句。
EXIT可以用于所有类型的循环中，它并不限于在无条件循环中使用。
在与BEGIN块一起使用时，EXIT会将控制交给块结束后的下一个语句。需要注意的是，必须使用标签；一个没有标签的EXIT永远不会被认为与一个BEGIN块匹配。（这种情况从PostgreSQL 8.4 之前的版本开始发生变化，之前允许一个未标记的EXIT与BEGIN块匹配。）
例子：
LOOP
-- 一些计算
IF count > 0 THEN
EXIT;  -- 退出循环
END IF;
END LOOP;
LOOP
-- 一些计算
EXIT WHEN count > 0;  -- 和前一个例子相同的结果
END LOOP;
<<ablock>>
BEGIN
-- 一些计算
IF stocks > 100000 THEN
EXIT ablock;  -- 导致从 BEGIN 块中退出
END IF;
-- 当stocks > 100000时，这里的计算将被跳过
END;
41.6.5.3. CONTINUE #
CONTINUE [ label ] [ WHEN boolean-expression ];
如果没有给出label，最内层循环的下一次迭代会开始。也就是，循环体中剩余的所有语句将被跳过，并且控制会返回到循环控制表达式（如果有）来决定是否需要另一次循环迭代。如果label存在，它指定继续执行的循环的标签。
如果指定了WHEN，该循环的下一次迭代只有在boolean-expression为真时才会开始。否则，控制会传递给CONTINUE后面的语句。
CONTINUE可以被用在所有类型的循环中，它并不限于在无条件循环中使用。
例子：
LOOP
-- 一些计算
EXIT WHEN count > 100;
CONTINUE WHEN count < 50;
-- 一些用于 count IN [50 .. 100] 的计算
END LOOP;
41.6.5.4. WHILE #
[ <<label>> ]
WHILE boolean-expression LOOP
statements
END LOOP [ label ];
只要boolean-expression计算为真，WHILE语句就会重复一个语句序列。在每次进入循环体之前都会检查该表达式。
例如：
WHILE amount_owed > 0 AND gift_certificate_balance > 0 LOOP
-- 这里是一些计算
END LOOP;
WHILE NOT done LOOP
-- 这里是一些计算
END LOOP;
41.6.5.5. FOR（整数变体） #
[ <<label>> ]
FOR name IN [ REVERSE ] expression .. expression [ BY expression ] LOOP
statements
END LOOP [ label ];
这种形式的FOR会创建一个在一个整数范围上迭代的循环。变量name会自动定义为类型integer并且只在循环内存在（任何该变量名的现有定义在此循环内都将被忽略）。给出范围上下界的两个表达式在进入循环的时候计算一次。如果没有指定BY子句，迭代步长为1，否则步长是BY中指定的值，该值也只在循环进入时计算一次。如果指定了REVERSE，那么在每次迭代后步长值会被减去而不是增加。
整数FOR循环的一些例子：
FOR i IN 1..10 LOOP
-- i will take on the values 1,2,3,4,5,6,7,8,9,10 within the loop
END LOOP;
FOR i IN REVERSE 10..1 LOOP
-- i will take on the values 10,9,8,7,6,5,4,3,2,1 within the loop
END LOOP;
FOR i IN REVERSE 10..1 BY 2 LOOP
-- i will take on the values 10,8,6,4,2 within the loop
END LOOP;
如果下界大于上界（或者在REVERSE情况下是小于），循环体根本不会被执行。而且不会抛出任何错误。
如果一个label被附加到FOR循环，那么整数循环变量可以用一个使用该label的限定名引用。
41.6.6. 通过查询结果循环 #
使用一种不同类型的FOR循环，你可以通过一个查询的结果进行迭代并且操纵相应的数据。语法是：
[ <<label>> ]
FOR target IN query LOOP
statements
END LOOP [ label ];
target是一个记录变量、行变量或者逗号分隔的标量变量列表。target被连续不断地赋予来自query的每一行，并且循环体将为每一行执行一次。下面是一个例子：
CREATE FUNCTION refresh_mviews() RETURNS integer AS $$
DECLARE
mviews RECORD;
BEGIN
RAISE NOTICE 'Refreshing all materialized views...';
FOR mviews IN
SELECT n.nspname AS mv_schema,
c.relname AS mv_name,
pg_catalog.pg_get_userbyid(c.relowner) AS owner
FROM pg_catalog.pg_class c
LEFT JOIN pg_catalog.pg_namespace n ON (n.oid = c.relnamespace)
WHERE c.relkind = 'm'
ORDER BY 1
LOOP
-- Now "mviews" has one record with information about the materialized view
RAISE NOTICE 'Refreshing materialized view %.% (owner: %)...',
quote_ident(mviews.mv_schema),
quote_ident(mviews.mv_name),
quote_ident(mviews.owner);
EXECUTE format('REFRESH MATERIALIZED VIEW %I.%I', mviews.mv_schema, mviews.mv_name);
END LOOP;
RAISE NOTICE 'Done refreshing materialized views.';
RETURN 1;
END;
$$ LANGUAGE plpgsql;
如果循环被一个EXIT语句终止，那么在循环之后你仍然可以访问最后被赋予的行值。
这种类型的FOR语句中的查询可以是任何返回行给调用者的SQL命令：
SELECT是最常见的情况，
但你也可以使用INSERT、UPDATE、
DELETE或带有RETURNING子句的MERGE。
一些实用命令如EXPLAIN也能使用。
PL/pgSQL变量会被查询参数替换，并且如第 41.11.1 节和第 41.11.2 节中详细讨论的，查询计划会被缓存以用于可能的重用。
FOR-IN-EXECUTE语句是在行上迭代的另一种方式：
[ <<label>> ]
FOR target IN EXECUTE text_expression [ USING expression [, ... ] ] LOOP
statements
END LOOP [ label ];
这个例子类似前面的形式，只不过源查询被指定为一个字符串表达式，在每次进入FOR循环时都会计算它并且重新规划。这允许程序员在一个预先规划好的查询的速度和一个动态查询的灵活性之间进行选择，就像一个纯EXECUTE语句那样。在使用EXECUTE时，可以通过USING将参数值插入到动态命令中。
另一种指定要对其结果迭代的查询的方式是将它声明为一个游标。这会在第 41.7.4 节中描述。
41.6.7. 循环通过数组 #
FOREACH循环很像一个FOR循环，但不是通过一个 SQL 查询返回的行进行迭代，它通过一个数组值的元素来迭代（通常，FOREACH意味着通过一个组合值表达式的部件迭代；用于通过除数组之外组合类型进行循环的变体可能会在未来被加入）。在一个数组上循环的FOREACH语句是：
[ <<label>> ]
FOREACH target [ SLICE number ] IN ARRAY expression LOOP
statements
END LOOP [ label ];
如果没有SLICE，或者如果没有指定SLICE 0，循环会通过计算expression得到的数组的个体元素进行迭代。target变量被逐一赋予每一个元素值，并且循环体会为每一个元素执行。这里是一个通过整数数组的元素循环的例子：
CREATE FUNCTION sum(int[]) RETURNS int8 AS $$
DECLARE
s int8 := 0;
x int;
BEGIN
FOREACH x IN ARRAY $1
LOOP
s := s + x;
END LOOP;
RETURN s;
END;
$$ LANGUAGE plpgsql;
元素会被按照存储顺序访问，而不管数组的维度数。尽管target通常只是一个单一变量，当通过一个组合值（记录）的数组循环时，它可以是一个变量列表。在那种情况下，对每一个数组元素，变量会被从组合值的连续列赋值。
通过一个正SLICE值，FOREACH通过数组的切片而不是单一元素迭代。SLICE值必须是一个不大于数组维度数的整数常量。target变量必须是一个数组，并且它接收数组值的连续切片，其中每一个切片都有SLICE指定的维度数。这里是一个通过一维切片迭代的例子：
CREATE FUNCTION scan_rows(int[]) RETURNS void AS $$
DECLARE
x int[];
BEGIN
FOREACH x SLICE 1 IN ARRAY $1
LOOP
RAISE NOTICE 'row = %', x;
END LOOP;
END;
$$ LANGUAGE plpgsql;
SELECT scan_rows(ARRAY[[1,2,3],[4,5,6],[7,8,9],[10,11,12]]);
NOTICE:  row = {1,2,3}
NOTICE:  row = {4,5,6}
NOTICE:  row = {7,8,9}
NOTICE:  row = {10,11,12}
41.6.8. 捕获错误 #
默认情况下，PL/pgSQL函数中发生的任何错误都会中止函数和周围事务的执行。你可以使用一个带有EXCEPTION子句的BEGIN块捕获错误并从中恢复。其语法是BEGIN块通常的语法的一个扩展：
[ <<label>> ]
[ DECLARE
declarations ]
BEGIN
statements
EXCEPTION
WHEN condition [ OR condition ... ] THEN
handler_statements
[ WHEN condition [ OR condition ... ] THEN
handler_statements
... ]
END;
如果没有发生错误，这种形式的块只是简单地执行所有statements，并且接着控制转到END之后的下一个语句。但是如果在statements内发生了一个错误，则会放弃对statements的进一步处理，然后控制会转到EXCEPTION列表。系统会在列表中寻找匹配所发生错误的第一个condition。如果找到一个匹配，则执行对应的handler_statements，并且接着把控制转到END之后的下一个语句。如果没有找到匹配，该错误就会传播出去，就好像根本没有EXCEPTION一样：错误可以被一个带有EXCEPTION的闭合块捕获，如果没有EXCEPTION则中止该函数的处理。
condition的名字可以是附录 A中显示的任何名字。一个分类名匹配其中所有的错误。特殊的条件名OTHERS匹配除了QUERY_CANCELED和ASSERT_FAILURE之外的所有错误类型（虽然通常并不明智，还是可以用名字捕获这两种错误类型）。条件名是大小写无关的。一个错误条件也可以通过SQLSTATE代码指定，例如以下是等价的：
WHEN division_by_zero THEN ...
WHEN SQLSTATE '22012' THEN ...
如果在选中的handler_statements内发生了新的错误，那么它不能被这个EXCEPTION子句捕获，而是被传播出去。一个外层的EXCEPTION子句可以捕获它。
当一个错误被EXCEPTION捕获时，PL/pgSQL函数的局部变量会保持错误发生时的值，但是该块中所有对持久数据库状态的改变都会被回滚。例如，考虑这个片段：
INSERT INTO mytab(firstname, lastname) VALUES('Tom', 'Jones');
BEGIN
UPDATE mytab SET firstname = 'Joe' WHERE lastname = 'Jones';
x := x + 1;
y := x / 0;
EXCEPTION
WHEN division_by_zero THEN
RAISE NOTICE 'caught division_by_zero';
RETURN x;
END;
当控制到达对y赋值的地方时，它会带着一个division_by_zero错误失败。这个错误将被EXCEPTION子句捕获。而在RETURN语句中返回的值将是x增加过后的值。但是UPDATE命令的效果将已经被回滚。不过，在该块之前的INSERT将不会被回滚，因此最终的结果是数据库包含Tom Jones但不包含Joe Jones。
提示
进入和退出一个包含EXCEPTION子句的块要比不包含EXCEPTION的块开销大得多。因此，只在必要的时候使用EXCEPTION。
例 41.2. UPDATE/INSERT的异常
这个例子使用异常处理来酌情执行UPDATE或
INSERT。我们推荐应用使用带有
ON CONFLICT DO UPDATE的INSERT
而不是真正使用这种模式。下面的例子主要是为了展示
PL/pgSQL如何控制流程：
CREATE TABLE db (a INT PRIMARY KEY, b TEXT);
CREATE FUNCTION merge_db(key INT, data TEXT) RETURNS VOID AS
$$
BEGIN
LOOP
-- 首先尝试更新该键
UPDATE db SET b = data WHERE a = key;
IF found THEN
RETURN;
END IF;
-- 不在这里，那么尝试插入该键
-- 如果其他某人并发地插入同一个键，
-- 我们可能得到一个唯一键失败
BEGIN
INSERT INTO db(a,b) VALUES (key, data);
RETURN;
EXCEPTION WHEN unique_violation THEN
-- 什么也不做，并且循环再次尝试 UPDATE
END;
END LOOP;
END;
$$
LANGUAGE plpgsql;
SELECT merge_db(1, 'david');
SELECT merge_db(1, 'dennis');
这段代码假定unique_violation错误是INSERT造成，并且不是由该表上一个触发器函数中的INSERT导致。如果在该表上有多于一个唯一索引，也可能会发生不正确的行为，因为不管哪个索引导致该错误它都将重试该操作。通过接下来要讨论的特性来检查被捕获的错误是否为所预期的会更安全。
41.6.8.1. 获取有关错误的信息 #
异常处理器经常需要识别发生的特定错误。有两种方法来得到PL/pgSQL中当前异常的信息：特殊变量和GET STACKED DIAGNOSTICS命令。
在一个异常处理器内，特殊变量SQLSTATE包含了对应于被抛出异常的错误代码（可能的错误代码列表见表 A.1）。特殊变量SQLERRM包含与该异常相关的错误消息。这些变量在异常处理器外是未定义的。
在一个异常处理器内，我们也可以用GET STACKED DIAGNOSTICS命令检索有关当前异常的信息，该命令的形式为：
GET STACKED DIAGNOSTICS variable { = | := } item [ , ... ];
每个item是一个关键词，它标识一个被赋予给指定variable（应该具有接收该值的正确数据类型）的状态值。表 41.2中显示了当前可用的状态项。
表 41.2. 错误诊断项名称类型描述RETURNED_SQLSTATEtext该异常的 SQLSTATE 错误代码COLUMN_NAMEtext与异常相关的列名CONSTRAINT_NAMEtext与异常相关的约束名PG_DATATYPE_NAMEtext与异常相关的数据类型名MESSAGE_TEXTtext该异常的主要消息文本TABLE_NAMEtext与异常相关的表名SCHEMA_NAMEtext与异常相关的模式名PG_EXCEPTION_DETAILtext该异常的详细消息文本（如果有）PG_EXCEPTION_HINTtext异常的提示消息文本（如果有）PG_EXCEPTION_CONTEXTtext描述产生异常时调用栈的文本行（见第 41.6.9 节）
如果异常没有为项设置值，将返回一个空字符串。
这里是一个例子：
DECLARE
text_var1 text;
text_var2 text;
text_var3 text;
BEGIN
-- 某些可能导致异常的处理
...
EXCEPTION WHEN OTHERS THEN
GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT,
text_var2 = PG_EXCEPTION_DETAIL,
text_var3 = PG_EXCEPTION_HINT;
END;
41.6.9. 获取执行位置信息 #
GET DIAGNOSTICS（之前在第 41.5.5 节中描述）命令检索有关当前执行状态的信息（而上文讨论的GET STACKED DIAGNOSTICS命令会报告有关执行状态的信息，基于以前的错误）。它的PG_CONTEXT状态项可用于标识当前执行位置。状态项PG_CONTEXT将返回一个文本字符串，其中有描述该调用栈的多行文本。第一行会指向当前函数以及当前正在执行GET DIAGNOSTICS的命令。第二行及其后的行表示调用栈中更上层的调用函数。例如：
CREATE OR REPLACE FUNCTION outer_func() RETURNS integer AS $$
BEGIN
RETURN inner_func();
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION inner_func() RETURNS integer AS $$
DECLARE
stack text;
BEGIN
GET DIAGNOSTICS stack = PG_CONTEXT;
RAISE NOTICE E'--- Call Stack ---\n%', stack;
RETURN 1;
END;
$$ LANGUAGE plpgsql;
SELECT outer_func();
NOTICE:  --- Call Stack ---
PL/pgSQL function inner_func() line 5 at GET DIAGNOSTICS
PL/pgSQL function outer_func() line 3 at RETURN
CONTEXT:  PL/pgSQL function outer_func() line 3 at RETURN
outer_func
------------
1
(1 row)
GET STACKED DIAGNOSTICS ... PG_EXCEPTION_CONTEXT返回同类的栈跟踪，但描述检测到错误的位置，而不是当前位置。
上一页 上一级 下一页41.5. 基本语句 起始页 41.7. 游标
