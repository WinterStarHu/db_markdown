# F.8. btree_gist — 具有B树行为的GiST操作符类

F.8. btree_gist — 具有B树行为的GiST操作符类
版本：
纠错本页面
搜索
目录导航
❮
❯
F.8. btree_gist — 具有B树行为的GiST操作符类 #F.8.1. 用法示例F.8.2. 作者
btree_gist 提供了GiST索引操作符类，实现了对数据类型
int2, int4, int8, float4,
float8, numeric, timestamp with time zone,
timestamp without time zone, time with time zone,
time without time zone, date, interval,
oid, money, char,
varchar, text, bytea, bit,
varbit, macaddr, macaddr8, inet,
cidr, uuid, bool 和所有 enum 类型的B树等效行为。
通常，这些操作符类不会比等效的标准 B 树索引方法更好，并且它们缺少标准 B 树代码的一个主要特性：强制唯一性的能力。然而，如下文所述，它们提供了在一个 B 树索引中没有的一些其他特性。另外，当需要一个多列 GiST 索引，并且其某些列的数据类型只在 GiST 中是可索引的而其他列是简单数据类型时，这些操作符类就有用了。最后，这些操作符类可以用于 GiST 测试以及作为开发其他 GiST 操作符类的基础。
除了典型的 B 树搜索操作符之外，btree_gist 也为 <>（“不等于”）提供了索引支持。这可能与下文描述的 排他约束 组合在一起产生作用。
另外，对于那些具有自然距离度量的数据类型，btree_gist 定义了一个距离操作符 <->，并且为使用这个操作符的最近邻搜索提供了 GiST 索引支持。距离操作符还提供给了：int2、int4、int8、float4、
float8、timestamp with time zone、
timestamp without time zone、
time without time zone、date、interval、
oid 和 money。
默认情况下，btree_gist 以 排序
模式使用 sortsupport 构建 GiST 索引，
这通常能大幅提升索引构建速度。在创建索引时也可以通过
buffering 参数切换回缓冲构建策略。
这个模块被认为是 “trusted”，也就是说，它可以被当前数据库中拥有 CREATE 特权的非超级用户安装。
F.8.1. 用法示例 #
使用btree_gist代替btree的简单例子：
CREATE TABLE test (a int4);
-- create index
CREATE INDEX testidx ON test USING GIST (a);
-- query
SELECT * FROM test WHERE a < 10;
-- nearest-neighbor search: find the ten entries closest to "42"
SELECT *, a <-> 42 AS dist FROM test ORDER BY a <-> 42 LIMIT 10;
使用一个排他约束来强制规则：一个动物园里的一个笼子只能装一种动物：
=> CREATE TABLE zoo (
cage   INTEGER,
animal TEXT,
EXCLUDE USING GIST (cage WITH =, animal WITH <>)
);
=> INSERT INTO zoo VALUES(123, 'zebra');
INSERT 0 1
=> INSERT INTO zoo VALUES(123, 'zebra');
INSERT 0 1
=> INSERT INTO zoo VALUES(123, 'lion');
ERROR:  conflicting key value violates exclusion constraint "zoo_cage_animal_excl"
DETAIL:  Key (cage, animal)=(123, lion) conflicts with existing key (cage, animal)=(123, zebra).
=> INSERT INTO zoo VALUES(124, 'lion');
INSERT 0 1
F.8.2. 作者 #
Teodor Sigaev（<teodor@stack.net>）、
Oleg Bartunov (<oleg@sai.msu.su>)、
Janko Richter (<jankorichter@yahoo.de>)和
Paul Jungwirth (<pj@illuminatedcomputing.com>)。参阅
http://www.sai.msu.su/~megera/postgres/gist/。
上一页 上一级 下一页F.7. btree_gin — 具有B-tree行为的GIN操作符类 起始页 F.9. citext — 一种不区分大小写的字符字符串类型
