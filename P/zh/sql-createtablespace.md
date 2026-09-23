# CREATE TABLESPACE

CREATE TABLESPACE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE TABLESPACECREATE TABLESPACE — 定义一个新的表空间大纲
CREATE TABLESPACE tablespace_name
[ OWNER { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER } ]
LOCATION 'directory'
[ WITH ( tablespace_option = value [, ... ] ) ]
描述
CREATE TABLESPACE 注册一个新的集簇范围
的表空间。表空间的名称必须与数据库集簇中现有的任何表空间不同。
表空间允许超级用户在文件系统上定义另一个位置，可以把包含数据库对象
（例如表和索引）的数据文件放在那里。
一个具有适当特权的用户可以把
tablespace_name 传递给
CREATE DATABASE、CREATE TABLE、
CREATE INDEX 或 ADD CONSTRAINT
来让这些对象的数据文件存储在指定的表空间中。
警告
表空间不能独立于定义它的集簇使用，见
第 22.6 节。
参数tablespace_name
要创建的表空间的名称。名称不能以 pg_ 开头，
因为此类名称保留给系统表空间使用。
user_name
将拥有该表空间的用户名。如果省略，默认为执行该命令的用户。只有
超级用户能创建表空间，但是他们能把表空间的拥有权赋予给非超级
用户。
directory
要被用于表空间的目录。该目录必须存在（CREATE TABLESPACE 将不创建它），应该为空，并且必须由
PostgreSQL系统用户拥有。该目录必须用一个绝对
路径指定。
tablespace_option
要设置或重置的表空间参数。目前，唯一可用的参数是 seq_page_cost、
random_page_cost、effective_io_concurrency
和 maintenance_io_concurrency。
为特定表空间设置这些值将覆盖规划器对从该表空间中的表读取页面的成本的通常估计，
以及根据同名配置参数（见 seq_page_cost、
random_page_cost、
effective_io_concurrency、
maintenance_io_concurrency）发出的并发 I/O 数量。
如果一个表空间位于比 I/O 子系统其余部分更快或更慢的磁盘上，这可能会很有用。
注意事项
CREATE TABLESPACE不能在一个事务块内执行。
示例
要在文件系统位置/data/dbs创建表空间dbspace，请首先使用操作系统工具创建目录并设置正确的所有权：
mkdir /data/dbs
chown postgres:postgres /data/dbs
然后在PostgreSQL中发出表空间创建命令：
CREATE TABLESPACE dbspace LOCATION '/data/dbs';
要创建由不同数据库用户拥有的表空间，可用类似这样的命令：
CREATE TABLESPACE indexspace OWNER genevieve LOCATION '/data/indexes';
兼容性
CREATE TABLESPACE是一种PostgreSQL扩展。
另见CREATE DATABASE, CREATE TABLE, CREATE INDEX, DROP TABLESPACE, ALTER TABLESPACE上一页 上一级 下一页CREATE TABLE AS 起始页 CREATE TEXT SEARCH CONFIGURATION
