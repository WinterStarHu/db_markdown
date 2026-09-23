# 35.49. sql_implementation_info

35.49. sql_implementation_info
版本：
纠错本页面
搜索
目录导航
❮
❯
35.49. sql_implementation_info #
表sql_implementation_info包含的信息指示由 SQL 标准实现定义的多个方面。这类信息主要用于 ODBC 接口的情境；其他接口的用户可能会发现这类信息用处不大。由于这个原因，个体实现信息项没有在这里描述，你将会在 ODBC 接口的描述中找到它们。
表 35.47. sql_implementation_info 列
列类型
描述
implementation_info_id character_data
实现信息项的标识符字符串
implementation_info_name character_data
实现信息项的描述性名称
integer_value cardinal_number
该实现信息项的值，如果该值被包含在列
character_value中则为空
character_value character_data
该实现信息项的值，如果该值被包含在列
integer_value中则为空
comments character_data
可能是与该实现信息项相关的一段注释
上一页 上一级 下一页35.48. sql_features 起始页 35.50. sql_parts
