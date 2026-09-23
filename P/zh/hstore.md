# F.17. hstore — hstore 键/值数据类型

F.17. hstore — hstore 键/值数据类型
版本：
纠错本页面
搜索
目录导航
❮
❯
F.17. hstore — hstore 键/值数据类型 #F.17.1. hstore 外部表示F.17.2. hstore 操作符和函数F.17.3. 索引F.17.4. 示例F.17.5. 统计F.17.6. 兼容性F.17.7. 转换F.17.8. 作者
这个模块实现了hstore数据类型用来在一个单一PostgreSQL值中存储键值对。这在各种场景下都有用，例如带有很多很少被检查的属性的行或者半结构化数据。键和值都是简单的文本字符串。
这个模块被视为“trusted”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.17.1. hstore 外部表示 #
一个hstore的文本表示用于输入和输出，包括零个或者多个由逗号分隔的key => value对。一些例子：
k => v
foo => bar, baz => whatever
"1-a" => "anything at all"
键值对的顺序没有意义（并且在输出时也不会重现）。键值对之间或者=>号周围的空白会被忽略。双引号内的键和值可以包括空白、逗号、=或>。要在一个键或值中包括一个双引号或一个反斜线，用一个反斜线对它转义。
一个hstore中的每一个键是唯一的。如果你声明了一个有重复键的hstore，只有一个会被存储在hstore中并且无法保证哪一个将被保留：
SELECT 'a=>1,a=>2'::hstore;
hstore
----------------
"a"=>"1"
一个值（但不是一个键）可以是一个 SQL NULL。例如：
key => NULL
NULL关键词是大小写不敏感的。将NULL放在双引号中可以将它当作一个普通的字符串“NULL”。
注意
记住当hstore文本格式被用于输入时，它应用在任何必须的引用或转义之前。如果你通过一个参数传递一个hstore文字，那么不需要额外的处理。但是如果你将它作为一个引用的文字常数，那么任何单引号字符以及（取决于standard_conforming_strings配置参数的设置）反斜线字符需要被正确地转义。更多关于处理字符串常量的内容可见第 4.1.2.1 节。
在输出时，双引号总是围绕着键和值，即使这样做不是绝对必要。
F.17.2. hstore 操作符和函数 #
hstore模块所提供的操作符显示在表 F.6中，函数在表 F.7中。
表 F.6. hstore 操作符
操作符
描述
示例
hstore -> text
→ text
返回与给定键相关联的值，如果不存在则返回NULL。
'a=>x, b=>y'::hstore -> 'a'
→ x
hstore -> text[]
→ text[]
返回与给定键（多个）相关联的值，如果不存在则返回NULL。
'a=>x, b=>y, c=>z'::hstore -> ARRAY['c','a']
→ {"z","x"}
hstore || hstore
→ hstore
连接两个 hstore。
'a=>b, c=>d'::hstore || 'c=>x, d=>q'::hstore
→ "a"=>"b", "c"=>"x", "d"=>"q"
hstore ? text
→ boolean
hstore 是否包含键？
'a=>1'::hstore ? 'a'
→ t
hstore ?& text[]
→ boolean
hstore 是否包含所有指定的键？
'a=>1,b=>2'::hstore ?& ARRAY['a','b']
→ t
hstore ?| text[]
→ boolean
hstore 是否包含任何指定的键？
'a=>1,b=>2'::hstore ?| ARRAY['b','c']
→ t
hstore @> hstore
→ boolean
左操作数是否包含右操作数？
'a=>b, b=>1, c=>NULL'::hstore @> 'b=>1'
→ t
hstore <@ hstore
→ boolean
左操作数是否包含在右操作数中？
'a=>c'::hstore <@ 'a=>b, b=>1, c=>NULL'
→ f
hstore - text
→ hstore
从左操作数中删除键。
'a=>1, b=>2, c=>3'::hstore - 'b'::text
→ "a"=>"1", "c"=>"3"
hstore - text[]
→ hstore
从左操作数中删除多个键。
'a=>1, b=>2, c=>3'::hstore - ARRAY['a','b']
→ "c"=>"3"
hstore - hstore
→ hstore
从左操作数中删除与右操作数中的对相匹配的对。
'a=>1, b=>2, c=>3'::hstore - 'a=>4, b=>2'::hstore
→ "a"=>"1", "c"=>"3"
anyelement #= hstore
→ anyelement
用hstore中匹配的值替换左操作数（必须是复合类型）中的字段。
ROW(1,3) #= 'f1=>11'::hstore
→ (11,3)
%% hstore
→ text[]
将hstore转换为交替的键和值的数组。
%% 'a=>foo, b=>bar'::hstore
→ {a,foo,b,bar}
%# hstore
→ text[]
将hstore转换为二维的键/值数组。
%# 'a=>foo, b=>bar'::hstore
→ {{a,foo},{b,bar}}
表 F.7. hstore 函数
函数
描述
示例
hstore ( record )
→ hstore
从一个记录或行构造一个hstore。
hstore(ROW(1,2))
→ "f1"=>"1", "f2"=>"2"
hstore ( text[] )
→ hstore
从一个数组构造hstore，可以是键/值数组，也可以是二维数组。
hstore(ARRAY['a','1','b','2'])
→ "a"=>"1", "b"=>"2"
hstore(ARRAY[['c','3'],['d','4']])
→ "c"=>"3", "d"=>"4"
hstore ( text[], text[] )
→ hstore
从单独的键和值数组构造一个hstore。
hstore(ARRAY['a','b'], ARRAY['1','2'])
→ "a"=>"1", "b"=>"2"
hstore ( text, text )
→ hstore
创建一个单项hstore。
hstore('a', 'b')
→ "a"=>"b"
akeys ( hstore )
→ text[]
提取一个hstore的键作为数组。
akeys('a=>1,b=>2')
→ {a,b}
skeys ( hstore )
→ setof text
提取一个hstore的键作为一个集合。
skeys('a=>1,b=>2')
→
a
b
avals ( hstore )
→ text[]
提取一个hstore的值作为数组。
avals('a=>1,b=>2')
→ {1,2}
svals ( hstore )
→ setof text
提取一个hstore的值作为一个集合。
svals('a=>1,b=>2')
→
1
2
hstore_to_array ( hstore )
→ text[]
提取一个hstore的键和值为键和值交替数组。
hstore_to_array('a=>1,b=>2')
→ {a,1,b,2}
hstore_to_matrix ( hstore )
→ text[]
提取一个hstore的键和值为二维数组。
hstore_to_matrix('a=>1,b=>2')
→ {{a,1},{b,2}}
hstore_to_json ( hstore )
→ json
将hstore转换为json值，将所有非空值转换为JSON字符串。
当hstore值被转换为json时，隐式使用此函数。
hstore_to_json('"a key"=>1, b=>t, c=>null, d=>12345, e=>012345, f=>1.234, g=>2.345e+4')
→ {"a key": "1", "b": "t", "c": null, "d": "12345", "e": "012345", "f": "1.234", "g": "2.345e+4"}
hstore_to_jsonb ( hstore )
→ jsonb
将hstore转换为jsonb值，将所有非空值转换为JSON字符串。
当hstore值转换为jsonb时，隐式使用此函数。
hstore_to_jsonb('"a key"=>1, b=>t, c=>null, d=>12345, e=>012345, f=>1.234, g=>2.345e+4')
→ {"a key": "1", "b": "t", "c": null, "d": "12345", "e": "012345", "f": "1.234", "g": "2.345e+4"}
hstore_to_json_loose ( hstore )
→ json
将hstore转换为json值，但尝试区分数值和布尔值，使它们在JSON中未引用。
hstore_to_json_loose('"a key"=>1, b=>t, c=>null, d=>12345, e=>012345, f=>1.234, g=>2.345e+4')
→ {"a key": 1, "b": true, "c": null, "d": 12345, "e": "012345", "f": 1.234, "g": 2.345e+4}
hstore_to_jsonb_loose ( hstore )
→ jsonb
将hstore转换为jsonb值，但试图区分数值和布尔值，使它们在JSON中不带引号。
hstore_to_jsonb_loose('"a key"=>1, b=>t, c=>null, d=>12345, e=>012345, f=>1.234, g=>2.345e+4')
→ {"a key": 1, "b": true, "c": null, "d": 12345, "e": "012345", "f": 1.234, "g": 2.345e+4}
slice ( hstore, text[] )
→ hstore
提取仅包含指定键的hstore的子集。
slice('a=>1,b=>2,c=>3'::hstore, ARRAY['b','c','x'])
→ "b"=>"2", "c"=>"3"
each ( hstore )
→ setof record
( key text,
value text )
提取hstore的键和值作为一组记录。
select * from each('a=>1,b=>2')
→
key | value
-----+-------
a   | 1
b   | 2
exist ( hstore, text )
→ boolean
hstore 是否包含键?
exist('a=>1', 'a')
→ t
defined ( hstore, text )
→ boolean
hstore 是否包含针对键的非NULL值？
defined('a=>NULL', 'a')
→ f
delete ( hstore, text )
→ hstore
删除带有匹配键的对。
delete('a=>1,b=>2', 'b')
→ "a"=>"1"
delete ( hstore, text[] )
→ hstore
删除带有匹配键的对。
delete('a=>1,b=>2,c=>3', ARRAY['a','b'])
→ "c"=>"3"
delete ( hstore, hstore )
→ hstore
删除在第二个参数中匹配的对。
delete('a=>1,b=>2', 'a=>4,b=>2'::hstore)
→ "a"=>"1"
populate_record ( anyelement, hstore )
→ anyelement
用hstore中的匹配值替换左操作数（必须是复合类型）中的字段。
populate_record(ROW(1,2), 'f1=>42'::hstore)
→ (42,2)
除了这些运算符和函数之外，hstore类型的值可以被索引，在这种情况下它们的行为就像关联数组。 只允许该类型的单个下标。下标被解释为一个键，并检索或存储相应的值。例如，
CREATE TABLE mytable (h hstore);
INSERT INTO mytable VALUES ('a=>b, c=>d');
SELECT h['a'] FROM mytable;
h
----
b
(1 row)
UPDATE mytable SET h['c'] = 'new';
SELECT h FROM mytable;
h
---------------------------------
"a"=>"b", "c"=>"new"
(1 row)
如果索引是NULL，或者该键在hstore中不存在，则按索引获取NULL返回。（所以下标检索与->操作符没有太大区别。）如果下标是NULL，则下标更新失败；否则，它会替换与该键对应的值，如果该键不存在，则添加一个条目到hstore中。
F.17.3. 索引 #
hstore有对@>、?、?&和?|操作符的 GiST 和 GIN 索引支持。例如：
CREATE INDEX hidx ON testhstore USING GIST (h);
CREATE INDEX hidx ON testhstore USING GIN (h);
gist_hstore_ops GiST 操作符类(opclass)将一组键/值对近似计算为位图签名。它的可选整数参数siglen决定了签名的字节长度。
默认长度为16字节。签名长度的有效值在1到2024字节之间。
更长的签名将导致更精确的搜索(扫描更小的索引部分和更少的堆页)，以更大的索引为代价。
创建这样的一个带有32字节签名长度的示例：
CREATE INDEX hidx ON testhstore USING GIST (h gist_hstore_ops(siglen=32));
hstore也为=操作符支持btree或hash索引。这允许hstore列被声明为UNIQUE或者被使用在GROUP BY、ORDER BY或DISTINCT表达式中。hstore值的排序顺序不是特别有用，但是这些索引可能对等值查找有用。为=比较创建以下索引：
CREATE INDEX hidx ON testhstore USING BTREE (h);
CREATE INDEX hidx ON testhstore USING HASH (h);
F.17.4. 示例 #
增加一个键，或者用一个新值更新一个现有的键：
UPDATE tab SET h['c'] = '3';
另一种方法是：
UPDATE tab SET h = h || hstore('c', '3');
在单个操作中添加或修改多个键时，连接比下标更高效：
UPDATE tab SET h = h || hstore(array['q', 'w'], array['11', '12']);
删除一个键：
UPDATE tab SET h = delete(h, 'k1');
将record转换为hstore：
CREATE TABLE test (col1 integer, col2 text, col3 text);
INSERT INTO test VALUES (123, 'foo', 'bar');
SELECT hstore(t) FROM test AS t;
hstore
---------------------------------------------
"col1"=>"123", "col2"=>"foo", "col3"=>"bar"
(1 row)
将hstore转换为预定义的record类型：
CREATE TABLE test (col1 integer, col2 text, col3 text);
SELECT * FROM populate_record(null::test,
'"col1"=>"456", "col2"=>"zzz"');
col1 | col2 | col3
------+------+------
456 | zzz  |
(1 row)
使用hstore中的值修改现有记录：
CREATE TABLE test (col1 integer, col2 text, col3 text);
INSERT INTO test VALUES (123, 'foo', 'bar');
SELECT (r).* FROM (SELECT t #= '"col3"=>"baz"' AS r FROM test t) s;
col1 | col2 | col3
------+------+------
123 | foo  | baz
(1 row)
F.17.5. 统计 #
由于hstore类型本质的宽大性，它能够包含许多不同的键。检查合法键是应用的任务。下列例子验证了用于检查键以及获得统计的一些技术。
简单例子：
SELECT * FROM each('aaa=>bq, b=>NULL, ""=>1');
使用一个表：
CREATE TABLE stat AS SELECT (each(h)).key, (each(h)).value FROM testhstore;
在线统计：
SELECT key, count(*) FROM
(SELECT (each(h)).key FROM testhstore) AS stat
GROUP BY key
ORDER BY count DESC, key;
key    | count
-----------+-------
line      |   883
query     |   207
pos       |   203
node      |   202
space     |   197
status    |   195
public    |   194
title     |   190
org       |   189
...................
F.17.6. 兼容性 #
从 PostgreSQL 9.0 开始，hstore使用了与之前版本不同的内部表示。这不会为转储/恢复升级造成障碍，因为文本表示（用于转储）没有改变。
在一次二进制升级中，通过让新代码识别旧格式数据来维持向上兼容。当处理还没有被新代码修改过的数据时，这会带来一定的性能惩罚。可以通过执行一个下面的UPDATE语句来强制升级表中的所有值：
UPDATE tablename SET hstorecol = hstorecol || '';
另一种方法：
ALTER TABLE tablename ALTER hstorecol TYPE hstore USING hstorecol || '';
ALTER TABLE方法要求表上的一个ACCESS EXCLUSIVE 锁，但是不会导致表因为旧行版本而膨胀。
F.17.7. 转换 #
可以使用附加的扩展来实现对hstore类型的转换，适用于PL/Perl和PL/Python语言。
用于PL/Perl的扩展称为hstore_plperl和hstore_plperlu，
分别用于受信任和不受信任的PL/Perl。如果安装这些转换并在创建函数时指定它们，
hstore值将映射到Perl哈希。用于PL/Python的扩展称为hstore_plpython3u。
如果使用它，hstore值将映射到Python字典。
F.17.8. 作者 #
Oleg Bartunov <oleg@sai.msu.su>，俄罗斯莫斯科大学
Teodor Sigaev <teodor@sigaev.ru>，俄罗斯德尔塔软件有限公司
额外的增强由英国的 Andrew Gierth <andrew@tao11.riddles.org.uk> 提供
上一页 上一级 下一页F.16. fuzzystrmatch — 确定字符串相似性和距离 起始页 F.18. intagg — 整数聚合器和枚举器
