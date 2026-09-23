# F.16. fuzzystrmatch — 确定字符串相似性和距离

F.16. fuzzystrmatch — 确定字符串相似性和距离
版本：
纠错本页面
搜索
目录导航
❮
❯
F.16. fuzzystrmatch — 确定字符串相似性和距离 #F.16.1. SoundexF.16.2. Daitch-Mokotoff SoundexF.16.3. LevenshteinF.16.4. MetaphoneF.16.5. 双变音位
fuzzystrmatch模块提供多个函数来确定字符串之间的相似性和距离。
小心
目前，soundex、metaphone、
dmetaphone 和 dmetaphone_alt 函数在多字节编码
（例如 UTF-8）中效果不佳。对于此类数据，请使用 daitch_mokotoff
或 levenshtein。
这个模块被视为“trusted”，就是说，它可由在当前数据库上拥有CREATE特权的非超级用户安装。
F.16.1. Soundex #
Soundex系统是一种将相似发音的名字转换成相同的代码来匹配它们的方法。它最初由美国国家统计局在1880年、1900年和1910年使用。注意Soundex对于非英语名称不是很有用。
fuzzystrmatch模块提供了两个函数用于处理Soundex代码：
soundex(text) returns text
difference(text, text) returns int
soundex函数将一个字符串转换成它的Soundex代码。
difference函数将两个字符串转换成它们的Soundex
代码并报告匹配代码位置的数量。由于Soundex代码具有四个字符，
结果范围从零到四，零表示没有匹配而四表示完全匹配。
（因此，这个函数的命名并不适当 — similarity才是
更合适的名称。）
这里有一些用法示例：
SELECT soundex('hello world!');
SELECT soundex('Anne'), soundex('Ann'), difference('Anne', 'Ann');
SELECT soundex('Anne'), soundex('Andrew'), difference('Anne', 'Andrew');
SELECT soundex('Anne'), soundex('Margaret'), difference('Anne', 'Margaret');
CREATE TABLE s (nm text);
INSERT INTO s VALUES ('john');
INSERT INTO s VALUES ('joan');
INSERT INTO s VALUES ('wobbly');
INSERT INTO s VALUES ('jack');
SELECT * FROM s WHERE soundex(nm) = soundex('john');
SELECT * FROM s WHERE difference(s.nm, 'john') > 2;
F.16.2. Daitch-Mokotoff Soundex #
与原始的Soundex系统类似，Daitch-Mokotoff Soundex通过将相似发音的名字
转换为相同的代码来匹配它们。然而，Daitch-Mokotoff Soundex对于非英语
名字比原始系统显著更有用。相较于原始系统的主要改进包括：
代码基于前六个有意义的字母，而不是四个。
一个字母或字母组合映射到十个可能的代码，而不是七个。
当两个连续的字母具有单一的发音时，它们被编码为一个单一的数字。
当一个字母或字母组合可能有不同的发音时，会生成多个代码以涵盖
所有可能性。
此函数为其输入生成戴奇-莫科托夫 Soundex 代码：
daitch_mokotoff(source text) returns text[]
结果可能包含一个或多个代码，具体取决于有多少种可能的发音，
因此它被表示为一个数组。
由于戴奇-莫科托夫 Soundex 代码仅由 6 位数字组成，
source 最好是一个单词或名字。
这里有一些例子：
SELECT daitch_mokotoff('George');
daitch_mokotoff
-----------------
{595000}
SELECT daitch_mokotoff('John');
daitch_mokotoff
-----------------
{160000,460000}
SELECT daitch_mokotoff('Bierschbach');
daitch_mokotoff
-----------------------------------------------------------
{794575,794574,794750,794740,745750,745740,747500,747400}
SELECT daitch_mokotoff('Schwartzenegger');
daitch_mokotoff
-----------------
{479465}
对于单个名称的匹配，返回的文本数组可以直接使用
&& 运算符进行匹配：任何重叠都可以
被视为匹配。为了提高效率，可以使用 GIN 索引，
请参阅 第 65.4 节 以及以下示例：
CREATE TABLE s (nm text);
CREATE INDEX ix_s_dm ON s USING gin (daitch_mokotoff(nm)) WITH (fastupdate = off);
INSERT INTO s (nm) VALUES
('Schwartzenegger'),
('John'),
('James'),
('Steinman'),
('Steinmetz');
SELECT * FROM s WHERE daitch_mokotoff(nm) && daitch_mokotoff('Swartzenegger');
SELECT * FROM s WHERE daitch_mokotoff(nm) && daitch_mokotoff('Jane');
SELECT * FROM s WHERE daitch_mokotoff(nm) && daitch_mokotoff('Jens');
对于任意数量的名称进行索引和匹配，无论顺序如何，都可以使用全文
检索功能。请参阅第 12 章以及以下示例：
CREATE FUNCTION soundex_tsvector(v_name text) RETURNS tsvector
BEGIN ATOMIC
SELECT to_tsvector('simple',
string_agg(array_to_string(daitch_mokotoff(n), ' '), ' '))
FROM regexp_split_to_table(v_name, '\s+') AS n;
END;
CREATE FUNCTION soundex_tsquery(v_name text) RETURNS tsquery
BEGIN ATOMIC
SELECT string_agg('(' || array_to_string(daitch_mokotoff(n), '|') || ')', '&')::tsquery
FROM regexp_split_to_table(v_name, '\s+') AS n;
END;
CREATE TABLE s (nm text);
CREATE INDEX ix_s_txt ON s USING gin (soundex_tsvector(nm)) WITH (fastupdate = off);
INSERT INTO s (nm) VALUES
('John Doe'),
('Jane Roe'),
('Public John Q.'),
('George Best'),
('John Yamson');
SELECT * FROM s WHERE soundex_tsvector(nm) @@ soundex_tsquery('john');
SELECT * FROM s WHERE soundex_tsvector(nm) @@ soundex_tsquery('jane doe');
SELECT * FROM s WHERE soundex_tsvector(nm) @@ soundex_tsquery('john public');
SELECT * FROM s WHERE soundex_tsvector(nm) @@ soundex_tsquery('besst, giorgio');
SELECT * FROM s WHERE soundex_tsvector(nm) @@ soundex_tsquery('Jameson John');
如果希望在索引重新检查期间避免重新计算soundex代码，可以使用单独列上的索引，
而不是表达式上的索引。可以使用存储生成的列；请参阅
第 5.4 节。
F.16.3. Levenshtein #
该函数计算两个字符串之间的Levenshtein距离：
levenshtein(source text, target text, ins_cost int, del_cost int, sub_cost int) returns int
levenshtein(source text, target text) returns int
levenshtein_less_equal(source text, target text, ins_cost int, del_cost int, sub_cost int, max_d int) returns int
levenshtein_less_equal(source text, target text, max_d int) returns int
source和target都可以是任何非空字符串，
最长为 255 个字符。代价参数分别指定一个字符插入、删除或替换的开销。
你可以像这个函数的第二种版本那样忽略代价参数，那样它们都会默认为 1。
levenshtein_less_equal是 Levenshtein 函数的加速版本，
用于只对小距离感兴趣的情况。如果实际距离小于等于max_d，
那么levenshtein_less_equal返回正确的距离；否则它返回某个
大于max_d的值。如果max_d是负值，那么其行为等同于
levenshtein。
示例：
test=# SELECT levenshtein('GUMBO', 'GAMBOL');
levenshtein
-------------
2
(1 row)
test=# SELECT levenshtein('GUMBO', 'GAMBOL', 2,1,1);
levenshtein
-------------
3
(1 row)
test=# SELECT levenshtein_less_equal('extensive', 'exhaustive',2);
levenshtein_less_equal
------------------------
3
(1 row)
test=# SELECT levenshtein_less_equal('extensive', 'exhaustive',4);
levenshtein_less_equal
------------------------
4
(1 row)
F.16.4. Metaphone #
Metaphone, 和 Soundex 相似，基于为输入字符串构建代表性代码的思想。
如果两个字符串具有相同的代码，则认为它们相似。
这个函数计算一个输入字符串的变音位代码：
metaphone(source text, max_output_length int) returns text
source必须是一个非空字符串，最大长度为255个字符。max_output_length设置输出的变音位代码的最大长度，如果超长，输出会被截断到这个长度。
例子：
test=# SELECT metaphone('GUMBO', 4);
metaphone
-----------
KM
(1 row)
F.16.5. 双变音位 #
双变音位系统为一个给定输入字符串计算两个“听起来像的”字符串 — 一个“主要”和一个“次要”。在大部分情况下它们是相同的，但是对于非英语名称它们可能有一点不同，这取决于发音。这些函数计算主要和次要代码：
dmetaphone(source text) returns text
dmetaphone_alt(source text) returns text
对输入字符串没有长度限制。
示例：
test=# SELECT dmetaphone('gumbo');
dmetaphone
------------
KMP
(1 row)
上一页 上一级 下一页F.15. file_fdw — 访问服务器文件系统中的数据文件 起始页 F.17. hstore — hstore 键/值数据类型
