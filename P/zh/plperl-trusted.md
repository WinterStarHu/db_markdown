# 43.5. 可信的和不可信的 PL/Perl

43.5. 可信的和不可信的 PL/Perl
版本：
纠错本页面
搜索
目录导航
❮
❯
43.5. 可信的和不可信的 PL/Perl #
通常，PL/Perl 被作为一种“可信的”编程语言安装，其名称
为plperl。在这种设置下，为了保持安全性禁用了某些
Perl 操作。一般来说，被限制的操作是那些与环境交互的操作。它们
包括文件处理操作、require以及
use（外部模块）。没有办法像 C 函数那样访问
数据库服务器进程的内部或者用服务器进程的权限得到 OS 级别的访问。
因此，任何没有特权的数据库用户也被允许使用这种语言。
警告
受信任的PL/Perl依赖Perl的Opcode模块来维护安全性。
Perl
文档
指出该模块对于受信任的PL/Perl使用场景并不有效。如果您的安全需求
与该警告中的不确定性不兼容，请考虑执行
REVOKE USAGE ON LANGUAGE plperl FROM PUBLIC。
下面例子中的函数将无法工作，因为出于安全原因不允许它做文件操作：
CREATE FUNCTION badfunc() RETURNS integer AS $$
my $tmpfile = "/tmp/badfile";
open my $fh, '>', $tmpfile
or elog(ERROR, qq{could not open the file "$tmpfile": $!});
print $fh "Testing writing to a file\n";
close $fh or elog(ERROR, qq{could not close the file "$tmpfile": $!});
return 1;
$$ LANGUAGE plperl;
这个函数的创建会失败，因为验证器会捕捉到它使用了禁用的操作。
有些时候需要编写不受限制的 Perl 函数。例如，我们可能想要一个能发送
电子邮件的 Perl 函数。要处理这些情况，可以把 PL/Perl 安装成一种
“不可信的”语言（通常被称作
PL/PerlU）。
在这种情况下整个 Perl 语言的特性都可以使用。在安装语言时，用语言
名称plperlu将会选择不可信的 PL/Perl 变体。
PL/PerlU函数的编写者必须注意该函数不能被用来做
其设计目的之外的事情，因为该函数能做一个作为数据库管理员登录的用户
可以做的任何事情。注意数据库系统只允许数据库超级用户用不可信语言
创建函数。
如果上述函数是一个超级用户用语言plperlu创建的，则可以
执行成功。
以和plperl语言同样的方式，可以用plperlu
编写 Perl 中的匿名代码块，这样的代码块能够使用受限的操作，不过调用
者必须是超级用户。
注意
虽然对每个 SQL 角色会在一个独立的 Perl 解释器中运行
PL/Perl函数，但是在一个给定会话中执行的所有
PL/PerlU函数都运行在一个 Perl 解释器中（与用于
任何PL/Perl函数的解释器不同）。这允许
PL/PerlU函数自由地共享数据，但是
PL/Perl和PL/PerlU函数之间不会
发生任何交流。
注意
Perl 不支持一个进程中的多个解释器，除非编译它时使用了合适的标志，
即usemultiplicity或者useithreads（
usemultiplicity会更好，除非你确实需要使用线程。更多细节，
请见perlembed手册页）。
如果PL/Perl用的是一份没有这样编译的 Perl 拷贝，那么
在每个会话中只能有一个 Perl 解释器，并且因此任一会话只能要么执行
PL/PerlU函数，要么执行同一个 SQL 角色调用的
PL/Perl函数。
上一页 上一级 下一页43.4. PL/Perl 中的全局值 起始页 43.6. PL/Perl 触发器
