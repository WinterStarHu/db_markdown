# 19.15. 预置选项

19.15. 预置选项
版本：
纠错本页面
搜索
目录导航
❮
❯
19.15. 预置选项 #
下列“参数”是只读的。
同样，它们被排除在postgresql.conf文件例子之外。
这些选项报告特定应用可能感兴趣的多种PostgreSQL行为，特别是管理前端相关的行为。
所有这些都是在PostgreSQL被编译或者它被安装时决定的。
block_size (integer)
#
报告一个磁盘块的大小。它由编译服务器时BLCKSZ的值确定。默认值是 8192 字节。有些配置变量的含义（例如shared_buffers）会被block_size影响。详见第 19.4 节。
data_checksums (boolean)
#
报告对这个集簇是否启用了数据校验码。详见-k。
data_directory_mode (integer)
#
在 Unix 系统上，此参数报告数据目录（由 data_directory 定义）
在服务器启动时的权限。
（在 Microsoft Windows 上，此参数将始终显示
0700。）有关更多信息，请参见
应用程序 initdb 的 -g 选项
debug_assertions (boolean)
#
报告编译PostgreSQL时是否启用了断言。
如果PostgreSQL被编译时定义了宏
USE_ASSERT_CHECKING，那么会报告已启用（例如通过
configure选项
--enable-cassert）。默认情况下
PostgreSQL编译时没有用断言。
huge_pages_status (enum)
#
报告当前实例中大页的状态：on、off或
unknown（如果使用postgres -C显示）。
该参数用于判断在huge_pages=try下是否成功分配了大页。
详情请参见huge_pages。
integer_datetimes (boolean)
#
报告PostgreSQL是否在编译时打开了 64 位整数日期和时间。从PostgreSQL 10起，这个值总是on。
in_hot_standby (boolean)
#
报告服务器当前是否处于热备模式。
当这个是on的时候，所有的事务强制为只读。
在会话中，这个只能在服务器提升为主服务器的时候变更。
更多信息参见第 26.4 节
max_function_args (integer)
#
报告函数参数的最大数量。它由编译服务器时的FUNC_MAX_ARGS值决定。默认值是 100 个参数。
max_identifier_length (integer)
#
报告标识符的最大长度。它由编译服务器时的NAMEDATALEN值减一决定。NAMEDATALEN的默认值是 64；因此max_identifier_length的默认值是 63 字节，但在使用多字节编码时可以少于 63 个字符。
max_index_keys (integer)
#
报告索引键的最大数量。它由编译服务器时的INDEX_MAX_KEYS值决定。默认值是 32 个键。
num_os_semaphores (integer)
#
报告服务器所需的信号量数量，基于配置的允许连接数
(max_connections), 允许的 autovacuum 工作进程
(autovacuum_max_workers), 允许的 WAL
发送进程 (max_wal_senders), 允许的
后台进程 (max_worker_processes), 等等。
segment_size (integer)
#
报告一个文件段中可以存储的块（页）的数量。由编译服务器时的RELSEG_SIZE值决定。一个段文件的最大大小（以字节计）等于segment_size乘以block_size，默认是1GB。
server_encoding (string)
#
报告数据库的编码（字符集）。这是在数据库创建时决定的。通常，客户端只需要关心client_encoding的值。
server_version (string)
#
报告服务器版本号。它是由编译服务器时的PG_VERSION值决定的。
server_version_num (integer)
#
报告服务器版本号的整数值。它是由编译服务器时的PG_VERSION_NUM值决定的。
shared_memory_size (integer)
#
报告主共享内存区域的大小，四舍五入到最接近的兆字节。
shared_memory_size_in_huge_pages (integer)
#
报告基于指定的 huge_page_size 所需的主共享内存区域的大页数。
如果不支持大页，这将是 -1。
这个设置仅在 Linux 上受支持。在其他平台上，它始终设置为 -1。
有关在 Linux 上使用大页的更多详细信息，请参见 第 18.4.5 节。
ssl_library (string)
#
报告此 PostgreSQL 服务器已构建的 SSL 库的名称（即使此实例当前未配置或使用 SSL），
例如 OpenSSL，或一个空字符串（如果没有）。
wal_block_size (integer)
#
报告一个 WAL 磁盘块的尺寸。由编译服务器时的XLOG_BLCKSZ值决定。默认值是 8192 字节。
wal_segment_size (integer)
#
报告 WAL 日志段的大小。默认值是 16MB。详见第 28.5 节。
上一页 上一级 下一页19.14. 错误处理 起始页 19.16. 自定义选项
