# REFRESH MATERIALIZED VIEW

REFRESH MATERIALIZED VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
REFRESH MATERIALIZED VIEWREFRESH MATERIALIZED VIEW — 替换物化视图的内容大纲
REFRESH MATERIALIZED VIEW [ CONCURRENTLY ] name
[ WITH [ NO ] DATA ]
描述
REFRESH MATERIALIZED VIEW 完全替换物化视图的内容。要执行此命令，您必须拥有物化视图的
MAINTAIN 权限。旧内容将被丢弃。如果指定了（或默认）WITH DATA，
则会执行支持查询以提供新数据，并且物化视图将处于可扫描状态。如果指定了 WITH NO DATA，
则不会生成新数据，物化视图将处于不可扫描状态。
CONCURRENTLY 和 WITH NO DATA
不能一起指定。
参数CONCURRENTLY
对物化视图的刷新不阻塞在该物化视图上的并发选择。如果没有这个选项，
一次影响很多行的刷新将使用更少的资源并且更快结束，但是可能会阻塞
其他尝试从物化视图中读取的连接。这个选项在只有少量行被影响的情况下
可能会更快。
只有当物化视图上有至少一个UNIQUE索引（只用列名
并且包括所有行）时，才允许这个选项。也就是说，它不能是表达式索引或包括WHERE子句。
该选项仅在物化视图已被填充时才能使用。
即使带有这个选项，对于任意一个物化视图一次也只能运行一个
REFRESH。
name
要刷新的物化视图的名称（可以被模式限定）。
Notes
如果在物化视图的定义查询中有一个ORDER BY子句，
物化视图的原始内容将按照那种方式排序；但REFRESH MATERIALIZED
VIEW不保证保留该排序方式。
当REFRESH MATERIALIZED VIEW正在运行时，search_path会临时更改为pg_catalog,
pg_temp。
Examples
这个命令将使用物化视图order_summary定义中的查询
来替换该物化视图的内容，并且让它处于一种可扫描的状态：
REFRESH MATERIALIZED VIEW order_summary;
这个命令将释放与物化视图annual_statistics_basis相关
的存储并且让它变成一种不可扫描的状态：
REFRESH MATERIALIZED VIEW annual_statistics_basis WITH NO DATA;
兼容性
REFRESH MATERIALIZED VIEW是一种
PostgreSQL扩展。
其他CREATE MATERIALIZED VIEW, ALTER MATERIALIZED VIEW, DROP MATERIALIZED VIEW上一页 上一级 下一页REASSIGN OWNED 起始页 REINDEX
