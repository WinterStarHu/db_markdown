# 53.27. pg_shmem_allocations

53.27. pg_shmem_allocations
版本：
纠错本页面
搜索
目录导航
❮
❯
53.27. pg_shmem_allocations #
pg_shmem_allocations视图显示从服务器的主共享内存段分配的内存。
这包括PostgreSQL本身分配的内存，以及使用第 36.10.11 节中详细描述的机制分配的内存。
请注意，此视图不包括使用动态共享内存基础设施分配的内存。
表 53.27. pg_shmem_allocations 列
列类型
描述
name text
共享内存分配的名称。未使用的内存为NULL，匿名分配的为 <anonymous>。
off int8
分配开始的偏移量。匿名分配为NULL，因为与它们相关的详细信息未知。
size int8
分配的大小（以字节为单位）
allocated_size int8
分配的大小（以字节为单位），包括填充。对于匿名分配，没有关于填充的
信息，因此size和allocated_size
列将始终相等。对于空闲内存，填充没有意义，因此在这种情况下，这些列
也将相等。
匿名分配是直接使用ShmemAlloc()进行的分配，
而不是通过ShmemInitStruct()或
ShmemInitHash()进行的。
默认情况下，pg_shmem_allocations视图只能被超级用户或具有pg_read_all_stats角色权限的角色读取。
上一页 上一级 下一页53.26. pg_shadow 起始页 53.28. pg_shmem_allocations_numa
