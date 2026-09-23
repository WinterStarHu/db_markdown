# 35.50. sql_parts

35.50. sql_parts
版本：
纠错本页面
搜索
目录导航
❮
❯
35.50. sql_parts #
表sql_parts包含的信息指示哪些定义在 SQL 标准中的部分被PostgreSQL支持。
表 35.48. sql_parts 列
列类型
描述
feature_id character_data
包含该部分编号的标识符字符串
feature_name character_data
该部分的描述性名称
is_supported yes_or_no
YES 如果当前版本的PostgreSQL完全支持该部分，
NO 如果不支持
is_verified_by character_data
总是为空，因为PostgreSQL开发组没有对特性的一致性执行正式的测试
comments character_data
可能是关于该部分支持状态的注释
上一页 上一级 下一页35.49. sql_implementation_info 起始页 35.51. sql_sizing
