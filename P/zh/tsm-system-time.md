# F.47. tsm_system_time — SYSTEM_TIME采样方法用于TABLESAMPLE

F.47. tsm_system_time — SYSTEM_TIME采样方法用于TABLESAMPLE
版本：
纠错本页面
搜索
目录导航
❮
❯
F.47. tsm_system_time —
SYSTEM_TIME采样方法用于TABLESAMPLE #F.47.1. 示例
tsm_system_time模块提供了表采样方法
SYSTEM_TIME，它可以用在SELECT
命令的TABLESAMPLE子句中。
这种表采样方法接受一个浮点类型的参数，它是花费在读表上的最大毫秒数。
这可以让你直接控制查询进行多久，但付出的代价是很难预测采样的大小。
得到的采样将包含在指定时间内能读入的那么多行，除非首先已经读入了整个表。
和内建的SYSTEM采样方法一样，
SYSTEM_TIME执行块级别的采样，所以采样不是完全随机的，
而是受聚簇效应的影响，特别是只选择少量行时。
SYSTEM_TIME不支持
REPEATABLE子句。
这个模块被认为是“可信的”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.47.1. 示例 #
这里是一个用SYSTEM_TIME选择一个表的采样的例子。
首先安装扩展：
CREATE EXTENSION tsm_system_time;
然后就可以在SELECT命令中使用它，例如：
SELECT * FROM my_table TABLESAMPLE SYSTEM_TIME(1000);
这个命令将返回在 1 秒（1000 毫秒）内能读到的my_table
采样。当然，如果 1 秒内就能读完整个表，所有的行都将被返回。
上一页 上一级 下一页F.46. tsm_system_rows —
SYSTEM_ROWS采样方法用于TABLESAMPLE 起始页 F.48. unaccent — 一个去除变音符号的文本搜索字典
