# 36.9. 内部函数

36.9. 内部函数
版本：
纠错本页面
搜索
目录导航
❮
❯
36.9. 内部函数 #
内部函数由 C 编写并且已经被静态链接到PostgreSQL
服务器中。该函数定义的“主体”指定该函数的 C 语言名称，
它不必与声明 SQL 函数所用的名称相同（为了向后兼容性的原因，也接受空
主体，那时会认为 C 语言函数名与 SQL 函数名相同）。
通常，所有存在于服务器中的内部函数都在数据库集簇的初始化（见
第 18.2 节）期间被声明，但是用户可以使用
CREATE FUNCTION为一个内部函数创建
额外的别名。在CREATE FUNCTION中用
语言名internal来声明内部函数。例如，要为
sqrt函数创建一个别名：
CREATE FUNCTION square_root(double precision) RETURNS double precision
AS 'dsqrt'
LANGUAGE internal
STRICT;
（大部分内部函数期望被声明为“strict”）。
注意
上述场景中并非所有“预定义”的函数都是
“内部”函数。有些预定义的函数由 SQL
编写。
上一页 上一级 下一页36.8. 过程语言函数 起始页 36.10. C语言函数
