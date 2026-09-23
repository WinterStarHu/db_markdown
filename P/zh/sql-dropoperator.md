# DROP OPERATOR

DROP OPERATOR
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP OPERATORDROP OPERATOR — 删除一个操作符大纲
DROP OPERATOR [ IF EXISTS ] name ( { left_type | NONE } , right_type ) [, ...] [ CASCADE | RESTRICT ]
说明
DROP OPERATOR从数据库系统中
删除一个现有的操作符。要执行这个命令，你必须是该操作符的拥有者。
参数IF EXISTS
如果该操作符不存在则不会抛出错误，而是发出一个提示。
name
一个现有的操作符的名称（可以是模式限定的）。
left_type
该操作符左操作数的数据类型，如果没有左操作数就写NONE。
right_type
该操作符右操作数的数据类型。
CASCADE
自动删除依赖于该操作符的对象（例如使用它的视图），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该操作符，则拒绝删除它。这是默认值。
示例
为类型integer移除幂操作符a^b：
DROP OPERATOR ^ (integer, integer);
为类型bit移除按位补操作符~b：
DROP OPERATOR ~ (none, bit);
在一条命令中删除多个操作符：
DROP OPERATOR ~ (none, bit), ^ (integer, integer);
兼容性
SQL标准中没有DROP OPERATOR语句。
另见CREATE OPERATOR, ALTER OPERATOR上一页 上一级 下一页DROP MATERIALIZED VIEW 起始页 DROP OPERATOR CLASS
