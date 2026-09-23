# 42.10. 事务管理

42.10. 事务管理
版本：
纠错本页面
搜索
目录导航
❮
❯
42.10. 事务管理 #
在从顶层调用的过程中或者从顶层调用的匿名代码块（DO命令）中，可以控制事务。要提交当前的事务，可调用commit。要回滚当前事务，可调用rollback（注意不能通过spi_exec或类似的函数运行SQL命令COMMIT或者ROLLBACK。这类工作必须用这些函数完成）。在事务结束以后，一个新的事务会自动开始，因此没有独立的函数用来开始新事务。
这里是一个例子：
CREATE PROCEDURE transaction_test1()
LANGUAGE pltcl
AS $$
for {set i 0} {$i < 10} {incr i} {
spi_exec "INSERT INTO test1 (a) VALUES ($i)"
if {$i % 2 == 0} {
commit
} else {
rollback
}
}
$$;
CALL transaction_test1();
当一个显式的子事务处于活跃状态时，事务不能被结束。
上一页 上一级 下一页42.9. PL/Tcl 中的显式子事务 起始页 42.11. PL/Tcl配置
