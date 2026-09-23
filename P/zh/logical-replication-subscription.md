# 29.2. 订阅

29.2. 订阅
版本：
纠错本页面
搜索
目录导航
❮
❯
29.2. 订阅 #29.2.1. 复制槽管理29.2.2. 示例：设置逻辑复制29.2.3. 示例：延迟复制槽创建
订阅是逻辑复制的下游端。订阅被定义在其中的节点被称为订阅者。一个订阅会定义到另一个数据库的连接以及它想要订阅的发布集合（一个或多个）。
订阅者数据库的行为与任何其他 PostgreSQL 实例相同，并且可以被用作其他数据库的发布者，只需要定义它自己的发布。
如果需要，一个订阅者节点可以有多个订阅。可以在一对发布者-订阅者之间定义多个订阅，在这种情况下要确保被订阅的发布对象不会重叠。
每个订阅都将通过一个复制槽（见第 26.2.6 节）接收更改。预先存在的表数据的初始数据同步过程可能会要求额外的复制槽，并且在数据同步结束后删除。
逻辑复制订阅可以是同步复制（见第 26.2.8 节）的后备服务器。后备名称默认是该订阅的名称。可以在订阅的连接信息中用application_name指定一个可供选择的名称。
如果当前用户是超级用户，则订阅会被pg_dump转储。否则会写出一个警告并跳过订阅，因为非超级用户不能从pg_subscription目录中读取所有的订阅信息。
可以使用CREATE SUBSCRIPTION增加订阅，并且使用ALTER SUBSCRIPTION在任何时刻停止/恢复订阅，还可以使用DROP SUBSCRIPTION删除订阅。
当一个订阅被删除并重建时，同步信息会丢失。这意味着数据必须重新同步。
模式定义不会被复制，并且被发布的表必须在订阅者上存在。只有常规表可以成为复制的目标。例如，不能复制视图。
表在发布者和订阅者之间使用完全限定的表名进行匹配。不支持复制到订阅者上命名不同的表。
表的列也可以通过名称进行匹配。订阅表中的列顺序不需要与发布者的顺序相同。列的数据类型
不需要匹配，只要数据的文本表示可以转换为目标类型就可以。例如，可以从类型为integer的
列复制到类型为bigint的列。目标表还可以包含发布表未提供的额外列。任何此类列
都将使用目标表定义中指定的默认值进行填充。然而，二进制格式的逻辑复制限制更多。请参见
binary选项的
CREATE SUBSCRIPTION命令了解详情。
29.2.1. 复制槽管理 #
如早前所提到的，每一个（活跃的）订阅会从远程（发布）端上的一个复制槽接收更改。
额外的表同步槽通常是临时的，在内部创建以执行初始表同步，并在它们不再被需要时自动删除。这些表同步槽命名为: “pg_%u_sync_%u_%llu”
(参数是: Subscription oid,
Table relid, system identifier sysid)
通常，当使用
CREATE SUBSCRIPTION 创建订阅时，远程复制槽会自动创建，
并且当使用
DROP SUBSCRIPTION 删除订阅时，复制槽也会自动删除。
但是，在某些情况下，单独操作订阅和底层复制槽可能是有用或必要的。以下是一些场景：
创建订阅时，复制槽已经存在。在这种情况下，可以使用
create_slot = false 选项来关联现有的复制槽，从而创建订阅。
创建订阅时，远程主机不可达或状态不明。在这种情况下，可以使用
connect = false 选项创建订阅。这样远程主机将完全不会被联系。
这正是 pg_dump 使用的方式。远程复制槽必须手动创建，
然后订阅才能被激活。
删除订阅时，应保留复制槽。当订阅数据库被迁移到不同主机并从那里激活时，
这可能很有用。在这种情况下，应先使用
ALTER SUBSCRIPTION 将复制槽与订阅解除关联，
然后再尝试删除订阅。
删除订阅时，远程主机不可达。在这种情况下，应先使用
ALTER SUBSCRIPTION 将复制槽与订阅解除关联，
然后再尝试删除订阅。如果远程数据库实例已不存在，则无需进一步操作。
但如果远程数据库实例只是暂时不可达，则应手动删除复制槽（以及任何仍然存在的表同步槽）；
否则它们会继续占用 WAL，最终可能导致磁盘空间耗尽。此类情况应当谨慎调查。
29.2.2. 示例：设置逻辑复制 #
在发布者上创建一些测试表。
/* pub # */ CREATE TABLE t1(a int, b text, PRIMARY KEY(a));
/* pub # */ CREATE TABLE t2(c int, d text, PRIMARY KEY(c));
/* pub # */ CREATE TABLE t3(e int, f text, PRIMARY KEY(e));
在订阅者上创建相同的表。
/* sub # */ CREATE TABLE t1(a int, b text, PRIMARY KEY(a));
/* sub # */ CREATE TABLE t2(c int, d text, PRIMARY KEY(c));
/* sub # */ CREATE TABLE t3(e int, f text, PRIMARY KEY(e));
在发布者端向表中插入数据。
/* pub # */ INSERT INTO t1 VALUES (1, 'one'), (2, 'two'), (3, 'three');
/* pub # */ INSERT INTO t2 VALUES (1, 'A'), (2, 'B'), (3, 'C');
/* pub # */ INSERT INTO t3 VALUES (1, 'i'), (2, 'ii'), (3, 'iii');
为表创建发布。发布 pub2 和 pub3a
不允许某些 publish
操作。发布 pub3b 有一个行过滤器（见
第 29.4 节）。
/* pub # */ CREATE PUBLICATION pub1 FOR TABLE t1;
/* pub # */ CREATE PUBLICATION pub2 FOR TABLE t2 WITH (publish = 'truncate');
/* pub # */ CREATE PUBLICATION pub3a FOR TABLE t3 WITH (publish = 'truncate');
/* pub # */ CREATE PUBLICATION pub3b FOR TABLE t3 WHERE (e > 5);
为发布创建订阅。订阅 sub3 同时订阅 pub3a 和
pub3b。所有订阅默认将复制初始数据。
/* sub # */ CREATE SUBSCRIPTION sub1
/* sub - */ CONNECTION 'host=localhost dbname=test_pub application_name=sub1'
/* sub - */ PUBLICATION pub1;
/* sub # */ CREATE SUBSCRIPTION sub2
/* sub - */ CONNECTION 'host=localhost dbname=test_pub application_name=sub2'
/* sub - */ PUBLICATION pub2;
/* sub # */ CREATE SUBSCRIPTION sub3
/* sub - */ CONNECTION 'host=localhost dbname=test_pub application_name=sub3'
/* sub - */ PUBLICATION pub3a, pub3b;
请注意，初始表数据被复制，无论发布的 publish
操作如何。
/* sub # */ SELECT * FROM t1;
a |   b
---+-------
1 | one
2 | two
3 | three
(3 rows)
/* sub # */ SELECT * FROM t2;
c | d
---+---
1 | A
2 | B
3 | C
(3 rows)
此外，由于初始数据复制忽略了 publish
操作，并且发布 pub3a 没有行过滤器，
这意味着复制的表 t3 包含所有行，即使它们
不匹配发布 pub3b 的行过滤器。
/* sub # */ SELECT * FROM t3;
e |  f
---+-----
1 | i
2 | ii
3 | iii
(3 rows)
在发布者端向表中插入更多数据。
/* pub # */ INSERT INTO t1 VALUES (4, 'four'), (5, 'five'), (6, 'six');
/* pub # */ INSERT INTO t2 VALUES (4, 'D'), (5, 'E'), (6, 'F');
/* pub # */ INSERT INTO t3 VALUES (4, 'iv'), (5, 'v'), (6, 'vi');
现在发布者端的数据如下：
/* pub # */ SELECT * FROM t1;
a |   b
---+-------
1 | one
2 | two
3 | three
4 | four
5 | five
6 | six
(6 rows)
/* pub # */ SELECT * FROM t2;
c | d
---+---
1 | A
2 | B
3 | C
4 | D
5 | E
6 | F
(6 rows)
/* pub # */ SELECT * FROM t3;
e |  f
---+-----
1 | i
2 | ii
3 | iii
4 | iv
5 | v
6 | vi
(6 rows)
请注意，在正常复制过程中使用了适当的
publish 操作。这意味着发布
pub2 和 pub3a 不会复制
INSERT。此外，发布 pub3b 只会
复制与 pub3b 的行过滤器匹配的数据。
现在订阅者端的数据如下：
/* sub # */ SELECT * FROM t1;
a |   b
---+-------
1 | one
2 | two
3 | three
4 | four
5 | five
6 | six
(6 rows)
/* sub # */ SELECT * FROM t2;
c | d
---+---
1 | A
2 | B
3 | C
(3 rows)
/* sub # */ SELECT * FROM t3;
e |  f
---+-----
1 | i
2 | ii
3 | iii
6 | vi
(4 rows)
29.2.3. 示例：延迟复制槽创建 #
有一些情况（例如
第 29.2.1 节)，如果远程复制槽未
自动创建，用户必须在订阅激活之前手动创建它。创建复制槽和激活订阅的步骤
在以下示例中显示。这些示例指定了标准的逻辑解码输出插件
(pgoutput)，这是内置逻辑复制所使用的插件。
首先，为示例创建一个发布。
/* pub # */ CREATE PUBLICATION pub1 FOR ALL TABLES;
示例 1：当订阅显示 connect = false 时
创建订阅。
/* sub # */ CREATE SUBSCRIPTION sub1
/* sub - */ CONNECTION 'host=localhost dbname=test_pub'
/* sub - */ PUBLICATION pub1
/* sub - */ WITH (connect=false);
WARNING:  subscription was created, but is not connected
HINT:  To initiate replication, you must manually create the replication slot, enable the subscription, and refresh the subscription.
在发布者上，手动创建一个槽。因为在 CREATE SUBSCRIPTION
时没有指定名称，所以要创建的槽的名称与订阅名称相同，例如 "sub1"。
/* pub # */ SELECT * FROM pg_create_logical_replication_slot('sub1', 'pgoutput');
slot_name |    lsn
-----------+-----------
sub1      | 0/19404D0
(1 row)
在订阅者上，完成订阅的激活。之后 pub1 的表将开始复制。
/* sub # */ ALTER SUBSCRIPTION sub1 ENABLE;
/* sub # */ ALTER SUBSCRIPTION sub1 REFRESH PUBLICATION;
示例 2：当订阅说 connect = false，
但也指定了
slot_name
选项。
创建订阅。
/* sub # */ CREATE SUBSCRIPTION sub1
/* sub - */ CONNECTION 'host=localhost dbname=test_pub'
/* sub - */ PUBLICATION pub1
/* sub - */ WITH (connect=false, slot_name='myslot');
WARNING:  subscription was created, but is not connected
HINT:  To initiate replication, you must manually create the replication slot, enable the subscription, and refresh the subscription.
在发布者上，手动创建一个槽，使用在 CREATE SUBSCRIPTION
时指定的相同名称，例如 "myslot"。
/* pub # */ SELECT * FROM pg_create_logical_replication_slot('myslot', 'pgoutput');
slot_name |    lsn
-----------+-----------
myslot    | 0/19059A0
(1 row)
在订阅者上，剩余的订阅激活步骤与之前相同。
/* sub # */ ALTER SUBSCRIPTION sub1 ENABLE;
/* sub # */ ALTER SUBSCRIPTION sub1 REFRESH PUBLICATION;
示例 3：当订阅指定 slot_name = NONE
创建订阅。当 slot_name = NONE 时，
enabled = false 和
create_slot = false 也是必需的。
/* sub # */ CREATE SUBSCRIPTION sub1
/* sub - */ CONNECTION 'host=localhost dbname=test_pub'
/* sub - */ PUBLICATION pub1
/* sub - */ WITH (slot_name=NONE, enabled=false, create_slot=false);
在发布者上，手动创建一个槽，使用任何名称，例如 "myslot"。
/* pub # */ SELECT * FROM pg_create_logical_replication_slot('myslot', 'pgoutput');
slot_name |    lsn
-----------+-----------
myslot    | 0/1905930
(1 row)
在订阅者上，将订阅与刚创建的槽名称关联。
/* sub # */ ALTER SUBSCRIPTION sub1 SET (slot_name='myslot');
剩余的订阅激活步骤与之前相同。
/* sub # */ ALTER SUBSCRIPTION sub1 ENABLE;
/* sub # */ ALTER SUBSCRIPTION sub1 REFRESH PUBLICATION;
上一页 上一级 下一页29.1. 发布 起始页 29.3. 逻辑复制故障切换
