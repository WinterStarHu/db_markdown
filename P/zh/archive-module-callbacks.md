# 49.2. 归档模块回调

49.2. 归档模块回调
版本：
纠错本页面
搜索
目录导航
❮
❯
49.2. 归档模块回调 #49.2.1. 启动回调49.2.2. 检查回调49.2.3. 存档回调49.2.4. 关闭回调
归档回调定义模块的实际归档行为。
服务器将根据需要调用它们来处理每个单独的WAL文件。
49.2.1. 启动回调 #
在模块加载后不久会调用startup_cb回调。此回调可用于执行
任何所需的额外初始化。如果归档模块有任何状态，可以使用
state->private_data来存储它。
typedef void (*ArchiveStartupCB) (ArchiveModuleState *state);
49.2.2. 检查回调 #
check_configured_cb回调函数被调用以确定模块是否已完全配置并准备好接
收WAL文件（例如，其配置参数已设置为有效值）。如果未定义
check_configured_cb，服务器始终假定模块已配置。
typedef bool (*ArchiveCheckConfiguredCB) (ArchiveModuleState *state);
如果返回true，服务器将通过调用archive_file_cb回调
函数继续归档文件。如果返回false，归档将不会继续，归档器将向服务器日志
输出以下消息：
WARNING:  archive_mode enabled, yet archiving is not configured
在后一种情况下，服务器将定期调用此函数，并且只有当其返回true时，归档
才会继续。
注意
返回false时，附加一些额外信息到通用警告消息可能会很有用。
为此，在返回false之前，向arch_module_check_errdetail宏
提供一条消息。像errdetail()一样，该宏接受一个格式字符串，
后跟可选的参数列表。生成的字符串将作为警告消息的DETAIL行发出。
49.2.3. 存档回调 #
archive_file_cb 回调函数被调用以归档单个 WAL 文件。
typedef bool (*ArchiveFileCB) (ArchiveModuleState *state, const char *file, const char *path);
如果返回 true，服务器将继续处理，仿佛文件已成功归档，
这可能包括回收或删除原始 WAL 文件。如果返回 false 或抛出错误，
服务器将保留原始 WAL 文件并稍后重试归档。file 只包含
要归档的 WAL 文件名，而 path 包含 WAL 文件的完整路径
（包括文件名）。
注意
archive_file_cb 回调函数在一个短暂的内存上下文中被调用，
该上下文将在每次调用之间重置。如果您需要更长生命周期的存储，
请在模块的 startup_cb 回调中创建一个内存上下文。
49.2.4. 关闭回调 #
当归档器进程退出（例如，发生错误后）或
archive_library 的值发生变化时，会调用
shutdown_cb 回调。如果没有定义
shutdown_cb，在这些情况下不会采取特殊操作。
如果归档模块有任何状态，此回调应释放它以避免内存泄漏。
typedef void (*ArchiveShutdownCB) (ArchiveModuleState *state);
上一页 上一级 下一页49.1. 初始化函数 起始页 第 50 章 OAuth 验证器模块
