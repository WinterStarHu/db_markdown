# 67.4. 两阶段事务

67.4. 两阶段事务
版本：
纠错本页面
搜索
目录导航
❮
❯
67.4. 两阶段事务 #
PostgreSQL支持两阶段提交（2PC）协议，
该协议允许多个分布式系统以事务方式协同工作。命令包括
PREPARE TRANSACTION、COMMIT PREPARED
和ROLLBACK PREPARED。两阶段事务旨在供外部事务管理
系统使用。PostgreSQL遵循X/Open XA标准提出的功能
和模型，但未实现一些较少使用的方面。
当用户执行PREPARE TRANSACTION时，唯一可能的下一个命令是
COMMIT PREPARED或ROLLBACK PREPARED。通常，
这种预备状态的设计是为了持续时间非常短，但外部可用性问题可能导致事务在
这种状态下停留较长时间。短期的预备事务仅存储在共享内存和WAL中。跨检查点
的事务会记录在pg_twophase目录中。当前处于预备状态的事务
可以通过使用
pg_prepared_xacts进行检查。
上一页 上一级 下一页67.3. 子事务 起始页 第 68 章 系统目录声明和初始内容
