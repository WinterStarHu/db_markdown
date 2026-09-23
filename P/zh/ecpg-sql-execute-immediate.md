# EXECUTE IMMEDIATE

EXECUTE IMMEDIATE
版本：
纠错本页面
搜索
目录导航
❮
❯
EXECUTE IMMEDIATEEXECUTE IMMEDIATE — 动态准备和执行一个语句大纲
EXECUTE IMMEDIATE string
描述
EXECUTE IMMEDIATE立刻准备并执行一个动态指定的 SQL 语句，不检索结果行。
参数string #
包含要执行的 SQL 语句的一个字符串或者是一个主机变量。
Notes
在典型用法中，string是对包含动态构造 SQL 语句的字符串的主机变量引用。
文字字符串的情况不是非常有用，你也可以直接写 SQL 语句，而无需 EXECUTE IMMEDIATE 的额外输入。
如果你使用文字字符串，请注意任何你可能希望在 SQL 语句中包括的双引号必须写为八进制转义 (\042)，而不是通常的 C 惯用法 \"。
这是因为字符串在 EXEC SQL 段里面，所以 ECPG 语法分析器根据 SQL 规则而不是 C 规则来解析它。
任何内嵌的反斜杠后续将按照 C 规则处理；但是 \" 会造成直接语法错误，因为它被视为文字的终结。
示例
这里是一个用EXECUTE IMMEDIATE和一个名为command的主变量执行INSERT语句的例子：
sprintf(command, "INSERT INTO test (name, amount, letter) VALUES ('db: ''r1''', 1, 'f')");
EXEC SQL EXECUTE IMMEDIATE :command;
兼容性
EXECUTE IMMEDIATE在 SQL 标准中被规定。
上一页 上一级 下一页DISCONNECT 起始页 GET DESCRIPTOR
