# 52.23. pg_foreign_data_wrapper

52.23. pg_foreign_data_wrapper
版本：
纠错本页面
搜索
目录导航
❮
❯
52.23. pg_foreign_data_wrapper #
目录pg_foreign_data_wrapper存储外部数据包装器定义。外部数据包装器是一种访问位于外部服务器上数据的机制。
表 52.23. pg_foreign_data_wrapper 列
列类型
描述
oid oid
行标识符
fdwname name
外部数据包装器的名称
fdwowner oid
(references pg_authid.oid)
外部数据包装器的拥有者
fdwhandler oid
(references pg_proc.oid)
指一个负责为外部数据包装器提供执行例程的处理函数。如果没有提供处理函数则为零
fdwvalidator oid
(references pg_proc.oid)
指一个负责检查传给外部数据包装器的选项的有效性的验证函数，包括外部服务器选项以及使用外部数据包装器的用户映射。如果没有提供验证函数则为零
fdwacl aclitem[]
访问权限；详见 第 5.8 节
fdwoptions text[]
外部数据包装器特定选项，以 “keyword=value” 字符串形式
上一页 上一级 下一页52.22. pg_extension 起始页 52.24. pg_foreign_server
