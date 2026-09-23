# 7.4. 组合查询 (UNION, INTERSECT, EXCEPT)

7.4. 组合查询 (UNION, INTERSECT, EXCEPT)
版本：
纠错本页面
搜索
目录导航
❮
❯
7.4. 组合查询 (UNION, INTERSECT, EXCEPT) #
两个查询的结果可以用集合操作并、交、差进行组合。语法是
query1 UNION [ALL] query2
query1 INTERSECT [ALL] query2
query1 EXCEPT [ALL] query2
query1和query2都是可以使用任何以上特性的查询。
UNION有效地把query2的结果附加到query1的结果上（不过我们不能保证这就是这些行实际被返回的顺序）。此外，它将删除结果中所有重复的行，就像DISTINCT做的那样，除非你使用了UNION ALL。
INTERSECT返回那些同时存在于query1和query2的结果中的行，除非声明了INTERSECT ALL，否则所有重复行都被消除。
EXCEPT返回所有在query1的结果中但是不在query2的结果中的行（有时这叫做两个查询的差）。同样的，除非声明了EXCEPT ALL，否则所有重复行都被消除。
为了计算两个查询的并、交、差，这两个查询必须是“并操作兼容的”，这意味着它们都返回相同数量的列，并且对应的列有兼容的数据类型，如第 10.5 节中描述的那样。
集合操作可以组合使用，例如：
query1 UNION query2 EXCEPT query3
等价于：
(query1 UNION query2) EXCEPT query3
如下所示，您可以使用括号来控制计算顺序。如果没有括号，则UNION和EXCEPT从左到右进行关联，但INTERSECT的绑定比这两个运算符更紧密。因此
query1 UNION query2 INTERSECT query3
意思是
query1 UNION (query2 INTERSECT query3)
你也可以用括号包裹一个单独的query。如果query需要使用后续部分中讨论的任何子句（例如LIMIT），那么这一点非常重要。没有括号，将会得到语法错误，否则子句将被解析为适用于集合操作的输出，而不是它的输入之一。例如，
SELECT a FROM b UNION SELECT x FROM y LIMIT 10
是可以接受的，但它的意思是
(SELECT a FROM b UNION SELECT x FROM y) LIMIT 10
不是
SELECT a FROM b UNION (SELECT x FROM y LIMIT 10)
上一页 上一级 下一页7.3. 选择列表 起始页 7.5. 行排序 (ORDER BY)
