# 8.11. 文本搜索类型

8.11. 文本搜索类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.11. 文本搜索类型 #8.11.1. tsvector8.11.2. tsquery
PostgreSQL提供两种数据类型，它们被设计用来支持全文搜索，全文搜索是一种在自然语言的文档集合中搜索以定位那些最匹配一个查询的文档的活动。tsvector类型表示一个为文本搜索优化的形式下的文档，tsquery类型表示一个文本查询。第 12 章提供了对于这种功能的详细解释，并且第 9.13 节总结了相关的函数和操作符。
8.11.1. tsvector #
一个tsvector值是一个排序的不同词元的列表，这些词元是已经标准化的单词，用于合并同一个单词的不同变体（详见第 12 章）。在输入时会自动进行排序和去重，如下所示：
SELECT 'a fat cat sat on a mat and ate a fat rat'::tsvector;
tsvector
----------------------------------------------------
'a' 'and' 'ate' 'cat' 'fat' 'mat' 'on' 'rat' 'sat'
为了表示包含空格或标点符号的词元，请用引号括起来：
SELECT $$the lexeme '    ' contains spaces$$::tsvector;
tsvector
-------------------------------------------
'    ' 'contains' 'lexeme' 'spaces' 'the'
（在这个例子和下一个例子中，我们使用了dollar-quoted字符串字面值，以避免在字面值内部需要双引号。）嵌入的引号和反斜杠必须加倍：
SELECT $$the lexeme 'Joe''s' contains a quote$$::tsvector;
tsvector
------------------------------------------------
'Joe''s' 'a' 'contains' 'lexeme' 'quote' 'the'
可选地，可以将整数位置附加到词元上：
SELECT 'a:1 fat:2 cat:3 sat:4 on:5 a:6 mat:7 and:8 ate:9 a:10 fat:11 rat:12'::tsvector;
tsvector
-------------------------------------------------------------------​------------
'a':1,6,10 'and':8 'ate':9 'cat':3 'fat':2,11 'mat':7 'on':5 'rat':12 'sat':4
位置通常表示文档中源单词的位置。位置信息可用于接近排名。位置值可以从1到16383范围；较大的数字会被自动设置为16383。相同词元的重复位置会被丢弃。
具有位置的词元可以进一步用权重标记，可以是A，
B，C或D。
D是默认值，因此不会显示在输出中：
SELECT 'a:1A fat:2B,4C cat:5D'::tsvector;
tsvector
----------------------------
'a':1A 'cat':5 'fat':2B,4C
权重通常用于反映文档结构，例如通过将标题词与正文词标记不同。文本搜索
排名函数可以为不同的权重标记分配不同的优先级。
重要的是要理解tsvector类型本身不执行任何单词规范化；它假定给定的单词已经适当地规范化了应用程序。
例如，
SELECT 'The Fat Rats'::tsvector;
tsvector
--------------------
'Fat' 'Rats' 'The'
对于大多数英文文本搜索应用程序来说，上述单词被认为是非规范化的，但tsvector并不在乎。
原始文档文本通常应通过to_tsvector进行传递，以便适当地规范化单词以供搜索：
SELECT to_tsvector('english', 'The Fat Rats');
to_tsvector
-----------------
'fat':2 'rat':3
再次，详细信息请参见第 12 章。
8.11.2. tsquery #
一个tsquery值存储要用于搜索的词位，并且使用布尔操作符&（AND）、|（OR）和!（NOT）来组合它们，还有短语搜索操作符<->（FOLLOWED BY）。也有一种 FOLLOWED BY 操作符的变体<N>，其中N是一个整数常量，它指定要搜索的两个词位之间的距离。<->等效于<1>。
圆括号可以被用来强制对操作符分组。如果没有圆括号，!（NOT）的优先级最高，其次是<->（FOLLOWED BY），然后是&（AND），最后是|（OR）。
这里是一些示例:
SELECT 'fat & rat'::tsquery;
tsquery
---------------
'fat' & 'rat'
SELECT 'fat & (rat | cat)'::tsquery;
tsquery
---------------------------
'fat' & ( 'rat' | 'cat' )
SELECT 'fat & rat & ! cat'::tsquery;
tsquery
------------------------
'fat' & 'rat' & !'cat'
可选地，一个tsquery中的词位可以被标注一个或多个权重字母，这将限制它们只能和具有那些权重之一的tsvector词位相匹配：
SELECT 'fat:ab & cat'::tsquery;
tsquery
------------------
'fat':AB & 'cat'
另外，在tsquery中的词元可以用*标记以指定前缀匹配：
SELECT 'super:*'::tsquery;
tsquery
-----------
'super':*
这个查询将匹配tsvector中以“super”开头的任何单词。
对于词元的引用规则与之前描述的tsvector中的词元相同；并且，与tsvector一样，
在转换为tsquery类型之前，必须对单词进行任何必需的规范化。函数to_tsquery
用于执行这种规范化：
SELECT to_tsquery('Fat:ab & Cats');
to_tsquery
------------------
'fat':AB & 'cat'
请注意，to_tsquery将以与其他单词相同的方式处理前缀，这意味着此比较返回true：
SELECT to_tsvector( 'postgraduate' ) @@ to_tsquery( 'postgres:*' );
?column?
----------
t
因为postgres被词干化为postgr：
SELECT to_tsvector( 'postgraduate' ), to_tsquery( 'postgres:*' );
to_tsvector  | to_tsquery
---------------+------------
'postgradu':1 | 'postgr':*
这将匹配postgraduate的词干形式。
上一页 上一级 下一页8.10. 位串类型 起始页 8.12. UUID 类型
