# 35.47. sequences

35.47. sequences
版本：
纠错本页面
搜索
目录导航
❮
❯
35.47. sequences #
视图sequences包含所有定义在当前数据库中的序列。只有那些当前用户能够访问（作为拥有者或具有某些特权）的序列才会被显示。
表 35.45. sequences 列
列类型
描述
sequence_catalog sql_identifier
包含该序列的数据库名称（总是当前数据库）
sequence_schema sql_identifier
包含该序列的模式名称
sequence_name sql_identifier
序列名称
data_type character_data
序列的数据类型
numeric_precision cardinal_number
这一列包含这个序列数据类型（见上文）的（声明的或隐式的）精度。精度指示了有效位数。
它可以按照列numeric_precision_radix中指定的以十进制（基于 10）或二进制（基于 2）表示。
numeric_precision_radix cardinal_number
这一列指示numeric_precision和numeric_scale列中的值是基于什么来表示。该值为 2 或 10。
numeric_scale cardinal_number
这一列包含这个序列数据类型（见上文）的（声明的或隐式的）比例。比例指示了小数点右侧的有效位数。
它可以按照列numeric_precision_radix中指定的以十进制（基于 10）或二进制（基于 2）表示。
start_value character_data
序列的起始值
minimum_value character_data
序列的最小值
maximum_value character_data
序列的最大值
increment character_data
序列的增量
cycle_option yes_or_no
如果该序列循环，则为YES，否则为NO
注意依照 SQL 标准，开始值、最小值、最大值和增量值作为字符串返回。
上一页 上一级 下一页35.46. schemata 起始页 35.48. sql_features
