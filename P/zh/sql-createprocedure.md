# CREATE PROCEDURE

CREATE PROCEDURE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE PROCEDURECREATE PROCEDURE — 定义一个新的过程大纲
CREATE [ OR REPLACE ] PROCEDURE
name ( [ [ argmode ] [ argname ] argtype [ { DEFAULT | = } default_expr ] [, ...] ] )
{ LANGUAGE lang_name
| TRANSFORM { FOR TYPE type_name } [, ... ]
| [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
| SET configuration_parameter { TO value | = value | FROM CURRENT }
| AS 'definition'
| AS 'obj_file', 'link_symbol'
| sql_body
} ...
描述
CREATE PROCEDURE 定义一个新的过程。
CREATE OR REPLACE PROCEDURE 将会创建一个新过程，或者替换一个已有的定义。
为了能够定义过程，用户必须具有所使用的语言上的 USAGE 特权。
如果这个命令中包括了一个模式名称，则该过程将被创建在该模式中。否则过程将被创建在当前的模式中。
新过程的名称不能匹配同一模式中具有相同输入参数类型的任何现有过程或函数。不过，
具有不同参数类型的过程和函数可以共享同一个名称（这被称为 重载）。
要替换一个已有过程的当前定义，请使用 CREATE OR REPLACE PROCEDURE。
不能用这种方式更改过程的名称或者参数类型（如果尝试这样做，实际上会创建一个新的、不同的过程）。
当 CREATE OR REPLACE PROCEDURE 被用来替换一个现有的过程时，该过程的拥有关系和权限保持不变。
所有其他的过程属性会被赋予这个命令中指定的或者暗示的值。必须拥有（包括成为拥有角色的成员）该过程才能替换它。
创建过程的用户将成为该过程的拥有者。
为了能够创建一个过程，用户必须具有参数类型上的USAGE特权。
有关编写过程的详细信息，请参阅第 36.4 节。
参数name
要创建的过程的名称（可以是方案限定的）。
argmode
参数的模式可以是：IN、OUT、
INOUT或VARIADIC。如果省略，
默认为IN。
argname
参数的名称。
argtype
过程的参数（如果有）的数据类型（可以是方案限定的）。参数类型可以是基础类型、组合类型、
或者域类型，或者可以引用一个表列的类型。
根据具体的实现语言，还可能可以指定“伪类型”，例如cstring。伪类型表示实际的参数类型要么没有完全确定，要么位于普通SQL数据类型的集合之外。
写上table_name.column_name%TYPE可以引用某个列的类型。使用这种特性有时可以让过程不受表定义改变的影响。
default_expr
没有指定参数时要被用作默认值的表达式。这个表达式必须可以转换为该参数的参数类型。跟在有默认值的参数后面的输入参数也都必须有默认值。
lang_name
用于实现该过程的语言名称。它可以是sql、c、
internal或者一种用户定义的过程语言的名称，例如plpgsql。
如果指定了sql_body，则默认值为sql。
将名称包裹在单引号内的方式已经被废弃，并且要求大小写匹配。
TRANSFORM { FOR TYPE type_name } [, ... ] }
列出对过程的调用应该应用哪些转换。转换负责在SQL类型和语言相关的数据类型之间进行转换，请参考CREATE TRANSFORM。过程语言实现通常采用硬编码的方式保存内建类型的知识，因此它们无需在这里列出。但如果一种过程语言实现不知道如何处理一种类型并且没有提供转换，它将回退到默认的行为来转换数据类型，但是这依赖于其实现。
[EXTERNAL] SECURITY INVOKER[EXTERNAL] SECURITY DEFINERSECURITY INVOKER指示过程以调用它的用户的特权来执行。这是默认方式。SECURITY DEFINER指定过程以拥有它的用户的特权来执行。
为了符合SQL标准，允许使用EXTERNAL关键词，但它是可选的，因为与SQL中不同，这个特性适用于所有的过程而不仅仅是外部过程。
SECURITY DEFINER过程不能执行事务控制语句（例如COMMIT和ROLLBACK，具体取决于实现的语言）。
configuration_parametervalue
SET子句导致在进入该过程时指定的配置参数被设置为指定的值，并且在过程退出时恢复到之前的值。SET FROM CURRENT把CREATE PROCEDURE执行时该参数的当前值保存为在进入该过程时要应用的值。
如果对过程附加一个SET子句，那么在该过程中为同一个变量执行的SET LOCAL命令的效果就被限制于该过程：在过程退出时还是会恢复到该配置参数的以前的值。不过，一个普通的SET命令（没有LOCAL）会覆盖这个SET子句，很像它对一个之前的SET LOCAL命令所做的事情：这样一个命令的效果将持续到过程退出之后，除非当前事务被回滚。
如果对过程附加一个SET子句，则该过程不能执行事务控制语句（例如COMMIT和ROLLBACK，具体取决于实现的语言）。
有关允许的参数名和值的更多信息请参考SET和第 19 章。
definition
一个定义该过程的字符串常量，其含义取决于语言。它可以是一个内部的过程名、一个对象文件的路径、一个SQL命令或者以一种过程语言编写的文本。
在编写过程的定义字符串时，使用美元引用（见第 4.1.2.4 节）而不是普通的单引号语法常常会很有帮助。如果没有美元引用，过程定义中的任何单引号或者反斜线必须以双写的方式进行转义。
obj_file, link_symbol
当C语言源码中的过程名与SQL过程的名称不同时，这种形式的AS子句被用于动态可装载的C语言过程。字符串obj_file是包含已编译好的C过程的共享库文件名，并且被按照LOAD命令的方式解析。字符串link_symbol是该过程的链接符号，也就是该过程在C语言源代码中的名称。如果链接符号被省略，则会被假定为与正在被定义的SQL过程的名称相同。
当重复的CREATE PROCEDURE调用引用同一个对象文件时，只会对每一个会话装载该文件一次。要卸载或者重新载入该文件（可能是在开发期间），应该开始一个新的会话。
sql_body
LANGUAGE SQL过程的主体。这应该是一个块
BEGIN ATOMIC
statement;
statement;
...
statement;
END
这类似于将过程体的文本写成字符串常量（请参见上面的definition），
但有一些不同：此形式仅适用于LANGUAGE SQL，字符串常量形式适用于所有语言。
此形式在过程定义时解析，字符串常量形式在执行时解析；因此，此形式不能支持多态参数类型和其他
在过程定义时无法解析的构造。此形式跟踪过程和过程体中使用的对象之间的依赖关系，因此DROP
... CASCADE将正常工作，而使用字符串文本的形式可能会留下悬空过程。最后，此形式与SQL标准
和其他SQL实现更加兼容。
注释
函数创建也适用于过程，更多细节请参考CREATE FUNCTION。
使用CALL来执行过程。
示例
CREATE PROCEDURE insert_data(a integer, b integer)
LANGUAGE SQL
AS $$
INSERT INTO tbl VALUES (a);
INSERT INTO tbl VALUES (b);
$$;
或
CREATE PROCEDURE insert_data(a integer, b integer)
LANGUAGE SQL
BEGIN ATOMIC
INSERT INTO tbl VALUES (a);
INSERT INTO tbl VALUES (b);
END;
然后像这样调用：
CALL insert_data(1, 2);
兼容性
SQL标准中定义有一个CREATE PROCEDURE命令。
PostgreSQL实现可以以兼容的方式使用，但有许多扩展。
有关详细信息，请参见CREATE FUNCTION。
另见ALTER PROCEDURE, DROP PROCEDURE, CALL, CREATE FUNCTION上一页 上一级 下一页CREATE POLICY 起始页 CREATE PUBLICATION
