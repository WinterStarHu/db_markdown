# CREATE OPERATOR

CREATE OPERATOR
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE OPERATORCREATE OPERATOR — 定义一个新的操作符大纲
CREATE OPERATOR name (
{FUNCTION|PROCEDURE} = function_name
[, LEFTARG = left_type ] [, RIGHTARG = right_type ]
[, COMMUTATOR = com_op ] [, NEGATOR = neg_op ]
[, RESTRICT = res_proc ] [, JOIN = join_proc ]
[, HASHES ] [, MERGES ]
)
描述
CREATE OPERATOR 定义一个新的操作符
name。定义操作符
的用户会成为该操作符的拥有者。如果给出一个模式名，该操作符将被创建
在指定的模式中。否则它会被创建在当前模式中。
操作符名称是以下列表中最多NAMEDATALEN-1（默认为63）个字符的序列：
+ - * / < > = ~ ! @ # % ^ & | ` ?
对名称的选择有一些限制：
-和/*不能出现在操作符名称的任何位置，
因为它们将被视为注释的开始。
多字符操作符名称不能以+或-结尾，
除非名称还包含至少一个这些字符：
~ ! @ # % ^ & | ` ?
例如，@-是一个允许的操作符名称，
但*-不是。
这个限制允许PostgreSQL解析符合SQL标准的命令，而不需要在标记之间添加空格。
符号=>被SQL语法保留，因此不能用作操作符名称。
在输入时!=会被映射为<>，
因此这两个名字总是等效的。
对于二元运算符，必须同时定义LEFTARG和RIGHTARG。
对于前缀运算符，仅应定义RIGHTARG。
function_name函数
必须在之前已经用CREATE FUNCTION定义好，
并且必须被定义为接受正确数量的指定类型的参数。
在CREATE OPERATOR的语法中，关键词FUNCTION和PROCEDURE是等效的，但无论哪种情况下被引用的函数都必须是一个函数而不是过程。这里对关键词PROCEDURE的使用是有历史原因的，现在已经被废弃。
其他条款指定了可选的操作符优化属性。它们的含义详见
第 36.15 节.
要能够创建操作符，您必须对参数类型和返回类型拥有USAGE
权限，并且对底层函数拥有EXECUTE权限。如果指定了
交换子或否定子操作符，您必须拥有这些操作符。
参数name
要定义的操作符的名称。允许使用的字符请见上文。名称可以被模式
限定，例如CREATE OPERATOR myschema.+ (...)。如果
没有被模式限定，该操作符将被创建在当前模式中。如果两个同一模式
中的操作符在不同的数据类型上操作，它们可以具有相同的名称。这
被称为重载。
function_name
用来实现这个操作符的函数。
left_type
这个操作符的左操作数（如果有）的数据类型。忽略这个选项
可以表示一个前缀操作符。
right_type
这个操作符的右操作数（如果有）的数据类型。
com_op
这个操作符的交换子。
neg_op
这个操作符的求反器。
res_proc
用于这个操作符的限制选择性估计函数。
join_proc
用于这个操作符的连接选择性估计函数。
HASHES
表示这个操作符可以支持哈希连接。
MERGES
表示这个操作符可以支持归并连接。
要在com_op
或其他可选参数中给出一个模式限定的操作符名称，
请使用OPERATOR()语法，例如：
COMMUTATOR = OPERATOR(myschema.===) ,
备注
更多信息请参考 第 36.14 节 和 第 36.15 节。
当你定义一个自反交换算子时，你只需直接定义它。
当你定义一对交换算子时，情况会稍微复杂一些：
第一个被定义的算子如何引用另一个尚未定义的算子呢？对此问题有三种解决方案：
一种方法是在第一个定义的算子中省略COMMUTATOR子句，
然后在第二个算子的定义中提供该子句。由于PostgreSQL
知道交换算子是成对出现的，当它看到第二个定义时，会自动回过头去补全
第一个定义中缺失的COMMUTATOR子句。
另一种更直接的方法是，在两个定义中都包含COMMUTATOR子句。
当PostgreSQL处理第一个定义并发现COMMUTATOR
指向一个不存在的算子时，系统会在系统目录中为该算子创建一个虚拟条目。
该虚拟条目仅包含算子名称、左右操作数类型和所有者的有效数据，
因为这就是PostgreSQL此时能推断出的全部信息。
第一个算子的目录条目将链接到这个虚拟条目。稍后，当你定义第二个算子时，
系统会用第二个定义中的附加信息更新该虚拟条目。如果你在虚拟条目被填充之前
尝试使用它，就会收到错误信息。
另外，也可以在两个算子定义时都不包含COMMUTATOR子句，
然后使用ALTER OPERATOR命令来设置它们的交换子链接。
只需ALTER其中一个算子就可以。
在这三种情况下，你必须拥有这两个算子的所有权，才能将它们标记为交换子。
否定算子对可以使用与交换算子对相同的方法来定义。
无法在CREATE OPERATOR中指定一个操作符的
词法优先级，因为解析器的优先级行为是硬编码的。详见
第 4.1.6 节。
废弃的选项SORT1、SORT2、
LTCMP以及GTCMP以前被用来指定与支持
归并连接的操作符相关的排序操作符的名称。现在不再需要它们了，因为
相关操作符的信息可以在 B-树的操作符族中找到。如果给出了这些选项
之一，它会被忽略（除非是为了隐式设置MERGES为真）。
使用DROP OPERATOR从数据库中删除用户定义的操作符。
使用ALTER OPERATOR修改数据库中的操作符。
示例
下面的命令为数据类型box定义了一种新的操作符——面积相等：
CREATE OPERATOR === (
LEFTARG = box,
RIGHTARG = box,
FUNCTION = area_equal_function,
COMMUTATOR = ===,
NEGATOR = !==,
RESTRICT = area_restriction_function,
JOIN = area_join_function,
HASHES, MERGES
);
兼容性
CREATE OPERATOR是一种
PostgreSQL扩展。在 SQL
标准中没有用户定义操作符的规定。
另见ALTER OPERATOR, CREATE OPERATOR CLASS, DROP OPERATOR上一页 上一级 下一页CREATE MATERIALIZED VIEW 起始页 CREATE OPERATOR CLASS
