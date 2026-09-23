# DECLARE

DECLARE
版本：
纠错本页面
搜索
目录导航
❮
❯
DECLAREDECLARE — 定义一个游标大纲
DECLARE cursor_name [ BINARY ] [ ASENSITIVE | INSENSITIVE ] [ [ NO ] SCROLL ] CURSOR [ { WITH | WITHOUT } HOLD ] FOR prepared_name
DECLARE cursor_name [ BINARY ] [ ASENSITIVE | INSENSITIVE ] [ [ NO ] SCROLL ] CURSOR [ { WITH | WITHOUT } HOLD ] FOR query
描述
DECLARE声明一个游标用来在一个预备语句的结果集上迭代。这个命令与直接的 SQL 命令DECLARE在语义上有一点点区别：后者会执行一个查询并且准备结果集用于检索，而这个嵌入式 SQL 命令仅仅声明一个名称作为“循环变量”用于在一个查询的结果集上迭代，实际的执行在游标被OPEN命令打开时才发生。
参数cursor_name #
一个游标名称，大小写敏感。这可以是一个 SQL 标识符或者一个主机变量。
prepared_name #
一个预备查询的名称，可以是一个 SQL 标识符或者一个主机变量。
query #
一个SELECT或者VALUES命令，它将提供游标要返回的行。
游标选项的含义请见DECLARE。
示例
为一个查询声明游标的示例：
EXEC SQL DECLARE C CURSOR FOR SELECT * FROM My_Table;
EXEC SQL DECLARE C CURSOR FOR SELECT Item1 FROM T;
EXEC SQL DECLARE cur1 CURSOR FOR SELECT version();
为一个预处理语句声明游标的示例：
EXEC SQL PREPARE stmt1 AS SELECT version();
EXEC SQL DECLARE cur1 CURSOR FOR stmt1;
兼容性
SQL 标准中规定了DECLARE。
另请参阅OPEN, CLOSE, DECLARE上一页 上一级 下一页DEALLOCATE DESCRIPTOR 起始页 DECLARE STATEMENT
