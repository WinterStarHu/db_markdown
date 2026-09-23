# ALTER PUBLICATION

ALTER PUBLICATION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER PUBLICATIONALTER PUBLICATION — 更改发布的定义大纲
ALTER PUBLICATION name ADD publication_object [, ...]
ALTER PUBLICATION name SET publication_object [, ...]
ALTER PUBLICATION name DROP publication_drop_object [, ...]
ALTER PUBLICATION name SET ( publication_parameter [= value] [, ... ] )
ALTER PUBLICATION name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER PUBLICATION name RENAME TO new_name
其中 publication_object 是以下之一：
TABLE table_and_columns [, ... ]
TABLES IN SCHEMA { schema_name | CURRENT_SCHEMA } [, ... ]
并且 publication_drop_object 是以下之一：
TABLE [ ONLY ] table_name [ * ] [, ... ]
TABLES IN SCHEMA { schema_name | CURRENT_SCHEMA } [, ... ]
并且 table_and_columns 是：
[ ONLY ] table_name [ * ] [ ( column_name [, ... ] ) ] [ WHERE ( expression ) ]
描述
命令ALTER PUBLICATION可以更改发布的属性。
前三个变体更改了哪些表/模式是出版物的一部分。SET 子句将用指定的列表替换出版物中的表/模式列表；出版物中存在的现有表/模式将被移除。ADD 和 DROP 子句将从出版物中添加和移除一个或多个表/模式。请注意，向已订阅的出版物添加表/模式将需要在订阅方执行
ALTER SUBSCRIPTION ... REFRESH PUBLICATION 操作才能生效。还请注意，DROP TABLES IN SCHEMA 不会删除使用
FOR TABLE/
ADD TABLE 指定的任何模式表。
第四条语句可以改变在CREATE PUBLICATION中指定的所有发布属性。
该命令中未提及的属性保留其先前的设置。
其余语句更改所有者和发布的名称。
您必须拥有该发布才能使用ALTER PUBLICATION。
向发布中添加表还需要拥有该表的权限。
ADD TABLES IN SCHEMA和
SET TABLES IN SCHEMA到发布中要求调用用户必须是超级用户。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须在数据库上具有CREATE权限。
此外，新的所有者必须是
FOR ALL TABLES
或 FOR TABLES IN SCHEMA
发布的超级用户。但是，超级用户可以不受这些限制更改发布的所有权。
当发布同时发布带有列列表的表时，不支持添加/设置任何模式，反之亦然。
参数name
要修改定义的现有发布的名称。
table_name
现有表的名称。如果在表名之前指定了ONLY，则只有该表受到影响。
如果没有指定ONLY，则该表及其所有后代表（如果有的话）都会受到影响。
可选地，可以在表名之后指定*以明确指示包含后代表。
可选地，可以指定列列表。有关详细信息，请参见CREATE PUBLICATION。
请注意，不支持在具有不同列列表的多个发布中发布相同表的情况。有关更改列列表时可能出现的问题的详细信息，请参见警告：合并来自多个发布的列列表。
如果指定了可选的WHERE子句，则expression
评估为false或null的行将不会被发布。请注意，表达式周围需要括号。
使用用于复制连接的角色评估expression。
schema_name
现有模式的名称。
SET ( publication_parameter [= value] [, ... ] )
该子句修改最初由CREATE PUBLICATION设置的发布参数。有关更多信息，请参见那里。
小心
修改 publish_via_partition_root 参数可能会导致订阅者的数据丢失或重复，因为它更改了已发布表的身份和模式。请注意，这仅在指定分区根表作为复制目标时发生。
通过在执行 ALTER PUBLICATION ... SET 后避免修改分区叶表，直到执行
ALTER SUBSCRIPTION ... REFRESH PUBLICATION
并且仅使用 copy_data = off 选项进行刷新，可以避免此问题。
new_owner
发布的新所有者的用户名。
new_name
发布的新名称。
示例
将发布修改为只发布删除和更新：
ALTER PUBLICATION noinsert SET (publish = 'update, delete');
向发布添加一些表：
ALTER PUBLICATION mypublication ADD TABLE users (user_id, firstname), departments;
更改表的发布列集合:
ALTER PUBLICATION mypublication SET TABLE users (user_id, firstname, lastname), TABLE departments;
将模式marketing和sales添加到发布sales_publication中：
ALTER PUBLICATION sales_publication ADD TABLES IN SCHEMA marketing, sales;
将表users、departments和模式
production添加到发布production_publication中：
ALTER PUBLICATION production_publication ADD TABLE users, departments, TABLES IN SCHEMA production;
兼容性
ALTER PUBLICATION是PostgreSQL的一个扩展。
另见CREATE PUBLICATION, DROP PUBLICATION, CREATE SUBSCRIPTION, ALTER SUBSCRIPTION上一页 上一级 下一页ALTER PROCEDURE 起始页 ALTER ROLE
