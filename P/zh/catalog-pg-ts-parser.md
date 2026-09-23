# 52.62. pg_ts_parser

52.62. pg_ts_parser
版本：
纠错本页面
搜索
目录导航
❮
❯
52.62. pg_ts_parser #
pg_ts_parser目录包含定义文本搜索分析器的项。一个分析器负责将输入文本分割成词位并为每一个词位分配一个记号类型。由于一个分析器必须用C语言级别的函数实现，创建新分析器的工作只限于数据库超级用户。
PostgreSQL的文本搜索特性在第 12 章中有更详尽的描述。
表 52.62. pg_ts_parser Columns
列类型
描述
oid oid
行标识符
prsname name
文本搜索解析器名称
prsnamespace oid
(references pg_namespace.oid)
包含此分析器的命名空间的OID
prsstart regproc
(references pg_proc.oid)
分析器启动函数的OID
prstoken regproc
(references pg_proc.oid)
分析器的下一记号函数的OID
prsend regproc
(references pg_proc.oid)
分析器的关闭函数的OID
prsheadline regproc
(references pg_proc.oid)
分析器的标题函数的OID（没有则为零）
prslextype regproc
(references pg_proc.oid)
分析器的词汇类型函数的OID
上一页 上一级 下一页52.61. pg_ts_dict 起始页 52.63. pg_ts_template
