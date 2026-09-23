# 5.5. 约束

5.5. 约束
版本：
纠错本页面
搜索
目录导航
❮
❯
5.5. 约束 #5.5.1. 检查约束5.5.2. 非空约束5.5.3. 唯一约束5.5.4. 主键5.5.5. 外键5.5.6. 排他约束
数据类型是一种限制能够存储在表中数据类别的方法。但是对于很多应用来说，它们提供的约束太粗糙。例如，一个包含产品价格的列应该只接受正值。但是没有任何一种标准数据类型只接受正值。另一个问题是我们可能需要根据其他列或行来约束一个列中的数据。例如，在一个包含产品信息的表中，对于每个产品编号应该只有一行。
为此，SQL允许我们在列和表上定义约束。约束让我们能够根据我们的愿望来控制表中的数据。如果一个用户试图在一个列中保存违反一个约束的数据，一个错误会被抛出。即便是这个值来自于默认值定义，这个规则也同样适用。
5.5.1. 检查约束 #
一个检查约束是最通用的约束类型。它允许我们指定一个特定列中的值必须满足一个布尔表达式。例如，为了要求正值的产品价格，我们可以使用：
CREATE TABLE products (
product_no integer,
name text,
price numeric CHECK (price > 0)
);
如你所见，约束定义就和默认值定义一样跟在数据类型之后。默认值和约束之间的顺序没有影响。一个检查约束由关键字CHECK和圆括号中的表达式组成。检查约束表达式应该涉及到被约束的列，否则该约束也没什么实际意义。
我们也可以给约束一个独立的名称。这会使得错误消息更为清晰，同时也允许我们在需要更改约束时能引用它。语法为：
CREATE TABLE products (
product_no integer,
name text,
price numeric CONSTRAINT positive_price CHECK (price > 0)
);
要指定一个命名的约束，请在约束名称前使用关键字CONSTRAINT，然后把约束定义放在标识符之后（如果没有以这种方式指定一个约束名称，系统将会为我们选择一个）。
一个检查约束也可以引用多个列。例如我们存储一个普通价格和一个打折后的价格，而我们希望保证打折后的价格低于普通价格：
CREATE TABLE products (
product_no integer,
name text,
price numeric CHECK (price > 0),
discounted_price numeric CHECK (discounted_price > 0),
CHECK (price > discounted_price)
);
前两个约束看起来很相似。第三个则使用了一种新语法。它并没有依附在一个特定的列，而是作为一个独立的项出现在逗号分隔的列列表中。列定义和这种约束定义可以以混合的顺序出现在列表中。
我们将前两个约束称为列约束，而第三个约束为表约束，因为它独立于任何一个列定义。列约束也可以写成表约束，但反过来不行，因为一个列约束只能引用它所依附的那一个列（PostgreSQL并不强制要求这个规则，但是如果我们希望表定义能够在其他数据库系统中工作，那就应该遵循它）。上述例子也可以写成：
CREATE TABLE products (
product_no integer,
name text,
price numeric,
CHECK (price > 0),
discounted_price numeric,
CHECK (discounted_price > 0),
CHECK (price > discounted_price)
);
甚至是：
CREATE TABLE products (
product_no integer,
name text,
price numeric CHECK (price > 0),
discounted_price numeric,
CHECK (discounted_price > 0 AND price > discounted_price)
);
这只是个人喜好的问题。
表约束也可以用列约束相同的方法来指定名称：
CREATE TABLE products (
product_no integer,
name text,
price numeric,
CHECK (price > 0),
discounted_price numeric,
CHECK (discounted_price > 0),
CONSTRAINT valid_discount CHECK (price > discounted_price)
);
需要注意的是，一个检查约束在其检查表达式值为真或空值时被满足。因为当任何操作数为空时大部分表达式将计算为空值，所以它们不会阻止被约束列中的空值。为了保证一列不包含空值，可以使用下一节中的非空约束。
注意
PostgreSQL不支持引用除了正在检查的新行或更新行之外的表数据的CHECK约束。
虽然违反此规则的CHECK约束在简单测试中可能有效，但无法保证数据库不会达到约束条件为假的状态
（由于其他行的后续更改）。这将导致数据库转储和恢复失败。即使完整的数据库状态与约束一致，恢复也可能失败，
因为行未按满足约束的顺序加载。如果可能的话，使用UNIQUE、EXCLUDE或
FOREIGN KEY约束来表示跨行和跨表的限制。
如果您想要的是在插入行时对其他行进行一次性检查，而不是持续维护一致性保证，
可以使用自定义触发器来实现。 （这种方法避免了
转储/恢复问题，因为pg_dump在恢复数据之后才重新安装触发器，
因此在转储/恢复期间不会强制执行检查。）
注意
PostgreSQL假定CHECK约束的条件是不可变的，也就是说，它们始终为同一输入行提供相同的结果。
这个假设是仅在插入或更新行时，而不是在其他时间检查CHECK约束的原因。
（上面关于不引用其他表数据的警告实际上是此限制的特殊情况。）
一个常见的打破这种假设的例子是在CHECK表达式中引用一个用户定义的函数，
然后改变该函数的行为。PostgreSQL不会禁止这样做，
但它不会注意到表中是否有行现在违反了CHECK约束。
这将导致后续的数据库转储和恢复操作失败。
处理这种变化的推荐方法是删除约束（使用ALTER TABLE），
调整函数定义，然后重新添加约束，从而重新检查所有表行。
5.5.2. 非空约束 #
非空约束仅指定列不得假定 NULL 值。 语法示例：
CREATE TABLE products (
product_no integer NOT NULL,
name text NOT NULL,
price numeric
);
还可以指定显式约束名称，例如：
CREATE TABLE products (
product_no integer NOT NULL,
name text CONSTRAINT products_name_not_null NOT NULL,
price numeric
);
非空约束通常作为列约束编写。 将其作为表约束编写的语法是
CREATE TABLE products (
product_no integer,
name text,
price numeric,
NOT NULL product_no,
NOT NULL name
);
但这种语法不是标准的，主要用于 pg_dump。
非空约束在功能上等同于创建检查约束 CHECK (column_name
IS NOT NULL)，但在 PostgreSQL 中，创建显式的非空约束更高效。
当然，一个列可以有多个约束，只需要将这些约束一个接一个写出：
CREATE TABLE products (
product_no integer NOT NULL,
name text NOT NULL,
price numeric NOT NULL CHECK (price > 0)
);
约束的顺序没有关系，因为并不需要决定约束被检查的顺序。
但是，一个列最多只能有一个显式的非空约束。
NOT NULL约束有一个相反的情况：NULL约束。这并不意味着该列必须为空，进而肯定是无用的。相反，它仅仅选择了列可能为空的默认行为。SQL标准中并不存在NULL约束，因此它不能被用于可移植的应用中（PostgreSQL中加入它是为了和某些其他数据库系统兼容）。但是某些用户喜欢它，因为它使得在一个脚本文件中可以很容易地进行约束切换。例如，初始时我们可以：
CREATE TABLE products (
product_no integer NULL,
name text NULL,
price numeric NULL
);
然后可以在需要的地方插入NOT关键词。
提示
在大部分数据库设计中，绝大多数列应该被标记为非空。
5.5.3. 唯一约束 #
唯一约束保证在一列中或者一组列中保存的数据在表中所有行间是唯一的。写成一个列约束的语法是：
CREATE TABLE products (
product_no integer UNIQUE,
name text,
price numeric
);
写成一个表约束的语法是：
CREATE TABLE products (
product_no integer,
name text,
price numeric,
UNIQUE (product_no)
);
当写入表约束时。
要为一组列定义一个唯一约束，把它写作一个表级约束，列名用逗号分隔：
CREATE TABLE example (
a integer,
b integer,
c integer,
UNIQUE (a, c)
);
这指定这些列的组合值在整个表的范围内是唯一的，但其中任意一列的值并不需要是（一般也不是）唯一的。
你可以通常的方式为一个唯一约束命名：
CREATE TABLE products (
product_no integer CONSTRAINT must_be_different UNIQUE,
name text,
price numeric
);
增加一个唯一约束会在约束中列出的列或列组上自动创建一个唯一B-tree索引。只覆盖某些行的唯一性限制不能被写为一个唯一约束，但可以通过创建一个唯一的部分索引来强制这种限制。
通常情况下，如果表中有多行，其中包含约束中包含的所有列的值相等，则违反了唯一约束。
默认情况下，在此比较中，两个空值不被视为相等。这意味着即使存在唯一约束，也可以存储包含至少一个受约束列中的空值的重复行。
可以通过添加子句NULLS NOT DISTINCT来更改此行为，例如
CREATE TABLE products (
product_no integer UNIQUE NULLS NOT DISTINCT,
name text,
price numeric
);
或者
CREATE TABLE products (
product_no integer,
name text,
price numeric,
UNIQUE NULLS NOT DISTINCT (product_no)
);
可以使用NULLS DISTINCT明确指定默认行为。唯一约束中的默认空值处理是根据SQL标准的实现定义的，其他实现具有不同的行为。因此，在开发旨在可移植的应用程序时要小心。
5.5.4. 主键 #
一个主键约束表示可以用作表中行的唯一标识符的一个列或者一组列。这要求那些值都是唯一的并且非空。因此，下面的两个表定义接受相同的数据：
CREATE TABLE products (
product_no integer UNIQUE NOT NULL,
name text,
price numeric
);
CREATE TABLE products (
product_no integer PRIMARY KEY,
name text,
price numeric
);
主键可以跨越多个列，其语法和唯一约束相似：
CREATE TABLE example (
a integer,
b integer,
c integer,
PRIMARY KEY (a, c)
);
增加一个主键将自动在主键中列出的列或列组上创建一个唯一B-tree索引，并且会强制这些列被标记为NOT NULL。
一个表最多只能有一个主键。 （可以有任意数量的唯一约束，结合非空约束在功能上几乎是相同的，但只能有一个可以被识别为主键。） 关系数据库理论规定每个表必须有一个主键。 这个规则在 PostgreSQL 中并不强制执行，但通常最好遵循它。
主键对于文档和客户端应用都是有用的。例如，一个允许修改行值的 GUI 应用可能需要知道一个表的主键，以便就可以唯一地标识行。如果定义了主键，数据库系统也有多种方法来利用主键。例如，主键定义了外键要引用的默认目标列。
5.5.5. 外键 #
一个外键约束指定一列（或一组列）中的值必须匹配出现在另一个表中某些行的值。我们说这维持了两个关联表之间的引用完整性。
例如我们有一个使用过多次的产品表：
CREATE TABLE products (
product_no integer PRIMARY KEY,
name text,
price numeric
);
让我们假设我们还有一个存储这些产品订单的表。我们希望保证订单表中只包含真正存在的产品的订单。因此我们在订单表中定义一个引用产品表的外键约束：
CREATE TABLE orders (
order_id integer PRIMARY KEY,
product_no integer REFERENCES products (product_no),
quantity integer
);
现在就不可能创建包含不存在于产品表中的product_no值（非空）的订单。
我们说在这种情况下，订单表是引用表而产品表是被引用表。相应地，也有引用和被引用列的说法。
我们也可以把上述命令简写为：
CREATE TABLE orders (
order_id integer PRIMARY KEY,
product_no integer REFERENCES products,
quantity integer
);
因为如果缺少列的列表，则被引用表的主键将被用作被引用列。
你可以按常规方式为外键约束指定自己的名称。
一个外键也可以约束和引用一组列。照例，它需要被写成表约束的形式。下面是一个例子：
CREATE TABLE t1 (
a integer PRIMARY KEY,
b integer,
c integer,
FOREIGN KEY (b, c) REFERENCES other_table (c1, c2)
);
当然，被约束列的数量和类型应该匹配被引用列的数量和类型。
有时，外键约束的“其他表”是同一个表也是有用的；这称为自引用 外键。例如，如果希望表中的行表示树结构的节点，可以编写
CREATE TABLE tree (
node_id integer PRIMARY KEY,
parent_id integer REFERENCES tree,
name text,
...
);
顶级节点的parent_id可以为NULL，而非NULL的parent_id条目将被约束为引用表中的有效行。
一个表可以有超过一个的外键约束。这被用于实现表之间的多对多关系。例如我们有关于产品和订单的表，但我们现在希望一个订单能包含多种产品（这在上面的结构中是不允许的）。我们可以使用这种表结构：
CREATE TABLE products (
product_no integer PRIMARY KEY,
name text,
price numeric
);
CREATE TABLE orders (
order_id integer PRIMARY KEY,
shipping_address text,
...
);
CREATE TABLE order_items (
product_no integer REFERENCES products,
order_id integer REFERENCES orders,
quantity integer,
PRIMARY KEY (product_no, order_id)
);
注意在最后一个表中主键和外键之间有重叠。
我们知道外键不允许创建与任何产品都不相关的订单。但如果一个产品在一个引用它的订单创建之后被移除会发生什么？SQL允许我们处理这种情况。直观上，我们有几种选项：
不允许删除一个被引用的产品同时也删除引用产品的订单其他？
为了说明这些，让我们在上面的多对多关系例子中实现下面的策略：当某人希望移除一个仍然被一个订单引用（通过order_items）的产品时，我们阻止它。如果某人移除一个订单，订单项也同时被移除：
CREATE TABLE products (
product_no integer PRIMARY KEY,
name text,
price numeric
);
CREATE TABLE orders (
order_id integer PRIMARY KEY,
shipping_address text,
...
);
CREATE TABLE order_items (
product_no integer REFERENCES products ON DELETE RESTRICT,
order_id integer REFERENCES orders ON DELETE CASCADE,
quantity integer,
PRIMARY KEY (product_no, order_id)
);
默认的 ON DELETE 操作是 ON DELETE NO ACTION；这不需要指定。这意味着允许在被引用的表中进行删除。但是，外键约束仍然需要满足，因此此操作通常会导致错误。但是，外键约束的检查也可以推迟到事务的后期（本章未涵盖）。在这种情况下，NO ACTION 设置将允许其他命令在检查约束之前 “修复” 情况，例如通过向被引用的表中插入另一行合适的行或通过从引用表中删除现在悬空的行。
RESTRICT 是比 NO ACTION 更严格的设置。它防止删除被引用的行。
RESTRICT 不允许将检查推迟到事务的后期。
CASCADE 指定当被引用的行被删除时，引用它的行也应自动删除。
还有两个其他选项：
SET NULL 和 SET DEFAULT。
当被引用的行被删除时，这些选项会使引用行中的引用列被设置为 null 或其默认值。
请注意，这些选项并不免除您遵守任何约束的责任。
例如，如果某个操作指定了 SET DEFAULT，
但默认值不满足外键约束，则操作将失败。
适当选择ON DELETE操作取决于相关表所代表的对象类型。当引用表代表被引用表所代表的组件，并且不能独立存在时，CASCADE可能是合适的选择。
如果这两个表代表独立的对象，则RESTRICT或NO ACTION更合适；实际上想要删除这两个对象的应用程序必须明确这一点，并运行两个删除命令。
在上面的例子中，订单项目是订单的一部分，如果删除订单，则自动删除它们是方便的。但产品和订单是不同的东西，因此使产品的删除自动导致某些订单项目的删除可能被认为是有问题的。
当外键关系表示可选信息时，SET NULL或SET DEFAULT操作可能是合适的。例如，如果产品表包含对产品经理的引用，并且产品经理条目被删除，则将产品的产品经理设置为null或默认值可能是有用的。
操作SET NULL和SET DEFAULT可以接受一个列列表来指定要设置的列。
通常，外键约束的所有列都会被设置；仅设置子集在某些特殊情况下很有用。考虑以下示例：
CREATE TABLE tenants (
tenant_id integer PRIMARY KEY
);
CREATE TABLE users (
tenant_id integer REFERENCES tenants ON DELETE CASCADE,
user_id integer NOT NULL,
PRIMARY KEY (tenant_id, user_id)
);
CREATE TABLE posts (
tenant_id integer REFERENCES tenants ON DELETE CASCADE,
post_id integer NOT NULL,
author_id integer,
PRIMARY KEY (tenant_id, post_id),
FOREIGN KEY (tenant_id, author_id) REFERENCES users ON DELETE SET NULL (author_id)
);
如果没有指定列，外键也会将列tenant_id设置为null，但该列仍然是主键的一部分。
类似于 ON DELETE，还有 ON UPDATE，当被引用的列被更改（更新）时会被调用。
可能的操作是相同的，除了 SET NULL 和 SET DEFAULT 不能指定列列表。
在这种情况下，CASCADE 意味着被引用列的更新值应复制到引用行中。
ON UPDATE NO ACTION（默认）和 ON UPDATE RESTRICT 之间也有明显的区别。
前者允许更新继续进行，并且外键约束将在更新后的状态下进行检查。
后者将阻止更新运行，即使更新后的状态仍然满足约束。这防止将被引用的行更新为一个不同但比较相等的值（例如，如果使用了不区分大小写的字符字符串类型，则不同大小写变体的字符字符串）。
正常情况下，如果一个引用行的任意一个引用列都为空，则它不需要满足外键约束。如果在外键定义中加入了MATCH FULL，一个引用行只有在它的所有引用列为空时才不需要满足外键约束（因此空和非空值的混合肯定会导致MATCH FULL约束失败）。如果不希望引用行能够避开外键约束，将引用列声明为NOT NULL。
外键必须引用列，这些列要么是主键，要么形成唯一约束，要么是非部分唯一索引的列。
这意味着引用列始终具有索引，以便有效地查找引用行是否有匹配项。
由于从引用表中删除行或更新引用列将需要扫描引用表以查找与旧值匹配的行，
因此通常也建议对引用列建立索引。因为这并不总是需要的，并且有许多可用的索引方式，
所以外键约束的声明不会自动在引用列上创建索引。
更多关于更新和删除数据的信息请见第 6 章。外键约束的语法描述请参考CREATE TABLE。
5.5.6. 排他约束 #
排他约束保证如果将任何两行的指定列或表达式使用指定操作符进行比较，至少其中一个操作符比较将会返回假或空值。语法是：
CREATE TABLE circles (
c circle,
EXCLUDE USING gist (c WITH &&)
);
详见CREATE
TABLE ... CONSTRAINT ... EXCLUDE的详细信息。
增加一个排他约束将在约束声明所指定的类型上自动创建索引。
上一页 上一级 下一页5.4. 生成列 起始页 5.6. 系统列
