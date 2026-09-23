# 34.5. 动态 SQL

34.5. 动态 SQL
版本：
纠错本页面
搜索
目录导航
❮
❯
34.5. 动态 SQL #34.5.1. 执行没有结果集的语句34.5.2. 执行一个有输入参数的语句34.5.3. 执行一个有结果集的语句
在很多情况下，一个应用必须要执行的特定 SQL 语句在编写该应用时就已知。不过在某些情况下，SQL 语句在运行时构造或者由一个外部来源提供。这样你就不能直接把 SQL 语句嵌入到 C 源代码，不过有一种功能允许你调用在一个字符串变量中提供的任意 SQL 语句。
34.5.1. 执行没有结果集的语句 #
执行一个任意 SQL 语句的最简单方法是使用命令EXECUTE IMMEDIATE。例如：
EXEC SQL BEGIN DECLARE SECTION;
const char *stmt = "CREATE TABLE test1 (...);";
EXEC SQL END DECLARE SECTION;
EXEC SQL EXECUTE IMMEDIATE :stmt;
EXECUTE IMMEDIATE可以用于不返回结果集的 SQL 语句（例如 DDL、INSERT、UPDATE、DELETE）。你不能用这种方法执行检索数据的语句（例如SELECT）。下一节将描述如何执行这种语句。
34.5.2. 执行一个有输入参数的语句 #
执行任意 SQL 语句的一种更强大的方法是准备它们一次并且在每次需要时执行该预备语句。也可以准备一个一般化的语句，然后通过替换参数执行它的特定版本。在准备语句时，在你想要稍后替换参数的地方写上问号。例如：
EXEC SQL BEGIN DECLARE SECTION;
const char *stmt = "INSERT INTO test1 VALUES(?, ?);";
EXEC SQL END DECLARE SECTION;
EXEC SQL PREPARE mystmt FROM :stmt;
...
EXEC SQL EXECUTE mystmt USING 42, 'foobar';
当你不再需要该预备语句时，你应该释放它：
EXEC SQL DEALLOCATE PREPARE name;
34.5.3. 执行一个有结果集的语句 #
要执行一个只有单一结果行的 SQL 语句，可以使用EXECUTE。要保存结果，在其中增加一个INTO子句。
EXEC SQL BEGIN DECLARE SECTION;
const char *stmt = "SELECT a, b, c FROM test1 WHERE a > ?";
int v1, v2;
VARCHAR v3[50];
EXEC SQL END DECLARE SECTION;
EXEC SQL PREPARE mystmt FROM :stmt;
...
EXEC SQL EXECUTE mystmt INTO :v1, :v2, :v3 USING 37;
一个EXECUTE命令可以有一个INTO子句、一个USING子句，可以同时有这两个子句，也可以不带这两个子句。
如果一个查询被期望返回多于一个结果行，应该如下列例子所示使用一个游标（关于游标详见第 34.3.2 节）。
EXEC SQL BEGIN DECLARE SECTION;
char dbaname[128];
char datname[128];
char *stmt = "SELECT u.usename as dbaname, d.datname "
"  FROM pg_database d, pg_user u "
"  WHERE d.datdba = u.usesysid";
EXEC SQL END DECLARE SECTION;
EXEC SQL CONNECT TO testdb AS con1 USER testuser;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL PREPARE stmt1 FROM :stmt;
EXEC SQL DECLARE cursor1 CURSOR FOR stmt1;
EXEC SQL OPEN cursor1;
EXEC SQL WHENEVER NOT FOUND DO BREAK;
while (1)
{
EXEC SQL FETCH cursor1 INTO :dbaname,:datname;
printf("dbaname=%s, datname=%s\n", dbaname, datname);
}
EXEC SQL CLOSE cursor1;
EXEC SQL COMMIT;
EXEC SQL DISCONNECT ALL;
上一页 上一级 下一页34.4. 使用主变量 起始页 34.6. pgtypes 库
