# 5.2. 默认值

5.2. 默认值
版本：
纠错本页面
搜索
目录导航
❮
❯
5.2. 默认值 #
一列可以被分配一个默认值。当一个新行被创建且没有为某些列指定值时，这些列将会被它们相应的默认值填充。一个数据操纵命令也可以显式地要求一列被置为它的默认值，而不需要知道这个值到底是什么（数据操纵命令详见第 6 章）。
如果没有显式指定默认值，则默认值是空值。这是合理的，因为空值表示未知数据。
在一个表定义中，默认值被列在列的数据类型之后。例如：
CREATE TABLE products (
product_no integer,
name text,
price numeric DEFAULT 9.99
);
默认值可以是一个表达式，它将在任何需要插入默认值的时候被实时计算（不是表创建时）。一个常见的例子是为一个timestamp列指定默认值为CURRENT_TIMESTAMP，这样它将得到行被插入时的时间。另一个常见的例子是为每一行生成一个“序列号”。这在PostgreSQL可以按照如下方式实现：
CREATE TABLE products (
product_no integer DEFAULT nextval('products_product_no_seq'),
...
);
这里nextval()函数从一个序列对象（见第 9.17 节）。还有一种特别的速写：
CREATE TABLE products (
product_no SERIAL,
...
);
SERIAL速写将在第 8.1.4 节进一步讨论。
上一页 上一级 下一页5.1. 表基础 起始页 5.3. 标识列
