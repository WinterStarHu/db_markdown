# 58.3. 外部数据包装器助手函数

58.3. 外部数据包装器助手函数
版本：
纠错本页面
搜索
目录导航
❮
❯
58.3. 外部数据包装器助手函数 #
多个助手函数从核心服务器导出，以便外部数据包装器的作者可以轻松访问FDW相关对象的属性，例如FDW选项。
要使用这些函数中的任何一个，你需要在你的源文件中包含头文件foreign/foreign.h。该头文件还定义了这些函数返回的结构类型。
ForeignDataWrapper *
GetForeignDataWrapperExtended(Oid fdwid, bits16 flags);
此功能返回具有给定 OID 的外数据包装器的ForeignDataWrapper对象。
ForeignDataWrapper对象包含 FDW 的属性（详细信息请参阅foreign/foreign.h）。
flags是一个按位或的位掩码，指示一组额外的选项集。
它可以取值FDW_MISSING_OK，在这种情况下NULL 结果将返回给调用方，而不是返回错误给未定义的对象。
ForeignDataWrapper *
GetForeignDataWrapper(Oid fdwid);
这个函数为具有给定 OID 的外数据包装器返回一个ForeignDataWrapper对象。一个ForeignDataWrapper对象包含该FDW的属性（详见foreign/foreign.h）。
ForeignServer *
GetForeignServerExtended(Oid serverid, bits16 flags);
此功能返回具有给定 OID 的外服务器的ForeignServer对象。
ForeignServer对象包含服务器的属性（详细信息请参阅foreign/foreign.h）。
flags是一个按位或的位掩码，指示一组额外的选项集。
它可以取值FSV_MISSING_OK，在这种情况下NULL 结果将返回给调用方，而不是返回错误给未定义的对象。
ForeignServer *
GetForeignServer(Oid serverid);
这个函数为一个具有给定 OID 的外服务器返回ForeignServer对象。一个ForeignServer对象包含该服务器的属性（详见foreign/foreign.h）。
UserMapping *
GetUserMapping(Oid userid, Oid serverid);
这个函数为在给定服务器上的给定角色的用户映射返回UserMapping对象（如果指定用户没有映射，它将返回PUBLIC的映射，如果也没有则抛出错误）。一个UserMapping对象包含该用户映射的属性（详见foreign/foreign.h）。
ForeignTable *
GetForeignTable(Oid relid);
该函数为一个具有给定 OID 的外部表返回ForeignTable对象。一个ForeignTable对象包含该外部表的属性（详见foreign/foreign.h）。
List *
GetForeignColumnOptions(Oid relid, AttrNumber attnum);
这个函数为一个具有给定外部表 OID 和属性号的列返回针对每一列的FDW选项，形式为一个DefElem列表。如果该列没有选项则返回 NIL。
某些对象类型除了基于OID的查找函数之外，还具有基于名称的查找函数：
ForeignDataWrapper *
GetForeignDataWrapperByName(const char *name, bool missing_ok);
这个函数为一个具有给定名称的外部数据包装器返回ForeignDataWrapper对象。如果包装器没有找到，在missing_ok为真时返回 NULL，否则抛出一个错误。
ForeignServer *
GetForeignServerByName(const char *name, bool missing_ok);
这个函数为一个具有给定名称的外部服务器返回ForeignServer对象。如果该服务器没有找到，在missing_ok为真时返回 NULL，否则抛出一个错误。
上一页 上一级 下一页58.2. 外部数据包装器回调例程 起始页 58.4. 外部数据包装器查询规划
