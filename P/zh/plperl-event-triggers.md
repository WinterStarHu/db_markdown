# 43.7. PL/Perl 事件触发器

43.7. PL/Perl 事件触发器
版本：
纠错本页面
搜索
目录导航
❮
❯
43.7. PL/Perl 事件触发器 #
PL/Perl 可以被用来编写事件触发器函数。在事件触发器函数中，哈希引用
$_TD包含有关当前触发器事件的信息。
$_TD是一个全局变量，对触发器的每一次调用它都会
得到一个独立的本地值。$_TD哈希引用的域有：
$_TD->{event}
触发器为其触发的事件名称。
$_TD->{tag}
触发器为其触发的命令标签。
触发器函数的返回值会被忽略。
这里是一个事件触发器函数的例子，展示了上文所说的一些东西：
CREATE OR REPLACE FUNCTION perlsnitch() RETURNS event_trigger AS $$
elog(NOTICE, "perlsnitch: " . $_TD->{event} . " " . $_TD->{tag} . " ");
$$ LANGUAGE plperl;
CREATE EVENT TRIGGER perl_a_snitch
ON ddl_command_start
EXECUTE FUNCTION perlsnitch();
上一页 上一级 下一页43.6. PL/Perl 触发器 起始页 43.8. PL/Perl 内部机制
