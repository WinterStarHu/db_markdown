# OPEN

OPEN
版本：
纠错本页面
搜索
目录导航
❮
❯
OPENOPEN — 打开一个动态游标大纲
OPEN cursor_name
OPEN cursor_name USING value [, ... ]
OPEN cursor_name USING SQL DESCRIPTOR descriptor_name
描述
OPEN 打开一个游标并且可选地绑定
实际值到游标声明中的占位符。该游标必须之前用
DECLARE 命令声明。OPEN 的执行
会导致查询开始在服务器上执行。
参数cursor_name #
要被打开的游标的名称。这可以是一个 SQL
标识符或者一个主机变量。
value #
要被绑定到游标中一个占位符的值。这可以
是一个 SQL 常量、一个主机变量或者一个带有
指示符的主机变量。
descriptor_name #
包含要绑定到游标中占位符的值的描述符的名称。这可以是一个 SQL 标识符或者一个主机变量。
示例
EXEC SQL OPEN a;
EXEC SQL OPEN d USING 1, 'test';
EXEC SQL OPEN c1 USING SQL DESCRIPTOR mydesc;
EXEC SQL OPEN :curname1;
兼容性
OPEN 在 SQL 标准中被指定。
另请参阅DECLARE, CLOSE上一页 上一级 下一页GET DESCRIPTOR 起始页 PREPARE
