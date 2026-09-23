# 53.16. pg_prepared_statements

53.16. pg_prepared_statements
版本：
纠错本页面
搜索
目录导航
❮
❯
53.16. pg_prepared_statements #
pg_prepared_statements视图显示当前会话中所有可用的预处理语句。
有关预处理语句的更多信息，请参见PREPARE。
pg_prepared_statements包含每个预处理语句的一行。
当创建新的预处理语句时，将行添加到视图中，并在释放预处理语句时（例如，通过
DEALLOCATE命令）将其移除。
表 53.16. pg_prepared_statements 列
列类型
描述
name text
预处理语句的标识符
statement text
客户端提交用于创建此预处理语句的查询语句。对于通过SQL创建的预处理语句，这里是由客户端提交的PREPARE语句。
对于通过前端/后端协议创建的预处理语句，这里是预处理语句本身的文本。
prepare_time timestamptz
预处理语句被创建的时间
parameter_types regtype[]
预处理语句期望的参数类型，以一个regtype数组的形式。这个数组中一个元素所对应的OID可通过将regtype值转换为oid获得。
result_types regtype[]
由预处理语句返回的列的类型，以regtype数组的形式表示。
可以通过将regtype值转换为oid来获取此数组
元素对应的OID。如果预处理语句不提供结果（例如，DML语句），
则此字段将为null。
from_sql bool
如果预处理语句通过SQL命令PREPARE创建，则为true；如果预处理语句通过前端/后端协议创建，则为false
generic_plans int8
被选中的通用计划的次数
custom_plans int8
被选中的自定义计划的次数
pg_prepared_statements视图是只读的。
上一页 上一级 下一页53.15. pg_policies 起始页 53.17. pg_prepared_xacts
