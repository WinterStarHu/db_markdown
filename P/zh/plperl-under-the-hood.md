# 43.8. PL/Perl 内部机制

43.8. PL/Perl 内部机制
版本：
纠错本页面
搜索
目录导航
❮
❯
43.8. PL/Perl 内部机制 #43.8.1. 配置43.8.2. 限制和缺失的功能43.8.1. 配置 #
本节列出了影响PL/Perl的配置参数。
plperl.on_init (string)
#
指定当第一次初始化一个 Perl 解释器时要执行的 Perl 代码，这会在
具体用于plperl或plperlu之前做完。当
这段代码被执行时 SPI 函数不可用。如果该代码由于错误失败，它
将中止解释器的初始化并且把错误传播到调用查询，最终导致当前
事务或者子事务被中止。
该 Perl 代码被限制为一个单一的字符串。更长的代码可以放在一个
模块中，然后由on_init字符串载入。例子：
plperl.on_init = 'require "plperlinit.pl"'
plperl.on_init = 'use lib "/my/app"; use MyApp::PgInit;'
任何被plperl.on_init载入的模块（不管是直接还是间接）都
可以被plperl使用。这可能会导致安全性风险。要看哪些模块
已经被载入，可以使用：
DO 'elog(WARNING, join ", ", sort keys %INC)' LANGUAGE plperl;
如果 plperl 库被包括在shared_preload_libraries
中，那么初始化将发生在 postmaster 中，在这种情况下要特别地考虑对
postmaster 带来的不稳定风险。使用这种特性的主要原因是，
plperl.on_init载入的 Perl 模块只需要在 postmaster 开始时
被载入，并且在数据库会话中不需要任何工作就立刻可用。不过，要记住这
只免除了一个数据库会话中使用的第一个 Perl 解释器的负载 — 不管
是 PL/PerlU 还是用于第一个 SQL 角色调用 PL/Perl 函数的 PL/Perl。在一个
数据库会话中创建的任何额外的 Perl 解释器将不得不重新执行
plperl.on_init。还有，在 Windows 上无论从什么里面进行
预先载入，都不会有这种节约，因为在 postmaster 进程中创建的 Perl 解释器
不会传播到子进程中。
这个参数只能在postgresql.conf文件或服务器命令行中设置。
plperl.on_plperl_init (string)
plperl.on_plperlu_init (string)
#
这些参数分别指定当为plperl或plperlu专门准备好
一个 Perl 解释器时要执行的 Perl 代码。当一个 PL/Perl 或者 PL/PerlU 函数
第一次在一个数据库会话中被执行时会发生这种动作，或者由于调用其他语言
或者新的 SQL 角色调用 PL/Perl 函数导致创建额外的解释器时也会发生这种
动作。这些初始化跟随着plperl.on_init所作的初始化。当这段
代码被执行时，SPI 函数不可用。plperl.on_plperl_init中的 Perl
代码在“锁定”解释器之后被执行，因此它只能执行可信的操作。
如果该代码由于错误失败，它将中止初始化并且把错误传播到调用查询，
最终导致当前事务或者子事务被中止。在 Perl 中已经完成的任何动作都
不会被撤销。不过，该解释器将不能被再次使用。如果再次使用该语言，
将在一个新的 Perl 解释器中再次尝试初始化。
只有超级用户能够更改这些设置。尽管这些设置可以在会话中被修改，
但是这类更改将不会影响已经被用来执行函数的 Perl 解释器。
plperl.use_strict (boolean)
#
如果被设置为真，则后续的 PL/Perl 函数编译将会启用
strict编译指示。这个参数不影响当前会话中已编译的函数。
43.8.2. 限制和缺失的功能 #
PL/Perl 中目前缺少下列特性，但是欢迎大家对此作出贡献。
PL/Perl 函数不能直接调用彼此。
SPI 还没有被完全实现。
如果正在使用spi_exec_query取一个非常大的数据集，
你应该注意它们都会进入到内存中。可以按先前所述，通过使用
spi_query/spi_fetchrow来避免发生
这类情况。
如果一个集合返回函数通过return把一个大型的行集合
返回给 PostgreSQL，同样会发生这种情况。同样如前所述，可以为每一个
要返回的行使用return_next来避免这个问题。
当会话正常结束（而不是由于致命错误结束）时，任何已经定义的
END块将被执行。当前不会执行其他动作。特别地，
此时文件句柄不会被自动刷新并且对象不会被自动销毁。
上一页 上一级 下一页43.7. PL/Perl 事件触发器 起始页 第 44 章 PL/Python — Python 过程语言
