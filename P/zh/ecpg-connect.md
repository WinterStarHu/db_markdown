# 34.2. 管理数据库连接

34.2. 管理数据库连接
版本：
纠错本页面
搜索
目录导航
❮
❯
34.2. 管理数据库连接 #34.2.1. 连接到数据库服务器34.2.2. 选择一个连接34.2.3. 关闭一个连接
本节描述如何打开、关闭以及切换数据库连接。
34.2.1. 连接到数据库服务器 #
我们可以使用下列语句连接到一个数据库：
EXEC SQL CONNECT TO target [AS connection-name] [USER user-name];
target可以用下列方法指定：
dbname[@hostname][:port]
tcp:postgresql://hostname[:port][/dbname][?options]
unix:postgresql://localhost[:port][/dbname][?options]
一个包含上述形式之一的 SQL 字符串
到一个包含上述形式之一（参见例子）的字符变量的引用
DEFAULT
连接目标DEFAULT会以默认用户名发起一个到默认数据库的连接。在这种情况下，不能指定单独的用户名或连接名。
如果你直接指定了连接目标(也就是说，不是字符串或变量引用)，则目标的内容传递到常规SQL语法解析；
这意味着，例如，hostname必须看起来像一个或多个由点分开的SQL标识符，并且除非被双引号括住，那些标识符将是小写的。
任何options的值必须是SQL标识符，整数，或变量引用。
当然，你可以用双引号把几乎任何内容放到SQL标识符中。
实际上，使用字符串(单引号)或变量引用可能比直接写入连接目标更不容易出错。
也有不同的方法来指定用户名：
username
username/password
username IDENTIFIED BY password
username USING password
如上所述，参数username以及password可以是一个SQL标识符、一个SQL字符串或者一个对字符变量的引用。
如果连接目标包含任何options，
这些由keyword=value组成的规范，由表示“和”的符号(&)分隔。
允许的关键字与libpq识别的关键字相同(参见第 32.1.2 节)。
在任何keyword或value之前的空格将被忽略，但其中或之后则不会。
请注意，无法将&写入value。
注意当指定套接字连接(具有unix:前缀)，主机名必须是精确的localhost。
要选择一个非默认套接字目录，写目录的路径名作为host选项的值，在目标的options部分。
connection-name被用来在一个程序中处理多个连接。如果一个程序只使用一个连接，它可以被忽略。最近被打开的连接将成为当前连接，当一个SQL语句要被执行时，将默认使用它（见这一章稍后的部分）。
这里有一些CONNECT语句的例子：
EXEC SQL CONNECT TO mydb@sql.mydomain.com;
EXEC SQL CONNECT TO tcp:postgresql://sql.mydomain.com/mydb AS myconnection USER john;
EXEC SQL BEGIN DECLARE SECTION;
const char *target = "mydb@sql.mydomain.com";
const char *user = "john";
const char *passwd = "secret";
EXEC SQL END DECLARE SECTION;
...
EXEC SQL CONNECT TO :target USER :user USING :passwd;
/* 或 EXEC SQL CONNECT TO :target USER :user/:passwd; */
最后一种示例利用被上文称为字符变量引用的特性。你将在后面的小节中看到当你把C变量前放上一个冒号时，它们是怎样被用于SQL语句的。
注意连接目标的格式没有在SQL标准中说明。因此如果你想要开发可移植的应用，你可能想要使用某种基于上述最后一个例子的方法来把连接目标字符串封装在某个地方。
如果不受信任的用户访问没有采用安全模式使用模式的数据库，通过从search_path中删除公共可写模式来开始每个会话。
例如，添加options=-c search_path=到options，或在连接后发出EXEC SQL SELECT pg_catalog.set_config('search_path', '', false);。
这种考虑并不特定于ECPG;它适用于执行任意SQL命令的每个接口。
34.2.2. 选择一个连接 #
嵌入式 SQL 程序中的 SQL 语句默认是在当前连接（也就是最近打开的那一个）上执行的。如果一个应用需要管理多个连接，那么有三种方法来处理这种需求。
第一个选项是显式地为每一个 SQL 语句选择一个连接，例如：
EXEC SQL AT connection-name SELECT ...;
如果应用需要以混合的顺序使用多个连接，这个选项特别合适。
如果你的应用使用多个线程执行，它们不能并发地共享一个连接。你必须显式地控制对连接的访问（使用互斥量）或者为每个线程使用一个连接。
第二个选项是执行一个语句来切换当前的连接。该语句是：
EXEC SQL SET CONNECTION connection-name;
如果很多语句要在同一个连接上执行，这个选项特别方便。
这里有一个管理多个数据库连接的例子程序：
#include <stdio.h>
EXEC SQL BEGIN DECLARE SECTION;
char dbname[1024];
EXEC SQL END DECLARE SECTION;
int
main()
{
EXEC SQL CONNECT TO testdb1 AS con1 USER testuser;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL CONNECT TO testdb2 AS con2 USER testuser;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
EXEC SQL CONNECT TO testdb3 AS con3 USER testuser;
EXEC SQL SELECT pg_catalog.set_config('search_path', '', false); EXEC SQL COMMIT;
/* 这个查询将在最近打开的数据库 "testdb3" 中执行 */
EXEC SQL SELECT current_database() INTO :dbname;
printf("current=%s (should be testdb3)\n", dbname);
/* 使用 "AT" 在 "testdb2" 中运行一个查询 */
EXEC SQL AT con2 SELECT current_database() INTO :dbname;
printf("current=%s (should be testdb2)\n", dbname);
/* 切换当前连接到 "testdb1" */
EXEC SQL SET CONNECTION con1;
EXEC SQL SELECT current_database() INTO :dbname;
printf("current=%s (should be testdb1)\n", dbname);
EXEC SQL DISCONNECT ALL;
return 0;
}
这个例子将产生这样的输出：
current=testdb3 (should be testdb3)
current=testdb2 (should be testdb2)
current=testdb1 (should be testdb1)
第三个选项是声明一个 SQL 标识符链接到连接，例如：
EXEC SQL AT connection-name DECLARE statement-name STATEMENT;
EXEC SQL PREPARE statement-name FROM :dyn-string;
当你链接一个 SQL 标识符到连接时，你可以在不使用 AT 子句的情况下执行动态 SQL。注意这个选项的行为像预处理器指令，因此链接仅在文件中启用。
这里是一个使用这个选项的示例程序：
#include <stdio.h>
EXEC SQL BEGIN DECLARE SECTION;
char dbname[128];
char *dyn_sql = "SELECT current_database()";
EXEC SQL END DECLARE SECTION;
int main(){
EXEC SQL CONNECT TO postgres AS con1;
EXEC SQL CONNECT TO testdb AS con2;
EXEC SQL AT con1 DECLARE stmt STATEMENT;
EXEC SQL PREPARE stmt FROM :dyn_sql;
EXEC SQL EXECUTE stmt INTO :dbname;
printf("%s\n", dbname);
EXEC SQL DISCONNECT ALL;
return 0;
}
这个示例会产生这个输出，即使默认的连接是 testdb：
postgres
34.2.3. 关闭一个连接 #
要关闭连接，请使用以下语句：
EXEC SQL DISCONNECT [connection];
connection可以通过以下方式指定：
connection-name
CURRENT
ALL
如果未指定连接名称，则关闭当前连接。
在一个应用中总是显式地从它打开的每个连接断开是一种好的风格。
上一页 上一级 下一页34.1. 概念 起始页 34.3. 运行 SQL 命令
