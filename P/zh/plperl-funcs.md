# 43.1. PL/Perl 函数和参数

43.1. PL/Perl 函数和参数
版本：
纠错本页面
搜索
目录导航
❮
❯
43.1. PL/Perl 函数和参数 #
要用 PL/Perl 语言创建一个函数，可使用标准的
CREATE FUNCTION语法：
CREATE FUNCTION funcname (argument-types)
RETURNS return-type
-- function attributes can go here
AS $$
# PL/Perl function body goes here
$$ LANGUAGE plperl;
函数的主体就是普通的 Perl 代码。事实上，PL/Perl 的粘合代码会把它
包裹在一个 Perl 子程序中。一个 PL/Perl 函数会在一种标量上下文中
被调用，因此它无法返回列表。如下文所述，可以通过返回引用来返回
非标量值（数组、记录和集合）。
在一个 PL/Perl 过程中，任何从 Perl 代码返回的值都会被忽略。
PL/Perl 也支持用 DO 语句调用的匿名代码块：
DO $$
# PL/Perl 代码
$$ LANGUAGE plperl;
一个匿名代码块没有参数，并且它返回的任何值都会被抛弃。否则
其行为就像一个函数。
注意
在 Perl 中使用命名嵌套子程序是有危险的，特别是当它们在作用域内
引用局部变量时。因为 PL/Perl 函数被包装成一个子程序，任何放在
其中的命名子程序都会被嵌套。总之，创建通过 coderef 调用的匿名
子程序要安全得多。更多信息可见
perldiag手册页
中的 Variable "%s" will not stay shared 以及
Variable "%s" is not available，或者在互联网上
搜索 “perl nested named subroutine”。
CREATE FUNCTION 命令的语法要求函数
体被写作一个字符串常量。通常对字符串常量使用美元引用（见
第 4.1.2.4 节）最方便。如果选择使用
转义字符串语法 E''，必须双写任何在函数体中使用的单引号
（'）和反斜线（\）（见
第 4.1.2.1 节）。
参数和结果的处理和在任何其他 Perl 子程序中一样：参数被传递到
@_ 中，并且结果值用 return
返回或者把函数中计算的最后一个表达式作为结果值。
例如，一个返回两个整数值中较大值的函数可以定义为：
CREATE FUNCTION perl_max (integer, integer) RETURNS integer AS $$
if ($_[0] > $_[1]) { return $_[0]; }
return $_[1];
$$ LANGUAGE plperl;
注意
参数将被从数据库的编码转换到 PL/Perl 中使用的 UTF-8，返回时再从
UTF-8 转回到数据库编码。
如果一个 SQL 空值被传给一个函数，在
Perl 中该参数值将呈现为“undefined”。上述函数定义对于
空输入的行为不太好（实际上，它会把它们当作零）。我们可以为函数
定义增加STRICT让PostgreSQL
干得更合理：如果空值被传入，函数将根本不会被调用，而只是自动
返回一个空结果。另外一种方式，我们可以在函数体中检查未定义的
输入。例如，假设我们想让带有一个空参数或者一个非空参数的
perl_max返回非空参数而不是空值：
CREATE FUNCTION perl_max (integer, integer) RETURNS integer AS $$
my ($x, $y) = @_;
if (not defined $x) {
return undef if not defined $y;
return $y;
}
return $x if not defined $y;
return $x if $x > $y;
return $y;
$$ LANGUAGE plperl;
如上所述，要从一个 PL/Perl 函数返回一个 SQL 空值，就返回一个未定义值。
不管函数是严格的还是非严格的都可以这样做。
一个非引用的函数参数中的任何东西都是一个串，是相关数据类型的标准
PostgreSQL外部文本表达。在普通
数字或文本类型的情况下，Perl 将会做正确的事情并且程序员通常不需要
操心。不过，在其他情况下将需要被转换成在 Perl 中更可用的形式。例如，
decode_bytea函数可以被用来把类型
bytea的参数转换成未转义的二进制形式。
类似地，回传给PostgreSQL的值必须
是外部文本表达格式。例如，encode_bytea
函数可以被用来转义二进制数据得到类型bytea的返回值。
一种特别重要的情况是布尔值。如前所述，bool值的默认行为是它们
作为文本传递给 Perl，因此要么't'要么'f'。
这是有问题的，因为 Perl 不会将'f'视为假！
可以通过使用“transform”来改善问题（参见CREATE TRANSFORM）。
bool_plperl扩展提供了合适的转换。要使用它，请安装扩展：
CREATE EXTENSION bool_plperl;  -- or bool_plperlu for PL/PerlU
然后将TRANSFORM函数属性用于接受或返回bool的 PL/Perl 函数，例如：
CREATE FUNCTION perl_and(bool, bool) RETURNS bool
TRANSFORM FOR TYPE bool
AS $$
my ($a, $b) = @_;
return $a && $b;
$$ LANGUAGE plperl;
当应用这个转换时，bool参数将被 Perl 视为1或空，因此正确或错误。
如果函数结果是bool类型，它会根据 Perl 是否将返回值评估为真来判断为真或假。
函数内部执行的 SPI 查询的布尔查询参数和结果也执行类似的转换(第 43.3.1 节)。
Perl 可以把PostgreSQL数组返回为对
Perl 数组的引用。这里有一个例子：
CREATE OR REPLACE function returns_array()
RETURNS text[][] AS $$
return [['a"b','c,d'],['e\\f','g']];
$$ LANGUAGE plperl;
select returns_array();
Perl 把PostgreSQL数组作为被 bless 过的
PostgreSQL::InServer::ARRAY对象传递。这个对象可以被当作
一个数组引用或者一个串，允许为了向后兼容性与为 9.1 以下版本的
PostgreSQL编写的 Perl 代码一起运行。
例如：
CREATE OR REPLACE FUNCTION concat_array_elements(text[]) RETURNS TEXT AS $$
my $arg = shift;
my $result = "";
return undef if (!defined $arg);
# as an array reference
for (@$arg) {
$result .= $_;
}
# also works as a string
$result .= $arg;
return $result;
$$ LANGUAGE plperl;
SELECT concat_array_elements(ARRAY['PL','/','Perl']);
注意
多维数组被以一种对每一个 Perl 程序员都公认的方法表示为对较低维引用数组
的引用。
组合类型参数被作为哈希的引用传递给函数。哈希的键是组合类型的
属性名。这里是一个例子：
CREATE TABLE employee (
name text,
basesalary integer,
bonus integer
);
CREATE FUNCTION empcomp(employee) RETURNS integer AS $$
my ($emp) = @_;
return $emp->{basesalary} + $emp->{bonus};
$$ LANGUAGE plperl;
SELECT name, empcomp(employee.*) FROM employee;
PL/Perl 函数可以使用相同的方法返回组合类型：返回具有所要求属性的
哈希的引用。例如：
CREATE TYPE testrowperl AS (f1 integer, f2 text, f3 text);
CREATE OR REPLACE FUNCTION perl_row() RETURNS testrowperl AS $$
return {f2 => 'hello', f1 => 1, f3 => 'world'};
$$ LANGUAGE plperl;
SELECT * FROM perl_row();
任何所要求结果数据类型中不存在于哈希中的列将被返回为 null 值。
类似的，过程的输出参数也可以被返回为哈希引用：
CREATE PROCEDURE perl_triple(INOUT a integer, INOUT b integer) AS $$
my ($a, $b) = @_;
return {a => $a * 3, b => $b * 3};
$$ LANGUAGE plperl;
CALL perl_triple(5, 10);
PL/Perl 函数也能返回标量或者组合类型集合。为了加速启动并且避免在
内存中让整个结果集排队等候，我们通常希望能一次返回一行。可以按
下文所说的用return_next来这样做。注意在
最后一次return_next后，必须放上
return或者return
undef（后者更好）。
CREATE OR REPLACE FUNCTION perl_set_int(int)
RETURNS SETOF INTEGER AS $$
foreach (0..$_[0]) {
return_next($_);
}
return undef;
$$ LANGUAGE plperl;
SELECT * FROM perl_set_int(5);
CREATE OR REPLACE FUNCTION perl_set()
RETURNS SETOF testrowperl AS $$
return_next({ f1 => 1, f2 => 'Hello', f3 => 'World' });
return_next({ f1 => 2, f2 => 'Hello', f3 => 'PostgreSQL' });
return_next({ f1 => 3, f2 => 'Hello', f3 => 'PL/Perl' });
return undef;
$$ LANGUAGE plperl;
对于小结果集，可以返回到一个数组的引用，该数组分别包含用于
简单类型、数组类型和组合类型的标量、数组引用或者哈希引用。
这里有一些简单的例子把整个结果集作为数组引用返回：
CREATE OR REPLACE FUNCTION perl_set_int(int) RETURNS SETOF INTEGER AS $$
return [0..$_[0]];
$$ LANGUAGE plperl;
SELECT * FROM perl_set_int(5);
CREATE OR REPLACE FUNCTION perl_set() RETURNS SETOF testrowperl AS $$
return [
{ f1 => 1, f2 => 'Hello', f3 => 'World' },
{ f1 => 2, f2 => 'Hello', f3 => 'PostgreSQL' },
{ f1 => 3, f2 => 'Hello', f3 => 'PL/Perl' }
];
$$ LANGUAGE plperl;
SELECT * FROM perl_set();
如果你想要对你的代码使用strict编译指示，有几种选项可用。
对于临时的全局使用，你可以SET
plperl.use_strict为 true。这将影响后续
PL/Perl函数的编译，但是对当前会话中已经编译过的
函数没有影响。对于持久的全局使用，可以在
postgresql.conf文件中设置
plperl.use_strict为 true。
对于在特定函数中的持久使用，可以简单地把
use strict;
放在函数体的顶部。
如果 Perl 版本是 5.10.0 或者更高，也可以使用
feature编译指示。
上一页 上一级 下一页第 43 章 PL/Perl — Perl 程序语言 起始页 43.2. PL/Perl 中的数据值
