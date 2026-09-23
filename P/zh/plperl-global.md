# 43.4. PL/Perl 中的全局值

43.4. PL/Perl 中的全局值
版本：
纠错本页面
搜索
目录导航
❮
❯
43.4. PL/Perl 中的全局值 #
可以在函数调用之间或者当前会话的生命周期中用全局哈希
%_SHARED来存储数据，包括代码引用。
这是共享数据的一个简单例子：
CREATE OR REPLACE FUNCTION set_var(name text, val text) RETURNS text AS $$
if ($_SHARED{$_[0]} = $_[1]) {
return 'ok';
} else {
return "cannot set shared variable $_[0] to $_[1]";
}
$$ LANGUAGE plperl;
CREATE OR REPLACE FUNCTION get_var(name text) RETURNS text AS $$
return $_SHARED{$_[0]};
$$ LANGUAGE plperl;
SELECT set_var('sample', 'Hello, PL/Perl!  How''s tricks?');
SELECT get_var('sample');
这是一个使用代码引用的稍微复杂一点的例子：
CREATE OR REPLACE FUNCTION myfuncs() RETURNS void AS $$
$_SHARED{myquote} = sub {
my $arg = shift;
$arg =~ s/(['\\])/\\$1/g;
return "'$arg'";
};
$$ LANGUAGE plperl;
SELECT myfuncs(); /* 初始化函数 */
/* 设置一个使用引用函数的函数 */
CREATE OR REPLACE FUNCTION use_quote(TEXT) RETURNS text AS $$
my $text_to_quote = shift;
my $qfunc = $_SHARED{myquote};
return &$qfunc($text_to_quote);
$$ LANGUAGE plperl;
（你可以把上面的代码用一行
return $_SHARED{myquote}->($_[0]);替换，
代价是牺牲了可读性）。
出于安全原因，PL/Perl为每个SQL角色调用的函数在一个单独的Perl解释器中执行。
这可以防止一个用户意外或恶意干扰另一个用户的PL/Perl函数的行为。
每个这样的解释器都有自己的%_SHARED变量和其他全局状态。
因此，只有当两个PL/Perl函数由相同的SQL角色执行时，它们才会共享%_SHARED的值。
在一个应用程序中，一个会话通过多个SQL角色执行代码（通过SECURITY DEFINER函数、
使用SET ROLE等），您可能需要采取明确的步骤来确保PL/Perl函数可以通过
%_SHARED共享数据。为此，请确保应该通信的函数由同一用户拥有，并标记为
SECURITY DEFINER。当然，您必须小心确保这些函数不能被用于执行任何意外操作。
上一页 上一级 下一页43.3. 内置函数 起始页 43.5. 可信的和不可信的 PL/Perl
