# 64.2. 自定义WAL资源管理器

64.2. 自定义WAL资源管理器
版本：
纠错本页面
搜索
目录导航
❮
❯
64.2. 自定义WAL资源管理器 #
本节解释了核心PostgreSQL系统与自定义WAL资源管理器之间的接口，
这些资源管理器使扩展能够直接与WAL集成。
一个扩展，特别是表访问方法或索引访问方法，可能需要使用WAL进行恢复、复制和/或
逻辑解码。
要创建一个新的自定义WAL资源管理器，首先定义一个RmgrData结构，其中包含资源管理器方法的实现。
参考src/backend/access/transam/README和src/include/access/xlog_internal.h中的PostgreSQL源代码。
/*
* 用于资源管理器的方法表。
*
* 此结构必须与rmgr.c中的PG_RMGR定义保持同步。
*
* rm_identify必须根据xl_info（而不是rmid）返回记录的名称。例如，XLOG_BTREE_VACUUM将被命名为“VACUUM”。
* 如果可用，rm_desc可以被调用以获取记录的其他详细信息（例如，最后一个块）。
*
* rm_mask以资源管理器修改的页面作为输入，并屏蔽掉不应被wal_consistency_checking标记的位。
*
* RmgrTable[]由RmgrId值（参见rmgrlist.h）索引。如果rm_name为NULL，则相应的RmgrTable条目被视为无效。
*/
typedef struct RmgrData
{
const char *rm_name;
void        (*rm_redo) (XLogReaderState *record);
void        (*rm_desc) (StringInfo buf, XLogReaderState *record);
const char *(*rm_identify) (uint8 info);
void        (*rm_startup) (void);
void        (*rm_cleanup) (void);
void        (*rm_mask) (char *pagedata, BlockNumber blkno);
void        (*rm_decode) (struct LogicalDecodingContext *ctx,
struct XLogRecordBuffer *buf);
} RmgrData;
模块src/test/modules/test_custom_rmgrs包含一个可用的示例，
演示了自定义WAL资源管理器的用法。
然后，注册您的新资源管理器。
/*
* 注册一个新的自定义WAL资源管理器。
*
* 资源管理器ID必须在所有扩展中全局唯一。请参考
* https://wiki.postgresql.org/wiki/CustomWALResourceManagers 为您的扩展保留一个
* 唯一的RmgrId，以避免与其他扩展开发者发生冲突。在开发过程中，
* 使用RM_EXPERIMENTAL_ID以避免不必要地保留一个新的ID。
*/
extern void RegisterCustomRmgr(RmgrId rmid, const RmgrData *rmgr);
必须从扩展模块的_PG_init函数中调用
RegisterCustomRmgr。在开发新扩展时，为
rmid使用RM_EXPERIMENTAL_ID。
当您准备将扩展发布给用户时，请在自定义WAL资源
管理器页面上保留一个新的资源管理器ID。
将实现自定义资源管理器的扩展模块放置在shared_preload_libraries中，
这样它将在PostgreSQL启动期间早期加载。
注意
扩展必须保留在shared_preload_libraries中，只要系统中可能存在任何自定义的WAL记录。
否则，PostgreSQL将无法应用或解码自定义的WAL记录，这可能会导致服务器无法启动。
上一页 上一级 下一页64.1. 通用WAL记录 起始页 第 65 章 内置索引访问方法
