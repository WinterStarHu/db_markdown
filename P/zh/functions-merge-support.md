# 9.23. 合并支持函数

9.23. 合并支持函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.23. 合并支持函数 #
PostgreSQL 包含一个合并支持函数，
可用于 RETURNING 列表中的
MERGE 命令，以识别每行所采取的操作；请参见 表 9.68。
表 9.68. 合并支持函数
函数
描述
merge_action ( )
→ text
返回当前行执行的合并操作命令。该命令将是 'INSERT'、
'UPDATE' 或 'DELETE'。
示例:
MERGE INTO products p
USING stock s ON p.product_id = s.product_id
WHEN MATCHED AND s.quantity > 0 THEN
UPDATE SET in_stock = true, quantity = s.quantity
WHEN MATCHED THEN
UPDATE SET in_stock = false, quantity = 0
WHEN NOT MATCHED THEN
INSERT (product_id, in_stock, quantity)
VALUES (s.product_id, true, s.quantity)
RETURNING merge_action(), p.*;
merge_action | product_id | in_stock | quantity
--------------+------------+----------+----------
UPDATE       |       1001 | t        |       50
UPDATE       |       1002 | f        |        0
INSERT       |       1003 | t        |       10
注意该函数只能用于 RETURNING 列表中，且仅限于 MERGE 命令。
在查询的其他部分使用该函数将导致错误。
上一页 上一级 下一页9.22. 窗口函数 起始页 9.24. 子查询表达式
