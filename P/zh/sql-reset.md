# RESET

RESET
版本：
纠错本页面
搜索
目录导航
❮
❯
RESETRESET — 将运行时参数的值恢复到默认值大纲
RESET configuration_parameter
RESET ALL
描述
RESET把运行时参数恢复到它们的默认值。RESET是
SET configuration_parameter TO DEFAULT
的另一种写法。详见SET。
默认值被定义为如果在当前会话中没有发出过SET，
参数应该具有的值。这个值的实际来源可能是一个编译在内部的默认值、
配置文件、命令行选项、或者针对每个数据库或者每个用户的默认设置。
这和把它定义成“在会话开始时该参数得到的值”有细微的差别，
因为如果该值来自于配置文件，它将被重置为现在配置文件所指定的任何东西。
详见第 19 章。
RESET的事务行为和SET相同：
它的效果会被事务回滚撤销。
参数configuration_parameter
可设置的运行时参数名称。可用的参数记录在
第 19 章以及
SET参考页中。
ALL
将所有可设置的运行时参数重置为默认值。
示例
将timezone配置变量设置为默认值：
RESET timezone;
兼容性
RESET是一个
PostgreSQL扩展。
另见SET, SHOW上一页 上一级 下一页RELEASE SAVEPOINT 起始页 REVOKE
