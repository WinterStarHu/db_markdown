# 3.3. 外键

3.3. 外键
版本：
纠错本页面
搜索
目录导航
❮
❯
3.3. 外键 #
回想第 2 章中的weather和cities表。考虑以下问题：我们希望确保在cities表中有相应项之前任何人都不能在weather表中插入行。这叫做维持数据的引用完整性。在过分简化的数据库系统中，可以通过先检查cities表中是否有匹配的记录存在，然后决定应该接受还是拒绝即将插入weather表的行。这种方法有一些问题且并不方便，于是PostgreSQL可以为我们来解决：
新的表定义如下：
CREATE TABLE cities (
name     varchar(80) primary key,
location point
);
CREATE TABLE weather (
city      varchar(80) references cities(name),
temp_lo   int,
temp_hi   int,
prcp      real,
date      date
);
现在尝试插入一个非法的记录：
INSERT INTO weather VALUES ('Berkeley', 45, 53, 0.0, '1994-11-28');
ERROR:  insert or update on table "weather" violates foreign key constraint "weather_city_fkey"
DETAIL:  Key (city)=(Berkeley) is not present in table "cities".
外键的行为可以很好地根据应用来调整。我们不会在这个教程里更深入地介绍，读者可以参考第 5 章中的信息。正确使用外键无疑会提高数据库应用的质量，因此强烈建议用户学会如何使用它们。
上一页 上一级 下一页3.2. 视图 起始页 3.4. 事务
