# 41.5. 基本语句

41.5. 基本语句
版本：
纠错本页面
搜索
目录导航
❮
❯
41.5. 基本语句 #41.5.1. 赋值41.5.2. 执行 SQL 命令41.5.3. 执行一个有单行结果的命令41.5.4. 执行动态命令41.5.5. 获取结果状态41.5.6. 什么也不做
在这一节和接下来的小节中，我们会描述PL/pgSQL能明确理解的所有语句类型。任何不被识别为这些语句类型之一的被假定为是一个 SQL 命令，并且会被发送给主数据库引擎执行，具体如第 41.5.2 节中所述。
41.5.1. 赋值 #
为一个PL/pgSQL变量赋一个值可以被写为：
variable { := | = } expression;
正如以前所解释的，这样一个语句中的表达式是通过一个 SQL
SELECT命令发送到主数据库引擎进行计算的。
该表达式必须得到一个单一值（如果该变量是一个行或记录变量，
它可能是一个行值）。该目标变量可以是一个简单变量（
可以选择用一个块名限定）、一个行或记录变量的字段，或是一个数组
的元素或切片。
等号（=）可以用来代替 PL/SQL-兼容的
:=。
如果该表达式的结果数据类型不匹配变量的数据类型，该值将被强制为变量
的类型，就好像做了赋值转换一样（见第 10.4 节）。
如果没有用于所涉及到的数据类型的赋值转换可用，
PL/pgSQL解释器将尝试以文本的方式转换结果值，也就
是在应用结果类型的输出函数之后再应用变量类型的输入函数。注意如果结果
值的字符串形式无法被输入函数所接受，这可能会导致由输入函数产生的运行
时错误。
例子：
tax := subtotal * 0.06;
my_record.user_id := 20;
my_array[j] := 20;
my_array[1:3] := array[1,2,3];
complex_array[n].realpart = 12.3;
41.5.2. 执行 SQL 命令 #
通常，任何不返回行的 SQL 命令，你可以通过把该命令直接写在一个 PL/pgSQL 函数中执行它。
例如，创建和填充表数据，你可以这样写：
CREATE TABLE mytable (id int primary key, data text);
INSERT INTO mytable VALUES (1,'one'), (2,'two');
如果命令确实返回行（例如SELECT，或者
INSERT/UPDATE/DELETE/MERGE
搭配RETURNING），有两种方式可以继续操作。
当命令最多返回一行，或者你只关心输出的第一行时，像平常一样编写命令，
但添加一个INTO子句来捕获输出，如
第 41.5.3 节中所述。
若要处理所有输出行，则将命令作为FOR循环的数据源，
如第 41.6.6 节中所述。
简单地执行静态定义的 SQL 命令通常是不够的。通常，您会希望使用可变数据值的命令，或者甚至以更基本的方式进行更改，例如在不同时间使用不同的表名。同样，有两种方法，视情况而定。
PL/pgSQL变量值可以自动插入到可优化的SQL命令中，这些命令包括SELECT、INSERT、UPDATE、DELETE、MERGE以及某些包含其中之一的实用程序命令，比如EXPLAIN和CREATE TABLE ... AS SELECT。在这些命令中，命令文本中出现的任何PL/pgSQL变量名都会被查询参数替换，然后变量的当前值会在运行时作为参数值提供。这与前面描述的表达式处理完全相同；详情请参见第 41.11.1 节。
当以这种方式执行一个可优化的SQL命令时，PL/pgSQL会为该命令缓存并重用执行计划，如第 41.11.2 节中讨论的。
不可优化的SQL命令（也称为实用命令）不能够接受查询参数。所以自动替换PL/pgSQL的变量在这类命令中不起作用。要在从PL/pgSQL执行的实用程序命令中包含非常量文本，你必须将实用程序命令构建为一个字符串，然后EXECUTE它，如第 41.5.4 节中所讨论的。
EXECUTE也必须使用，如果你想以某种其他方式修改命令，而不是提供数据值，例如改变表名。
有时候计算一个表达式或SELECT查询但抛弃其结果是有用的，例如调用一个有副作用但是没有有用的结果值的函数。在PL/pgSQL中要这样做，可使用PERFORM语句：
PERFORM query;
这会执行query并且丢弃掉结果。以写一个SQL SELECT命令相同的方式写该query，并且将初始的关键词SELECT替换为PERFORM。对于WITH查询，使用PERFORM并且接着把该查询放在圆括号中（在这种情况下，该查询只能返回一行）。PL/pgSQL变量将被替换到该查询中，正如上面描述的查询，并且计划以相同的方式被缓存。还有，如果该查询产生至少一行，特殊变量FOUND会被设置为真，而如果它不产生行则设置为假（见第 41.5.5 节）。
注意
我们可能期望直接写SELECT能实现这个结果，但是当前唯一被接受的方式是PERFORM。一个能返回行的SQL命令（例如SELECT）将被当成一个错误拒绝，除非它像下一节中讨论的有一个INTO子句。
一个例子：
PERFORM create_mv('cs_session_page_requests_mv', my_query);
41.5.3. 执行一个有单行结果的命令 #
SQL命令返回单行结果（可能包含多列）时，可以将其赋值给记录变量、行类型变量或标量变量列表。
这是通过编写基本的SQL命令并添加一个INTO子句来完成的。例如，
SELECT select_expressions INTO [STRICT] target FROM ...;
INSERT ... RETURNING expressions INTO [STRICT] target;
UPDATE ... RETURNING expressions INTO [STRICT] target;
DELETE ... RETURNING expressions INTO [STRICT] target;
MERGE ... RETURNING expressions INTO [STRICT] target;
其中target可以是记录变量、行变量，或由简单变量和记录/行字段组成的逗号分隔列表。
PL/pgSQL变量将被替换到命令的其余部分（即除INTO子句之外的所有内容），
如上所述，并且计划以相同方式缓存。
这适用于带有RETURNING的SELECT、
INSERT/UPDATE/DELETE/MERGE，
以及返回行集的某些实用命令，如EXPLAIN。
除了INTO子句外，SQL命令与在PL/pgSQL外部编写时相同。
提示
注意带INTO的SELECT的这种解释和PostgreSQL常规的SELECT INTO命令有很大的不同，后者的INTO目标是一个新创建的表。如果你想要在一个PL/pgSQL函数中从一个SELECT的结果创建一个表，请使用语法CREATE TABLE ... AS SELECT。
如果一个行变量或一个变量列表被用作目标，该命令的结果列必须完全匹配该结果的结构，包括数量和数据类型，否则会发生一个运行时错误。当一个记录变量是目标时，它会自动地把自身配置成命令的结果列组成的行类型。
INTO子句几乎可以出现在 SQL 命令中的任何位置。通常它被写成刚好在SELECT命令中的select_expressions列表之前或之后，或者在其他命令类型的命令最后。我们推荐你遵循这种惯例，以防PL/pgSQL的解析器在未来的版本中变得更严格。
如果STRICT没有在INTO子句中被指定，那么target将被设置为该命令返回的第一个行，或者在该命令不返回行时设置为空（注意除非使用了ORDER BY，否则“第一行”的界定并不清楚）。第一行之后的任何结果行都会被抛弃。你可以检查特殊的FOUND变量（见第 41.5.5 节）来确定是否返回了一行：
SELECT * INTO myrec FROM emp WHERE empname = myname;
IF NOT FOUND THEN
RAISE EXCEPTION 'employee % not found', myname;
END IF;
如果指定了STRICT选项，该命令必须刚好返回一行或者将会报告一个运行时错误，该错误可能是NO_DATA_FOUND（没有行）或TOO_MANY_ROWS（多于一行）。如果你希望捕捉该错误，可以使用一个异常块，例如：
BEGIN
SELECT * INTO STRICT myrec FROM emp WHERE empname = myname;
EXCEPTION
WHEN NO_DATA_FOUND THEN
RAISE EXCEPTION 'employee % not found', myname;
WHEN TOO_MANY_ROWS THEN
RAISE EXCEPTION 'employee % not unique', myname;
END;
成功执行一个带STRICT的命令总是会将FOUND置为真。
对于 INSERT/UPDATE/DELETE/MERGE
搭配 RETURNING，PL/pgSQL 会在返回多行时报告错误，
即使未指定 STRICT。这是因为没有类似 ORDER BY 的选项来确定
应该返回哪一条受影响的行。
如果为函数启用了print_strict_params，
那么当由于未满足STRICT的要求而抛出错误时，
错误消息的DETAIL部分将包含有关传递给命令的参数的信息。
您可以通过设置plpgsql.print_strict_params
来更改所有函数的print_strict_params设置，
但只有后续的函数编译会受到影响。您还可以通过使用编译器选项
在每个函数的基础上启用它，例如：
CREATE FUNCTION get_userid(username text) RETURNS int
AS $$
#print_strict_params on
DECLARE
userid int;
BEGIN
SELECT users.userid INTO STRICT userid
FROM users WHERE users.username = get_userid.username;
RETURN userid;
END;
$$ LANGUAGE plpgsql;
如果失败，此函数可能会生成如下错误消息：
ERROR:  query returned no rows
DETAIL:  parameters: username = 'nosuchuser'
CONTEXT:  PL/pgSQL function get_userid(text) line 6 at SQL statement
注意
STRICT选项匹配 Oracle PL/SQL 的SELECT INTO和相关语句的行为。
41.5.4. 执行动态命令 #
很多时候你将想要在PL/pgSQL函数中产生动态命令，也就是每次执行中会涉及到不同表或不同数据类型的命令。PL/pgSQL通常对于命令所做的缓存计划尝试（如第 41.11.2 节中讨论）在这种情境下无法工作。要处理这一类问题，需要提供EXECUTE语句：
EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ];
其中command-string是一个能得到一个包含要被执行命令字符串（类型text）的表达式。可选的target是一个记录变量、一个行变量或者一个逗号分隔的简单变量以及记录/行域的列表，该命令的结果将存储在其中。可选的USING表达式提供要被插入到该命令中的值。
在计算得到的命令字符串中，不会做PL/pgSQL变量的替换。任何所需的变量值必须在命令字符串被构造时被插入其中，或者你可以使用下面描述的参数。
还有，对于通过EXECUTE执行的命令不会有计划被缓存。该命令反而在每次运行时都会被做计划。因此，该命令字符串可以在执行不同表和列上动作的函数中被动态创建。
INTO子句指定一个返回行的 SQL 命令的结果应该被赋值到哪里。如果提供了一个行或变量列表，它必须完全匹配查询命令结果的结构；当一个记录变量被提供时，它会自动把它自己配置为匹配结果结构。如果返回多个行，只有第一个行会被赋值给INTO变量。如果没有返回行，NULL 会被赋值给INTO变量。如果没有指定INTO子句，该命令结果会被抛弃。
如果给出了STRICT选项，除非该命令刚好产生一行，否则将会报告一个错误。
命令字符串可以使用参数值，它们在命令中用$1、$2等引用。这些符号引用在USING子句中提供的值。这种方法常常更适合于把数据值作为文本插入到命令字符串中：它避免了将该值转换为文本以及转换回来的运行时负荷，并且它更不容易被 SQL 注入攻击，因为不需要引用或转义。一个例子是：
EXECUTE 'SELECT count(*) FROM mytable WHERE inserted_by = $1 AND inserted <= $2'
INTO c
USING checked_user, checked_date;
需要注意的是，参数符号只能用于数据值 — 如果想要使用动态决定的表名或列名，你必须将它们以文本形式插入到命令字符串中。例如，如果前面的那个查询需要在一个动态选择的表上执行，你可以这么做：
EXECUTE 'SELECT count(*) FROM '
|| quote_ident(tabname)
|| ' WHERE inserted_by = $1 AND inserted <= $2'
INTO c
USING checked_user, checked_date;
一种更干净的方法是使用format()的
%I规范，插入自带引号的表名或者列名：
EXECUTE format('SELECT count(*) FROM %I '
'WHERE inserted_by = $1 AND inserted <= $2', tabname)
INTO c
USING checked_user, checked_date;
(此示例依赖于隐式连接由换行符分隔的字符串文字的 SQL 规则)
参数符号的另一个限制是它们仅适用于可优化的SQL命令
(SELECT, INSERT, UPDATE,
DELETE, MERGE以及包含其中一个的某些命令)。
在其他语句类型（通称为实用程序语句）中，即使它们只是数据值，您也必须以文本方式插入值。
在上面第一个例子中，带有一个简单的常量命令字符串和一些USING参数的EXECUTE命令在功能上等效于直接用PL/pgSQL写的命令，并且允许自动发生PL/pgSQL变量替换。重要的不同之处在于，EXECUTE会在每一次执行时根据当前的参数值重新规划该命令，而PL/pgSQL则是创建一个通用计划并且将其缓存以便重用。在最佳计划强依赖于参数值的情况中，使用EXECUTE来明确地保证不会选择一个通用计划是很有帮助的。
SELECT INTO目前不支持EXECUTE。但是可以执行一个纯的SELECT命令并且指定INTO作为EXECUTE本身的一部分。
注意
PL/pgSQL中的EXECUTE语句与EXECUTE PostgreSQL服务器支持的 SQL 语句无关。服务器的EXECUTE语句不能直接在PL/pgSQL函数中使用（并且也没有必要）。
例 41.1. 在动态查询中引用值
在使用动态命令时经常不得不处理单引号的转义。我们推荐在函数体中使用美元符号引用来引用固定的文本（如果你没有使用美元符号引用的老代码，请参考第 41.12.1 节中的概述，这样在把上述代码转换成更合理的模式时会省力些）。
动态值需要被小心地处理，因为它们可能包含引号字符。一个使用
format()的例子（这假设你用美元符号引用了函数
体，因此引号不需要被双写）：
EXECUTE format('UPDATE tbl SET %I = $1 '
'WHERE key = $2', colname) USING newvalue, keyvalue;
还可以直接调用引用函数：
EXECUTE 'UPDATE tbl SET '
|| quote_ident(colname)
|| ' = '
|| quote_literal(newvalue)
|| ' WHERE key = '
|| quote_literal(keyvalue);
这个例子展示了quote_ident和quote_literal函数的使用（见第 9.4 节）。为了安全，在进行一个动态查询中的插入之前，包含列或表标识符的表达式应该通过quote_ident被传递。如果表达式包含在被构造出的命令中应该是字符串的值时，它应该通过quote_literal被传递。这些函数采取适当的步骤来分别返回被封闭在双引号或单引号中的文本，其中任何嵌入的特殊字符都会被正确地转义。
因为quote_literal被标记为STRICT，当用一个空参数调用时，它总是会返回空。在上面的例子中，如果newvalue或keyvalue为空，整个动态查询字符串会变成空，导致从EXECUTE得到一个错误。可以通过使用quote_nullable函数来避免这种问题，它工作起来和quote_literal相同，除了用空参数调用时会返回一个字符串NULL。例如：
EXECUTE 'UPDATE tbl SET '
|| quote_ident(colname)
|| ' = '
|| quote_nullable(newvalue)
|| ' WHERE key = '
|| quote_nullable(keyvalue);
如果正在处理的参数值可能为空，那么通常应该用quote_nullable来代替quote_literal。
通常，必须小心地确保查询中的空值不会递送意料之外的结果。例如下面的WHERE子句
'WHERE key = ' || quote_nullable(keyvalue)
永远不会成功，因为在=操作符中使用空操作数得到的结果总是为空。如果想让空和一个普通键值一样工作，你应该将上面的命令重写成
'WHERE key IS NOT DISTINCT FROM ' || quote_nullable(keyvalue)
（目前，IS NOT DISTINCT FROM的处理效率不如=，因此只有在非常必要时才这样做。关于空和IS DISTINCT的详细信息请见第 9.2 节）。
请注意美元符号引用只对引用固定文本有用。尝试写出下面这个例子是一个非常糟糕的主意：
EXECUTE 'UPDATE tbl SET '
|| quote_ident(colname)
|| ' = $$'
|| newvalue
|| '$$ WHERE key = '
|| quote_literal(keyvalue);
因为如果newvalue的内容碰巧含有$$，那么这段代码就会出问题。同样的缺点可能适用于你选择的任何其他美元符号引用定界符。因此，要想安全地引用事先不知道的文本，必须恰当地使用quote_literal、quote_nullable或quote_ident。
动态 SQL 语句也可以使用format（见第 9.4.1 节）函数来安全地构造。例如：
EXECUTE format('UPDATE tbl SET %I = %L '
'WHERE key = %L', colname, newvalue, keyvalue);
%I等效于quote_ident并且
%L等效于quote_nullable。
format函数可以和
USING子句一起使用：
EXECUTE format('UPDATE tbl SET %I = $1 WHERE key = $2', colname)
USING newvalue, keyvalue;
这种形式更好，因为变量被以它们天然的数据类型格式处理，而不是无
条件地把它们转换成文本并且通过%L引用它们。这也效率
更高。
动态命令和EXECUTE的一个更大的例子可以在例 41.10中找到，它会构建并执行一个CREATE FUNCTION命令来定义一个新的函数。
41.5.5. 获取结果状态 #
有好几种方法可以判断一条命令的效果。第一种方法是使用GET DIAGNOSTICS命令，其形式如下：
GET [ CURRENT ] DIAGNOSTICS variable { = | := } item [ , ... ];
这条命令允许检索系统状态指示符。CURRENT是一个噪声词（另见GET STACKED DIAGNOSTICS在第 41.6.8.1 节中）。每个item是一个关键字，它标识一个要被赋予给指定variable的状态值（变量应具有正确的数据类型来接收状态值）。表 41.1中展示了当前可用的状态项。冒号等号（:=）可以被用来取代 SQL 标准的=符号。例如：
GET DIAGNOSTICS integer_var = ROW_COUNT;
表 41.1. 可用的诊断项名称类型描述ROW_COUNTbigint最近的SQL命令处理的行数PG_CONTEXTtext描述当前调用栈的文本行（见第 41.6.9 节）PG_ROUTINE_OIDoid当前函数的OID
第二种确定命令效果的方法是检查名为FOUND的特殊变量，类型为boolean。
在每次PL/pgSQL函数调用中，FOUND都是以 false 开头。
它由以下类型的语句设置：
SELECT INTO语句在分配行时将FOUND设置为true，
如果没有返回行则设置为false。
PERFORM语句在生成（和丢弃）一个或多个行时将FOUND设置为true，
如果没有生成行则设置为false。
UPDATE、INSERT、DELETE和MERGE
语句在至少影响一行时将FOUND设置为true，如果没有影响行则设置为false。
FETCH语句在返回行时将FOUND设置为true，
如果没有返回行则设置为false。
MOVE语句在成功重新定位游标时将FOUND设置为true，
否则设置为false。
FOR或FOREACH语句在迭代一次或多次时将
FOUND设置为true，否则设置为false。
当循环退出时，FOUND被设置为这种方式；
在循环执行过程中，FOUND不会被循环语句修改，
尽管它可能会被循环体内的其他语句执行修改。
RETURN QUERY和RETURN QUERY
EXECUTE语句在查询返回至少一行时将FOUND设置为true，
如果没有返回行则设置为false。
其他PL/pgSQL语句不会改变FOUND的状态。
特别注意，EXECUTE会改变GET DIAGNOSTICS的输出，
但不会改变FOUND。
FOUND是每个PL/pgSQL函数的局部变量；任何对它的修改只影响当前函数。
41.5.6. 什么也不做 #
有时一个什么也不做的占位语句也很有用。例如，它能够指示 if/then/else 链中故意留出的空分支。可以使用NULL语句达到这个目的：
NULL;
例如，下面的两段代码是等价的：
BEGIN
y := x / 0;
EXCEPTION
WHEN division_by_zero THEN
NULL;  -- 忽略错误
END;
BEGIN
y := x / 0;
EXCEPTION
WHEN division_by_zero THEN  -- 忽略错误
END;
究竟使用哪一种取决于各人的喜好。
注意
在 Oracle 的 PL/SQL 中，不允许出现空语句列表，并且因此在这种情况下必须使用NULL语句。而PL/pgSQL允许你什么也不写。
上一页 上一级 下一页41.4. 表达式 起始页 41.6. 控制结构
