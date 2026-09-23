# ALTER DATABASE

ALTER DATABASE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER DATABASEALTER DATABASE — 更改数据库大纲
ALTER DATABASE name [ [ WITH ] option [ ... ] ]
其中 option 可以是：
ALLOW_CONNECTIONS allowconn
CONNECTION LIMIT connlimit
IS_TEMPLATE istemplate
ALTER DATABASE name RENAME TO new_name
ALTER DATABASE name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER DATABASE name SET TABLESPACE new_tablespace
ALTER DATABASE name REFRESH COLLATION VERSION
ALTER DATABASE name SET configuration_parameter { TO | = } { value | DEFAULT }
ALTER DATABASE name SET configuration_parameter FROM CURRENT
ALTER DATABASE name RESET configuration_parameter
ALTER DATABASE name RESET ALL
描述
ALTER DATABASE更改数据库的属性。
第一种形式更改某些针对每个数据库的设置（详见下文）。只有数据库拥有者或超级用户可以更改这些设置。
第二种形式更改数据库的名称。只有数据库拥有者或超级用户可以重命名数据库；非超级用户拥有者还必须拥有CREATEDB特权。当前数据库不能被重命名（如果需要这样做，请连接到一个不同的数据库）。
第三种形式更改数据库的所有者。
要更改所有者，您必须能够SET ROLE为新的所有者角色，
并且您必须拥有CREATEDB特权。
（请注意，超级用户会自动拥有所有这些权限。）
第四种形式更改数据库的默认表空间。
只有数据库的拥有者或超级用户可以执行此操作；
您还必须对新表空间具有创建权限。
此命令会将数据库旧默认表空间中的任何表或索引物理移动到新表空间。
此数据库的新默认表空间必须为空，并且没有人可以连接到
数据库。  非默认表空间中的表和索引不受影响。
复制文件到新表空间所使用的方法受 file_copy_method 设置的影响。
剩下的形式更改用于一个PostgreSQL数据库的运行时配置变量的会话默认值。只要一个新的会话在该数据库中开始，指定的值就会成为该会话的默认值。数据库相关的默认值会覆盖出现在postgresql.conf中或者从postgres命令行接收到的设置。只有数据库拥有者或超级用户可以更改一个数据库的会话默认值。一些变量不能用这种方式设置或者只能由超级用户更改。
参数name
要修改属性的数据库名称。
allowconn
如果为假，则没有人能连接到这个数据库。
connlimit
与这个数据库可以建立多少个并发连接。-1 表示没有限制。
istemplate
如果为真，则任何具有CREATEDB特权的用户都可以从这个数据库进行克隆；如果为假，则只有超级用户或者这个数据库的拥有者可以克隆它。
new_name
数据库的新名称。
new_owner
数据库的新拥有者。
new_tablespace
数据库的新默认表空间。
这种形式的命令不能在事务块内执行。
REFRESH COLLATION VERSION
更新数据库排序规则版本。请参见Notes了解背景信息。
configuration_parametervalue
将这个数据库的指定配置参数的会话默认值设置为给定值。如果value是DEFAULT，或者等效地使用了RESET，数据库相关的设置会被移除，因此系统范围的默认设置将会在新会话中继承。使用RESET ALL可清除所有数据库相关的设置。SET FROM CURRENT会保存该会话的当前参数值作为数据库相关的值。
更多关于允许的参数名称和值的信息可参考SET和第 19 章。
注释
也可以把一个会话的默认值绑定到一个特定角色而不是一个数据库，见ALTER ROLE。如果有冲突，角色相关的设置会覆盖数据库相关的设置。
示例
要在数据库test中默认禁用索引扫描：
ALTER DATABASE test SET enable_indexscan TO off;
兼容性
ALTER DATABASE语句是一个PostgreSQL扩展。
另请参阅CREATE DATABASE, DROP DATABASE, SET, CREATE TABLESPACE上一页 上一级 下一页ALTER CONVERSION 起始页 ALTER DEFAULT PRIVILEGES
