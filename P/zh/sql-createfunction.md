# CREATE FUNCTION

CREATE FUNCTION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE FUNCTIONCREATE FUNCTION — 定义一个新函数大纲
CREATE [ OR REPLACE ] FUNCTION
name ( [ [ argmode ] [ argname ] argtype [ { DEFAULT | = } default_expr ] [, ...] ] )
[ RETURNS rettype
| RETURNS TABLE ( column_name column_type [, ...] ) ]
{ LANGUAGE lang_name
| TRANSFORM { FOR TYPE type_name } [, ... ]
| WINDOW
| { IMMUTABLE | STABLE | VOLATILE }
| [ NOT ] LEAKPROOF
| { CALLED ON NULL INPUT | RETURNS NULL ON NULL INPUT | STRICT }
| { [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER }
| PARALLEL { UNSAFE | RESTRICTED | SAFE }
| COST execution_cost
| ROWS result_rows
| SUPPORT support_function
| SET configuration_parameter { TO value | = value | FROM CURRENT }
| AS 'definition'
| AS 'obj_file', 'link_symbol'
| sql_body
} ...
描述
CREATE FUNCTION定义一个新函数。CREATE OR REPLACE FUNCTION将创建一个新函数，或者替换一个现有的定义。要定义一个函数，用户必须具有该语言上的USAGE特权。
如果包括了一个模式名，那么该函数会被创建在指定的模式中。否则，它会被创建在当前模式中。新函数的名称不能匹配同一个模式中具有相同输入参数类型的任何现有函数或过程。不过，不同参数类型的函数和过程能够共享一个名字（这被称作重载）。
要替换一个现有函数的当前定义，可以使用CREATE OR REPLACE FUNCTION。但不能用这种方式更改函数的名称或者参数类型（如果尝试这样做，实际上就会创建一个新的不同的函数）。还有，CREATE OR REPLACE FUNCTION将不会让你更改一个现有函数的返回类型。要这样做，你必须先删除再重建该函数（在使用OUT参数时，这意味着除了删除函数之外无法更改任何OUT参数的类型）。
当CREATE OR REPLACE FUNCTION被用来替换一个现有的函数，该函数的拥有权和权限不会改变。所有其他的函数属性会按照该命令中所指定的或者隐含的来赋值。必须拥有该函数才能替换它（这包括成为拥有角色的成员）。
如果你删除并重建一个函数，新函数与旧函数不是同一个实体；你将必须删掉引用旧函数的现有规则、视图、触发器等。使用
CREATE OR REPLACE FUNCTION来更改函数定义，而不会破坏引用该函数的对象。
此外，ALTER FUNCTION可以用来更改现有函数的大部分辅助属性。
创建该函数的用户将成为该函数的拥有者。
要能够创建一个函数，你必须拥有参数类型和返回类型上的USAGE特权。
有关编写函数的更多信息，请参阅第 36.3 节。
参数name
要创建的函数的名称（可以被模式限定）。
argmode
一个参数的模式：IN、OUT、INOUT或VARIADIC。
如果省略，默认为IN。只有OUT参数可以跟在VARIADIC参数后面。
此外，OUT和INOUT参数不能与RETURNS TABLE符号一起使用。
argname
一个参数的名称。一些语言（包括 SQL 和 PL/pgSQL）允许你在函数体中使用该名称。对于其他语言，输入参数的名称只是额外的文档，就函数本身而言；但是你可以在调用函数时使用输入参数名称来提高可读性（见第 4.3 节）。在任何情况下，输出参数的名称是重要的，因为它定义了结果行类型中的列名。（如果你省略输出参数的名称，系统将选择一个默认的列名。）
argtype
该函数参数（如果有）的数据类型（可以是模式限定的）。参数类型可以是基本类型、组合类型或域类型，或者可以引用一个表列的类型。
根据实现语言，也可以允许指定“伪类型”，例如cstring。伪类型表示实际参数类型没有被完整指定或者不属于普通 SQL 数据类型集合。
可以写table_name.column_name%TYPE来引用一列的类型。使用这种特性有时可以帮助创建一个不受表定义更改影响的函数。
default_expr
如果参数没有被指定值时要用作默认值的表达式。该表达式必须能被强制为该参数的参数类型。只有输入（包括INOUT）参数可以具有默认值。所有跟随在一个具有默认值的参数之后的输入参数也必须有默认值。
rettype
返回数据类型（可能被模式限定）。返回类型可以是一种基本类型、组合类型或域类型，也可以引用一个表列的类型。根据实现语言，也可以允许指定“伪类型”，例如cstring。如果该函数不会返回一个值，可以指定返回类型为void。
当有OUT或者INOUT参数时，可以省略RETURNS子句。如果存在，该子句必须和输出参数所表示的结果类型一致：如果有多个输出参数，则为RECORD，否则与单个输出参数的类型相同。
SETOF修饰符表示该函数将返回一个项的集合，而不是一个单一项。
可以写table_name.column_name%TYPE来引用一列的类型。
column_name
RETURNS TABLE语法中一个输出列的名称。这实际上是另一种声明OUT参数的方法，不过RETURNS TABLE也隐含了RETURNS SETOF。
column_type
RETURNS TABLE语法中的输出列的数据类型。
lang_name
用以实现该函数的语言的名称。可以是sql、c、
internal或者一个用户定义的过程语言的名称，例如plpgsql。
如果指定了sql_body，
则默认值为sql。不推荐使用单引号将名称括起来，并要求大小写匹配。
TRANSFORM { FOR TYPE type_name } [, ... ] }
一个由转换构成的列表，对该函数的调用适用于它们。转换在 SQL 类型和语言相关的数据类型之间进行变换，详见CREATE TRANSFORM。过程语言实现通常把有关内建类型的知识硬编码在代码中，因此那些不需要列举在这里。如果一种过程语言实现不知道如何处理一种类型并且没有转换被提供，它将回退到一种默认的行为来转换数据类型，但是这取决于具体实现。
WINDOWWINDOW表示该函数是一个窗口函数而不是一个普通函数。当前只用于用 C 编写的函数。在替换一个现有函数定义时，不能更改WINDOW属性。
IMMUTABLESTABLEVOLATILE
这些属性告知查询优化器该函数的行为。最多只能指定其中一个。如果这些都不出现，则会默认为VOLATILE。
IMMUTABLE表示该函数不能修改数据库并且对于给定的参数值总是会返回相同的值。也就是说，它不会做数据库查找或者使用没有在其参数列表中直接出现的信息。如果给定该选项，任何用全常量参数对该函数的调用可以立刻用该函数值替换。
STABLE表示该函数不能修改数据库，并且对于相同的参数值，它在一次表扫描中将返回相同的结果。但是这种结果在不同的 SQL 语句执行期间可能会变化。对于那些结果依赖于数据库查找、参数变量（例如当前时区）等的函数来说，这是合适的（对希望查询被当前命令修改的行的AFTER触发器不适合）。还要注意current_timestamp函数族适合被标记为稳定，因为它们的值在一个事务内不会改变。
VOLATILE表示该函数的值在一次表扫描中都有可能改变，因此不能做优化。在这种意义上，相对较少的数据库函数是可变的，一些例子是random()、currval()、timeofday()。但是注意任何有副作用的函数都必须被分类为可变的，即便其结果是可以预测的，这是为了防止调用被优化掉。一个例子是setval()。
更多细节可见第 36.7 节。
LEAKPROOF
LEAKPROOF表示该函数没有副作用。它不会泄露有关其参数的信息（除了通过返回值）。例如，一个只对某些参数值抛出错误消息而对另外一些却不抛出错误的函数不是防泄漏的，一个把参数值包括在任何错误消息中的函数也不是防泄漏的。这会影响系统如何执行在使用security_barrier选项创建的视图或者开启了行级安全性的表上执行查询。对于包含有非防泄漏函数的查询，系统将在任何来自查询本身的用户提供条件之前强制来自安全策略或者安全屏障的条件，防止无意中的数据暴露。被标记为防泄漏的函数和操作符被假定是可信的，并且可以在安全性策略和安全性屏障视图的条件之前被执行。此外，没有参数的函数或者不从安全屏障视图或表传递任何参数的函数不一定要被标记为防泄漏的。详见CREATE VIEW和第 39.5 节。这个选项只能由超级用户设置。
CALLED ON NULL INPUTRETURNS NULL ON NULL INPUTSTRICTCALLED ON NULL INPUT（默认）表示在某些参数为空值时应正常调用该函数。如果有必要，函数的作者应该负责检查空值并做出适当的响应。
RETURNS NULL ON NULL INPUT或STRICT表示只要其任意参数为空值，该函数就会返回空值。如果指定了这个参数，当有空值参数时该函数不会被执行，而是自动返回一个空值结果。
[EXTERNAL] SECURITY INVOKER[EXTERNAL] SECURITY DEFINERSECURITY INVOKER表示函数将以调用它的用户的权限执行。
这是默认设置。SECURITY DEFINER
指定函数将以拥有它的用户的权限执行。有关如何安全地编写
SECURITY DEFINER 函数的信息，
请参见下文。
为了符合 SQL，允许使用关键词EXTERNAL。但是它是可选的，因为与 SQL 中不同，这个特性适用于所有函数而不仅是那些外部函数。
PARALLEL
PARALLEL UNSAFE表示该函数不能在并行模式下执行；
在 SQL 语句中存在此类函数会强制采用串行执行计划。这是默认设置。
PARALLEL RESTRICTED表示该函数可以在并行模式下执行，
但仅限于并行组的领导进程。PARALLEL SAFE表示该函数
可以安全地在并行模式下运行且不受限制，包括在并行工作进程中。
如果函数修改了任何数据库状态、更改了事务状态（除了使用子事务进行错误恢复之外），
访问序列（例如，通过调用currval）或对设置进行持久更改，则应将其标记为
并行不安全（parallel unsafe）。如果函数访问临时表、客户端连接状态、游标、预准备语句，
或系统无法在并行模式下同步的其他后端本地状态（例如，setseed只能由组
领导者执行，因为其他进程所做的更改不会反映到领导者中），则应将其标记为并行受限
（parallel restricted）。一般来说，如果函数被标记为安全，但实际上是受限或不安全的，
或者被标记为受限，但实际上是不安全的，那么在并行查询中使用时可能会抛出错误或产生错误
结果。理论上，如果C语言函数标记错误，可能会表现出完全未定义的行为，因为系统无法保护
自己免受任意C代码的影响，但在大多数情况下，结果不会比其他函数更糟。如果不确定，函数
应标记为UNSAFE，这是默认设置。
COST execution_cost
一个给出该函数的估计执行代价的正数，单位是cpu_operator_cost。如果该函数返回一个集合，这就是每个被返回行的代价。如果没有指定代价，对C语言和内部函数会指定为1个单位，对其他语言的函数则会指定为100单位。更大的值会导致规划器尝试避免对该函数的不必要的过多计算。
ROWS result_rows
一个正数，它给出规划器期望该函数返回的行数估计。只有当该函数被声明为返回一个集合时才允许这个参数。默认假设为1000行。
SUPPORT support_function
用于此函数的planner support function的名称（可选的模式限定）。
详请参见第 36.11 节。你必须是超级用户才能使用此选项。
configuration_parametervalue
SET子句导致进入该函数时指定配置参数将被设置为指定值。并且在该函数退出时恢复到该参数之前的值。SET FROM CURRENT会把CREATE FUNCTION被执行时该参数的当前值保存为进入该函数时将被应用的值。
如果一个SET子句被附加到一个函数，那么在该函数内为同一个变量执行的SET LOCAL命令会被限制于该函数：在函数退出时该配置参数之前的值仍会被恢复。不过，一个普通的SET命令（没有LOCAL）会覆盖SET子句，更像一个之前的SET LOCAL命令所做的那样：这种命令的效果在函数退出后将会持续，除非当前事务被回滚。
更多有关允许的参数名和参数值的信息请见SET和第 19 章。
definition
一个定义该函数的字符串常量，其含义取决于语言。它可以是一个内部函数名、一个对象文件的路径、一个SQL命令或者用一种过程语言编写的文本。
使用美元引用（参见 第 4.1.2.4 节）来编写函数定义字符串通常是有帮助的，而不是使用普通的单引号语法。如果没有美元引用，函数定义中的任何单引号或反斜线必须通过双写来转义。
obj_file, link_symbol
当 C 语言源代码中函数名称与 SQL 函数名称不同时，这种形式的AS子句用于动态可载入的 C 语言函数。
字符串obj_file是包含编译好的 C 函数的共享库文件的名称，
并且按LOAD命令进行解析。字符串
link_symbol是该函数的链接符号，即 C 语言源代码中的函数名称。如果省略链接符号，则假定它与要定义的 SQL 函数名称相同。所有函数的 C 名称必须不同，因此必须为重载的 C 函数提供不同的 C 名称（例如，将参数类型作为 C 名称的一部分）。
当重复调用CREATE FUNCTION引用同一对象文件时，该文件每个会话只会被加载一次。要卸载并重新加载该文件（可能是在开发期间），需要开始一个新会话。
sql_body
LANGUAGE SQL函数的主体。这可以是单个语句
RETURN expression
或者一个语句块
BEGIN ATOMIC
statement;
statement;
...
statement;
END
这类似于将函数体的文本写成字符串常量（请参见上面的definition），
但有一些不同：此形式仅适用于LANGUAGE SQL，字符串常量形式适用于所有语言。
此形式在函数定义时解析，字符串常量形式在执行时解析；因此，此形式不能支持多态参数类型和其他在函数定义时无法解析的构造。
此形式跟踪函数与函数体中使用的对象之间的依赖关系，因此DROP ... CASCADE
将正常工作，而使用字符串文本的形式可能会留下悬空函数。最后，此形式与 SQL 标准和其他 SQL 实现更加兼容。
重载
PostgreSQL允许函数重载；也就是说，同一个名称可以用于多个不同的函数，只要它们具有可区分的输入参数类型。不管是否使用它，在某些用户不信任其他用户的数据库中调用函数时，这种能力需要安全性预防措施；请参见第 10.3 节。
如果两个函数具有相同的名称和输入参数类型，它们被认为是相同的（不考虑任何OUT参数）。因此，例如，这些声明会冲突：
CREATE FUNCTION foo(int) ...
CREATE FUNCTION foo(int, out text) ...
具有不同参数类型列表的函数在创建时将不会被认为是冲突的，但是如果默认值被提供，在使用时它们有可能会冲突。例如，考虑
CREATE FUNCTION foo(int) ...
CREATE FUNCTION foo(int, int default 42) ...
调用foo(10)将会失败，因为在决定应该调用哪个函数时会有歧义。
备注
允许把完整的SQL类型语法用于声明一个函数的参数和返回值。不过，CREATE FUNCTION会抛弃带圆括号的类型修饰符（例如类型numeric的精度域）。例如CREATE FUNCTION foo (varchar(10)) ...和CREATE FUNCTION foo (varchar) ...完全一样。
在用CREATE OR REPLACE FUNCTION替换一个现有函数时，对于更改参数名是有限制的。不能更改已经分配给任何输入参数的名称（不过可以给之前没有名称的参数增加名称）。如果有多于一个输出参数，不能更改输出参数的名称，因为可能会改变描述函数结果的匿名组合类型的列名。这些限制是为了确保函数被替换时，已有的对该函数的调用不会停止工作。
如果一个被声明为STRICT的函数带有一个VARIADIC参数，会严格检查该可变数组作为一个整体是否为非空。如果该数组有空值元素，该函数仍将被调用。
示例
使用SQL函数对两个整数相加：
CREATE FUNCTION add(integer, integer) RETURNS integer
AS 'select $1 + $2;'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;
同一个函数以更符合SQL习惯的样式编写，使用参数名称和未加引号的函数体，如下：
CREATE FUNCTION add(a integer, b integer) RETURNS integer
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT
RETURN a + b;
在PL/pgSQL中，使用一个参数名称增加一个整数：
CREATE OR REPLACE FUNCTION increment(i integer) RETURNS integer AS $$
BEGIN
RETURN i + 1;
END;
$$ LANGUAGE plpgsql;
返回一个包含多个输出参数的记录：
CREATE FUNCTION dup(in int, out f1 int, out f2 text)
AS $$ SELECT $1, CAST($1 AS text) || ' is text' $$
LANGUAGE SQL;
SELECT * FROM dup(42);
你可以用更复杂的方式（用一个显式命名的组合类型）来做同样的事情：
CREATE TYPE dup_result AS (f1 int, f2 text);
CREATE FUNCTION dup(int) RETURNS dup_result
AS $$ SELECT $1, CAST($1 AS text) || ' is text' $$
LANGUAGE SQL;
SELECT * FROM dup(42);
另一种返回多列的方法是使用一个TABLE函数：
CREATE FUNCTION dup(int) RETURNS TABLE(f1 int, f2 text)
AS $$ SELECT $1, CAST($1 AS text) || ' is text' $$
LANGUAGE SQL;
SELECT * FROM dup(42);
不过，TABLE函数与之前的例子不同，因为它实际返回了一个记录集合而不只是一个记录。
安全地编写 SECURITY DEFINER 函数
因为一个SECURITY DEFINER函数会被以创建它的用户的特权来执行，需要小心地确保该函数不会被误用。为了安全，search_path应该被设置为排除任何不可信用户可写的模式。这可以阻止恶意用户创建对象（例如表、函数以及操作符）来掩饰该函数所要用到的对象。在这方面特别重要的是临时表模式，默认情况下它会第一个被搜索并且通常对任何用户都是可写的。可以通过强制最后搜索临时模式来得到一种安全的布局。要这样做，把pg_temp写成search_path中的最后一项。这个函数展示了安全的用法：
CREATE FUNCTION check_password(uname TEXT, pass TEXT)
RETURNS BOOLEAN AS $$
DECLARE passed BOOLEAN;
BEGIN
SELECT  (pwd = $2) INTO passed
FROM    pwds
WHERE   username = $1;
RETURN passed;
END;
$$  LANGUAGE plpgsql
SECURITY DEFINER
-- 设置一个安全的 search_path：受信的模式，然后是 'pg_temp'。
SET search_path = admin, pg_temp;
这个函数的目的是为了访问表admin.pwds。但是如果没有SET子句或者带有SET子句却只提到admin，该函数会变成创建一个名为pwds的临时表。
如果安全定义者函数打算创建角色，并且它以非超级用户身份运行，
createrole_self_grant也应该使用SET
子句设置为一个已知的值。
另一点要记住的是默认情况下，会为新创建的函数给PUBLIC授予执行特权（详见第 5.8 节）。你常常会希望把安全定义器函数的使用限制在某些用户中。要这样做，你必须收回默认的PUBLIC特权，然后选择性地授予执行特权。为了避免出现新函数能被所有人访问的时间窗口，应在一个事务中创建它并且设置特权。例如：
BEGIN;
CREATE FUNCTION check_password(uname TEXT, pass TEXT) ... SECURITY DEFINER;
REVOKE ALL ON FUNCTION check_password(uname TEXT, pass TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION check_password(uname TEXT, pass TEXT) TO admins;
COMMIT;
兼容性
SQL标准中定义了CREATE FUNCTION命令。
PostgreSQL实现可以以兼容的方式使用，但有许多扩展。
相反，SQL标准指定了许多未在PostgreSQL中实现的可选功能。
以下是重要的兼容性问题：
OR REPLACE是PostgreSQL的扩展。
为了与其他一些数据库系统兼容，argmode
可以在argname之前或之后写入。
但只有第一种方式符合标准。
对于参数默认值，SQL标准仅指定带有DEFAULT关键字的语法。
=的语法是在T-SQL和Firebird中被使用的。
SETOF修饰符是PostgreSQL的扩展。
只有SQL是被标准化的一个语言。
除了CALLED ON NULL INPUT和
RETURNS NULL ON NULL INPUT以外的所有其他属性都没有标准化。
对于LANGUAGE SQL函数的主体，SQL标准只指定了
sql_body形式。
简单的LANGUAGE SQL函数可以以既符合标准又可移植到其他实现的方式编写。
使用高级特性、优化属性或其他语言的更复杂的函数必然在很大程度上特定于PostgreSQL。
另见ALTER FUNCTION, DROP FUNCTION, GRANT, LOAD, REVOKE上一页 上一级 下一页CREATE FOREIGN TABLE 起始页 CREATE GROUP
