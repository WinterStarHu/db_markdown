# 52.55. pg_subscription_rel

52.55. pg_subscription_rel
版本：
纠错本页面
搜索
目录导航
❮
❯
52.55. pg_subscription_rel #
目录 pg_subscription_rel 包含每个订阅中每个被复制关系的状态。这是一种多对多映射。
这个目录仅包含运行 CREATE SUBSCRIPTION 或 ALTER SUBSCRIPTION ... REFRESH PUBLICATION 后对订阅已知的表。
表 52.55. pg_subscription_rel Columns
列类型
描述
srsubid oid
(references pg_subscription.oid)
对订阅的引用
srrelid oid
(references pg_class.oid)
对关系的引用
srsubstate char
状态代码：
i = 初始化，
d = 数据正在被拷贝，
f = 结束表拷贝，
s = 已同步，
r = 准备好（普通复制）
srsublsn pg_lsn
在s或r状态中，用于同步协调的状态更改的远程 LSN，否则为空
上一页 上一级 下一页52.54. pg_subscription 起始页 52.56. pg_tablespace
