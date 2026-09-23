# DO

DO
版本：
纠错本页面
搜索
目录导航
❮
❯
DODO — 执行一个匿名代码块大纲
DO [ LANGUAGE lang_name ] code
描述
DO 执行一个匿名代码块，或者换句话说
执行一个以一种过程语言编写的瞬时匿名函数。
代码块就好像是一个没有参数并且返回 void 的函数的函数体。
它会被解析并且执行一次。
可选的 LANGUAGE 子句可以写在代码块之前或者之后。
参数code
要被执行的过程语言代码。就像在
CREATE FUNCTION中一样，必须把它指定为一个
字符串文字。推荐使用一个美元引用的文本。
lang_name
编写该代码的过程语言的名称。如果省略，默认为plpgsql。
注意事项
要使用的过程语言必须已经用CREATE EXTENSION安装在
当前数据库中。默认已经安装了plpgsql，但是其他语言没有被
安装。
用户必须拥有该过程语言的USAGE特权，如果该语言
是不可信的则必须是一个超级用户。这和创建该语言的函数对
特权的要求相同。
如果在事务块中执行DO，则过程代码无法执行事务控制语句。只有在自己的事务中执行DO时，才允许使用事务控制语句。
示例
把模式public中所有视图上的所有特权授予
给角色webuser：
DO $$DECLARE r record;
BEGIN
FOR r IN SELECT table_schema, table_name FROM information_schema.tables
WHERE table_type = 'VIEW' AND table_schema = 'public'
LOOP
EXECUTE 'GRANT ALL ON ' || quote_ident(r.table_schema) || '.' || quote_ident(r.table_name) || ' TO webuser';
END LOOP;
END$$;
兼容性
SQL 标准中没有DO语句。
另见CREATE LANGUAGE上一页 上一级 下一页DISCARD 起始页 DROP ACCESS METHOD
