# 42.6. PL/Tcl 中的触发器函数

42.6. PL/Tcl 中的触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
42.6. PL/Tcl 中的触发器函数 #
触发器函数也可以用 PL/Tcl 编写。PostgreSQL要求能作为触发器被调用的函数必须被声明为没有参数并且返回类型为trigger。
来自于触发器管理器的信息通过下列变量被传递给函数体：
$TG_name
CREATE TRIGGER语句中触发器的名字。
$TG_relid
导致触发器函数被调用的表的对象 ID。
$TG_table_name
导致触发器函数被调用的表的名字。
$TG_table_schema
导致触发器函数被调用的表所在的模式。
$TG_relatts
表列名的 Tcl 列表，前面放上一个空列表元素。因此用Tcl的lsearch命令在该列表中查找一个列名返回的元素编号会从 1 开始（对于第一列），这和PostgreSQL中的自定义编号是同样的方式（空列表元素也出现在被删除的列的位置上，这样其右边的列的属性编号才是正确的）。
$TG_when
可以为BEFORE、AFTER或者INSTEAD OF，具体的选择取决于触发器事件的类型。
$TG_level
可以为ROW或者STATEMENT，取决于触发器事件的类型。
$TG_op
可以为INSERT、UPDATE、DELETE或者TRUNCATE，取决于触发器事件的类型。
$NEW
对于INSERT或者UPDATE动作是一个包含着新表行值的关联数组，对于DELETE为空。该数组以列名为索引。为空的列不会出现在数组中。对于语句级触发器这个变量不会被设置。
$OLD
对于UPDATE或者DELETE动作是一个包含着旧表行值的关联数组，对于INSERT为空。该数组以列名为索引。为空的列不会出现在数组中。对于语句级触发器这个变量不会被设置。
$args
在CREATE TRIGGER语句中对过程给出的参数的 Tcl 列表。在过程体中也可以用$1 ... $n来访问这些参数。
一个触发器函数的返回值可以是字符串OK或者SKIP，或者是一个“列名/值”对的列表。如果返回值是OK，引发该触发器的操作（INSERT/UPDATE/DELETE）将正常继续下去。SKIP告诉触发器管理器悄悄地抑制对这一行的该操作。如果返回一个列表，它告诉PL/Tcl返回一个被修改的行给触发器管理器，这个被修改的行的内容由列表中的列名和值指定。该列表中没有提到的任何列会被设置为空。返回被修改行只对行级BEFORE INSERT或UPDATE触发器有意义，对它们来说这个被修改的行将被插入而不是插入$NEW中给出的行。返回被修改行还对行级INSTEAD OF
INSERT或UPDATE触发器有意义，其中被返回的行被用作INSERT RETURNING或UPDATE RETURNING子句的源数据。在行级BEFORE DELETE或INSTEAD OF DELETE触发器中，返回一个被修改行的效果和返回OK的效果相同，即操作继续。对所有其他类型的触发器来说，触发器返回值会被忽略。
提示
结果列表可以用Tcl的array get命令从被修改的元组的数组表示中生成。
这里有一个触发器函数的例子，它用一个表中的整数值来跟踪在行上被执行的更新数。对于被插入的新行，该值被初始化为 0 并且之后在每一次更新操作时被加一。
CREATE FUNCTION trigfunc_modcount() RETURNS trigger AS $$
switch $TG_op {
INSERT {
set NEW($1) 0
}
UPDATE {
set NEW($1) $OLD($1)
incr NEW($1)
}
default {
return OK
}
}
return [array get NEW]
$$ LANGUAGE pltcl;
CREATE TABLE mytab (num integer, description text, modcnt integer);
CREATE TRIGGER trig_mytab_modcount BEFORE INSERT OR UPDATE ON mytab
FOR EACH ROW EXECUTE FUNCTION trigfunc_modcount('modcnt');
注意触发器函数本身不知道列名，列名由触发器参数提供。这让触发器函数可以被重用于不同的表。
上一页 上一级 下一页42.5. 从 PL/Tcl 访问数据库 起始页 42.7. PL/Tcl 中的事件触发器函数
