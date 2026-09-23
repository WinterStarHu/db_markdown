# 41.8. 事务管理

41.8. 事务管理
版本：
纠错本页面
搜索
目录导航
❮
❯
41.8. 事务管理 #
在由CALL命令调用的过程中以及匿名代码块（DO命令）中，可以用命令COMMIT和ROLLBACK结束事务。在一个事务被使用这些命令结束后，一个新的事务会被自动开始，因此没有单独的START TRANSACTION命令（注意BEGIN和END在PL/pgSQL中有不同的含义）。
这里是一个简单的例子：
CREATE PROCEDURE transaction_test1()
LANGUAGE plpgsql
AS $$
BEGIN
FOR i IN 0..9 LOOP
INSERT INTO test1 (a) VALUES (i);
IF i % 2 = 0 THEN
COMMIT;
ELSE
ROLLBACK;
END IF;
END LOOP;
END;
$$;
CALL transaction_test1();
新事务开始时具有默认事务特征，如事务隔离级别。在循环中提交事务的情况下，可能需要以与前一个事务相同的特征来自动启动新事务。
命令COMMIT AND CHAIN和ROLLBACK AND CHAIN可以完成此操作。
只有在从顶层调用的CALL或DO中才能进行事务控制，在没有任何其他中间命令的嵌套CALL或DO调用中也能进行事务控制。例如，如果调用栈是CALL proc1() → CALL proc2() → CALL proc3()，那么第二个和第三个过程可以执行事务控制动作。但是如果调用栈是CALL proc1() → SELECT func2() → CALL proc3()，则最后一个过程不能做事务控制，因为中间有SELECT。
PL/pgSQL 不支持保存点
(SAVEPOINT/ROLLBACK TO
SAVEPOINT/RELEASE SAVEPOINT 命令)。
保存点的典型使用模式可以被带有异常处理程序的块替代（参见
第 41.6.8 节）。
在底层，带有异常处理程序的块形成一个子事务，这意味着事务不能在
这样的块内结束。
对游标循环有特殊考虑。考虑这个例子：
CREATE PROCEDURE transaction_test2()
LANGUAGE plpgsql
AS $$
DECLARE
r RECORD;
BEGIN
FOR r IN SELECT * FROM test2 ORDER BY x LOOP
INSERT INTO test1 (a) VALUES (r.x);
COMMIT;
END LOOP;
END;
$$;
CALL transaction_test2();
通常，游标会在事务提交时自动关闭。然而，像这样作为循环一部分创建的游标，
会在第一次COMMIT或ROLLBACK时自动转换为可保持的游标。
这意味着游标会在第一次COMMIT或ROLLBACK时被完全评估，
而不是逐行评估。游标仍会在循环结束后自动移除，所以这对用户来说大多是透明的。
但必须记住，游标查询所持有的任何表或行锁，在第一次COMMIT或
ROLLBACK后将不再保持。
有非只读命令（UPDATE ... RETURNING）驱动的游标循环中不允许有事务命令。
上一页 上一级 下一页41.7. 游标 起始页 41.9. 错误和消息
