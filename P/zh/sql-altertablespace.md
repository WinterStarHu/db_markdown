# ALTER TABLESPACE

ALTER TABLESPACE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER TABLESPACEALTER TABLESPACE — 更改表空间的定义大纲
ALTER TABLESPACE name RENAME TO new_name
ALTER TABLESPACE name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER TABLESPACE name SET ( tablespace_option = value [, ... ] )
ALTER TABLESPACE name RESET ( tablespace_option [, ... ] )
描述
ALTER TABLESPACE可以用于更改表空间的定义。
您必须拥有表空间才能更改表空间的定义。
要更改所有者，您还必须能够SET ROLE
为新的拥有角色。
（请注意，超级用户会自动拥有这些权限。）
参数name
现有表空间的名称。
new_name
该表空间的新名称。新名称不能以pg_开始，因为这类名称被
保留用于系统表空间。
new_owner
该表空间的新拥有者。
tablespace_option
要设置或重置的表空间参数。目前，唯一可用的参数是 seq_page_cost、
random_page_cost、effective_io_concurrency
和 maintenance_io_concurrency。
为特定表空间设置这些值将覆盖规划器通常对从该表空间中的表读取页面的成本的估计，
以及根据同名配置参数（见 seq_page_cost、
random_page_cost、
effective_io_concurrency、
maintenance_io_concurrency）确定的并发 I/O 数量。
如果一个表空间位于比 I/O 子系统的其余部分更快或更慢的磁盘上，这可能会很有用。
示例
将表空间index_space重命名为fast_raid：
ALTER TABLESPACE index_space RENAME TO fast_raid;
更改表空间index_space的拥有者：
ALTER TABLESPACE index_space OWNER TO mary;
兼容性
在 SQL 标准中没有
ALTER TABLESPACE语句。
另请参阅CREATE TABLESPACE, DROP TABLESPACE上一页 上一级 下一页ALTER TABLE 起始页 ALTER TEXT SEARCH CONFIGURATION
