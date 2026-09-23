# CREATE SCHEMA

CREATE SCHEMA
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE SCHEMACREATE SCHEMA — 定义一个新模式大纲
CREATE SCHEMA schema_name [ AUTHORIZATION role_specification ] [ schema_element [ ... ] ]
CREATE SCHEMA AUTHORIZATION role_specification [ schema_element [ ... ] ]
CREATE SCHEMA IF NOT EXISTS schema_name [ AUTHORIZATION role_specification ]
CREATE SCHEMA IF NOT EXISTS AUTHORIZATION role_specification
其中 role_specification 可以是：
user_name
| CURRENT_ROLE
| CURRENT_USER
| SESSION_USER
描述
CREATE SCHEMA输入一个新模式到当前数据库中。
该模式名必须与当前数据库中任何现有模式的名称不同。
一个模式本质上是一个名字空间：它包含命名对象（表、数据类型、函数以及操作符），
对象可以与在其他模式中存在的对象重名。可以通过用模式名作为一个前缀
“限定”命名对象的名称来访问它们，或者通过把要求的模式包括
在搜索路径中来访问命名对象。一个指定非限定对象名的
CREATE命令在当前模式（搜索路径中的第一个模式，由函数
current_schema决定）中创建对象。
可选地，CREATE SCHEMA中可以包括子命令
用以在新模式中创建对象。这些子命令实际被当做独立的在创建该模式后被发出的命令
一样，除非使用AUTHORIZATION子句，所有被创建的对象都会
由该用户拥有。
参数schema_name
要创建的一个模式名。如果省略，
user_name
将被用作模式名。该名称不能以pg_开始，
因为这样的名称是保留给系统模式的。
user_name
将拥有新模式的用户的角色名称。如果省略，则默认为执行命令的用户。
要创建由其他角色拥有的模式，您必须能够SET ROLE
为该角色。
schema_element
要在该模式中创建的对象的定义 SQL 语句。当前，只有CREATE
TABLE、CREATE VIEW、CREATE
INDEX、CREATE SEQUENCE、CREATE
TRIGGER以及GRANT被接受为
CREATE SCHEMA中的子句。其他类型的对象可以在模式被
创建之后用单独的命令创建。
IF NOT EXISTS
如果一个具有同名的模式已经存在，则什么也不做（不过发出一个提示）。
使用这个选项时不能包括
schema_element子命令。
注释
要创建一个模式，调用用户必须拥有当前数据库的CREATE
特权（当然，超级用户可以绕过此检查）。
示例
创建一个模式：
CREATE SCHEMA myschema;
为用户joe创建一个模式，该模式也将被命名为
joe：
CREATE SCHEMA AUTHORIZATION joe;
创建一个被用户joe拥有的名为test的模式，
除非已经有一个名为test的模式（不管joe
是否拥有该已经存在的模式）。
CREATE SCHEMA IF NOT EXISTS test AUTHORIZATION joe;
创建一个模式并且在其中创建一个表和视图：
CREATE SCHEMA hollywood
CREATE TABLE films (title text, release date, awards text[])
CREATE VIEW winners AS
SELECT title, release FROM films WHERE awards IS NOT NULL;
注意子命令不以分号结束。
下面是达到相同结果的等效的方法：
CREATE SCHEMA hollywood;
CREATE TABLE hollywood.films (title text, release date, awards text[]);
CREATE VIEW hollywood.winners AS
SELECT title, release FROM hollywood.films WHERE awards IS NOT NULL;
兼容性
SQL 标准允许在CREATE SCHEMA中有一个
DEFAULT CHARACTER SET子句，以及当前
PostgreSQL接受的更多子命令类型。
SQL 标准制定CREATE SCHEMA中的子命令
可以以任何顺序出现。当前的
PostgreSQL实现不能处理子命令中
所有情况的向前引用。有时候可能有必要对子命令进行重排序以避免向前
引用。
根据 SQL 标准，模式的拥有者总是拥有其中的所有对象。
PostgreSQL允许模式包含非模式
拥有者所拥有的对象。只有模式拥有者把其模式上的CREATE
特权授予给了其他人或者一个超级用户选择在该模式中创建对象时才会
发生这种事情。
IF NOT EXISTS 选项是一种
PostgreSQL 扩展。
另请参阅ALTER SCHEMA, DROP SCHEMA上一页 上一级 下一页CREATE RULE 起始页 CREATE SEQUENCE
