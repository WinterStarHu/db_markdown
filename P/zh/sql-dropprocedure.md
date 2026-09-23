# DROP PROCEDURE

DROP PROCEDURE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP PROCEDUREDROP PROCEDURE — 移除一个过程大纲
DROP PROCEDURE [ IF EXISTS ] name [ ( [ [ argmode ] [ argname ] argtype [, ...] ] ) ] [, ...]
[ CASCADE | RESTRICT ]
描述
DROP PROCEDURE 移除一个或多个现有过程的定义。为了执行这个命令，用户必须是该过程的拥有者。该过程的参数类型通常必须被指定，因为可能存在多个不同的过程具有相同名称和不同参数列表。
参数IF EXISTS
如果该过程不存在也不抛出错误。这种情况下会发出一个提示。
name
现有过程的名称（可以被模式限定）。如果没有指定参数列表，则该名称在其所属的模式中必须是唯一的。
argmode
参数的模式：IN，OUT，
INOUT或VARIADIC。如果省略，
默认值为IN（但请参见下文）。
argname
参数的名称。注意，DROP PROCEDURE并不真正在意参数名称，因为只需要参数的数据类型来确定过程的身份。
argtype
该过程如果有参数，这里是参数的数据类型（可以是模式限定的）。
详细参考下文。
CASCADE
自动删除依赖于该过程的对象，然后接着删除依赖于那些对象的对象（见第 5.15 节）。
RESTRICT
如果有任何对象依赖于该过程，则拒绝删除它。这是默认选项。
注意事项
如果只有一个给定名称的过程，则可以省略参数列表。在这种情况下，括号也可以省略。
在PostgreSQL中，只需列出输入参数（包括INOUT）就可以，
因为不允许同名例程共享相同的输入参数列表。此外，DROP命令实际上不会检查您是否正确
编写了OUT参数的类型；因此，明确标记为OUT的任何参数都只是噪音。
但是，为了与相应的CREATE命令保持一致，建议将其写入。
为了与SQL标准兼容，还可以写入所有参数数据类型（包括OUT参数的类型）但不带任何
argmode标记。当这样做时，将根据命令验证存储过程的
OUT参数的类型。这个规定会导致歧义，因为当参数列表中不包含
argmode标记时，无法确定使用哪个规则。
DROP命令将尝试以两种方式进行查找，并且如果找到了两个不同的过程，将抛出错误。
为避免这种歧义的风险，建议明确写入IN标记，而不是让其默认，从而强制使用传统的
PostgreSQL解释方式。
刚才解释的查找规则也适用于其他操作现有过程的命令，例如ALTER PROCEDURE和
COMMENT ON PROCEDURE。
示例
如果只有一个名为do_db_maintenance的过程，以下命令足以将其删除:
DROP PROCEDURE do_db_maintenance;
给定此过程定义:
CREATE PROCEDURE do_db_maintenance(IN target_schema text, OUT results text) ...
任何一个这些命令都可以用来删除它:
DROP PROCEDURE do_db_maintenance(IN target_schema text, OUT results text);
DROP PROCEDURE do_db_maintenance(IN text, OUT text);
DROP PROCEDURE do_db_maintenance(IN text);
DROP PROCEDURE do_db_maintenance(text);
DROP PROCEDURE do_db_maintenance(text, text);  -- 可能会有歧义
然而，如果还有，比如说，
CREATE PROCEDURE do_db_maintenance(IN target_schema text, IN options text) ...
兼容性
这个命令符合SQL标准，不过PostgreSQL做了这些扩展：
标准仅允许每个命令删除一个过程。IF EXISTS选项是一种扩展。指定参数模式和名称的能力是一种扩展，当给定参数模式时，查找规则也不同。另见CREATE PROCEDURE, ALTER PROCEDURE, DROP FUNCTION, DROP ROUTINE上一页 上一级 下一页DROP POLICY 起始页 DROP PUBLICATION
