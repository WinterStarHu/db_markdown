# 39.4. 在INSERT、UPDATE和DELETE上的规则

39.4. 在INSERT、UPDATE和DELETE上的规则
版本：
纠错本页面
搜索
目录导航
❮
❯
39.4. 在INSERT、UPDATE和DELETE上的规则 #39.4.1. 更新规则如何工作39.4.2. 与视图合作
在INSERT、UPDATE和DELETE上定义的规则与前面章节中描述的视图规则有显著不同。首先，它们的CREATE
RULE命令允许更多操作：
它们可以没有任何操作。
它们可以有多个操作。
它们可以是INSTEAD或ALSO（默认值）。
伪关系NEW和OLD变得有用。
它们可以有规则限定条件。
其次，它们不会直接修改查询树。相反，它们会创建零个或多个新的查询树，并且可以丢弃原始的查询树。
小心
在很多情况下，由INSERT/UPDATE/DELETE上的规则执行的任务用触发器能做得更好。触发器在记法上要更复杂些，但是它们的语义理解起来更简单些。当原始查询包含不稳定函数时，规则容易产生令人惊讶的结果：在执行规则的过程中不稳定函数的执行次数可能比预期中的更多。
还有，有些情况根本无法用这些类型的规则支持，典型的是在原始查询中包括WITH子句以及在UPDATE查询的SET列表中包括多个赋值的子SELECT。这是因为把这些结构复制到一个规则查询中可能导致子查询的多次计算，这与查询作者表达的意图相悖。
39.4.1. 更新规则如何工作 #
记住以下语法：
CREATE [ OR REPLACE ] RULE name AS ON event
TO table [ WHERE condition ]
DO [ ALSO | INSTEAD ] { NOTHING | command | ( command ; command ... ) }
在随后的内容中，更新规则表示定义在INSERT、UPDATE或DELETE上的规则。
如果查询树的结果关系和命令类型等于CREATE RULE命令中给出的对象和事件，规则系统就会应用更新规则。对于更新规则，规则系统会创建一个查询树列表。一开始该查询树列表是空的。更新规则中可以有零个（NOTHING关键字）、一个或多个动作。为简单起见，我们先看一个只有一个动作的规则。这个规则可以有条件或者没有条件，并且它可以是INSTEAD或ALSO（缺省）。
什么是规则条件？它是一个限制，告诉规则动作什么时候做、什么时候不做。这个条件只能引用NEW和/或OLD伪关系，它们基本上代表作为对象给定的关系（但是有着特殊含义）。
所以，对这个单动作的规则生成下面的查询树，我们有三种情况。
没有条件，有ALSO或INSTEAD
来自规则动作的查询树，在其上增加原始查询树的条件
给出了条件，有ALSO
来自规则动作的查询树，在其上加入规则条件和原始查询树的条件
给出了条件，有INSTEAD
来自规则动作的查询树，在其上加入规则条件和原始查询树的条件；以及带有反规则条件的原始查询树
最后，如果规则是ALSO，那么未修改的原始查询树也被加入到列表。因为只有合格的INSTEAD规则已经被加入到原始查询树中，对于单动作的规则，我们将结束于一个或两个输出查询树。
对于ON INSERT规则，原始查询（如果没有被INSTEAD取代）是在任何规则增加的动作之前完成的。这样就允许动作看到被插入的行。但是对ON UPDATE 和ON DELETE规则，原始查询是在规则增加的动作之后完成的。这样就确保动作可以看到将要更新或者将要删除的行；否则，动作可能什么也不做，因为它们无法发现符合它们要求的行。
从规则动作生成的查询树会被再次丢给重写系统，并且可能有更多规则被应用而得到更多或更少的查询树。所以一个规则的动作必须有一种不同的命令类型或者和规则所在的关系不同的另一个结果关系。否则这样的递归处理就会没完没了（规则的递归展开会被检测到，并当作一个错误报告）。
在pg_rewrite系统目录中的动作中的查询树只是模板。因为它们可以引用NEW和OLD的范围表项，在使用它们之前必须做一些替换。对于任何NEW的引用，都要先在原始查询的目标列表中搜索对应的项。如果找到，该项的表达式将会替换该引用。否则，NEW和OLD的含义一样（对于UPDATE）或者被替换成一个空值（对于INSERT）。任何对OLD的引用都用结果关系的范围表项的引用替换。
在系统完成应用更新规则后，它再应用视图规则到生成的查询树上。视图无法插入新的更新动作，所以没有必要向视图重写的输出应用更新规则。
39.4.1.1. 第一个规则循序渐进 #
假设我们想要跟踪shoelace_data关系中的sl_avail列。所以我们建立一个日志表和一条规则，这条规则每次在shoelace_data上执行UPDATE时有条件地写入一个日志项。
CREATE TABLE shoelace_log (
sl_name    text,          -- 改变的鞋带
sl_avail   integer,       -- 新的可用值
log_who    text,          -- 谁做的
log_when   timestamp      -- 何时做的
);
CREATE RULE log_shoelace AS ON UPDATE TO shoelace_data
WHERE NEW.sl_avail <> OLD.sl_avail
DO INSERT INTO shoelace_log VALUES (
NEW.sl_name,
NEW.sl_avail,
current_user,
current_timestamp
);
现在有人执行了:
UPDATE shoelace_data SET sl_avail = 6 WHERE sl_name = 'sl7';
然后我们查看日志表:
SELECT * FROM shoelace_log;
sl_name | sl_avail | log_who | log_when
---------+----------+---------+----------------------------------
sl7     |        6 | Al      | Tue Oct 20 16:14:45 1998 MET DST
(1 row)
这就是我们所期望的。在后台发生的事情如下。解析器创建查询树：
UPDATE shoelace_data SET sl_avail = 6
FROM shoelace_data shoelace_data
WHERE shoelace_data.sl_name = 'sl7';
这是一个带有规则条件表达式的ON UPDATE规则log_shoelace，条件是：
NEW.sl_avail <> OLD.sl_avail
它的动作是：
INSERT INTO shoelace_log VALUES (
new.sl_name, new.sl_avail,
current_user, current_timestamp )
FROM shoelace_data new, shoelace_data old;
（这看起来有点奇怪，因为你通常不能写INSERT ... VALUES ... FROM。这里的FROM子句只是表示查询树里有用于new和old的范围表项。这些东西是必需的，这样它们就可以被INSERT命令的查询树中的变量引用）。
该规则是一个有条件的ALSO规则，所以规则系统必须返回两个查询树：更改过的规则动作和原始查询树。在第 1 步里，原始查询的范围表被集成到规则动作的查询树中。得到：
INSERT INTO shoelace_log VALUES (
new.sl_name, new.sl_avail,
current_user, current_timestamp )
FROM shoelace_data new, shoelace_data old,
shoelace_data shoelace_data;
第 2 步把规则条件增加进去，所以结果集被限制为sl_avail改变了的行：
INSERT INTO shoelace_log VALUES (
new.sl_name, new.sl_avail,
current_user, current_timestamp )
FROM shoelace_data new, shoelace_data old,
shoelace_data shoelace_data
WHERE new.sl_avail <> old.sl_avail;
（这看起来更奇怪，因为INSERT ... VALUES也没有WHERE子句，但是规划器和执行器处理它没有任何难度。不管怎样，它们需要为INSERT ... SELECT支持这种相同功能）。
第 3 步把原始查询树的条件加进去，把结果集进一步限制成只有被原始查询触及的行：
INSERT INTO shoelace_log VALUES (
new.sl_name, new.sl_avail,
current_user, current_timestamp )
FROM shoelace_data new, shoelace_data old,
shoelace_data shoelace_data
WHERE new.sl_avail <> old.sl_avail
AND shoelace_data.sl_name = 'sl7';
第 4 步把NEW引用替换为来自原始查询树的目标列表项或来自结果关系的相匹配的变量引用：
INSERT INTO shoelace_log VALUES (
shoelace_data.sl_name, 6,
current_user, current_timestamp )
FROM shoelace_data new, shoelace_data old,
shoelace_data shoelace_data
WHERE 6 <> old.sl_avail
AND shoelace_data.sl_name = 'sl7';
第 5 步，用结果关系引用把OLD引用替换掉：
INSERT INTO shoelace_log VALUES (
shoelace_data.sl_name, 6,
current_user, current_timestamp )
FROM shoelace_data new, shoelace_data old,
shoelace_data shoelace_data
WHERE 6 <> shoelace_data.sl_avail
AND shoelace_data.sl_name = 'sl7';
这就完成了。因为规则是ALSO，我们还要输出原始查询树。简而言之，从规则系统输出的是一个包含两个查询树的列表，它们与下面语句相对应：
INSERT INTO shoelace_log VALUES (
shoelace_data.sl_name, 6,
current_user, current_timestamp )
FROM shoelace_data
WHERE 6 <> shoelace_data.sl_avail
AND shoelace_data.sl_name = 'sl7';
UPDATE shoelace_data SET sl_avail = 6
WHERE sl_name = 'sl7';
这些会按照这个顺序被执行，并且这也正是规则要做的事情。
做的替换和追加的条件用于确保对于下面这样的原始查询不会有日志记录被写入：
UPDATE shoelace_data SET sl_color = 'green'
WHERE sl_name = 'sl7';
在这种情况下，原始查询树不包含sl_avail的目标列表项，因此NEW.sl_avail将被shoelace_data.sl_avail代替。所以，规则生成的额外命令是：
INSERT INTO shoelace_log VALUES (
shoelace_data.sl_name, shoelace_data.sl_avail,
current_user, current_timestamp )
FROM shoelace_data
WHERE shoelace_data.sl_avail <> shoelace_data.sl_avail
AND shoelace_data.sl_name = 'sl7';
并且条件将永远不可能为真。
如果原始查询修改多个行，这也能正常工作。所以如果某人发出命令：
UPDATE shoelace_data SET sl_avail = 0
WHERE sl_color = 'black';
实际上有四行（sl1、sl2、sl3和sl4）被更新。但sl3已经是sl_avail = 0。在这种情况下，原始查询树的条件不同并且导致规则产生额外的查询树：
INSERT INTO shoelace_log
SELECT shoelace_data.sl_name, 0,
current_user, current_timestamp
FROM shoelace_data
WHERE 0 <> shoelace_data.sl_avail
AND shoelace_data.sl_color = 'black';
这个查询树将肯定插入三个新的日志项。这也是完全正确的。
到这里我们就能明白为什么原始查询树最后执行非常重要。如果UPDATE先被执行，则所有的行都已经被设为零，所以记日志的INSERT将无法找到任何符合0 <> shoelace_data.sl_avail的行。
39.4.2. 与视图合作 #
要保护一个视图关系不被INSERT、UPDATE或DELETE，一种简单的方法是让那些查询树被丢掉。因此我们可以创建规则：
CREATE RULE shoe_ins_protect AS ON INSERT TO shoe
DO INSTEAD NOTHING;
CREATE RULE shoe_upd_protect AS ON UPDATE TO shoe
DO INSTEAD NOTHING;
CREATE RULE shoe_del_protect AS ON DELETE TO shoe
DO INSTEAD NOTHING;
如果现在某人尝试对视图关系shoe做任何这些操作，规则系统将应用这些规则。因为这些规则没有动作而且是INSTEAD，查询树列表将是空的并且整个查询将变得什么也不做，因为经过规则系统处理后没有什么东西剩下来被优化或执行了。
一个更好的使用规则系统的方法是创建一些规则，这些规则把查询树重写成一个在真实表上进行正确操作的查询树。要在视图shoelace上做这件事，我们创建下列规则：
CREATE RULE shoelace_ins AS ON INSERT TO shoelace
DO INSTEAD
INSERT INTO shoelace_data VALUES (
NEW.sl_name,
NEW.sl_avail,
NEW.sl_color,
NEW.sl_len,
NEW.sl_unit
);
CREATE RULE shoelace_upd AS ON UPDATE TO shoelace
DO INSTEAD
UPDATE shoelace_data
SET sl_name = NEW.sl_name,
sl_avail = NEW.sl_avail,
sl_color = NEW.sl_color,
sl_len = NEW.sl_len,
sl_unit = NEW.sl_unit
WHERE sl_name = OLD.sl_name;
CREATE RULE shoelace_del AS ON DELETE TO shoelace
DO INSTEAD
DELETE FROM shoelace_data
WHERE sl_name = OLD.sl_name;
如果你要在视图上支持RETURNING查询，你需要让规则包含RETURNING子句来计算视图行。这对于基于单个表的视图来说通常非常简单，但是对于连接视图（如shoelace）就有点冗长了。对于插入的一个例子：
CREATE RULE shoelace_ins AS ON INSERT TO shoelace
DO INSTEAD
INSERT INTO shoelace_data VALUES (
NEW.sl_name,
NEW.sl_avail,
NEW.sl_color,
NEW.sl_len,
NEW.sl_unit
)
RETURNING
shoelace_data.*,
(SELECT shoelace_data.sl_len * u.un_fact
FROM unit u WHERE shoelace_data.sl_unit = u.un_name);
注意，这个规则同时支持该视图上的INSERT和INSERT RETURNING查询 — 对于INSERT会简单地忽略RETURNING子句。
请注意，在规则的RETURNING子句中，
OLD和NEW指的是
作为额外范围表条目添加到重写查询中的伪关系，而不是结果关系中的旧/新行。因此，例如，在支持UPDATE查询的规则中，如果RETURNING子句包含
old.sl_name，则旧名称将始终被返回，
无论在视图上的查询中RETURNING子句指定OLD还是NEW，
这可能会造成困惑。为了避免这种困惑，并支持在视图查询中返回
旧值和新值，规则定义中的RETURNING子句应引用结果
关系中的条目，例如shoelace_data.sl_name，而不指定OLD或NEW。
现在假设偶尔，一包鞋带到达商店，随之而来的是一个大的零件清单。但是您不想每次都手动更新shoelace视图。
相反，我们设置了两个小表：一个用于插入零件清单中的项目，另一个带有一个特殊的技巧。这些表的创建命令如下：
CREATE TABLE shoelace_arrive (
arr_name    text,
arr_quant   integer
);
CREATE TABLE shoelace_ok (
ok_name     text,
ok_quant    integer
);
CREATE RULE shoelace_ok_ins AS ON INSERT TO shoelace_ok
DO INSTEAD
UPDATE shoelace
SET sl_avail = sl_avail + NEW.ok_quant
WHERE sl_name = NEW.ok_name;
现在您可以将来自零件清单的数据填充到表shoelace_arrive中：
SELECT * FROM shoelace_arrive;
arr_name | arr_quant
----------+-----------
sl3      |        10
sl6      |        20
sl8      |        20
(3 rows)
快速查看当前数据：
SELECT * FROM shoelace;
sl_name  | sl_avail | sl_color | sl_len | sl_unit | sl_len_cm
----------+----------+----------+--------+---------+-----------
sl1      |        5 | black    |     80 | cm      |        80
sl2      |        6 | black    |    100 | cm      |       100
sl7      |        6 | brown    |     60 | cm      |        60
sl3      |        0 | black    |     35 | inch    |      88.9
sl4      |        8 | black    |     40 | inch    |     101.6
sl8      |        1 | brown    |     40 | inch    |     101.6
sl5      |        4 | brown    |      1 | m       |       100
sl6      |        0 | brown    |    0.9 | m       |        90
(8 rows)
现在将到达的鞋带放入：
INSERT INTO shoelace_ok SELECT * FROM shoelace_arrive;
并检查结果：
SELECT * FROM shoelace ORDER BY sl_name;
sl_name  | sl_avail | sl_color | sl_len | sl_unit | sl_len_cm
----------+----------+----------+--------+---------+-----------
sl1      |        5 | black    |     80 | cm      |        80
sl2      |        6 | black    |    100 | cm      |       100
sl7      |        6 | brown    |     60 | cm      |        60
sl4      |        8 | black    |     40 | inch    |     101.6
sl3      |       10 | black    |     35 | inch    |      88.9
sl8      |       21 | brown    |     40 | inch    |     101.6
sl5      |        4 | brown    |      1 | m       |       100
sl6      |       20 | brown    |    0.9 | m       |        90
(8 rows)
SELECT * FROM shoelace_log;
sl_name | sl_avail | log_who| log_when
---------+----------+--------+----------------------------------
sl7     |        6 | Al     | Tue Oct 20 19:14:45 1998 MET DST
sl3     |       10 | Al     | Tue Oct 20 19:25:16 1998 MET DST
sl6     |       20 | Al     | Tue Oct 20 19:25:16 1998 MET DST
sl8     |       21 | Al     | Tue Oct 20 19:25:16 1998 MET DST
(4 rows)
从一个INSERT ... SELECT到这些结果经过了很长的过程。并且该查询树转换的描述将出现在本章的最后。首先，这里是解析器的输出：
INSERT INTO shoelace_ok
SELECT shoelace_arrive.arr_name, shoelace_arrive.arr_quant
FROM shoelace_arrive shoelace_arrive, shoelace_ok shoelace_ok;
现在应用第一条规则shoelace_ok_ins并且把这个输出转换成：
UPDATE shoelace
SET sl_avail = shoelace.sl_avail + shoelace_arrive.arr_quant
FROM shoelace_arrive shoelace_arrive, shoelace_ok shoelace_ok,
shoelace_ok old, shoelace_ok new,
shoelace shoelace
WHERE shoelace.sl_name = shoelace_arrive.arr_name;
并且丢掉shoelace_ok上的INSERT。这个被重写后的查询被再次传递给规则系统，并且第二个被应用的规则shoelace_upd会产生：
UPDATE shoelace_data
SET sl_name = shoelace.sl_name,
sl_avail = shoelace.sl_avail + shoelace_arrive.arr_quant,
sl_color = shoelace.sl_color,
sl_len = shoelace.sl_len,
sl_unit = shoelace.sl_unit
FROM shoelace_arrive shoelace_arrive, shoelace_ok shoelace_ok,
shoelace_ok old, shoelace_ok new,
shoelace shoelace, shoelace old,
shoelace new, shoelace_data shoelace_data
WHERE shoelace.sl_name = shoelace_arrive.arr_name
AND shoelace_data.sl_name = shoelace.sl_name;
同样这是一个INSTEAD规则并且前一个查询树会被丢弃掉。注意这个查询仍然使用视图shoelace。但是规则系统还没有完成这一步，所以它会继续并在其上应用_RETURN规则，并且我们得到：
UPDATE shoelace_data
SET sl_name = s.sl_name,
sl_avail = s.sl_avail + shoelace_arrive.arr_quant,
sl_color = s.sl_color,
sl_len = s.sl_len,
sl_unit = s.sl_unit
FROM shoelace_arrive shoelace_arrive, shoelace_ok shoelace_ok,
shoelace_ok old, shoelace_ok new,
shoelace shoelace, shoelace old,
shoelace new, shoelace_data shoelace_data,
shoelace old, shoelace new,
shoelace_data s, unit u
WHERE s.sl_name = shoelace_arrive.arr_name
AND shoelace_data.sl_name = s.sl_name;
最后，规则log_shoelace被应用，生成额外的查询树：
INSERT INTO shoelace_log
SELECT s.sl_name,
s.sl_avail + shoelace_arrive.arr_quant,
current_user,
current_timestamp
FROM shoelace_arrive shoelace_arrive, shoelace_ok shoelace_ok,
shoelace_ok old, shoelace_ok new,
shoelace shoelace, shoelace old,
shoelace new, shoelace_data shoelace_data,
shoelace old, shoelace new,
shoelace_data s, unit u,
shoelace_data old, shoelace_data new
shoelace_log shoelace_log
WHERE s.sl_name = shoelace_arrive.arr_name
AND shoelace_data.sl_name = s.sl_name
AND (s.sl_avail + shoelace_arrive.arr_quant) <> s.sl_avail;
完成这些之后，规则系统用完了所有的规则并且返回生成的查询树。
所以我们结束于两个最终查询树，它们等效于SQL语句：
INSERT INTO shoelace_log
SELECT s.sl_name,
s.sl_avail + shoelace_arrive.arr_quant,
current_user,
current_timestamp
FROM shoelace_arrive shoelace_arrive, shoelace_data shoelace_data,
shoelace_data s
WHERE s.sl_name = shoelace_arrive.arr_name
AND shoelace_data.sl_name = s.sl_name
AND s.sl_avail + shoelace_arrive.arr_quant <> s.sl_avail;
UPDATE shoelace_data
SET sl_avail = shoelace_data.sl_avail + shoelace_arrive.arr_quant
FROM shoelace_arrive shoelace_arrive,
shoelace_data shoelace_data,
shoelace_data s
WHERE s.sl_name = shoelace_arrive.sl_name
AND shoelace_data.sl_name = s.sl_name;
结果是从一个关系来的数据插入了到另一个中，改变成第三个上的更新，改变成更新第四个外加做日志，在第五个中的最后更新缩减为两个查询。
有一个小细节有点丑陋。看看那两个查询，我们会发现shoelace_data关系在范围表中出现了两次而实际上绝对可以缩为出现一次。规划器不会处理它，因此INSERT的规则系统输出的执行规划会是
Nested Loop
->  Merge Join
->  Seq Scan
->  Sort
->  Seq Scan on s
->  Seq Scan
->  Sort
->  Seq Scan on shoelace_arrive
->  Seq Scan on shoelace_data
在省略额外的范围表项后会得到
Merge Join
->  Seq Scan
->  Sort
->  Seq Scan on s
->  Seq Scan
->  Sort
->  Seq Scan on shoelace_arrive
这在日志表中生成完全一样的项。因此，规则系统导致了shoelace_data表上的一次绝对不必要的扫描。并且同样的冗余扫描会在UPDATE中进行。但是要把这些全部实现实在是一项很困难的工作。
现在我们对PostgreSQL规则系统及其能力做最后一个演示。假设你向你的数据库中添加一些有特别颜色的鞋带：
INSERT INTO shoelace VALUES ('sl9', 0, 'pink', 35.0, 'inch', 0.0);
INSERT INTO shoelace VALUES ('sl10', 1000, 'magenta', 40.0, 'inch', 0.0);
我们想要建立一个视图来检查哪些shoelace项在颜色上不配任何鞋子。适用的视图是：
CREATE VIEW shoelace_mismatch AS
SELECT * FROM shoelace WHERE NOT EXISTS
(SELECT shoename FROM shoe WHERE slcolor = sl_color);
它的输出是：
SELECT * FROM shoelace_mismatch;
sl_name | sl_avail | sl_color | sl_len | sl_unit | sl_len_cm
---------+----------+----------+--------+---------+-----------
sl9     |        0 | pink     |     35 | inch    |      88.9
sl10    |     1000 | magenta  |     40 | inch    |     101.6
现在我们想建立它，这样没有库存的不匹配的鞋带都会被从数据库中删除。为了对PostgreSQL有点难度，我们不直接删除它们。而是我们再创建一个视图：
CREATE VIEW shoelace_can_delete AS
SELECT * FROM shoelace_mismatch WHERE sl_avail = 0;
然后用下面方法：
DELETE FROM shoelace WHERE EXISTS
(SELECT * FROM shoelace_can_delete
WHERE sl_name = shoelace.sl_name);
结果是：
SELECT * FROM shoelace;
sl_name | sl_avail | sl_color | sl_len | sl_unit | sl_len_cm
---------+----------+----------+--------+---------+-----------
sl1     |        5 | black    |     80 | cm      |        80
sl2     |        6 | black    |    100 | cm      |       100
sl7     |        6 | brown    |     60 | cm      |        60
sl4     |        8 | black    |     40 | inch    |     101.6
sl3     |       10 | black    |     35 | inch    |      88.9
sl8     |       21 | brown    |     40 | inch    |     101.6
sl10    |     1000 | magenta  |     40 | inch    |     101.6
sl5     |        4 | brown    |      1 | m       |       100
sl6     |       20 | brown    |    0.9 | m       |        90
(9 rows)
对一个视图上的DELETE，这个命令带有一个总共使用了四个嵌套/连接视图的子查询条件，这四个视图之一本身有一个包含一个视图的子查询条件，该条件计算使用的视图列；这个命令被重写成了一个查询树，该查询树从一个真正的表里面把需要删除的数据删除。
在现实世界里只有很少的情况需要这样的构造。但这些东西能运转肯定让你感觉不错。
上一页 上一级 下一页39.3. 物化视图 起始页 39.5. 规则和权限
