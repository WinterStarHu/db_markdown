# CREATE VIEW

CREATE VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE VIEWCREATE VIEW — 定义一个新视图大纲
CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] [ RECURSIVE ] VIEW name [ ( column_name [, ...] ) ]
[ WITH ( view_option_name [= view_option_value] [, ... ] ) ]
AS query
[ WITH [ CASCADED | LOCAL ] CHECK OPTION ]
描述
CREATE VIEW定义一个查询的视图。该视图不会被
物理上物质化。相反，在每一次有查询引用该视图时，视图的查询都会被运行。
CREATE OR REPLACE VIEW与之相似，但是如果
已经存在一个同名视图，该视图会被替换。新查询必须产生和现有视图查询相同
的列（也就是相同的列序、相同的列名、相同的数据类型），但是它可以在列表
的末尾加上额外的列。产生输出列的计算可以完全不同。
如果给出了模式名称（例如，CREATE VIEW
myschema.myview ...），则视图将在指定的模式中创建。
否则，它将在当前模式中创建。临时视图存在于一个特殊的模式中，因此在创建临时视图时不能给出模式名称。
视图的名称必须与同一模式中的任何其他关系（表、序列、索引、视图、
材料化视图或外部表）的名称不同。
参数TEMPORARY或TEMP
如果被指定，视图被创建为一个临时视图。在当前会话结束时会自动
删除临时视图。当临时视图存在时，具有相同名称的已有永久视图对
当前会话不可见，除非用模式限定的名称引用它们。
如果视图引用的任何表是临时的，视图将被创建为临时视图（不管有
没有指定TEMPORARY）。
RECURSIVE
创建一个递归视图。语法
CREATE RECURSIVE VIEW [ schema . ] view_name (column_names) AS SELECT ...;
等效于
CREATE VIEW [ schema . ] view_name AS WITH RECURSIVE view_name (column_names) AS (SELECT ...) SELECT column_names FROM view_name;
对于一个递归视图必须指定一个视图列名列表。
name
要创建的视图的名称（可以是模式限定的）。
column_name
要用于视图列的名称列表，可选。如果没有给出，列名会根据查询
推导。
WITH ( view_option_name [= view_option_value] [, ... ] )
本节指定了视图的可选参数；支持以下参数：
check_option (enum)
此参数可以是local或cascaded，等同于指定
WITH [ CASCADED | LOCAL ] CHECK OPTION（见下文）。
security_barrier (boolean)
如果视图旨在提供逐行安全性，则应使用此选项。详细信息请参见第 39.5 节。
security_invoker (boolean)
此选项导致基础基本关系根据视图用户的权限而不是视图所有者的权限进行检查。详细信息请参见下文的注释。
所有上述选项都可以使用ALTER VIEW更改现有视图。
query
提供视图的行和列的一个SELECT 或 VALUES命令。
WITH [ CASCADED | LOCAL ] CHECK OPTION
此选项控制自动可更新视图的行为。当指定此选项时，INSERT、
UPDATE和MERGE命令将在视图上被检查，
以确保新行满足视图定义的条件（即检查新行是否通过视图可见）。
如果不满足，更新将被拒绝。如果未指定CHECK OPTION，
则允许在视图上执行INSERT、UPDATE和
MERGE命令创建视图不可见的行。支持以下检查选项：
LOCAL
新行仅针对视图本身直接定义的条件进行检查。对底层基础视图定义的任何条件
不进行检查（除非它们也指定了CHECK OPTION）。
CASCADED
新行将针对视图及所有底层基础视图的条件进行检查。如果指定了
CHECK OPTION，且未指定LOCAL或
CASCADED，则默认采用CASCADED。
CHECK OPTION不能与RECURSIVE视图一起使用。
注意，CHECK OPTION仅支持自动可更新的视图，且这些视图不包含
INSTEAD OF触发器或INSTEAD规则。如果一个自动可更新的
视图定义在一个具有INSTEAD OF触发器的基础视图之上，则可以使用
LOCAL CHECK OPTION来检查自动可更新视图上的条件，但不会检查带有
INSTEAD OF触发器的基础视图上的条件（级联检查选项不会级联到触发器可更新的
视图，且直接定义在触发器可更新视图上的任何检查选项将被忽略）。如果视图或其任何基础关系
具有导致INSERT或UPDATE命令被重写的
INSTEAD规则，则所有检查选项将在重写的查询中被忽略，包括定义在带有
INSTEAD规则的关系之上的自动可更新视图的任何检查。若视图或其任何基础关系
有规则，则不支持MERGE。
注意事项
使用DROP VIEW语句删除视图。
要小心视图列的名称和类型将会按照你想要的方式指定。例如：
CREATE VIEW vista AS SELECT 'Hello World';
是不好的形式，因为列名默认为?column?，而且列的数据类型默认为text，这可能不是你想要的。视图结果中一个字符串更好的风格类似于这样：
CREATE VIEW vista AS SELECT text 'Hello World' AS hello;
默认情况下，对视图中引用的基础关系的访问权限由视图所有者的权限确定。在某些情况下，
这可以用来提供对基础表的安全但受限制的访问。然而，并非所有视图都能防止篡改；详见
第 39.5 节。
如果视图的security_invoker属性设置为true，
则对基础关系的访问权限取决于执行查询的用户的权限，而不是视图所有者的权限。
因此，安全调用者视图的用户必须对视图及其基础关系具有相关权限。
如果任何基础关系中有一个是安全调用者视图，它将被视为直接从原始查询中访问。
因此，安全调用者视图将始终使用当前用户的权限检查其基础关系，即使它是从没有
security_invoker属性的视图中访问。
如果任何基础关系中有启用行级安全，那么默认情况下，视图所有者的行级安全策略将被应用，
并且对于这些策略引用的任何其他关系的访问将由视图所有者的权限确定。然而，如果视图设置了security_invoker为true，
那么调用用户的策略和权限将被使用，就好像基础关系直接从查询中使用视图引用一样。
在视图中调用的函数与直接从查询中使用视图调用的函数一样对待。因此，视图的用户必须具有调用视图中使用的所有函数的权限。
视图中的函数以执行查询的用户或函数所有者的权限执行，具体取决于这些函数是否被定义为SECURITY INVOKER或SECURITY DEFINER。
因此，例如，在视图中直接调用CURRENT_USER将始终返回调用用户，而不是视图所有者。
这不受视图的security_invoker设置的影响，因此，将security_invoker设置为false的视图
不等同于SECURITY DEFINER函数，这些概念不应混淆。
创建或替换视图的用户必须对视图查询中引用的任何模式具有USAGE权限，
以便在这些模式中查找引用的对象。然而，请注意，此查找仅在创建或替换视图时发生。
因此，视图的用户只需要对包含视图的模式具有USAGE权限，而不需要对视图查询中引用的模式具有权限，即使是安全调用者视图。
当使用CREATE OR REPLACE VIEW来更新现有视图时，只有视图的定义SELECT规则，
以及任何WITH ( ... )参数和其CHECK OPTION会被更改。
其他视图属性，包括所有权、权限和非SELECT规则，保持不变。您必须拥有该视图才能替换它（这包括成为拥有角色的成员）。
可更新视图
简单视图是自动可更新的：系统允许在视图上使用
INSERT、UPDATE、
DELETE和MERGE语句，
使用方式与普通表相同。视图满足以下所有条件时，
它就是自动可更新的：
视图的FROM列表中必须恰好有一个条目，
该条目必须是表或另一个可更新视图。
视图定义的顶层不得包含WITH、
DISTINCT、GROUP BY、
HAVING、LIMIT或
OFFSET子句。
视图定义的顶层不得包含集合操作（UNION、
INTERSECT或EXCEPT）。
视图的选择列表中不得包含任何聚合函数、窗口函数
或返回集合的函数。
自动可更新视图可能包含可更新列和不可更新列的混合。只有当列是对底层基表中
可更新列的简单引用时，该列才是可更新的；否则该列为只读，如果
INSERT、UPDATE或
MERGE语句试图为其赋值，将引发错误。
如果视图是自动可更新的，系统将把对视图的任何
INSERT、UPDATE、
DELETE或MERGE语句
转换为对底层基表的相应语句。带有ON
CONFLICT UPDATE子句的INSERT语句
得到完全支持。
如果一个自动可更新视图包含一个WHERE条件，条件限制了基表中哪些行
可以被视图上的UPDATE、DELETE和MERGE
语句修改。然而，允许UPDATE或MERGE更改某行，使其不再满足
WHERE条件，因此不再通过视图可见。同样，INSERT或
MERGE命令可能插入不满足WHERE条件的基表行，因此不通过视图
可见（ON CONFLICT UPDATE也可能影响视图不可见的现有行）。可以使用
CHECK OPTION防止INSERT、UPDATE和
MERGE命令创建此类视图不可见的行。
如果一个自动可更新视图被标记了security_barrier属性，那么
所有该属性的WHERE条件（以及任何使用标记为
LEAKPROOF的操作符的条件）将在该视图使用者的任何条件
之前计算。详见第 39.5 节。注意正因为这样，不会
被最终返回的行（因为它们不会通过用户的WHERE条件）可能
仍会结束被锁定的状态。可以用EXPLAIN来查看
哪些条件被应用在关系层面（并且因此不锁定行）以及哪些不会被应用在关系
层面。
一个更复杂的视图，如果不满足所有这些条件，默认是只读的：系统不会允许
对视图执行INSERT、UPDATE、DELETE或
MERGE操作。你可以通过在视图上创建INSTEAD OF触发器来实现
可更新视图的效果，这些触发器必须将对视图的插入等尝试转换为对其他表的相应操作。
更多信息请参见CREATE TRIGGER。另一种可能是创建规则
（参见CREATE RULE），但实际上触发器更容易理解和正确使用。
另外请注意，带有规则的关系不支持MERGE操作。
注意，执行对视图进行插入、更新或删除操作的用户必须对该视图具有相应的插入、更新或删除权限。
另外，默认情况下，视图的所有者必须对底层基本关系具有相关权限，而执行更新操作的用户不需要对底层基本关系有任何权限
（参见第 39.5 节）。然而，如果视图的security_invoker设置为true，
执行更新操作的用户，而不是视图所有者，必须对底层基本关系具有相关权限。
示例
创建一个由所有喜剧电影组成的视图：
CREATE VIEW comedies AS
SELECT *
FROM films
WHERE kind = 'Comedy';
创建的视图包含创建时film表中的列。尽管*
被用来创建该视图，后来加入到该表中的列不会成为该视图的组成部分。
创建带有LOCAL CHECK OPTION的视图：
CREATE VIEW universal_comedies AS
SELECT *
FROM comedies
WHERE classification = 'U'
WITH LOCAL CHECK OPTION;
这将创建一个基于comedies视图的视图，只显示
kind = 'Comedy'和classification = 'U'的电影。
如果新行没有classification = 'U'，在该视图中的任何
INSERT或UPDATE尝试将被拒绝，
但是电影的kind将不会被检查。
创建一个带有CASCADED CHECK OPTION的视图：
CREATE VIEW pg_comedies AS
SELECT *
FROM comedies
WHERE classification = 'PG'
WITH CASCADED CHECK OPTION;
这将创建一个检查新行的kind和classification
的视图。
创建一个由可更新列和不可更新列混合而成的视图：
CREATE VIEW comedies AS
SELECT f.*,
country_code_to_name(f.country_code) AS country,
(SELECT avg(r.rating)
FROM user_ratings r
WHERE r.film_id = f.id) AS avg_rating
FROM films f
WHERE f.kind = 'Comedy';
这个视图将支持INSERT、UPDATE
以及DELETE。所有来自于films表的列都
将是可更新的，而计算列country和avg_rating
将是只读的。
创建一个由数字 1 到 100 组成的递归视图：
CREATE RECURSIVE VIEW public.nums_1_100 (n) AS
VALUES (1)
UNION ALL
SELECT n+1 FROM nums_1_100 WHERE n < 100;
注意在这个CREATE中尽管递归的视图名称是方案限定的，但它内部的自引用不是方案限定的。这是因为隐式创建的CTE的名称不能是方案限定的。
兼容性
CREATE OR REPLACE VIEW是一个PostgreSQL语言扩展。
临时视图的概念也是如此。
WITH ( ... )子句也是一个扩展，安全屏障视图和安全调用者视图也是如此。
另请参阅ALTER VIEW, DROP VIEW, CREATE MATERIALIZED VIEW上一页 上一级 下一页CREATE USER MAPPING 起始页 DEALLOCATE
