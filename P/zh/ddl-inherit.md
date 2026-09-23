# 5.11. 继承

5.11. 继承
版本：
纠错本页面
搜索
目录导航
❮
❯
5.11. 继承 #5.11.1. 警告
PostgreSQL实现了表继承，这对数据库设计者来说是一种有用的工具（SQL:1999及其后的版本定义了一种类型继承特性，但和这里介绍的特性有很大的不同）。
让我们从一个例子开始：假设我们要为城市建立一个数据模型。每一个州有很多城市，但是只有一个首府。我们希望能够快速地检索任何特定州的首府城市。这可以通过创建两个表来实现：一个用于州首府，另一个用于不是首府的城市。然而，当我们想要查看一个城市的数据（不管它是不是一个首府）时会发生什么？继承特性将有助于解决这个问题。我们可以将capitals表定义为继承自cities表：
CREATE TABLE cities (
name            text,
population      float,
elevation       int     -- in feet
);
CREATE TABLE capitals (
state           char(2)
) INHERITS (cities);
在这种情况下，capitals表继承了它的父表cities的所有列。州首府还有一个额外的列state用来表示它所属的州。
在PostgreSQL中，一个表可以从零个或多个其他表继承，而对一个表的查询则可以引用一个表的所有行或者该表的所有行加上它所有的后代表。
默认情况是后一种行为。例如，下面的查询将查找所有高度高于500尺的城市的名称，包括州首府：
SELECT name, elevation
FROM cities
WHERE elevation > 500;
对于来自PostgreSQL教程（见第 2.1 节）的例子数据，它将返回：
name    | elevation
-----------+-----------
Las Vegas |      2174
Mariposa  |      1953
Madison   |       845
另一方面，下面的查询将找到高度超过500英尺且不是州首府的所有城市：
SELECT name, elevation
FROM ONLY cities
WHERE elevation > 500;
name    | elevation
-----------+-----------
Las Vegas |      2174
Mariposa  |      1953
这里的ONLY关键词指示查询只应用于cities，而不涉及继承层次中位于cities之下的其他表。很多我们已经讨论过的命令（如SELECT、UPDATE和DELETE）都支持ONLY关键词。
我们也可以在表名后写上一个*来显式地将后代表包括在查询范围内：
SELECT name, elevation
FROM cities*
WHERE elevation > 500;
写*不是必需的，因为这种行为总是默认的。不过，为了兼容可以修改默认值的较老版本，现在仍然支持这种语法。
在某些情况下，我们可能希望知道一个特定行来自于哪个表。每个表中的系统列tableoid可以告诉我们行来自于哪个表：
SELECT c.tableoid, c.name, c.elevation
FROM cities c
WHERE c.elevation > 500;
将会返回：
tableoid |   name    | elevation
----------+-----------+-----------
139793 | Las Vegas |      2174
139793 | Mariposa  |      1953
139798 | Madison   |       845
（如果重新生成这个结果，可能会得到不同的OID数字。）通过与pg_class进行连接可以看到实际的表名：
SELECT p.relname, c.name, c.elevation
FROM cities c, pg_class p
WHERE c.elevation > 500 AND c.tableoid = p.oid;
将会返回：
relname  |   name    | elevation
----------+-----------+-----------
cities   | Las Vegas |      2174
cities   | Mariposa  |      1953
capitals | Madison   |       845
另一种得到同样效果的方法是使用regclass别名类型，
它将象征性地打印出表的OID：
SELECT c.tableoid::regclass, c.name, c.elevation
FROM cities c
WHERE c.elevation > 500;
继承不会自动地将来自INSERT或COPY命令的数据传播到继承层次中的其他表。在我们的例子中，下面的INSERT语句将会失败：
INSERT INTO cities (name, population, elevation, state)
VALUES ('Albany', NULL, NULL, 'NY');
我们也许希望数据能以某种方式被引入到capitals表中，但是这不会发生：INSERT总是向指定的表中插入。在某些情况下，可以通过使用一个规则（见第 39 章）来将插入动作重定向。但是这对上面的情况并没有帮助，因为cities表根本就不包含state列，因此这个命令将在触发规则之前就被拒绝。
父表上的所有检查约束和非空约束都将自动被它的后代所继承，除非显式地指定了NO INHERIT子句。其他类型的约束（唯一、主键和外键约束）则不会被继承。
一个表可以从超过一个的父表继承，在这种情况下它拥有父表所定义的列的并集。任何定义在子表上的列也会被加入到其中。如果在这个集合中出现重名列，那么这些列将被“合并”，这样在子表中只会有一个这样的列。重名列能被合并的前提是这些列必须具有相同的数据类型，否则会导致错误。可继承的检查约束和非空约束会以类似的方式被合并。例如，如果合并成一个合并列的任一列定义被标记为非空，则该合并列会被标记为非空。如果检查约束的名称相同，则它们会被合并，但如果它们的条件不同则合并会失败。
表继承通常是在子表被创建时建立，使用CREATE TABLE语句的INHERITS子句。一个已经被创建的表也可以另外一种方式增加一个新的父关系，使用ALTER TABLE的INHERIT变体。要这样做，新的子表必须已经包括和父表相同名称和数据类型的列。子表还必须包括和父表相同的检查约束和检查表达式。相似地，一个继承链接也可以使用ALTER TABLE的NO INHERIT变体从一个子表中移除。动态增加和移除继承链接可以用于实现表划分（见第 5.12 节）。
一种创建一个未来将被用作子表的新表的方法是在CREATE
TABLE中使用LIKE子句。这将创建一个和源表具有相同列的新表。如果源表上定义有任何CHECK约束，LIKE的INCLUDING CONSTRAINTS选项应该被指定，因为新的子表必须具有与父表匹配的约束才能被视为兼容。
当有任何一个子表存在时，父表不能被删除。当子表的列或者检查约束继承于父表时，它们也不能被删除或修改。如果希望移除一个表和它的所有后代，一种简单的方法是使用CASCADE选项删除父表（见第 5.15 节）。
ALTER TABLE将会把列的数据定义或检查约束上的任何变化沿着继承层次向下传播。同样，删除被其他表依赖的列只能使用CASCADE选项。ALTER TABLE对于重名列的合并和拒绝遵循与CREATE TABLE同样的规则。
继承的查询仅在父表上执行访问权限检查。例如，在cities表上授予UPDATE权限也隐含着通过cities访问时在capitals表中更新行的权限。
这保留了数据（也）在父表中的样子。但是如果没有额外的授权，则不能直接更新capitals表。
以类似的方式，父表的行安全性策略（见第 5.9 节）适用于继承查询期间来自于子表的行。
只有当子表在查询中被明确提到时，其策略（如果有）才会被应用，在那种情况下，附着在其父表上的任何策略都会被忽略。
外部表（见第 5.13 节）也可以是继承层次中的一部分，即可以作为父表也可以作为子表，就像常规表一样。如果一个外部表是继承层次的一部分，那么任何不被该外部表支持的操作也不被整个层次所支持。
5.11.1. 警告 #
请注意，并非所有 SQL 命令都能在继承层次结构上工作。用于数据查询、
数据修改或模式修改的命令
（例如，SELECT、UPDATE、DELETE、
大多数 ALTER TABLE 的变体，但
不包括 INSERT 或 ALTER TABLE ...
RENAME）通常默认包括子表，并
支持 ONLY 语法以排除它们。
大多数进行数据库维护和调优的命令
（例如，REINDEX）仅适用于单个物理
表，并不支持递归遍历继承层次结构。
然而，VACUUM 和 ANALYZE
命令默认包括子表，并支持 ONLY
语法以允许将其排除。每个单独命令的
具体行为在其参考页面中有文档说明
（SQL 命令）。
继承特性的一个严肃的限制是索引（包括唯一约束）和外键约束只应用在单个表上而非它们的继承子表。在外键约束的引用端和被引用端都是这样。因此，按照上面的例子：
如果我们声明cities.name为UNIQUE或者PRIMARY KEY，这将不会阻止capitals表中拥有和cities中城市同名的行。而且这些重复的行将会默认显示在cities的查询中。事实上，capitals在默认情况下是根本不能拥有唯一约束的，并且因此能够包含多个同名的行。我们可以为capitals增加一个唯一约束，但这无法阻止相对于cities的重复。
相似地，如果我们指定cities.name REFERENCES某个其他表，该约束不会自动地传播到capitals。在此种情况下，我们可以变通地在capitals上手工创建一个相同的REFERENCES约束。
指定另一个表的列REFERENCES cities(name)将允许其他表包含城市名称，但不会包含首府名称。这对于这个例子不是一个好的变通方案。
某些未为继承层次结构实现的功能是为声明性分区实现的。在决定使用旧继承进行分区是否对应用程序有用时，需要非常小心。
上一页 上一级 下一页5.10. 模式 起始页 5.12. 表分区
