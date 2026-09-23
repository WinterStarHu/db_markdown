# 41.2. PL/pgSQL的结构

41.2. PL/pgSQL的结构
版本：
纠错本页面
搜索
目录导航
❮
❯
41.2. PL/pgSQL的结构 #
通过执行CREATE FUNCTION命令，以PL/pgSQL写成的函数可以被定义到服务器中。这种命令通常看起来是这样：
CREATE FUNCTION somefunc(integer, text) RETURNS integer
AS 'function body text'
LANGUAGE plpgsql;
就目前CREATE FUNCTION所关心的来说，函数体就是简单的一个字符串。通常在写函数体时，使用美元符号引用（见第 4.1.2.4 节）比使用普通单引号语法更有帮助。如果没有美元引用，函数体中的任何单引号或者反斜线必须通过双写来转义。这一章中几乎所有的例子都在其函数体中使用美元符号引用。
PL/pgSQL是一种块结构的语言。一个函数体的完整文本必须是一个块。一个块被定义为：
[ <<label>> ]
[ DECLARE
declarations ]
BEGIN
statements
END [ label ];
在一个块中的每一个声明和每一个语句都由一个分号终止。如上所示，出现在另一个块中的块必须有一个分号在END之后。不过最后一个结束函数体的END不需要一个分号。
提示
一种常见的错误是直接在BEGIN之后写一个分号。这是不正确的，并且将会导致一个语法错误。
如果你想要标识一个块以便在一个EXIT语句中使用或者标识在该块中声明的变量名，那么label是你唯一需要的。如果一个标签在END之后被给定，它必须匹配在块开始处的标签。
所有的关键词都是大小写无关的。除非被双引号引用，标识符会被隐式地转换为小写形式，就像它们在普通 SQL 命令中一样。
PL/pgSQL代码中的注释和普通 SQL 中的一样。一个双连字符（--）开始一段注释，它延伸到该行的末尾。一个/*开始一段块注释，它会延伸到匹配*/出现的位置。块注释可以嵌套。
一个块的语句节中的任何语句可以是一个子块。子块可以被用来逻辑分组或者将变量局部化为语句的一个小组。在子块的持续期间，在一个子块中声明的变量会掩盖外层块中相同名称的变量。但是如果你用块的标签限定外层变量的名字，你仍然可以访问它们。例如：
CREATE FUNCTION somefunc() RETURNS integer AS $$
<< outerblock >>
DECLARE
quantity integer := 30;
BEGIN
RAISE NOTICE 'Quantity here is %', quantity;  -- Prints 30
quantity := 50;
--
-- 创建一个子块
--
DECLARE
quantity integer := 80;
BEGIN
RAISE NOTICE 'Quantity here is %', quantity;  -- Prints 80
RAISE NOTICE 'Outer quantity here is %', outerblock.quantity;  -- Prints 50
END;
RAISE NOTICE 'Quantity here is %', quantity;  -- Prints 50
RETURN quantity;
END;
$$ LANGUAGE plpgsql;
注意
在任何PL/pgSQL函数体的外部确实有一个隐藏的“外层块”包围着。这个块提供了该函数参数（如果有）的声明，以及某些诸如FOUND之类特殊变量（见第 41.5.5 节）。外层块被标上函数的名称，这意味着参数和特殊变量可以用该函数的名称限定。
重要的是不要把PL/pgSQL中用来分组语句的BEGIN/END与用于事务控制的同名 SQL 命令弄混。PL/pgSQL的BEGIN/END只用于分组，它们不会开始或结束一个事务。有关PL/pgSQL中管理事务的信息，请参考第 41.8 节。此外，一个包含EXCEPTION子句的块实际上会形成一个子事务，它可以被回滚而不影响外层事务。详见第 41.6.8 节。
上一页 上一级 下一页41.1. 综述 起始页 41.3. 声明
