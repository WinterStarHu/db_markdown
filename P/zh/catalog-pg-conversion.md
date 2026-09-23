# 52.14. pg_conversion

52.14. pg_conversion
版本：
纠错本页面
搜索
目录导航
❮
❯
52.14. pg_conversion #
目录 pg_conversion 描述编码转换函数。更多信息参见 CREATE CONVERSION。
表 52.14. pg_conversion Columns
列类型
描述
oid oid
行标识符
conname name
转换名称（在一个命名空间内唯一）
connamespace oid
(references pg_namespace.oid)
包含此转换的命名空间的OID
conowner oid
(references pg_authid.oid)
转换的拥有者
conforencoding int4
源编码ID（pg_encoding_to_char()
可以将此数字转换为编码名称）
contoencoding int4
目标编码ID（pg_encoding_to_char()
可以将此数字转换为编码名称）
conproc regproc
(references pg_proc.oid)
转换函数
condefault bool
如果这是默认转换则为真
上一页 上一级 下一页52.13. pg_constraint 起始页 52.15. pg_database
