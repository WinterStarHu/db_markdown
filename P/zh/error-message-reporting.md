# 55.2. 在服务器中报告错误

55.2. 在服务器中报告错误
版本：
纠错本页面
搜索
目录导航
❮
❯
55.2. 在服务器中报告错误 #
服务器代码内产生的错误、警告和日志消息应该使用ereport，或者更老的elog生成。这个函数的使用有些复杂，因此有必要做一些解释。
每条消息都有两个必需的元素：一个严重性级别（范围从DEBUG到
PANIC，定义在src/include/utils/elog.h中）和一个
主要的消息文本。此外，还有可选元素，其中最常见的是遵循SQL规范的SQLSTATE约定的错误标识码。
ereport本身只是一个壳宏，主要用于语法上的方便，使消息生成看起来像
是C源代码中的单个函数调用。ereport直接接受的唯一参数是严重性级别。
主要的消息文本和任何可选的消息元素都是通过在ereport调用中调用辅助函数，
例如errmsg，来生成的。
对于ereport的一次典型调用可能看起来像：
ereport(ERROR,
errcode(ERRCODE_DIVISION_BY_ZERO),
errmsg("division by zero"));
这会指定错误严重性级别为ERROR（一个普通错误）。errcode调用使用src/include/utils/errcodes.h中定义的一个宏指定 SQLSTATE 错误代码。errmsg调用提供主消息文本。
您还会经常看到这种较旧的样式，在辅助函数调用周围有一组额外的圆括号：
ereport(ERROR,
(errcode(ERRCODE_DIVISION_BY_ZERO),
errmsg("division by zero")));
在 PostgreSQL 版本 12 之前需要额外的括号，但现在是可选的。
这里有一个更复杂的例子：
ereport(ERROR,
errcode(ERRCODE_AMBIGUOUS_FUNCTION),
errmsg("function %s is not unique",
func_signature_string(funcname, nargs,
NIL, actual_arg_types)),
errhint("Unable to choose a best candidate function. "
"You might need to add explicit typecasts."));
这展示了使用格式代码把运行时值嵌入到一个消息文本中的方法，其中还提供了一个可选的“hint”消息。
辅助函数调用可以按任何顺序写入，但通常先出现errcode和errmsg。
如果严重级别是ERROR或更高，ereport
会中止当前查询的执行并且不会返回到调用者。如果严重级别低于
ERROR，ereport会正常返回。
ereport可用的辅助例程是：
errcode(sqlerrcode)指定对于该情况的 SQLSTATE 错误标识符代码。如果没有调用这个例程，错误标识符会默认成ERRCODE_INTERNAL_ERROR，错误级别是WARNING时标识符为ERRCODE_WARNING，否则（对于NOTICE及以下的级别）标识符会被设置为ERRCODE_SUCCESSFUL_COMPLETION。虽然这些默认值常常很方便，在忽略errcode()调用之前请总是思考一下它们是否合适。
errmsg(const char *msg, ...)指定主错误消息文本，以及需要插入其中的运行时值。这种插入以sprintf-风格的格式代码指定。除了sprintf接受的标准格式代码，格式代码%m可以用来插入由strerror为errno的当前值返回的错误消息。
[18]
%m不要求errmsg参数列表中的任何对应项。注意在格式代码被处理之前，消息字符串将通过gettext来进行可能的本地化。
errmsg_internal(const char *msg, ...)与errmsg相同，不过消息串将不会被翻译，也不会被包括在国际化的消息字典中。这不应该被用于“不能发生”的情况中，因为那些情况下不值得花费精力去做翻译。
errmsg_plural(const char *fmt_singular, const char *fmt_plural,
unsigned long n, ...)很像errmsg，但是支持消息的多种复数形式。fmt_singular是英语单数格式，fmt_plural是英语复数格式，n是决定需要何种复数形式的整数值，剩下的参数会被根据选中的格式字符串进行格式化。详见第 56.2.2 节。
errdetail(const char *msg, ...)提供了一个可选的“详情”消息，如果有额外的信息但不适合放在主消息中时就可以使用这种方式。消息字符串的处理与errmsg相同。
errdetail_internal(const char *msg, ...)与errdetail相同，不过消息串将不会被翻译，也不会被包括在国际化的消息字典中。这应该被用于不值得花费精力翻译的详情消息上，例如它们对大部分用户太过技术化而没什么用处。
errdetail_plural(const char *fmt_singular, const char *fmt_plural,
unsigned long n, ...)与errdetail相似，但是支持消息的多种复数形式。详见第 56.2.2 节。
errdetail_log(const char *msg, ...)与errdetail相同，除了这个字符串只会进入服务器的日志而不会发往客户端。如果同时使用了errdetail（或者上述的一种等效函数）以及errdetail_log，那么一个字符串会被发往客户端而另一个会被发往日志。如果错误细节的安全性过于敏感或者体积过于庞大而不适合于发往客户端，这个函数就非常有用。
errdetail_log_plural(const char *fmt_singular, const char
*fmt_plural, unsigned long n, ...)与errdetail_log
相似，但是支持多种复数形式的消息。详见第 56.2.2 节。
errhint(const char *msg, ...)提供一个可选的“hint”消息，它被用来提供关于如何修复该问题的建议。该消息字符串以和errmsg相同的方式处理。
errhint_plural(const char *fmt_singular, const char *fmt_plural,
unsigned long n, ...)与errhint相似，但是支持多种复数形式的消息。详见第 56.2.2 节。
errcontext(const char *msg, ...)通常不会被直接从一个ereport消息站点调用，它被用在error_context_stack回调函数中来提供错误发生的上下文，例如一个 PL 函数中的当前位置。该消息字符串以和errmsg相同的方式处理。不同于其他辅助函数，在每次ereport调用中可以多次调用这个函数，这样提供的连续的字符串将被用单独的新行串接在一起。
errposition(int cursorpos)指定一个查询字符串中错误的文本位置。当前，它只对查询处理的词法和语法分析阶段中检测到的错误有用。
errtable(Relation rel)指定一个关系，它的名称和模式名称应该被包括在错误报告中作为辅助域。
errtablecol(Relation rel, int attnum)指定一个列，它的名称、表名和模式名称应该被包括在错误报告中作为辅助域。
errtableconstraint(Relation rel, const char *conname)指定一个约束，它的名称、表名和模式名称应该被包括在错误报告中作为辅助域。索引应当被视为用于这种目的的约束，不管它们有没有一个相关联的pg_constraint项。要小心地以rel传递底层堆关系而不是索引本身。
errdatatype(Oid datatypeOid)指定一个数据类型，它的名称和模式名称应该被包括在错误报告中作为辅助域。
errdomainconstraint(Oid datatypeOid, const char *conname)指定一个域约束，它的名称、域名和模式名称应该被包括在错误报告中作为辅助域。
errcode_for_file_access()是一个便捷函数，它可以在一个文件访问相关的系统调用中为一个失败选择一个合适的 SQLSTATE 错误标识符。它使用保存下来的errno来决定要生成哪种错误代码。通常，应该把它和主错误消息文本中的%m联合使用。
errcode_for_socket_access()是一个便捷函数，它可以在一个套接字相关的系统调用中为一个失败选择一个合适的 SQLSTATE 错误标识符。
可以调用errhidestmt(bool hide_stmt)来指定抑制 postmaster 日志中消息里的STATEMENT:部分。 如果消息文本已经包含当前语句，通常这是合适的。
可以调用errhidecontext(bool hide_ctx)来指示抑制 postmaster 日志中消息里的CONTEXT:部分。这只应该被用于 verbose 模式的调试消息，这类消息中被重复包含的上下文信息会让日志膨胀得非常厉害。
注意
在一个ereport调用中，最多可以使用一个errtable、errtablecol、errtableconstraint、errdatatype或者errdomainconstraint函数。这些函数存在是为了允许应用抽取与错误情况相关的数据库对象名，而不需要检查可能已被本地化的错误消息文本。这些函数应该被用在应用需要对其进行自动错误处理的错误报告中。从PostgreSQL 9.3 开始，完整的覆盖只为 SQLSTATE 类别 23 中的错误存在（完整性约束违背），但是在未来这些很可能会被扩展。
有一个还在大量使用的旧的函数elog。一个elog调用：
elog(level, "format string", ...);
完全等效于：
ereport(level, errmsg_internal("format string", ...));
注意 SQLSTATE 错误代码总是被给予默认值，并且消息字符串不受翻译影响。因此，elog应该只被用于内部错误和低层次的调试日志。任何普通用户感兴趣的消息应该通过ereport。不管怎样，在仍广泛使用elog的系统中，有足够多的内部“不可能发生”的错误检查，出于记号简洁的目的这更适合于那些消息。
有关编写好的错误消息的建议可见第 55.3 节。
[18]
也就是说，该值是到达ereport调用时的当前值，在辅助报告例程内errno的改变不会影响它。但如果你在errmsg的参数列表中显式地写了strerror(errno)则不是这样，因此不要那样做。
上一页 上一级 下一页55.1. 格式化 起始页 55.3. 错误消息风格指南
