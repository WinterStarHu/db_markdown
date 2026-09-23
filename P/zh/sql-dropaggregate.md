# DROP AGGREGATE

DROP AGGREGATE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP AGGREGATEDROP AGGREGATE — 移除一个聚合函数大纲
DROP AGGREGATE [ IF EXISTS ] name ( aggregate_signature ) [, ...] [ CASCADE | RESTRICT ]
其中 aggregate_signature 可以是：
* |
[ argmode ] [ argname ] argtype [ , ... ] |
[ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]
描述
DROP AGGREGATE移除一个现有的
聚合函数。要执行这个命令，当前用户必须是该聚合函数的拥有者。
参数IF EXISTS
如果该聚合不存在则不要抛出一个错误，而是发出一个提示。
name
一个现有聚合函数的名称（可以是模式限定的）。
argmode
一个参数的模式：IN或VARIADIC。
如果省略，默认值是IN。
argname
一个参数的名称。注意DROP AGGREGATE
并不真正关心参数名称，因为决定聚合函数的身份时只需要参数数据类型。
argtype
该聚合函数所操作的一个输入数据类型。要引用一个零参数的聚合函数，写
*来替代参数说明列表。要引用一个有序集聚合函数，在直接和
聚合参数说明之间写上ORDER BY。
CASCADE
自动删除依赖于该聚合函数的对象（例如使用它的视图），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该聚合函数，则拒绝删除它。这是默认值。
注释
ALTER AGGREGATE下描述了另一种引用有序集聚合的语法。
示例
要为类型integer移除聚合函数myavg：
DROP AGGREGATE myavg(integer);
要移除假设集聚合函数myrank，该函数接收一个排序列的
任意列表和直接参数的一个匹配的列表：
DROP AGGREGATE myrank(VARIADIC "any" ORDER BY VARIADIC "any");
要在一个命令中删除多个聚合函数：
DROP AGGREGATE myavg(integer), myavg(bigint);
兼容性
在 SQL 标准中没有DROP AGGREGATE语句。
另见ALTER AGGREGATE, CREATE AGGREGATE上一页 上一级 下一页DROP ACCESS METHOD 起始页 DROP CAST
