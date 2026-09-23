# PREPARE

PREPARE
版本：
纠错本页面
搜索
目录导航
❮
❯
PREPAREPREPARE — 准备一个语句以供执行大纲
PREPARE prepared_name FROM string
描述
PREPARE将一个作为字符串动态指定的语句准备好执行。这不同于直接的 SQL 语句PREPARE（也可以用于嵌入式程序）。EXECUTE命令用于执行两种类型的预备语句。
参数prepared_name #
预备查询的一个标识符。
string #
一个文字字符串或一个主机变量，包含一个可预备的
SQL 语句，可能是 SELECT、INSERT、UPDATE 或 DELETE 之一。
对于执行时提供的参数值，使用问号(?)。
备注
在典型用法中，string 是对包含动态构造
SQL 语句的字符串的主机变量引用。文字字符串的情况不是很有用；
你也可以写一条直接 SQL PREPARE 语句。
如果你使用文字字符串，请注意任何你可能希望在 SQL 语句中
包括的双引号必须写为八进制转义(\042)，
而不是通常的 C 惯用法\"。这是因为字符串在
EXEC SQL 段里面，所以 ECPG 语法分析器根据
SQL 规则而不是 C 规则来解析它。任何内嵌的反斜杠后续将按照
C 规则处理；但是 \" 会造成直接语法错误，
因为它被视为文字的终结。
示例
char *stmt = "SELECT * FROM test1 WHERE a = ? AND b = ?";
EXEC SQL ALLOCATE DESCRIPTOR outdesc;
EXEC SQL PREPARE foo FROM :stmt;
EXEC SQL EXECUTE foo USING SQL DESCRIPTOR indesc INTO SQL DESCRIPTOR outdesc;
兼容性
SQL 标准中说明了PREPARE。
另请参阅EXECUTE上一页 上一级 下一页OPEN 起始页 SET AUTOCOMMIT
