# CREATE PUBLICATION

CREATE PUBLICATION
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE PUBLICATIONCREATE PUBLICATION — 定义一个新的发布大纲
CREATE PUBLICATION name
[ FOR ALL TABLES
| FOR publication_object [, ... ] ]
[ WITH ( publication_parameter [= value] [, ... ] ) ]
其中 publication_object 是以下之一：
TABLE table_and_columns [, ... ]
TABLES IN SCHEMA { schema_name | CURRENT_SCHEMA } [, ... ]
并且 table_and_columns 是：
[ ONLY ] table_name [ * ] [ ( column_name [, ... ] ) ] [ WHERE ( expression ) ]
描述
CREATE PUBLICATION向当前数据库添加一个新的发布。
发布的名称必须与当前数据库中任何现有发布的名称不同。
发布本质上是一组表，其数据更改旨在通过逻辑复制进行复制。
有关发布如何适应逻辑复制设置的详细信息，
请参见第 29.1 节。
参数name #
新发布的名称。
FOR TABLE #
指定要添加到发布的表的列表。如果在表名之前指定了ONLY，
那么只有该表被添加到发布中。如果没有指定ONLY，
则添加表及其所有后代表（如果有的话）。可选地，可以在表名之后指定
*以明确指示包含后代表。但是，这不适用于分区表。
分区表的分区始终被隐式视为发布的一部分，因此永远不会明确将其添加到发布中。
如果指定了可选的WHERE子句，则定义了一个row filter表达式。
对于expression评估为false或null的行将不会被发布。
请注意，表达式周围需要括号。它对TRUNCATE命令没有影响。
当指定列列表时，仅复制指定的列。
列列表也可以包含存储生成的列。如果省略列列表，
则默认情况下，发布将复制所有非生成列（包括将来添加的列）。
如果将 publish_generated_columns 设置为
stored，则也可以复制存储生成的列。
指定列列表对 TRUNCATE 命令没有影响。
有关列列表的详细信息，请参见
第 29.5 节。
只有持久基表和分区表才能成为发布的一部分。
临时表，未记录表，外部表，物化视图和常规视图不能成为发布的一部分。
当发布也发布 FOR TABLES IN SCHEMA 时，不支持指定列列表。
将分区表添加到发布时，其所有现有分区和将来分区都被隐式视为发布的一部分。
因此，即使直接在分区上执行的操作也会通过其祖先所在的发布来发布。
FOR ALL TABLES #
将发布标记为复制数据库中所有表的更改，包括在将来创建的表。
FOR TABLES IN SCHEMA #
将该发布标记为复制指定模式列表中所有表的更改的发布，包括将来创建的表。
当发布还发布带有列列表的表时，不支持指定模式。
只有模式中存在的持久基表和分区表将作为发布的一部分包含在内。临时表、无日志表、外部表、物化视图以及来自模式的常规视图将不会成为发布的一部分。
当通过模式级别发布来发布分区表时，所有现有和未来的分区都被隐式地视为发布的一部分，无论它们是否来自发布模式。
因此，即使直接在分区上执行操作，也会通过其祖先所属的发布进行发布。
WITH ( publication_parameter [= value] [, ... ] ) #
此子句指定发布的可选参数。
支持以下参数：
publish (string) #
此参数确定新发布将向订阅者发布哪些 DML 操作。
值是以逗号分隔的操作列表。允许的操作有
insert、update、
delete 和 truncate。
默认情况下发布所有操作，
因此此选项的默认值为
'insert, update, delete, truncate'。
此参数仅影响 DML 操作。特别是，初始
数据同步（参见 第 29.9.1 节）
在复制现有表数据时不考虑此参数。
publish_generated_columns (enum) #
指定与发布关联的表中是否应复制生成的列。
可能的值为 none 和 stored。
默认值为 none，这意味着与发布关联的表中的生成
列将不会被复制。
如果设置为 stored，则与发布关联的表中
存储的生成列将被复制。
注意
如果订阅者来自 18 之前的版本，则初始表
同步不会复制生成的列，即使在发布者中
参数 publish_generated_columns 设置为 stored。
有关生成列的逻辑复制的更多详细信息，请参见
第 29.6 节。
publish_via_partition_root (boolean) #
此参数控制如何发布对分区表（或其任何分区）的更改。
当设置为 true 时，更改将使用根分区表的身份和模式进行发布。
当设置为 false（默认值）时，更改将使用实际发生更改的各个分区的身份和模式进行发布。
启用此选项允许将更改复制到非分区表或其分区结构与发布者不同的分区表中。
可能存在一种情况，其中一个订阅组合了多个发布。如果一个分区表被任何设置了
publish_via_partition_root = true 的订阅发布发布，则该分区表（或其分区）上的更改将使用该分区表的身份和模式进行发布，而不是各个分区的身份和模式。
此参数还会影响如何为分区选择行过滤器和列列表；有关详细信息，请参见下文。
如果启用，直接在分区上执行的 TRUNCATE 操作将不会被复制。
当指定类型为boolean的参数时，
=value
部分可以省略，这等同于指定TRUE。
Notes
如果未指定FOR TABLE、FOR ALL TABLES或
FOR TABLES IN SCHEMA，则发布将以空表集开始。这在稍后要添加表或模式时很有用。
创建发布不会开始复制。它只为未来的订阅者定义一个分组和过滤逻辑。
要创建一个发布，调用者必须拥有当前数据库的CREATE权限。
（当然，超级用户不需要这个检查。）
要向publication添加表，调用用户必须对表拥有所有权。使用FOR ALL TABLES和
FOR TABLES IN SCHEMA子句需要调用用户是超级用户。
添加到发布UPDATE和/或DELETE
操作的表必须已经定义了REPLICA IDENTITY。
否则将在这些表上禁止这些操作。
任何列列表必须包括REPLICA IDENTITY列，以便UPDATE或DELETE操作被发布。
如果发布只涉及INSERT操作，则没有列列表限制。
行过滤表达式（即，WHERE子句）必须仅包含由REPLICA IDENTITY覆盖的列，
以便UPDATE和DELETE操作被发布。对于INSERT操作的发布，
可以在WHERE表达式中使用任何列。行过滤器允许简单表达式，不包括
用户定义函数、用户定义运算符、用户定义类型、用户定义排序规则、非不可变内置函数，或对
系统列的引用。
属于REPLICA IDENTITY的生成列必须通过在列列表中列出它们或启用publish_generated_columns选项显式发布，以便UPDATE和DELETE操作能够被发布。
如果指定了FOR TABLES IN SCHEMA，并且表属于引用的模式，则表上的行过滤器变得多余。
对于已发布的分区表，如果发布参数publish_via_partition_root为true，
则每个分区的行过滤器来自已发布的分区表，如果为false（默认值），
则来自分区本身。有关行过滤器的详细信息，请参见第 29.4 节。
类似地，对于已发布的分区表，如果发布参数publish_via_partition_root为true，
则每个分区的列列表来自已发布的分区表，如果为false，则来自分区本身。
对于INSERT ... ON CONFLICT命令，发布将发布由该命令导致的操作。
根据结果，它可能被发布为INSERT或UPDATE，或者根本不被发布。
对于MERGE命令，发布将为每个插入、更新或删除的行发布一个
INSERT、UPDATE或DELETE。
将表ATTACH到一个以使用publish_via_partition_root
设置为true的发布的分区树的根部，不会导致表的现有内容被复制。
COPY ... FROM命令是作为INSERT操作发布的。
不发布DDL操作。
WHERE子句表达式是使用用于复制连接的角色执行的。
示例
创建一个发布，发布两个表中所有更改：
CREATE PUBLICATION mypublication FOR TABLE users, departments;
创建一个发布，发布所有来自活跃部门的更改：
CREATE PUBLICATION active_departments FOR TABLE departments WHERE (active IS TRUE);
创建一个发布，发布所有表中的所有更改：
CREATE PUBLICATION alltables FOR ALL TABLES;
创建一个只发布INSERT操作的发布，针对一个表：
CREATE PUBLICATION insert_only FOR TABLE mydata
WITH (publish = 'insert');
创建一个发布，发布所有表users，departments的更改，
以及模式production中所有表的更改：
CREATE PUBLICATION production_publication FOR TABLE users, departments, TABLES IN SCHEMA production;
创建一个发布，发布位于模式marketing和sales中的所有表的所有更改：
CREATE PUBLICATION sales_publication FOR TABLES IN SCHEMA marketing, sales;
创建一个发布，发布表users的所有更改，但只复制user_id和
firstname两列：
CREATE PUBLICATION users_filtered FOR TABLE users (user_id, firstname);
兼容性
CREATE PUBLICATION是一个PostgreSQL
扩展。
另见ALTER PUBLICATION, DROP PUBLICATION, CREATE SUBSCRIPTION, ALTER SUBSCRIPTION上一页 上一级 下一页CREATE PROCEDURE 起始页 CREATE ROLE
