# 53.2. pg_aios

53.2. pg_aios
版本：
纠错本页面
搜索
目录导航
❮
❯
53.2. pg_aios #
pg_aios 视图列出了所有当前正在使用的 Asynchronous I/O 句柄。I/O 句柄用于引用正在准备、执行或
正在完成的 I/O 操作。pg_aios 为每个 I/O 句柄
包含一行。
此视图主要对 PostgreSQL 的开发者有用，
但在调整 PostgreSQL 时也可能有用。
表 53.2. pg_aios 列
列类型
描述
pid int4
发出此 I/O 的服务器进程的进程 ID。
io_id int4
I/O 句柄的标识符。句柄在 I/O 完成后会被重用（或者在 I/O 开始前
释放句柄时）。重用时，
pg_aios.io_generation
会递增。
io_generation int8
I/O 句柄的代数。
state text
I/O 句柄的状态：
HANDED_OUT，被代码引用但尚未使用
DEFINED，执行所需的信息已知
STAGED，准备执行
SUBMITTED，已提交执行
COMPLETED_IO，已完成，但结果尚未处理
COMPLETED_SHARED，共享完成处理已完成
COMPLETED_LOCAL，后端本地完成处理已完成
operation text
使用 I/O 句柄执行的操作：
invalid，尚不清楚
readv，向量化读取
writev，向量化写入
off int8
I/O 操作的偏移量。
length int8
I/O 操作的长度。
target text
I/O 目标对象的类型：
smgr，对关系的 I/O
handle_data_len int2
与 I/O 操作相关的数据长度。对于从
shared_buffers 和 temp_buffers 的 I/O，这表示 I/O 操作的缓冲区数量。
raw_result int4
I/O 操作的低级结果，如果操作尚未完成则为 NULL。
result text
I/O 操作的高级结果：
UNKNOWN 表示操作的结果尚不清楚。
OK 表示 I/O 成功完成。
PARTIAL 表示 I/O 成功完成但未处理所有数据。通常调用者需要重试并在单独的 I/O 中完成剩余工作。
WARNING 表示 I/O 成功完成，但执行 I/O 时触发了警告。例如，当启用 zero_damaged_pages 时遇到损坏的缓冲区。
ERROR 表示 I/O 失败并出现错误。
target_desc text
I/O 操作目标的描述。
f_sync bool
指示 I/O 是否以同步方式执行的标志。
f_localmem bool
指示 I/O 是否引用进程本地内存的标志。
f_buffered bool
指示 I/O 是否为缓冲 I/O 的标志。
pg_aios 视图是只读的。
默认情况下，只有超级用户或具有
pg_read_all_stats 角色权限的角色可以读取 pg_aios 视图。
上一页 上一级 下一页53.1. 概述 起始页 53.3. pg_available_extensions
