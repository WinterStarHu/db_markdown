# 53.5. pg_backend_memory_contexts

53.5. pg_backend_memory_contexts
版本：
纠错本页面
搜索
目录导航
❮
❯
53.5. pg_backend_memory_contexts #
视图pg_backend_memory_contexts显示与当前会话关联的服务器进程的所有内存上下文。
pg_backend_memory_contexts包含每个内存上下文的一行。
表 53.5. pg_backend_memory_contexts 列
列类型
描述
name text
内存上下文的名称
ident text
内存上下文的标识信息。该字段在1024字节处被截断
type text
内存上下文的类型
level int4
内存上下文层次结构中基于1的上下文级别。上下文的级别还显示该上下文在
path列中的位置。
path int4[]
描述内存上下文层次结构的瞬态数字标识符数组。第一个元素用于
TopMemoryContext，后续元素包含中间父级，最后一个元素包含
当前上下文的标识符。
total_bytes int8
分配给该内存上下文的总字节数
total_nblocks int8
分配给该内存上下文的总块数
free_bytes int8
可用空间（以字节为单位）
free_chunks int8
可用大块的总数量
used_bytes int8
已用空间（字节）
默认情况下，pg_backend_memory_contexts视图只能被超级用户或具有pg_read_all_stats角色权限的角色读取。
由于内存上下文在查询运行期间被创建和销毁，存储在 path 列中的标识符
在同一查询的多次调用之间可能不稳定。下面的示例演示了此列的有效用法，并计算
CacheMemoryContext 及其所有子级使用的字节总数：
WITH memory_contexts AS (
SELECT * FROM pg_backend_memory_contexts
)
SELECT sum(c1.total_bytes)
FROM memory_contexts c1, memory_contexts c2
WHERE c2.name = 'CacheMemoryContext'
AND c1.path[c2.level] = c2.path[c2.level];
公共表表达式 用于确保 path 列中的上下文 ID
在视图的两个评估之间匹配。
上一页 上一级 下一页53.4. pg_available_extension_versions 起始页 53.6. pg_config
