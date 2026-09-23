# 42.8. PL/Tcl 中的错误处理

42.8. PL/Tcl 中的错误处理
版本：
纠错本页面
搜索
目录导航
❮
❯
42.8. PL/Tcl 中的错误处理 #
PL/Tcl 函数中的 Tcl 代码或者从 PL/Tcl 函数中调用的代码可以抛出一个错误，错误可以由执行某些非法操作产生或者通过使用 Tcl error命令或者 PL/Tcl 的elog命令产生。Tcl 中可以使用 Tcl catch命令捕获这类错误。如果一个错误没有被捕获但是被允许传播到该 PL/Tcl 函数执行的顶层，它会在该函数的调用查询中被报告为一个 SQL 错误。
相反，在 PL/Tcl 的spi_exec、spi_prepare以及spi_execp命令中发生的 SQL 错误会被报告为 Tcl 错误，因此它们也可以被 Tcl 的catch命令捕获（这些 PL/Tcl 命令中的每一个都在一个子事务中运行它的 SQL 操作，该子事务在错误时会被回滚，这样任何部分完成的操作也会被自动清除）。同样地，如果一个错误被传播到顶层而没有被捕获，它会转变成 SQL 错误。
Tcl 提供了一个errorCode变量，它表示有关于一个错误的附加信息，它的格式易于 Tcl 程序解释。该变量的内容符合 Tcl 列表格式，第一个词标识报告该错误的子系统或者库，之后的内容则留给子系统或者库来填充。对于 PL/Tcl 命令报告的数据库错误，第一个词是POSTGRES，第二个词是 PostgreSQL 的版本号，剩下的部分是域名称/域值构成的对，它们提供有关该错误的详细信息。域SQLSTATE、condition以及message总是会被提供（前两个表示附录 A中所示的错误代码和情况名称）。可能出现的域包括
detail、hint、context、
schema、table、column、
datatype、constraint、
statement、cursor_position、
filename、lineno以及
funcname。
使用 PL/Tcl 的errorCode信息的一种便捷方式是把它载入到一个数组中，这样域名称就变成了数组下标。这样做的代码看起来像这样
if {[catch { spi_exec $sql_command }]} {
if {[lindex $::errorCode 0] == "POSTGRES"} {
array set errorArray $::errorCode
if {$errorArray(condition) == "undefined_table"} {
# deal with missing table
} else {
# deal with some other type of SQL error
}
}
}
（双冒号显式地指定errorCode是一个全局变量）。
上一页 上一级 下一页42.7. PL/Tcl 中的事件触发器函数 起始页 42.9. PL/Tcl 中的显式子事务
