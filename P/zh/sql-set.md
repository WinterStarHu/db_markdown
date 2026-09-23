# SET

SET
版本：
纠错本页面
搜索
目录导航
❮
❯
SETSET — 更改运行时参数大纲
SET [ SESSION | LOCAL ] configuration_parameter { TO | = } { value | 'value' | DEFAULT }
SET [ SESSION | LOCAL ] TIME ZONE { value | 'value' | LOCAL | DEFAULT }
描述
SET命令用于更改运行时配置参数。许多在第 19 章中列出的运行时参数可以通过SET动态更改。
（有些参数只能由超级用户和已被授予对该参数具有SET特权的用户更改。
还有一些参数在服务器或会话启动后无法更改。）
SET仅影响当前会话使用的值。
如果在一个事务内发出SET
（或者等效的SET SESSION）而该事务后来
中止，在该事务被回滚时SET命令的效果会
消失。一旦所在的事务被提交，这些效果将会持续到会话结束（除非被另
一个SET所覆盖）。
SET LOCAL的效果只持续到当前事务结束，
不管事务是否被提交。一种特殊情况是在一个事务内
SET后面跟着
SET LOCAL：
SET LOCAL值将会在该事务结束前一直可见，
但是之后（如果该事务被提交）SET值将会生效。
SET或SET LOCAL
的效果也会因为回滚到早于它们的保存点而消失。
如果SET LOCAL在一个函数内使用，并且该函数
还有对同一变量的SET选项（见
CREATE FUNCTION），在函数退出时
SET LOCAL命令的效果会消失。也就是说，该
函数被调用时的值会被恢复。这允许用
SET LOCAL在函数内动态地或重复地更改
一个参数，同时仍然能便利地使用SET选项来保存和
恢复调用者的值。不过，一个常规的SET命令
会覆盖它所在的任何函数的SET选项，除非回滚，它的效果将一直保持。
注意
在PostgreSQL 版本 8.0 到 8.2 中，
一个SET LOCAL的效果会因为释放较早的
保存点或者成功地从一个PL/pgSQL异常块
中退出而被取消。这种行为已经被更改，因为它被认为不直观。
参数SESSION
指定该命令对当前会话有效（这是默认值，如果既没有出现
SESSION也没有出现LOCAL）。
LOCAL
指定该命令只对当前事务有效。在COMMIT或
ROLLBACK之后，会话级别的设置会再次生效。
在事务块外部发出这个参数会发出一个警告，并且不会有效果。
configuration_parameter
可设置运行时参数的名称。可用的参数在
第 19 章和下文中有记录。
value
参数的新值。根据特定的参数，值可以被指定为字符串常量、标识符、
数字或者以上构成的逗号分隔列表。写DEFAULT
可以指定将该参数重置为它的默认值（也就是说在当前会话中还没有
执行SET命令时它具有的值）。
除了在第 19 章中记录的配置参数外，还有一些只能通过
SET命令调整或具有特殊语法的参数：
SCHEMASET SCHEMA 'value' 是
SET search_path TO value 的别名。只能使用此语法指定一个
模式。
NAMESSET NAMES 'value' 是
SET client_encoding TO value 的别名。
SEED
设置随机数生成器的内部种子（函数random）。
允许的值是介于-1和1之间的浮点数（包括-1和1）。
也可以通过调用函数
setseed来设置种子：
SELECT setseed(value);
TIME ZONESET TIME ZONE 'value' 是
SET timezone TO 'value' 的别名。语法
SET TIME ZONE允许时间区指定的特殊语法。以下是有效值的示例：
'America/Los_Angeles'
加利福尼亚州伯克利的时区。
'Europe/Rome'
意大利的时区。
-7
UTC西7小时的时区（相当于PDT）。正值表示东于UTC。
INTERVAL '-08:00' HOUR TO MINUTE
UTC西8小时的时区（相当于PST）。
LOCALDEFAULT
将时区设置为您的本地时区（即服务器的默认值timezone）。
以数字或区间给出的时区设置在内部转换为POSIX时区语法。例如，在
SET TIME ZONE -7之后，SHOW TIME ZONE将
报告<-07>+07。
SET不支持时区缩写；
有关时区的更多信息，请参见第 8.5.3 节。
注释
函数set_config提供了等效的功能，见
第 9.28.1 节。此外，可以更新
pg_settings
系统视图来执行与SET等效的工作。
示例
设置模式搜索路径：
SET search_path TO my_schema, public;
把日期风格设置为传统
POSTGRES的
“日先于月”的输入习惯：
SET datestyle TO postgres, dmy;
设置加利福尼亚州伯克利的时区：
SET TIME ZONE 'America/Los_Angeles';
设置时区为意大利：
SET TIME ZONE 'Europe/Rome';
兼容性
SET TIME ZONE 扩展了 SQL 标准定义的语法。标准
只允许数字的时区偏移量，而
PostgreSQL 允许更灵活的时区说明。
所有其他 SET 特性都是
PostgreSQL 扩展。
其他RESET, SHOW上一页 上一级 下一页SELECT INTO 起始页 SET CONSTRAINTS
