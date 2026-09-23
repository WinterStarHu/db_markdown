# 4.3. 调用函数

4.3. 调用函数
版本：
纠错本页面
搜索
目录导航
❮
❯
4.3. 调用函数 #4.3.1. 使用位置记号法4.3.2. 使用命名记号法4.3.3. 使用混合表示法
PostgreSQL允许带有命名参数的函数被使用位置或命名记号法调用。命名记号法对于有大量参数的函数特别有用，因为它让参数和实际参数之间的关联更明显和可靠。在位置记号法中，书写一个函数调用时，其参数值要按照它们在函数声明中被定义的顺序书写。在命名记号法中，参数根据名称匹配函数参数，并且可以以任何顺序书写。对于每一种记法，还要考虑函数参数类型的效果，这些在第 10.3 节有介绍。
在任意一种记号法中，在函数声明中给出了默认值的参数根本不需要在调用中写出。但是这在命名记号法中特别有用，因为任何参数的组合都可以被忽略；而在位置记号法中参数只能从右往左忽略。
PostgreSQL也支持混合记号法，它组合了位置和命名记号法。在这种情况下，位置参数被首先写出，并且命名参数出现在其后。
下列例子将展示所有三种记号法的用法：
CREATE FUNCTION concat_lower_or_upper(a text, b text, uppercase boolean DEFAULT false)
RETURNS text
AS
$$
SELECT CASE
WHEN $3 THEN UPPER($1 || ' ' || $2)
ELSE LOWER($1 || ' ' || $2)
END;
$$
LANGUAGE SQL IMMUTABLE STRICT;
函数concat_lower_or_upper有两个强制参数，a和b。此外，有一个可选的参数uppercase，其默认值为false。a和b输入将被串接，并且根据uppercase参数被强制为大写或小写形式。这个函数的剩余细节对这里并不重要（详见第 36 章）。
4.3.1. 使用位置记号法 #
位置记号法是在PostgreSQL中将参数传递给函数的传统机制。一个例子是：
SELECT concat_lower_or_upper('Hello', 'World', true);
concat_lower_or_upper
-----------------------
HELLO WORLD
(1 row)
所有参数按顺序指定。结果是大写，因为uppercase被指定为true。
另一个例子是：
SELECT concat_lower_or_upper('Hello', 'World');
concat_lower_or_upper
-----------------------
hello world
(1 row)
这里，uppercase参数被省略，因此它接收其默认值false，导致输出为小写。在位置记号法中，参数可以从右到左省略，只要它们有默认值。
4.3.2. 使用命名记号法 #
在命名表示法中，每个参数的名称都使用=>来与参数表达式分隔开来。
例如：
SELECT concat_lower_or_upper(a => 'Hello', b => 'World');
concat_lower_or_upper
-----------------------
hello world
(1 row)
再次，参数uppercase被省略了，因此它隐式地设置为false。
使用命名表示法的一个优点是参数可以以任何顺序指定，例如：
SELECT concat_lower_or_upper(a => 'Hello', b => 'World', uppercase => true);
concat_lower_or_upper
-----------------------
HELLO WORLD
(1 row)
SELECT concat_lower_or_upper(a => 'Hello', uppercase => true, b => 'World');
concat_lower_or_upper
-----------------------
HELLO WORLD
(1 row)
为了向后兼容，仍支持基于":="的旧语法：
SELECT concat_lower_or_upper(a := 'Hello', uppercase := true, b := 'World');
concat_lower_or_upper
-----------------------
HELLO WORLD
(1 row)
4.3.3. 使用混合表示法 #
混合表示法结合了位置表示法和命名表示法。然而，正如前面提到的，命名参数不能在位置参数之前。
例如：
SELECT concat_lower_or_upper('Hello', 'World', uppercase => true);
concat_lower_or_upper
-----------------------
HELLO WORLD
(1 row)
在上面的查询中，参数a和b是按位置指定的，而uppercase是按名称指定的。
在这个例子中，这只是增加了一点文档说明。对于具有许多具有默认值的参数的更复杂函数，命名或混合表示法可以节省大量编写工作，并减少错误的机会。
注意
命名和混合调用表示法当前不能在调用聚合函数时使用（但是当聚合函数被用作窗口函数时它们可以被使用）。
上一页 上一级 下一页4.2. 值表达式 起始页 第 5 章 数据定义
