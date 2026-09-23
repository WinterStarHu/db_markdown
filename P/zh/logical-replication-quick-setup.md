# 29.14. 快速设置

29.14. 快速设置
版本：
纠错本页面
搜索
目录导航
❮
❯
29.14. 快速设置 #
首先在 postgresql.conf 中设置配置选项：
wal_level = logical
对于一个基础设置来说，其他所需的设置使用默认值就足够了。
pg_hba.conf 需要调整以允许复制
（这里的值取决于您的实际网络配置和您希望用于连接的用户）：
host     all     repuser     0.0.0.0/0     scram-sha-256
然后在发布者数据库上：
CREATE PUBLICATION mypub FOR TABLE users, departments;
并且在订阅者数据库上：
CREATE SUBSCRIPTION mysub CONNECTION 'dbname=foo host=bar user=repuser' PUBLICATION mypub;
上面的语句将开始复制过程，它会同步表 users 以及 departments 的初始表内容，然后开始复制对那些表的增量更改。
上一页 上一级 下一页29.13. 升级 起始页 第 30 章 即时编译（JIT）
