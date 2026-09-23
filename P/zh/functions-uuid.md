# 9.14. UUID 函数

9.14. UUID 函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.14. UUID 函数 #
表 9.45 显示了可以用于生成 UUID 的
PostgreSQL 函数。
表 9.45. UUID 生成函数
函数
描述
示例
gen_random_uuid ( )
→ uuid
uuidv4 ( )
→ uuid
生成一个版本 4（随机）UUID
gen_random_uuid()
→ 5b30857f-0bfa-48b5-ac0b-5c64e28078d1
uuidv4()
→ b42410ee-132f-42ee-9e4f-09a6485c95b8
uuidv7
( [ shift interval ] )
→ uuid
生成一个版本 7（时间排序）UUID。时间戳使用 UNIX 时间戳
计算，精确到毫秒 + 亚毫秒时间戳 + 随机数。可选参数
shift 将根据给定的 interval
移动计算出的时间戳。
uuidv7()
→ 019535d9-3df7-79fb-b466-fa907fa17f9e
注意
uuid-ossp 模块提供了其他标准算法的附加函数
用于生成 UUID。
表 9.46 显示了 PostgreSQL
函数，可用于从 UUID 中提取信息。
表 9.46. UUID 提取函数
函数
描述
示例
uuid_extract_timestamp
( uuid )
→ 带时区的时间戳
从版本 1 或 7 的 UUID 中提取 带时区的时间戳。
对于其他版本，此函数返回 null。
请注意，提取的时间戳不一定与生成 UUID 的时间完全相等；
这取决于生成 UUID 的实现。
uuid_extract_timestamp('019535d9-3df7-79fb-b466-​fa907fa17f9e'::uuid)
→ 2025-02-23 21:46:24.503-05
uuid_extract_version
( uuid )
→ smallint
从 RFC
9562 描述的某个变体的 UUID 中提取版本。对于其他变体，此函数返回 null。
例如，对于由 gen_random_uuid() 生成的 UUID，
此函数将返回 4。
uuid_extract_version('41db1265-8bc1-4ab3-992f-​885799a4af1d'::uuid)
→ 4
uuid_extract_version('019535d9-3df7-79fb-b466-​fa907fa17f9e'::uuid)
→ 7
PostgreSQL 还为 UUID 提供了 表 9.1 中所示的常用比较操作符。
请参见 第 8.12 节 以获取有关 PostgreSQL
中数据类型 uuid 的详细信息。
上一页 上一级 下一页9.13. 文本搜索函数和操作符 起始页 9.15. XML 函数
