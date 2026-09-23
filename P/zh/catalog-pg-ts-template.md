# 52.63. pg_ts_template

52.63. pg_ts_template
版本：
纠错本页面
搜索
目录导航
❮
❯
52.63. pg_ts_template #
pg_ts_template目录包含定义文本搜索模板的项。一个模板是一类文本搜索字典的实现骨架。由于一个模板必须用C语言级别的函数实现，新模板的创建只限于数据库超级用户。
PostgreSQL的文本搜索特性在第 12 章中有详尽的描述。
表 52.63. pg_ts_template Columns
列类型
描述
oid oid
行标识符
tmplname name
文本搜索模板名称
tmplnamespace oid
(references pg_namespace.oid)
包含此模板的名字空间的OID
tmplinit regproc
(references pg_proc.oid)
模板的初始化函数的OID（没有则为零）
tmpllexize regproc
(references pg_proc.oid)
模板的词汇化函数的OID
上一页 上一级 下一页52.62. pg_ts_parser 起始页 52.64. pg_type
