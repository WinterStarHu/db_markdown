# 42.5. 从 PL/Tcl 访问数据库

42.5. 从 PL/Tcl 访问数据库
版本：
纠错本页面
搜索
目录导航
❮
❯
42.5. 从 PL/Tcl 访问数据库 #
在本节中，我们遵循通常的Tcl约定，使用问号而不是方括号来表示语法概要中的可选元素。以下命令可用于从PL/Tcl函数体中访问数据库：
spi_exec ?-count n? ?-array name? command ?loop-body?
执行作为字符串给出的SQL命令。命令中的错误会引发错误。否则，spi_exec的返回值是命令处理的行数（选择、插入、更新或删除），如果命令是实用程序语句，则返回值为零。此外，如果命令是SELECT语句，则所选列的值将按照下面描述的方式放入Tcl变量中。
可选的-count值告诉spi_exec在检索到n行后停止，
就像查询包含LIMIT子句一样。
如果n为零，则查询运行到完成，与省略-count时相同。
如果命令是SELECT语句，则结果列的值将放入以列名命名的Tcl变量中。
如果给定了-array选项，则列值将存储在命名的关联数组的元素中，
列名用作数组索引。此外，结果中的当前行号（从零开始计数）将存储在数组元素中，
该数组元素命名为“.tupno”，除非该名称在结果中用作列名。
如果命令是一个SELECT语句，并且没有给出loop-body
脚本，则只有结果的第一行被存储到Tcl变量或数组元素中；如果有剩余的行，则被忽略。
如果查询没有返回行，则不会发生存储。（可以通过检查spi_exec的结果来检测这种情况。）
例如：
spi_exec "SELECT count(*) AS cnt FROM pg_proc"
将把Tcl变量$cnt设置为pg_proc系统目录中的行数。
如果给定了可选的loop-body参数，它是一段Tcl脚本，对查询结果中的每一行执行一次。
（如果给定的命令不是SELECT，则会忽略loop-body。）
当前行的列的值在每次迭代之前存储到Tcl变量或数组元素中。
例如：
spi_exec -array C "SELECT * FROM pg_class" {
elog DEBUG "have table $C(relname)"
}
将为每一行pg_class打印一个日志消息。这个特性类似于其他Tcl循环结构；特别是continue和break在循环体内部的工作方式与通常相同。
如果查询结果的某一列为空，那么对应的目标变量将被设置为“unset”，而不是被设置。
spi_prepare query typelist
准备并保存查询计划以供以后执行。保存的计划将在当前会话的生命周期内保留。
查询可以使用参数，即值在实际执行计划时提供的占位符。
在查询字符串中，通过符号$1 ... $n引用参数。
如果查询使用参数，则必须将参数类型的名称给出为Tcl列表。
（如果不使用参数，请写一个空列表给typelist。）
spi_prepare的返回值是一个查询ID，用于在后续调用spi_execp时使用。
有关示例，请参见spi_execp。
spi_execp ?-count n? ?-array name? ?-nulls string? queryid ?value-list? ?loop-body?
执行之前使用spi_prepare准备的查询。
queryid是spi_prepare返回的ID。
如果查询引用了参数，则必须提供value-list。
这是参数的实际值的Tcl列表。列表的长度必须与之前提供给spi_prepare的参数类型列表相同。
如果查询没有参数，则省略value-list。
可选值-nulls是由空格和'n'字符组成的字符串，告诉spi_execp哪些参数是空值。
如果提供了，它必须与value-list的长度完全相同。如果没有提供，所有参数值都是非空的。
除了查询及其参数的指定方式外，spi_execp的工作方式与spi_exec相同。
-count，-array和loop-body选项也相同，结果值也相同。
这是一个使用准备计划的PL/Tcl函数的示例：
CREATE FUNCTION t1_count(integer, integer) RETURNS integer AS $$
if {![ info exists GD(plan) ]} {
# prepare the saved plan on the first call
set GD(plan) [ spi_prepare \
"SELECT count(*) AS cnt FROM t1 WHERE num >= \$1 AND num <= \$2" \
[ list int4 int4 ] ]
}
spi_execp -count 1 $GD(plan) [ list $1 $2 ]
return $cnt
$$ LANGUAGE pltcl;
我们需要在传递给spi_prepare的查询字符串中使用反斜杠，
以确保$n标记将原样传递给
spi_prepare，而不会被Tcl变量替换。
subtransaction command
包含在command中的Tcl脚本在SQL子事务中执行。
如果脚本返回错误，整个子事务将被回滚，然后将错误返回给周围的Tcl代码。
有关更多详细信息和示例，请参见第 42.9 节。
quote string
将给定字符串中的所有单引号和反斜杠字符加倍。
这可以用于安全地引用要插入到SQL命令中的字符串，这些SQL命令将传递给spi_exec或spi_prepare。
例如，考虑一个类似于以下的SQL命令字符串：
"SELECT '$val' AS ret"
其中Tcl变量val实际包含doesn't。这将导致最终的命令字符串：
SELECT 'doesn't' AS ret
这将在spi_exec或spi_prepare期间导致解析错误。
为了正常工作，提交的命令应包含：
SELECT 'doesn''t' AS ret
这可以在PL/Tcl中使用以下方式形成：
"SELECT '[ quote $val ]' AS ret"
spi_execp的一个优点是，您不必像这样引用参数值，因为参数永远不会被解析为SQL命令字符串的一部分。
elog level msg
发出日志或错误消息。可能的级别包括
DEBUG，LOG，INFO，
NOTICE，WARNING，ERROR和
FATAL。 ERROR
引发错误条件；如果周围的Tcl代码没有捕获到这个错误，
错误将传播到调用查询，导致当前事务或子事务被中止。这
实际上与Tcl的error命令相同。
FATAL中止事务并导致当前
会话关闭。(在PL/Tcl函数中使用这个错误级别可能没有什么好理由，
但为了完整性而提供。)其他级别只生成不同
优先级的消息。
特定优先级的消息是否报告给客户端，
写入服务器日志，或两者都由
log_min_messages和
client_min_messages配置
变量控制。参见第 19 章
和第 42.8 节
了解更多信息。
上一页 上一级 下一页42.4. PL/Tcl 中的全局数据 起始页 42.6. PL/Tcl 中的触发器函数
