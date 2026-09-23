# 47.3. 流复制协议接口

47.3. 流复制协议接口
版本：
纠错本页面
搜索
目录导航
❮
❯
47.3. 流复制协议接口 #
命令
CREATE_REPLICATION_SLOT slot_name LOGICAL output_pluginDROP_REPLICATION_SLOT slot_name [ WAIT ]START_REPLICATION SLOT slot_name LOGICAL ...
被用来创建、删除以及流式传送一个复制槽。这些命令只能在一个复制连接上使用。
它们不能通过 SQL 使用。这些命令的详情请见
第 54.4 节。
命令pg_recvlogical可以被用来控制一个流复制连接上的逻辑
解码（它在内部使用这些命令）。
上一页 上一级 下一页47.2. 逻辑解码概念 起始页 47.4. 逻辑解码的 SQL 接口
