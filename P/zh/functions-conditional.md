# 9.18. 条件表达式

9.18. 条件表达式
版本：
纠错本页面
搜索
目录导航
❮
❯
9.18. 条件表达式 #9.18.1. CASE9.18.2. COALESCE9.18.3. NULLIF9.18.4. GREATEST 和 LEAST
本节描述在PostgreSQL中可用的SQL兼容的条件表达式。
提示
如果你的需求超过这些条件表达式的能力，你可能会考虑用一种更富表现力的编程语言写一个服务器端函数。
注意
尽管COALESCE、GREATEST和LEAST在语法上类似于函数，但它们不是普通的函数，因此不能使用显式VARIADIC数组参数。
9.18.1. CASE #
SQL CASE表达式是一种通用的条件表达式，类似于其他编程语言中的 if/else 语句：
CASE WHEN condition THEN result
[WHEN ...]
[ELSE result]
END
CASE子句可以用于任何表达式可以出现的地方。每一个condition是一个返回boolean结果的表达式。如果条件的结果为真，那么CASE表达式的值就是符合条件的result，并且剩下的CASE表达式不会被处理。如果条件的结果不为真，那么以相同方式检查任何随后的WHEN子句。如果没有WHEN condition为真，那么CASE表达式的值就是在ELSE子句里的result。如果省略了ELSE子句而且没有条件为真，结果为空。
例子：
SELECT * FROM test;
a
----
1
2
3
SELECT a,
CASE WHEN a=1 THEN 'one'
WHEN a=2 THEN 'two'
ELSE 'other'
END
FROM test;
a | case
----+----------
1 | one
2 | two
3 | other
所有result表达式的数据类型都必须可以转换成单一的输出类型。 参阅第 10.5 节获取更多细节。
下面这个“简单”形式的CASE表达式是上述通用形式的一个变种：
CASE expression
WHEN value THEN result
[WHEN ...]
[ELSE result]
END
第一个expression会被计算，然后与所有在WHEN子句中的每一个value对比，直到找到一个相等的。如果没有找到匹配的，则返回在ELSE子句中的result（或者空值）。这类似于 C 里的switch语句。
上面的例子可以用简单CASE语法来写：
SELECT a,
CASE a WHEN 1 THEN 'one'
WHEN 2 THEN 'two'
ELSE 'other'
END
FROM test;
a | case
----+----------
1 | one
2 | two
3 | other
CASE表达式并不计算任何无助于判断结果的子表达式。例如，下面是一个可以避免被零除错误的方法：
SELECT ... WHERE CASE WHEN x <> 0 THEN y/x > 1.5 ELSE false END;
注意
如第 4.2.14 节中所述，在有几种情况中一个表达式的子表达式
会被计算多次，因此“CASE只计算必要的子表达式”这
一原则并非不可打破。例如一个常量子表达式1/0通常将会在规划时导致一次
除零错误，即便它位于一个执行时永远也不会进入的CASE分支时也是
如此。
9.18.2. COALESCE #
COALESCE(value [, ...])
COALESCE函数返回它的第一个非空参数的值。当且仅当所有参数都为空时才会返回空。它常用于在为显示目的检索数据时用默认值替换空值。例如：
SELECT COALESCE(description, short_description, '(none)') ...
如果description不为空，这将会返回它的值，否则如果short_description非空则返回short_description的值，如果前两个都为空则返回(none)。
所有参数都必须转换为一个公共数据类型，它将是结果的类型 (详见
第 10.5 节 )。
和CASE表达式一样，COALESCE只
计算用于确定结果的参数；也就是说，在第一个非空参数右边的参数不会被计算。这个 SQL 标准函数提供了类似于NVL和IFNULL的能力，它们被用在某些其他数据库系统中。
9.18.3. NULLIF #
NULLIF(value1, value2)
NULLIF 函数在 value1 等于 value2 时返回一个空值；否则返回 value1。
这可以用于执行前文给出的 COALESCE 例子的逆操作：
SELECT NULLIF(value, '(none)') ...
在这个例子中，如果 value 是 (none)，将返回空值，否则返回 value 的值。
这两个参数必须具有可比较的类型。具体来说，它们的比较与你写的 value1 = value2 完全一样，因此必须有一个合适的 = 操作符可用。
结果的类型与第一个参数相同，但有一点细微的区别。实际上返回的是隐含 = 操作符的第一个参数，在某些情况下，它将被提升以匹配第二个参数的类型。
例如，NULLIF(1, 2.2) 生成 numeric，因为没有 integer = numeric 操作符，只有 numeric = numeric。
9.18.4. GREATEST 和 LEAST #
GREATEST(value [, ...])
LEAST(value [, ...])
GREATEST和LEAST函数从任意数量的表达式
列表中选择最大或最小值。这些表达式必须都可以转换为一种通用的数据类型，
该数据类型将是结果的类型
（详见第 10.5 节）。
参数列表中的NULL值会被忽略。只有当所有表达式的计算结果都为NULL时，
结果才会是NULL。（这与SQL标准有所不同。根据标准，如果任何一个参数
为NULL，则返回值应为NULL。一些其他数据库也是这样处理的。）
上一页 上一级 下一页9.17. 序列操作函数 起始页 9.19. 数组函数和操作符
