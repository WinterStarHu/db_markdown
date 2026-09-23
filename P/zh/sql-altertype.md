# ALTER TYPE

ALTER TYPE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER TYPEALTER TYPE —
更改类型的定义
大纲
ALTER TYPE name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER TYPE name RENAME TO new_name
ALTER TYPE name SET SCHEMA new_schema
ALTER TYPE name RENAME ATTRIBUTE attribute_name TO new_attribute_name [ CASCADE | RESTRICT ]
ALTER TYPE name action [, ... ]
ALTER TYPE name ADD VALUE [ IF NOT EXISTS ] new_enum_value [ { BEFORE | AFTER } neighbor_enum_value ]
ALTER TYPE name RENAME VALUE existing_enum_value TO new_enum_value
ALTER TYPE name SET ( property = value [, ... ] )
其中 action 可以是：
ADD ATTRIBUTE attribute_name data_type [ COLLATE collation ] [ CASCADE | RESTRICT ]
DROP ATTRIBUTE [ IF EXISTS ] attribute_name [ CASCADE | RESTRICT ]
ALTER ATTRIBUTE attribute_name [ SET DATA ] TYPE data_type [ COLLATE collation ] [ CASCADE | RESTRICT ]
描述
ALTER TYPE更改一种现有类型的定义。
它有几种形式：
OWNER
此表单更改类型的所有者。
RENAME
此表单更改类型的名称。
SET SCHEMA
这种形式将类型移动到另一个模式。
RENAME ATTRIBUTE
该形式仅可用于复合类型。它更改类型的单个属性的名称。
ADD ATTRIBUTE
这种形式为一种组合类型增加一个新属性，使用的语法和
CREATE TYPE相同。
DROP ATTRIBUTE [ IF EXISTS ]
这种形式从一种组合类型删除一个属性。如果指定了
IF EXISTS并且该属性不存在，则不会抛出错误。
这种情况下会发出一个提示。
ALTER ATTRIBUTE ... SET DATA TYPE
这种形式更改一种组合类型的一个属性类型。
ADD VALUE [ IF NOT EXISTS ] [ BEFORE | AFTER ]
这种形式为一种枚举类型增加一个新值。可以用BEFORE或者
AFTER一个现有值来指定新值在枚举顺序中的位置。
否则，新项会被增加在值列表的最后。
如果指定了IF NOT EXISTS，该类型已经包含新值时不会发生
错误：会发出一个提示但是不采取其他行动。否则，如果新值已经存在会发生错误。
RENAME VALUE
该形式重命名枚举类型的值。该值在枚举排序中的位置不受影响。
如果指定的值不存在或新名称已存在，则会发生错误。
SET ( property = value [, ... ] )
该表格仅适用于基本类型。 它允许调整可以在CREATE TYPE中设置的基本类型属性的子集。
具体来说，可以更改以下属性：
可以将RECEIVE设置为二进制输入函数的名称，
或者设置为NONE删除类型的二进制输入函数。
使用此选项需要超级用户特权。
可以将SEND设置为二进制输出函数的名称，
或者设置为NONE删除类型的二进制输出函数。
使用此选项需要超级用户特权。
可以将TYPMOD_IN设置为类型修饰符输入函数的名称，
或者设置为NONE删除类型的类型修饰符输入函数。
使用此选项需要超级用户特权。
可以将TYPMOD_OUT设置为类型修饰符输出函数的名称，
或者设置为NONE删除类型的类型修饰符输出函数。
使用此选项需要超级用户特权。
可以将ANALYZE设置为特定于类型的统计信息收集功能的名称，
或者设置为NONE删除该类型的统计信息收集功能。
使用此选项需要超级用户特权。
SUBSCRIPT可以设置为特定于类型的下标处理程序函数的名称，也可以设置为NONE以删除类型的下标处理程序函数。使用此选项需要超级用户权限。
可以将STORAGE设置为plain,
extended, external,
或 main (有关这些含义的更多信息参考 第 66.2 节)。
但是，从plain更改为另一个设置需要超级用户特权（因为它要求该类型的C函数全部是TOAST-ready），
而从另一个设置更改为 plain 则不是完全允许（因为类型可能已经在数据库中包含TOASTed值）。
请注意，更改此选项本身并不会更改任何存储的数据，它只是设置默认的TOAST策略以用于将来创建的表列。
请参见ALTER TABLE更改现有表列的TOAST策略。
有关这些类型属性的更多详细信息，请参见CREATE TYPE。
请注意，在适当的情况下，基本类型的这些属性中的更改将自动传播到基于该类型的域。
ADD ATTRIBUTE、DROP
ATTRIBUTE和ALTER ATTRIBUTE动作
可以被整合到一个多个修改组成的列表中，以便被平行应用。例如，
可以在一个命令中增加多个属性并且/或者修改多个属性的类型。
您必须拥有该类型才能使用ALTER TYPE。
要更改类型的模式，您还必须对新模式具有
CREATE权限。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须对类型的模式具有CREATE权限。
（这些限制确保更改所有者不会做任何您不能通过删除和重新创建
类型来完成的事情。然而，超级用户仍然可以更改任何类型的所有权。）
要添加属性或更改属性类型，您还必须对属性的数据类型具有
USAGE权限。
参数
name
要修改的一个现有类型的名称（可能被模式限定）。
new_name
该类型的新名称。
new_owner
该类型新拥有者的用户名。
new_schema
该类型的新模式。
attribute_name
要增加、修改或者删除的属性名称。
new_attribute_name
要被重命名的属性的新名称。
data_type
要增加的属性的数据类型，或者是要修改的属性的新类型。
new_enum_value
要被增加到一个枚举类型的值列表的新值，或将赋予现有值的新名称。
和所有枚举文本一样，它需要被引号引用。
neighbor_enum_value
一个现有枚举值，新值应该被增加在紧接着该枚举值之前或者
之后的位置上。和所有枚举文本一样，它需要被引号引用。
existing_enum_value
现有的应该重命名的枚举值。和所有的枚举文本一样，它需要被引号引用。
property
要修改的基本类型属性的名称；参见上面的可能值。
CASCADE
自动将操作传播到被更改类型的类型表及其后代。
RESTRICT
如果被更改的类型是类型表的类型，则拒绝该操作。这是默认设置。
备注
如果ALTER TYPE ... ADD VALUE（增加一个新值到枚举类型的形式）
在一个事务块中执行，新值不能被使用直到事务被提交之后。
涉及添加枚举值的比较有时会比仅涉及枚举类型的原始成员的比较慢。这通常仅在使用 BEFORE或AFTER 将新值的排序位置设置在列表末尾以外的某个位置时才会发生。
但是，有时即使将新值添加到末尾也会发生这种情况（如果 OID 计数器自最初创建枚举类型以来“wrapped around”，则会发生这种情况）。
速度减慢通常微不足道；但如果这很重要，可以通过删除并重新创建枚举类型或转储并恢复数据库来恢复最佳性能。
示例
要重命名一个数据类型：
ALTER TYPE electronic_mail RENAME TO email;
把类型email的拥有者改为
joe：
ALTER TYPE email OWNER TO joe;
把类型email的模式改为
customers：
ALTER TYPE email SET SCHEMA customers;
增加一个新属性到复合类型：
ALTER TYPE compfoo ADD ATTRIBUTE f3 int;
在特定的排序位置上为枚举类型增加一个新值：
ALTER TYPE colors ADD VALUE 'orange' AFTER 'red';
重命名枚举值：
ALTER TYPE colors RENAME VALUE 'purple' TO 'mauve';
要为现有基本类型创建二进制 I/O 函数：
CREATE FUNCTION mytypesend(mytype) RETURNS bytea ...;
CREATE FUNCTION mytyperecv(internal, oid, integer) RETURNS mytype ...;
ALTER TYPE mytype SET (
SEND = mytypesend,
RECEIVE = mytyperecv
);
兼容性
增加和删除属性的变体是 SQL 标准的一部分；其他变体是
PostgreSQL 扩展。
另见CREATE TYPE, DROP TYPE上一页 上一级 下一页ALTER TRIGGER 起始页 ALTER USER
