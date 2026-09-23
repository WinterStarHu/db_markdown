# 43.6. PL/Perl 触发器

43.6. PL/Perl 触发器
版本：
纠错本页面
搜索
目录导航
❮
❯
43.6. PL/Perl 触发器 #
PL/Perl 可以被用来编写触发器函数。在触发器函数中，哈希引用
$_TD包含有关当前触发器事件的信息。
$_TD是一个全局变量，对触发器的每一次调用它都会
得到一个独立的本地值。$_TD哈希引用的域有：
$_TD->{new}{foo}
列foo的NEW值
$_TD->{old}{foo}
列foo的OLD值
$_TD->{name}
要被调用的触发器的名称
$_TD->{event}
触发器事件：INSERT、UPDATE、
DELETE、TRUNCATE或者UNKNOWN
$_TD->{when}
什么时候调用触发器：BEFORE、
AFTER、INSTEAD OF或者
UNKNOWN
$_TD->{level}
触发器级别：ROW、STATEMENT或者UNKNOWN
$_TD->{relid}
触发器定义在其上的表的 OID
$_TD->{table_name}
触发器定义在其上的表的名称
$_TD->{relname}
触发器定义在其上的表的名称。这已经被废弃，并且可能会在
未来的发布中被移除。请使用
$_TD->{table_name}。
$_TD->{table_schema}
触发器定义在其上的表所在的模式的名称
$_TD->{argc}
触发器函数的参数数目
@{$_TD->{args}}
触发器函数的参数。如果$_TD->{argc}为 0 则不存在
行级触发器可以返回下列之一：
return;
执行操作
"SKIP"
不执行操作
"MODIFY"
指示触发器函数修改了NEW行
这里是一个触发器函数的例子，展示上文所说的一些东西：
CREATE TABLE test (
i int,
v varchar
);
CREATE OR REPLACE FUNCTION valid_id() RETURNS trigger AS $$
if (($_TD->{new}{i} >= 100) || ($_TD->{new}{i} <= 0)) {
return "SKIP";    # skip INSERT/UPDATE command
} elsif ($_TD->{new}{v} ne "immortal") {
$_TD->{new}{v} .= "(modified by trigger)";
return "MODIFY";  # 修改行并执行 INSERT/UPDATE 命令
} else {
return;           # 执行 INSERT/UPDATE 命令
}
$$ LANGUAGE plperl;
CREATE TRIGGER test_valid_id_trig
BEFORE INSERT OR UPDATE ON test
FOR EACH ROW EXECUTE FUNCTION valid_id();
上一页 上一级 下一页43.5. 可信的和不可信的 PL/Perl 起始页 43.7. PL/Perl 事件触发器
