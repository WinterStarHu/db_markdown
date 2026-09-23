# 52.3. pg_am

52.3. pg_am
版本：
纠错本页面
搜索
目录导航
❮
❯
52.3. pg_am #
目录pg_am存储关于关系访问方法的信息。系统支持的每种访问方法在这个目录中都有一行。
目前只有表和索引拥有访问方法。表和索引访问方法的需求分别在第 62 章和第 63 章中详细讨论。
表 52.3. pg_am 列
列类型
描述
oid oid
行标识符
amname name
访问方法的名称
amhandler regproc
(references pg_proc.oid)
负责提供有关访问方法的信息的处理函数的 OID
amtype char
t = 表（包括物化视图），
i = 索引。
注意
在PostgreSQL 9.6 之前，pg_am
包含很多额外的列以表示索引访问方法的属性。那些数据现在只有在 C 代码级别才是直接可见的。
不过，系统中增加了pg_index_column_has_property()和相关函数来允许 SQL 查询检查索引访问方法的属性；请见表 9.76。
上一页 上一级 下一页52.2. pg_aggregate 起始页 52.4. pg_amop
