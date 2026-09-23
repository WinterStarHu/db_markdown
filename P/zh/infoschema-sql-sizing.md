# 35.51. sql_sizing

35.51. sql_sizing
版本：
纠错本页面
搜索
目录导航
❮
❯
35.51. sql_sizing #
表sql_sizing包含有关PostgreSQL中各种尺寸限制和最大值的信息。该信息主要用于ODBC接口的上下文中；其他接口的用户可能会发现这些信息用处不大。出于这个原因，个别尺寸项在这里没有描述；你将在ODBC接口的描述中找到它们。
表 35.49. sql_sizing 列
列类型
描述
sizing_id cardinal_number
尺寸项的标识符
sizing_name character_data
尺寸项的描述性名称
supported_value cardinal_number
尺寸项的值，如果尺寸是不受限制或不能确定的则为 0，如果尺寸项适用的特性不受支持则为 null
comments character_data
可能与尺寸项相关的注释
上一页 上一级 下一页35.50. sql_parts 起始页 35.52. table_constraints
