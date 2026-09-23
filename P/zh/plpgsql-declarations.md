# 41.3. 声明

41.3. 声明
版本：
纠错本页面
搜索
目录导航
❮
❯
41.3. 声明 #41.3.1. 声明函数参数41.3.2. ALIAS41.3.3. 复制类型41.3.4. 行类型41.3.5. 记录类型41.3.6. PL/pgSQL变量的排序规则
在一个块中使用的所有变量必须在该块的声明小节中声明（唯一的例外是在一个整数范围上迭代的FOR循环变量会被自动声明为一个整数变量，并且相似地在一个游标结果上迭代的FOR循环变量会被自动声明为一个记录变量）。
PL/pgSQL变量可以是任意 SQL 数据类型，例如integer、varchar和char。
这里是变量声明的一些例子：
user_id integer;
quantity numeric(5);
url varchar;
myrow tablename%ROWTYPE;
myfield tablename.columnname%TYPE;
arow RECORD;
一个变量声明的一般语法是：
name [ CONSTANT ] type [ COLLATE collation_name ] [ NOT NULL ] [ { DEFAULT | := | = } expression ];
如果给定DEFAULT子句，它会指定进入该块时分
配给该变量的初始值。如果没有给出DEFAULT子句，
则该变量被初始化为SQL空值。
CONSTANT选项阻止该变量在初始化之后被赋值，
这样它的值在块的持续期内保持不变。COLLATE
选项指定用于该变量的一个排序规则（见
第 41.3.6 节）。如果指
定了NOT NULL，对该变量赋值为空值会导致一个
运行时错误。所有被声明为NOT NULL的变量必须
被指定一个非空默认值。
等号（=）可以被用来代替 PL/SQL-兼容的
:=。
一个变量的默认值会在每次进入该块时被计算并且赋值给该变量（不是每次函数调用只计算一次）。因此，例如将now()赋值给类型为timestamp的一个变量将会导致该变量具有当前函数调用的时间，而不是该函数被预编译的时间。
示例:
quantity integer DEFAULT 32;
url varchar := 'http://mysite.com';
transaction_time CONSTANT timestamp with time zone := now();
一旦声明，变量的值可以在同一块中的后续初始化表达式中使用，例如：
DECLARE
x integer := 1;
y integer := x + 1;
41.3.1. 声明函数参数 #
传递给函数的参数被命名为标识符$1、$2，
等等。可选地，能够为$n参数名声明别名来增加可读性。不管是别名还是数字标识符都能用来引用参数值。
有两种方式来创建一个别名。比较好的方式是在CREATE FUNCTION命令中为参数给定一个名称。例如：
CREATE FUNCTION sales_tax(subtotal real) RETURNS real AS $$
BEGIN
RETURN subtotal * 0.06;
END;
$$ LANGUAGE plpgsql;
另一种方式是显式地使用声明语法声明一个别名。
name ALIAS FOR $n;
使用这种风格的同一个例子看起来是：
CREATE FUNCTION sales_tax(real) RETURNS real AS $$
DECLARE
subtotal ALIAS FOR $1;
BEGIN
RETURN subtotal * 0.06;
END;
$$ LANGUAGE plpgsql;
注意
这两个例子并非完全等效。在第一种情况中，subtotal可以被引用为sales_tax.subtotal，但在第二种情况中它不能这样引用（如果我们为内层块附加了一个标签，subtotal则可以用那个标签限定）。
更多一些例子：
CREATE FUNCTION instr(varchar, integer) RETURNS integer AS $$
DECLARE
v_string ALIAS FOR $1;
index ALIAS FOR $2;
BEGIN
-- 这里是一些使用 v_string 和 index 的计算
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION concat_selected_fields(in_t sometablename) RETURNS text AS $$
BEGIN
RETURN in_t.f1 || in_t.f3 || in_t.f5 || in_t.f7;
END;
$$ LANGUAGE plpgsql;
当一个PL/pgSQL函数被声明为带有输出参数，输出参数可以用普通输入参数相同的方式被给定$n名称以及可选的别名。一个输出参数实际上是一个最初为 NULL 的变量，它应当在函数的执行期间被赋值。该参数的最终值就是要被返回的东西。例如，sales-tax 例子也可以用这种方式来做：
CREATE FUNCTION sales_tax(subtotal real, OUT tax real) AS $$
BEGIN
tax := subtotal * 0.06;
END;
$$ LANGUAGE plpgsql;
注意我们忽略了RETURNS real — 我们也可以包括它，但是那将是冗余。
调用带有 OUT 参数的函数，在函数调用中省略输出参数：
SELECT sales_tax(100.00);
当返回多个值时，输出参数最有用。一个小例子是：
CREATE FUNCTION sum_n_product(x int, y int, OUT sum int, OUT prod int) AS $$
BEGIN
sum := x + y;
prod := x * y;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM sum_n_product(2, 4);
sum | prod
-----+------
6 |    8
如第 36.5.4 节中所讨论的，这实际上为该函数的结果创建了一个匿名记录类型。如果给定了一个RETURNS子句，它必须说RETURNS record。
对于存储过程同样有效，例如：
CREATE PROCEDURE sum_n_product(x int, y int, OUT sum int, OUT prod int) AS $$
BEGIN
sum := x + y;
prod := x * y;
END;
$$ LANGUAGE plpgsql;
在一次存储过程调用中，所有参数必须定义申明。对于输出参数，SQL调用执行存储过程时可指定为NULL:
CALL sum_n_product(2, 4, NULL, NULL);
sum | prod
-----+------
6 |    8
但是，当通过 PL/pgSQL调用执行存储过程时, 你应该为任何输出参数写一个变量；该变量将接收调用的结果。 详见 第 41.6.3 节。
声明一个PL/pgSQL函数的另一种方式是用RETURNS TABLE，例如：
CREATE FUNCTION extended_sales(p_itemno int)
RETURNS TABLE(quantity int, total numeric) AS $$
BEGIN
RETURN QUERY SELECT s.quantity, s.quantity * s.price FROM sales AS s
WHERE s.itemno = p_itemno;
END;
$$ LANGUAGE plpgsql;
这和声明一个或多个OUT参数并且指定RETURNS SETOF sometype完全等效。
当PL/pgSQL函数的返回类型被声明为多态类型（参见第 36.2.5 节）时，
一个特殊的参数 $0 已创建。它的数据类型是函数的实际返回类型，从实际输入类型推导出来。
这允许函数访问其实际的返回类型，如第 41.3.3 节所示。
$0被初始化为空并且可以被该函数修改，因此它能够被用来保持可能需要的返回值，不过这不是必须的。
$0也可以被给定一个别名。例如，这个函数工作在任何具有一个+操作符的数据类型上：
CREATE FUNCTION add_three_values(v1 anyelement, v2 anyelement, v3 anyelement)
RETURNS anyelement AS $$
DECLARE
result ALIAS FOR $0;
BEGIN
result := v1 + v2 + v3;
RETURN result;
END;
$$ LANGUAGE plpgsql;
通过声明一个或多个输出参数为多态类型可以得到同样的效果。在这种情况下，不使用特殊的$0参数，输出参数本身就用作相同的目的。例如：
CREATE FUNCTION add_three_values(v1 anyelement, v2 anyelement, v3 anyelement,
OUT sum anyelement)
AS $$
BEGIN
sum := v1 + v2 + v3;
END;
$$ LANGUAGE plpgsql;
在实践中，使用anycompatible类型系列声明多态函数可能更有用，以便将输入参数自动提升为公共类型。例如：
CREATE FUNCTION add_three_values(v1 anycompatible, v2 anycompatible, v3 anycompatible)
RETURNS anycompatible AS $$
BEGIN
RETURN v1 + v2 + v3;
END;
$$ LANGUAGE plpgsql;
在此示例中，调用如
SELECT add_three_values(1, 2, 4.7);
将工作，自动将整数输入提升为数字。使用anyelement的函数需要您手动将三个输入转换为相同的类型。
41.3.2. ALIAS #
newname ALIAS FOR oldname;
ALIAS语法比前一节中建议的更一般化：你可以为任意变量声明一个别名，而不只是函数参数。其主要实际用途是为预先决定名称的变量分配一个不同的名称，例如在一个触发器函数中的NEW或OLD。
例子：
DECLARE
prior ALIAS FOR old;
updated ALIAS FOR new;
因为ALIAS创造了两种不同的方式来命名相同的对象，如果对其使用不加限制就会导致混淆。最好只把它用来覆盖预先决定的名称。
41.3.3. 复制类型 #
name table.column%TYPE
name variable%TYPE
%TYPE 提供表列或先前声明的
PL/pgSQL 变量的数据类型。您可以使用它来声明将保存数据库值的变量。
例如，假设您有一个名为 user_id 的列，位于您的
users 表中。要声明一个与 users.user_id 相同数据类型的变量，
您可以这样写：
user_id users.user_id%TYPE;
也可以在%TYPE之后写数组修饰符，从而创建一个保存所引用类型数组的变量：
user_ids users.user_id%TYPE[];
user_ids users.user_id%TYPE ARRAY[4];  -- 等同于上面写法
就像声明表中数组列时一样，无论是写多个括号对还是具体的数组维度都无关紧要：
PostgreSQL将给定元素类型的所有数组视为相同类型，
与维度无关。（参见第 8.15.1 节。）
通过使用%TYPE，你不需要知道你要引用的结构的实际数据类型，而且最重要的是，如果被引用项的数据类型在未来被改变（例如你把user_id的类型从integer改为real），你不需要改变你的函数定义。
%TYPE在多态函数中特别有价值，因为内部变量所需的数据类型能在两次调用时改变。可以把%TYPE应用在函数的参数或结果占位符上来创建合适的变量。
41.3.4. 行类型 #
name table_name%ROWTYPE;
name composite_type_name;
一个组合类型的变量被称为一个行变量（或行类型变量）。这样一个变量可以保存一个SELECT或FOR查询结果的一整行，前提是查询的列集合匹配该变量被声明的类型。该行值的各个字段可以使用通常的点号标记访问，例如rowvar.field。
通过使用table_name%ROWTYPE标记，一个行变量可以被声明为具有和一个现有表或视图的行相同的类型。它也可以通过给定一个组合类型名称来声明（因为每一个表都有一个相关联的具有相同名称的组合类型，所以在PostgreSQL中实际上写不写%ROWTYPE都没有关系。但是带有%ROWTYPE的形式可移植性更好）。
如同%TYPE，%ROWTYPE后面可以跟数组修饰符，
用于声明一个保存所引用组合类型数组的变量。
一个函数的参数可以是组合类型（完整的表行）。在这种情况下，相应的标识符$n将是一个行变量，并且可以从中选择字段，例如$1.user_id。
这里是一个使用组合类型的例子。table1和table2是已有的表，它们至少有以下提到的字段：
CREATE FUNCTION merge_fields(t_row table1) RETURNS text AS $$
DECLARE
t2_row table2%ROWTYPE;
BEGIN
SELECT * INTO t2_row FROM table2 WHERE ... ;
RETURN t_row.f1 || t2_row.f3 || t_row.f5 || t2_row.f7;
END;
$$ LANGUAGE plpgsql;
SELECT merge_fields(t.*) FROM table1 t WHERE ... ;
41.3.5. 记录类型 #
name RECORD;
记录变量和行类型变量类似，但是它们没有预定义的结构。它们采用在一个SELECT或FOR命令期间为其赋值的行的真实行结构。一个记录变量的子结构能在每次它被赋值时改变。这样的结果是直到一个记录变量第一次被赋值之前，它都没有子结构，并且任何尝试访问其中一个字段都会导致一个运行时错误。
注意RECORD并非一个真正的数据类型，只是一个占位符。我们也应该认识到当一个PL/pgSQL函数被声明为返回类型record，这与一个记录变量并不是完全相同的概念，即便这样一个函数可能会用一个记录变量来保存其结果。在两种情况下，编写函数时都不知道真实的行结构，但是对于一个返回record的函数，当调用查询被解析时就已经决定了真正的结构，而一个记录变量能够随时改变它的行结构。
41.3.6. PL/pgSQL变量的排序规则 #
当一个PL/pgSQL函数有一个或多个可排序数据类型的参数时，为每一次函数调用都会基于赋值给实参的排序规则来确定出一个排序规则，如第 23.2 节中所述。如果一个排序规则被成功地确定（即在参数之间隐式排序规则没有冲突），那么所有的可排序参数会被当做隐式具有那个排序规则。这将在函数中影响行为受到排序规则影响的操作。例如，考虑
CREATE FUNCTION less_than(a text, b text) RETURNS boolean AS $$
BEGIN
RETURN a < b;
END;
$$ LANGUAGE plpgsql;
SELECT less_than(text_field_1, text_field_2) FROM table1;
SELECT less_than(text_field_1, text_field_2 COLLATE "C") FROM table1;
less_than的第一次使用将会采用text_field_1和text_field_2共同的排序规则进行比较，而第二次使用将采用C排序规则。
此外，被确定的排序规则也被假定为任何可排序数据类型本地变量的排序规则。因此，当这个函数被写为以下形式时，它的工作将不会有什么不同
CREATE FUNCTION less_than(a text, b text) RETURNS boolean AS $$
DECLARE
local_a text := a;
local_b text := b;
BEGIN
RETURN local_a < local_b;
END;
$$ LANGUAGE plpgsql;
如果没有可排序数据类型的参数，或者不能为它们确定共同的排序规则，那么参数和本地变量会使用它们数据类型的默认排序规则（通常是数据库的默认排序规则，但是可能不同于域类型的变量）。
通过在一个可排序数据类型的本地变量的声明中包括COLLATE选项，可以为它指定一个不同的排序规则，例如
DECLARE
local_a text COLLATE "en_US";
这个选项会覆盖根据上述规则给予该变量的排序规则。
还有，如果一个函数想要强制在一个特定操作中使用一个特定排序规则，当然可以在该函数内部写一个显式的COLLATE子句。例如：
CREATE FUNCTION less_than_c(a text, b text) RETURNS boolean AS $$
BEGIN
RETURN a < b COLLATE "C";
END;
$$ LANGUAGE plpgsql;
这会覆盖表达式中使用的表列、参数或本地变量相关的排序规则，就像在纯 SQL 命令中发生的一样。
上一页 上一级 下一页41.2. PL/pgSQL的结构 起始页 41.4. 表达式
