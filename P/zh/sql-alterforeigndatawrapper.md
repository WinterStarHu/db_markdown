# ALTER FOREIGN DATA WRAPPER

ALTER FOREIGN DATA WRAPPER
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER FOREIGN DATA WRAPPERALTER FOREIGN DATA WRAPPER — 更改外部数据包装器的定义大纲
ALTER FOREIGN DATA WRAPPER name
[ HANDLER handler_function | NO HANDLER ]
[ VALIDATOR validator_function | NO VALIDATOR ]
[ OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ]) ]
ALTER FOREIGN DATA WRAPPER name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER FOREIGN DATA WRAPPER name RENAME TO new_name
描述
ALTER FOREIGN DATA WRAPPER更改外部数据包装器的定义。该命令的第一种形式用于更改外部数据包装器的支持函数或一般选项（至少要求一个子句）。第二种形式更改外部数据包装器的拥有者。
只有超级用户能修改外部数据包装器。此外，只有超级用户能够拥有外部数据包装器。
参数name
一个现有的外部数据包装器的名称。
HANDLER handler_function
为外部数据包装器指定一个新的处理器函数。
NO HANDLER
用于指定该外部数据包装器不再具有处理器函数。
注意使用没有处理器的外部数据包装器的外部表不能被访问。
VALIDATOR validator_function
为外部数据包装器指定一个新的验证器函数。
注意，新的验证器可能会认为该外部数据包装器或者依赖于它的独立服务器
的已有选项、用户映射、外部表无效。PostgreSQL
不会做这种检查。在使用修改过的外部数据包装器之前确认这些选项正确是
用户的责任。不过，在这个ALTER FOREIGN DATA
WRAPPER命令中指定的选项将会被使用新的验证器检查。
NO VALIDATOR
用于指定该外部数据包装器不再拥有验证器函数。
OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ] )
为该外部数据包装器更改选项。ADD、SET
以及DROP指定要被执行的动作。如果没有显式地指定操作，
将假定为ADD。选项名称必须唯一，选项名称和值（如果有）
也会使用该外部数据包装器的验证器函数来验证。
new_owner
该外部数据包装器的新拥有者的用户名。
new_name
外部数据包装器的新名称。
示例
更改外部数据包装器dbi，添加选项foo，删除bar：
ALTER FOREIGN DATA WRAPPER dbi OPTIONS (ADD foo '1', DROP bar);
将外部数据包装器dbi的验证器改为bob.myvalidator：
ALTER FOREIGN DATA WRAPPER dbi VALIDATOR bob.myvalidator;
兼容性
ALTER FOREIGN DATA WRAPPER符合ISO/IEC
9075-9 (SQL/MED)，不过HANDLER、
VALIDATOR、OWNER TO
和RENAME子句是扩展。
另见CREATE FOREIGN DATA WRAPPER, DROP FOREIGN DATA WRAPPER上一页 上一级 下一页ALTER EXTENSION 起始页 ALTER FOREIGN TABLE
