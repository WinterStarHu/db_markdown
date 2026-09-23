# F.9. citext — 一种不区分大小写的字符字符串类型

F.9. citext — 一种不区分大小写的字符字符串类型
版本：
纠错本页面
搜索
目录导航
❮
❯
F.9. citext — 一种不区分大小写的字符字符串类型 #F.9.1. 基本原理F.9.2. 如何使用它F.9.3. 字符串比较行为F.9.4. 限制F.9.5. 作者
citext模块提供了一种不区分大小写的字符字符串类型：citext。本质上，它在比较值时内部调用lower。除此之外，它的行为几乎与text完全相同。
提示
可考虑使用nondeterministic collations (参见
第 23.2.2.4 节)来代替这个模块。它们可用于不区分大小写的比较、不区分重音的比较，以及其他组合，并且它们可以正确处理更多Unicode特殊情况。
此模块被视为“可信(trusted)”，也就是说，它可以由当前数据库上具有CREATE权限的非超级用户来安装。
F.9.1. 基本原理 #
在PostgreSQL中进行不区分大小写的匹配的标准方法是，在比较值时使用lower函数，例如：
SELECT * FROM tab WHERE lower(col) = LOWER(?);
这工作得比较好，但有一些缺点：
它让你的 SQL 语句冗长，并且你必须总是要记住在列和查询值上使用lower。
它不会使用一个索引，除非你使用lower创建一个函数索引。
如果你声明一个列为UNIQUE或PRIMARY KEY，隐式生成的索引是大小写敏感的。因此，它对于大小写不敏感的搜索是没有用处的，并且它不会强制大小写不敏感的唯一性。
citext数据类型允许你在 SQL 查询中消除对lower的调用，并且允许一个主键是大小写无关的。就和text一样，citext是区域相关的，这意味着大写和小写字符的匹配依赖于数据库LC_CTYPE设置的规则。此外，这种行为和在查询中使用lower是一样的。但是因为它是由数据类型以透明的方式完成的，你不需要记住在你的查询中做任何特殊的事情。
F.9.2. 如何使用它 #
这里是一个简单的用法示例：
CREATE TABLE users (
nick CITEXT PRIMARY KEY,
pass TEXT   NOT NULL
);
INSERT INTO users VALUES ( 'larry',  sha256(random()::text::bytea) );
INSERT INTO users VALUES ( 'Tom',    sha256(random()::text::bytea) );
INSERT INTO users VALUES ( 'Damian', sha256(random()::text::bytea) );
INSERT INTO users VALUES ( 'NEAL',   sha256(random()::text::bytea) );
INSERT INTO users VALUES ( 'Bjørn',  sha256(random()::text::bytea) );
SELECT * FROM users WHERE nick = 'Larry';
即使nick列被设置为larry而查询是Larry，SELECT语句也将只返回一个元组。
F.9.3. 字符串比较行为 #
citext执行比较时先将每一个串转换成小写形式（调用lower）然后正常地比较结果。因此，如果两个串通过lower产生相同的结果，它们就被认为是相等。
为了尽可能接近地模拟一种大小写不敏感的排序规则，一些字符串处理操作符和函数有citext相关的版本。例如，当应用到citext时，正则表达式操作符~和~*会展现出相同的行为：它们都以大小写不敏感的方式匹配。!~和!~*也是一样，以及LIKE操作符~~和~~*，以及!~~和!~~*。如果你想以大小写敏感的方式匹配，你可以把该操作符的参数转换成text。
相似地，如果下列函数的参数是citext，它们会以大小写不敏感的方式执行匹配：
regexp_match()
regexp_matches()
regexp_replace()
regexp_split_to_array()
regexp_split_to_table()
replace()
split_part()
strpos()
translate()
对于 regexp 函数，如果你想要以大小写敏感的方式匹配，你可以指定“c”标志来强制大小写敏感的匹配。否则，如果你想要大小写敏感的行为，你必须在使用这些函数之一之前转换到text。
F.9.4. 限制 #
citext的大小写折叠行为取决于你的数据库的LC_CTYPE设置。因此它如何比较值是在数据库被创建时决定的。在 Unicode 标准定义的术语中没有真正的大小写不敏感。实际上，它的含义是，只要你对你的排序规则满意，你就应该对citext的比较满意。但是如果在你的数据库中存储有不同语言的数据，当排序规则是用于一种语言时，另一种语言的用户可能会发现他们的查询结果并不是所期待的。
自PostgreSQL 9.1 起，你可以为citext列或数据值附加一个COLLATE说明。当前，在比较大小写折叠过的字符串时，citext操作符将尊重一种非默认的COLLATE说明，但是最初到小写形式的折叠是根据数据库的LC_CTYPE设置完成的（就是说，尽管给出了COLLATE "default"）。这可能在未来的发行中被改变，这样两步都能遵循输入的COLLATE说明。
citext的效率不如text，因为操作符函数和 B 树比较函数必须创建数据的拷贝并且将它转换为小写形式来进行比较。
此外，只有text可以支持B树重复数据删除。不过，在进行大小写不敏感的匹配时，citext比使用lower的效率要略高。
如果你在某些环境下需要以大小写敏感的方式比较数据并且在另一些环境下需要以大小写不敏感的方式比较数据，citext就帮不上什么忙。标准的答案是使用text类型并且在你需要以大小写不敏感的方式比较时手动使用lower函数。如果大小写不敏感的比较需求不频繁，这会工作得不错。如果你大部分时间需要大小写不敏感的行为，考虑将数据存储为citext并且在进行大小写敏感比较时显式地将列转换为text。不管在那种情况下，你都需要两个索引来让两种类型的搜索更快。
包含citext操作符的模式必须在当前的search_path（通常是public）中；如果它不在，普通的大小写敏感的text操作符将会取而代之。
比较小写字符串的方法不能正确处理一些Unicode特殊情况，例如当一个大写字母有两个小写字母等价时。
因此Unicode区分了case mapping和case folding。
用非确定性排序代替citext以便正确处理。
F.9.5. 作者 #
David E. Wheeler <david@kineticode.com>
受Donald Fraser的citext模块启发。
上一页 上一级 下一页F.8. btree_gist — 具有B树行为的GiST操作符类 起始页 F.10. cube — 一种多维立方体数据类型
