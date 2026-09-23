# SET CONSTRAINTS

SET CONSTRAINTS
版本：
纠错本页面
搜索
目录导航
❮
❯
SET CONSTRAINTSSET CONSTRAINTS — 为当前事务设置约束检查时机大纲
SET CONSTRAINTS { ALL | name [, ...] } { DEFERRED | IMMEDIATE }
描述
SET CONSTRAINTS设置当前事务内约束检查
的行为。IMMEDIATE约束在每个语句结束时被检查。
DEFERRED约束直到事务提交时才被检查。每个约束都有
自己的IMMEDIATE或DEFERRED模式。
在创建时，一个约束会被给定三种特性之一：
DEFERRABLE INITIALLY DEFERRED、
DEFERRABLE INITIALLY IMMEDIATE或
NOT DEFERRABLE。第三类总是
IMMEDIATE并且不会受到
SET CONSTRAINTS命令的影响。前两类在每个
事务开始时都处于指定的模式，但是它们的行为可以在一个事务内用
SET CONSTRAINTS更改。
带有一个约束名称列表的SET CONSTRAINTS
只更改那些约束（都必须是可延迟的）的模式。每一个约束名称都可以是
模式限定的。如果没有指定模式名称，则当前的模式搜索路径将被用来寻找
第一个匹配的名称。SET CONSTRAINTS ALL
更改所有可延迟约束的模式。
当SET CONSTRAINTS把一个约束的模式从
DEFERRED改成IMMEDIATE时，
新模式会有追溯效果：任何尚未解决的数据修改（本来会在事务结束时
被检查）会转而在SET CONSTRAINTS命令
的执行期间被检查。如果任何这种约束被违背，
SET CONSTRAINTS将会失败（并且不会改
变该约束模式）。这样，SET
CONSTRAINTS可以被用来在一个事务中的特定点强制进
行约束检查。
当前，只有UNIQUE、PRIMARY KEY、
REFERENCES（外键）以及EXCLUDE
约束受到这个设置的影响。
NOT NULL以及CHECK约束总是在一行
被插入或修改时立即检查（不是在语句结束时）。
没有被声明为DEFERRABLE的唯一和排除约束也会被
立刻检查。
被声明为“约束触发器”的触发器的引发也受到这个设置
的控制 — 它们会在相关约束被检查的同时被引发。
注释
因为PostgreSQL并不要求约束名称在模式内
唯一（但是在表内要求唯一），可能有多于一个约束匹配指定的约束名称。在这种
情况下SET CONSTRAINTS将会在所有的匹配上操作。
对于一个非模式限定的名称，一旦在搜索路径中的某个模式中发现一个或者多个匹
配，路径中后面的模式将不会被搜索。
这个命令只修改当前事务内约束的行为。在事务块外部发出这个命令会产生一个
警告并且也不会有任何效果。
兼容性
这个命令符合 SQL 标准中定义的行为，但有一点限制：在
PostgreSQL中，它不会应用在
NOT NULL和CHECK约束上。还有，
PostgreSQL会立刻检查非可延迟的
唯一约束，而不是按照标准建议的在语句结束时检查。
上一页 上一级 下一页SET 起始页 SET ROLE
