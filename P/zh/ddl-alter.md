# 5.7. 修改表

5.7. 修改表
版本：
纠错本页面
搜索
目录导航
❮
❯
5.7. 修改表 #5.7.1. 增加列5.7.2. 移除列5.7.3. 增加约束5.7.4. 移除约束5.7.5. 更改列的默认值5.7.6. 修改列的数据类型5.7.7. 重命名列5.7.8. 重命名表
当我们已经创建了一个表并意识到犯了一个错误或者应用需求发生改变时，我们可以移除表并重新创建它。但如果表中已经被填充数据或者被其他数据库对象引用（例如有一个外键约束），这种做法就显得很不方便。因此，PostgreSQL提供了一族命令来对已有的表进行修改。注意这和修改表中所包含的数据是不同的，这里要做的是对表的定义或者说结构进行修改。
利用这些命令，我们可以：
增加列移除列增加约束移除约束修改默认值修改列数据类型重命名列重命名表
所有这些动作都由ALTER TABLE命令执行，其参考页面中包含更详细的信息。
5.7.1. 增加列 #
要增加一个列，可以使用这样的命令：
ALTER TABLE products ADD COLUMN description text;
新列将被默认值所填充（如果没有指定DEFAULT子句，则会填充空值）。
提示
添加具有常量默认值的列时，不需要在执行 ALTER TABLE 语句时更新表的每一行。
相反，默认值将在下次访问该行时返回，并在表被重写时应用，使得即使在大表上，ALTER TABLE 也非常快速。
如果默认值是易变的（例如，clock_timestamp()），
则每一行都需要使用在执行 ALTER TABLE 时计算的值进行更新。
为了避免潜在的漫长更新操作，特别是如果您打算用大多数非默认值填充该列，
最好是添加没有默认值的列，使用 UPDATE 插入正确的值，
然后添加任何所需的默认值，如下所述。
也可以同时为列定义约束，语法：
ALTER TABLE products ADD COLUMN description text CHECK (description <> '');
事实上CREATE TABLE中关于一列的描述都可以应用在这里。记住不管怎样，默认值必须满足给定的约束，否则ADD将会失败。也可以先将新列正确地填充好，然后再增加约束（见后文）。
5.7.2. 移除列 #
为了移除一个列，使用如下的命令：
ALTER TABLE products DROP COLUMN description;
列中的数据将会消失。涉及到该列的表约束也会被移除。然而，如果该列被另一个表的外键所引用，PostgreSQL不会安静地移除该约束。我们可以通过增加CASCADE来授权移除任何依赖于被删除列的所有东西：
ALTER TABLE products DROP COLUMN description CASCADE;
关于这个操作背后的一般性机制请见第 5.15 节。
5.7.3. 增加约束 #
要添加约束，使用表约束语法。例如：
ALTER TABLE products ADD CHECK (name <> '');
ALTER TABLE products ADD CONSTRAINT some_name UNIQUE (product_no);
ALTER TABLE products ADD FOREIGN KEY (product_group_id) REFERENCES product_groups;
要添加一个非空约束，通常不作为表约束书写，可以使用以下特殊语法：
ALTER TABLE products ALTER COLUMN product_no SET NOT NULL;
如果列已经具有非空约束，则此命令将静默无效。
该约束会立即被检查，所以表中的数据必须在约束被添加之前就已经符合约束。
5.7.4. 移除约束 #
要删除一个约束，您需要知道它的名称。如果您给它命名了，那就很简单。
否则系统会分配一个生成的名称，您需要找出来。psql命令
\d tablename在这里很有用；其他接口也可能
提供查看表详细信息的方法。然后命令是：
ALTER TABLE products DROP CONSTRAINT some_name;
和移除一个列相似，如果需要移除一个被其他东西依赖的约束，也需要加上CASCADE。一个例子是外键约束依赖于被引用列上的唯一或主键约束。
可以使用简化语法删除非空约束：
ALTER TABLE products ALTER COLUMN product_no DROP NOT NULL;
这与添加非空约束的 SET NOT NULL 语法相对应。
如果列没有非空约束，则此命令将静默无效。（请记住，列最多只能有一个非空约束，因此该命令作用于哪个约束从不模糊。）
5.7.5. 更改列的默认值 #
要为一个列设置一个新默认值，使用命令：
ALTER TABLE products ALTER COLUMN price SET DEFAULT 7.77;
注意这不会影响任何表中已经存在的行，它只是为未来的INSERT命令改变了默认值。
要移除任何默认值，使用：
ALTER TABLE products ALTER COLUMN price DROP DEFAULT;
这等同于将默认值设置为null。相应的，试图删除一个未被定义的默认值并不会引发错误，因为默认值已经被隐式地设置为null。
5.7.6. 修改列的数据类型 #
为了将一个列转换为一种不同的数据类型，使用如下命令：
ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);
只有当列中的每一个项都能通过一个隐式转换为新的类型时该操作才能成功。如果需要一种更复杂的转换，应该加上一个USING子句来指定应该如何把旧值转换为新值。
PostgreSQL将尝试把列的默认值转换为新类型，其他涉及到该列的任何约束也是一样。但是这些转换可能失败或者产生意外的结果。因此最好在修改类型之前先删除该列上所有的约束，然后在修改完类型后重新加上相应修改过的约束。
5.7.7. 重命名列 #
要重命名一个列：
ALTER TABLE products RENAME COLUMN product_no TO product_number;
5.7.8. 重命名表 #
要重命名一个表：
ALTER TABLE products RENAME TO items;
上一页 上一级 下一页5.6. 系统列 起始页 5.8. 权限
