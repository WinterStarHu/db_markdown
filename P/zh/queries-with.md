# 7.8. WITH 查询（公共表表达式）

7.8. WITH 查询（公共表表达式）
版本：
纠错本页面
搜索
目录导航
❮
❯
7.8. WITH 查询（公共表表达式） #7.8.1. WITH中的SELECT7.8.2. Recursive Queries7.8.3. Common Table Expression Materialization7.8.4. WITH 中的数据修改语句
WITH 提供了一种编写辅助语句的方法，用于更大范围的查询。
这些语句通常被称为公共表表达式或 CTE，可以被视为定义
仅存在于单个查询中的临时表。WITH 子句中的每个辅助语句
可以是 SELECT、INSERT、UPDATE、
DELETE 或 MERGE；而 WITH 子句
本身附加于一个主语句，该主语句也可以是 SELECT、
INSERT、UPDATE、DELETE 或
MERGE。
7.8.1. WITH中的SELECT #
WITH中SELECT的基本价值是将复杂的查询分解成简单的部分。一个例子：
WITH regional_sales AS (
SELECT region, SUM(amount) AS total_sales
FROM orders
GROUP BY region
), top_regions AS (
SELECT region
FROM regional_sales
WHERE total_sales > (SELECT SUM(total_sales)/10 FROM regional_sales)
)
SELECT region,
product,
SUM(quantity) AS product_units,
SUM(amount) AS product_sales
FROM orders
WHERE region IN (SELECT region FROM top_regions)
GROUP BY region, product;
它只显示在高销售区域每种产品的销售总额。WITH子句定义了两个辅助语句regional_sales和top_regions，其中regional_sales的输出用在top_regions中而top_regions的输出用在主SELECT查询。这个例子可以不用WITH来书写，但是我们必须要用两层嵌套的子SELECT。使用这种方法要更简单些。
7.8.2. Recursive Queries #
可选的RECURSIVE修饰符将WITH从单纯的句法便利变成了一种在标准SQL中不能完成的特性。通过使用RECURSIVE，一个WITH查询可以引用它自己的输出。一个非常简单的例子是计算从1到100的整数和的查询：
WITH RECURSIVE t(n) AS (
VALUES (1)
UNION ALL
SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t;
一个递归WITH查询的通常形式总是一个非递归项，然后是UNION（或者UNION ALL），再然后是一个递归项，其中只有递归项能够包含对于查询自身输出的引用。这样一个查询可以被这样执行：
递归查询求值
计算非递归项。对UNION（但不对UNION ALL），抛弃重复行。把所有剩余的行包括在递归查询的结果中，并且也把它们放在一个临时的工作表中。
只要工作表不为空，重复下列步骤：
计算递归项，用当前工作表的内容替换递归自引用。对UNION（但不对UNION ALL），抛弃重复行以及那些与之前结果行重复的行。将剩下的所有行包括在递归查询的结果中，并且也把它们放在一个临时的中间表中。
用中间表的内容替换工作表的内容，然后清空中间表。
注意
虽然RECURSIVE允许递归指定查询，但在内部这样的查询是迭代评估的。
在上面的例子中，工作表在每一步只有一行，并且它在连续的步骤中取值从1到100。在第100步，由于WHERE子句导致没有输出，因此查询终止。
递归查询通常用于处理分层或树形结构数据。一个有用的例子是这个查询，用于查找产品的所有直接和间接子部件，只给出一个显示直接包含关系的表：
WITH RECURSIVE included_parts(sub_part, part, quantity) AS (
SELECT sub_part, part, quantity FROM parts WHERE part = 'our_product'
UNION ALL
SELECT p.sub_part, p.part, p.quantity * pr.quantity
FROM included_parts pr, parts p
WHERE p.part = pr.sub_part
)
SELECT sub_part, SUM(quantity) as total_quantity
FROM included_parts
GROUP BY sub_part
7.8.2.1. Search Order #
当使用递归查询计算树形遍历时，你可能希望以深度优先或广度优先的顺序对结果进行排序。这可以通过计算与其他数据列一起的排序列来实现，并在最后用它来对结果进行排序。请注意，这实际上并不能控制查询评估访问行的顺序；这在SQL中总是取决于实现。这种方法只是提供了一种方便的方法来对结果进行排序。
为了创建深度优先顺序，我们针对每个结果行计算已访问的行数组。例如，考虑使用link字段对表tree进行搜索的以下查询：
WITH RECURSIVE search_tree(id, link, data) AS (
SELECT t.id, t.link, t.data
FROM tree t
UNION ALL
SELECT t.id, t.link, t.data
FROM tree t, search_tree st
WHERE t.id = st.link
)
SELECT * FROM search_tree;
为了增加深度优先的排序信息，你可以这样写：
WITH RECURSIVE search_tree(id, link, data, path) AS (
SELECT t.id, t.link, t.data, ARRAY[t.id]
FROM tree t
UNION ALL
SELECT t.id, t.link, t.data, path || t.id
FROM tree t, search_tree st
WHERE t.id = st.link
)
SELECT * FROM search_tree ORDER BY path;
在需要使用多个字段来识别行的一般情况下，使用一组行记录。例如，如果我们需要跟踪字段f1和f2：
WITH RECURSIVE search_tree(id, link, data, path) AS (
SELECT t.id, t.link, t.data, ARRAY[ROW(t.f1, t.f2)]
FROM tree t
UNION ALL
SELECT t.id, t.link, t.data, path || ROW(t.f1, t.f2)
FROM tree t, search_tree st
WHERE t.id = st.link
)
SELECT * FROM search_tree ORDER BY path;
提示
在通常情况下只需要跟踪一个字段，可以省略 ROW() 语法。这样可以使用简单的数组而不是复合类型数组，提高效率。
为了创建一个广度优先的顺序，你可以添加一个跟踪搜索深度的列，例如：
WITH RECURSIVE search_tree(id, link, data, depth) AS (
SELECT t.id, t.link, t.data, 0
FROM tree t
UNION ALL
SELECT t.id, t.link, t.data, depth + 1
FROM tree t, search_tree st
WHERE t.id = st.link
)
SELECT * FROM search_tree ORDER BY depth;
添加数据列作为二级排序列以获得稳定的排序。
提示
递归查询评估算法以广度优先搜索顺序生成其输出。但是，这是一种实现细节，可能不能依赖它。每个级别内行的顺序肯定是未定义的，因此在任何情况下都可能需要一些显式排序。
有内置的语法可以计算深度或广度优先排序列。例如：
WITH RECURSIVE search_tree(id, link, data) AS (
SELECT t.id, t.link, t.data
FROM tree t
UNION ALL
SELECT t.id, t.link, t.data
FROM tree t, search_tree st
WHERE t.id = st.link
) SEARCH DEPTH FIRST BY id SET ordercol
SELECT * FROM search_tree ORDER BY ordercol;
WITH RECURSIVE search_tree(id, link, data) AS (
SELECT t.id, t.link, t.data
FROM tree t
UNION ALL
SELECT t.id, t.link, t.data
FROM tree t, search_tree st
WHERE t.id = st.link
) SEARCH BREADTH FIRST BY id SET ordercol
SELECT * FROM search_tree ORDER BY ordercol;
这个语法会在内部扩展为类似于上面手动编写的表单。SEARCH子句指定要搜索深度优先还是广度优先，要跟踪进行排序的列的列表以及包含可用于排序的结果数据的列名称。该列将隐式地添加到CTE的输出行中。
7.8.2.2. Cycle Detection #
在使用递归查询时，确保查询的递归部分最终将不返回元组非常重要，否则查询将会无限循环。在某些时候，使用UNION替代UNION ALL可以通过抛弃与之前输出行重复的行来达到这个目的。不过，经常有循环不涉及到完全重复的输出行：它可能只需要检查一个或几个字段来看相同点之前是否达到过。处理这种情况的标准方法是计算一个已经访问过值的数组。例如，考虑下面这个使用link字段搜索表graph的查询：
WITH RECURSIVE search_graph(id, link, data, depth) AS (
SELECT g.id, g.link, g.data, 0
FROM graph g
UNION ALL
SELECT g.id, g.link, g.data, sg.depth + 1
FROM graph g, search_graph sg
WHERE g.id = sg.link
)
SELECT * FROM search_graph;
如果link关系包含环，这个查询将会循环。因为我们要求一个“depth”输出，仅仅将UNION ALL改为UNION不会消除循环。反过来在我们顺着一个特定链接路径搜索时，我们需要识别我们是否再次到达了一个相同的行。我们可以向这个有循环倾向的查询增加两个列is_cycle和path：
WITH RECURSIVE search_graph(id, link, data, depth, is_cycle, path) AS (
SELECT g.id, g.link, g.data, 0,
false,
ARRAY[g.id]
FROM graph g
UNION ALL
SELECT g.id, g.link, g.data, sg.depth + 1,
g.id = ANY(path),
path || g.id
FROM graph g, search_graph sg
WHERE g.id = sg.link AND NOT is_cycle
)
SELECT * FROM search_graph;
除了阻止环，数组值对于它们自己的工作显示到达任何特定行的“path”也有用。
在通常情况下如果需要检查多于一个字段来识别一个环，请用行数组。例如，如果我们需要比较字段f1和f2：
WITH RECURSIVE search_graph(id, link, data, depth, is_cycle, path) AS (
SELECT g.id, g.link, g.data, 0,
false,
ARRAY[ROW(g.f1, g.f2)]
FROM graph g
UNION ALL
SELECT g.id, g.link, g.data, sg.depth + 1,
ROW(g.f1, g.f2) = ANY(path),
path || ROW(g.f1, g.f2)
FROM graph g, search_graph sg
WHERE g.id = sg.link AND NOT is_cycle
)
SELECT * FROM search_graph;
提示
在通常情况下只有一个字段需要被检查来识别一个环，可以省略ROW()语法。这允许使用一个简单的数组而不是一个组合类型数组，可以获得效率。
有一种内置的语法可以简化环路检测。上面的查询也可以这样编写：
WITH RECURSIVE search_graph(id, link, data, depth) AS (
SELECT g.id, g.link, g.data, 1
FROM graph g
UNION ALL
SELECT g.id, g.link, g.data, sg.depth + 1
FROM graph g, search_graph sg
WHERE g.id = sg.link
) CYCLE id SET is_cycle USING path
SELECT * FROM search_graph;
内部将被重写成上述形式。CYCLE子句首先指定要跟踪的列以检测循环，然后是一个列名，它将显示是否检测到循环，最后是将跟踪路径的其他列的名称。循环和路径列将隐含地添加到CTE的输出行中。
提示
循环路径列的计算方法与上一节中显示的深度优先排序列相同。一个查询可以同时有SEARCH和CYCLE子句，但是深度优先的搜索规范和循环检测规范会产生多余的计算，所以只使用CYCLE子句并按路径列排序会更有效率。如果想要进行广度优先排序，那么同时指定SEARCH和CYCLE会很有用。
当你不确定查询是否可能循环时，一个测试查询的有用技巧是在父查询中放一个LIMIT。例如，这个查询没有LIMIT时会永远循环：
WITH RECURSIVE t(n) AS (
SELECT 1
UNION ALL
SELECT n+1 FROM t
)
SELECT n FROM t LIMIT 100;
这会起作用，因为PostgreSQL的实现只计算WITH查询中被父查询实际取到的行。不推荐在生产中使用这个技巧，因为其他系统可能以不同方式工作。同样，如果你让外层查询排序递归查询的结果或者把它们连接成某种其他表，这个技巧将不会起作用，因为在这些情况下外层查询通常将尝试取得WITH查询的所有输出。
7.8.3. Common Table Expression Materialization #
WITH查询的一个有用的特性是在每一次父查询的执行中它们通常只被计算一次，即使它们被父查询或兄弟WITH查询引用了超过一次。
因此，在多个地方需要的昂贵计算可以被放在一个WITH查询中来避免冗余工作。另一种可能的应用是阻止不希望的多个函数计算产生副作用。
但是，从另一方面来看，优化器不能将来自父查询的约束下推到多次引用的WITH查询，因为当它应该只影响一个时它可能会影响所有使用WITH查询的输出的使用。
多次引用的WITH查询将会按照所写的方式计算，而不抑制父查询以后可能会抛弃的行（但是，如上所述，如果对查询的引用只请求有限数目的行，计算可能会提前停止）。
但是，如果 WITH 查询是非递归和无副作用的（就是说，它是一个SELECT包含没有可变函数），则它可以合并到父查询中，允许两个查询级别的联合优化。
默认情况下，这发生在父查询仅引用 WITH 查询一次的时候，而不是它引用 WITH 查询多于一次时。
你可以通过指定 MATERIALIZED 来强制分开计算 WITH 查询，或者通过指定 NOT MATERIALIZED 来强制它被合并到父查询中，从而覆盖该决策。
后一种选择存在重复计算 WITH 查询的风险，但如果每个使用 WITH 查询的地方只需要 WITH 查询的完整输出的一小部分，它仍然可以带来净节省。
这些规则的一个简单示例是
WITH w AS (
SELECT * FROM big_table
)
SELECT * FROM w WHERE key = 123;
这个 WITH 查询将被合并，生成相同的执行计划为
SELECT * FROM big_table WHERE key = 123;
特别是，如果在 key 上有一个索引，它可能只用于获取具有 key = 123 的行。另一方面，在
WITH w AS (
SELECT * FROM big_table
)
SELECT * FROM w AS w1 JOIN w AS w2 ON w1.key = w2.ref
WHERE w2.key = 123;
WITH 查询将被物化，生成一个 big_table 的临时拷贝，然后与其自身联合，这样将不能从索引上获得任何好处。
如果写成下面的形式，这个查询将被执行得更有效率。
WITH w AS NOT MATERIALIZED (
SELECT * FROM big_table
)
SELECT * FROM w AS w1 JOIN w AS w2 ON w1.key = w2.ref
WHERE w2.key = 123;
所以父查询的限制可以直接应用于 big_table 的扫描。
一个 NOT MATERIALIZED 可能不理想的例子是
WITH w AS (
SELECT key, very_expensive_function(val) as f FROM some_table
)
SELECT * FROM w AS w1 JOIN w AS w2 ON w1.f = w2.f;
在这里，WITH 查询的物化确保 very_expensive_function 每个表行只计算一次，而不是两次。
上面的示例仅显示了 WITH 与 SELECT 一起使用，
但它可以以相同的方式附加到 INSERT、UPDATE、
DELETE 或 MERGE。
在每种情况下，它有效地提供了可以在主命令中引用的临时表。
7.8.4. WITH 中的数据修改语句 #
您可以在 WITH 中使用数据修改语句（INSERT、
UPDATE、DELETE 或 MERGE）。这
允许您在同一个查询中执行多种不同的操作。示例如下：
WITH moved_rows AS (
DELETE FROM products
WHERE
"date" >= '2010-10-01' AND
"date" < '2010-11-01'
RETURNING *
)
INSERT INTO products_log
SELECT * FROM moved_rows;
该查询实际上是将行从 products 移动到
products_log。WITH 中的 DELETE
会删除 products 中指定的行，并通过其 RETURNING
子句返回这些内容；然后主查询读取该输出并将其插入到
products_log 中。
上述例子中好的一点是 WITH 子句被附加给 INSERT，而没有附加给 INSERT 的子 SELECT。这是必需的，因为 WITH 中的数据修改语句只能附加到顶层语句。不过，普通 WITH 的可见性规则仍适用，这样才可能从子 SELECT 中引用 WITH 语句的输出。
正如上述例子所示，WITH 中的数据修改语句通常具有 RETURNING 子句（见 第 6.4 节）。它是 RETURNING 子句的输出，不是 数据修改语句的目标表，它形成了其他查询可以引用的临时表。如果一个 WITH 中的数据修改语句缺少一个 RETURNING 子句，则它不会形成临时表并且不能被其他查询引用。尽管如此，这样一个语句仍将被执行。一个不是特别有用的例子：
WITH t AS (
DELETE FROM foo
)
DELETE FROM bar;
这个例子将从表 foo 和 bar 中移除所有行。被报告给客户端的受影响行的数目可能只包括从 bar 中移除的行。
数据修改语句中不允许递归自引用。在某些情况下可以通过
引用一个递归WITH的输出来绕过这个限制，例如：
WITH RECURSIVE included_parts(sub_part, part) AS (
SELECT sub_part, part FROM parts WHERE part = 'our_product'
UNION ALL
SELECT p.sub_part, p.part
FROM included_parts pr, parts p
WHERE p.part = pr.sub_part
)
DELETE FROM parts
WHERE part IN (SELECT part FROM included_parts);
这个查询将移除一个产品的所有直接和间接子部件。
WITH中的数据修改语句只被执行一次，并且总是能结束，
而不管主查询是否读取它们所有（或者任何）的输出。注意这和WITH
中SELECT的规则不同：正如前一小节所述，SELECT
只有在主查询要求其输出时才会被执行。
WITH中的子语句和其他子语句以及主查询被并发执行。
因此在使用WITH中的数据修改语句时，无法预知实际更新顺序。
所有的语句都使用同一个snapshot执行（参见第 13 章），
因此它们不能“看见”目标表上另一个执行的效果。这减轻了行更新的实际顺序的
不可预见性的影响，并且意味着RETURNING数据是在不同WITH
子语句和主查询之间传达改变的唯一方法。其例子是
WITH t AS (
UPDATE products SET price = price * 1.05
RETURNING *
)
SELECT * FROM products;
外层SELECT可以返回在UPDATE动作之前的原始价格，
而在
WITH t AS (
UPDATE products SET price = price * 1.05
RETURNING *
)
SELECT * FROM t;
外层SELECT将返回更新过的数据。
在一个语句中试图两次更新同一行是不被支持的。只会发生一次修改，
但是该办法不能很容易地（有时是不可能）可靠预测哪一个会被执行。
这也适用于删除一个已经在同一个语句中被更新过的行：只有更新被执行。
因此你通常应该避免尝试在一个语句中两次修改同一行。
尤其是避免编写可以作用于被主语句或兄弟子语句修改行的WITH子语句。
这样一个语句的效果将是不可预测的。
当前，用作WITH中数据修改语句目标的任何表不能有条件规则、
ALSO规则或扩展到多个语句的INSTEAD规则。
上一页 上一级 下一页7.7. VALUES 列表 起始页 第 8 章 数据类型
