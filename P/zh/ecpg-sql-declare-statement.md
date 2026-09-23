# DECLARE STATEMENT

DECLARE STATEMENT
版本：
纠错本页面
搜索
目录导航
❮
❯
DECLARE STATEMENTDECLARE STATEMENT — 声明 SQL 语句标识符大纲
EXEC SQL [ AT connection_name ] DECLARE statement_name STATEMENT
描述
DECLARE STATEMENT 声明一个SQL语句标识符。
SQL语句标识符可以被关联到连接。
当标识符被动态SQL语句使用，该语句使用关联连接执行。
声明的名字空间是预编译单元，到相同SQL语句标识符的多个声明是不被允许的。
注意如果预编译运行在Informix兼容模式并且一些SQL语句被声明，"database"不能被用于作为游标名称。
参数connection_name #
由 CONNECT 命令建立的数据库连接名称。
AT 子句可以省略，但是这样的语句没有意义。
statement_name #
SQL语句标识符，可以是SQL标识符或者主机变量。
Notes
这个关联只在声明物理放置在动态语句顶部时生效。
示例
EXEC SQL CONNECT TO postgres AS con1;
EXEC SQL AT con1 DECLARE sql_stmt STATEMENT;
EXEC SQL DECLARE cursor_name CURSOR FOR sql_stmt;
EXEC SQL PREPARE sql_stmt FROM :dyn_string;
EXEC SQL OPEN cursor_name;
EXEC SQL FETCH cursor_name INTO :column1;
EXEC SQL CLOSE cursor_name;
兼容性
DECLARE STATEMENT是SQL标准的扩展，但可以在著名的DBMS中使用。
另请参阅CONNECT, DECLARE, OPEN上一页 上一级 下一页DECLARE 起始页 DESCRIBE
