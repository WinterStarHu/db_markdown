# 2.9. 删除

2.9. 删除
版本：
纠错本页面
搜索
目录导航
❮
❯
2.9. 删除 #
数据行可以用DELETE命令从表中删除。假设你对Hayward的天气不再感兴趣，那么你可以用下面的方法把那些行从表中删除：
DELETE FROM weather WHERE city = 'Hayward';
所有属于Hayward的天气记录都被删除。
SELECT * FROM weather;
city      | temp_lo | temp_hi | prcp |    date
---------------+---------+---------+------+------------
San Francisco |      46 |      50 | 0.25 | 1994-11-27
San Francisco |      41 |      55 |    0 | 1994-11-29
(2 rows)
我们用下面形式的语句的时候一定要小心
DELETE FROM tablename;
如果没有一个限制，DELETE将从指定表中删除所有行，把它清空。系统不会请求确认就执行此操作！
上一页 上一级 下一页2.8. 更新 起始页 第 3 章 高级特性
