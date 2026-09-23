# F.7. btree_gin — 具有B-tree行为的GIN操作符类

F.7. btree_gin — 具有B-tree行为的GIN操作符类
版本：
纠错本页面
搜索
目录导航
❮
❯
F.7. btree_gin — 具有B-tree行为的GIN操作符类 #F.7.1. 用法示例F.7.2. 作者
btree_gin 提供了GIN操作符类，这些类为以下数据类型实现了
等效于B树的行为：int2、int4、int8、
float4、float8、timestamp with time zone、
timestamp without time zone、time with time zone、
time without time zone、date、interval、
oid、money、"char"、varchar、
text、bytea、bit、varbit、
macaddr、macaddr8、inet、cidr、
uuid、name、bool、bpchar，以及
所有enum类型。
通常，这些操作符类不会比等效的标准B树索引方法更好，并且它们缺少标准B树代码的一个主要特性：强制唯一性的能力。然而，它们有助于GIN测试并且有助于作为开发其他GIN操作符类的基础。另外，对于测试一个GIN可索引的列和一个B树可索引的列的查询，创建一个使用这些操作符类之一的多列GIN索引要比创建必须通过位图AND组合在一起的两个独立索引要更有效。
这个模块被认为是 “trusted”，也就是说，它可以被当前数据库中拥有CREATE特权的非超级用户安装。
F.7.1. 用法示例 #
CREATE TABLE test (a int4);
-- create index
CREATE INDEX testidx ON test USING GIN (a);
-- query
SELECT * FROM test WHERE a < 10;
F.7.2. 作者 #
Teodor Sigaev（<teodor@stack.net>）和 Oleg Bartunov（<oleg@sai.msu.su>）。有关更多信息，请参见http://www.sai.msu.su/~megera/oddmuse/index.cgi/Gin。
上一页 上一级 下一页F.6. bloom — bloom过滤器索引访问方法 起始页 F.8. btree_gist — 具有B树行为的GiST操作符类
