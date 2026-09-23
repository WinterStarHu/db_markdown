# CREATE LANGUAGE

CREATE LANGUAGE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE LANGUAGECREATE LANGUAGE — 定义一种新的过程语言大纲
CREATE [ OR REPLACE ] [ TRUSTED ] [ PROCEDURAL ] LANGUAGE name
HANDLER call_handler [ INLINE inline_handler ] [ VALIDATOR valfunction ]
CREATE [ OR REPLACE ] [ TRUSTED ] [ PROCEDURAL ] LANGUAGE name
描述
CREATE LANGUAGE为一个
PostgreSQL数据库注册一种新的
过程语言。接着，可以用这种新语言定义函数和存储过程。
CREATE LANGUAGE实际上把该语言名称与
负责执行用该语言编写的函数的处理器函数关联在一起。有关语言处理器的
更多信息可以参考第 57 章。
CREATE OR REPLACE LANGUAGE将创建
或者替换一种现有的定义。如果该语言已经存在，其参数会被根据命令更新。但
该语言的拥有关系和权限设置不会更改，并且任何已有的用该语言编写的
函数仍然被假定有效。
必须具有PostgreSQL超级用户权限才能注册新语言或更改现有语言的参数。
然而，一旦语言被创建，将它的所有权分配给非超级用户是有效的，然后他可以删除它、更改其权限、重命名它或
将其分配给新的所有者。（但是，不要将底层 C 函数的所有权分配给非超级用户；这会为该用户创建权限提升路径。）
不提供任何处理函数的CREATE LANGUAGE形式已过时。
为了向后兼容旧的转储文件，它被解释为CREATE EXTENSION。
如果语言被打包到同名的扩展中，这将起作用，这是设置过程语言的传统方式。
参数TRUSTEDTRUSTED指定该语言不会授予用户不该具有的
数据访问。如果在注册语言时这个关键词被省略，只有具有
PostgreSQL超级用户特权的用户才能
使用该语言创建新函数。
PROCEDURAL
这是一个噪声词。
name
新过程语言的名称。该名称必须在该数据库的语言中唯一。
HANDLER call_handlercall_handler是
一个之前注册的函数的名称，它将被调用来执行该过程语言的函数。
一种过程语言的调用处理器必须以一种编译型语言（如 C）编写并且
具有版本 1 的调用约定，它必须在
PostgreSQL内注册为一个没有
参数并且返回language_handler类型的函数。
language_handler是一种占位符类型， 它被用来
标识该函数为一个调用处理器。
INLINE inline_handlerinline_handler
是一个之前注册的函数的名称，它将被调用来执行一个该语言的匿名代码块（
DO命令）。如果没有指定
inline_handler函数，则
该语言不支持匿名代码块。该处理器函数必须接受一个internal
类型的参数，该参数将是DO命令的内部表示，而且它通常
将返回void。该处理器的返回值会被忽略。
VALIDATOR valfunctionvalfunction是
一个之前注册的函数的名称，当一个该语言的新函数被创建时会调用该函数来
验证新函数。如果没有指定验证器函数，那么一个新函数被创建时不会被检查。
验证器函数必须接受一个oid类型的参数，它将是要被创建的
函数的 OID，而且它通常将返回void。
一个验证器函数通常会检查函数体中的语法正确性，但是它也能查看函数的其他
属性，例如该语言能否处理特定的参数类型。为了发出一个错误，验证器函数应该
使用ereport()函数。验证器函数的返回值会被忽略。
注释
使用DROP LANGUAGE来删除过程语言。
系统目录pg_language（见第 52.29 节）记录着有关当前已安装的语言的信息。
另外，psql命令\dL列出已安装的语言。
要以一种过程语言创建函数，用户必须具有该语言的
USAGE特权。默认情况下，对于可信语言，
USAGE被授予给PUBLIC（即所有人）。
如果需要，可以将其收回。
过程语言对于单个数据库来说是本地的。但是，一种语言可以被安装在
template1数据库中，这会导致它在所有后续创建的
数据库中自动变得可用。
示例
创建新的过程语言的最小顺序是：
CREATE FUNCTION plsample_call_handler() RETURNS language_handler
AS '$libdir/plsample'
LANGUAGE C;
CREATE LANGUAGE plsample
HANDLER plsample_call_handler;
通常这会写在扩展的创建脚本中，用户会这样做来安装扩展：
CREATE EXTENSION plsample;
兼容性
CREATE LANGUAGE 是一种
PostgreSQL 扩展。
另见ALTER LANGUAGE, CREATE FUNCTION, DROP LANGUAGE, GRANT, REVOKE上一页 上一级 下一页CREATE INDEX 起始页 CREATE MATERIALIZED VIEW
