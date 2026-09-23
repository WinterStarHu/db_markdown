# 41.4. 表达式

41.4. 表达式
版本：
纠错本页面
搜索
目录导航
❮
❯
41.4. 表达式 #
PL/pgSQL语句中用到的所有表达式会被服务器的主SQL执行器处理。例如，当你写一个这样的PL/pgSQL语句时
IF expression THEN ...
PL/pgSQL将通过给主 SQL 引擎发送一个查询
SELECT expression
来计算该表达式。如第 41.11.1 节中所详细讨论的，在构造该SELECT命令时，PL/pgSQL变量名的每一次出现会被查询参数所替换。这允许SELECT的查询计划仅被准备一次并且被重用于之后的对于该变量不同值的计算。因此，在一个表达式第一次被使用时实际发生的本质上是一个PREPARE命令。例如，如果我们已经声明了两个整数变量x和y，并且我们写了
IF x < y THEN ...
在现象之后发生的等效于
PREPARE statement_name(integer, integer) AS SELECT $1 < $2;
并且然后为每一次IF语句的执行，这个预备语句都会被EXECUTE，执行时使用变量的当前值作为参数值。通常这些细节对于一个PL/pgSQL用户并不重要，但是在尝试诊断一个问题时了解它们很有用。更多信息可见第 41.11.2 节。
因为一个 expression 可以被转换成
SELECT 命令，它可以包含与普通SELECT命令相同的子句，但是，它不能包含顶级UNION，INTERSECT， 或者 EXCEPT子句。例如，您可以检查表是否非空：
IF count(*) > 0 FROM my_table THEN ...
因为在 IF 和 THEN之间的expression被解析为  SELECT count(*) > 0 FROM my_table。
SELECT 必须生成一个单列，不能超过一行。 (如果没有行数据返回， 结果为NULL。)
上一页 上一级 下一页41.3. 声明 起始页 41.5. 基本语句
