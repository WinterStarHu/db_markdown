# 12.8. 测试和调试文本搜索

12.8. 测试和调试文本搜索
版本：
纠错本页面
搜索
目录导航
❮
❯
12.8. 测试和调试文本搜索 #12.8.1. 配置测试12.8.2. 解析器测试12.8.3. 词典测试
一个自定义文本搜索配置的行为很容易变得混乱。本节中描述的函数对于测试文本搜索对象有用。你可以测试一个完整的配置，或者独立测试解析器和词典。
12.8.1. 配置测试 #
函数ts_debug允许简单地测试一个文本搜索配置。
ts_debug([ config regconfig, ] document text,
OUT alias text,
OUT description text,
OUT token text,
OUT dictionaries regdictionary[],
OUT dictionary regdictionary,
OUT lexemes text[])
returns setof record
ts_debug显示document的每一个记号的信息，记号由解析器产生并由配置的词典处理过。该函数使用由config指定的配置，如果该参数被忽略则使用default_text_search_config指定的配置。
ts_debug为解析器在文本中标识的每一个记号返回一行。被返回的列是：
alias text — 记号类型的短名称
description text — 记号类型的描述
token text — 记号的文本
dictionaries regdictionary[] — 配置为这种记号类型选择的词典
dictionary regdictionary — 识别该记号的词典，如果没有词典能识别则为NULL
lexemes text[] — 识别该记号的词典产生的词位，如果没有词典能识别则为NULL；一个空数组（{}）表示该记号被识别为一个停用词
这是一个简单的例子：
SELECT * FROM ts_debug('english', 'a fat  cat sat on a mat - it ate a fat rats');
alias   |   description   | token |  dictionaries  |  dictionary  | lexemes
-----------+-----------------+-------+----------------+--------------+---------
asciiword | Word, all ASCII | a     | {english_stem} | english_stem | {}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | fat   | {english_stem} | english_stem | {fat}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | cat   | {english_stem} | english_stem | {cat}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | sat   | {english_stem} | english_stem | {sat}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | on    | {english_stem} | english_stem | {}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | a     | {english_stem} | english_stem | {}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | mat   | {english_stem} | english_stem | {mat}
blank     | Space symbols   |       | {}             |              |
blank     | Space symbols   | -     | {}             |              |
asciiword | Word, all ASCII | it    | {english_stem} | english_stem | {}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | ate   | {english_stem} | english_stem | {ate}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | a     | {english_stem} | english_stem | {}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | fat   | {english_stem} | english_stem | {fat}
blank     | Space symbols   |       | {}             |              |
asciiword | Word, all ASCII | rats  | {english_stem} | english_stem | {rat}
为了一个更广泛的示范，我们先为英语语言创建一个public.english配置和 Ispell 词典：
CREATE TEXT SEARCH CONFIGURATION public.english ( COPY = pg_catalog.english );
CREATE TEXT SEARCH DICTIONARY english_ispell (
TEMPLATE = ispell,
DictFile = english,
AffFile = english,
StopWords = english
);
ALTER TEXT SEARCH CONFIGURATION public.english
ALTER MAPPING FOR asciiword WITH english_ispell, english_stem;
SELECT * FROM ts_debug('public.english', 'The Brightest supernovaes');
alias   |   description   |    token    |         dictionaries          |   dictionary   |   lexemes
-----------+-----------------+-------------+-------------------------------+----------------+-------------
asciiword | Word, all ASCII | The         | {english_ispell,english_stem} | english_ispell | {}
blank     | Space symbols   |             | {}                            |                |
asciiword | Word, all ASCII | Brightest   | {english_ispell,english_stem} | english_ispell | {bright}
blank     | Space symbols   |             | {}                            |                |
asciiword | Word, all ASCII | supernovaes | {english_ispell,english_stem} | english_stem   | {supernova}
在这个例子中，词Brightest被解析器识别为一个ASCII 词（别名asciiword）。对于这种记号类型，词典列表是english_ispell和english_stem。该词被english_ispell识别，这个词典将它缩减为名词bright。词supernovaes对于english_ispell词典是未知的，因此它被传递给下一个词典，并且幸运地是，它被识别了（实际上，english_stem是一个 Snowball 词典，它识别所有的东西；这也是为什么它被放置在词典列表的尾部）。
词The被english_ispell词典识别为一个停用词（第 12.6.1 节）并且将不会被索引。空格也被丢弃，因为该配置没有为它们提供词典。
你可以通过明确指定要查看的列来减少输出的宽度：
SELECT alias, token, dictionary, lexemes
FROM ts_debug('public.english', 'The Brightest supernovaes');
alias   |    token    |   dictionary   |   lexemes
-----------+-------------+----------------+-------------
asciiword | The         | english_ispell | {}
blank     |             |                |
asciiword | Brightest   | english_ispell | {bright}
blank     |             |                |
asciiword | supernovaes | english_stem   | {supernova}
12.8.2. 解析器测试 #
下列函数允许直接测试一个文本搜索解析器。
ts_parse(parser_name text, document text,
OUT tokid integer, OUT token text) returns setof record
ts_parse(parser_oid oid, document text,
OUT tokid integer, OUT token text) returns setof record
ts_parse解析给定的document并返回一系列记录，每一个记录对应一个由解析产生的记号。每一个记录包括一个tokid展示分配给记号的类型以及一个token展示记号的文本。例如：
SELECT * FROM ts_parse('default', '123 - a number');
tokid | token
-------+--------
22 | 123
12 |
12 | -
1 | a
12 |
1 | number
ts_token_type(parser_name text, OUT tokid integer,
OUT alias text, OUT description text) returns setof record
ts_token_type(parser_oid oid, OUT tokid integer,
OUT alias text, OUT description text) returns setof record
ts_token_type返回一个表，描述指定解析器可以识别的每种类型的标记。
对于每种标记类型，表给出解析器用于标记该类型标记的整数tokid，
在配置命令中命名标记类型的alias，以及简短的description。
例如：
SELECT * FROM ts_token_type('default');
tokid |      alias      |               description
-------+-----------------+------------------------------------------
1 | asciiword       | Word, all ASCII
2 | word            | Word, all letters
3 | numword         | Word, letters and digits
4 | email           | Email address
5 | url             | URL
6 | host            | Host
7 | sfloat          | Scientific notation
8 | version         | Version number
9 | hword_numpart   | Hyphenated word part, letters and digits
10 | hword_part      | Hyphenated word part, all letters
11 | hword_asciipart | Hyphenated word part, all ASCII
12 | blank           | Space symbols
13 | tag             | XML tag
14 | protocol        | Protocol head
15 | numhword        | Hyphenated word, letters and digits
16 | asciihword      | Hyphenated word, all ASCII
17 | hword           | Hyphenated word, all letters
18 | url_path        | URL path
19 | file            | File or path name
20 | float           | Decimal notation
21 | int             | Signed integer
22 | uint            | Unsigned integer
23 | entity          | XML entity
12.8.3. 词典测试 #
ts_lexize函数帮助进行词典测试。
ts_lexize(dict regdictionary, token text) returns text[]
如果输入的token是该词典已知的，则ts_lexize返回一个词位数组；如果该标记是词典已知的但是它是一个停用词，则返回一个空数组；或者如果它对词典是未知词，则返回NULL。
例子：
SELECT ts_lexize('english_stem', 'stars');
ts_lexize
-----------
{star}
SELECT ts_lexize('english_stem', 'a');
ts_lexize
-----------
{}
注意
ts_lexize函数期望一个单一记号而不是文本。下面的情况会让它搞混：
SELECT ts_lexize('thesaurus_astro', 'supernovae stars') is null;
?column?
---------------
t
分类词典thesaurus_astro确实知道短语supernovae stars，但是ts_lexize会失败，因为它无法解析输入文本而把它当做一个单一记号。可以使用plainto_tsquery或to_tsvector来测试分类词典，例如：
SELECT plainto_tsquery('supernovae stars');
plainto_tsquery
-------------------------
'sn'
上一页 上一级 下一页12.7. 配置示例 起始页 12.9. 文本搜索的首选索引类型
