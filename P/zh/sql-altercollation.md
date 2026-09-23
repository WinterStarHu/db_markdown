# ALTER COLLATION

ALTER COLLATION
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER COLLATIONALTER COLLATION — 更改排序规则的定义大纲
ALTER COLLATION name REFRESH VERSION
ALTER COLLATION name RENAME TO new_name
ALTER COLLATION name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER COLLATION name SET SCHEMA new_schema
描述
ALTER COLLATION更改排序规则的定义。
您必须拥有排序规则才能使用ALTER COLLATION。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且该角色必须对排序规则的模式具有CREATE权限。
（这些限制确保更改所有者不会执行任何您无法通过删除和重新创建
排序规则完成的操作。然而，超级用户仍然可以更改任何排序规则的所有权。）
参数name
一个现有排序规则的名称（可以是模式限定的）。
new_name
排序规则的新名称。
new_owner
排序规则的新拥有者。
new_schema
排序规则的新模式。
REFRESH VERSION
更新排序规则的版本。
参阅下面的Notes。
注意
当创建排序对象时，提供程序特定版本的排序记录在系统目录中。当使用排序时，当前版本与记录的版本进行检查，当存在不匹配时会发出警告，例如：
WARNING:  collation "xx-x-icu" has version mismatch
DETAIL:  The collation in the database was created using version 1.2.3.4, but the operating system provides version 2.3.4.5.
HINT:  Rebuild all objects affected by this collation and run ALTER COLLATION pg_catalog."xx-x-icu" REFRESH VERSION, or build PostgreSQL with the right library version.
排序定义的更改可能导致索引损坏和其他问题，因为数据库系统依赖于存储对象具有特定的排序顺序。通常应该避免这种情况，但在合法情况下可能会发生，例如在升级操作系统到新的主要版本或使用pg_upgrade升级到与新版本ICU链接的服务器二进制文件时。当发生这种情况时，应重建所有依赖于排序的对象，例如使用REINDEX。完成后，可以使用命令ALTER COLLATION ... REFRESH VERSION刷新排序版本。这将更新系统目录以记录当前排序版本，并消除警告。请注意，这实际上并不检查所有受影响对象是否已正确重建。
当使用libc提供的排序规则时，在使用GNU C库（大多数Linux系统）、FreeBSD和Windows的系统上记录版本信息。
当使用ICU提供的排序规则时，版本信息由ICU库提供，并在所有平台上都可用。
注意
当使用GNU C库进行排序时，C库的版本用作排序规则版本的代理。许多Linux发行版仅在升级C库时才更改排序规则定义，但这种方法并不完美，因为维护人员可以自由地将较新的排序规则定义移植到较旧的C库版本。
在使用Windows进行排序时，版本信息仅适用于使用BCP 47语言标签定义的排序，例如
en-US。
对于数据库默认排序规则，有一个类似的命令ALTER DATABASE ... REFRESH COLLATION VERSION。
以下查询可用于识别当前数据库中需要刷新的所有排序规则以及依赖它们的对象：
SELECT pg_describe_object(refclassid, refobjid, refobjsubid) AS "Collation",
pg_describe_object(classid, objid, objsubid) AS "Object"
FROM pg_depend d JOIN pg_collation c
ON refclassid = 'pg_collation'::regclass AND refobjid = c.oid
WHERE c.collversion <> pg_collation_actual_version(c.oid)
ORDER BY 1, 2;
示例
要把排序规则de_DE重命名为german：
ALTER COLLATION "de_DE" RENAME TO german;
要把排序规则en_US的拥有者改成joe：
ALTER COLLATION "en_US" OWNER TO joe;
兼容性
在 SQL 标准中没有ALTER COLLATION语句。
参见其他CREATE COLLATION, DROP COLLATION上一页 上一级 下一页ALTER AGGREGATE 起始页 ALTER CONVERSION
