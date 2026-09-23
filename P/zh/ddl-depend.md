# 5.15. 依赖跟踪

5.15. 依赖跟踪
版本：
纠错本页面
搜索
目录导航
❮
❯
5.15. 依赖跟踪 #
当我们创建一个涉及到很多具有外键约束、视图、触发器、函数等的表的复杂数据库结构时，我们隐式地创建了一张对象之间的依赖关系网。例如，具有一个外键约束的表依赖于它所引用的表。
为了保证整个数据库结构的完整性，PostgreSQL确保我们无法删除仍然被其他对象依赖的对象。例如，尝试删除第 5.5.5 节中的产品表会导致一个如下的错误消息，因为有订单表依赖于产品表：
DROP TABLE products;
ERROR:  cannot drop table products because other objects depend on it
DETAIL:  constraint orders_product_no_fkey on table orders depends on table products
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
该错误消息包含了一个有用的提示：如果我们不想一个一个去删除所有的依赖对象，我们可以执行：
DROP TABLE products CASCADE;
这样所有的依赖对象将被移除，同样依赖于它们的任何对象也会被递归删除。在这种情况下，订单表不会被移除，但是它的外键约束会被移除。之所以在这里会停下，是因为没有什么依赖着外键约束。（如果希望检查DROP ... CASCADE会干什么，运行不带CASCADE的DROP并阅读DETAIL输出。）
PostgreSQL中的几乎所有DROP命令都支持CASCADE。当然，其本质的区别随着对象的类型而不同。我们也可以用RESTRICT代替CASCADE来获得默认行为，它将阻止删除任何被其他对象依赖的对象。
注意
根据SQL标准，在DROP命令中指定RESTRICT或CASCADE是被要求的。但没有哪个数据库系统真正强制了这个规则，但是不同的系统中两种默认行为都是可能的。
如果一个DROP命令列出了多个对象，只有在存在指定对象构成的组之外的依赖关系时才需要CASCADE。例如，如果发出命令DROP TABLE tab1, tab2且存在从tab2到tab1的外键引用，那么就不需要CASCADE即可成功执行。
对于一个将其主体定义为字符串文字的用户定义函数或过程，PostgreSQL会跟踪与函数的外部可见属性相关的依赖关系，例如其参数和结果类型，但不会跟踪只有通过检查函数主体才能知道的依赖关系。例如，考虑以下情况：
CREATE TYPE rainbow AS ENUM ('red', 'orange', 'yellow',
'green', 'blue', 'purple');
CREATE TABLE my_colors (color rainbow, note text);
CREATE FUNCTION get_color_note (rainbow) RETURNS text AS
'SELECT note FROM my_colors WHERE color = $1'
LANGUAGE SQL;
（请参阅第 36.5 节以了解SQL语言函数的解释。）PostgreSQL将意识到get_color_note函数依赖于rainbow类型：删除该类型将导致删除该函数，因为其参数类型将不再被定义。但PostgreSQL不会认为get_color_note依赖于my_colors表，因此如果删除表，将不会删除该函数。虽然这种方法有缺点，但也有好处。如果表丢失，该函数在某种意义上仍然有效，尽管执行它会导致错误；创建一个同名的新表将使函数再次正常工作。
另一方面，对于其主体以SQL标准风格编写的SQL语言函数或过程，函数主体会在函数定义时被解析，
并且解析器识别的所有依赖关系都会被存储。因此，如果我们将上述函数写成
CREATE FUNCTION get_color_note (rainbow) RETURNS text
BEGIN ATOMIC
SELECT note FROM my_colors WHERE color = $1;
END;
那么该函数对my_colors表的依赖关系将被DROP命令
所知晓并强制执行。
上一页 上一级 下一页5.14. 其他数据库对象 起始页 第 6 章 数据操纵
