# 34.3. 运行 SQL 命令

34.3. 运行 SQL 命令
版本：
纠错本页面
搜索
目录导航
❮
❯
34.3. 运行 SQL 命令 #34.3.1. 执行 SQL 语句34.3.2. 使用游标34.3.3. 管理事务34.3.4. 预处理语句
任何 SQL 命令都可以在一个嵌入式 SQL 应用中运行。下面是一些如何在嵌入式 SQL 应用中运行 SQL 命令的例子。
34.3.1. 执行 SQL 语句 #
创建一个表：
EXEC SQL CREATE TABLE foo (number integer, ascii char(16));
EXEC SQL CREATE UNIQUE INDEX num1 ON foo(number);
EXEC SQL COMMIT;
插入行：
EXEC SQL INSERT INTO foo (number, ascii) VALUES (9999, 'doodad');
EXEC SQL COMMIT;
删除行：
EXEC SQL DELETE FROM foo WHERE number = 9999;
EXEC SQL COMMIT;
更新：
EXEC SQL UPDATE foo
SET ascii = 'foobar'
WHERE number = 9999;
EXEC SQL COMMIT;
返回一个单一结果行的SELECT语句也可以直接使用EXEC SQL执行。要处理有多行的结果集，一个应用必须使用一个游标，可参考下面的第 34.3.2 节（作为一种特殊情况，一个应用可以一次取出多行到一个数组主变量中，参考第 34.4.4.3.1 节）。
单行选择：
EXEC SQL SELECT foo INTO :FooBar FROM table1 WHERE ascii = 'doodad';
还有，一个配置参数可以用SHOW命令检索：
EXEC SQL SHOW search_path INTO :var;
:something形式的记号是主变量，即它们指向 C 程序中的变量。它们在第 34.4 节中解释。
34.3.2. 使用游标 #
要检索一个包含多行的结果集，一个应用必须声明一个游标并从该游标中获取每一行。使用一个游标的步骤如下：声明一个游标、打开它、从该游标获取一行、重复并最终关闭它。
使用游标选择：
EXEC SQL DECLARE foo_bar CURSOR FOR
SELECT number, ascii FROM foo
ORDER BY ascii;
EXEC SQL OPEN foo_bar;
EXEC SQL FETCH foo_bar INTO :FooBar, DooDad;
...
EXEC SQL CLOSE foo_bar;
EXEC SQL COMMIT;
有关声明游标的更多细节，可参考DECLARE；关于从游标中获取行的更多细节，参见FETCH。
注意
ECPG DECLARE命令实际上不会导致一个语句被发送到 PostgreSQL 后端。在OPEN命令被执行时，游标会在后端被打开（使用后端的DECLARE命令）。
34.3.3. 管理事务 #
在默认模式中，只有当EXEC SQL COMMIT被发出时才会提交命令。嵌入式 SQL 接口也通过ecpg的-t命令行选项（见ecpg）或者通过EXEC SQL SET AUTOCOMMIT TO ON语句支持事务的自动提交（类似于psql的默认行为）。在自动提交模式中，除非位于一个显式事务块内，每一个命令都会被自动提交。这种模式可以使用EXEC SQL SET AUTOCOMMIT TO OFF显式地关闭。
以下是可用的事务管理命令：
EXEC SQL COMMIT #
提交一个正在进行的事务。
EXEC SQL ROLLBACK #
回滚一个正在进行的事务。
EXEC SQL PREPARE TRANSACTION transaction_id #
准备当前事务以进行两阶段提交。
EXEC SQL COMMIT PREPARED transaction_id #
提交一个处于已准备状态的事务。
EXEC SQL ROLLBACK PREPARED transaction_id #
回滚一个处于已准备状态的事务。
EXEC SQL SET AUTOCOMMIT TO ON #
启用自动提交模式。
EXEC SQL SET AUTOCOMMIT TO OFF #
禁用自动提交模式。这是默认设置。
34.3.4. 预处理语句 #
当传递给 SQL 语句的值在编译时未知或者同一个语句要被使用多次时，那么预处理语句就有用武之地了。
语句使用命令PREPARE进行预备。对于还未知的值，使用占位符“?”：
EXEC SQL PREPARE stmt1 FROM "SELECT oid, datname FROM pg_database WHERE oid = ?";
如果一个语句返回一行，应用可以在PREPARE之后调用EXECUTE来执行该语句，同时要用一个USING子句为占位符提供真实的值：
EXEC SQL EXECUTE stmt1 INTO :dboid, :dbname USING 1;
如果一个语句返回多行，应用可以使用一个基于该预备语句声明的游标。要绑定输入参数，该游标必须用一个USING子句打开：
EXEC SQL PREPARE stmt1 FROM "SELECT oid,datname FROM pg_database WHERE oid > ?";
EXEC SQL DECLARE foo_bar CURSOR FOR stmt1;
/* 当到达结果集末尾时，跳出 while 循环 */
EXEC SQL WHENEVER NOT FOUND DO BREAK;
EXEC SQL OPEN foo_bar USING 100;
...
while (1)
{
EXEC SQL FETCH NEXT FROM foo_bar INTO :dboid, :dbname;
...
}
EXEC SQL CLOSE foo_bar;
当你不再需要该预备语句时，你应该释放它：
EXEC SQL DEALLOCATE PREPARE name;
更多有关PREPARE的细节，可参考PREPARE。关于使用占位符和输入参数的细节，可参考第 34.5 节。
上一页 上一级 下一页34.2. 管理数据库连接 起始页 34.4. 使用主变量
