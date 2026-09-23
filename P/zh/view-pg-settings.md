# 53.25. pg_settings

53.25. pg_settings
版本：
纠错本页面
搜索
目录导航
❮
❯
53.25. pg_settings #
视图pg_settings提供对服务器运行时参数的访问。
它实质上是SHOW和SET命令的替代接口。
它还提供了一些关于每个参数的事实，这些事实无法直接从SHOW中获取，例如最小值和最大值。
表 53.25. pg_settings 列
列类型
描述
name text
运行时配置参数名
setting text
参数的当前值
unit text
参数的隐式单位
category text
参数的逻辑组
short_desc text
参数的简短描述
extra_desc text
参数的附加详细描述
context text
设置此参数值所需的上下文 (参见下方)
vartype text
参数类型 (bool, enum,
integer, real, or string)
source text
当前参数值的来源
min_val text
参数的最小允许值（对非数字值为空）
max_val text
参数的最大允许值（对非数字值为空）
enumvals text[]
一个枚举参数的允许值（对非枚举值为空）
boot_val text
如果参数没有被其他设置，此列为在服务器启动时设定的参数值
reset_val text
在当前会话中，RESET将会重置参数的值
sourcefile text
当前值在哪个配置文件中设置（对于从配置文件以外的源设置的值，或者被既不是超级用户也没有pg_read_all_settings权限的用户检查时为null）；
在配置文件中使用include指令时很有帮助
sourceline int4
当前值在配置文件中设置的行号（对于从配置文件以外的源设置的值为null，
或者当被既不是超级用户也没有pg_read_all_settings权限的用户检查时）。
pending_restart bool
如果配置文件中修改了该值但需要重启，则为true，否则为false
有几种可能的context值。
按照更改设置的难度递减的顺序，它们是：
internal
这些设置不能直接更改；它们反映了内部确定的值。其中一些可能可通过使用不同的配置选项重新构建服务器，或通过更改提供给initdb的选项来进行调整。
postmaster
这些设置只能在服务器启动时应用，因此任何更改都需要重新启动服务器。这些设置的值通常存储在postgresql.conf文件中，
或者在启动服务器时通过命令行传递。当然，具有任何较低context类型的设置也可以在服务器启动时设置。
sighup
更改这些设置可以在postgresql.conf中进行，而无需重新启动服务器。
向postmaster发送SIGHUP信号，使其重新读取postgresql.conf并应用更改。
postmaster还将向其子进程转发SIGHUP信号，以便它们都采用新值。
superuser-backend
这些设置的更改可以在postgresql.conf中进行，而无需重新启动服务器。
也可以在连接请求数据包中为特定会话设置这些值（例如，通过libpq的PGOPTIONS
环境变量），但前提是连接用户是超级用户或已被授予适当的SET权限。
然而，这些设置在会话启动后永远不会更改。
如果在postgresql.conf中更改它们，请向postmaster发送一个
SIGHUP信号，以使其重新读取postgresql.conf。新值只会
影响随后启动的会话。
backend
这些设置的更改可以在postgresql.conf中进行，而无需重新启动服务器。
也可以在连接请求数据包中为特定会话设置这些值（例如，通过libpq的PGOPTIONS
环境变量）；任何用户都可以为其会话进行此类更改。
但是，在会话启动后，这些设置永远不会更改。
如果您在postgresql.conf中更改它们，请向postmaster发送一个
SIGHUP信号，以使其重新读取postgresql.conf。新值只会
影响随后启动的会话。
superuser
这些设置可以从postgresql.conf中设置，
或者通过SET命令在会话中设置；但只有超级用户
和具有适当SET权限的用户
可以通过SET更改它们。
如果没有使用SET建立会话本地值，那么在postgresql.conf中的更改也会影响到现有会话。
user
这些设置可以从postgresql.conf中设置，
或通过SET命令在会话中设置。任何用户都可以更改其会话本地值。
如果没有使用SET建立会话本地值，那么在postgresql.conf中的更改也会影响到现有会话。
查看第 19.1 节以获取有关更改这些参数的各种方法的更多信息。
这个视图不能被插入或删除，但可以被更新。对pg_settings表的一行应用UPDATE等同于在该命名参数上执行SET命令。更改仅影响当前会话使用的值。如果在稍后被中止的事务中发出UPDATE，则在事务回滚时UPDATE命令的效果消失。一旦周围的事务提交，效果将持续到会话结束，除非被另一个UPDATE或SET覆盖。
这个视图不会显示定制选项，
除非定义这些选项的扩展模块已被执行查询的后端进程加载（例如，通过在
shared_preload_libraries中提及，
在扩展中调用C函数，或使用
LOAD命令）。
例如，由于归档模块
通常只由归档进程加载而不是常规会话，
因此，除非采取特殊措施将它们加载到执行查询的后端进程中，
否则此视图将不显示由这些模块定义的任何定制选项。
上一页 上一级 下一页53.24. pg_sequences 起始页 53.26. pg_shadow
