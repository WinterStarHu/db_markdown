# 39.7. 规则与触发器

39.7. 规则与触发器
版本：
纠错本页面
搜索
目录导航
❮
❯
39.7. 规则与触发器 #
许多触发器可以干的事情同样也可以用PostgreSQL规则系统来实现。不能用规则来实现的东西之一是某些约束，特别是外键。可以放置一个合格的规则在一列上，这个规则在列的值没有出现在另一个表中时把命令重写成NOTHING。但是这样做数据就会被不声不响地丢弃，因此也不是一个好主意。如果要求检查值的有效性，并且在出现无效值的情况下应该生成一个错误消息，这种需求就必须要用触发器来完成。
在本章中，我们关注于使用规则来更新视图。本章中所有的更新规则的例子都可以使用视图上的INSTEAD OF触发器来实现。编写这类触发器通常比编写规则要容易，特别是在要求使用复杂逻辑来执行更新的情况下。
对于两者都可实现的情况，哪个更好取决于对数据库的使用。触发器为每一个受影响的行都执行一次。规则修改查询或生成一个额外的查询。所以如果在一个语句中影响到很多行，一个发出额外查询的规则通常可能会比一个触发器快，因为触发器对每一个行都要被调用，并且每次被调用时都需要重新判断要做什么样的操作。不过，触发器方法从概念上要远比规则方法简单，并且很容易让新人上手。
下面我们展示一个例子，该例子说明了在同种情况下两种选择的比较。这里有两个表：
CREATE TABLE computer (
hostname        text,    -- 被索引
manufacturer    text     -- 被索引
);
CREATE TABLE software (
software        text,    -- 被索引
hostname        text     -- 被索引
);
两个表都有数千行，并且在hostname上的索引是唯一的。规则或触发器应该实现一个约束，该约束从software中删除引用已删除计算机的行。触发器可以用下面这条命令：
DELETE FROM software WHERE hostname = $1;
因为触发器会为每一个从computer中删除的独立行调用一次，那么它可以准备并且保存这个命令的规划，把hostname作为参数传入。规则应该被写为：
CREATE RULE computer_del AS ON DELETE TO computer
DO DELETE FROM software WHERE hostname = OLD.hostname;
现在看看不同类型的删除。在这种情况：
DELETE FROM computer WHERE hostname = 'mypc.local.net';
表computer被使用索引（快速）扫描，并且由触发器发出的命令也将使用一个索引扫描（同样快速）。来自规则的额外查询应该是：
DELETE FROM software WHERE computer.hostname = 'mypc.local.net'
AND software.hostname = computer.hostname;
由于已经建立了合适的索引，规划器将创建一个规划
Nestloop
->  Index Scan using comp_hostidx on computer
->  Index Scan using soft_hostidx on software
所以在触发器和规则的实现之间没有太多的速度差别。
在接下来的删除中，我们想要去掉所有 2000 个hostname以old开头的计算机。有两个命令可以来做这件事。一个是：
DELETE FROM computer WHERE hostname >= 'old'
AND hostname <  'ole'
被规则增加的命令将是：
DELETE FROM software WHERE computer.hostname >= 'old' AND computer.hostname < 'ole'
AND software.hostname = computer.hostname;
计划是：
Hash Join
->  Seq Scan on software
->  Hash
->  Index Scan using comp_hostidx on computer
另一个可能的命令是：
DELETE FROM computer WHERE hostname ~ '^old';
它会为规划增加的命令产生下面的执行计划：
Nestloop
->  Index Scan using comp_hostidx on computer
->  Index Scan using soft_hostidx on software
这表明，当有多个条件表达式被使用AND组合在一起时，规划器不能认识到表computer中hostname上的条件也可以被用于一个software上的索引扫描，而在该命令的正则表达式版本中正是这样做的。触发器将为要被删除的 2000 个旧计算机中的每一个调用，并且会导致在computer上的一次索引扫描和software上的 2000 次索引扫描。采用规则的实现将会使用两个使用索引的命令来完成。并且在顺序扫描情况下规则是否仍将更快是取决于software表的总体大小的。即使所有的索引块都将很快地进入高速缓存，通过 SPI 管理器执行来自触发器的 2000 个命令也要花不少时间。
我们要看的最后一个命令是：
DELETE FROM computer WHERE manufacturer = 'bim';
同样，这也会导致很多行被从computer中删除。所以触发器同样会通过执行器运行很多命令。规则生成的命令将会是：
DELETE FROM software WHERE computer.manufacturer = 'bim'
AND software.hostname = computer.hostname;
这个命令的计划又将是在两个索引扫描上的嵌套循环，只不过使用了computer上的另一个索引：
Nestloop
->  Index Scan using comp_manufidx on computer
->  Index Scan using soft_hostidx on software
在任何这些情况之一，来自规则系统的额外命令都或多或少与命令中影响的行数无关。
概括来说，规则只有在其动作导致了大而且不合理的连接时才会明显地慢于触发器，这种情况下规划器将无法处理。
上一页 上一级 下一页39.6. 规则和命令状态 起始页 第 40 章 过程语言
