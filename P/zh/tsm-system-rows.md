# F.46. tsm_system_rows — SYSTEM_ROWS采样方法用于TABLESAMPLE

F.46. tsm_system_rows — SYSTEM_ROWS采样方法用于TABLESAMPLE
版本：
纠错本页面
搜索
目录导航
❮
❯
F.46. tsm_system_rows —
SYSTEM_ROWS采样方法用于TABLESAMPLE #F.46.1. 示例
tsm_system_rows模块提供了表采样方法
SYSTEM_ROWS，它可以用在SELECT
命令的TABLESAMPLE子句中。
这种表采样方法接受一个整数参数，它是要读取的最大行数。得到的采样将总是包
含正好这么多行，除非该表中没有足够的行，在那种情况下整个表都会被选择出来。
和内建的SYSTEM采样方法一样，
SYSTEM_ROWS执行块级别的采样，所以采样不是完全随机的，
而是受聚簇效果的影响，特别是只要求少量行时。
SYSTEM_ROWS不支持
REPEATABLE子句。
这个模块被认为是“可信的”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.46.1. 示例 #
这里是一个用SYSTEM_ROWS选择一个表的采样的例子。
首先安装扩展：
CREATE EXTENSION tsm_system_rows;
然后就可以在SELECT命令中使用它，例如：
SELECT * FROM my_table TABLESAMPLE SYSTEM_ROWS(100);
这个命令将从表my_table中返回一个100行的采样（除非
该表没有100个可见行，那时将会返回其中所有的行）。
上一页 上一级 下一页F.45. test_decoding — 基于SQL的WAL逻辑解码测试/示例模块 起始页 F.47. tsm_system_time —
SYSTEM_TIME采样方法用于TABLESAMPLE
