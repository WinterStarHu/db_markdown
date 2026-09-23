# 42.9. PL/Tcl 中的显式子事务

42.9. PL/Tcl 中的显式子事务
版本：
纠错本页面
搜索
目录导航
❮
❯
42.9. PL/Tcl 中的显式子事务 #
从第 42.8 节中介绍的数据库访问导致的错误中恢复可能导致一种不可取的情况，其中一些操作在它们中的一个失败前成功完成，并且在从错误中恢复过来后数据还处于一种不一致的状态。PL/Tcl 以显式子事务的形式为这类问题提供了一个解决方案。
考虑一个在两个账户间实现转账的函数：
CREATE FUNCTION transfer_funds() RETURNS void AS $$
if [catch {
spi_exec "UPDATE accounts SET balance = balance - 100 WHERE account_name = 'joe'"
spi_exec "UPDATE accounts SET balance = balance + 100 WHERE account_name = 'mary'"
} errormsg] {
set result [format "error transferring funds: %s" $errormsg]
} else {
set result "funds transferred successfully"
}
spi_exec "INSERT INTO operations (result) VALUES ('[quote $result]')"
$$ LANGUAGE pltcl;
如果第二个UPDATE语句导致一个异常，这个函数将记下该失败，但是第一个UPDATE的结果将被提交。换句话说，资金将从 Joe 的账户中被取走，但不会被转到 Mary 的账户。这是因为每个spi_exec都是一个单独的子事务，并且那些子事务中只有一个被回滚。
为了处理这类情况，你可以把多个数据库操作包裹在一个显式子事务中，它将作为一个整体成功完成或者回滚。PL/Tcl提供了一个subtransaction命令来做这件事情。我们可以把我们的函数写成：
CREATE FUNCTION transfer_funds2() RETURNS void AS $$
if [catch {
subtransaction {
spi_exec "UPDATE accounts SET balance = balance - 100 WHERE account_name = 'joe'"
spi_exec "UPDATE accounts SET balance = balance + 100 WHERE account_name = 'mary'"
}
} errormsg] {
set result [format "error transferring funds: %s" $errormsg]
} else {
set result "funds transferred successfully"
}
spi_exec "INSERT INTO operations (result) VALUES ('[quote $result]')"
$$ LANGUAGE pltcl;
注意，为了实现这个目的仍要求使用catch。否则错误将传播到该函数的顶层，导致想要对operations表的插入被阻止。subtransaction命令不会捕捉错误，它仅确保报告错误时在其范围内执行的所有数据库操作将被一起回滚。
一个显式子事务的回滚发生在包含它的Tcl代码报告任何错误时，而不仅仅是数据库访问导致的错误。因此一个subtransaction命令中发生的常规Tcl异常也将导致该子事务被回滚。不过，无错误退出到包含子事务的Tcl代码外面（例如，由于return）不会导致回滚。
上一页 上一级 下一页42.8. PL/Tcl 中的错误处理 起始页 42.10. 事务管理
