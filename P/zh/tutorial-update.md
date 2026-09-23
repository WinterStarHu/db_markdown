# 2.8. 更新

2.8. 更新
版本：
纠错本页面
搜索
目录导航
❮
❯
2.8. 更新 #
你可以用UPDATE命令更新现有的行。假设你发现所有11月28日以后的温度读数都低了两度，那么你就可以用下面的方式改正数据：
UPDATE weather
SET temp_hi = temp_hi - 2,  temp_lo = temp_lo - 2
WHERE date > '1994-11-28';
看看数据的新状态：
SELECT * FROM weather;
city      | temp_lo | temp_hi | prcp |    date
---------------+---------+---------+------+------------
San Francisco |      46 |      50 | 0.25 | 1994-11-27
San Francisco |      41 |      55 |    0 | 1994-11-29
Hayward       |      35 |      52 |      | 1994-11-29
(3 rows)
上一页 上一级 下一页2.7. 聚合函数 起始页 2.9. 删除
