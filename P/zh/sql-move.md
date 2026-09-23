# MOVE

MOVE
版本：
纠错本页面
搜索
目录导航
❮
❯
MOVEMOVE — 定位游标大纲
MOVE [ direction ] [ FROM | IN ] cursor_name
其中 direction 可以是以下之一：
NEXT
PRIOR
FIRST
LAST
ABSOLUTE count
RELATIVE count
count
ALL
FORWARD
FORWARD count
FORWARD ALL
BACKWARD
BACKWARD count
BACKWARD ALL
描述
MOVE重新定位一个游标而不检索任何数据。
MOVE的工作完全像
FETCH命令，但是它只定位游标并且不返回行。
用于MOVE命令的参数和
FETCH命令的一样，可参考
FETCH。
输出
成功完成时，MOVE命令返回的命令标签形式是
MOVE count
count是一个
具有相同参数的FETCH命令会返回的
行数（可能为零）。
示例
BEGIN WORK;
DECLARE liahona CURSOR FOR SELECT * FROM films;
-- 跳过前 5 行：
MOVE FORWARD 5 IN liahona;
MOVE 5
-- 从游标 liahona 中取第 6 行：
FETCH 1 FROM liahona;
code  | title  | did | date_prod  |  kind  |  len
-------+--------+-----+------------+--------+-------
P_303 | 48 Hrs | 103 | 1982-10-22 | Action | 01:37
(1 row)
-- 关闭游标 liahona 并结束事务：
CLOSE liahona;
COMMIT WORK;
兼容性
在 SQL 标准中没有MOVE语句。
其他参考CLOSE, DECLARE, FETCH上一页 上一级 下一页MERGE 起始页 NOTIFY
