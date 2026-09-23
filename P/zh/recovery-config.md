# O.1. recovery.conf 文件合并到 postgresql.conf

O.1. recovery.conf 文件合并到 postgresql.conf
版本：
纠错本页面
搜索
目录导航
❮
❯
O.1. recovery.conf 文件合并到 postgresql.conf #
PostgreSQL 11 及以下版本使用配置文件名为 recovery.conf ，以管理复制和备用机。
关于此文件的支持在PostgreSQL 12被移除。此变更的详细信息请参见PostgreSQL 12 的发布说明。
在PostgreSQL 12 及以上版本，归档恢复、流复制和PITR使用
普通服务器配置参数进行配置。
这些参数在postgresql.conf中设置，或像其他参数一样通过
ALTER SYSTEM进行设置。
如果recovery.conf 存在则服务器不会启动。
PostgreSQL 15及以下版本有一个设置
promote_trigger_file，或者在12之前是
trigger_file。
使用pg_ctl promote或调用
pg_promote()来提升一个备用节点。
standby_mode
设置已经被移除。数据目录中的standby.signal 文件用于替代它。详见Standby Server Operation。
上一页 上一级 下一页附录 O. 废弃或重命名的功能 起始页 O.2. 默认角色重命名为预定义角色
