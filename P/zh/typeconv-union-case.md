# 10.5. UNION、CASE和相关结构

10.5. UNION、CASE和相关结构
版本：
纠错本页面
搜索
目录导航
❮
❯
10.5. UNION、CASE和相关结构 #
SQL UNION结构必须使可能不相似的类型匹配成为一个单一的结果集。该解析算法被独立地应用到一个联合查询的每个输出列。INTERSECT和EXCEPT采用和UNION相同的方法来解析不相似的类型。其他一些结构，包括 CASE、ARRAY、VALUES，以及 GREATEST 和 LEAST函数，使用相同的算法来使它们的组成表达式匹配并选择一种结果数据类型。
UNION、CASE和相关结构的类型解析
如果所有的输入为相同类型，并且不是unknown，那么就可以确定为该类型。
如果任何输入是一种域类型，在所有后续步骤中都把它当做该域的基类型。
[12]
如果所有的输入为unknown类型，则确定为text（字符串分类的首选类型）。否则，为了剩余规则，unknown输入会被忽略。
如果非未知输入不全是相同的类型分类，则失败。
选择第一个非未知输入类型作为候选类型，然后从左到右考虑其他非未知输入类型。
[13]
如果候选类型可以隐式转换为其他类型，但反之不行，则选择其他类型作为新的候选类型。然后继续考虑剩余的输入。如果在此过程的任何阶段选择了首选类型，请停止考虑其他输入。
将所有输入转换为最终候选类型。如果没有从给定输入类型到候选类型的隐式转换，则失败。
下面是一些例子。
例 10.10. 联合中未指定类型的类型决定
SELECT text 'a' AS "text" UNION SELECT 'b';
text
------
a
b
(2 rows)
这里，未知类型文字'b'将被决定为类型text。
例 10.11. 简单联合中的类型决定
SELECT 1.2 AS "numeric" UNION SELECT 1;
numeric
---------
1
1.2
(2 rows)
文字1.2是numeric类型，且integer值1可以被隐式地转换为numeric，因此使用numeric类型。
例 10.12. 可换位联合中的类型解析
SELECT 1 AS "real" UNION SELECT CAST('2.2' AS REAL);
real
------
1
2.2
(2 rows)
这里，由于类型real不能被隐式地转换为integer，而integer可以被隐式地转换为real，联合结果类型被确定为real。
例 10.13. 嵌套联合中的类型解析
SELECT NULL UNION SELECT NULL UNION SELECT 1;
ERROR:  UNION types text and integer cannot be matched
这个失败发生的原因是PostgreSQL把多个UNION当作是成对操作的嵌套，也就是说上面的输入等同于：
(SELECT NULL UNION SELECT NULL) UNION SELECT 1;
根据上面给定的规则，内层的UNION被确定为类型text。然后外层的UNION的输入是类型text和integer，这就导致了上面看到的错误。通过确保最左边的UNION至少有一个输入类型为想要的结果类型，就可以修正这个问题。
INTERSECT和EXCEPT操作也被当作成对操作。不过，这一节中描述的其他结构会在一个解析步骤中考虑所有的输入。
[12]
多少有些类似于对待用于操作符和函数的域输入的方式，这种行为允许
一种域类型能通过一个UNION或相似的结构保留下来，
只要用户小心地确保所有的输入都是显式地或隐式地准确类型。否则
会使用该域的基类型。
[13]
出于历史原因，CASE将其ELSE子句（如果有的话）视为“第一个”输入，之后再考虑THEN子句。在所有其他情况下，“从左到右”表示表达式在查询文本中出现的顺序。
上一页 上一级 下一页10.4. 值存储 起始页 10.6. SELECT 输出列
