# 52.22. pg_extension

52.22. pg_extension
版本：
纠错本页面
搜索
目录导航
❮
❯
52.22. pg_extension #
目录 pg_extension 存储有关已安装扩展的信息。有关扩展的细节请参见 第 36.17 节。
表 52.22. pg_extension Columns
列类型
描述
oid oid
行标识符
extname name
扩展的名称
extowner oid
(references pg_authid.oid)
扩展的拥有者
extnamespace oid
(references pg_namespace.oid)
包含扩展导出对象的模式
extrelocatable bool
如果扩展可以重定位到另一个模式则为真
extversion text
扩展的版本名称
extconfig oid[]
(references pg_class.oid)
扩展配置表的regclass OID数组，如果没有则为NULL
extcondition text[]
扩展配置表的WHERE子句过滤条件的数组，如果没有则为NULL
注意和大部分具有一个“namespace”列的模式不同，extnamespace不是用来表示扩展属于该模式。扩展的名字从不用模式进行限定。extnamespace表明该模式包含了该扩展的大部分或全部对象。如果extrelocatable为真，则该模式事实上必须包含属于此扩展的全部模式限定的对象。
上一页 上一级 下一页52.21. pg_event_trigger 起始页 52.23. pg_foreign_data_wrapper
