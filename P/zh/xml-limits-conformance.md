# D.3. XML限制和符合性

D.3. XML限制和符合性
版本：
纠错本页面
搜索
目录导航
❮
❯
D.3. XML限制和符合性 #D.3.1. 查询只限于XPath 1.0D.3.2. 实现中的附带限制
ISO/IEC 9075-14（SQL/XML）中与XML相关规范的重大修订是在SQL:2006中引入的。
PostgreSQL对XML数据类型及相关函数的实现大体遵循了
早期的2003版，并借鉴了后续版本的部分内容。具体来说：
当前标准提供了一系列XML数据类型，用于保存无类型或XML Schema类型的
“文档”或“内容”，以及一个类型
XML(SEQUENCE)用于保存任意XML内容片段，
PostgreSQL则提供了单一的
xml类型，可以保存“文档”或
“内容”。标准中的“序列”类型没有对应的等价物。
PostgreSQL提供了SQL:2006中引入的两个函数，
但使用的是XPath 1.0语言的变体，而非标准中指定的XML Query。
PostgreSQL不支持
RETURNING CONTENT或RETURNING SEQUENCE
子句，规范中定义带有这些子句的函数隐式返回内容。
本节介绍了一些你可能会遇到的差异。
D.3.1. 查询只限于XPath 1.0 #
PostgreSQL-特定的函数
xpath() 和 xpath_exists()使用XPath语言查询XML文档。
PostgreSQL也提供了标准函数中的XPath-only变体XMLEXISTS和
XMLTABLE，其中正式采用XQuery语言。所有这些函数
PostgreSQL都依赖于libxml2 库，而这个库仅在XPath 1.0中提供。
在XQuery语言和XPath 2.0及以后的版本之间有很强的联系：任何语法上有效的表达式，在这两个版本中都能成功地执行，都会产生相同的结果（对于包含数字字符引用或预定义的实体引用的表达式会略有不同，
XQuery会用相应的字符替换，而XPath则不会。）但这些语言和XPath 1.0之间没有这种联系，它是一种较早的语言，在很多方面都有区别。
有两类限制需要记住：一是对SQL标准中指定的函数从XQuery到XPath的限制，二是对标准和PostgreSQL特定函数的XPath限制是1.0版本。
D.3.1.1. XQuery到XPath的限制 #
除了XPath的特性之外，XQuery的特性还包括:
除了所有可能的XPath值之外，XQuery表达式还可以构造和返回新的XML节点。XPath可以创建和返回原子类型（数字、字符串等）的值，但只能返回作为表达式输入的文档中已经存在的XML节点。
XQuery有用于迭代、排序和分组的控制结构。
XQuery允许声明和使用局部函数。
最近的 XPath 版本开始提供与这些功能重叠的功能（例如函数式的 for-each和sort，匿名函数，以及 parse-xml从字符串中创建节点），但这些功能在 XPath 3.0 之前是不具备的。
D.3.1.2. 对 XPath 的限制为 1.0 #
对于熟悉 XQuery 和 XPath 2.0 或更高版本的开发人员来说，XPath 1.0
带来了许多不同的地方，需要解决的是:
一个 XQuery/XPath 表达式的基本类型，即 sequence，它可以包含 XML 节点、原子值或两者，在 XPath 1.0 中不存在。一个 1.0 表达式只能产生一个节点集（包含零个或更多的 XML 节点），或者一个原子值。
与 XQuery/XPath 序列不同的是，XPath 1.0 节点集没有保证顺序，和任何集一样，不允许同一个项目多次出现。
注意
libxml2 库似乎总是将节点集返回到 PostgreSQL 的节点集，其成员在输入文档中的相对顺序是一样的。它的文档并没有承诺这种行为，而且 XPath 1.0 表达式不能控制它。
虽然 XQuery/XPath 提供了 XML Schema 中定义的所有类型和许多操作符和函数，但 XPath 1.0 只有节点集和三种原子类型 boolean、double 和 string。
XPath 1.0 没有条件运算符。一个 XQuery/XPath 表达式，如 if ( hat ) then hat/@size else "no hat" 没有 XPath 1.0 的等价物。
XPath 1.0 没有对字符串进行排序比较运算符。"cat" < "dog" 和 "cat" > "dog" 都是假的，因为每一个都是两个 NaN 的数值比较。相比之下，= 和 != 确实将字符串作为字符串进行比较。
XPath 1.0 模糊了 XQuery/XPath 定义的 值比较 和 一般比较 之间的区别。 sale/@hatsize = 7 和 sale/@customer = "alice" 都是存在的量化比较，如果有任何 sale 属性的给定值，则为真。但 sale/@taxable = false() 是与整个节点集的 有效布尔值 的值比较。只有当没有 sale 有一个 taxable 属性时，它才是真值。
在 XQuery/XPath 数据模型中，一个 文档节点 既可以有文档形式（即正好有一个顶层元素，只有注释和处理指令以外的注释和处理指令），也可以有内容形式（放宽了这些限制）。在 XPath 1.0 中，它的等价物是 根节点，只能是文档形式。这也是 xml 的值被作为上下文项到任何 PostgreSQL 的基于 XPath 的函数必须是以文档形式出现。
这里强调的区别并不是全部。在 XQuery 和 XPath 的 2.0 及以后的版本中，有一个 XPath 1.0 的兼容性模式，W3C 列出的 函数库变化 和 语言变化 在该模式下应用的列表提供了一个更完整（但仍然不是详尽的）的差异说明。兼容性模式不能使后来的语言与 XPath 1.0 完全等同。
D.3.1.3. SQL 和 XML 数据类型和值之间的映射 #
在 SQL:2006 及以后的版本中，标准 SQL 数据类型和 XML Schema 类型之间的转换方向都被精确地指定了。但是，这些规则都是用 XQuery/XPath 的类型和语义来表示的，对于 XPath 1.0 的不同数据模型没有直接应用。
当 PostgreSQL 将 SQL 数据值映射到 XML（如 xmlelement），或 XML 映射到 SQL（如输出 xmltable 的列），除了少数情况下的特殊处理，PostgreSQL 只需假定 XML 数据类型的 XPath 1.0 字符串形式将被视为有效的文本输入形式的 SQL 数据类型，反之。该规则的优点是简单，同时对许多数据类型来说，产生的结果与标准中规定的映射类似。
如果与其他系统的互操作性是一个问题，对于某些数据类型，可能需要使用数据类型格式化函数（如 第 9.8 节 中的函数）来生成标准映射。
D.3.2. 实现中的附带限制 #
本节涉及的限制并不是libxml2库所固有的，而是适用于PostgreSQL中的当前实现。
D.3.2.1. 仅支持BY VALUE传递机制 #
SQL标准定义了两种传递机制，适用于从SQL向XML函数传递XML参数或接收结果时：BY REF，其中一个特定的XML值保留其节点身份，以及BY VALUE，其中传递XML的内容，但不保留节点身份。可以在参数列表之前指定，作为所有参数的默认机制，也可以在任何参数之后指定，以覆盖默认机制。
为了说明区别，如果x是一个XML值，那么在SQL:2006环境下的这两个查询将分别产生true和false：
SELECT XMLQUERY('$a is $b' PASSING BY REF x AS a, x AS b NULL ON EMPTY);
SELECT XMLQUERY('$a is $b' PASSING BY VALUE x AS a, x AS b NULL ON EMPTY);
PostgreSQL将在XMLEXISTS或XMLTABLE构造中接受BY VALUE或BY REF，但它会忽略它们。 xml数据类型持有一个字符串的序列化表示，因此没有节点身份需要保留，并且传递总是有效的BY VALUE。
D.3.2.2. 不能将命名参数传递给查询 #
基于 XPath 的函数支持传递一个参数作为 XPath 表达式的上下文项，但不支持传递额外的值作为命名参数提供给表达式。
D.3.2.3. 无 XML(SEQUENCE) 类型 #
PostgreSQL xml 数据类型只能保存一个值，在 DOCUMENT 或 CONTENT 形式。一个 XQuery/XPath 表达式上下文项必须是一个单一的 XML 节点或原子值，但 XPath 1.0 进一步限制它只能是一个 XML 节点，并且没有允许 CONTENT 的节点类型。最终的结果是，一个完善的 DOCUMENT 是 PostgreSQL 可以作为 XPath 上下文项提供的唯一形式的 XML 值。
上一页 上一级 下一页D.2. 未支持的特性 起始页 附录 E. 版本说明
