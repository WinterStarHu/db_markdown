# 36.14. 用户定义的操作符

36.14. 用户定义的操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
36.14. 用户定义的操作符 #
对于一个完成实际工作的底层函数的调用来说，每一个操作符都是“语法糖”，因此在创建操作符之前你必须先创建底层函数。不过，一个操作符不仅仅是语法糖，因为它携带了额外的信息来帮助查询规划器优化使用该操作符的查询。下一节将致力于解释这些额外信息。
PostgreSQL支持前缀和中缀操作符。操作符可以被重载，也就是说相同的操作符名称可以被用于具有不同操作数数量和类型的操作符。在执行一个查询时，系统会根据提供的操作数的数量和类型决定要调用的操作符。
这里有一个创建用于对两个复数做加法的操作符的例子。我们假设我们已经创建了类型complex（见第 36.13 节）的定义。首先我们需要一个函数做这个加法，然后我们可以定义该操作符：
CREATE FUNCTION complex_add(complex, complex)
RETURNS complex
AS 'filename', 'complex_add'
LANGUAGE C IMMUTABLE STRICT;
CREATE OPERATOR + (
leftarg = complex,
rightarg = complex,
function = complex_add,
commutator = +
);
现在我们可以执行一个这样的查询：
SELECT (a + b) AS c FROM test_complex;
c
-----------------
(5.2,6.05)
(133.42,144.95)
这里我们已经展示了如何创建一个二元操作符。
要创建前缀操作符，只要忽略leftarg。
在CREATE OPERATOR中只要求function子句和参数子句。
例子中展示的commutator子句是一个可选的提示，它被用作查询优化器的提示。
有关commutator以及其他优化器提示的细节出现在下一小节中。
上一页 上一级 下一页36.13. 用户定义的类型 起始页 36.15. 操作符优化信息
