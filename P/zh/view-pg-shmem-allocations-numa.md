# 53.28. pg_shmem_allocations_numa

53.28. pg_shmem_allocations_numa
版本：
纠错本页面
搜索
目录导航
❮
❯
53.28. pg_shmem_allocations_numa #
pg_shmem_allocations_numa 显示服务器主共享内存段中共享内存分配
如何分布在 NUMA 节点上。这包括 PostgreSQL 本身分配的内存
以及使用 第 36.10.11 节 中详细机制的扩展分配的内存。此视图将输出多行
对于每个共享内存段，只要它们分布在多个 NUMA 节点上。此视图不应被监控系统查询，
因为它非常慢，并且可能会在未使用的情况下分配共享内存。
此视图的当前限制是不会显示匿名共享内存分配。
请注意，此视图不包括使用动态共享内存基础设施分配的内存。
警告
在确定 NUMA 节点时，视图会访问共享内存段的所有内存页面。
如果共享内存尚未分配，这将强制分配共享内存，
并且内存可能会在单个 NUMA 节点中分配（具体取决于系统配置）。
表 53.28. pg_shmem_allocations_numa 列
列类型
描述
name text
共享内存分配的名称。
numa_node int4
NUMA 节点的 ID
size int8
此特定 NUMA 内存节点上分配的大小（以字节为单位）
默认情况下，pg_shmem_allocations_numa 视图
仅可被超级用户或具有
pg_read_all_stats 角色权限的角色读取。
上一页 上一级 下一页53.27. pg_shmem_allocations 起始页 53.29. pg_stats
