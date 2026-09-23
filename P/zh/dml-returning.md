# 6.4. 从修改的行返回数据

6.4. 从修改的行返回数据
版本：
纠错本页面
搜索
目录导航
❮
❯
6.4. 从修改的行返回数据 #
有时在修改行时获取数据是很有用的。INSERT、UPDATE、
DELETE 和 MERGE 命令都带有一个可选的
RETURNING 子句来支持这一点。使用 RETURNING
可以避免执行额外的数据库查询来收集数据，尤其在难以可靠识别被修改行时
更加有价值。
所允许的 RETURNING 子句的内容与 SELECT 命令的输出列表相同
（请参阅 第 7.3 节）。它可以包含命令的目标表的列名，
或者包含使用这些列的值表达式。一个常见的简写是 RETURNING *，
它按顺序选择目标表的所有列。
在一个 INSERT 中，提供给
RETURNING 的默认数据是
插入时的行。这在简单插入中并不太有用，
因为它只是重复了客户端提供的数据。但在依赖计算的默认值时，
它可以非常方便。例如，
当使用一个 serial
列来提供唯一标识符时，RETURNING 可以返回
分配给新行的 ID：
CREATE TABLE users (firstname text, lastname text, id serial primary key);
INSERT INTO users (firstname, lastname) VALUES ('Joe', 'Cool') RETURNING id;
RETURNING 子句在 INSERT ... SELECT 中也非常有用。
在一个 UPDATE 中，提供给
RETURNING 的默认数据是
修改后行的新内容。例如：
UPDATE products SET price = price * 1.10
WHERE price <= 99.99
RETURNING name, price AS new_price;
在一个 DELETE 中，提供给
RETURNING 的默认数据是
被删除行的内容。例如：
DELETE FROM products
WHERE obsoletion_date = 'today'
RETURNING *;
在一个 MERGE 中，提供给
RETURNING 的默认数据是
源行的内容加上插入、更新或
删除的目标行的内容。由于源和目标通常有许多相同的列，
指定 RETURNING * 可能会导致许多重复的列，
因此通常更有用的是限定返回仅源或目标行。例如：
MERGE INTO products p USING new_products n ON p.product_no = n.product_no
WHEN NOT MATCHED THEN INSERT VALUES (n.product_no, n.name, n.price)
WHEN MATCHED THEN UPDATE SET name = n.name, price = n.price
RETURNING p.*;
在这些命令中，也可以显式返回
修改行的旧内容和新内容。例如：
UPDATE products SET price = price * 1.10
WHERE price <= 99.99
RETURNING name, old.price AS old_price, new.price AS new_price,
new.price - old.price AS price_change;
在这个例子中，写 new.price 与
仅写 price 是相同的，但它使含义更清晰。
这种返回旧值和新值的语法适用于
INSERT、UPDATE、
DELETE 和 MERGE 命令，但
通常旧值在 INSERT 中将为 NULL，
新值在 DELETE 中将为 NULL。
然而，在某些情况下，这些命令仍然可以有用。例如，在一个
INSERT 中使用
ON CONFLICT DO UPDATE
子句时，冲突行的旧值将为非 NULL。
类似地，如果一个 DELETE 被通过
重写规则 转换为
UPDATE，新值可能是非 NULL。
如果目标表上有触发器(第 37 章)，可用于RETURNING
的数据是被触发器修改的行。因此，检查由触发器计算的列是
RETURNING的另一个常见用例。
上一页 上一级 下一页6.3. 删除数据 起始页 第 7 章 查询
