# 42.7. PL/Tcl 中的事件触发器函数

42.7. PL/Tcl 中的事件触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
42.7. PL/Tcl 中的事件触发器函数 #
事件触发器函数可以用 PL/Tcl 编写。PostgreSQL要求作为事件触发器被调用的函数必须声明为没有参数并且返回类型为event_trigger。
来自触发器管理器的信息通过下列变量传递给函数体：
$TG_event
触发器引发的事件名称。
$TG_tag
触发器引发的命令标签。
触发器函数的返回值被忽略。
这里是一个事件触发器函数的小例子，它在每次执行所支持的命令时简单地产生一个NOTICE消息：
CREATE OR REPLACE FUNCTION tclsnitch() RETURNS event_trigger AS $$
elog NOTICE "tclsnitch: $TG_event $TG_tag"
$$ LANGUAGE pltcl;
CREATE EVENT TRIGGER tcl_a_snitch ON ddl_command_start EXECUTE FUNCTION tclsnitch();
上一页 上一级 下一页42.6. PL/Tcl 中的触发器函数 起始页 42.8. PL/Tcl 中的错误处理
