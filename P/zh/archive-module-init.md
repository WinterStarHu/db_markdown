# 49.1. 初始化函数

49.1. 初始化函数
版本：
纠错本页面
搜索
目录导航
❮
❯
49.1. 初始化函数 #
一个归档库是通过动态加载一个共享库来加载的，使用
archive_library'的名称作为库的基本名称。正常的库搜索路径
用于定位该库。为了提供所需的归档模块回调并表明该库实际上是一个归档模块，
它需要提供一个名为_PG_archive_module_init的函数。该函数的
返回值必须是一个指向类型为ArchiveModuleCallbacks的结构体的指针，
该结构体包含核心代码需要了解的所有信息，以便使用归档模块。返回值需要具有服务器
生命周期，这通常通过在全局范围内将其定义为static const变量来实现。
typedef struct ArchiveModuleCallbacks
{
ArchiveStartupCB startup_cb;
ArchiveCheckConfiguredCB check_configured_cb;
ArchiveFileCB archive_file_cb;
ArchiveShutdownCB shutdown_cb;
} ArchiveModuleCallbacks;
typedef const ArchiveModuleCallbacks *(*ArchiveModuleInit) (void);
只有archive_file_cb回调是必需的。其他的都是可选的。
上一页 上一级 下一页第 49 章 存档模块 起始页 49.2. 归档模块回调
