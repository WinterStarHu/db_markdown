# 44.8. 事务管理

44.8. 事务管理
版本：
纠错本页面
搜索
目录导航
❮
❯
44.8. 事务管理 #
在从顶层调用的过程中或者从顶层调用的匿名代码块（DO命令）中，可以控制事务。要提交当前的事务，可调用plpy.commit()。要回滚当前事务，可调用plpy.rollback()（注意不能通过plpy.execute或类似的函数运行SQL命令COMMIT或者ROLLBACK。这类工作必须用这些函数完成）。在事务结束以后，一个新的事务会自动开始，因此没有独立的函数用来开始新事务。
这里是一个示例：
CREATE PROCEDURE transaction_test1()
LANGUAGE plpython3u
AS $$
for i in range(0, 10):
plpy.execute("INSERT INTO test1 (a) VALUES (%d)" % i)
if i % 2 == 0:
plpy.commit()
else:
plpy.rollback()
$$;
CALL transaction_test1();
当一个显式的子事务处于活跃状态时，事务不能被结束。
上一页 上一级 下一页44.7. 显式子事务 起始页 44.9. 实用函数
