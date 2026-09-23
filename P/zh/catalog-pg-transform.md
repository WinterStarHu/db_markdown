# 52.57. pg_transform

52.57. pg_transform
版本：
纠错本页面
搜索
目录导航
❮
❯
52.57. pg_transform #
目录pg_transform存储有关转换的信息，转换是
一种让数据类型适应过程语言的机制。详见CREATE TRANSFORM。
表 52.57. pg_transform 列
列类型
描述
oid oid
行标识符
trftype oid
(参考 pg_type.oid)
这个转换所针对的数据类型的 OID
trflang oid
(参考 pg_language.oid)
这个转换所针对的语言的 OID
trffromsql regproc
(参考 pg_proc.oid)
用于将数据类型转换为过程语言输入（例如函数参数）的函数的 OID。
如果要使用默认行为，这里存储零。
trftosql regproc
(references pg_proc.oid)
用于将过程语言的输出（例如返回值）转换为该数据类型的函数的 OID。
如果要使用默认行为，这里存储零。
上一页 上一级 下一页52.56. pg_tablespace 起始页 52.58. pg_trigger
