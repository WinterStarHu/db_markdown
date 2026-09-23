# F.22. ltree — 层次树状数据类型

F.22. ltree — 层次树状数据类型
版本：
纠错本页面
搜索
目录导航
❮
❯
F.22. ltree — 层次树状数据类型 #F.22.1. 定义F.22.2. 操作符和函数F.22.3. 索引F.22.4. 示例F.22.5. 转换F.22.6. 作者
这个模块实现了一种数据类型ltree用于表示存储在一个层次树状结构中的数据的标签。提供了在标签树中搜索的扩展功能。
这个模块被视为“trusted”，也就是说，它可以由拥有CREATE特权的非超级用户安装在当前数据库上。
F.22.1. 定义 #
一个标签是由字母数字字符、下划线和连字符组成的序列。
有效的字母数字字符范围取决于数据库的区域设置。例如，在C区域设置中，
允许的字符是A-Za-z0-9_-。
标签的长度不得超过1000个字符。
例子：42, Personal_Services
一个标签路径是由点号分隔的零个或多个标签的序列，例如L1.L2.L3，它表示一个从层次树的根到一个特定节点的路径。
一个标签路径的长度不能超过65535个标签。
例子：Top.Countries.Europe.Russia
ltree模块提供几种数据类型：
ltree存储一个标签路径。
lquery表示一个用于匹配ltree值的类正则表达式的模式。一个简单词匹配一个路径中的那个标签。
一个星号（*）匹配零个或更多个标签。它们可以用点连接起来，以形成一个必须匹配整个标签路径的模式。例如：
foo         正好匹配标签路径foo
*.foo.*     匹配任何包含标签foo的标签路径
*.foo       匹配任何最后一个标签是foo的标签路径
星号和简单词都可以被限定来限制它能匹配多少标签：
*{n}        匹配正好n个标签
*{n,}       匹配至少n个标签
*{n,m}      匹配至少n个但不超过m个标签
*{,m}       匹配最多m个标签 — 与*{0,m}相同
foo{n,m}    匹配至少n个但不超过m次的foo
foo{,}      匹配任何数量的foo，包括零
在缺乏任何显式量词的情况下，星号的默认值是匹配任意数量的标签（也就是{,}），而非星号项的默认值是只匹配一次（也就是{1}）。
有几个修饰符可以放在一个非星号的lquery项的末尾，使它能匹配除了精确匹配之外更多的匹配：
@           不区分大小写匹配，例如a@匹配A
*           匹配带此前缀的任何标签，例如foo*匹配foobar
%           匹配开头以下划线分隔的词
%的行为有点复杂。它尝试匹配词而不是整个标签。例如，foo_bar%匹配foo_bar_baz但是不匹配foo_barbaz。如果和*组合，前缀匹配可以单独应用于每一个词，例如foo_bar%*匹配foo1_bar2_baz但不匹配foo1_br2_baz。
此外，你可以写多个带有|（OR）的可能修改的非星号项目来匹配那些项目中的任何一个（或几个），并且你可以在非星号组最前面放上!（NOT）来匹配任何不匹配那些分支的标签。
量词，若有的话，位于组的末尾；它意味着作为一个整体的组的一些匹配（也就是说，一些匹配或不匹配任何替代的标签）。
这里是一个lquery的例子：
Top.*{0,2}.sport*@.!football|tennis{1,}.Russ*|Spain
a.  b.     c.      d.                   e.
这个查询将匹配任何这样的标签路径：
开始于标签Top
并且接着具有零到两个标签
之后是一个以大小写无关的前缀sport开头的标签
然后有一个或多个标签，没有匹配football或tennis。
并且结尾是一个以Russ开头的标签，或者完全匹配Spain的标签。
ltxtquery表示一种用于匹配ltree值的类全文搜索的模式。一个ltxtquery值包含词，也可能在末尾带有修饰符@、*、%，修饰符具有和lquery中相同的含义。词可以用&（AND）、|（OR）、!（NOT）以及圆括号组合。lquery和ltxtquery的关键区别是ltxtquery匹配词时不考虑它们在标签路径中的位置。
这是一个ltxtquery的例子：
Europe & Russia*@ & !Transportation
这将匹配包含标签Europe以及任何以Russia开头（大小写不敏感）的标签的路径，但是不匹配包含标签Transportation的路径。这些词在路径中的位置并不重要。还有，当使用%时，该词可以与一个标签中任何下划线分隔的词匹配，而不管它们的位置如何。
注意：ltxtquery允许符号之间的空白，但是ltree和lquery不允许。
F.22.2. 操作符和函数 #
类型ltree有普通比较操作符
=、<>、
<、>、<=、>=。
比较会按照树遍历的顺序排序，一个节点的子女按照标签文本排序。另外，还有表 F.12中显示的特殊操作符。
表 F.12. ltree 操作符
操作符
描述
ltree @> ltree
→ boolean
左参数是右参数的祖先（或相等）吗？
ltree <@ ltree
→ boolean
左参数是右参数的后代（或相等）吗？
ltree ~ lquery
→ boolean
lquery ~ ltree
→ boolean
ltree 匹配 lquery 吗？
ltree ? lquery[]
→ boolean
lquery[] ? ltree
→ boolean
ltree 在数组中匹配任何 lquery 吗？
ltree @ ltxtquery
→ boolean
ltxtquery @ ltree
→ boolean
ltree 匹配 ltxtquery 吗？
ltree || ltree
→ ltree
连接 ltree 路径。
ltree || text
→ ltree
text || ltree
→ ltree
将文本转换为 ltree 并连接。
ltree[] @> ltree
→ boolean
ltree <@ ltree[]
→ boolean
数组中包含一个 ltree 的祖先吗？
ltree[] <@ ltree
→ boolean
ltree @> ltree[]
→ boolean
数组中包含一个 ltree 的后代吗？
ltree[] ~ lquery
→ boolean
lquery ~ ltree[]
→ boolean
数组中包含匹配 lquery 的任何路径吗？
ltree[] ? lquery[]
→ boolean
lquery[] ? ltree[]
→ boolean
ltree 数组中包含匹配任何 lquery 的任何路径吗？
ltree[] @ ltxtquery
→ boolean
ltxtquery @ ltree[]
→ boolean
数组中包含匹配 ltxtquery 的任何路径吗？
ltree[] ?@> ltree
→ ltree
返回作为ltree祖先的第一个数组条目，如果没有则返回NULL。
ltree[] ?<@ ltree
→ ltree
返回作为ltree后代的第一个数组条目，如果没有则返回NULL。
ltree[] ?~ lquery
→ ltree
返回匹配lquery的第一个数组条目，如果没有，则返回NULL。
ltree[] ?@ ltxtquery
→ ltree
返回匹配ltxtquery的第一个数组条目，如果没有，则返回NULL。
操作符<@、@>、
@和~有类似的
^<@、^@>、^@、
^~，只是它们不使用索引。它们只对测试目的有用。
可用的函数在表 F.13中。
表 F.13. ltree 函数
函数
描述
示例
subltree ( ltree, start integer, end integer )
→ ltree
返回从位置start到位置end-1的ltree的子路径（从0开始计数）。
subltree('Top.Child1.Child2', 1, 2)
→ Child1
subpath ( ltree, offset integer, len integer )
→ ltree
返回从位置offset开始的ltree的子路径，长度为len。
如果offset为负，则子路径从距离路径终点-offset标签开始。如果len为负，将许多标签留在路径的末尾。
subpath('Top.Child1.Child2', 0, 2)
→ Top.Child1
subpath ( ltree, offset integer )
→ ltree
返回从位置offset开始的ltree的子路径，扩展到路径的结束。
如果offset为负，则子路径从距离路径终点的远端开始。
subpath('Top.Child1.Child2', 1)
→ Child1.Child2
nlevel ( ltree )
→ integer
返回路径中标签的数量。
nlevel('Top.Child1.Child2')
→ 3
index ( a ltree, b ltree )
→ integer
返回b在a中第一次出现的位置，如果没有发现则返回-1。
index('0.1.2.3.5.4.5.6.8.5.6.8', '5.6')
→ 6
index ( a ltree,  b ltree, offset integer )
→ integer
返回b在a中第一次出现的位置，如果没有发现则返回-1。
搜索从位置offset开始；负的offset是指从路径的末端开始的-offset标签。
index('0.1.2.3.5.4.5.6.8.5.6.8', '5.6', -4)
→ 9
text2ltree ( text )
→ ltree
将text转换为ltree。
ltree2text ( ltree )
→ text
将ltree转换为text。
lca ( ltree [, ltree [, ... ]] )
→ ltree
计算路径的最长公共祖先（最多可支持8个参数）。
lca('1.2.3', '1.2.3.4.5.6')
→ 1.2
lca ( ltree[] )
→ ltree
计算数组中的路径的最长公共祖先。
lca(array['1.2.3'::ltree,'1.2.3.4'])
→ 1.2
F.22.3. 索引 #
ltree支持几种可以加速指定操作符的索引类型：
ltree上的 B-树索引：
<、<=、=、
>=、>
Hash 索引基于 ltree：
=
ltree 之上的 GiST 索引 (gist_ltree_ops
opclass):
<、<=、=、
>=、>、
@>、<@、
@、~、?
gist_ltree_ops GiST opclass 近似将一组路径标签表示为位图签名。
其可选整数参数 siglen 确定签名长度（以字节为单位）。
默认签名长度为 8 字节。长度必须是 int 对齐的正整数倍（大多数机器上为 4 字节），
最多为 2024。更长的签名会导致更精确的搜索（扫描索引的较小部分和较少的堆页），
但会增加索引的大小。
创建默认签名长度为8字节的索引的例子：
CREATE INDEX path_gist_idx ON test USING GIST (path);
创建签名长度为100字节的索引的例子：
CREATE INDEX path_gist_idx ON test USING GIST (path gist_ltree_ops(siglen=100));
GiST索引在ltree[]（gist__ltree_ops opclass）上：
ltree[] <@ ltree、ltree @> ltree[]、
@、~、?
gist__ltree_ops GiST opclass 的工作类似于
gist_ltree_ops，并且也使用签名长度作为参数。默认值
siglen 在gist__ltree_ops中为28字节。
创建这样一个默认签名长度为28字节的索引的例子：
CREATE INDEX path_gist_idx ON test USING GIST (array_path);
创建签名长度为100字节的索引的例子：
CREATE INDEX path_gist_idx ON test USING GIST (array_path gist__ltree_ops(siglen=100));
注意：这种索引类型是有损的。
F.22.4. 示例 #
这个例子使用下列数据（在源代码发布的contrib/ltree/ltreetest.sql文件中也有）：
CREATE TABLE test (path ltree);
INSERT INTO test VALUES ('Top');
INSERT INTO test VALUES ('Top.Science');
INSERT INTO test VALUES ('Top.Science.Astronomy');
INSERT INTO test VALUES ('Top.Science.Astronomy.Astrophysics');
INSERT INTO test VALUES ('Top.Science.Astronomy.Cosmology');
INSERT INTO test VALUES ('Top.Hobbies');
INSERT INTO test VALUES ('Top.Hobbies.Amateurs_Astronomy');
INSERT INTO test VALUES ('Top.Collections');
INSERT INTO test VALUES ('Top.Collections.Pictures');
INSERT INTO test VALUES ('Top.Collections.Pictures.Astronomy');
INSERT INTO test VALUES ('Top.Collections.Pictures.Astronomy.Stars');
INSERT INTO test VALUES ('Top.Collections.Pictures.Astronomy.Galaxies');
INSERT INTO test VALUES ('Top.Collections.Pictures.Astronomy.Astronauts');
CREATE INDEX path_gist_idx ON test USING GIST (path);
CREATE INDEX path_idx ON test USING BTREE (path);
CREATE INDEX path_hash_idx ON test USING HASH (path);
现在，我们有一个表test，它被填充了描述下列层次的数据：
Top
/   |  \
Science Hobbies Collections
/       |              \
Astronomy   Amateurs_Astronomy Pictures
/  \                            |
Astrophysics  Cosmology                Astronomy
/  |    \
Galaxies Stars Astronauts
我们可以做继承：
ltreetest=> SELECT path FROM test WHERE path <@ 'Top.Science';
path
------------------------------------
Top.Science
Top.Science.Astronomy
Top.Science.Astronomy.Astrophysics
Top.Science.Astronomy.Cosmology
(4 rows)
这里是一些路径匹配的例子：
ltreetest=> SELECT path FROM test WHERE path ~ '*.Astronomy.*';
path
-----------------------------------------------
Top.Science.Astronomy
Top.Science.Astronomy.Astrophysics
Top.Science.Astronomy.Cosmology
Top.Collections.Pictures.Astronomy
Top.Collections.Pictures.Astronomy.Stars
Top.Collections.Pictures.Astronomy.Galaxies
Top.Collections.Pictures.Astronomy.Astronauts
(7 rows)
ltreetest=> SELECT path FROM test WHERE path ~ '*.!pictures@.Astronomy.*';
path
------------------------------------
Top.Science.Astronomy
Top.Science.Astronomy.Astrophysics
Top.Science.Astronomy.Cosmology
(3 rows)
这里是一些全文搜索的例子：
ltreetest=> SELECT path FROM test WHERE path @ 'Astro*% & !pictures@';
path
------------------------------------
Top.Science.Astronomy
Top.Science.Astronomy.Astrophysics
Top.Science.Astronomy.Cosmology
Top.Hobbies.Amateurs_Astronomy
(4 rows)
ltreetest=> SELECT path FROM test WHERE path @ 'Astro* & !pictures@';
path
------------------------------------
Top.Science.Astronomy
Top.Science.Astronomy.Astrophysics
Top.Science.Astronomy.Cosmology
(3 rows)
使用函数的路径构建：
ltreetest=> SELECT subpath(path,0,2)||'Space'||subpath(path,2) FROM test WHERE path <@ 'Top.Science.Astronomy';
?column?
------------------------------------------
Top.Science.Space.Astronomy
Top.Science.Space.Astronomy.Astrophysics
Top.Science.Space.Astronomy.Cosmology
(3 rows)
我们可以通过创建一个在路径中指定位置插入标签的 SQL 函数来简化：
CREATE FUNCTION ins_label(ltree, int, text) RETURNS ltree
AS 'select subpath($1,0,$2) || $3 || subpath($1,$2);'
LANGUAGE SQL IMMUTABLE;
ltreetest=> SELECT ins_label(path,2,'Space') FROM test WHERE path <@ 'Top.Science.Astronomy';
ins_label
------------------------------------------
Top.Science.Space.Astronomy
Top.Science.Space.Astronomy.Astrophysics
Top.Science.Space.Astronomy.Cosmology
(3 rows)
F.22.5. 转换 #
ltree_plpython3u扩展实现了 PL/Python 的 ltree 类型的转换。
如果安装并在创建函数时指定，ltree 值将映射到 Python 列表。
（目前不支持反向操作。）
F.22.6. 作者 #
所有工作都是 Teodor Sigaev（<teodor@stack.net>）和
Oleg Bartunov（<oleg@sai.msu.su>）完成的。额外信息可见
http://www.sai.msu.su/~megera/postgres/gist/。作者还要感谢 Eugeny Rodichev 参与讨论。欢迎评论和缺陷报告。
上一页 上一级 下一页F.21. lo — 管理大对象 起始页 F.23. pageinspect — 数据库页面的低级检查
