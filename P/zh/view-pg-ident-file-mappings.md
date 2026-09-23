# 53.11. pg_ident_file_mappings

53.11. pg_ident_file_mappings
版本：
纠错本页面
搜索
目录导航
❮
❯
53.11. pg_ident_file_mappings #
视图pg_ident_file_mappings提供了客户端用户名映射配置文件
pg_ident.conf内容的摘要。
在该视图中，每个非空非注释行都会显示一行，同时还会显示注释，指示是否成功应用映射。
这个视图对于检查计划中的身份验证配置文件的更改是否有效，或者诊断先前的故障非常有帮助。
请注意，这个视图报告的是文件的current内容，而不是服务器上次加载的内容。
默认情况下，pg_ident_file_mappings视图只能被超级用户读取。
表 53.11. pg_ident_file_mappings 列
列类型
描述
map_number int4
此映射的编号，按优先顺序排列，如果有效，否则为
NULL
file_name text
包含此映射的文件的名称
line_number int4
此映射在file_name中的行号
map_name text
映射名称
sys_name text
检测到客户端的用户名称
pg_username text
请求的 PostgreSQL 用户名
error text
如果不是 NULL，则表示为什么无法处理此行的错误消息
通常，反映错误条目的行只会有 line_number 和 error 字段的值。
查看 第 20 章 以获取有关客户端身份验证配置的更多信息。
上一页 上一级 下一页53.10. pg_hba_file_rules 起始页 53.12. pg_indexes
