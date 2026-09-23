# 52.61. pg_ts_dict

52.61. pg_ts_dict
版本：
纠错本页面
搜索
目录导航
❮
❯
52.61. pg_ts_dict #
pg_ts_dict目录包含定义文本搜索字典的项。一个字典依赖于一个文本搜索模板，它指定了所有需要的函数实现，字典本身则为模板支持的用户可设置参数提供值。这种分工允许无权限的用户创建字典。参数由一个文本串dictinitoption定义，其格式和意义随着模板而变化。
PostgreSQL的文本搜索特性在第 12 章中有详尽的描述。
表 52.61. pg_ts_dict Columns
列类型
描述
oid oid
行标识符
dictname name
文本搜索字典名
dictnamespace oid
(references pg_namespace.oid)
包含该字典的命名空间的OID
dictowner oid
(references pg_authid.oid)
字典的拥有者
dicttemplate oid
(references pg_ts_template.oid)
该字典的文本搜索模板的OID
dictinitoption text
模板的初始化选项字符串
上一页 上一级 下一页52.60. pg_ts_config_map 起始页 52.62. pg_ts_parser
