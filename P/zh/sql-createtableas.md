# CREATE TABLE AS

CREATE TABLE AS
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TABLE ASCREATE TABLE AS — 从查询的结果定义一个新表大纲
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
[ (column_name [, ...] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
AS query
[ WITH [ NO ] DATA ]
描述
CREATE TABLE AS 创建一个表，并且用
由一个 SELECT 命令计算出来的数据填充
该表。该表的列具有和 SELECT 的输出列
相关的名称和数据类型（不过可以通过给出一个显式的新列名列表来覆
盖这些列名）。
CREATE TABLE AS 和创建一个视图有些
相似，但是实际上非常不同：它会创建一个新表并且只计算该查询一次
用来初始填充新表。这个新表将不会跟踪该查询源表的后续变化。相反，
一个视图只要被查询，它的定义 SELECT
语句就会被重新计算。
CREATE TABLE AS 需要用于表的模式上的 CREATE 权限。
参数GLOBAL或LOCAL
为兼容性而忽略。不推荐使用这些关键词；详见
CREATE TABLE。
TEMPORARY或TEMP
如果被指定，该表会被创建为一个临时表。详见
CREATE TABLE。
UNLOGGED
如果被指定，该表会被创建为一个不记录日志的表。详见
CREATE TABLE。
IF NOT EXISTS
如果已经存在同名关系，则不会抛出错误；只会发出通知并保持表不变。
table_name
要创建的表的名称（可选的模式限定）。
column_name
新表中一列的名称。如果没有提供列名，会从查询的输出列名中获取。
USING method
这个可选的子句指定了用于存储新表内容的表访问方法；该方法需要是一个类型 TABLE的访问方法。详见第 62 章。
如果没有指定这个选项，则选择新表的默认表访问方法。详见default_table_access_method。
WITH ( storage_parameter [= value] [, ... ] )
这个子句为新表指定可选的存储参数，详见Storage Parameters在
CREATE TABLE文档中的更多信息。
为了向后兼容，表的WITH子句也能包含OIDS=FALSE来指定新表的行将不包含OID（对象标识符）。OIDS=TRUE不再支持。
WITHOUT OIDS
这是向后兼容的语法，用于声明表WITHOUT OIDS，创建表WITH OIDS不再被支持。
ON COMMIT
临时表在事务块结束时的行为可以用ON COMMIT
控制。三个选项是：
PRESERVE ROWS
在事务结束时不采取特殊的动作。这是默认行为。
DELETE ROWS
在每一个事务块结束时临时表中的所有行都将被删除。本质上，
在每次提交时会完成一次自动的TRUNCATE。
DROP
在当前事务块结束时将删掉临时表。
TABLESPACE tablespace_name
tablespace_name
是要在其中创建新表的表空间名称。如果没有指定，将会查询
default_tablespace，如果是临时表则查询
temp_tablespaces。
query
一个SELECT、TABLE，或VALUES
命令，或者是一个运行准备好的SELECT、TABLE或
VALUES查询的EXECUTE命令。
WITH [ NO ] DATA
这个子句指定查询产生的数据是否应该被复制到新表中。如果不是，只有
表结构会被复制。默认是复制数据。
注释
这个命令在功能上类似于SELECT INTO，但是它更好，
因为不太可能被SELECT INTO语法的其他使用混淆。更
进一步，CREATE TABLE AS提供了
SELECT INTO的功能的一个超集。
示例
创建一个新表films_recent，它只由表
films中最近的项组成：
CREATE TABLE films_recent AS
SELECT * FROM films WHERE date_prod >= '2002-01-01';
要完全地复制一个表，也可以使用TABLE命令的
简短形式：
CREATE TABLE films2 AS
TABLE films;
用一个预备语句创建一个新的临时表films_recent，
它仅由表films中最近的项组成，使用准备好的语句。新表将在提交时被丢弃：
PREPARE recentfilms(date) AS
SELECT * FROM films WHERE date_prod > $1;
CREATE TEMP TABLE films_recent ON COMMIT DROP AS
EXECUTE recentfilms('2002-01-01');
兼容性
CREATE TABLE AS符合
SQL标准。下面的是非标准扩展：
标准要求在子查询子句周围有圆括号，在
PostgreSQL中这些圆括号是可选的。
在标准中，WITH [ NO ] DATA子句是必要的，而
PostgreSQL中是可选的。
PostgreSQL处理临时表的方式和标准不同。
详见CREATE TABLE。
WITH子句是一种
PostgreSQL扩展，
标准中没有存储参数。
PostgreSQL的表空间概念不是标准的一部分。
因此，子句TABLESPACE是一种扩展。
另见CREATE MATERIALIZED VIEW, CREATE TABLE, EXECUTE, SELECT, SELECT INTO, VALUES上一页 上一级 下一页CREATE TABLE 起始页 CREATE TABLESPACE
