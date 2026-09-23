# 8.7. 枚举类型

8.7. 枚举类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.7. 枚举类型 #8.7.1. 枚举类型的声明8.7.2. 排序8.7.3. 类型安全8.7.4. 实现细节
枚举（enum）类型是包含一组静态、有序值的数据类型。
它们相当于许多编程语言中支持的 enum 类型。
枚举类型的一个示例是一周中的各天，或某条数据的一组状态值。
8.7.1. 枚举类型的声明 #
枚举类型使用 CREATE TYPE 命令创建，例如：
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');
创建后，枚举类型可以像其他类型一样在表和函数定义中使用：
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');
CREATE TABLE person (
name text,
current_mood mood
);
INSERT INTO person VALUES ('Moe', 'happy');
SELECT * FROM person WHERE current_mood = 'happy';
name | current_mood
------+--------------
Moe  | happy
(1 row)
8.7.2. 排序 #
枚举类型中值的排序顺序就是创建该类型时列出值的顺序。
所有标准比较运算符和相关聚合函数都支持枚举类型。例如：
INSERT INTO person VALUES ('Larry', 'sad');
INSERT INTO person VALUES ('Curly', 'ok');
SELECT * FROM person WHERE current_mood > 'sad';
name  | current_mood
-------+--------------
Moe   | happy
Curly | ok
(2 rows)
SELECT * FROM person WHERE current_mood > 'sad' ORDER BY current_mood;
name  | current_mood
-------+--------------
Curly | ok
Moe   | happy
(2 rows)
SELECT name
FROM person
WHERE current_mood = (SELECT MIN(current_mood) FROM person);
name
-------
Larry
(1 row)
8.7.3. 类型安全 #
每种枚举数据类型都是独立的，不能与其他枚举类型相比较。请看这个示例：
CREATE TYPE happiness AS ENUM ('happy', 'very happy', 'ecstatic');
CREATE TABLE holidays (
num_weeks integer,
happiness happiness
);
INSERT INTO holidays(num_weeks,happiness) VALUES (4, 'happy');
INSERT INTO holidays(num_weeks,happiness) VALUES (6, 'very happy');
INSERT INTO holidays(num_weeks,happiness) VALUES (8, 'ecstatic');
INSERT INTO holidays(num_weeks,happiness) VALUES (2, 'sad');
ERROR:  invalid input value for enum happiness: "sad"
SELECT person.name, holidays.num_weeks FROM person, holidays
WHERE person.current_mood = holidays.happiness;
ERROR:  operator does not exist: mood = happiness
如果确实需要这样做，可以编写自定义运算符，
或在查询中添加显式类型转换：
SELECT person.name, holidays.num_weeks FROM person, holidays
WHERE person.current_mood::text = holidays.happiness::text;
name | num_weeks
------+-----------
Moe  |         4
(1 row)
8.7.4. 实现细节 #
枚举标签是大小写敏感的，因此'happy'与'HAPPY'是不同的。标签中的空格也是有意义的。
尽管枚举类型的主要目的是用于值的静态集合，但也有方法在现有枚举类型中增加新值和重命名值（见ALTER TYPE）。不能从枚举类型中去除现有的值，也不能更改这些值的排序顺序，如果要那样做可以删除并重建枚举类型。
一个枚举值在磁盘上占据4个字节。一个枚举值的文本标签的长度受限于NAMEDATALEN设置，该设置被编译在PostgreSQL中，在标准编译下它表示最多63字节。
从内部枚举值到文本标签的翻译被保存在系统目录pg_enum中。可以直接查询该目录。
上一页 上一级 下一页8.6. 布尔类型 起始页 8.8. 几何类型
