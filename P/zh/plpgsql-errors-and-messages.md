# 41.9. 错误和消息

41.9. 错误和消息
版本：
纠错本页面
搜索
目录导航
❮
❯
41.9. 错误和消息 #41.9.1. 报告错误和消息41.9.2. 检查断言41.9.1. 报告错误和消息 #
使用 RAISE 语句报告消息和
引发错误。
RAISE [ level ] 'format' [, expression [, ... ]] [ USING option { = | := } expression [, ... ] ];
RAISE [ level ] condition_name [ USING option { = | := } expression [, ... ] ];
RAISE [ level ] SQLSTATE 'sqlstate' [ USING option { = | := } expression [, ... ] ];
RAISE [ level ] USING option { = | := } expression [, ... ];
RAISE ;
level 选项指定
错误严重性。允许的级别有 DEBUG,
LOG, INFO,
NOTICE, WARNING,
和 EXCEPTION，其中 EXCEPTION
是默认值。
EXCEPTION 引发错误（通常会中止当前事务）；其他级别仅生成不同
优先级级别的消息。
是否将特定优先级的消息报告给客户端，
写入服务器日志，或两者兼而有之由
log_min_messages 和
client_min_messages 配置
变量控制。有关更多信息，请参见 第 19 章。
在第一个语法变体中，
在 level 后（如果有），
写一个 format 字符串
（必须是简单的字符串文字，而不是表达式）。
格式字符串指定要报告的错误消息文本。
格式字符串后可以跟可选的参数表达式，以插入到消息中。
在格式字符串中，% 被替换为
下一个可选参数的值的字符串表示。写
%% 以发出字面量 %。
参数的数量必须与格式字符串中的 %
占位符的数量匹配，否则在函数编译期间会引发错误。
在这个例子中，v_job_id的值将替换字符串中的%：
RAISE NOTICE 'Calling cs_create_job(%)', v_job_id;
在第二和第三个语法变体中，
condition_name 和
sqlstate 分别指定
错误条件名称或五个字符的 SQLSTATE 代码。
有效的错误条件名称和预定义的 SQLSTATE 代码请参见 附录 A。
这里是 condition_name
和 sqlstate 使用的示例：
RAISE division_by_zero;
RAISE WARNING SQLSTATE '22012';
在这些语法变体中，
你可以通过写 USING 后跟 option = expression 项来附加额外信息到错误报告中。
每个 expression 可以是任何
字符串值表达式。允许的 option 关键字有：
MESSAGE #设置错误消息文本。此选项不能在第一个语法变体中使用，因为消息已经提供。DETAIL #提供错误详细消息。HINT #提供提示消息。ERRCODE #指定要报告的错误代码（SQLSTATE），可以通过条件
名称，如 附录 A 中所示，或直接作为五个字符的 SQLSTATE 代码。
此选项不能在第二或第三个语法变体中使用，因为错误代码已经提供。COLUMNCONSTRAINTDATATYPETABLESCHEMA #提供相关对象的名称。
这个例子将用给定的错误消息和提示中止事务：
RAISE EXCEPTION 'Nonexistent ID --> %', user_id
USING HINT = 'Please check your user ID';
这两个示例展示了设置 SQLSTATE 的等效方法：
RAISE 'Duplicate user ID: %', user_id USING ERRCODE = 'unique_violation';
RAISE 'Duplicate user ID: %', user_id USING ERRCODE = '23505';
另一种产生相同结果的方法是：
RAISE unique_violation USING MESSAGE = 'Duplicate user ID: ' || user_id;
如第四个语法变体所示，也可以写 RAISE USING 或 RAISE
level USING，并将
其他所有内容放入 USING 列表中。
RAISE的最后一种变体根本没有参数。这种形式只能被用在一个BEGIN块的EXCEPTION子句中，它导致当前正在被处理的错误被重新抛出。
注意
在PostgreSQL 9.1 之前，没有参数的RAISE被解释为重新抛出来自包含活动异常处理器的块的错误。因此一个嵌套在那个处理器中的EXCEPTION子句无法捕捉它，即使RAISE位于嵌套EXCEPTION子句的块中也是这样。这种行为很奇怪，也并不兼容 Oracle 的 PL/SQL。
如果在RAISE EXCEPTION命令中没有指定条件名称或SQLSTATE，
则默认使用raise_exception (P0001)。
如果没有指定消息文本，则默认使用条件名称或SQLSTATE作为消息文本。
注意
当用 SQLSTATE 代码指定一个错误代码时，你不会受到预定义错误代码的限制，而是可以选择任何由五位以及大写 ASCII 字母构成的错误代码，只有00000不能使用。我们推荐尽量避免抛出以三个零结尾的错误代码，因为这些是分类代码并且只能用来捕获整个类别。
41.9.2. 检查断言 #
ASSERT语句是一种向
PL/pgSQL函数中插入调试检查的方便方法。
ASSERT condition [ , message ];
condition是一个布尔
表达式，它被期望总是计算为真。如果确实如此，
ASSERT语句不会再做什么。但如果结果是假
或者空，那么将发生一个ASSERT_FAILURE异常（如果在计算
condition时发生错误，
它会被报告为一个普通错误）。
如果提供了可选的message，
它是一个结果（如果非空）被用来替换默认错误消息文本
“assertion failed”的表达式（如果
condition失败）。
message表达式在
断言成功的普通情况下不会被计算。
通过配置参数plpgsql.check_asserts可以启用或禁用断言测试，
这个参数接受布尔值且默认为on。如果这个参数为off，
则ASSERT语句什么也不做。
注意ASSERT是为了检测程序的 bug，而不是
报告普通的错误情况。如果要报告普通错误，请使用前面介绍的
RAISE语句。
上一页 上一级 下一页41.8. 事务管理 起始页 41.10. 触发器函数
