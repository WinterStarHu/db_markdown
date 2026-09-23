# CREATE DOMAIN

CREATE DOMAIN
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE DOMAINCREATE DOMAIN — 定义一个新的域大纲
CREATE DOMAIN name [ AS ] data_type
[ COLLATE collation ]
[ DEFAULT expression ]
[ domain_constraint [ ... ] ]
其中 domain_constraint 是：
[ CONSTRAINT constraint_name ]
{ NOT NULL | NULL | CHECK (expression) }
描述
CREATE DOMAIN创建一个新的域。域
本质上是一种带有可选约束（在允许的值集合上的限制）的数据类型。
定义一个域的用户将成为它的拥有者。
如果给定一个模式名（例如CREATE DOMAIN
myschema.mydomain ...），那么域将被创建在该指定的模式中。
否则它会被创建在当前模式中。域的名称在其模式中的类型和域之间
必须保持唯一。
域主要被用于把字段上的常用约束抽象到一个单一的位置以便维护。例如，
几个表可能都包含电子邮件地址列，而且都要求相同的 CHECK 约束来验证
地址的语法。可以为此定义一个域，而不是在每个表上都单独设置一个约束。
要创建一个域，你必须在其底层类型上拥有USAGE特权。
参数name
要被创建的域的名称（可以被模式限定）。
data_type
域的底层数据类型。可以包括数组指示符。
collation
域的可选排序。如果未指定排序，则该域具有与其底层数据类型相同的排序行为。
如果指定了COLLATE，则底层类型必须是可排序的。
DEFAULT expression
DEFAULT子句为该域数据类型的列指定一个默认值。
该值是任何没有变量的表达式（但不允许子查询）。默认值表达式
的数据类型必须匹配域的数据类型。如果没有指定默认值，那么
默认值就是空值。
默认值表达式将被用在任何没有指定列值的插入操作中。如果为一个
特定列定义了默认值，它会覆盖与域相关的默认值。继而，域默认值
会覆盖任何与底层数据类型相关的默认值。
CONSTRAINT constraint_name
一个约束的名称（可选）。如果没有指定，系统会生成一个名称。
NOT NULL
这个域的值通常不能为空（但是看看下面的注释）。
NULL
这个域的值允许为空。这是默认值。
这个子句只是为了与非标准 SQL 数据库相兼容而设计。在新的
应用中不鼓励使用它。
CHECK (expression)CHECK子句指定该域的值必须满足的完整性
约束或测试。每个约束必须是一个产生布尔结果的表达式。
它应该使用关键词VALUE来引用要被测试的值。计算为
TRUE 或 UNKNOWN 的表达式成功。如果该表达式产生一个 FALSE
结果，会报告一个错误并且该值不允许被转换成该域类型。
当前，CHECK表达式不能包含子查询，也不能
引用除VALUE之外的其他变量。
当一个域有多个CHECK约束，将按照其名字的
字母顺序测试它们（版本 9.5 之前的PostgreSQL
不遵循任何用于CHECK约束的特定触发顺序）。
备注
在把一个值转换成域类型时会检查域约束（特别是NOT NULL）。
即使有一个这样的约束，有可能一个名义上属于该域类型的列也会被读成空值。
例如，如果在一次外连接查询中，属于该域的列出现在外连接的空值端。下面
是一个更精细的例子：
INSERT INTO tab (domcol) VALUES ((SELECT domcol FROM tab WHERE false));
空的标量子-SELECT 将产生一个空值，它被认为是该域类型的值，因此不会
在其上应用任何进一步的约束检查，并且插入将会成功。
要避免这类问题很难，因为 SQL 的一般假设是空值也是每种数据类型的合法值。
因此，最好的方法是设计一个允许空值的域约束，然后根据需要在该域类型的列上
应用列的NOT NULL约束。
PostgreSQL假定CHECK约束的条件是不可变的，也就是说，对于相同的输入值它们总会给出相同的结果。
仅在首次将值转换为域类型时，此假设检查CHECK约束的正确性，而不是在其他时候。
（这与处理表CHECK约束基本上相同，如 第 5.5.1 节中所述。）
一个常见的打破这种假设的例子是在CHECK表达式中引用一个用户定义的函数，然后更改该函数的行为。
PostgreSQL不会禁止这样做，但它不会注意到域类型的存储值是否违反了CHECK约束。
这将导致后续的数据库转储和恢复失败。处理这种更改的推荐方法是删除约束（使用ALTER DOMAIN），
调整函数定义，然后重新添加约束，从而重新检查存储的数据。
确保域CHECK表达式不会抛出错误也是一种良好的实践。
示例
这个例子创建us_postal_code数据类型并且把它用在
一个表定义中。一个正则表达式测试被用来验证值是否看起来像一个
合法的 US 邮政编码：
CREATE DOMAIN us_postal_code AS TEXT
CHECK(
VALUE ~ '^\d{5}$'
OR VALUE ~ '^\d{5}-\d{4}$'
);
CREATE TABLE us_snail_addy (
address_id SERIAL PRIMARY KEY,
street1 TEXT NOT NULL,
street2 TEXT,
street3 TEXT,
city TEXT NOT NULL,
postal us_postal_code NOT NULL
);
兼容性
命令CREATE DOMAIN符合 SQL 标准。
该命令中的语法 NOT NULL 是
PostgreSQL 的扩展。（对于非复合数据类型，
标准的写法是 CHECK (VALUE IS NOT
NULL)。然而，根据 “备注”一节，
实际上最好避免使用此类约束。）NULL
“约束”是 PostgreSQL 的扩展
（另见 Compatibility）。
另请参阅ALTER DOMAIN, DROP DOMAIN上一页 上一级 下一页CREATE DATABASE 起始页 CREATE EVENT TRIGGER
