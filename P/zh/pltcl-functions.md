# 42.2. PL/Tcl 函数和参数

42.2. PL/Tcl 函数和参数
版本：
纠错本页面
搜索
目录导航
❮
❯
42.2. PL/Tcl 函数和参数 #
要用PL/Tcl语言创建函数，可使用标准的CREATE FUNCTION语法：
CREATE FUNCTION funcname (argument-types) RETURNS return-type AS $$
# PL/Tcl function body
$$ LANGUAGE pltcl;
PL/TclU是一样的，只是语言被指定为pltclu。
函数的主体就是一个 Tcl 脚本。当函数被调用时，参数值会被以变量名$1 ... $n传递给该Tcl脚本。结果会以常见的方式通过一个return语句从 Tcl 脚本中返回。在一个过程中，Tcl代码的返回值会被忽略。
例如，一个返回两个整数值中较大值的函数可以定义为：
CREATE FUNCTION tcl_max(integer, integer) RETURNS integer AS $$
if {$1 > $2} {return $1}
return $2
$$ LANGUAGE pltcl STRICT;
注意子句STRICT，它让我们不用去操心空输入值：如果空值被传入，函数根本就不会被调用，而是自动地返回一个空结果。
在非严格函数中，如果一个参数的实际值为空，对应的$n变量将被设置为一个空串。为了检测一个特定参数是否为空，可使用函数argisnull。例如，假设我们想要带有一个空参数和一个非空参数并且返回非空参数的tcl_max：
CREATE FUNCTION tcl_max(integer, integer) RETURNS integer AS $$
if {[argisnull 1]} {
if {[argisnull 2]} { return_null }
return $2
}
if {[argisnull 2]} { return $1 }
if {$1 > $2} {return $1}
return $2
$$ LANGUAGE pltcl;
如上所述，要从一个 PL/Tcl 函数返回空值，可执行return_null。不管函数是严格还是非严格都可以这样做。
组合类型参数会被作为 Tcl 数组传递给函数。该数组的元素名就是组合类型的属性名。如果被传入行的一个属性为空值，它不会出现在数组中。这里是一个例子：
CREATE TABLE employee (
name text,
salary integer,
age integer
);
CREATE FUNCTION overpaid(employee) RETURNS boolean AS $$
if {200000.0 < $1(salary)} {
return "t"
}
if {$1(age) < 30 && 100000.0 < $1(salary)} {
return "t"
}
return "f"
$$ LANGUAGE pltcl;
PL/Tcl函数也能返回组合类型的结果。要返回组合类型结果，Tcl代码必须返回匹配预期结果类型的“列名/值”对的列表。任何从该列表中省略的列名将被返回为空，如果有意外的列名则会报出错误。这里是一个例子：
CREATE FUNCTION square_cube(in int, out squared int, out cubed int) AS $$
return [list squared [expr {$1 * $1}] cubed [expr {$1 * $1 * $1}]]
$$ LANGUAGE pltcl;
过程的输出参数以相同的方式返回，例如：
CREATE PROCEDURE tcl_triple(INOUT a integer, INOUT b integer) AS $$
return [list a [expr {$1 * 3}] b [expr {$2 * 3}]]
$$ LANGUAGE pltcl;
CALL tcl_triple(5, 10);
提示
结果列表可以用Tcl的array get命令从想得到的元组的数组表示中生成。例如：
CREATE FUNCTION raise_pay(employee, delta int) RETURNS employee AS $$
set 1(salary) [expr {$1(salary) + $2}]
return [array get 1]
$$ LANGUAGE pltcl;
PL/Tcl函数能够返回集合。要返回集合，Tcl代码应该对每一个要返回的行调用一次return_next，在返回标量类型时传入合适的值或者在返回组合类型时传入“列名/值”对的列表。这里是一个返回标量类型的例子：
CREATE FUNCTION sequence(int, int) RETURNS SETOF int AS $$
for {set i $1} {$i < $2} {incr i} {
return_next $i
}
$$ LANGUAGE pltcl;
这里是一个返回组合类型的例子：
CREATE FUNCTION table_of_squares(int, int) RETURNS TABLE (x int, x2 int) AS $$
for {set i $1} {$i < $2} {incr i} {
return_next [list x $i x2 [expr {$i * $i}]]
}
$$ LANGUAGE pltcl;
上一页 上一级 下一页42.1. 概述 起始页 42.3. PL/Tcl 中的数据值
