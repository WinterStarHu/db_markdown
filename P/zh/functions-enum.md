# 9.10. 枚举支持函数

9.10. 枚举支持函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.10. 枚举支持函数 #
对于枚举类型（在第 8.7 节中描述），有一些函数允许更清洁的编码，而不需要为一个枚举类型硬编码特定的值。它们被列在表 9.35中。本例假定一个枚举类型被创建为：
CREATE TYPE rainbow AS ENUM ('red', 'orange', 'yellow', 'green', 'blue', 'purple');
表 9.35. 枚举支持函数
函数
描述
示例
enum_first ( anyenum )
→ anyenum
返回输入枚举类型的第一个值。
enum_first(null::rainbow)
→ red
enum_last ( anyenum )
→ anyenum
返回输入枚举类型的最后一个值。
enum_last(null::rainbow)
→ purple
enum_range ( anyenum )
→ anyarray
返回输入枚举类型的所有值作为一个有序的数组。
enum_range(null::rainbow)
→ {red,orange,yellow,​green,blue,purple}
enum_range ( anyenum, anyenum )
→ anyarray
返回给定两个枚举值之间的范围，作为一个有序数组。值必须来自相同的枚举类型。如果第一个参数为空，其结果将从枚举类型的第一个值开始。如果第二个参数为空，其结果将以枚举类型的最后一个值结束。
enum_range('orange'::rainbow, 'green'::rainbow)
→ {orange,yellow,green}
enum_range(NULL, 'green'::rainbow)
→ {red,orange,​yellow,green}
enum_range('orange'::rainbow, NULL)
→ {orange,yellow,green,​blue,purple}
请注意，除了双参数形式的enum_range外，这些函数忽略传递给它们的具体值，它们只关心声明的数据类型。空值或类型的一个特定值可以传递，并得到相同的结果。这些函数更多地被用于一个表列或函数参数，而不是一个硬编码的类型名，如例子中所使用。
上一页 上一级 下一页9.9. 日期/时间函数和操作符 起始页 9.11. 几何函数和操作符
