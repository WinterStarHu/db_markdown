# 44.7. 显式子事务

44.7. 显式子事务
版本：
纠错本页面
搜索
目录导航
❮
❯
44.7. 显式子事务 #44.7.1. 子事务上下文管理器
按第 44.6.2 节中所述的从数据库访问导致的错误中恢复可能导致不良情况：某些操作在其中一个操作失败之前已经成功，并且在从错误中恢复后这些操作的数据形成了一种不一致的状态。PL/Python 通过显式子事务的形式为这种问题提供了一套解决方案。
44.7.1. 子事务上下文管理器 #
考虑一个实现两个账户之间转账的函数：
CREATE FUNCTION transfer_funds() RETURNS void AS $$
try:
plpy.execute("UPDATE accounts SET balance = balance - 100 WHERE account_name = 'joe'")
plpy.execute("UPDATE accounts SET balance = balance + 100 WHERE account_name = 'mary'")
except plpy.SPIError as e:
result = "error transferring funds: %s" % e.args
else:
result = "funds transferred correctly"
plan = plpy.prepare("INSERT INTO operations (result) VALUES ($1)", ["text"])
plpy.execute(plan, [result])
$$ LANGUAGE plpython3u;
如果第二个UPDATE语句导致异常被触发，该函数将报告错误，但是第一个UPDATE的结果仍将被提交。
换句话说，资金将从Joe的账户中提取，但不会转账到Mary的账户。
为了避免这种问题，您可以将plpy.execute调用包装在显式子事务中。
plpy模块提供了一个帮助对象来管理显式子事务，该对象通过
plpy.subtransaction()函数创建。
由此函数创建的对象实现了
上下文管理器接口。使用显式子事务，我们可以重写我们的函数如下：
CREATE FUNCTION transfer_funds2() RETURNS void AS $$
try:
with plpy.subtransaction():
plpy.execute("UPDATE accounts SET balance = balance - 100 WHERE account_name = 'joe'")
plpy.execute("UPDATE accounts SET balance = balance + 100 WHERE account_name = 'mary'")
except plpy.SPIError as e:
result = "error transferring funds: %s" % e.args
else:
result = "funds transferred correctly"
plan = plpy.prepare("INSERT INTO operations (result) VALUES ($1)", ["text"])
plpy.execute(plan, [result])
$$ LANGUAGE plpython3u;
请注意，仍然需要使用try/except。
否则，异常将传播到Python堆栈的顶部，并导致整个函数中止，
并显示PostgreSQL错误，因此
operations表将不会插入任何行。
子事务上下文管理器不会捕获错误，它只确保其范围内执行的所有数据库操作
将被原子地提交或回滚。子事务块的回滚发生在任何类型的异常退出时，
不仅仅是由数据库访问引起的错误。在显式子事务块中引发的常规Python异常
也会导致子事务被回滚。
上一页 上一级 下一页44.6. 数据库访问 起始页 44.8. 事务管理
