# 29.13. 升级

29.13. 升级
版本：
纠错本页面
搜索
目录导航
❮
❯
29.13. 升级 #29.13.1. 为发布者升级做准备29.13.2. 准备订阅者升级29.13.3. 升级逻辑复制集群
迁移 逻辑复制集群
仅在旧逻辑复制
集群的所有成员版本为 17.0 或更高时才可能。
29.13.1. 为发布者升级做准备 #
pg_upgrade 尝试迁移逻辑
槽。这有助于避免在新发布者上手动定义相同
的逻辑槽。仅在旧集群版本为 17.0 或更高时支持逻辑槽的迁移。
版本低于 17.0 的集群将被静默忽略。
在开始升级发布者集群之前，请确保
订阅暂时禁用，通过执行
ALTER SUBSCRIPTION ... DISABLE。
升级后重新启用订阅。
有一些前提条件需要满足，以便 pg_upgrade
能够升级逻辑槽。如果这些条件未满足，将会报告错误。
新集群必须将
wal_level 设置为
logical。
新集群必须将
max_replication_slots
配置为大于或等于旧集群中存在的槽的数量。
旧集群上引用的输出插件必须安装在新的 PostgreSQL 可执行目录中。
旧集群已将所有事务和逻辑解码消息复制到订阅者。
旧集群上的所有槽必须可用，即没有槽的
pg_replication_slots.conflicting
不为 true。
新集群不得有永久逻辑槽，即，
必须没有槽的
pg_replication_slots.temporary
为 false。
29.13.2. 准备订阅者升级 #
在新的订阅者中设置
订阅者配置。
pg_upgrade 尝试迁移订阅依赖项，包括
pg_subscription_rel
系统目录中存在的订阅表信息，以及订阅的复制源。这允许
新订阅者的逻辑复制从旧订阅者的进度继续。只有当旧集群的版本为
17.0 或更高时，才支持订阅依赖项的迁移。版本低于 17.0 的集群
的订阅依赖项将被静默忽略。
有一些前提条件需要满足，以便 pg_upgrade
能够升级订阅。如果这些条件未满足，将会报告错误。
旧订阅者中的所有订阅表应处于 i（初始化）或
r（准备就绪）状态。这可以通过检查
pg_subscription_rel.srsubstate
来验证。
每个订阅对应的复制源条目应存在于旧集群中。这可以通过检查
pg_subscription 和
pg_replication_origin
系统表来找到。
新的集群必须将
max_active_replication_origins
配置为大于或等于旧集群中存在的订阅数量。
29.13.3. 升级逻辑复制集群 #
在升级订阅者时，可以在发布者上执行写操作。这些更改将在
订阅者升级完成后复制到订阅者。
注意
逻辑复制的限制同样适用于逻辑复制集群的升级。有关详细信息，请参见
第 29.8 节。
发布者升级的先决条件同样适用于逻辑复制集群的升级。有关详细信息，请参见
第 29.13.1 节。
订阅者升级的先决条件同样适用于逻辑复制集群的升级。有关详细信息，请参见
第 29.13.2 节。
警告
升级逻辑复制集群需要在各个节点上执行多个步骤。由于并非所有操作都是
事务性的，建议用户按照
第 25.3.2 节中所述进行备份。
升级以下逻辑复制集群的步骤如下所述：
按照
第 29.13.3.1 节中指定的步骤升级
两节点逻辑复制集群。
按照
第 29.13.3.2 节中指定的步骤升级
级联逻辑复制集群。
按照
第 29.13.3.3 节
中指定的步骤升级两节点循环逻辑复制集群。
29.13.3.1. 升级两节点逻辑复制集群的步骤 #
假设发布者在 node1，而订阅者在
node2。订阅者 node2 有一个订阅
sub1_node1_node2，它正在订阅来自 node1 的更改。
通过使用
ALTER SUBSCRIPTION ... DISABLE，禁用
所有在 node2 上订阅来自 node1 的更改的订阅，例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 DISABLE;
停止 node1 中的发布者服务器，例如：
pg_ctl -D /opt/PostgreSQL/data1 stop
使用所需的较新版本初始化 data1_upgraded 实例。
将发布者 node1 的服务器升级到所需的较新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data1"
--new-datadir "/opt/PostgreSQL/postgres/18/data1_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node1 启动升级后的发布者服务器，例如：
pg_ctl -D /opt/PostgreSQL/data1_upgraded start -l logfile
停止 node2 中的订阅者服务器，例如：
pg_ctl -D /opt/PostgreSQL/data2 stop
使用所需的较新版本初始化 data2_upgraded 实例。
将订阅者 node2 的服务器升级到所需的新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data2"
--new-datadir "/opt/PostgreSQL/postgres/18/data2_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node2 启动升级后的订阅者服务器，例如：
pg_ctl -D /opt/PostgreSQL/data2_upgraded start -l logfile
在 node2 上，创建在升级后的发布者 node1 服务器中创建的任何表，
例如：
/* node2 # */ CREATE TABLE distributors (did integer PRIMARY KEY, name varchar(40));
启用所有在 node2 上订阅来自 node1 的更改的订阅，
使用 ALTER SUBSCRIPTION ... ENABLE，
例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 ENABLE;
使用 ALTER SUBSCRIPTION ... REFRESH PUBLICATION
刷新 node2 订阅的出版物，例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 REFRESH PUBLICATION;
注意
在上述步骤中，首先升级发布者，然后是订阅者。或者，用户可以使用类似的步骤
首先升级订阅者，然后是发布者。
29.13.3.2. 升级级联逻辑复制集群的步骤 #
假设我们有一个级联的逻辑复制设置
node1->node2->node3。
这里 node2 正在订阅来自
node1 的更改，而 node3 正在订阅
来自 node2 的更改。 node2
有一个订阅 sub1_node1_node2，它正在
订阅来自 node1 的更改。 node3
有一个订阅 sub1_node2_node3，它正在订阅
来自 node2 的更改。
禁用所有在 node2 上订阅来自 node1 的更改的订阅，通过使用
ALTER SUBSCRIPTION ... DISABLE，
例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 DISABLE;
停止 node1 中的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data1 stop
使用所需的较新版本初始化 data1_upgraded 实例。
将 node1 的服务器升级到所需的新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data1"
--new-datadir "/opt/PostgreSQL/postgres/18/data1_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node1 中启动升级后的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data1_upgraded start -l logfile
禁用在 node3 上的所有订阅，这些订阅
正在使用 ALTER SUBSCRIPTION ... DISABLE
从 node2 订阅更改，例如：
/* node3 # */ ALTER SUBSCRIPTION sub1_node2_node3 DISABLE;
停止 node2 中的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data2 stop
使用所需的较新版本初始化 data2_upgraded 实例。
将 node2 的服务器升级到所需的新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data2"
--new-datadir "/opt/PostgreSQL/postgres/18/data2_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node2 中启动升级后的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data2_upgraded start -l logfile
在 node2 上，创建在升级后的发布者
node1 服务器中创建的任何表，这些表是在
步骤 1
之间创建的，例如：
/* node2 # */ CREATE TABLE distributors (did integer PRIMARY KEY, name varchar(40));
启用所有在 node2 上订阅来自 node1 的更改的订阅，
使用 ALTER SUBSCRIPTION ... ENABLE，
例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 ENABLE;
使用 ALTER SUBSCRIPTION ... REFRESH PUBLICATION
刷新 node2 订阅的出版物，例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 REFRESH PUBLICATION;
停止 node3 中的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data3 stop
使用所需的新版本初始化 data3_upgraded 实例。
将 node3 的服务器升级到所需的新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data3"
--new-datadir "/opt/PostgreSQL/postgres/18/data3_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node3 启动升级后的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data3_upgraded start -l logfile
在 node3 上创建在升级后的
node2 中创建的任何表，时间范围是
步骤 6 到现在，
例如：
/* node3 # */ CREATE TABLE distributors (did integer PRIMARY KEY, name varchar(40));
启用在 node3 上的所有订阅，这些订阅
来自 node2 的更改，使用
ALTER SUBSCRIPTION ... ENABLE,
例如：
/* node3 # */ ALTER SUBSCRIPTION sub1_node2_node3 ENABLE;
使用 ALTER SUBSCRIPTION ... REFRESH PUBLICATION
刷新 node3 订阅的发布，
例如：
/* node3 # */ ALTER SUBSCRIPTION sub1_node2_node3 REFRESH PUBLICATION;
29.13.3.3. 升级双节点循环逻辑复制集群的步骤 #
假设我们有一个循环逻辑复制设置
node1->node2 和
node2->node1。这里
node2 订阅来自
node1 的更改，而 node1 订阅
来自 node2 的更改。node1
有一个订阅 sub1_node2_node1，它
订阅来自 node2 的更改。
node2 有一个订阅
sub1_node1_node2，它订阅来自
node1 的更改。
通过使用
ALTER SUBSCRIPTION ... DISABLE，禁用
所有在 node2 上订阅来自 node1 的更改的订阅，例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 DISABLE;
停止 node1 中的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data1 stop
使用所需的较新版本初始化 data1_upgraded 实例。
将 node1 的服务器升级到所需的
新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data1"
--new-datadir "/opt/PostgreSQL/postgres/18/data1_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node1 中启动升级后的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data1_upgraded start -l logfile
启用所有在 node2 上订阅来自 node1 的更改的订阅，
使用 ALTER SUBSCRIPTION ... ENABLE，
例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 ENABLE;
在 node1 上创建在
node2 中创建的任何表，时间范围是 步骤 1
到现在，例如：
/* node1 # */ CREATE TABLE distributors (did integer PRIMARY KEY, name varchar(40));
刷新 node1 订阅的发布，以
从 node2 复制初始表数据，使用
ALTER SUBSCRIPTION ... REFRESH PUBLICATION,
例如：
/* node1 # */ ALTER SUBSCRIPTION sub1_node2_node1 REFRESH PUBLICATION;
禁用在 node1 上的所有订阅，这些订阅
来自 node2 的更改，使用
ALTER SUBSCRIPTION ... DISABLE,
例如：
/* node1 # */ ALTER SUBSCRIPTION sub1_node2_node1 DISABLE;
停止 node2 中的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data2 stop
使用所需的较新版本初始化 data2_upgraded 实例。
将 node2 的服务器升级到所需的新版本，例如：
pg_upgrade
--old-datadir "/opt/PostgreSQL/postgres/17/data2"
--new-datadir "/opt/PostgreSQL/postgres/18/data2_upgraded"
--old-bindir "/opt/PostgreSQL/postgres/17/bin"
--new-bindir "/opt/PostgreSQL/postgres/18/bin"
在 node2 中启动升级后的服务器，例如：
pg_ctl -D /opt/PostgreSQL/data2_upgraded start -l logfile
启用在 node1 上的所有订阅，这些订阅
来自 node2 的更改，使用
ALTER SUBSCRIPTION ... ENABLE,
例如：
/* node1 # */ ALTER SUBSCRIPTION sub1_node2_node1 ENABLE;
在 node2 上创建在升级后的
node1 中创建的任何表，时间范围是 步骤 9
到现在，例如：
/* node2 # */ CREATE TABLE distributors (did integer PRIMARY KEY, name varchar(40));
刷新 node2 订阅的发布，以从 node1 复制初始表数据，
使用 ALTER SUBSCRIPTION ... REFRESH PUBLICATION，
例如：
/* node2 # */ ALTER SUBSCRIPTION sub1_node1_node2 REFRESH PUBLICATION;
上一页 上一级 下一页29.12. 配置设置 起始页 29.14. 快速设置
