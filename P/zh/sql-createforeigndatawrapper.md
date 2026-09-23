# CREATE FOREIGN DATA WRAPPER

CREATE FOREIGN DATA WRAPPER
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE FOREIGN DATA WRAPPERCREATE FOREIGN DATA WRAPPER — 定义一个新的外部数据包装器大纲
CREATE FOREIGN DATA WRAPPER name
[ HANDLER handler_function | NO HANDLER ]
[ VALIDATOR validator_function | NO VALIDATOR ]
[ OPTIONS ( option 'value' [, ... ] ) ]
描述
CREATE FOREIGN DATA WRAPPER 创建一个
新的外部数据包装器。定义外部数据包装器的用户将成为它的拥有者。
外部数据包装器名称在数据库内必须唯一。
只有超级用户可以创建外部数据包装器。
参数name
要创建的外部数据包装器的名称。
HANDLER handler_functionhandler_function是一个以前注册
的函数的名称，它将被调用来为外部表检索执行函数。处理函数必
须不能有参数，并且它的返回类型必须是fdw_handler。
可以创建一个没有处理函数的外部数据包装器，但是使用这个包装
器的外部表只能被声明，但不能被访问。
VALIDATOR validator_functionvalidator_function
是一个之前已注册的函数的名称，它将被调用来检查给予该外部数据包装器
的选项，还有用于外部服务器、用户映射以及使用
该外部数据包装器的外部表的选项。如果没有验证器函数或者指定了
NO VALIDATOR，那么在创建时不会检查选项（
外部数据包装器可能会在运行时忽略或者拒绝无效的选项说明，这取决于
实现）。验证器函数必须接受两个参数：一个类型是text[]，
它将包含存储在系统目录中的选项数组，另一个是类型
oid，它将是包含该选项的系统目录的 OID。返回类型
会被忽略，该函数应该使用ereport(ERROR)
函数报告无效选项。
OPTIONS ( option 'value' [, ... ] )
这个子句为新的外部数据包装器指定选项。允许的选项名称和值与每一个
外部数据包装器有关，并且它们会被该外部数据包装器的验证器函数验证。
选项名称必须唯一。
注释
PostgreSQL的外部数据功能仍在积极的开发中。
查询的优化还很原始（也是剩下工作最多的部分）。因此，未来还有很
可观的性能提升空间。
示例
创建一个无用的外部数据包装器dummy：
CREATE FOREIGN DATA WRAPPER dummy;
创建一个外部数据包装器file，其处理函数为
file_fdw_handler：
CREATE FOREIGN DATA WRAPPER file HANDLER file_fdw_handler;
用一些选项创建一个外部数据包装器mywrapper：
CREATE FOREIGN DATA WRAPPER mywrapper
OPTIONS (debug 'true');
兼容性
CREATE FOREIGN DATA WRAPPER
符合 ISO/IEC 9075-9 (SQL/MED)，不过HANDLER
和VALIDATOR子句是扩展，并且标准子句
LIBRARY和LANGUAGE还没有
在PostgreSQL中被实现。
不过要注意，整体上来说 SQL/MED 功能还没有符合。
另见ALTER FOREIGN DATA WRAPPER, DROP FOREIGN DATA WRAPPER, CREATE SERVER, CREATE USER MAPPING, CREATE FOREIGN TABLE上一页 上一级 下一页CREATE EXTENSION 起始页 CREATE FOREIGN TABLE
