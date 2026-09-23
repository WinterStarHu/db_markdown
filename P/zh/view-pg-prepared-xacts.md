# 53.17. pg_prepared_xacts

53.17. pg_prepared_xacts
版本：
纠错本页面
搜索
目录导航
❮
❯
53.17. pg_prepared_xacts #
视图pg_prepared_xacts显示当前准备进行两阶段提交的事务的信息
(详见PREPARE TRANSACTION)。
pg_prepared_xacts包含每个预处理事务的一行。当事务提交或回滚时，条目将被移除。
表 53.17. pg_prepared_xacts 列
列类型
描述
transaction xid
预备事务的数字事务标识符
gid text
分配给事务的全局事务标识符
prepared timestamptz
此事务为提交准备的时间
owner name
(references pg_authid.rolname)
执行此事务的用户名
database name
(references pg_database.datname)
执行此事务所在数据库的名称
当访问pg_prepared_xacts视图时，内部事务管理器数据结构会被暂时锁定，并为视图制作一份副本用以显示。
这确保视图生成一致的结果集，同时不会不必要地阻塞正常操作。尽管如此，如果频繁访问该视图，可能会对数据库性能产生一些影响。
上一页 上一级 下一页53.16. pg_prepared_statements 起始页 53.18. pg_publication_tables
