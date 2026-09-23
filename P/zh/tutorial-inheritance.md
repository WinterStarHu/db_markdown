# 3.6. 继承

3.6. 继承
版本：
纠错本页面
搜索
目录导航
❮
❯
3.6. 继承 #
继承是面向对象数据库中的概念。它展示了数据库设计的新可能性。
让我们创建两个表：表cities和表capitals。自然地，首都也是城市，所以我们需要有某种方式能够在列举所有城市的时候也隐式地包含首都。如果真的聪明，我们会设计如下的模式：
CREATE TABLE capitals (
name       text,
population real,
elevation  int,    -- (in ft)
state      char(2)
);
CREATE TABLE non_capitals (
name       text,
population real,
elevation  int     -- (in ft)
);
CREATE VIEW cities AS
SELECT name, population, elevation FROM capitals
UNION
SELECT name, population, elevation FROM non_capitals;
这个模式对于查询而言工作正常，但是当我们需要更新一些行时它就变得不好用了。
更好的方案是：
CREATE TABLE cities (
name       text,
population real,
elevation  int     -- (in ft)
);
CREATE TABLE capitals (
state      char(2) UNIQUE NOT NULL
) INHERITS (cities);
在这种情况下，一个capitals的行从它的父cities继承了所有列（name、population和elevation）。
列name的类型是text，一种用于变长字符串的本地PostgreSQL类型。
capitals表有一个附加列，state，用于显示它们的州缩写。
在PostgreSQL中，一个表可以从0个或者多个表继承。
例如，如下查询可以寻找所有海拔超过500英尺的城市名称，包括州首都：
SELECT name, elevation
FROM cities
WHERE elevation > 500;
返回结果为:
name    | elevation
-----------+-----------
Las Vegas |      2174
Mariposa  |      1953
Madison   |       845
(3 rows)
另一方面，下面的查询可以查找所有海拔高于500英尺且不是州首府的城市：
SELECT name, elevation
FROM ONLY cities
WHERE elevation > 500;
name    | elevation
-----------+-----------
Las Vegas |      2174
Mariposa  |      1953
(2 rows)
这里ONLY在cities之前表示查询只应在
cities表上进行，而不涉及继承层次中位于
cities之下的表。我们已经讨论过的许多命令 —
SELECT、UPDATE和
DELETE — 都支持这个ONLY
记号。
注意
尽管继承很有用，但是它还未与唯一约束或外键集成，这也限制了它的可用性。更多详情见第 5.11 节。
上一页 上一级 下一页3.5. 窗口函数 起始页 3.7. 结论
