# DROP FUNCTION

DROP FUNCTION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP FUNCTIONDROP FUNCTION — 移除函数大纲
DROP FUNCTION [ IF EXISTS ] name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] [, ...]
[ CASCADE | RESTRICT ]
描述
DROP FUNCTION 移除一个已有函数
的定义。要执行这个命令用户必须是该函数的拥有者。该函数的参数
类型必须被指定，因为多个不同的函数可能会具有相同的函数名和不
同的参数列表。
参数IF EXISTS
如果该函数不存在则不要抛出错误，而是发出一个提示。
name
一个现有函数的名称（可以是模式限定的）。
如果未指定参数列表，则该名称在其模式中必须是唯一的。
argmode
一个参数的模式：IN、OUT、
INOUT或者VARIADIC。如果被忽略，
则默认为IN。注意
DROP FUNCTION并不真正关心
OUT参数，因为决定函数的身份时只需要输入参数。
因此列出IN、INOUT和
VARIADIC参数足以。
argname
一个参数的名称。注意
DROP FUNCTION并不真正关心
参数名称，因为决定函数的身份时只需要参数的数据类型。
argtype
如果函数有参数，这是函数参数的数据类型（可以是模式限定的）。
CASCADE
自动删除依赖于该函数的对象（例如操作符和触发器），然后删除所有
依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该函数，则拒绝删除它。这是默认值。
示例
这个命令移除平方根函数：
DROP FUNCTION sqrt(integer);
在一个命令中删除多个函数：
DROP FUNCTION sqrt(integer), sqrt(bigint);
如果函数名称在其模式中是唯一的，则可以在不带参数列表的情况下引用它：
DROP FUNCTION update_employee_salaries;
请注意，这与
DROP FUNCTION update_employee_salaries();
不同，后者引用一个零个参数的函数，而第一个变体可以引用具有任意数量参数的函数，
包括零，只要该名称是唯一的。
兼容性
该命令符合SQL标准，使用这些PostgreSQL扩展：
该标准只允许每个命令删除一个函数。IF EXISTS选项能够指定参数模式和名称另见CREATE FUNCTION, ALTER FUNCTION, DROP PROCEDURE, DROP ROUTINE上一页 上一级 下一页DROP FOREIGN TABLE 起始页 DROP GROUP
