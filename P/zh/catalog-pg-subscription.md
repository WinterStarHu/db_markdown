# 52.54. pg_subscription

52.54. pg_subscription
版本：
纠错本页面
搜索
目录导航
❮
❯
52.54. pg_subscription #
目录 pg_subscription 包含所有现有的逻辑复制订阅。更多有关逻辑复制的信息请见 第 29 章。
和大部分系统目录不同，pg_subscription 在集簇的所有数据库之间共享：每个集簇只有一份 pg_subscription 拷贝，而不是每个数据库一份。
对列subconninfo的访问被从普通用户那里收回，因为该列可能含有明文密码。
表 52.54. pg_subscription Columns
列类型
描述
oid oid
行标识符
subdbid oid
(references pg_database.oid)
订阅所在的数据库的OID
subskiplsn pg_lsn
事务的完成LSN，其更改将被跳过，如果是有效LSN；否则0/0。
subname name
订阅的名称
subowner oid
(references pg_authid.oid)
订阅的拥有者
subenabled bool
如果为真，订阅被启用并且应该正在复制。
subbinary bool
如果为真，订阅将请求发布者以二进制格式发送数据。
substream char
控制如何处理进行中的事务的流式传输：
f = 不允许进行中的事务流式传输，
t = 将进行中的事务的更改溢写到磁盘，并在发布者提交事务且订阅者接收后一次性应用，
p = 如果有可用的并行应用工作线程，则直接使用该线程应用更改（如果没有工作线程，则与
t 相同）
subtwophasestate char
两阶段模式的状态代码：
d = 禁用，
p = 待启用，
e = 启用
subdisableonerr bool
如果为真，则如果其工作线程之一检测到错误，订阅将被禁用。
subpasswordrequired bool
如果为真，则订阅将需要指定一个密码进行身份验证。
subrunasowner bool
如果为真，订阅将以订阅所有者的权限运行。
subfailover bool
如果为真，则上游数据库中关联的复制槽（即主槽和表同步槽）
可以同步到备用服务器。
subconninfo text
到上游数据库的连接字符串
subslotname name
上游数据库中复制槽的名称（也用于本地复制源名称）；空表示 NONE
subsynccommit text
用于订阅工作者的 synchronous_commit 设置
subpublications text[]
被订阅的 publication 名称的数组。这些引用上游数据库中定义的 publication。
更多有关 publication 的内容请见 第 29.1 节。
suborigin text
原点值必须是 none 或 any 之一。默认值是
any。如果是 none，订阅将请求发布者仅发送
没有原点的更改。如果是 any，发布者将发送无论其原点的所有
更改。
上一页 上一级 下一页52.53. pg_statistic_ext_data 起始页 52.55. pg_subscription_rel
