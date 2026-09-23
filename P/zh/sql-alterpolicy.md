# ALTER POLICY

ALTER POLICY
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER POLICYALTER POLICY — 更改行级安全策略的定义大纲
ALTER POLICY name ON table_name RENAME TO new_name
ALTER POLICY name ON table_name
[ TO { role_name | PUBLIC | CURRENT_ROLE | CURRENT_USER | SESSION_USER } [, ...] ]
[ USING ( using_expression ) ]
[ WITH CHECK ( check_expression ) ]
描述
ALTER POLICY更改现有行级安全策略的定义。请注意，ALTER POLICY
只允许修改策略所应用的角色集合，以及要修改的USING和WITH CHECK表达式。
要更改策略的其他属性，例如其应用的命令，或者是允许还是限制，策略
必须被删除并重新创建。
要使用ALTER POLICY，你必须拥有该策略所适用的表。
在ALTER POLICY的第二种形式中，如果指定了角色列表、
using_expression以及
check_expression，
它们会被独立地替换。当这些子句之一被省略时，策略的对应部分不会被更改。
参数name
要更改的现有策略的名称。
table_name
该策略所在的表的名称（可选地被模式限定）。
new_name
该策略的新名称。
role_name
该策略适用的角色。可以一次指定多个角色。要把该策略
应用于所有角色，就可以使用PUBLIC。
using_expression
该策略的USING表达式。详见
CREATE POLICY。
check_expression
该策略的WITH CHECK表达式。详见
CREATE POLICY。
兼容性
ALTER POLICY是一种PostgreSQL扩展。
另请参见CREATE POLICY, DROP POLICY上一页 上一级 下一页ALTER OPERATOR FAMILY 起始页 ALTER PROCEDURE
