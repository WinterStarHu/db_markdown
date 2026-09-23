# 8.3. 字符类型

8.3. 字符类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.3. 字符类型 #表 8.4. 字符类型名字描述character varying(n), varchar(n)有限制的变长character(n), char(n), bpchar(n)固定长度，填充空格bpchar可变无限长度，去除空格text无限变长
表 8.4 显示了在PostgreSQL里可用的一般用途的字符类型。
SQL 定义了两种主要的字符类型：
character varying(n) 和
character(n)，其中 n
是一个正整数。这两种类型都可以存储长度最多为
n 个字符（不是字节）的字符串。尝试将更长的字符串存储到
这些类型的列中将会导致错误，除非多余的字符全是空格，
在这种情况下，字符串将被截断到最大长度。（这种有些奇怪的例外是
SQL 标准所要求的。）
然而，如果明确地将一个值转换为 character
varying(n) 或
character(n)，那么超长的值将会被截断为
n 个字符，而不会引发错误。（这也是
SQL 标准所要求的。）
如果要存储的字符串短于声明的长度，
类型为 character 的值将会用空格填充；
类型为 character varying 的值将仅存储较短的
字符串。
此外，PostgreSQL 提供了
text 类型，它可以存储任意长度的字符串。
尽管 text 类型不属于
SQL 标准，但其他几个 SQL 数据库
管理系统也支持它。
text 是 PostgreSQL 的原生
字符串数据类型，因为大多数对字符串操作的内置函数
都声明为接受或返回 text，而不是 character
varying。对于许多用途，character varying
表现得就像是 domain
类型上的一个 text。
类型名称 varchar 是 character varying 的别名，
而 bpchar（带长度说明符）和 char 是
character 的别名。varchar 和
char 别名在 SQL 标准中定义；
bpchar 是 PostgreSQL 的扩展。
如果指定，长度n必须大于零且不能超过
10,485,760。如果character varying（或varchar）
未指定长度，则该类型接受任意长度的字符串。如果bpchar
未指定长度，它也接受任意长度的字符串，但尾随空格在语义上无关紧要。
如果character（或char）未指定长度，
则等同于character(1)。
类型character的值物理上都用空白填充到指定的长度n， 并且以这种方式存储和显示。不过，尾随的空白被当作是没有意义的，并且在比较两个
character类型值时不会考虑它们。在空白有意义的排序规则中，这种行为可能会
产生意料之外的结果，例如SELECT 'a '::CHAR(2) collate "C" <
E'a\n'::CHAR(2)会返回真（即便C区域会认为一个空格比新行更大）。当把一个character值转换成其他
字符串类型之一时，尾随的空白会被移除。请注意，在character varying和text值里， 结尾的空白语义上是有含义的，并且在使用模式匹配（如LIKE和正则表达式）时也会被考虑。
可以存储在这些数据类型中的字符由数据库字符集确定，该数据库字符集在创建数据库时选择。无论特定的字符集是什么，都无法存储代码为零的字符（有时称为NUL）。有关更多信息，请参阅第 23.3 节。
这些类型的存储需求是 4 字节加上实际的字串，如果是 character 的话再加上填充的字节。长的字串将会自动被系统压缩， 因此在磁盘上的物理需求可能会更少些。长的数值也会存储在后台表里面，这样它们就不会干扰对短字段值的快速访问。 不管怎样，允许存储的最长字串大概是 1 GB。 （允许在数据类型声明中出现的的 n 的最大值比这还小。 修改这个行为没有甚么意义，因为在多字节编码下字符和字节的数目可能差别很大。 如果你想存储没有特定上限的长字串，那么使用 text 或者没有长度声明词的 character varying， 而不要选择一个任意长度限制。）
一个短串（最长126字节）的存储要求是1个字节外加实际的串，该串在character情况下包含填充的空白。长一些的串在前面需要4个字节而不是1个字节。长串会被系统自动压缩，这样在磁盘上的物理需求可能会更少。非常长的值也会被存储在背景表中，这样它们不会干扰对较短的列值的快速访问。在任何情况下，能被存储的最长的字符串是1GB（数据类型定义中n能允许的最大值比这个值要小。修改它没有用处，因为对于多字节字符编码来说，字符的数量和字节数可能完全不同。如果你想要存储没有指定上限的长串，使用text或没有长度声明的character varying，而不是给出一个任意长度限制）。
提示
这三种类型之间没有性能差别，只不过是在使用填充空白的类型的时候需要更多存储空间，以及在存储到一个有长度约束的列时需要少量额外CPU周期来检查长度。虽然在某些其他的数据库系统里，character(n)有一定的性能优势，但在PostgreSQL里没有。事实上，character(n)通常是这三种类型之中最慢的一个，因为它需要额外的存储开销。在大多数情况下，应该使用text或者character varying。
请参考第 4.1.2.1 节获取关于字符串文字的语法的信息，以及参阅第 9 章获取关于可用操作符和函数的信息。
例 8.1. 使用字符类型
CREATE TABLE test1 (a character(4));
INSERT INTO test1 VALUES ('ok');
SELECT a, char_length(a) FROM test1; -- (1)
a   | char_length
------+-------------
ok   |           2
CREATE TABLE test2 (b varchar(5));
INSERT INTO test2 VALUES ('ok');
INSERT INTO test2 VALUES ('good      ');
INSERT INTO test2 VALUES ('too long');
ERROR:  value too long for type character varying(5)
INSERT INTO test2 VALUES ('too long'::varchar(5)); -- explicit truncation
SELECT b, char_length(b) FROM test2;
b   | char_length
-------+-------------
ok    |           2
good  |           5
too l |           5
(1)
函数char_length在第 9.4 节中讨论。
在PostgreSQL中还有另外两种固定长度的字符类型，显示在表 8.5中。
这些类型不适用于通用用途，仅用于内部系统目录中。
name类型用于存储标识符。其长度目前定义为64字节（63个可用字符加终止符），但应在C源代码中使用常量NAMEDATALEN引用。
长度在编译时设置（因此可根据特殊用途进行调整）；默认最大长度可能在将来的版本中更改。类型"char"（注意引号）与char(1)不同，因为它只使用一个字节的存储空间，因此只能存储单个ASCII字符。它在系统目录中用作简单的枚举类型。
表 8.5. 特殊字符类型名称存储大小描述"char"1字节单字节内部类型name64字节用于对象名的内部类型上一页 上一级 下一页8.2. 货币类型 起始页 8.4. 二进制数据类型
