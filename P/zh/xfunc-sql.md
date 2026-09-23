# 36.5. 查询语言（SQL）函数

36.5. 查询语言（SQL）函数
版本：
纠错本页面
搜索
目录导航
❮
❯
36.5. 查询语言（SQL）函数 #36.5.1. SQL函数的参数36.5.2. SQL 函数在基本类型上36.5.3. 组合类型上的SQL函数36.5.4. 带有输出参数的SQL函数36.5.5. SQL 过程带有输出参数36.5.6. 带有可变数量参数的SQL函数36.5.7. 带有参数默认值的SQL函数36.5.8. SQL 函数作为表来源36.5.9. 返回集合的SQL函数36.5.10. 返回TABLE的SQL函数36.5.11. 多态SQL函数36.5.12. SQL 函数带有排序规则
SQL 函数执行一个由任意 SQL 语句构成的列表，返回列表中最后一个查询的结果。
在简单（非集合）情况下，最后一个查询结果的第一行将被返回。
（记住，一个多行结果的 “第一行” 不是良定义的，除非你使用 ORDER BY。）
如果最后一个查询正好根本不返回行，将会返回空值。
或者，一个 SQL 函数可以通过指定函数的返回类型为 SETOF
sometype 被声明为返回一个集合（也就是多个行），或者等效地声明它为
RETURNS TABLE(columns)。在这种情况下，
最后一个查询结果的所有行会被返回。下文将给出进一步的细节。
SQL函数的主体必须是由分号分隔的SQL语句列表。最后一条语句后的分号是可选的。
除非函数声明返回void，否则最后一条语句必须是一个SELECT，
或者带有RETURNING子句的INSERT、UPDATE、
DELETE或MERGE语句。
任何在SQL语言中的命令集合都可以打包在一起并定义为一个函数。
除了SELECT查询外，这些命令可以包括数据修改查询(INSERT、
UPDATE、DELETE和MERGE)，以及
其他SQL命令。(在SQL函数中不能使用事务控制命令，例如，
COMMIT、SAVEPOINT，以及一些实用命令，例如，
VACUUM。)
然而，最终命令必须是一个SELECT或具有返回函数返回类型的RETURNING子句。
或者，如果您想定义一个执行操作但没有有用值返回的SQL函数，可以将其定义为返回void。
例如，此函数从emp表中删除负薪水的行:
CREATE FUNCTION clean_emp() RETURNS void AS '
DELETE FROM emp
WHERE salary < 0;
' LANGUAGE SQL;
SELECT clean_emp();
clean_emp
-----------
(1 row)
你也可以把这个写为一个过程，那样避免返回类型的问题。
例如：
CREATE PROCEDURE clean_emp() AS '
DELETE FROM emp
WHERE salary < 0;
' LANGUAGE SQL;
CALL clean_emp();
在像这样的简单情况中，函数与过程返回void的差异主要是风格上的。
然而，过程提供函数中不具备的附加功能，例如事务控制。
而且，过程是SQL标准，而返回void是PostgreSQL扩展。
CREATE FUNCTION命令的语法要求函数体被写作一个字符串常量。使用用于字符串常量的美元引用通常最方便（见第 4.1.2.4 节）。如果你选择使用常规的单引号引用的字符串常量语法，你必须在函数体中双写单引号（'）和反斜线（\）（假定转义字符串语法）（见第 4.1.2.1 节）。
36.5.1. SQL函数的参数 #
一个 SQL 函数的参数可以在函数体中用名称或编号引用。下面会有两种方法的例子。
要使用一个名称，将函数参数声明为带有一个名称，然后在函数体中只写该名称。如果参数名称与函数内当前 SQL 命令中的任意列名相同，列名将优先。如果不想这样，可以用函数本身的名称来限定参数名，也就是function_name.argument_name（如果这会与一个被限定的列名冲突，照例还是列名优先。你可以通过为 SQL 命令中的表选择一个不同的别名来避免这种混淆）。
在更旧的数字方法中，参数可以用语法$n引用：$1指的是第一个输入参数，$2指的是第二个，以此类推。不管特定的参数是否使用名称声明，这种方法都有效。
如果一个参数是一种组合类型，那么点号记法（如
argname.fieldname
或$1.fieldname）也可以被用来
访问该参数的属性。同样，你可能需要用函数的名称来限定参数的名称以避免歧义。
SQL 函数参数只能被用作数据值而不能作为标识符。例如这是合理的：
INSERT INTO mytable VALUES ($1);
但这样就不行：
INSERT INTO $1 VALUES (42);
注意
使用名称来引用 SQL 函数参数的能力是在PostgreSQL 9.2 中加入的。要在旧的服务器中使用的函数必须使用$n记法。
36.5.2. SQL 函数在基本类型上 #
最简单的SQL函数没有参数并且简单地返回一个基本类型，例如integer：
CREATE FUNCTION one() RETURNS integer AS $$
SELECT 1 AS result;
$$ LANGUAGE SQL;
-- 字符串字面量的替代语法：
CREATE FUNCTION one() RETURNS integer AS '
SELECT 1 AS result;
' LANGUAGE SQL;
SELECT one();
one
-----
1
注意我们为该函数的结果在函数体内定义了一个列别名（名为result），但是这个列别名在函数以外是不可见的。因此，结果被标记为one而不是result。
定义用基本类型作为参数的SQL函数也很容易：
CREATE FUNCTION add_em(x integer, y integer) RETURNS integer AS $$
SELECT x + y;
$$ LANGUAGE SQL;
SELECT add_em(1, 2) AS answer;
answer
-----
3
我们也能省掉参数的名称而使用数字：
CREATE FUNCTION add_em(integer, integer) RETURNS integer AS $$
SELECT $1 + $2;
$$ LANGUAGE SQL;
SELECT add_em(1, 2) AS answer;
answer
--------
3
这里是一个更有用的函数，它可以被用来借记一个银行账号：
CREATE FUNCTION tf1 (accountno integer, debit numeric) RETURNS numeric AS $$
UPDATE bank
SET balance = balance - debit
WHERE accountno = tf1.accountno;
SELECT 1;
$$ LANGUAGE SQL;
一个用户可以这样执行这个函数来从账户 17 中借记 $100.00：
SELECT tf1(17, 100.0);
在这个例子中，我们为第一个参数选择了名称accountno，但是这和表bank中的一个列名相同。
在UPDATE命令中，
accountno引用列bank.accountno，因此
tf1.accountno必须被用来引用该参数。
我们当然可以通过为该参数使用一个不同的名称来避免这样的问题。
实际上我们可能喜欢从该函数得到一个更有用的结果而不是一个常数 1，因此一个更可能的定义是：
CREATE FUNCTION tf1 (accountno integer, debit numeric) RETURNS numeric AS $$
UPDATE bank
SET balance = balance - debit
WHERE accountno = tf1.accountno;
SELECT balance FROM bank WHERE accountno = tf1.accountno;
$$ LANGUAGE SQL;
它会调整余额并且返回新的余额。
同样的事情也可以用一个使用RETURNING的命令实现：
CREATE FUNCTION tf1 (accountno integer, debit numeric) RETURNS numeric AS $$
UPDATE bank
SET balance = balance - debit
WHERE accountno = tf1.accountno
RETURNING balance;
$$ LANGUAGE SQL;
如果在SELECT或RETURNING子句中，
SQL函数的最终返回值类型与函数声明的结果类型不完全匹配，
如果可以使用隐式或赋值转换，
PostgreSQL将自动将该值转换为所需类型。
否则，您必须编写显式转换。
例如，假设我们希望前面的add_em函数返回float8类型。
只需编写
CREATE FUNCTION add_em(integer, integer) RETURNS float8 AS $$
SELECT $1 + $2;
$$ LANGUAGE SQL;
因为integer的和可以隐式转换为float8。
（有关转换的更多信息，请参见第 10 章或CREATE CAST。）
36.5.3. 组合类型上的SQL函数 #
在编写使用组合类型参数的函数时，我们必须不仅指定我们想要哪些参数，还要指定参数的期望属性（域）。例如，假定
emp是一个包含雇员数据的表，并且因此它也是该表每一行的组合类型的名称。
这里是一个函数double_salary，它计算某个人的双倍薪水：
CREATE TABLE emp (
name        text,
salary      numeric,
age         integer,
cubicle     point
);
INSERT INTO emp VALUES ('Bill', 4200, 45, '(2,1)');
CREATE FUNCTION double_salary(emp) RETURNS numeric AS $$
SELECT $1.salary * 2 AS salary;
$$ LANGUAGE SQL;
SELECT name, double_salary(emp.*) AS dream
FROM emp
WHERE emp.cubicle ~= point '(2,1)';
name | dream
------+-------
Bill |  8400
注意语法$1.salary的使用是要选择参数行值的一个域。
还要注意调用的SELECT命令是如何使用table_name.*来选择一个表的整个当前行作为一个组合值的。该表行也可以只用表名来引用：
SELECT name, double_salary(emp) AS dream
FROM emp
WHERE emp.cubicle ~= point '(2,1)';
但这种用法已被废弃，因为它很容易让人搞混。
（关于表行的组合值的这两种记法的详细情况请见第 8.16.5 节。）
有时候实时构建一个组合参数很方便。这可以用ROW结构完成。
例如，我们可以调整被传递给函数的数据：
SELECT name, double_salary(ROW(name, salary*1.1, age, cubicle)) AS dream
FROM emp;
也可以构建一个返回组合类型的函数。这是一个返回单一emp行的函数例子：
CREATE FUNCTION new_emp() RETURNS emp AS $$
SELECT text 'None' AS name,
1000.0 AS salary,
25 AS age,
point '(2,2)' AS cubicle;
$$ LANGUAGE SQL;
在这个例子中，我们为每一个属性指定了一个常量值，但是可以用任何计算来替换这些常量。
有关定义函数有两件重要的事情：
查询中的选择列表顺序必须与列在复合类型中出现的顺序完全相同。（正如我们上面所做的那样，命名列与系统无关。）
我们必须确保每个表达式的类型都可以转换为复合类型的相应列的类型。 否则我们会得到这样的错误：
ERROR:  return type mismatch in function declared to return emp
DETAIL:  Final statement returns text instead of point at column 4.
与基本类型的情况一样，系统不会自动插入显式转换，只会插入隐式或赋值转换。
定义同样的函数的一种不同的方法是：
CREATE FUNCTION new_emp() RETURNS emp AS $$
SELECT ROW('None', 1000.0, 25, '(2,2)')::emp;
$$ LANGUAGE SQL;
这里我们写了一个只返回正确组合类型的单一列的SELECT。
在这种情况下这种写法实际并非更好，但是它在一些情况下比较方便
— 例如，我们需要通过调用另一个返回所期望的组合值的函数来计算结果。
另一个例子是，如果我们试图编写一个函数，它返回一个复合类型的域，而不是一个普通的复合类型，
总是有必要把它写成返回单个列，因为没有办法导致整行结果。
我们可以直接调用这个函数或者在一个值表达式中使用它：
SELECT new_emp();
new_emp
--------------------------
(None,1000.0,25,"(2,2)")
或者把它当做一个表函数调用：
SELECT * FROM new_emp();
name | salary | age | cubicle
------+--------+-----+---------
None | 1000.0 |  25 | (2,2)
第二种方式在第 36.5.8 节中有更完全的描述。
当你使用一个返回组合类型的函数时，你可能只想要其结果中的一个域（属性）。
你可以这样做：
SELECT (new_emp()).name;
name
------
None
额外的圆括号是必须的，它用于避免解析器被搞混。如果你不写这些括号，会这样：
SELECT new_emp().name;
ERROR:  syntax error at or near "."
LINE 1: SELECT new_emp().name;
^
另一个选项是使用函数记号来抽取一个属性：
SELECT name(new_emp());
name
------
None
如第 8.16.5 节中所说，字段记法和函数记法是等效的。
另一种使用返回组合类型的函数的方法是把结果传递给另一个接收正确行类型作为输入的函数：
CREATE FUNCTION getname(emp) RETURNS text AS $$
SELECT $1.name;
$$ LANGUAGE SQL;
SELECT getname(new_emp());
getname
---------
None
(1 row)
36.5.4. 带有输出参数的SQL函数 #
一种描述一个函数的结果的替代方法是定义它的输出参数，例如：
CREATE FUNCTION add_em (IN x int, IN y int, OUT sum int)
AS 'SELECT x + y'
LANGUAGE SQL;
SELECT add_em(3,7);
add_em
--------
10
(1 row)
这和第 36.5.2 节中展示的add_em版本没有本质上的不同。输出参数的真正价值是它们提供了一种方便的方法来定义返回多个列的函数。例如，
CREATE FUNCTION sum_n_product (x int, y int, OUT sum int, OUT product int)
AS 'SELECT x + y, x * y'
LANGUAGE SQL;
SELECT * FROM sum_n_product(11,42);
sum | product
-----+---------
53 |     462
(1 row)
这里实际发生的是我们为该函数的结果创建了一个匿名的组合类型。上述例子具有与下面相同的最终结果
CREATE TYPE sum_prod AS (sum int, product int);
CREATE FUNCTION sum_n_product (int, int) RETURNS sum_prod
AS 'SELECT $1 + $2, $1 * $2'
LANGUAGE SQL;
但是不必单独定义组合类型常常很方便。注意输出参数的名称并非只是装饰，而且决定了匿名组合类型的列名（如果你为一个输出参数忽略了名称，系统将自行选择一个名称）。
在从 SQL 调用这样一个函数时，输出参数不会被包括在调用参数列表中。这是因为PostgreSQL只考虑输入参数来定义函数的调用签名。这也意味着在为诸如删除函数等目的引用该函数时只有输入参数有关系。我们可以用下面的命令之一删除上述函数
DROP FUNCTION sum_n_product (x int, y int, OUT sum int, OUT product int);
DROP FUNCTION sum_n_product (int, int);
参数可以被标记为IN（默认）、OUT、INOUT或者VARIADIC。
一个INOUT参数既作为一个输入参数（调用参数列表的一部分）又作为一个输出参数（结果记录类型的一部分）。
VARIADIC参数是输入参数，但被按照下文所述特殊对待。
36.5.5. SQL 过程带有输出参数 #
过程也支持输出参数，但是它们工作方式与函数略有不同。
在CALL命令中，输出参数必须包括在参数列表中。
例如，前面的银行账户借记例程可以像这样写：
CREATE PROCEDURE tp1 (accountno integer, debit numeric, OUT new_balance numeric) AS $$
UPDATE bank
SET balance = balance - debit
WHERE accountno = tp1.accountno
RETURNING balance;
$$ LANGUAGE SQL;
要调用这个例程，必须包括匹配OUT参数的参数。
习惯性的写NULL：
CALL tp1(17, 100.0, NULL);
如果你要写一些其他的，它必须是隐式强制到参数的声明类型中的一个表达式，就像输入参数一样。
注意，无论如何这样的表达式不会被评估。
当从PL/pgSQL调用一个过程时，而不是写NULL，你必须写一个将接收过程输出的变量。
详请参见第 41.6.3 节。
36.5.6. 带有可变数量参数的SQL函数 #
SQL函数可以声明接受可变数量的参数，只要所有“可选”参数都是相同的数据类型。
可选参数将作为数组传递给函数。函数通过将最后一个参数标记为VARIADIC来声明；
此参数必须声明为数组类型。例如：
CREATE FUNCTION mleast(VARIADIC arr numeric[]) RETURNS numeric AS $$
SELECT min($1[i]) FROM generate_subscripts($1, 1) g(i);
$$ LANGUAGE SQL;
SELECT mleast(10, -1, 5, 4.4);
mleast
--------
-1
(1 row)
实际上，所有实际参数在VARIADIC位置或之后都被收集到一个一维数组中，就好像你写了
SELECT mleast(ARRAY[10, -1, 5, 4.4]);    -- does not work
但实际上你不能这样写 — 或者至少，它不会匹配这个函数定义。标记为
VARIADIC的参数匹配其元素类型的一个或多个出现，而不是其自身类型的一个或多个出现。
有时候能够传递一个已经构造好的数组给variadic函数是有用的，特别是当
一个variadic函数想要把它的数组参数传递给另一个函数时这会特别方便。此外，这是在一个允许不可信用户创建对象的方案中调用一个variadic函数的唯一安全的方式，见第 10.3 节。你可以通过在调用中指定VARIADIC来做到这一点：
SELECT mleast(VARIADIC ARRAY[10, -1, 5, 4.4]);
这会阻止该函数的variadic参数扩展成它的元素类型，从而允许数组参数值正常匹配。VARIADIC只能被附着在函数调用的最后一个实参上。
在调用中指定VARIADIC也是将空数组传递给variadic函数的唯一方式，例如：
SELECT mleast(VARIADIC ARRAY[]::numeric[]);
简单地写成SELECT mleast()是没有作用的，因为一个variadic参数必须匹配至少一个实参（如果想允许这类调用，你可以定义第二个没有参数且也叫mleast的函数）。
从一个variadic参数产生的数组元素参数会被当做自己不具有名称。这
意味着不能使用命名参数调用variadic函数（第 4.3 节），除非你指定了
VARIADIC。例如下面的调用是可以工作的：
SELECT mleast(VARIADIC arr => ARRAY[10, -1, 5, 4.4]);
但这些就不行：
SELECT mleast(arr => 10);
SELECT mleast(arr => ARRAY[10, -1, 5, 4.4]);
36.5.7. 带有参数默认值的SQL函数 #
函数可以被声明为对一些或所有输入参数具有默认值。只要调用函数时
没有给出足够多的实参，就会插入默认值来弥补缺失的实参。由于参数只
能从实参列表的尾部开始被省略，在一个有默认值的参数之后的所有参数
都必须也具有默认值（尽管使用命名参数记法可以允许放松这种限制，
这种限制仍然会被强制以便位置参数记法能工作）。不管你是否使用它，这种能力都要求在某些用户不信任其他用户的数据中调用函数时做一些预防措施，见第 10.3 节。
例如:
CREATE FUNCTION foo(a int, b int DEFAULT 2, c int DEFAULT 3)
RETURNS int
LANGUAGE SQL
AS $$
SELECT $1 + $2 + $3;
$$;
SELECT foo(10, 20, 30);
foo
-----
60
(1 row)
SELECT foo(10, 20);
foo
-----
33
(1 row)
SELECT foo(10);
foo
-----
15
(1 row)
SELECT foo();  -- fails since there is no default for the first argument
ERROR:  function foo() does not exist
=符号也可以用来代替关键字DEFAULT。
36.5.8. SQL 函数作为表来源 #
所有的 SQL 函数都可以被用在查询的FROM子句中，但是
对于返回复合类型的函数特别有用。如果函数被定义为返回一种基本类型，
该表函数会产生一个单列表。如果该函数被定义为返回一种复合类型，该
表函数会为该复合类型的每一个属性产生一列。
这里是一个例子：
CREATE TABLE foo (fooid int, foosubid int, fooname text);
INSERT INTO foo VALUES (1, 1, 'Joe');
INSERT INTO foo VALUES (1, 2, 'Ed');
INSERT INTO foo VALUES (2, 1, 'Mary');
CREATE FUNCTION getfoo(int) RETURNS foo AS $$
SELECT * FROM foo WHERE fooid = $1;
$$ LANGUAGE SQL;
SELECT *, upper(fooname) FROM getfoo(1) AS t1;
fooid | foosubid | fooname | upper
-------+----------+---------+-------
1 |        1 | Joe     | JOE
(1 row)
正如例子所示，我们可以把函数结果的列当作常规表的列来使用。
注意我们只从函数得到了一行。这是因为我们没有使用SETOF。
这会在下一节中介绍。
36.5.9. 返回集合的SQL函数 #
当一个 SQL 函数被声明为返回SETOF
sometype时，该函数的
最后一个查询会被执行完，并且它输出的每一行都会被
作为结果集的一个元素返回。
在FROM子句中调用函数时通常会使用这种特性。在这种
情况下，该函数返回的每一行都变成查询所见的表的一行。例如，假设
表foo具有和上文一样的内容，并且我们做了以下动作：
CREATE FUNCTION getfoo(int) RETURNS SETOF foo AS $$
SELECT * FROM foo WHERE fooid = $1;
$$ LANGUAGE SQL;
SELECT * FROM getfoo(1) AS t1;
那么我们会得到：
fooid | foosubid | fooname
-------+----------+---------
1 |        1 | Joe
1 |        2 | Ed
(2 rows)
也可以返回多个带有由输出参数定义的列的行，像这样：
CREATE TABLE tab (y int, z int);
INSERT INTO tab VALUES (1, 2), (3, 4), (5, 6), (7, 8);
CREATE FUNCTION sum_n_product_with_tab (x int, OUT sum int, OUT product int)
RETURNS SETOF record
AS $$
SELECT $1 + tab.y, $1 * tab.y FROM tab;
$$ LANGUAGE SQL;
SELECT * FROM sum_n_product_with_tab(10);
sum | product
-----+---------
11 |      10
13 |      30
15 |      50
17 |      70
(4 rows)
这里的关键点是必须写上RETURNS SETOF record来指示
该函数返回多行而不是一行。如果只有一个输出参数，则写上该参数的
类型而不是record。
通过多次调用集合返回函数来构建查询的结果非常有用，每次调用的参数
来自于一个表或者子查询的连续行。做这种事情最好的方法是使用
LATERAL关键字，该关键字在第 7.2.1.5 节中描述。
这里是一个使用集合返回函数枚举树结构中元素的例子：
SELECT * FROM nodes;
name    | parent
-----------+--------
Top       |
Child1    | Top
Child2    | Top
Child3    | Top
SubChild1 | Child1
SubChild2 | Child1
(6 rows)
CREATE FUNCTION listchildren(text) RETURNS SETOF text AS $$
SELECT name FROM nodes WHERE parent = $1
$$ LANGUAGE SQL STABLE;
SELECT * FROM listchildren('Top');
listchildren
--------------
Child1
Child2
Child3
(3 rows)
SELECT name, child FROM nodes, LATERAL listchildren(name) AS child;
name  |   child
--------+-----------
Top    | Child1
Top    | Child2
Top    | Child3
Child1 | SubChild1
Child1 | SubChild2
(5 rows)
这个例子和我们使用的简单连接的效果没什么不同，但是在更复杂的
计算中，把一些工作放在函数中会是一种很方便的选项。
返回集合的函数也能在查询的选择列表中调用。对于该查询本身产生的每一行都会调用集合返回函数，并且会从该函数的结果集中的每一个元素生成一个输出行。之前的例子也可以用这样的查询实现：
SELECT listchildren('Top');
listchildren
--------------
Child1
Child2
Child3
(3 rows)
SELECT name, listchildren(name) FROM nodes;
name  | listchildren
--------+--------------
Top    | Child1
Top    | Child2
Top    | Child3
Child1 | SubChild1
Child1 | SubChild2
(5 rows)
在最后一个SELECT中，注意对于Child2、
Child3等没有出现输出行。这是因为listchildren
对这些参数返回空集，因此没有产生结果行。这和使用LATERAL
语法时，我们从与该函数结果的内连接得到的行为是一样的。
PostgreSQL中，写在查询的选择列表中的集合返回函数的行为几乎和写在LATERAL FROM子句项中的集合返回函数完全一样。例如：
SELECT x, generate_series(1,5) AS g FROM tab;
几乎等效于
SELECT x, g FROM tab, LATERAL generate_series(1,5) AS g;
这会是完全一样的，除了在这个特别的例子中，规划器会选择把g放在嵌套循环连接的外侧，因为g对tab没有实际的横向依赖。那会导致一种不同的输出行顺序。选择列表中的集合返回函数总是会被计算，就好像它们在FROM子句剩余部分的嵌套循环连接的内侧一样，因此在考虑来自FROM子句的下一行之前，这些函数会运行到完成。
如果在查询的选择列表中有不止一个集合返回函数，则行为类似于把那些函数放到一个单一的LATERAL ROWS FROM( ... ) FROM子句项中的行为。对于来自底层查询的每一行，都有一个用到每个函数首个结果的输出行，然后是一个使用每个函数第二个结果的输出行，以此类推。如果某些集合返回函数产生的输出比其他函数少，会用空值代替缺失的数据，因此为一个底层行形成的总行数等于产生最多输出的集合返回函数的输出行数。因此集合返回函数会“步调一致”地运行直到它们的输出被耗尽，然后用下一个底层行继续执行。
集合返回函数可以被嵌套在一个选择列表中，不过在FROM子句项中不允许这样做。在这种情况下，嵌套的每一层会被单独对待，就像它是一个单独的LATERAL ROWS FROM( ... )项一样。例如，在
SELECT srf1(srf2(x), srf3(y)), srf4(srf5(z)) FROM tab;
中，集合返回函数srf2、srf3和srf5将为tab的每一行步调一致地运行，然后会对较低层的函数产生的每一行以步调一致的形式应用srf1和srf4。
在CASE或COALESCE这样的条件计算结构中，不能使用集合返回函数。例如，考虑
SELECT x, CASE WHEN x > 0 THEN generate_series(1, 5) ELSE 0 END FROM tab;
看起来这个语句应该产生满足x > 0的输入行的五次重复，以及不满足的行的一次重复。但实际上，由于在CASE表达式被计算前，generate_series(1, 5)会被运行在一个隐式的LATERAL FROM项中，它会为每个输入行产生五次重复。为了减少混乱，这类情况会产生一个解析时错误。
注意
如果函数的最后一个命令是INSERT、UPDATE、DELETE或
MERGE并带有RETURNING，该命令将始终执行完成，
即使函数未声明为SETOF，或者调用查询未获取所有结果行。
由RETURNING子句产生的任何额外行都会被静默丢弃，但命令的表修改
仍然会发生（并且在函数返回之前全部完成）。
注意
在PostgreSQL 10之前，在同一选择列表中放置多个集合返回函数
的行为不太合理，除非它们始终产生相等数量的行。否则，您得到的将是由集合返回函数产生的行数的最小公倍数。
此外，嵌套的集合返回函数不像上面描述的那样工作；相反，一个集合返回函数最多可以有一个集合返回参数，
并且每个集合返回函数的嵌套都是独立运行的。此外，以前允许条件执行（在CASE等内部的集合返回函数），
进一步复杂化了事情。
在编写需要在旧版PostgreSQL版本中工作的查询时，建议使用LATERAL语法，
因为这将在不同版本中提供一致的结果。
如果您的查询依赖于集合返回函数的条件执行，您可以通过将条件测试移入自定义集合返回函数来修复它。例如，
SELECT x, CASE WHEN y > 0 THEN generate_series(1, z) ELSE 5 END FROM tab;
可以变成
CREATE FUNCTION case_generate_series(cond bool, start int, fin int, els int)
RETURNS SETOF int AS $$
BEGIN
IF cond THEN
RETURN QUERY SELECT generate_series(start, fin);
ELSE
RETURN QUERY SELECT els;
END IF;
END$$ LANGUAGE plpgsql;
SELECT x, case_generate_series(y > 0, 1, z, 5) FROM tab;
这种表述在所有版本的PostgreSQL中都能正常工作。
36.5.10. 返回TABLE的SQL函数 #
还有另一种方法可以把函数声明为返回一个集合，即使用
RETURNS TABLE(columns)语法。
这等效于使用一个或者多个OUT参数外加把函数标记为返回
SETOF record（或者是SETOF单个输出参数的
类型）。这种写法是在最近的 SQL 标准中指定的，因此可能比使用
SETOF的移植性更好。
例如，前面的求和并相乘的例子也可以这样来做：
CREATE FUNCTION sum_n_product_with_tab (x int)
RETURNS TABLE(sum int, product int) AS $$
SELECT $1 + tab.y, $1 * tab.y FROM tab;
$$ LANGUAGE SQL;
不允许把显式的OUT或INOUT参数用于
RETURNS TABLE记法 — 必须把所有输出列放在
TABLE列表中。
36.5.11. 多态SQL函数 #
SQL函数可以声明为接受和返回第 36.2.5 节中描述的多态类型。
这是一个多态函数make_array，它从两个任意数据类型元素构建一个数组：
CREATE FUNCTION make_array(anyelement, anyelement) RETURNS anyarray AS $$
SELECT ARRAY[$1, $2];
$$ LANGUAGE SQL;
SELECT make_array(1, 2) AS intarray, make_array('a'::text, 'b') AS textarray;
intarray | textarray
----------+-----------
{1,2}    | {a,b}
(1 row)
注意类型转换'a'::text的使用是为了指定该参数的类型
是text。如果该参数只是一个字符串字面量，这就是必须的，因为
否则它会被当作unknown类型，并且
unknown的数组也不是一种合法的类型。如果没有该类型
转换，将得到这样的错误：
ERROR:  could not determine polymorphic type because input has type unknown
使用上述方式声明make_array函数时，必须提供两个完全相同数据类型的参数；
系统不会尝试解决任何类型差异。因此，例如以下操作不起作用：
SELECT make_array(1, 2.5) AS numericarray;
ERROR:  function make_array(integer, numeric) does not exist
另一种方法是使用“common”系列多态类型，允许系统尝试识别一个合适的公共类型：
CREATE FUNCTION make_array2(anycompatible, anycompatible)
RETURNS anycompatiblearray AS $$
SELECT ARRAY[$1, $2];
$$ LANGUAGE SQL;
SELECT make_array2(1, 2.5) AS numericarray;
numericarray
--------------
{1,2.5}
(1 row)
因为当所有输入类型未知时，公共类型解析规则默认选择text类型，所以以下操作也有效：
SELECT make_array2('a', 'b') AS textarray;
textarray
-----------
{a,b}
(1 row)
允许具有多态参数和固定的返回类型，但是反过来不行。例如：
CREATE FUNCTION is_greater(anyelement, anyelement) RETURNS boolean AS $$
SELECT $1 > $2;
$$ LANGUAGE SQL;
SELECT is_greater(1, 2);
is_greater
------------
f
(1 row)
CREATE FUNCTION invalid_func() RETURNS anyelement AS $$
SELECT 1;
$$ LANGUAGE SQL;
ERROR:  cannot determine result data type
DETAIL:  A result of type anyelement requires at least one input of type anyelement, anyarray, anynonarray, anyenum, or anyrange.
多态性可以用在具有输出参数的函数上。例如：
CREATE FUNCTION dup (f1 anyelement, OUT f2 anyelement, OUT f3 anyarray)
AS 'select $1, array[$1,$1]' LANGUAGE SQL;
SELECT * FROM dup(22);
f2 |   f3
----+---------
22 | {22,22}
(1 row)
多态性也可以与可变函数一起使用。
例如：
CREATE FUNCTION anyleast (VARIADIC anyarray) RETURNS anyelement AS $$
SELECT min($1[i]) FROM generate_subscripts($1, 1) g(i);
$$ LANGUAGE SQL;
SELECT anyleast(10, -1, 5, 4);
anyleast
----------
-1
(1 row)
SELECT anyleast('abc'::text, 'def');
anyleast
----------
abc
(1 row)
CREATE FUNCTION concat_values(text, VARIADIC anyarray) RETURNS text AS $$
SELECT array_to_string($2, $1);
$$ LANGUAGE SQL;
SELECT concat_values('|', 1, 4, 2);
concat_values
---------------
1|4|2
(1 row)
36.5.12. SQL 函数带有排序规则 #
当一个 SQL 函数具有一个或多个可排序数据类型的参数时，
对每一次函数调用都会根据分配给实参的排序规则为其确定一个排序规则，
如 第 23.2 节 中所述。如果成功地确定（即在
参数之间没有隐式排序规则的冲突），那么所有的可排序参数都被认为
隐式地具有该排序规则。这将会影响函数中对排序敏感的操作的行为。
例如，使用上述的 anyleast 函数时，
SELECT anyleast('abc'::text, 'ABC');
的结果将依赖于数据库的默认排序规则。在 C 区域中，
结果将是 ABC，但是在许多其他区域中它将是
abc。可以在任意参数上增加一个 COLLATE
子句来强制要使用的排序规则，例如：
SELECT anyleast('abc'::text, 'ABC' COLLATE "C");
此外，如果你希望一个函数用一个特定的排序规则工作而不管用什么排序规则
调用它，可根据需要在函数定义中插入 COLLATE 子句。
这种版本的 anyleast 将总是使用 en_US
区域来比较字符串：
CREATE FUNCTION anyleast (VARIADIC anyarray) RETURNS anyelement AS $$
SELECT min($1[i] COLLATE "en_US") FROM generate_subscripts($1, 1) g(i);
$$ LANGUAGE SQL;
但是注意如果应用到不可排序数据类型上，这将会抛出一个错误。
如果在实参之间无法确定共同的排序规则，那么 SQL 函数会把它的参数
当作拥有其数据类型的默认排序规则（通常是数据库的默认排序规则，
但是域类型的参数可能会不同）。
可排序参数的行为可以被看作是多态的一种受限形式，只适用于文本数据
类型。
上一页 上一级 下一页36.4. 用户定义的过程 起始页 36.6. 函数重载
