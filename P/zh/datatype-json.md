# 8.14. JSON 类型

8.14. JSON 类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.14. JSON 类型 #8.14.1. JSON 输入和输出语法8.14.2. 设计 JSON 文档8.14.3. jsonb 包含和存在8.14.4. jsonb 索引8.14.5. jsonb 下标8.14.6. 转换8.14.7. jsonpath 类型
JSON数据类型用于存储JSON（JavaScript对象表示法）数据，如在
RFC
7159中指定的。这样的数据也可以存储为text，但
JSON数据类型具有强制执行每个
存储值符合JSON规则的优势。此外，还有各种各样的针对存储在这些数据类型中的数据
提供的特定于JSON的函数和运算符；请参见第 9.16 节。
PostgreSQL 提供存储JSON数据的两种类型：json 和 jsonb。
为了实现这些数据类型高效的查询机制， PostgreSQL还提供了jsonpath数据类型，具体描述见第 8.14.7 节。
json 和 jsonb数据类型接受几乎完全相同的值集合作为输入。
主要的实际区别之一是效率。json数据类型存储输入文本的精准拷贝，处理函数必须在每
次执行时重新解析该数据。而jsonb数据被存储在一种分解好的
二进制格式中，它在输入时要稍慢一些，因为需要做附加的转换。但是
jsonb在处理时要快很多，因为不需要重新解析。jsonb也支
持索引，这也是一个显著的优势。
由于json类型存储的是输入文本的准确拷贝，其中可能会保留在语法
上不明显的、存在于记号之间的空格，还有 JSON 对象内部的键的顺序。此外，
如果一个值中的 JSON 对象包含同一个键超过一次，所有的键/值对都会被保留（
处理函数会把最后的值当作有效值）。相反，jsonb不保留空格、不
保留对象键的顺序并且不保留重复的对象键。如果在输入中指定了重复的键，只有
最后一个值会被保留。
通常，除非有特别特殊的需要（例如遗留的对象键顺序假设），大多数应用应该
更愿意把 JSON 数据存储为jsonb。
RFC 7159 指定 JSON 字符串应以 UTF8 编码。因此 JSON 类型不可能严格遵守 JSON 规范，除非数据库编码
是 UTF8。尝试直接包括数据库编码中无法表示的字符将会失败。反过来，能
在数据库编码中表示但是不在 UTF8 中的字符是被允许的。
RFC 7159 允许 JSON 字符串包含\uXXXX
所标记的 Unicode 转义序列。在json类型的输入函数中，不管数据库
编码如何都允许 Unicode 转义，并且只检查语法正确性（即，跟在\u
后面的四个十六进制位）。但是，jsonb的输入函数更加严格：它不允许对无法在数据库
编码中表示的字符进行 Unicode 转义。jsonb类型也拒绝\u0000（因为
PostgreSQL的text类型无法表示
它），并且它坚持使用 Unicode 代理对来标记位于 Unicode 基本多语言平面之外
的字符是正确的。合法的 Unicode 转义会被转换成等价的单个字符进行存储；
这包括把代理对折叠成一个单一字符。
注意
很多第 9.16 节中描述的 JSON 处理函数将把 Unicode
转义转换成常规字符，并且将因此抛出和刚才所描述的同样类型的错误（即使它们
的输入是类型json而不是jsonb）。json的
输入函数不做这些检查是由来已久的，不过它确实允许将 JSON Unicode 转义简单
的（不经处理）存储在一个不支持所表示字符的数据库编码中。
在把文本 JSON 输入转换成jsonb时，RFC 7159描述
的基本类型会被有效地映射到原生的
PostgreSQL类型（如
表 8.23中所示）。因此，在合法
jsonb数据的组成上有一些次要额外约束，它们不适合
json类型和抽象意义上的 JSON，这些约束对应于有关哪些东西不
能被底层数据类型表示的限制。尤其是，jsonb将拒绝位于
PostgreSQL numeric数据类型范
围之外的数字，而json则不会。这类实现定义的限制是
RFC 7159 所允许的。不过，实际上这类问题更可能发生在其他实
现中，因为把 JSON 的number基本类型表示为 IEEE 754 双精度浮点
是很常见的（这也是RFC 7159 明确期待和允许的）。当在这类系
统间使用 JSON 作为一种交换格式时，应该考虑丢失数字精度的风险。
相反地，如表中所述，有一些 JSON 基本类型输入格式上的次要限制并不适用于相
应的PostgreSQL类型。
表 8.23. JSON 基本类型和相应的PostgreSQL类型JSON 基本类型PostgreSQL类型注释stringtext\u0000是不允许的，因为 Unicode 转义表示数据库编码中不可用的字符numbernumeric不允许 NaN 和 infinity 值booleanboolean只接受小写 true 和 false 拼写null(无)SQL NULL 是一个不同的概念8.14.1. JSON 输入和输出语法 #
RFC 7159 中定义了 JSON 数据类型的输入/输出语法。
下列都是合法的 json（或者 jsonb）表达式：
-- 简单标量/基本值
-- 基本值可以是数字、带引号的字符串、true、false 或者 null
SELECT '5'::json;
-- 有零个或者更多元素的数组（元素不需要为同一类型）
SELECT '[1, 2, "foo", null]'::json;
-- 包含键值对的对象
-- 注意对象键必须总是带引号的字符串
SELECT '{"bar": "baz", "balance": 7.77, "active": false}'::json;
-- 数组和对象可以被任意嵌套
SELECT '{"foo": [true, "bar"], "tags": {"a": 1, "b": null}}'::json;
如前所述，当输入一个 JSON 值并且没有进行额外处理时，json 输出与输入相同的文本，而 jsonb 不保留语义上无关紧要的细节，如空格。例如，请注意这里的差异：
SELECT '{"bar": "baz", "balance": 7.77, "active":false}'::json;
json
-------------------------------------------------
{"bar": "baz", "balance": 7.77, "active":false}
(1 row)
SELECT '{"bar": "baz", "balance": 7.77, "active":false}'::jsonb;
jsonb
--------------------------------------------------
{"bar": "baz", "active": false, "balance": 7.77}
(1 row)
一个值得注意的语义上无关紧要的细节是，在 jsonb 中，数字将根据底层的 numeric 类型的行为进行打印。实际上，这意味着使用 E 表示法输入的数字将被打印为没有该表示法，例如：
SELECT '{"reading": 1.230e-5}'::json, '{"reading": 1.230e-5}'::jsonb;
json          |          jsonb
-----------------------+-------------------------
{"reading": 1.230e-5} | {"reading": 0.00001230}
(1 row)
然而， jsonb 将保留尾部的小数零，如这个例子所示，即使对于诸如相等性检查之类的目的，这些零在语义上是无关紧要的。
对于可用于构造和处理 JSON 值的内置函数和运算符的列表，参见 第 9.16 节。
8.14.2. 设计 JSON 文档 #
将数据表示为 JSON 比传统关系数据模型要灵活得多，在需求不固定时
这种优势更加令人感兴趣。在同一个应用里非常有可能有两种方法共存
并且互补。不过，即便是在要求最大灵活性的应用中，我们还是推荐
JSON 文档有固定的结构。该结构通常是非强制的（尽管可能会强制一
些业务规则），但是有一个可预测的结构会使书写概括一个表中的
“文档”（数据）集合的查询更容易。
当被存储在表中时，JSON 数据也像其他数据类型一样服从相同的并发
控制考虑。尽管存储大型文档是可行的，但是要记住任何更新都在整行
上要求一个行级锁。为了在更新事务之间减少锁争夺，可考虑把 JSON
文档限制到一个可管理的尺寸。理想情况下，JSON 文档应该每个表示
一个原子数据，业务规则规定不会进一步把它们划分成更小的可独立修
改的数据。
8.14.3. jsonb 包含和存在 #
测试包含是jsonb的一种重要能力。对
json类型没有平行的功能集。包含测试会测试一个
jsonb文档是否包含在另一个文档中。除了特别注解
之外，这些例子都会返回真：
-- 简单的标量/基本值只包含相同的值：
SELECT '"foo"'::jsonb @> '"foo"'::jsonb;
-- 右边的数组被包含在左边的数组中：
SELECT '[1, 2, 3]'::jsonb @> '[1, 3]'::jsonb;
-- 数组元素的顺序没有意义，因此这个例子也返回真：
SELECT '[1, 2, 3]'::jsonb @> '[3, 1]'::jsonb;
-- 重复的数组元素也没有关系：
SELECT '[1, 2, 3]'::jsonb @> '[1, 2, 2]'::jsonb;
-- 右边具有一个单一键值对的对象被包含在左边的对象中：
SELECT '{"product": "PostgreSQL", "version": 9.4, "jsonb": true}'::jsonb @> '{"version": 9.4}'::jsonb;
-- 右边的数组不会被认为包含在左边的数组中，
-- 即使其中嵌入了一个相似的数组：
SELECT '[1, 2, [1, 3]]'::jsonb @> '[1, 3]'::jsonb;  -- 得到假
-- 但是如果同样也有嵌套，包含就成立：
SELECT '[1, 2, [1, 3]]'::jsonb @> '[[1, 3]]'::jsonb;
-- 类似的，这个例子也不会被认为是包含：
SELECT '{"foo": {"bar": "baz"}}'::jsonb @> '{"bar": "baz"}'::jsonb;  -- 得到假
-- 包含一个顶层键和一个空对象：
SELECT '{"foo": {"bar": "baz"}}'::jsonb @> '{"foo": {}}'::jsonb;
一般原则是被包含的对象必须在结构和数据内容上匹配包含对象，这种匹配
可以是从包含对象中丢弃了不匹配的数组元素或者对象键值对之后成立。但是
记住做包含匹配时数组元素的顺序是没有意义的，并且重复的数组元素实
际也只会考虑一次。
结构必须匹配的一般原则有一种特殊情况，一个数组可以包含一个原始值：
-- 这个数组包含基本字符串值：
SELECT '["foo", "bar"]'::jsonb @> '"bar"'::jsonb;
-- 这个例外不是互惠的 - 不包含在这里报告：
SELECT '"bar"'::jsonb @> '["bar"]'::jsonb;  -- 得到假
jsonb还有一个存在操作符，它是包含的一种
变体：它测试一个字符串（以一个text值的形式给出）是否出
现在jsonb值顶层的一个对象键或者数组元素中。除非特别注解，
下面这些例子返回真：
-- 字符串作为一个数组元素存在：
SELECT '["foo", "bar", "baz"]'::jsonb ? 'bar';
-- 字符串作为一个对象键存在：
SELECT '{"foo": "bar"}'::jsonb ? 'foo';
-- 不考虑对象值：
SELECT '{"foo": "bar"}'::jsonb ? 'bar';  -- 得到假
-- 和包含一样，存在必须在顶层匹配：
SELECT '{"foo": {"bar": "baz"}}'::jsonb ? 'bar'; -- 得到假
-- 如果一个字符串匹配一个原始 JSON 字符串，它就被认为存在：
SELECT '"foo"'::jsonb ? 'foo';
当涉及很多键或元素时，JSON 对象比数组更适合于做包含或存在测试，
因为它们不像数组，进行搜索时会进行内部优化，并且不需要被线性搜索。
提示
由于 JSON 的包含是嵌套的，因此一个恰当的查询可以跳过对子对象的显式选择。
例如，假设我们在顶层有一个doc列包含着对象，大部分对象
包含着tags域，其中有子对象的数组。这个查询会找到其中出现了
同时包含"term":"paris"和"term":"food"的子对象
的项，而忽略任何位于tags数组之外的这类键：
SELECT doc->'site_name' FROM websites
WHERE doc @> '{"tags":[{"term":"paris"}, {"term":"food"}]}';
可以用下面的查询完成同样的事情：
SELECT doc->'site_name' FROM websites
WHERE doc->'tags' @> '[{"term":"paris"}, {"term":"food"}]';
但是后一种方法灵活性较差，并且常常也效率更低。
另一方面，JSON 的存在操作符不是嵌套的：它将只在 JSON 值的顶层
查找指定的键或数组元素。
第 9.16 节中记录了多个包含和存在操作符，以及
所有其他 JSON 操作符和函数。
8.14.4. jsonb 索引 #
GIN 索引可以被用来有效地搜索在大量jsonb文档（数据）中出现
的键或者键值对。提供了两种 GIN “操作符类”，它们在性能和灵活
性方面做出了不同的平衡。
默认的jsonb GIN操作符类支持使用键存在操作符?、?|和?&、包含操作符@>，以及jsonpath匹配操作符@?和@@。
（有关这些操作符实现的语义细节，请参见表 9.48。）
使用此操作符类创建索引的示例为：
CREATE INDEX idxgin ON api USING GIN (jdoc);
非默认的GIN操作符类jsonb_path_ops不支持键存在操作符，但支持@>、@?和@@。
使用此操作符类创建索引的示例为：
CREATE INDEX idxginp ON api USING GIN (jdoc jsonb_path_ops);
考虑这样一个例子：一个表存储了从一个第三方 Web 服务检索到的 JSON
文档，并且有一个模式定义。一个典型的文档：
{
"guid": "9c36adc1-7fb5-4d5b-83b4-90356a46061a",
"name": "Angela Barton",
"is_active": true,
"company": "Magnafone",
"address": "178 Howard Place, Gulf, Washington, 702",
"registered": "2009-11-07T08:53:22 +08:00",
"latitude": 19.793713,
"longitude": 86.513373,
"tags": [
"enim",
"aliquip",
"qui"
]
}
我们把这些文档存储在一个名为api的表的名为
jdoc的jsonb列中。如果在这个列上创建一个
GIN 索引，下面这样的查询就能利用该索引：
-- 寻找键 "company" 有值 "Magnafone" 的文档
SELECT jdoc->'guid', jdoc->'name' FROM api WHERE jdoc @> '{"company": "Magnafone"}';
不过，该索引不能被用于下面这样的查询，因为尽管操作符?
是可索引的，但它不能直接被应用于被索引列jdoc：
-- 寻找这样的文档：其中的键 "tags" 包含键或数组元素 "qui"
SELECT jdoc->'guid', jdoc->'name' FROM api WHERE jdoc -> 'tags' ? 'qui';
但是，通过适当地使用表达式索引，上述查询也能使用一个索引。
如果对"tags"键中的特定项的查询很常见，可能值得
定义一个这样的索引：
CREATE INDEX idxgintags ON api USING GIN ((jdoc -> 'tags'));
现在，WHERE 子句 jdoc -> 'tags' ? 'qui'
将被识别为可索引操作符?在索引表达式jdoc -> 'tags'
上的应用（更多有关表达式索引的信息可见第 11.7 节）。
另一种查询的方法是利用包含，例如：
-- 寻找这样的文档：其中键 "tags" 包含数组元素 "qui"
SELECT jdoc->'guid', jdoc->'name' FROM api WHERE jdoc @> '{"tags": ["qui"]}';
jdoc列上的一个简单 GIN 索引就能支持这个查询。
但是注意这样一个索引将会存储jdoc列中每一个键
和值的拷贝，然而前一个例子的表达式索引只存储tags
键下找到的数据。虽然简单索引的方法更加灵活（因为它支持有关任
意键的查询），定向的表达式索引更小并且搜索速度比简单索引更快。
GIN 索引还支持 @? 和 @@ 操作符，
它们执行 jsonpath 匹配。示例如下：
SELECT jdoc->'guid', jdoc->'name' FROM api WHERE jdoc @? '$.tags[*] ? (@ == "qui")';
SELECT jdoc->'guid', jdoc->'name' FROM api WHERE jdoc @@ '$.tags[*] == "qui"';
对于这些操作符，GIN 索引会从 accessors_chain
== constant 形式的 jsonpath 模式中提取子句，
并基于这些子句中提到的键和值进行索引搜索。访问链可能包括
.key、[*] 和
[index] 访问器。
jsonb_ops 操作符类还支持 .* 和
.** 访问器，但 jsonb_path_ops 操作符类不支持。
尽管jsonb_path_ops操作符类仅支持使用@>、
@?和@@操作符的查询，但与默认操作符类
jsonb_ops相比，它具有显著的性能优势。通常，jsonb_path_ops
索引比相同数据上的jsonb_ops索引要小得多，并且搜索的特异性更好，
特别是当查询包含在数据中频繁出现的键时。因此，搜索操作通常比使用默认操作符类时性能更好。
jsonb_ops和jsonb_path_ops
GIN 索引之间的技术区别是前者为数据中的每一个键和值创建独立的索引项，
而后者仅为该数据中的每个值创建索引项。
[7]
基本上，每一个jsonb_path_ops索引项是其所对应的值和
键的哈希。例如要索引{"foo": {"bar": "baz"}}，将创建一个
单一的索引项，它把所有三个foo、bar、
和baz合并到哈希值中。因此一个查找这个结构的包含查询可能
导致极度详细的索引搜索。但是根本没有办法找到foo是否作为
一个键出现。在另一方面，一个jsonb_ops会创建三个索引
项分别表示foo、bar和baz。那么要
做同样的包含查询，它将会查找包含所有三个项的行。虽然 GIN 索引能够相当
有效地执行这种 AND 搜索，它仍然不如等效的
jsonb_path_ops搜索那样详细和快速，特别是如果有大量
行包含三个索引项中的任意一个时。
jsonb_path_ops方法的一个不足是它不会为不包含任何值
的 JSON 结构创建索引项，例如{"a": {}}。如果需要搜索包
含这样一种结构的文档，它将要求一次全索引扫描，那就非常慢。
因此jsonb_path_ops不适合经常执行这类搜索的应用。
jsonb 还支持 btree 和 hash
索引。这些通常只有在需要检查完整 JSON 文档的相等性时才有用。
对于 jsonb 数据的 btree 排序通常不太
重要，但为了完整性，其排序规则是：
Object > Array > Boolean > Number > String > null
Object with n pairs > object with n - 1 pairs
Array with n elements > array with n - 1 elements
但有一个例外（由于历史原因），即空的顶级数组排序低于 null。
具有相同数量对的对象按以下顺序比较：
key-1, value-1, key-2 ...
请注意，对象键是按照其存储顺序进行比较的；
特别是，由于较短的键存储在较长的键之前，这可能会导致一些
不直观的结果，例如：
{ "aa": 1, "c": 1} > {"b": 1, "d": 1}
同样，具有相同数量元素的数组按以下顺序比较：
element-1, element-2 ...
原始 JSON 值的比较规则与底层
PostgreSQL 数据类型的比较规则相同。
字符串使用默认的数据库排序规则进行比较。
8.14.5. jsonb 下标 #
jsonb 数据类型支持用于检索和修改元素的数组样式索引。 嵌套值可以通过链式下标表达式指定，遵循与jsonb_set函数中path参数相同的规则。如果jsonb
类型的值是一个数组，数值下标从零开始，负整数从数组的最后的元素倒数。 不支持切片表达式。下标表达式的结果始终是 jsonb 数据类型。
UPDATE 语句可以在
SET 子句中使用下标来修改 jsonb 值。下标路径必须对它存在范围内的所有受影响的值都是可遍历的。 例如，val、val['a']和val['a']['b']如果每个路径都是一个对象，  则val['a']['b']['c']路径可以一直被遍历访问到c， 如果val['a']或者val['a']['b']
中任何一个没有定义，将创建为空对象并根据需要进行填充。 但是，如果val本身或者其中任何一个中间值被定义为非对象，例如字符串、数字或者jsonb null，将无法访问并发生错误，事务将中止。
下面是下标语法的一个示例：
-- 通过键提取对象值
SELECT ('{"a": 1}'::jsonb)['a'];
-- 通过键路径提取嵌套对象值
SELECT ('{"a": {"b": {"c": 1}}}'::jsonb)['a']['b']['c'];
-- 通过索引提取数组元素
SELECT ('[1, "2", null]'::jsonb)[1];
-- 通过键更新对象值。注意'1'周围的引号：分配的值也必须是jsonb类型
UPDATE table_name SET jsonb_field['key'] = '1';
-- 如果任何记录的jsonb_field['a']['b']不是对象，则会引发错误。例如，值{"a": 1}具有键'a'的数值。
UPDATE table_name SET jsonb_field['a']['b']['c'] = '1';
-- 使用下标的WHERE子句过滤记录。由于下标的结果是jsonb，我们比较的值也必须是jsonb。双引号使"value"也成为有效的jsonb字符串。
SELECT * FROM table_name WHERE jsonb_field['key'] = '"value"';
通过下标赋值jsonb处理一些边缘情况与jsonb_set不同。当源jsonb值为NULL时，通过下标赋值将继续进行，就好像它是由下标键隐含的类型（对象或数组）的空JSON值：
-- 其中jsonb_field为NULL，现在是{"a": 1}
UPDATE table_name SET jsonb_field['a'] = '1';
-- 其中jsonb_field为NULL，现在是[1]
UPDATE table_name SET jsonb_field[0] = '1';
如果为包含太少元素的数组指定了索引，将附加NULL元素，直到达到索引并且可以设置值。
-- 其中jsonb_field为[]，现在是[null, null, 2];
-- 其中jsonb_field为[0]，现在是[0, null, 2]
UPDATE table_name SET jsonb_field[2] = '2';
只要要遍历的最后一个现有元素是对象或数组（由相应的下标隐含），jsonb值将接受对不存在的下标路径的赋值，直到可以放置分配的值为止，将创建嵌套的数组和对象结构，在前一种情况下，根据下标路径填充null。
-- 其中jsonb_field为{}，现在是{"a": [{"b": 1}]}
UPDATE table_name SET jsonb_field['a'][0]['b'] = '1';
-- 其中jsonb_field为[]，现在是[null, {"a": 1}]
UPDATE table_name SET jsonb_field[1]['a'] = '1';
8.14.6. 转换 #
有一些附加的扩展可以为不同的过程语言实现jsonb类型的转换。
PL/Perl的扩展被称作jsonb_plperl和jsonb_plperlu。如果使用它们，jsonb值会视情况被映射为Perl的数组、哈希和标量。
PL/Python的扩展名为jsonb_plpython3u。
如果您使用它，jsonb值将被映射到Python字典、列表和标量。
在这些扩展中，jsonb_plperl被认为是“trusted”，
也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
其余的需要超级用户权限才能安装。
8.14.7. jsonpath 类型 #
在PostgreSQL中，jsonpath类型实现支持SQL/JSON路径语言以有效地查询JSON数据。
它提供了已解析的SQL/JSON路径表达式的二进制表示，该表达式指定路径引擎从JSON数据中检索的项，以便使用SQL/JSON查询函数进行进一步处理。
SQL/JSON 路径谓词和运算符的语义通常遵循 SQL。同时，为了提供使用 JSON 数据的自然方法，SQL/JSON 路径语法使用一些 JavaScript 约定：
点 (.) 用于成员访问。
方括号 ([]) 用于数组访问。
与从 1 开始的常规 SQL 数组不同，SQL/JSON 数组是 0 相对的。
SQL/JSON路径表达式中的数字字面量遵循JavaScript规则，这在一些细微的细节上
与SQL和JSON不同。例如，SQL/JSON路径允许.1和
1.，而这些在JSON中是无效的。支持非十进制整数字面量和
下划线分隔符，例如，1_000_000、
0x1EEE_FFFF、0o273、
0b100101。在SQL/JSON路径中（以及在JavaScript中，但不在
正规SQL中），基数前缀后面不能直接有下划线分隔符。
SQL/JSON路径表达式通常在SQL查询中以SQL字符串文字的形式编写，因此必须用单引号括起，
并且值中所需的任何单引号必须加倍（参见第 4.1.2.1 节）。
某些形式的路径表达式需要其中的字符串文字。
这些嵌入式字符串文字遵循JavaScript/ECMAScript约定：
它们必须用双引号括起，并且可以在其中使用反斜杠转义来表示其他难以输入的字符。
特别是，在嵌入式字符串文字中写入双引号的方法是\"，
而要写入反斜杠本身，必须写为\\。其他特殊的反斜杠序列
包括JavaScript字符串中识别的那些：
\b、
\f、
\n、
\r、
\t、
\v
用于各种ASCII控制字符，
\xNN表示用仅两个十六进制数字编写的字符代码，
\uNNNN表示由其4个十六进制代码点标识的Unicode字符，
以及\u{N...}表示用1至6个十六进制数字编写的Unicode字符代码点。
路径表达式由一系列路径元素组成，可以是以下任何一种：
JSON基本类型的路径文字：Unicode文本、数字、真、假或空。
表 8.24中列出的路径变量。
表 8.25中列出的访问器运算符。
第 9.16.2.3 节中列出的jsonpath 运算符和方法。
括号，可用于提供筛选器表达式或定义路径计算的顺序。
有关使用jsonpath表达式与 SQL/JSON 查询函数的详细信息，参见第 9.16.2 节。
表 8.24. jsonpath 变量变量描述$表示被查询的 JSON 值的变量（context item）。
$varname
命名变量。其值可以由多个 JSON 处理函数的参数
vars 设置；详细信息请参见 表 9.51。
@表示筛选表达式中路径计算结果的变量。
表 8.25. jsonpath 访问器访问器运算符描述
.key
."$varname"
返回具有指定键的对象成员的成员访问器。
如果键名称是以 $ 开头的命名变量，或者不符合标识符的 JavaScript 规则，则必须将其括在双引号中以使其成为字符串文字。
.*
通配符成员访问器，该访问器返回位于当前对象顶层的所有成员的值。
.**
递归通配符成员访问器，它处理当前对象JSON层次结构的所有级别，并返回所有成员值，而不管它们的嵌套级别如何。
这是 PostgreSQL SQL/JSON 标准的扩展。
.**{level}
.**{start_level to
end_level}
与 .** 类似，但仅选择 JSON 层次结构的指定级别。嵌套级别指定为整数。
零级别对应于当前对象。要访问最低嵌套级别，可以使用last关键字。
这是 PostgreSQL SQL/JSON 标准的扩展。
[subscript, ...]
数组元素访问器。
subscript 能够以两种形式给出: index 或 start_index 到 end_index。
第一个形式按其索引返回单个数组元素。第二个形式按索引范围返回数组切片，包括对应于提供的
start_index 和 end_index 的元素。
指定的index可以是整数，也可以是返回单个数值的表达式，该数值将自动转换为整数。
零索引对应于第一个数组元素。你还可以使用last 关键字来表示最后一个数组元素，这对于处理未知长度的数组很有用。
[*]
通配符数组元素访问器，返回所有数组元素。
[7]
对于这种目的，术语“值”包括数组元素，尽管 JSON 的术语有时
认为数组元素与对象内的值不同。
上一页 上一级 下一页8.13. XML 类型 起始页 8.15. 数组
