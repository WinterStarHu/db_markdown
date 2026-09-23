# 3.5. 窗口函数

3.5. 窗口函数
版本：
纠错本页面
搜索
目录导航
❮
❯
3.5. 窗口函数 #
一个窗口函数在一系列与当前行有某种关联的表行上执行一种计算。这与一个聚合函数所完成的计算有可比之处。但是窗口函数并不会使多行被聚合成一个单独的输出行，这与通常的非窗口聚合函数不同。取而代之，行保留它们独立的标识。在这些现象背后，窗口函数可以访问的不仅仅是查询结果的当前行。
这是一个示例，展示了如何比较每位员工的工资与其所在部门的平均工资：
SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
depname  | empno | salary |          avg
-----------+-------+--------+-----------------------
develop   |    11 |   5200 | 5020.0000000000000000
develop   |     7 |   4200 | 5020.0000000000000000
develop   |     9 |   4500 | 5020.0000000000000000
develop   |     8 |   6000 | 5020.0000000000000000
develop   |    10 |   5200 | 5020.0000000000000000
personnel |     5 |   3500 | 3700.0000000000000000
personnel |     2 |   3900 | 3700.0000000000000000
sales     |     3 |   4800 | 4866.6666666666666667
sales     |     1 |   5000 | 4866.6666666666666667
sales     |     4 |   4800 | 4866.6666666666666667
(10 rows)
前三列的输出直接来自表empsalary，每行都有一个输出行。
第四列表示对具有与当前行相同depname值的所有表行进行的平均值。
（实际上，这与非窗口avg聚合函数相同，但OVER子句
使其被视为窗口函数并计算在窗口帧上。）
一个窗口函数调用总是包含一个直接跟在窗口函数名及其参数之后的OVER子句。这使得它从句法上和一个普通函数或非窗口聚合函数区分开来。OVER子句决定究竟查询中的哪些行被分离出来由窗口函数处理。OVER子句中的PARTITION BY子句指定了将具有相同PARTITION BY表达式值的行分到组或者分区。对于每一行，窗口函数都会在当前行同一分区的行上进行计算。
您也可以在 OVER 中使用 ORDER BY
来控制窗口函数处理行的顺序。（窗口 ORDER BY
不必与行的输出顺序相匹配。）下面是一个示例：
SELECT depname, empno, salary,
row_number() OVER (PARTITION BY depname ORDER BY salary DESC)
FROM empsalary;
depname  | empno | salary | row_number
-----------+-------+--------+------------
develop   |     8 |   6000 |          1
develop   |    10 |   5200 |          2
develop   |    11 |   5200 |          3
develop   |     9 |   4500 |          4
develop   |     7 |   4200 |          5
personnel |     2 |   3900 |          1
personnel |     5 |   3500 |          2
sales     |     1 |   5000 |          1
sales     |     4 |   4800 |          2
sales     |     3 |   4800 |          3
(10 rows)
如图所示，row_number 窗口函数按照
ORDER BY 子句定义的顺序（平局行以未指定的顺序编号）
为每个分区内的行分配连续编号。
row_number 不需要显式参数，
因为其行为完全由 OVER 子句决定。
一个窗口函数所考虑的行属于那些通过查询的FROM子句产生并通过WHERE、GROUP BY、HAVING过滤的“虚拟表”。例如，一个由于不满足WHERE条件被删除的行是不会被任何窗口函数所见的。在一个查询中可以包含多个窗口函数，每个窗口函数都可以用不同的OVER子句来按不同方式划分数据，但是它们都作用在由虚拟表定义的同一个行集上。
我们已经看到如果行的顺序不重要时ORDER BY可以忽略。PARTITION BY同样也可以被忽略，在这种情况下会产生一个包含所有行的分区。
这里有一个与窗口函数相关的重要概念：对于每一行，在它的分区中的行集被称为它的窗口帧。一些窗口函数只作用在窗口帧中的行上，而不是整个分区。默认情况下，如果使用ORDER BY，则帧包括从分区开始到当前行的所有行，以及后续任何与当前行在ORDER BY子句上相等的行。如果ORDER BY被忽略，则默认帧包含整个分区中所有的行。
[5]
下面是使用sum的例子：
SELECT salary, sum(salary) OVER () FROM empsalary;
salary |  sum
--------+-------
5200 | 47100
5000 | 47100
3500 | 47100
4800 | 47100
3900 | 47100
4200 | 47100
4500 | 47100
4800 | 47100
6000 | 47100
5200 | 47100
(10 rows)
如上所示，由于在OVER子句中没有ORDER BY，窗口帧和分区一样，而如果缺少PARTITION BY则是整个表；换句话说，每个合计都会在整个表上进行，这样我们为每一个输出行得到的都是相同的结果。但是如果我们加上一个ORDER BY子句，我们会得到非常不同的结果：
SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;
salary |  sum
--------+-------
3500 |  3500
3900 |  7400
4200 | 11600
4500 | 16100
4800 | 25700
4800 | 25700
5000 | 30700
5200 | 41100
5200 | 41100
6000 | 47100
(10 rows)
这里的合计是从第一个（最低的）薪水一直到当前行，包括任何与当前行相同的行（注意重复薪水行的结果）。
窗口函数只允许出现在查询的SELECT列表和ORDER BY子句中。它们不允许出现在其他地方，例如GROUP BY、HAVING和WHERE子句中。这是因为窗口函数的执行逻辑是在处理完这些子句之后。另外，窗口函数在非窗口聚合函数之后执行。这意味着可以在窗口函数的参数中包括一个聚合函数，但反过来不行。
如果需要在执行窗口计算后对行进行过滤或分组，可以使用子查询。例如：
SELECT depname, empno, salary, enroll_date
FROM
(SELECT depname, empno, salary, enroll_date,
row_number() OVER (PARTITION BY depname ORDER BY salary DESC, empno) AS pos
FROM empsalary
) AS ss
WHERE pos < 3;
上面的查询只显示内部查询中row_number小于3的行
（即每个部门的前两行）。
当一个查询涉及到多个窗口函数时，可以将每一个分别写在一个独立的OVER子句中。但如果多个函数要求同一个窗口行为时，这种做法是冗余的而且容易出错。替代方案是，每一个窗口行为可以被放在一个命名的WINDOW子句中，然后在OVER中引用它。例如：
SELECT sum(salary) OVER w, avg(salary) OVER w
FROM empsalary
WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);
关于窗口函数的更多细节可以在第 4.2.8 节、第 9.22 节、第 7.2.5 节以及SELECT参考页中找到。
[5]
还有些选项用于以其他方式定义窗口帧，但是这不包括在本教程内。详见第 4.2.8 节。
上一页 上一级 下一页3.4. 事务 起始页 3.6. 继承
