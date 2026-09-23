# 第 62 章 表访问方法接口定义

第 62 章 表访问方法接口定义
版本：
纠错本页面
搜索
目录导航
❮
❯
第 62 章 表访问方法接口定义
本章阐述PostgreSQL核心系统与表访问方法间的接口，其管理表的存储。除这里指出的内容，核心系统对于这些访问方法知之甚少，因此可以通过编写附加代码来开发全新的访问方法类型。
每个表访问方法都有pg_am系统目录中的一行来描述。pg_am条目为表访问方法指定一个名字和句柄函数。这些条目可以用SQL命令CREATE ACCESS METHOD和DROP ACCESS METHOD来创建和删除。
表访问方法处理函数必须声明为接受一个类型为 internal 的单一参数，并返回伪类型 table_am_handler。该参数是一个虚拟值，仅用于防止处理函数直接从 SQL 命令中被调用。
下面是一个扩展 SQL 脚本文件如何创建表访问方法处理函数的示例：
CREATE OR REPLACE FUNCTION my_tableam_handler(internal)
RETURNS table_am_handler AS 'my_extension', 'my_tableam_handler'
LANGUAGE C STRICT;
CREATE ACCESS METHOD myam TYPE TABLE HANDLER my_tableam_handler;
函数的返回值必须是指向类型为 TableAmRoutine 的结构体的指针，该结构体包含核心代码需要知道的所有信息，以便使用表访问方法。返回值需要具有服务器生命周期，通常通过在全局作用域中将其定义为 static const 变量来实现。
下面是一个包含表访问方法处理程序的源文件可能的样子：
#include "postgres.h"
#include "access/tableam.h"
#include "fmgr.h"
PG_MODULE_MAGIC;
static const TableAmRoutine my_tableam_methods = {
.type = T_TableAmRoutine,
/* Methods of TableAmRoutine omitted from example, add them here. */
};
PG_FUNCTION_INFO_V1(my_tableam_handler);
Datum
my_tableam_handler(PG_FUNCTION_ARGS)
{
PG_RETURN_POINTER(&my_tableam_methods);
}
TableAmRoutine 结构体，也称为访问方法的 API 结构，使用回调定义访问方法的行为。这些回调是指向普通 C 函数的指针，在 SQL 层面上不可见或不可调用。所有回调及其行为在 TableAmRoutine 结构体中定义（结构体内部的注释定义了回调的要求）。大多数回调都有包装函数，这些函数从表访问方法的用户（而不是实现者）的角度进行文档说明。有关详细信息，请参阅
src/include/access/tableam.h 文件。
要实现一个访问方法，实现者通常需要实现一个AM特定类型的元组表槽（参见
src/include/executor/tuptable.h），该槽允许访问方法之外的代码持有对AM元组的引用，
并访问元组的列。
目前AM存储数据的实际方式完全没有限制。例如，可以使用postgres的共享缓冲区缓存，但这并非必需。如果使用它，使用第 66.6 节中所述的PostgreSQL的标准页面布局可能很有意义。
当前表访问方法API的一个相当大的限制是，如果AM要支持修改和/或索引，每个元组都需要有由块号和项目号组成的元组标识符（TID）（见第 66.6 节）。TIDs的子部分不一定具有与堆相同的含义，但如果需要位图扫描支持（可选），则块号需要提供局部性。
为了崩溃安全性，AM可以使用postgres的WAL，或者自定义实现。
如果选择WAL，可以使用通用WAL记录，
或者实现一个自定义WAL资源管理器。
要以允许在单个事务中访问不同表访问方法的方式实现事务支持，可能需要与src/backend/access/transam/xlog.c中的机制紧密集成。
新的表访问方法的开发人员可以参考src/backend/access/heap/heapam_handler.c中已有的堆实现代码，以了解其实现的细节。
上一页 上一级 下一页61.4. 进一步阅读 起始页 第 63 章 索引访问方法接口定义
