# 29.4. 行过滤器

29.4. 行过滤器
版本：
纠错本页面
搜索
目录导航
❮
❯
29.4. 行过滤器 #29.4.1. 行过滤规则29.4.2. 表达式限制29.4.3. UPDATE Transformations29.4.4. 分区表29.4.5. 初始数据同步29.4.6. 组合多个行过滤器29.4.7. 示例
默认情况下，所有已发布表中的所有数据都将被复制到相应的订阅者。可以通过使用行过滤器来减少复制的数据。
用户可能出于行为、安全或性能原因选择使用行过滤器。如果已发布表设置了行过滤器，则仅当其数据满足行过滤器表达式时才复制一行。
这允许部分复制一组表。行过滤器是针对每个表定义的。对于需要过滤数据的每个已发布表，在表名后使用WHERE子句。
WHERE子句必须用括号括起来。有关详细信息，请参见CREATE PUBLICATION。
29.4.1. 行过滤规则 #
行过滤器在发布更改之前应用。如果行过滤器的计算结果为
false或NULL，则该行不会被复制。WHERE
子句表达式使用与复制连接相同的角色进行计算（即在
CONNECTION
子句中指定的角色，见CREATE SUBSCRIPTION）。行过滤器对
TRUNCATE命令无效。
29.4.2. 表达式限制 #
WHERE子句只允许简单表达式。它不能包含用户定义的函数、操作符、类型和排序规则、系统列引用或非不可变内置函数。
如果一个发布包含UPDATE或DELETE操作，行过滤器WHERE子句必须只包含副本标识覆盖的列
(参见REPLICA IDENTITY)。如果一个发布仅发布
INSERT操作，行过滤器WHERE子句可以使用任何列。
29.4.3. UPDATE Transformations #
每当处理UPDATE时，都会对旧行和新行的行过滤表达式进行评估（即使用更新前和更新后的数据）。
如果两次评估都为true，则复制UPDATE更改。
如果两次评估都为false，则不复制更改。
如果旧行/新行中只有一个与行过滤表达式匹配，则将UPDATE转换为INSERT或DELETE，
以避免任何数据不一致。订阅者上的行应反映发布者上行过滤表达式定义的内容。
如果旧行满足行过滤表达式（已发送给订阅者），但新行不满足，则从数据一致性的角度来看，
应该从订阅者中删除旧行。因此UPDATE被转换为DELETE。
如果旧行不满足行过滤表达式（它没有发送给订阅者），但新行满足，则从数据一致性的角度来看，
应将新行添加到订阅者。
因此，UPDATE被转换为INSERT。
表 29.1
总结了应用的转换。
表 29.1. UPDATE Transformation Summary旧行新行转换no matchno match不复制不匹配匹配INSERT匹配不匹配DELETE匹配匹配UPDATE29.4.4. 分区表 #
如果发布包含分区表，则发布参数
publish_via_partition_root
决定使用哪个行过滤器。如果 publish_via_partition_root
为 true，则使用根分区表的行过滤器。
否则，如果 publish_via_partition_root 为 false
（默认），则使用每个分区的行过滤器。
29.4.5. 初始数据同步 #
如果订阅需要复制预先存在的表数据，并且发布包含WHERE子句，
则只有满足行过滤表达式的数据才会被复制到订阅者。
如果订阅中有几个publication发布了带有不同WHERE子句的表，满足任何表达式的行将被复制。
有关详细信息，请参见第 29.4.6 节。
警告
由于初始数据同步在复制现有表数据时未考虑
publish
参数，因此可能会复制一些使用DML不会被复制的行。请参阅
第 29.9.1 节, 并查看
第 29.2.2 节 了解示例。
注意
如果订阅者使用的是早于15版本的发布版，即使在发布中定义了行过滤器，复制预先存在的数据也不会使用行过滤器。
这是因为旧版本只能复制整个表的数据。
29.4.6. 组合多个行过滤器 #
如果订阅包含多个发布，其中同一张表在不同的行过滤条件下被发布（针对相同的
publish
操作），这些表达式会被用 OR 连接，因此满足
任意表达式的行都会被复制。这意味着如果满足以下条件，
同一张表的其他行过滤条件将变得多余：
某个发布没有行过滤条件。
某个发布是使用
FOR ALL TABLES
创建的。该子句不允许行过滤条件。
某个发布是使用
FOR TABLES IN SCHEMA
创建的，且该表属于指定的模式。该子句不允许行过滤条件。
29.4.7. 示例 #
创建一些表以用于以下示例。
/* pub # */ CREATE TABLE t1(a int, b int, c text, PRIMARY KEY(a,c));
/* pub # */ CREATE TABLE t2(d int, e int, f int, PRIMARY KEY(d));
/* pub # */ CREATE TABLE t3(g int, h int, i int, PRIMARY KEY(g));
创建一些出版物。出版物 p1 有一个表
(t1)，并且该表有一个行过滤器。出版物
p2 有两个表。表 t1 没有行过滤器，而表 t2 有一个行过滤器。出版物
p3 有两个表，并且它们都有一个行过滤器。
/* pub # */ CREATE PUBLICATION p1 FOR TABLE t1 WHERE (a > 5 AND c = 'NSW');
/* pub # */ CREATE PUBLICATION p2 FOR TABLE t1, t2 WHERE (e = 99);
/* pub # */ CREATE PUBLICATION p3 FOR TABLE t2 WHERE (d = 10), t3 WHERE (g = 10);
psql 可用于显示每个出版物的行过滤器表达式（如果已定义）。
/* pub # */ \dRp+
Publication p1
Owner   | All tables | Inserts | Updates | Deletes | Truncates | Generated columns | Via root
----------+------------+---------+---------+---------+-----------+-------------------+----------
postgres | f          | t       | t       | t       | t         | none              | f
Tables:
"public.t1" WHERE ((a > 5) AND (c = 'NSW'::text))
Publication p2
Owner   | All tables | Inserts | Updates | Deletes | Truncates | Generated columns | Via root
----------+------------+---------+---------+---------+-----------+-------------------+----------
postgres | f          | t       | t       | t       | t         | none              | f
Tables:
"public.t1"
"public.t2" WHERE (e = 99)
Publication p3
Owner   | All tables | Inserts | Updates | Deletes | Truncates | Generated columns | Via root
----------+------------+---------+---------+---------+-----------+-------------------+----------
postgres | f          | t       | t       | t       | t         | none              | f
Tables:
"public.t2" WHERE (d = 10)
"public.t3" WHERE (g = 10)
psql 可用于显示每个表的行过滤器表达式（如果已定义）。请注意，表 t1 是两个出版物的成员，但仅在 p1 中有行过滤器。
请注意，表 t2 是两个出版物的成员，并且在每个出版物中有不同的行过滤器。
/* pub # */ \d t1
Table "public.t1"
Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
a      | integer |           | not null |
b      | integer |           |          |
c      | text    |           | not null |
Indexes:
"t1_pkey" PRIMARY KEY, btree (a, c)
Publications:
"p1" WHERE ((a > 5) AND (c = 'NSW'::text))
"p2"
/* pub # */ \d t2
Table "public.t2"
Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
d      | integer |           | not null |
e      | integer |           |          |
f      | integer |           |          |
Indexes:
"t2_pkey" PRIMARY KEY, btree (d)
Publications:
"p2" WHERE (e = 99)
"p3" WHERE (d = 10)
/* pub # */ \d t3
Table "public.t3"
Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
g      | integer |           | not null |
h      | integer |           |          |
i      | integer |           |          |
Indexes:
"t3_pkey" PRIMARY KEY, btree (g)
Publications:
"p3" WHERE (g = 10)
在订阅节点上，创建一个与发布者上相同定义的表 t1，并创建订阅 s1，该订阅订阅出版物 p1。
/* sub # */ CREATE TABLE t1(a int, b int, c text, PRIMARY KEY(a,c));
/* sub # */ CREATE SUBSCRIPTION s1
/* sub - */ CONNECTION 'host=localhost dbname=test_pub application_name=s1'
/* sub - */ PUBLICATION p1;
插入一些行。只有满足发布 p1 的
t1 WHERE 子句的行会被复制。
/* pub # */ INSERT INTO t1 VALUES (2, 102, 'NSW');
/* pub # */ INSERT INTO t1 VALUES (3, 103, 'QLD');
/* pub # */ INSERT INTO t1 VALUES (4, 104, 'VIC');
/* pub # */ INSERT INTO t1 VALUES (5, 105, 'ACT');
/* pub # */ INSERT INTO t1 VALUES (6, 106, 'NSW');
/* pub # */ INSERT INTO t1 VALUES (7, 107, 'NT');
/* pub # */ INSERT INTO t1 VALUES (8, 108, 'QLD');
/* pub # */ INSERT INTO t1 VALUES (9, 109, 'NSW');
/* pub # */ SELECT * FROM t1;
a |  b  |  c
---+-----+-----
2 | 102 | NSW
3 | 103 | QLD
4 | 104 | VIC
5 | 105 | ACT
6 | 106 | NSW
7 | 107 | NT
8 | 108 | QLD
9 | 109 | NSW
(8 rows)
/* sub # */ SELECT * FROM t1;
a |  b  |  c
---+-----+-----
6 | 106 | NSW
9 | 109 | NSW
(2 rows)
更新一些数据，旧行和新行的值都满足发布
p1 的 t1 WHERE 子句。
UPDATE 会正常复制该更改。
/* pub # */ UPDATE t1 SET b = 999 WHERE a = 6;
/* pub # */ SELECT * FROM t1;
a |  b  |  c
---+-----+-----
2 | 102 | NSW
3 | 103 | QLD
4 | 104 | VIC
5 | 105 | ACT
7 | 107 | NT
8 | 108 | QLD
9 | 109 | NSW
6 | 999 | NSW
(8 rows)
/* sub # */ SELECT * FROM t1;
a |  b  |  c
---+-----+-----
9 | 109 | NSW
6 | 999 | NSW
(2 rows)
更新一些数据，旧行的值不满足发布 p1 的
t1 WHERE 子句，但新行的值满足它。
UPDATE 被转换为 INSERT，
并且该更改被复制。请查看订阅者上的新行。
/* pub # */ UPDATE t1 SET a = 555 WHERE a = 2;
/* pub # */ SELECT * FROM t1;
a  |  b  |  c
---+-----+-----
3 | 103 | QLD
4 | 104 | VIC
5 | 105 | ACT
7 | 107 | NT
8 | 108 | QLD
9 | 109 | NSW
6 | 999 | NSW
555 | 102 | NSW
(8 rows)
/* sub # */ SELECT * FROM t1;
a  |  b  |  c
---+-----+-----
9 | 109 | NSW
6 | 999 | NSW
555 | 102 | NSW
(3 rows)
更新一些数据，旧行的值满足发布 p1 的
t1 WHERE 子句，但新行的值不满足它。
UPDATE 被转换为 DELETE，
并且该更改被复制。请查看该行是否从订阅者中移除。
/* pub # */ UPDATE t1 SET c = 'VIC' WHERE a = 9;
/* pub # */ SELECT * FROM t1;
a  |  b  |  c
---+-----+-----
3 | 103 | QLD
4 | 104 | VIC
5 | 105 | ACT
7 | 107 | NT
8 | 108 | QLD
6 | 999 | NSW
555 | 102 | NSW
9 | 109 | VIC
(8 rows)
/* sub # */ SELECT * FROM t1;
a  |  b  |  c
---+-----+-----
6 | 999 | NSW
555 | 102 | NSW
(2 rows)
以下示例展示了发布参数
publish_via_partition_root
如何决定在分区表的情况下，使用父表还是子表的行过滤器。
在发布者上创建一个分区表。
/* pub # */ CREATE TABLE parent(a int PRIMARY KEY) PARTITION BY RANGE(a);
/* pub # */ CREATE TABLE child PARTITION OF parent DEFAULT;
在订阅者上创建相同的表。
/* sub # */ CREATE TABLE parent(a int PRIMARY KEY) PARTITION BY RANGE(a);
/* sub # */ CREATE TABLE child PARTITION OF parent DEFAULT;
创建一个发布 p4，然后订阅它。
发布参数 publish_via_partition_root 被设置为 true。
在分区表 (parent) 和分区 (child) 上定义了行过滤器。
/* pub # */ CREATE PUBLICATION p4 FOR TABLE parent WHERE (a < 5), child WHERE (a >= 5)
/* pub - */ WITH (publish_via_partition_root=true);
/* sub # */ CREATE SUBSCRIPTION s4
/* sub - */ CONNECTION 'host=localhost dbname=test_pub application_name=s4'
/* sub - */ PUBLICATION p4;
直接向 parent 和 child 表插入一些值。
它们通过 parent 的行过滤器进行复制
（因为 publish_via_partition_root 为 true）。
/* pub # */ INSERT INTO parent VALUES (2), (4), (6);
/* pub # */ INSERT INTO child VALUES (3), (5), (7);
/* pub # */ SELECT * FROM parent ORDER BY a;
a
-−-
2
3
4
5
6
7
(6 rows)
/* sub # */ SELECT * FROM parent ORDER BY a;
a
-−-
2
3
4
(3 rows)
重复相同的测试，但将 publish_via_partition_root 的值更改为不同的值。
发布参数 publish_via_partition_root 被设置为 false。
在分区 (child) 上定义了行过滤器。
/* pub # */ DROP PUBLICATION p4;
/* pub # */ CREATE PUBLICATION p4 FOR TABLE parent, child WHERE (a >= 5)
/* pub - */ WITH (publish_via_partition_root=false);
/* sub # */ ALTER SUBSCRIPTION s4 REFRESH PUBLICATION;
在发布者上执行与之前相同的插入操作。
它们通过 child 的行过滤器进行复制
（因为 publish_via_partition_root 为 false）。
/* pub # */ TRUNCATE parent;
/* pub # */ INSERT INTO parent VALUES (2), (4), (6);
/* pub # */ INSERT INTO child VALUES (3), (5), (7);
/* pub # */ SELECT * FROM parent ORDER BY a;
a
-−-
2
3
4
5
6
7
(6 rows)
/* sub # */ SELECT * FROM child ORDER BY a;
a
-−-
5
6
7
(3 rows)
上一页 上一级 下一页29.3. 逻辑复制故障切换 起始页 29.5. 列列表
