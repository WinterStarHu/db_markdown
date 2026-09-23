# 39.2. 视图和规则系统

39.2. 视图和规则系统
版本：
纠错本页面
搜索
目录导航
❮
❯
39.2. 视图和规则系统 #39.2.1. SELECT规则如何工作39.2.2. 非SELECT语句中的视图规则39.2.3. PostgreSQL中视图的能力39.2.4. 更新视图
在PostgreSQL中，视图是通过规则系统实现的。
视图基本上是一个空表（没有实际存储），并带有一个ON SELECT DO INSTEAD
规则。通常，这个规则被命名为_RETURN。
因此，一个像这样的视图
CREATE VIEW myview AS SELECT * FROM mytab;
实际上几乎等同于
CREATE TABLE myview (与mytab相同的列列表);
CREATE RULE "_RETURN" AS ON SELECT TO myview DO INSTEAD
SELECT * FROM mytab;
尽管你实际上不能这样写，因为表不允许有ON SELECT规则。
一个视图还可以有其他类型的DO INSTEAD规则，允许
INSERT、UPDATE或DELETE
命令在视图上执行，尽管它缺乏底层存储。
这将在下面的第 39.2.4 节中进一步讨论。
39.2.1. SELECT规则如何工作 #
规则ON SELECT被应用于所有查询作为最后一步，即使给出的是一条INSERT、UPDATE或DELETE命令。而且它们与其他命令类型上的规则有着不同的语义，它们会就地修改查询树而不是创建一个新的查询树。因此我们首先描述SELECT规则。
目前，一个ON SELECT规则中只能有一个动作，而且它必须是一个无条件的INSTEAD的SELECT动作。这个限制是为了令规则足够安全，以便普通用户也可以打开它们，并且它限制ON SELECT规则使之行为类似视图。
本章的例子是两个连接视图，它们做一些运算并且某些更多视图会轮流使用它们。最前面的两个视图之一后面将利用对INSERT、UPDATE和DELETE操作增加规则的方法被自定义，这样最终结果将是一个视图，它表现得像一个具有魔力的真正的表。这个例子不适合于作为简单易懂的例子，它可能会让本章更难懂。但是用一个覆盖所有关键点的例子来一步一步讨论要比举很多例子搞乱思维好。
在前两个规则系统描述中我们需要真实表是：
CREATE TABLE shoe_data (
shoename   text,          -- 主键
sh_avail   integer,       -- 可用的双数
slcolor    text,          -- 首选的鞋带颜色
slminlen   real,          -- 最小鞋带长度
slmaxlen   real,          -- 最大鞋带长度
slunit     text           -- 长度单位
);
CREATE TABLE shoelace_data (
sl_name    text,          -- 主键
sl_avail   integer,       -- 可用的双数
sl_color   text,          -- 鞋带颜色
sl_len     real,          -- 鞋带长度
sl_unit    text           -- 长度单位
);
CREATE TABLE unit (
un_name    text,          -- 主键
un_fact    real           -- 转换到厘米的因子
);
如你所见，它们表示鞋店的数据。
视图被创建为：
CREATE VIEW shoe AS
SELECT sh.shoename,
sh.sh_avail,
sh.slcolor,
sh.slminlen,
sh.slminlen * un.un_fact AS slminlen_cm,
sh.slmaxlen,
sh.slmaxlen * un.un_fact AS slmaxlen_cm,
sh.slunit
FROM shoe_data sh, unit un
WHERE sh.slunit = un.un_name;
CREATE VIEW shoelace AS
SELECT s.sl_name,
s.sl_avail,
s.sl_color,
s.sl_len,
s.sl_unit,
s.sl_len * u.un_fact AS sl_len_cm
FROM shoelace_data s, unit u
WHERE s.sl_unit = u.un_name;
CREATE VIEW shoe_ready AS
SELECT rsh.shoename,
rsh.sh_avail,
rsl.sl_name,
rsl.sl_avail,
least(rsh.sh_avail, rsl.sl_avail) AS total_avail
FROM shoe rsh, shoelace rsl
WHERE rsl.sl_color = rsh.slcolor
AND rsl.sl_len_cm >= rsh.slminlen_cm
AND rsl.sl_len_cm <= rsh.slmaxlen_cm;
创建shoelace视图的CREATE VIEW命令（也是最简单的一个）将创建一个shoelace关系和一个pg_rewrite项，这个pg_rewrite项说明有一个重写规则，只要一个查询的范围表中引用了关系shoelace，就必须应用它。该规则没有规则条件（稍后和非SELECT规则一起讨论，因为目前的SELECT规则不能有规则条件）并且它是INSTEAD规则。要注意规则条件与查询条件不一样。我们的规则的动作有一个查询条件。该规则的动作是一个查询树，这个查询是视图创建命令中的SELECT语句的一个拷贝。
注意
你在pg_rewrite项中看到的两个额外的用于NEW和OLD的范围表项不是SELECT规则感兴趣的内容。
现在我们填充unit、shoe_data和shoelace_data，并在视图上运行一个简单的查询：
INSERT INTO unit VALUES ('cm', 1.0);
INSERT INTO unit VALUES ('m', 100.0);
INSERT INTO unit VALUES ('inch', 2.54);
INSERT INTO shoe_data VALUES ('sh1', 2, 'black', 70.0, 90.0, 'cm');
INSERT INTO shoe_data VALUES ('sh2', 0, 'black', 30.0, 40.0, 'inch');
INSERT INTO shoe_data VALUES ('sh3', 4, 'brown', 50.0, 65.0, 'cm');
INSERT INTO shoe_data VALUES ('sh4', 3, 'brown', 40.0, 50.0, 'inch');
INSERT INTO shoelace_data VALUES ('sl1', 5, 'black', 80.0, 'cm');
INSERT INTO shoelace_data VALUES ('sl2', 6, 'black', 100.0, 'cm');
INSERT INTO shoelace_data VALUES ('sl3', 0, 'black', 35.0 , 'inch');
INSERT INTO shoelace_data VALUES ('sl4', 8, 'black', 40.0 , 'inch');
INSERT INTO shoelace_data VALUES ('sl5', 4, 'brown', 1.0 , 'm');
INSERT INTO shoelace_data VALUES ('sl6', 0, 'brown', 0.9 , 'm');
INSERT INTO shoelace_data VALUES ('sl7', 7, 'brown', 60 , 'cm');
INSERT INTO shoelace_data VALUES ('sl8', 1, 'brown', 40 , 'inch');
SELECT * FROM shoelace;
sl_name   | sl_avail | sl_color | sl_len | sl_unit | sl_len_cm
-----------+----------+----------+--------+---------+-----------
sl1       |        5 | black    |     80 | cm      |        80
sl2       |        6 | black    |    100 | cm      |       100
sl7       |        7 | brown    |     60 | cm      |        60
sl3       |        0 | black    |     35 | inch    |      88.9
sl4       |        8 | black    |     40 | inch    |     101.6
sl8       |        1 | brown    |     40 | inch    |     101.6
sl5       |        4 | brown    |      1 | m       |       100
sl6       |        0 | brown    |    0.9 | m       |        90
(8 rows)
这是你可以在我们的视图上做的最简单的SELECT，所以我们借此机会来解释视图规则的基本要素。SELECT * FROM shoelace会被解析器解释并生成下面的查询树：
SELECT shoelace.sl_name, shoelace.sl_avail,
shoelace.sl_color, shoelace.sl_len,
shoelace.sl_unit, shoelace.sl_len_cm
FROM shoelace shoelace;
然后这将被交给规则系统。规则系统遍历范围表，检查有没有可用于任何关系的规则。在为shoelace（到目前为止的唯一一个）处理范围表时，它会发现查询树里有_RETURN规则：
SELECT s.sl_name, s.sl_avail,
s.sl_color, s.sl_len, s.sl_unit,
s.sl_len * u.un_fact AS sl_len_cm
FROM shoelace old, shoelace new,
shoelace_data s, unit u
WHERE s.sl_unit = u.un_name;
要扩展该视图，重写器简单地创建一个子查询范围表项，它包含规则的动作的查询树，然后用这个范围表记录取代原来引用视图的那个。作为结果的重写后的查询树几乎与你键入的那个一样：
SELECT shoelace.sl_name, shoelace.sl_avail,
shoelace.sl_color, shoelace.sl_len,
shoelace.sl_unit, shoelace.sl_len_cm
FROM (SELECT s.sl_name,
s.sl_avail,
s.sl_color,
s.sl_len,
s.sl_unit,
s.sl_len * u.un_fact AS sl_len_cm
FROM shoelace_data s, unit u
WHERE s.sl_unit = u.un_name) shoelace;
不过有一个区别：子查询的范围表有两个额外的项shoelace old和shoelace new。这些项并不直接参与到查询中，因为它们没有被子查询的连接树或者目标列表引用。重写器用它们存储最初出现在引用视图的范围表项中表达的访问权限检查信息。以这种方式，执行器仍然会检查该用户是否有访问视图的正确权限，尽管在重写后的查询中没有对视图的直接使用。
这是被应用的第一个规则。规则系统将继续检查顶层查询里剩下的范围表项（本例中没有了），并且它将递归地检查增加的子查询中的范围表项，看看其中有没有引用视图的（不过这样不会扩展old或new — 否则我们会得到无限递归！）。在这个例子中，没有用于shoelace_data或unit的重写规则，所以重写结束并且上面得到的就是给规划器的最终结果。
现在我们想写一个查询，它找出目前在店里哪些鞋子有匹配的（颜色和长度）鞋带，并且完全匹配的鞋带双数大于等于二。
SELECT * FROM shoe_ready WHERE total_avail >= 2;
shoename | sh_avail | sl_name | sl_avail | total_avail
----------+----------+---------+----------+-------------
sh1      |        2 | sl1     |        5 |           2
sh3      |        4 | sl7     |        7 |           4
(2 rows)
这次解析器的输出是查询树：
SELECT shoe_ready.shoename, shoe_ready.sh_avail,
shoe_ready.sl_name, shoe_ready.sl_avail,
shoe_ready.total_avail
FROM shoe_ready shoe_ready
WHERE shoe_ready.total_avail >= 2;
第一个被应用的规则将是用于shoe_ready的规则并且它会导致查询树：
SELECT shoe_ready.shoename, shoe_ready.sh_avail,
shoe_ready.sl_name, shoe_ready.sl_avail,
shoe_ready.total_avail
FROM (SELECT rsh.shoename,
rsh.sh_avail,
rsl.sl_name,
rsl.sl_avail,
least(rsh.sh_avail, rsl.sl_avail) AS total_avail
FROM shoe rsh, shoelace rsl
WHERE rsl.sl_color = rsh.slcolor
AND rsl.sl_len_cm >= rsh.slminlen_cm
AND rsl.sl_len_cm <= rsh.slmaxlen_cm) shoe_ready
WHERE shoe_ready.total_avail >= 2;
相似地，用于shoe和shoelace的规则被替换到子查询的范围表中，得到一个三层的最终查询树：
SELECT shoe_ready.shoename, shoe_ready.sh_avail,
shoe_ready.sl_name, shoe_ready.sl_avail,
shoe_ready.total_avail
FROM (SELECT rsh.shoename,
rsh.sh_avail,
rsl.sl_name,
rsl.sl_avail,
least(rsh.sh_avail, rsl.sl_avail) AS total_avail
FROM (SELECT sh.shoename,
sh.sh_avail,
sh.slcolor,
sh.slminlen,
sh.slminlen * un.un_fact AS slminlen_cm,
sh.slmaxlen,
sh.slmaxlen * un.un_fact AS slmaxlen_cm,
sh.slunit
FROM shoe_data sh, unit un
WHERE sh.slunit = un.un_name) rsh,
(SELECT s.sl_name,
s.sl_avail,
s.sl_color,
s.sl_len,
s.sl_unit,
s.sl_len * u.un_fact AS sl_len_cm
FROM shoelace_data s, unit u
WHERE s.sl_unit = u.un_name) rsl
WHERE rsl.sl_color = rsh.slcolor
AND rsl.sl_len_cm >= rsh.slminlen_cm
AND rsl.sl_len_cm <= rsh.slmaxlen_cm) shoe_ready
WHERE shoe_ready.total_avail >= 2;
这看起来是低效的，但是规划器会通过“pulling up”子查询将其折叠成一个单层查询树，然后它会计划连接，就像我们手动写出来一样。
因此，折叠查询树是重写系统本身不必关心的一种优化。
39.2.2. 非SELECT语句中的视图规则 #
有两个查询树的细节在上面的视图规则的描述中没有涉及。它们是命令类型和结果关系。实际上，视图规则不需要命令类型，但是结果关系可能会影响查询重写器工作的方式，因为如果结果关系是一个视图，我们需要采取特殊的措施。
一个SELECT的查询树和其他命令的查询树之间只有少数几处不同。显然，它们有不同的命令类型，并且对于SELECT之外的命令，结果关系指向结果将进入的范围表项。其他所有东西都完全相同。所以如果有两个表t1和t2分别有列a和b，下面两个语句的查询树：
SELECT t2.b FROM t1, t2 WHERE t1.a = t2.a;
UPDATE t1 SET b = t2.b FROM t2 WHERE t1.a = t2.a;
几乎是一样的。特别是：
范围表包含表t1和t2的项。
目标列表包含一个变量，该变量指向表t2的范围表项的列b。
条件表达式比较两个范围表项的列a以寻找相等。
连接树展示了t1和t2之间的一次简单连接。
结果是，两个查询树生成相似的执行计划：它们都是两个表的连接。对于UPDATE语句，规划器把t1缺失的列加到目标列表，并且最终查询树读起来是：
UPDATE t1 SET a = t1.a, b = t2.b FROM t2 WHERE t1.a = t2.a;
因此在连接上运行的执行器将产生完全相同的结果集：
SELECT t1.a, t2.b FROM t1, t2 WHERE t1.a = t2.a;
但是在UPDATE中有个小问题：执行器计划中执行连接的部分不关心连接的结果的含义。它只是产生一个行的结果集。一个是SELECT命令而另一个是由执行器中的更高层处理的UPDATE命令，在那里执行器知道这是一个UPDATE，并且它知道这个结果应该进入表t1。但是这里的哪些行必须被新行替换呢？
要解决这个问题，在UPDATE（以及DELETE）语句的目标列表中增加了另外一个项：当前元组 ID（CTID）。这是一个系统列，它包含行所在的文件块编号和在块中的位置。在已知表的情况下，CTID可以被用来检索要被更新的t1的原始行。在添加CTID到目标列表之后，该查询实际看起来像：
SELECT t1.a, t2.b, t1.ctid FROM t1, t2 WHERE t1.a = t2.a;
现在，另一个PostgreSQL的细节进入到这个阶段了。表中的旧行还没有被覆盖，这就是为什么ROLLBACK很快的原因。在一个UPDATE中，新的结果行被插入到表中（在剥除CTID之后），并且把CTID指向的旧行的行头部中的cmax和xmax项设置为当前命令计数器和当前事务 ID。这样旧的行就被隐藏起来，并且在事务提交之后，清理器就可以最终移除死亡的行。
知道了所有这些，我们就可以用完全相同的方式简单地把视图规则应用到任何命令中。没有任何区别。
39.2.3. PostgreSQL中视图的能力 #
上文演示了规则系统如何把视图定义整合到原始的查询树中。在第二个例子中，一个来自于一个视图的简单SELECT创建了一个四表连接（unit以不同的名字被用了两次）的最终查询树。
用规则系统实现视图的好处是，规划器拥有关于哪些表必须被扫描、这些表之间的联系、来自于视图的限制性条件、原始查询的条件等所有信息，全部集中在一个单一查询树中。当原始查询已经是一个视图上的连接时仍然是这样。规划器必须决定执行查询的最优路径，而且规划器拥有越多信息，该决定就越好。并且PostgreSQL中实现的规则系统保证这些信息是此时能获得的有关该查询的所有信息。
39.2.4. 更新视图 #
如果视图被命名为INSERT、UPDATE、
DELETE或MERGE的目标关系，会发生什么？执行
上述替换会生成一个查询树，其中结果关系指向一个子查询范围表项，这将无法工作。
PostgreSQL支持模拟更新视图的几种方式。
按用户体验复杂度排序，这些方式是：自动替换为视图的底层表，执行用户定义的触发器，
或根据用户定义的规则重写查询。
下面将讨论这些选项。
如果子查询仅从单个基础关系中选择且足够简单，重写器可以自动将子查询替换为
底层基础关系，从而使INSERT、UPDATE、
DELETE或MERGE以适当的方式应用于基础关系。
被称为“足够简单”的视图称为自动可更新。
有关可以自动更新的视图类型的详细信息，请参见CREATE VIEW。
另外，操作可以通过用户提供的INSTEAD OF触发器在视图上处理
(见CREATE TRIGGER).
在这种情况下，重写的工作方式略有不同。对于INSERT，重写器对
视图不做任何处理，保持其作为查询的结果关系。对于UPDATE、DELETE和MERGE，仍然需要扩展视图查询以生成命令将尝试更新、删除或合并的“旧”行。因此，视图按正常方式扩展，但另一个未扩展的范围表项被添加到查询中，以表示视图作为结果关系的身份。
现在出现的问题是如何识别视图中需要更新的行。回想一下，当结果关系是一个表时，
会在目标列表中添加一个特殊的CTID条目，用于标识要更新的行的物理位置。
如果结果关系是视图，这种方法就不起作用，因为视图没有任何CTID，
因为其行没有实际的物理位置。相反，对于UPDATE、DELETE或
MERGE操作，会在目标列表中添加一个特殊的wholerow条目，
它会展开以包含视图中的所有列。执行器使用该值向INSTEAD OF触发器提供
“旧”行。由触发器根据旧行和新行的值来确定要更新的内容。
另一种可能是用户定义INSTEAD规则，指定对视图上的
INSERT、UPDATE和DELETE
命令的替代操作。这些规则将重写命令，通常转换为更新一个或多个表的
命令，而不是视图。这个主题详见第 39.4 节。注意，
这对MERGE无效，因为它目前不支持除SELECT
规则之外的目标关系上的规则。
注意规则会首先被计算，然后在原始查询被规划和执行之前重写它。因此，如果一个视图上同时有INSTEAD OF触发器和INSERT、UPDATE或DELETE规则，那么首先会计算规则，然后根据其结果决定是否执行触发器，触发器可能完全都不会被使用。
自动重写INSERT、UPDATE、DELETE或
MERGE查询在简单视图上总是最后尝试的。因此，如果视图有规则或
触发器，它们将覆盖自动可更新视图的默认行为。
如果对该视图没有INSTEAD规则或INSTEAD OF触发器，并且重写器不能自动地把该查询重写成一个底层基本关系上的更新，将会抛出一个错误，因为执行器不能更新一个这样的视图。
上一页 上一级 下一页39.1. 查询树 起始页 39.3. 物化视图
