# VAR

VAR
版本：
纠错本页面
搜索
目录导航
❮
❯
VARVAR — 定义一个变量大纲
VAR varname IS ctype
描述
VAR命令分配一个新的 C 数据类型给一个主变量。主变量必须之前在一个声明节中声明过。
参数varname #
一个 C 变量名。
ctype #
一个 C 类型规范。
示例
Exec sql begin declare section;
short a;
exec sql end declare section;
EXEC SQL VAR a IS int;
兼容性
VAR命令是 PostgreSQL 的一个扩展。
上一页 上一级 下一页TYPE 起始页 WHENEVER
