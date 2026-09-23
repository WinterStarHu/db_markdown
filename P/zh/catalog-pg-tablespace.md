# 52.56. pg_tablespace

52.56. pg_tablespace
版本：
纠错本页面
搜索
目录导航
❮
❯
52.56. pg_tablespace #
目录pg_tablespace存储关于可用表空间的信息。表可以被放置在特定
表空间中以实现磁盘布局的管理。
与大部分其他系统目录不同，pg_tablespace在整个集簇的所有数据库之间共享：在每一个集簇中只有一个pg_tablespace的副本，而不是每个数据库一份。
表 52.56. pg_tablespace 列
列类型
描述
oid oid
行标识符
spcname name
表空间名
spcowner oid
(references pg_authid.oid)
表空间的拥有者，通常是创建它的用户
spcacl aclitem[]
访问权限；详见 第 5.8 节 获取详细信息
spcoptions text[]
表空间级别的选项，形如“keyword=value”的字符串
上一页 上一级 下一页52.55. pg_subscription_rel 起始页 52.57. pg_transform
