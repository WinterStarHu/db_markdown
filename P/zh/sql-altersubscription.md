# ALTER SUBSCRIPTION

ALTER SUBSCRIPTION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER SUBSCRIPTIONALTER SUBSCRIPTION — 更改订阅的定义大纲
ALTER SUBSCRIPTION name CONNECTION 'conninfo'
ALTER SUBSCRIPTION name SET PUBLICATION publication_name [, ...] [ WITH ( publication_option [= value] [, ... ] ) ]
ALTER SUBSCRIPTION name ADD PUBLICATION publication_name [, ...] [ WITH ( publication_option [= value] [, ... ] ) ]
ALTER SUBSCRIPTION name DROP PUBLICATION publication_name [, ...] [ WITH ( publication_option [= value] [, ... ] ) ]
ALTER SUBSCRIPTION name REFRESH PUBLICATION [ WITH ( refresh_option [= value] [, ... ] ) ]
ALTER SUBSCRIPTION name ENABLE
ALTER SUBSCRIPTION name DISABLE
ALTER SUBSCRIPTION name SET ( subscription_parameter [= value] [, ... ] )
ALTER SUBSCRIPTION name SKIP ( skip_option = value )
ALTER SUBSCRIPTION name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER SUBSCRIPTION name RENAME TO new_name
描述
ALTER SUBSCRIPTION可以修改大部分可以在
CREATE SUBSCRIPTION中指定的订阅属性。
您必须拥有订阅才能使用ALTER SUBSCRIPTION。
要重命名订阅或更改所有者，您必须对数据库具有
CREATE权限。此外，
要更改所有者，您必须能够SET ROLE为新的所有角色。
如果订阅设置了password_required=false，
只有超级用户可以修改它。
刷新出版物时，我们会删除不再属于出版物的关系，如果有的话，还会删除表同步插槽。
必须删除这些插槽，以便释放在远程主机上为订阅分配的资源。如果由于网络故障或其他错误，
PostgreSQL无法删除插槽，则会报告错误。在这种情况下，用户需要
重新尝试操作或按照DROP SUBSCRIPTION中的说明取消订阅并删除插槽。
命令 ALTER SUBSCRIPTION ... REFRESH PUBLICATION,
ALTER SUBSCRIPTION ... {SET|ADD|DROP} PUBLICATION ...
选项为 refresh 的值为 true，
ALTER SUBSCRIPTION ... SET (failover = true|false) 和
ALTER SUBSCRIPTION ... SET (two_phase = false)
不能在事务块内执行。
命令 ALTER SUBSCRIPTION ... REFRESH PUBLICATION 和
ALTER SUBSCRIPTION ... {SET|ADD|DROP} PUBLICATION ...
带有 refresh 选项为 true 时，也不能在订阅启用
two_phase
提交的情况下执行，除非
copy_data
为 false。请参见 subtwophasestate 列，
该列位于 pg_subscription
中，以了解实际的两阶段状态。
参数name #
要修改属性的订阅的名称。
CONNECTION 'conninfo' #
本条款替换了最初由CREATE SUBSCRIPTION设置的连接字符串。有关更多信息，请参见那里。
SET PUBLICATION publication_nameADD PUBLICATION publication_nameDROP PUBLICATION publication_name #
这些形式改变了已订阅的出版物列表。
SET用新列表替换整个出版物列表，
ADD将额外的出版物添加到出版物列表中，
而DROP从出版物列表中移除出版物。
我们允许在ADD和SET变体中指定不存在的出版物，
以便用户以后可以添加这些出版物。有关更多信息，请参见CREATE SUBSCRIPTION。
默认情况下，此命令还将像REFRESH PUBLICATION一样操作。
publication_option指定了这个操作的附加选项。
支持的选项是：
refresh (boolean)
如果为false，则该命令将不会尝试刷新表信息。然后应单独执行
REFRESH PUBLICATION。默认值是true。
此外，可以指定REFRESH PUBLICATION下描述的选项，以控制隐式刷新操作。
REFRESH PUBLICATION #
从发布者获取缺失的表信息。这将启动对自
CREATE SUBSCRIPTION以来添加到订阅发布的表的复制，
或自上次调用REFRESH PUBLICATION以来的复制。
refresh_option 指定刷新操作的附加选项。支持的选项有：
copy_data (boolean)
指定在复制开始时是否复制已存在于被订阅发布中的数据。默认值为
true。
之前订阅的表不会被复制，即使表的行过滤器WHERE子句
已经被修改。
详情请参见Notes，了解
copy_data = true如何与
origin
参数交互。
有关以二进制格式复制已存在数据的详细信息，请参见
binary
参数的CREATE SUBSCRIPTION。
ENABLE #
启用先前禁用的订阅，在事务结束时启动逻辑复制工作进程。
DISABLE #
禁用正在运行的订阅，在事务结束时停止逻辑复制工作进程。
SET ( subscription_parameter [= value] [, ... ] ) #
此子句修改最初由
CREATE SUBSCRIPTION 设置的参数。有关更多
信息，请参见那里。可以修改的参数有
slot_name,
synchronous_commit,
binary,
streaming,
disable_on_error,
password_required,
run_as_owner,
origin,
failover, 和
two_phase。
只有超级用户可以设置 password_required = false。
修改
slot_name
时，命名槽的 failover 和 two_phase 属性值可能与订阅中指定的对应
failover
和
two_phase
参数不同。创建槽时，确保槽属性 failover 和 two_phase 与订阅的对应参数匹配。
否则，发布者上的槽可能表现得与这些订阅选项所描述的不同：例如，即使订阅的
failover
选项被禁用，发布者上的槽也可能同步到备用节点，或者即使订阅的
failover
选项被启用，槽也可能被禁用同步。
failover
和 two_phase
参数只能在订阅被禁用时修改。
当将 two_phase
从 true 修改为 false 时，
如果发现逻辑复制工作进程执行的任何准备事务（在 two_phase
参数仍为 true 时）则后端
进程会报告错误。您可以在发布节点上解决
准备事务，或在订阅者上手动回滚它们，
然后再试一次。由逻辑复制工作进程准备的
与特定订阅对应的事务具有以下模式：“pg_gid_%u_%u”
（参数：订阅 oid，远程事务 ID xid）。
要手动解决此类事务，您需要回滚所有
名称中包含相应订阅 ID 的准备事务。应用程序可以检查
pg_prepared_xacts
以查找所需的准备事务。在 two_phase
选项从 true 更改为 false 后，
发布者将在事务提交时再次复制这些事务。
SKIP ( skip_option = value ) #
跳过应用远程事务的所有更改。如果传入数据违反任何约束，逻辑复制将停止，直到问题
解决。通过使用ALTER SUBSCRIPTION ... SKIP命令，逻辑复制工作
进程会跳过事务中的所有数据修改更改。此选项对已经通过在订阅者上启用
two_phase
预备的事务无效。
逻辑复制工作进程成功跳过事务或完成事务后，存储在
pg_subscription.subskiplsn中的LSN
会被清除。有关逻辑复制冲突的详细信息，请参见
第 29.7 节。
skip_option指定此操作的选项。支持的选项是：
lsn (pg_lsn)
指定要被逻辑复制工作进程跳过的远程事务的完成LSN。完成LSN是事务提交或准备的LSN。
不支持跳过单个子事务。设置NONE会重置LSN。
new_owner #
订阅的新所有者的用户名。
new_name #
订阅的新名称。
当指定类型为boolean的参数时，
=value
部分可以省略，这等同于指定TRUE。
示例
将订阅的发布更改为insert_only：
ALTER SUBSCRIPTION mysub SET PUBLICATION insert_only;
禁用（停止）订阅：
ALTER SUBSCRIPTION mysub DISABLE;
兼容性
ALTER SUBSCRIPTION是PostgreSQL
的一个扩展。
另见CREATE SUBSCRIPTION, DROP SUBSCRIPTION, CREATE PUBLICATION, ALTER PUBLICATION上一页 上一级 下一页ALTER STATISTICS 起始页 ALTER SYSTEM
