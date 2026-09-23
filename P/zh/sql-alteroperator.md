# ALTER OPERATOR

ALTER OPERATOR
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER OPERATORALTER OPERATOR — 更改操作符的定义大纲
ALTER OPERATOR name ( { left_type | NONE } , right_type )
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER OPERATOR name ( { left_type | NONE } , right_type )
SET SCHEMA new_schema
ALTER OPERATOR name ( { left_type | NONE } , right_type )
SET ( {  RESTRICT = { res_proc | NONE }
| JOIN = { join_proc | NONE }
| COMMUTATOR = com_op
| NEGATOR = neg_op
| HASHES
| MERGES
} [, ... ] )
描述
ALTER OPERATOR更改操作符的定义。
您必须拥有该操作符才能使用ALTER OPERATOR。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须对操作符的模式具有CREATE权限。
（这些限制确保更改所有者不会做任何您不能通过删除和重新创建操作符
来完成的事情。然而，超级用户仍然可以更改任何操作符的所有权。）
参数name
一个现有操作符的名称（可以是模式限定的）。
left_type
该操作符左操作数的数据类型，如果该操作符没有左操作数就可以写成
NONE。
right_type
该操作符右操作数的数据类型。
new_owner
该操作符的新拥有者。
new_schema
该操作符的新模式。
res_proc
这个操作符的约束选择度估算器函数，写成 NONE 可以移除现有的选择度估算器。
join_proc
这个操作符的连接选择度估算器函数，写成 NONE 可以移除现有的选择度估算器。
com_op
该算子的对易子。只有当算子没有现有的对易子时，才能更改。
neg_op
该操作符的否定符。只有当操作符没有现有的否定符时，才能更改。
HASHES
表示此操作符支持哈希连接。只能启用，不能禁用。
MERGES
表示此操作符支持合并连接。只能启用，不能禁用。
笔记
更多信息请参考 第 36.14 节 和
第 36.15 节。
由于换位子成对出现，且彼此互为换位子，ALTER OPERATOR SET COMMUTATOR也会设置
com_op的换位子为目标操作符。同样，ALTER OPERATOR SET
NEGATOR也会将neg_op的否定子设置为目标操作符。
因此，您必须同时拥有换位子或否定子操作符以及目标操作符的所有权。
示例
更改自定义操作符 a @@ b 在类型 text 上的所有者：
ALTER OPERATOR @@ (text, text) OWNER TO joe;
更改自定义运算符 a && b 的限制和连接选择性估算函数，
该运算符适用于类型 int[]：
ALTER OPERATOR && (int[], int[]) SET (RESTRICT = _int_contsel, JOIN = _int_contjoinsel);
标记&&运算符为其自身的交换子：
ALTER OPERATOR && (int[], int[]) SET (COMMUTATOR = &&);
兼容性
在 SQL 标准中没有ALTER OPERATOR语句。
另见CREATE OPERATOR, DROP OPERATOR上一页 上一级 下一页ALTER MATERIALIZED VIEW 起始页 ALTER OPERATOR CLASS
