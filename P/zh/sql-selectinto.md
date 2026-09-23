# SELECT INTO

SELECT INTO
版本：
纠错本页面
搜索
目录导航
❮
❯
SELECT INTOSELECT INTO — 从查询的结果定义一个新表大纲
[ WITH [ RECURSIVE ] with_query [, ...] ]
SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
[ { * | expression [ [ AS ] output_name ] } [, ...] ]
INTO [ TEMPORARY | TEMP | UNLOGGED ] [ TABLE ] new_table
[ FROM from_item [, ...] ]
[ WHERE condition ]
[ GROUP BY expression [, ...] ]
[ HAVING condition ]
[ WINDOW window_name AS ( window_definition ) [, ...] ]
[ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
[ LIMIT { count | ALL } ]
[ OFFSET start [ ROW | ROWS ] ]
[ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
[ FOR { UPDATE | SHARE } [ OF table_name [, ...] ] [ NOWAIT ] [...] ]
描述
SELECT INTO创建一个新表并用查询
计算得到的数据填充它。这些数据不会像普通的
SELECT那样被返回给客户端。新表的列具有
和SELECT的输出列相关的名称和数据类型。
参数TEMPORARY or TEMP
如果指定，该表被创建为临时表。详见
CREATE TABLE。
UNLOGGED
如果被指定，该表被创建为一个不记录日志的表。详见
CREATE TABLE。
new_table
要创建的表的名称（可以是模式限定的）。
所有其他参数在 SELECT 中有详细描述。
备注
CREATE TABLE AS 在功能上与
SELECT INTO 相似。CREATE TABLE AS
是被推荐的语法，因为这种形式的 SELECT
INTO 在 ECPG
或 PL/pgSQL 中不可用，因为它们对
INTO 子句的解释不同。此外，
CREATE TABLE AS 提供的功能是
SELECT INTO 的超集。
与 CREATE TABLE AS 相比， SELECT
INTO 不允许使用 USING method 指定表的访问方法，
也不允许使用 TABLESPACE tablespace_name 指定表的表空间。如有必要，请使用 CREATE TABLE AS。
因此，新表将选择默认的表访问方法。有关更多信息，请参见 default_table_access_method。
示例
创建一个只由来自 films 的最近项构成的
新表 films_recent：
SELECT * INTO films_recent FROM films WHERE date_prod >= '2002-01-01';
兼容性
SQL 标准使用SELECT INTO表示把值选择到一个宿主程序的标量变量中，而不是创建一个新表。
这实际上就是ECPG（见第 34 章）和PL/pgSQL（见第 41 章）中的用法。
PostgreSQL使用SELECT INTO来表示表创建是有历史原因的。
一些其他SQL实现也以此方式使用SELECT INTO（但是大多数SQL实现支持CREATE TABLE AS）。
除了这样的兼容性考虑之外，最好在新代码中使用CREATE TABLE AS。
另见CREATE TABLE AS上一页 上一级 下一页SELECT 起始页 SET
