# 2.3. 创建一个新表

2.3. 创建一个新表
版本：
纠错本页面
搜索
目录导航
❮
❯
2.3. 创建一个新表 #
你可以通过指定表的名字和所有列的名字及其类型来创建表∶
CREATE TABLE weather (
city            varchar(80),
temp_lo         int,           -- 低温
temp_hi         int,           -- 高温
prcp            real,          -- 降水量
date            date
);
你可以在psql输入这些命令以及换行符。psql可以识别该命令直到分号才结束。
空白字符（即空格、制表符和换行符）可以在SQL命令中自由使用。这意味着您可以
以与上面不同的方式对齐命令，甚至将其全部写在一行中。两个连字符
(“--”)引入注释。它们之后的内容会被忽略，直到行尾。
SQL对关键字和标识符不区分大小写，除非标识符用双引号括起来以保留
大小写（上面未使用这种方式）。
varchar(80)指定了一个可以存储最长 80 个字符的任意字符串的数据类型。int是普通的整数类型。real是一种用于存储单精度浮点数的类型。date类型应该可以自解释（没错，类型为date的列名字也是date。 这么做可能比较方便或者容易让人混淆 — 你自己选择）。
PostgreSQL支持标准的SQL类型int、smallint、real、double precision、char(N)、varchar(N)、date、time、timestamp和interval，还支持其他的通用功能的类型和丰富的几何类型。PostgreSQL中可以定制任意数量的用户定义数据类型。因而类型名并不是语法关键字，除了SQL标准要求支持的特例外。
第二个例子将保存城市和它们相关的地理位置：
CREATE TABLE cities (
name            varchar(80),
location        point
);
类型point就是一种PostgreSQL特有数据类型的例子。
最后，我们还要提到如果你不再需要某个表，或者你想以不同的方式重建它，那么你可以用下面的命令删除它：
DROP TABLE tablename;
上一页 上一级 下一页2.2. 概念 起始页 2.4. 填充表格行
