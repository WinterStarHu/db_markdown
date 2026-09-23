# 6.1. 插入数据

6.1. 插入数据
版本：
纠错本页面
搜索
目录导航
❮
❯
6.1. 插入数据 #
当一个表被创建后，它不包含任何数据。在数据库发挥作用之前，首先要做的是插入数据。一次插入一行数据。你也可以在一个命令中插入多行，但不能插入不完整的行。即使只知道其中一些列的值，也必须创建完整的行。
要创建一个新行，使用INSERT命令。这条命令要求提供表的名字和列的值。例如，考虑第 5 章中的产品表：
CREATE TABLE products (
product_no integer,
name text,
price numeric
);
一个插入一行的命令将是：
INSERT INTO products VALUES (1, 'Cheese', 9.99);
数据的值是按照这些列在表中出现的顺序列出的，并且用逗号分隔。通常，数据的值是文字（常量），但也允许使用标量表达式。
上面的语法的缺点是你必须知道表中列的顺序。要避免这个问题，你也可以显式地列出列。例如，下面的两条命令都有和上文那条命令一样的效果：
INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', 9.99);
INSERT INTO products (name, price, product_no) VALUES ('Cheese', 9.99, 1);
许多用户认为明确列出列的名字是个好习惯。
如果你没有获得所有列的值，那么你可以省略其中的一些。在这种情况下，这些列将被填充为它们的默认值。例如：
INSERT INTO products (product_no, name) VALUES (1, 'Cheese');
INSERT INTO products VALUES (1, 'Cheese');
第二种形式是PostgreSQL的一个扩展。它从左开始填充列，使用给出的值，填充多少个列就填充多少个，其他列将使用默认值。
为了保持清晰，你也可以显式地要求默认值，用于单个列或者用于整个行：
INSERT INTO products (product_no, name, price) VALUES (1, 'Cheese', DEFAULT);
INSERT INTO products DEFAULT VALUES;
你可以在一个命令中插入多行：
INSERT INTO products (product_no, name, price) VALUES
(1, 'Cheese', 9.99),
(2, 'Bread', 1.99),
(3, 'Milk', 2.99);
也可以插入查询的结果（可能没有行、一行或多行）：
INSERT INTO products (product_no, name, price)
SELECT product_no, name, price FROM new_products
WHERE release_date = 'today';
这提供了用于计算要插入的行的SQL查询机制（第 7 章）的全部功能。
提示
在一次性插入大量数据时，考虑使用COPY命令。它不如INSERT命令那么灵活，但是更高效。参考第 14.4 节获取更多有关批量加载性能的信息。
上一页 上一级 下一页第 6 章 数据操纵 起始页 6.2. 更新数据
