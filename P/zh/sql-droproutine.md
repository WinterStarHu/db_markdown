# DROP ROUTINE

DROP ROUTINE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP ROUTINEDROP ROUTINE — 删除一个例程大纲
DROP ROUTINE [ IF EXISTS ] name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] [, ...]
[ CASCADE | RESTRICT ]
说明
DROP ROUTINE删除一个或多个现有例程的定义。术语“routine”
包括聚合函数、普通函数和过程。有关参数说明、更多示例和详细信息，请参见
DROP AGGREGATE、DROP FUNCTION和
DROP PROCEDURE。
注意事项
DROP ROUTINE使用的查找规则基本上与DROP PROCEDURE相同；
特别是，DROP ROUTINE共享了该命令的行为，即将没有
argmode标记的参数列表视为可能使用SQL标准定义的将
OUT参数包含在列表中。（DROP AGGREGATE和
DROP FUNCTION不是这样。）
在某些情况下，当不同类型的例程共享相同的名称时，DROP ROUTINE可能会因为
存在歧义而失败，而更具体的命令（如DROP FUNCTION等）则可以正常工作。
更仔细地指定参数类型列表也可以解决此类问题。
其他对现有例程进行操作的命令，如ALTER ROUTINE和
COMMENT ON ROUTINE也使用这些查找规则。
示例
删除类型integer的例程foo：
DROP ROUTINE foo(integer);
不管foo是一个聚合、函数或是过程，这个命令都能起作用。
兼容性
这个命令符合SQL标准，不过PostgreSQL做了下面这些扩展：
标准仅允许每个命令删除一个例程。IF EXISTS选项是一种扩展。指定参数模式和名称的能力是一种扩展，当给定参数模式时，查找规则也不同。用户定义聚合函数是一种扩展。另见DROP AGGREGATE, DROP FUNCTION, DROP PROCEDURE, ALTER ROUTINE
注意CREATE ROUTINE命令不存在。
上一页 上一级 下一页DROP ROLE 起始页 DROP RULE
