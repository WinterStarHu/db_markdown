# 53.34. pg_timezone_names

53.34. pg_timezone_names
版本：
纠错本页面
搜索
目录导航
❮
❯
53.34. pg_timezone_names #
视图pg_timezone_names提供了一个由SET TIMEZONE识别的时区名称列表，
以及它们的相关缩写、UTC偏移和夏令时状态。
（从技术上讲，PostgreSQL不使用UTC，因为不处理闰秒。）
与在pg_timezone_abbrevs中显示的缩写不同，
这些名称中的许多暗示了一组夏令时转换日期规则。
因此，相关信息在本地夏令时边界上发生变化。
显示的信息是基于CURRENT_TIMESTAMP的当前值计算的。
表 53.34. pg_timezone_names 列
列类型
描述
name text
时区名
abbrev text
时区缩写
utc_offset interval
相对于UTC的偏移（正值表示格林威治东部）
is_dst bool
如果当前观察到夏令时则为真
上一页 上一级 下一页53.33. pg_timezone_abbrevs 起始页 53.35. pg_user
