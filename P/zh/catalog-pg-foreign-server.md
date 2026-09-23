# 52.24. pg_foreign_server

52.24. pg_foreign_server
版本：
纠错本页面
搜索
目录导航
❮
❯
52.24. pg_foreign_server #
目录 pg_foreign_server 存储外部服务器定义。外部服务器定义了外部数据的来源，例如一个远程服务器。外部服务器通过外部数据包装器来访问。
表 52.24. pg_foreign_server 列
列类型
描述
oid oid
行标识符
srvname name
外部服务器的名称
srvowner oid
(references pg_authid.oid)
外部服务器的拥有者
srvfdw oid
(references pg_foreign_data_wrapper.oid)
此外部服务器的外部数据包装器的OID
srvtype text
服务器的类型（可选）
srvversion text
服务器的版本（可选）
srvacl aclitem[]
访问权限；详见 第 5.8 节 获取详细信息
srvoptions text[]
外部服务器特定选项，以 “keyword=value” 字符串形式
上一页 上一级 下一页52.23. pg_foreign_data_wrapper 起始页 52.25. pg_foreign_table
