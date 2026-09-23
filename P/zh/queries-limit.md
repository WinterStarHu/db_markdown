# 7.6. LIMIT和OFFSET

7.6. LIMIT和OFFSET
版本：
纠错本页面
搜索
目录导航
❮
❯
7.6. LIMIT和OFFSET #
LIMIT 和 OFFSET 允许你只检索查询其余部分生成的部分行：
SELECT select_list
FROM table_expression
[ ORDER BY ... ]
[ LIMIT { count | ALL } ]
[ OFFSET start ]
如果给出了一个限制计数，那么会返回数量不超过该限制的行（但可能更少些，因为查询本身可能生成的行数就比较少）。LIMIT ALL的效果和省略LIMIT子句一样，就像是LIMIT带有 NULL 参数一样。
OFFSET说明在开始返回行之前忽略多少行。OFFSET 0的效果和省略OFFSET子句是一样的，并且OFFSET带有 NULL 参数的效果和省略OFFSET子句一样。
如果OFFSET和LIMIT都出现了，那么在返回LIMIT个行之前要先忽略OFFSET行。
如果使用LIMIT，那么用一个ORDER BY子句把结果行约束成一个唯一的顺序是很重要的。否则你就会拿到一个不可预料的该查询的行的子集。你要的可能是第十到第二十行，但以什么顺序的第十到第二十？除非你指定了ORDER BY，否则顺序是不知道的。
查询优化器在生成查询计划时会考虑LIMIT，因此如果你给定LIMIT和OFFSET，那么你很可能收到不同的计划（产生不同的行顺序）。因此，使用不同的LIMIT/OFFSET值选择查询结果的不同子集将生成不一致的结果，除非你用ORDER BY强制一个可预测的顺序。这并非bug，这是一个很自然的结果，因为 SQL 没有许诺把查询的结果按照任何特定的顺序发出，除非用了ORDER BY来约束顺序。
被OFFSET子句忽略的行仍然需要在服务器内部计算；因此，一个很大的OFFSET可能效率不高。
上一页 上一级 下一页7.5. 行排序 (ORDER BY) 起始页 7.7. VALUES 列表
