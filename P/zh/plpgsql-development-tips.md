# 41.12. PL/pgSQL开发提示

41.12. PL/pgSQL开发提示
版本：
纠错本页面
搜索
目录导航
❮
❯
41.12. PL/pgSQL开发提示 #41.12.1. 处理引号41.12.2. 额外的编译时和运行时检查
在PL/pgSQL中进行开发的一种好方法是使用你自己选择的文本编辑器来创建函数，并且在另一个窗口中使用psql来载入并测试那些函数。如果你正在这样做，使用CREATE OR REPLACE FUNCTION来编写函数是一个好主意。用那种方式你只需要重载该文件来更新函数的定义。例如：
CREATE OR REPLACE FUNCTION testfunc(integer) RETURNS integer AS $$
....
$$ LANGUAGE plpgsql;
在运行psql期间，你可以用下面的命令载入或者重载这样一个函数定义文件：
\i filename.sql
并且接着立即发出 SQL 命令来测试该函数。
另一种在PL/pgSQL中开发的方式是用一个 GUI 数据库访问工具，它能方便对过程语言的开发。这种工具的一个例子是pgAdmin，虽然还有其他工具。这些工具通常提供方便的特性，例如转义单引号以及便于重新创建和调试函数。
41.12.1. 处理引号 #
一个PL/pgSQL函数的代码在一个CREATE FUNCTION中被指定为一个字符串。如果你用通常的方式把该字符串写在单引号中间，那么该函数体中的任何单引号都必须被双写；同样任何反斜线也必须被双写（假定使用了转义字符串语法）。双写引号最多有点冗长，并且在更复杂的情况中代码会变得完全无法理解，因为你很容易发现你需要半打或者更多相邻的引号。我们推荐你转而把函数体写成一个“美元引用”的字符串（见第 4.1.2.4 节）。在美元引用方法中，你从不需要双写任何引号。但是要注意为你需要的每一层嵌套选择一个不同的美元引用定界符。例如，你可能把CREATE FUNCTION命令写成：
CREATE OR REPLACE FUNCTION testfunc(integer) RETURNS integer AS $PROC$
....
$PROC$ LANGUAGE plpgsql;
在这里面，你可以在 SQL 命令中为简单字符串使用引号并且用$$来界定被你组装成字符串的 SQL 命令片段。如果你需要引用包括$$的文本，你可以使用$Q$，等等。
下列图表展示了在写没有美元引用的引号时需要做什么。在将之前用美元引用的代码翻译成更易于理解的代码时，它们会有所帮助。
1 个引号 #
用来开始和结束函数体，例如：
CREATE FUNCTION foo() RETURNS integer AS '
....
' LANGUAGE plpgsql;
在一个单引号引用的函数体中的任何位置，引号必须成对出现。
2 个引号 #
用于函数体内的字符串，例如：
a_output := ''Blah'';
SELECT * FROM users WHERE f_name=''foobar'';
在美元引用方法中，你只需要写：
a_output := 'Blah';
SELECT * FROM users WHERE f_name='foobar';
这恰好就是PL/pgSQL在两种情况中会看到的。
4 个引号 #
当你在函数内的一个字符串常量中需要一个单引号时，例如：
a_output := a_output || '' AND name LIKE ''''foobar'''' AND xyz''
实际会被追加到a_output的值将是： AND name LIKE 'foobar' AND xyz。
在美元引用方法中，你可以写：
a_output := a_output || $$ AND name LIKE 'foobar' AND xyz$$
要小心在这周围的任何美元引用定界符不只是$$。
6 个引号 #
当在函数体内的一个字符串中的一个单引号与该字符串常量末尾相邻，例如：
a_output := a_output || '' AND name LIKE ''''foobar''''''
被追加到a_output的值则将是： AND name LIKE 'foobar'。
在美元引用方法中，这会变成：
a_output := a_output || $$ AND name LIKE 'foobar'$$
10 个引号 #
当你想在一个字符串常量（占 8 个引号）中有两个单引号时并且这会挨着该字符串常量的末尾（另外 2 个）。如果你正在写一个产生其他函数的函数（如例 41.10中），你将很可能只需要这种。例如：
a_output := a_output || '' if v_'' ||
referrer_keys.kind || '' like ''''''''''
|| referrer_keys.key_string || ''''''''''
then return ''''''  || referrer_keys.referrer_type
|| ''''''; end if;'';
a_output的值将是：
if v_... like ''...'' then return ''...''; end if;
在美元引用方法中，这会变成：
a_output := a_output || $$ if v_$$ || referrer_keys.kind || $$ like '$$
|| referrer_keys.key_string || $$'
then return '$$  || referrer_keys.referrer_type
|| $$'; end if;$$;
这里我们假定我们只需要把单引号放在a_output中，因为在使用前它将被再引用。
41.12.2. 额外的编译时和运行时检查 #
为了辅助用户在一些简单但常见的问题产生危害之前找到它们，
PL/pgSQL提供了额外的检查。当被启用时，
根据配置，它们可以在一个函数的编译期间被用来发出
WARNING或者ERROR。一个已经收到了
WARNING的函数可以被继续执行而不会产生进一步的消息，
因此建议你在一个单独的开发环境中进行测试。
根据需要设置 plpgsql.extra_warnings 或 plpgsql.extra_errors，适当情况下，在开发和/或测试环境中就可以设置为 "all"。
这些额外的检查通过配置变量plpgsql.extra_warnings（用于警告）
和plpgsql.extra_errors（用于错误）启用。两者都可以设置为
逗号分隔的检查列表、"none"或"all"。
默认值是"none"。当前可用的检查列表包括：
shadowed_variables #
检查声明是否覆盖了先前定义的变量。
strict_multi_assignment #
一些PL/pgSQL命令允许一次为多个变量赋值，
例如SELECT INTO。通常，目标变量的数量和源变量的
数量应该匹配，尽管PL/pgSQL会对缺失的值
使用NULL，并忽略多余的变量。启用此检查将导致
PL/pgSQL在目标变量和源变量数量不匹配时
抛出WARNING或ERROR。
too_many_rows #
启用此检查将导致PL/pgSQL检查在使用
INTO子句时，查询是否返回多于一行。由于
INTO语句只会使用一行，查询返回多行通常是低效
的和/或不确定的，因此可能是一个错误。
以下示例展示了将plpgsql.extra_warnings设置为
shadowed_variables的效果：
SET plpgsql.extra_warnings TO 'shadowed_variables';
CREATE FUNCTION foo(f1 int) RETURNS int AS $$
DECLARE
f1 int;
BEGIN
RETURN f1;
END;
$$ LANGUAGE plpgsql;
WARNING:  variable "f1" shadows a previously defined variable
LINE 3: f1 int;
^
CREATE FUNCTION
下面的示例展示了将plpgsql.extra_warnings设置为
strict_multi_assignment的效果：
SET plpgsql.extra_warnings TO 'strict_multi_assignment';
CREATE OR REPLACE FUNCTION public.foo()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
x int;
y int;
BEGIN
SELECT 1 INTO x, y;
SELECT 1, 2 INTO x, y;
SELECT 1, 2, 3 INTO x, y;
END;
$$;
SELECT foo();
WARNING:  number of source and target fields in assignment does not match
DETAIL:  strict_multi_assignment check of extra_warnings is active.
HINT:  Make sure the query returns the exact list of columns.
WARNING:  number of source and target fields in assignment does not match
DETAIL:  strict_multi_assignment check of extra_warnings is active.
HINT:  Make sure the query returns the exact list of columns.
foo
-----
(1 row)
上一页 上一级 下一页41.11. PL/pgSQL的内部实现 起始页 41.13. 从Oracle PL/SQL 移植
