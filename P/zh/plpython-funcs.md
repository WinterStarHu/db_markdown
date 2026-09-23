# 44.1. PL/Python 函数

44.1. PL/Python 函数
版本：
纠错本页面
搜索
目录导航
❮
❯
44.1. PL/Python 函数 #
在PL/Python中，函数是通过标准的CREATE FUNCTION语法声明的：
CREATE FUNCTION funcname (argument-list)
RETURNS return-type
AS $$
# PL/Python function body
$$ LANGUAGE plpython3u;
函数体就是一个 Python 脚本。当函数被调用时，它的参数被当做列表args的元素传递，命名参数也被作为普通变量传递给 Python 脚本。使用命名参数通常可读性更好。Python 代码会以通常的方式返回结果，即使用return或者yield（在结果集合语句的情况中）。如果没有提供一个返回值，Python 会返回默认的None。PL/Python会把 Python 的None翻译成 SQL 空值。在一个过程中，Python代码的结果必须是None（通常实现为结束过程时不写return语句或者使用不带参数的return），否则将会发生错误。
例如，一个返回两个整数中较大值的函数可以定义为：
CREATE FUNCTION pymax (a integer, b integer)
RETURNS integer
AS $$
if a > b:
return a
return b
$$ LANGUAGE plpython3u;
作为函数定义主体给出的Python代码被转换为Python函数。例如，上述代码会得到：
def __plpython_procedure_pymax_23456():
if a > b:
return a
return b
假设23456是由PostgreSQL分配给该函数的OID。
参数被设置为全局变量。由于Python的作用域规则，这带来了一个微妙的后果，即参数变量不能在函数内部重新赋值为涉及变量名本身的表达式的值，除非在块中将变量重新声明为全局变量。例如，以下情况不起作用：
CREATE FUNCTION pystrip(x text)
RETURNS text
AS $$
x = x.strip()  # error
return x
$$ LANGUAGE plpython3u;
因为对x赋值会使整个块中的x成为局部变量，因此赋值语句右侧的x指的是一个尚未分配的局部变量x，而不是PL/Python函数参数。使用global语句，可以使其正常工作：
CREATE FUNCTION pystrip(x text)
RETURNS text
AS $$
global x
x = x.strip()  # ok now
return x
$$ LANGUAGE plpython3u;
但最好不要依赖于PL/Python的这个实现细节。最好将函数参数视为只读。
上一页 上一级 下一页第 44 章 PL/Python — Python 过程语言 起始页 44.2. 数据值
