# 53.33. pg_timezone_abbrevs

53.33. pg_timezone_abbrevs
版本：
纠错本页面
搜索
目录导航
❮
❯
53.33. pg_timezone_abbrevs #
视图 pg_timezone_abbrevs 提供了一个
当前被日期时间输入例程识别的时区缩写列表。
当 TimeZone 或
timezone_abbreviations 运行时参数被
修改时，此视图的内容会发生变化。
表 53.33. pg_timezone_abbrevs 列
列类型
描述
abbrev text
时区缩写
utc_offset interval
相对于UTC的偏移（正值表示格林威治东部）
is_dst bool
如果这是一个夏令时缩写，则为真
虽然大多数时区缩写代表与UTC的固定偏移量，
但也有一些在历史上变化过（有关更多信息，请参见第 B.4 节）。
在这种情况下，此视图呈现它们当前的含义。
上一页 上一级 下一页53.32. pg_tables 起始页 53.34. pg_timezone_names
