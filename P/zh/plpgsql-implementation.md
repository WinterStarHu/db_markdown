# 41.11. PL/pgSQL的内部实现

41.11. PL/pgSQL的内部实现
版本：
纠错本页面
搜索
目录导航
❮
❯
41.11. PL/pgSQL的内部实现 #41.11.1. 变量替换41.11.2. 计划缓存
这一节讨论了一些PL/pgSQL用户应该知道的重要实现细节。
41.11.1. 变量替换 #
一个PL/pgSQL函数中的 SQL 语句和表达式能够引用该函数的变量和参数。在背后，PL/pgSQL会为这些引用替换查询参数。只有在语法上允许的地方才会替换参数。作为一种极端情况，考虑这个编程风格糟糕的例子：
INSERT INTO foo (foo) VALUES (foo(foo));
foo的第一次出现在语法上必须是一个表名，因此它将不会被替换，即使该函数有一个名为foo的变量。第二次出现必须是该表的一列的名称，因此它也将不会被替换。同样，第三次出现必须是一个函数名，因此它也不会被替换。只有最后一个位置是PL/pgSQL函数中变量引用的候选者。
另一种理解方式是，变量替换只能将数据值插入到 SQL 命令中。命令引用的数据库对象不能动态更改。（如果你想这样做，你必须动态构造命令字符串，如第 41.5.4 节中所述。）
因为变量名在语法上与表列的名字没什么区别，在引用表的语句中会有歧义：一个给定的名字意味着一个表列还是一个变量？让我们把前一个例子改成：
INSERT INTO dest (col) SELECT foo + bar FROM src;
这里，dest和src必须是表名，并且col必须是dest的一列，但是foo和bar可能是该函数的变量或者src的列。
默认情况下，如果一个 SQL 语句中的名称可能引用一个变量或者一个表列，PL/pgSQL将报告一个错误。修复这种问题的方法有很多：你可以重命名变量或列，或者对有歧义的引用加以限定，或者告诉PL/pgSQL要引用哪种解释。
最简单的解决方案是重命名变量或列。一种常用的编码规则是为PL/pgSQL变量使用一种不同于列名的命名习惯。例如，如果你将函数变量统一地命名为v_something，而你的列名不会以v_开头，就不会发生冲突。
另外你可以限定有歧义的引用让它们变清晰。在上面的例子中，src.foo将是对表列的一种无歧义的引用。要创建对一个变量的无歧义引用，在一个被标记的块中声明它并且使用块的标签（见第 41.2 节）。例如
<<block>>
DECLARE
foo int;
BEGIN
foo := ...;
INSERT INTO dest (col) SELECT block.foo + bar FROM src;
这里block.foo表示变量，即使在src中有一个列foo。函数参数以及诸如FOUND的特殊变量，都能通过函数的名称被限定，因为它们被隐式地声明在一个带有该函数名称的外层块中。
有时候在一个大型的PL/pgSQL代码体中修复所有的有歧义引用是不现实的。在这种情况下，你可以指定PL/pgSQL应该将有歧义的引用作为变量（这与PL/pgSQL在 PostgreSQL 9.0 之前的行为兼容）或表列（这与某些其他系统兼容，例如Oracle）解决。
要在系统范围内改变这种行为，将配置参数plpgsql.variable_conflict设置为error、use_variable或者use_column（这里error是出厂设置）之一。这个参数会影响PL/pgSQL函数中语句的后续编译，但是不会影响在当前会话中已经编译过的语句。因为改变这个设置能够导致PL/pgSQL函数中行为的意想不到的改变，所以只能由一个超级用户来更改它。
你也可以对逐个函数设置该行为，做法是在函数文本的开始插入这些特殊命令之一：
#variable_conflict error
#variable_conflict use_variable
#variable_conflict use_column
这些命令只影响它们所属的函数，并且会覆盖plpgsql.variable_conflict的设置。一个例子是：
CREATE FUNCTION stamp_user(id int, comment text) RETURNS void AS $$
#variable_conflict use_variable
DECLARE
curtime timestamp := now();
BEGIN
UPDATE users SET last_modified = curtime, comment = comment
WHERE users.id = id;
END;
$$ LANGUAGE plpgsql;
在UPDATE命令中，curtime、comment以及id将引用该函数的变量和参数，不管users有没有这些名称的列。注意，我们不得不在WHERE子句中对users.id的引用加以限定，以便让它引用表列。但是我们不需要在UPDATE列表中把对comment的引用限定为一个目标，因为语法上那必须是users的一列。我们可以用下面的方式写一个相同的不依赖于variable_conflict设置的函数：
CREATE FUNCTION stamp_user(id int, comment text) RETURNS void AS $$
<<fn>>
DECLARE
curtime timestamp := now();
BEGIN
UPDATE users SET last_modified = fn.curtime, comment = stamp_user.comment
WHERE users.id = stamp_user.id;
END;
$$ LANGUAGE plpgsql;
被交给EXECUTE或其变体的命令字符串中不会发生变量替换。如果你需要插入一个变化值到这样一个命令中，在构建该字符串值时就这样做，或者使用USING，如第 41.5.4 节中所阐明的。
变量替换当前仅在 SELECT,
INSERT, UPDATE,
DELETE, MERGE 和包含这些命令的命令
（如 EXPLAIN 和
CREATE TABLE ... AS SELECT）中工作，因为主要的 SQL
引擎仅允许在这些命令中使用查询参数。要在其他语句类型中使用
非常量名称或值（通常称为实用程序语句），必须将实用程序语句构造为字符串
并使用 EXECUTE 执行它。
41.11.2. 计划缓存 #
在函数被第一次调用时（在每个会话中），PL/pgSQL解释器解析函数的源文本并产生一个内部的二进制指令树。该指令树完全翻译了PL/pgSQL语句结构，但是该函数中使用的SQL表达式以及SQL命令并没有被立即翻译。
作为该函数中每一个表达式和SQL命令第一次被执行时，PL/pgSQL解释器使用SPI管理器的SPI_prepare函数解析并分析该命令来创建一个预备语句。对于那个表达式或命令的后续访问将会重用该预备语句。因此，一个带有很少被访问的条件性代码路径的函数将永远不会发生分析那些在当前会话中永远不被执行的命令的开销。一个缺点是在一个特定表达式或命令中的错误将不能被检测到，直到函数的该部分在执行时被到达（不重要的语法错误在初始的解析中就会被检测到，但是任何更深层次的东西将只有在执行时才能检测到）。
PL/pgSQL（或者更准确地说是 SPI 管理器）能进一步尝试缓存与任何特定预备语句相关的执行计划。如果没有使用一个已缓存的计划，那么每次访问该语句时都会生成一个新的执行计划，并且当前的参数值（也就是PL/pgSQL的变量值）可以被用来优化被选中的计划。如果该语句没有参数，或者要被执行很多次，SPI 管理器将考虑创建一个不依赖特定参数值的一般计划并将其缓存用于重用。通常只有在执行计划对其中引用的PL/pgSQL变量值不那么敏感时，才会这样做。如果这样做，每一次生成的计划就是纯利。关于预备语句的行为请详见PREPARE。
由于PL/pgSQL保存预备语句并且有时候以这种方式保存执行计划，直接出现在一个PL/pgSQL函数中的 SQL 命令必须在每次执行时引用相同的表和列。也就是说，你不能在一个 SQL 命令中把一个参数用作表或列的名字。要绕过这种限制，你可以构建PL/pgSQL EXECUTE使用的动态命令，但会付出在每次执行时需要执行新解析分析以及构建新执行计划的代价。
记录变量的易变性在这个关系中带来了另一个问题。当一个记录变量的域被用在表达式或语句中时，域的数据类型不能在该函数的调用之间改变，因为每一个表达式被分析时都将使用第一次到达该表达式时存在的数据类型。必要时，可以用EXECUTE来绕过这个问题。
如果同一个函数被用作一个服务于多个表的触发器，PL/pgSQL会为每一个这样的表独立地准备并缓存语句 — 也就是对每一种触发器函数和表的组合都会有一个缓存，而不是每个函数一个缓存。这减轻了数据类型变化带来的问题。例如，一个触发器函数将能够成功地使用一个名为key的列工作，即使该列正好在不同的表中有不同的类型。
同样，具有多态参数类型的函数也会为它们已经被调用的每一种实参类型组合保留一个独立的缓存，这样数据类型差异不会导致意想不到的失败。
语句缓存有时可能在解释时间敏感的值时产生令人惊讶的效果。例如这两个函数做的事情就有区别：
CREATE FUNCTION logfunc1(logtxt text) RETURNS void AS $$
BEGIN
INSERT INTO logtable VALUES (logtxt, 'now');
END;
$$ LANGUAGE plpgsql;
和：
CREATE FUNCTION logfunc2(logtxt text) RETURNS void AS $$
DECLARE
curtime timestamp;
BEGIN
curtime := 'now';
INSERT INTO logtable VALUES (logtxt, curtime);
END;
$$ LANGUAGE plpgsql;
在logfunc1中，PostgreSQL的主解析器在分析INSERT时就知道字符串'now'应该被解释为timestamp，因为logtable的目标列是这种类型。因此，在INSERT被分析时'now'将被转换为一个timestamp常量，并且在该会话的生命周期内被用于所有对logfunc1的调用。不用说，这不是程序员想要的。一个更好的主意是使用now()或current_timestamp函数。
在logfunc2中，PostgreSQL的主解析器不知道'now'应该变成什么类型，因此返回一个text类型的包含字符串now的数据值。在对本地变量curtime的赋值期间，PL/pgSQL解释器通过调用用于转换的textout和timestamp_in函数将这个字符串转换为timestamp类型。因此，计算出来的时间戳会按照程序员的期待在每次执行时更新。虽然这正好符合预期，但是它的效率很糟糕，因此使用now()函数仍然是一种更好的方案。
上一页 上一级 下一页41.10. 触发器函数 起始页 41.12. PL/pgSQL开发提示
