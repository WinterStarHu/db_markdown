# 19.11. 客户端连接默认值

19.11. 客户端连接默认值
版本：
纠错本页面
搜索
目录导航
❮
❯
19.11. 客户端连接默认值 #19.11.1. 语句行为19.11.2. 区域和格式化19.11.3. 共享库预加载19.11.4. 其他默认值19.11.1. 语句行为 #client_min_messages (enum)
#
控制被发送给客户端的消息级别。有效值是DEBUG5、
DEBUG4、DEBUG3、DEBUG2、
DEBUG1、LOG、NOTICE、
WARNING、ERROR。
每个级别都包括其后的所有级别。级别越靠后，被发送的消息越少。默认值是NOTICE。
注意LOG在这里有与log_min_messages中不同的排名。
INFO 级别的消息总是发送给客户端。
search_path (string)
#
这个变量指定当一个对象（表、数据类型、函数等）被用一个无模式限定的简单名称引用时，用于进行搜索该对象的模式顺序。当在不同模式中有同名对象时，将使用第一个在搜索路径中被找到的对象。一个不属于搜索路径中任何一个模式的对象只能通过用限定名（带点号）指定包含它的模式来引用。
search_path的值必须是一个逗号分隔的模式名列表。任何不是一个已有模式的名称，或者是一个用户不具有USAGE权限的模式，将被安静地忽略。
如果列表项之一是特殊名$user，则具有CURRENT_USER返回的名字的模式将取代它（如果有这样一个模式并且该用户有该模式的USAGE权限；如果没有，$user会被忽略）。
系统目录模式pg_catalog总是被搜索，不管它是否在搜索路径中被提及。如果它在路径中被提及，那么它将被按照路径指定的顺序搜索。如果pg_catalog不在路径中，则它将在任何路径项之前被搜索。
同样，如果存在，当前会话的临时表模式pg_temp_nnn总是被搜索。可以通过使用别名pg_temp在路径中显式列出它。如果它没有列在路径中，则首先搜索它（甚至在pg_catalog之前）。然而，临时模式仅用于搜索关系（表、视图、序列等）和数据类型名称。它永远不会用于搜索函数或操作符名称。
当对象创建时没有指定一个特定目标模式，它们将被放置在search_path中第一个合法模式中。如果搜索路径为空将报告一个错误。
这个参数的默认值是"$user", public。这种设置支持一个数据库（其中没有用户拥有私有模式，并且所有人共享使用public）、每个用户私有模式及其组合的共享使用。其他效果可以通过全局或者针对每个用户修改默认搜索路径设置获得。
更多有关模式处理的信息，请参考第 5.10 节。特别地，只有当数据库只有一个用户或者有少数的相互信任的用户时，默认配置是合适的。
搜索路径的当前有效值可以通过SQL函数current_schemas检查（见第 9.27 节）。它和检查search_path的值不太一样，因为current_schemas显示出现在search_path中的项是如何被解析的。
row_security (boolean)
#
这个变量控制是否以抛出一个错误来代替应用一条行安全性策略。在设置为on时，策略正常应用。在设置为off时，只要有至少一条策略被应用则查询就会失败。默认为on。受限的行可见性会导致不正确的结果时，可以将其改成off。例如，pg_dump默认会做这种更改。这个变量对能绕过每一条行安全性策略的角色（即超级用户和具有BYPASSRLS属性的角色）没有效果。
更多关于行安全性策略的信息，请见CREATE POLICY。
default_table_access_method (string)
#
这个参数指定了在创建表或物化视图时使用的默认表访问方法，如果CREATE命令没有明确指定访问方法，或者当使用SELECT ... INTO时，不允许指定表访问方法。默认值是heap。
default_tablespace (string)
#
这个变量指定当一个CREATE命令没有显式指定一个表空间时，创建对象（表和索引）的默认表空间。
该值要么是一个表空间的名字，要么是一个空字符串
以指定使用当前数据库的默认表空间。如果该值和任何现有表空间的名字都不匹配，
PostgreSQL将自动使用当前数据库的默认表空间。
如果指定了一个非默认的表空间，用户必须对它有CREATE权限，
否则创建企图将失败。
这个变量不被用于临时表，对临时表会使用temp_tablespaces。
当创建数据库时也不会使用这个变量。默认情况下，一个新数据库会从它的模板数据库继承其表空间设置。
当一个分区表建立时如果这个参数被设置为空字符串以外的值，分区表的
表空间将被设置为该值，将被用作未来建立分区的默认表空间，
即使default_tablespace已经改变。
有关表空间的更多信息，请见第 22.6 节。
default_toast_compression (enum)
#
这个变量设置针对可压缩列的值的默认的TOAST
压缩方法。
（这个可以通过设置COMPRESSION列选项在
CREATE TABLE或
ALTER TABLE中覆盖个别列。）
支持的压缩方法有pglz和
（如果PostgreSQL编译时包含
--with-lz4）lz4。
默认为pglz。
temp_tablespaces (string)
#
这个变量指定当一个CREATE命令没有显式指定一个表空间时，创建临时对象（临时表和临时表上的索引）的默认表空间。用于排序大型数据集的临时文件也会在这些表空间中创建。
该值是一个表空间名称的列表。当列表中有多个名称时，每次创建临时对象时，PostgreSQL会随机选择列表中的一个成员；但在一个事务中，连续创建的临时对象会依次放置在列表中的连续表空间中。如果选中的列表元素是一个空字符串，PostgreSQL将自动使用当前数据库的默认表空间。
当temp_tablespaces被交互式地设置时，指定一个不存在的表空间是一种错误，类似于为用户指定一个不具有CREATE权限的表空间。不过，当使用一个之前设置的值时，不存在的表空间会被忽略，就像用户缺少CREATE权限的表空间一样。特别地，使用一个在postgresql.conf中设置的值时，这条规则适用。
默认值是一个空字符串，这会导致所有临时对象被创建在当前数据库的默认表空间中。
参阅default_tablespace。
check_function_bodies (boolean)
#
这个参数通常是开启的。当设置为off时，它会禁用在CREATE FUNCTION和CREATE PROCEDURE期间对例程体字符串的验证。禁用验证可以避免验证过程的副作用，特别是防止由于向前引用等问题导致的误报。在代表其他用户加载函数之前，将此参数设置为off；pg_dump会自动这样做。
default_transaction_isolation (enum)
#
每个 SQL 事务都有一个隔离级别，可以是“读未提交”、“读已提交”、“可重复读”或者“可序列化”。这个参数控制每个新事务的默认隔离级别。默认是“读已提交”。
更多信息请参阅第 13 章和SET TRANSACTION。
default_transaction_read_only (boolean)
#
一个只读的 SQL 事务不能修改非临时表。这个参数控制每个新事务的默认只读状态。默认是off（读/写）。
更多信息请参考SET TRANSACTION。
default_transaction_deferrable (boolean)
#
当运行在可序列化隔离级别时，一个可延迟只读 SQL 事务可以在它被允许继续之前延迟一段时间。但是，一旦它开始执行就不会产生任何用来保证可序列化性的负荷；因此序列化代码将没有任何理由因为并发更新而强制它中断，使得这个选项适合于长时间运行的只读事务。
这个参数控制每个新事务的默认可延迟状态。目前它对读写事务或者那些操作在低于可序列化隔离级别上的事务无效。默认值是off。
更多信息请参考SET TRANSACTION。
transaction_isolation (enum)
#
此参数反映当前事务的隔离级别。在每个事务开始时，它被设置为
default_transaction_isolation的当前值。
任何后续更改它的尝试都相当于SET TRANSACTION命令。
transaction_read_only (boolean)
#
此参数反映当前事务的只读状态。在每个事务开始时，它被设置为
default_transaction_read_only的当前值。
任何后续尝试更改它的都相当于SET TRANSACTION命令。
transaction_deferrable (boolean)
#
此参数反映当前事务的可延迟性状态。在每个事务开始时，它被设置为
default_transaction_deferrable的当前值。
任何后续尝试更改它的都相当于SET TRANSACTION命令。
session_replication_role (enum)
#
控制当前会话中复制相关触发器和规则的触发。
可能的值是origin（默认值），
replica和local。
设置此参数会导致丢弃先前缓存的任何查询计划。
只有超级用户和具有适当SET权限的用户才能更改此设置。
这个设置的预期用途是由逻辑复制系统在应用所复制的更改时将它设置为replica。
其效果将是触发器和规则（没有对其默认配置做修改）在复制机上将不会被触发。
更多信息请参考ALTER TABLE的子句ENABLE TRIGGER以及ENABLE RULE。
PostgreSQL在内部会把设置origin和local同样对待。第三方复制系统可能会把这两个值用于其内部目的，例如把local用来标出一个不应复制其更改的会话。
因为外键被实现为触发器，将这个参数设置为replica还会禁用所有的外键检查，如果使用不当可能会让数据处于一种不一致的状态。
statement_timeout (integer)
#
中止任何使用了超过指定时间量的语句。
如果log_min_error_statement被设置为ERROR或更低，语句如果超时也会被记录。
如果指定值时没有单位，则以毫秒为单位。一个零值（默认）将禁用超时。
超时时间是从命令到达服务器开始计时，直到服务器完成该命令为止。
如果在单个简单查询消息中出现多个SQL语句，超时将分别应用于每条语句。
(PostgreSQL 13之前的版本通常将超时视为应用于整个查询字符串。)
在扩展查询协议中，超时从任何查询相关消息（Parse、Bind、Execute、Describe）
到达时开始计时，并在Execute或Sync消息完成时取消。
我们不推荐在postgresql.conf中设置statement_timeout，因为它会影响所有会话。
transaction_timeout (整数)
#
终止任何持续时间超过指定时间的事务会话。该限制适用于显式事务
（以BEGIN开始）以及对应单条语句的隐式事务。
如果未指定单位，则该值被视为毫秒。
值为零（默认）表示禁用超时。
如果transaction_timeout小于或等于
idle_in_transaction_session_timeout或statement_timeout，
则较长的超时将被忽略。
设置transaction_timeout在
postgresql.conf中是不推荐的，因为这会影响所有会话。
注意
预处理的事务不受此超时限制。
lock_timeout (integer)
#
如果任何语句在试图获取表、索引、行或其他数据库对象上的锁时等待超过指定的时间，该语句将被中止。
该时间限制独立地应用于每一次锁获取尝试。该限制会应用到显式锁定请求（如LOCK TABLE或不带NOWAIT的SELECT FOR UPDATE）和隐式获得的锁。
如果指定值时没有单位，则以毫秒为单位。一个零值（默认）将禁用超时。
与statement_timeout不同，这个超时只在等待锁时发生。注意如果statement_timeout为非零，设置lock_timeout为相同或更大的值没有意义，因为语句超时将总是第一个被触发。
如果log_min_error_statement被设置为ERROR或更低，超时的语句将被记录。
我们不推荐在postgresql.conf中设置lock_timeout，因为它会影响所有会话。
idle_in_transaction_session_timeout (integer)
#
终止任何已经闲置（这是指，等待客户端查询）超过这个参数所指定时间量的打开事务的会话。
如果这个值指定时没有单位，它被设为毫秒。
零值（默认）禁用超时。
此选项可以用于确保空闲会话不会在不合理的时间内持有锁。
即使没有持有重要的锁的时候，打开的事务也会防止清理最近死亡的可能只对这个事务可见的元组；所以长时间保持空闲会导致表膨胀。
详见第 24.1 节。
idle_session_timeout (integer)
#
终止任何空闲的会话（也就是，等待客户端查询），但不在打开的事务中，且超过指定的时间量。
如果指定值时不带单位，其单位采用毫秒。
零值时（默认）禁用超时。
不像打开事务的情况，没有事务的空闲会话不会给服务器带来很大的开销，因此启用此超时的需要比idle_in_transaction_session_timeout更少。
注意不要对通过连接池软件或其他中间件建立的连接强制执行此超时，因为这样的层可能不会很好地响应意外的连接关闭。
只对交互会话启用此超时可能是有帮助的，也许只对特定用户应用它。
bytea_output (enum)
#
设置bytea类型值的输出格式。有效值是hex（默认）和escape（传统的 PostgreSQL 格式）。详见第 8.4 节。不管这个设置的值如何，bytea类型总是接受这两种格式的输入。
xmlbinary (enum)
#
设置二进制值如何被编码为 XML。例如，这适用于通过xmlelement函数或xmlforest函数将bytea值转换到 XML 值。可能的值有base64和hex，它们都是用 XML 模式标准定义的。默认值是base64。更多关于 XML 相关函数的信息可参阅第 9.15 节。
这里的实际选择主要是个人喜好，受限于客户端应用中可能存在的限制。两种方法都支持所有可能的值，尽管十六进制编码将比 base64 编码更大。
xmloption (enum)
#
设置在 XML 和字符串值之间转换时，DOCUMENT或CONTENT是否为隐式。详见第 8.13 节。有效值是DOCUMENT和CONTENT。默认值是CONTENT。
根据 SQL 标准，设置这个选项的命令是：
SET XML OPTION { DOCUMENT | CONTENT };
这种语法在 PostgreSQL 也可用。
gin_pending_list_limit (integer)
#
设置 GIN 索引的待处理列表的最大尺寸，该列表在 fastupdate 被启用时使用。
如果该列表增长到超过这个最大尺寸，会通过批量将其中的项移入索引的主 GIN 数据结构来清理列表。
如果指定值时没有单位，则以千字节为单位。默认值是四兆字节（4MB）。
可以通过更改索引的存储参数来为个别 GIN 索引覆盖这个设置。更多信息请见第 65.4.4.1 节和第 65.4.5 节。
createrole_self_grant (string)
#
如果一个拥有CREATEROLE但没有
SUPERUSER权限的用户创建了一个角色，并且如果
此项被设置为非空值，那么新创建的角色将根据指定的选项授予
创建用户。该值必须是set、
inherit，或者是这些值的逗号分隔列表。
默认值是一个空字符串，这会禁用此功能。
此选项的目的是允许一个CREATEROLE用户（非超级用户）自动继承或
自动获得对任何创建用户执行SET ROLE的能力。由于
CREATEROLE用户总是隐式地被授予创建角色的
ADMIN OPTION，该用户始终可以执行一个
GRANT语句来实现与此设置相同的效果。然而，出于可用性
的考虑，如果授权自动发生会更方便。超级用户会自动继承每个角色的权限，并且
始终可以对任何角色执行SET ROLE，而此设置可以用于为
CREATEROLE用户创建类似的行为，以便他们为其创建的用户
提供相同的功能。
event_triggers (boolean)
#
允许临时禁用事件触发器的执行，以便排查和修复故障的事件触发器。
通过将其设置为false，所有事件触发器将被禁用。
将该值设置为true允许所有事件触发器触发，
这是默认值。只有超级用户和具有相应SET权限的用户
才能更改此设置。
restrict_nonsystem_relation_kind (string)
#
设置禁止访问非系统关系的关系类型。该值采用逗号分隔的关系类型列表形式。
当前支持的关系类型是视图和外部表。
19.11.2. 区域和格式化 #DateStyle (string)
#
设置日期和时间值的显示格式，以及解释有歧义的日期输入值的规则。由于历史原因，这个变量包含两个独立的部分：输出格式声明（ISO、Postgres、SQL或German）、输入/输出的年/月/日顺序（DMY、MDY或YMD）。这些可以被独立设置或者一起设置。关键字Euro和European是DMY的同义词；关键字US、NonEuro和NonEuropean是MDY的同义词。详见第 8.5 节。内建默认值是ISO, MDY，但是initdb将用对应于选中的lc_time区域行为的设置初始化配置文件。
IntervalStyle (enum)
#
设置间隔值的显示格式。值sql_standard将产生匹配SQL标准间隔文本的输出。当DateStyle参数被设置为ISO时，值postgres（默认）将产生匹配PostgreSQL发行8.4之前的输出。当DateStyle参数被设置为非ISO输出时，值postgres_verbose会产生匹配PostgreSQL发行8.4之前的输出。值iso_8601会产生匹配在ISO 8601的4.4.3.2节中定义的“带标志符格式”的时间间隔的输出。
IntervalStyle参数也可以影响对有歧义的间隔输入的解释。详见第 8.5.4 节。
TimeZone (string)
#
设置用于显示和解释时间戳的时区。内建默认值是GMT，但是它通常会在postgresql.conf中被覆盖；initdb将安装一个对应于其系统环境的设置。详见第 8.5.3 节。
timezone_abbreviations (string)
#
设置服务器接受的额外时区缩写的集合，用于日期时间输入
（超出当前 TimeZone 设置定义的任何缩写）。
默认值为 'Default'，这是一个在世界大部分地区
都有效的集合；还有 'Australia' 和
'India'，并且可以为特定安装定义其他集合。
有关更多信息，请参见 第 B.4 节。
extra_float_digits (integer)
#
这个参数调整用于文本输出浮点值的位数，包括float4，float8以及几何数据类型。
如果值为1（默认值）或更高，浮点值被输出为最短-精度格式；参见第 8.1.3 节。实际生成的位数只取决于输出的值，而不取决于此参数的值。float8值最多需要17位数字，float4值最多需要9位数字。这种格式既快速又精确，在正确读取时精确地保留了原始的二进制浮点值。为了历史兼容性，允许的值最大为3。
如果值为零或负，则输出四舍五入为给定的十进制精度。使用的精度是根据此参数的值减小的类型（FLT_DIG或DBL_DIG，视情况而定）的标准位数。（例如，指定-1将导致float4值输出四舍五入为5位有效数字，而float8值四舍五入为14位。）此格式较慢，不会保留二进制浮点值的所有位，但可能更易于阅读。
注意
此参数的含义，以及其默认值，在 PostgreSQL 12 中发生了变化；参见 第 8.1.3 节 以便进一步讨论。
client_encoding (string)
#
设置客户端编码（字符集）。默认使用数据库编码。PostgreSQL服务器所支持的字符集在第 23.3.1 节中描述。
lc_messages (string)
#
设置消息显示的语言。可接受的值是系统相关的；详见第 23.1 节。如果这个变量被设置为空字符串（默认），那么该值将以一种系统相关的方式从服务器的执行环境中继承。
在一些系统上，这个区域分类并不存在。仍然可以设置这个变量，只是不会有任何效果。同样，所期望语言的翻译消息也可能不存在。在这种情况下，你将仍然继续看到英文消息。
只有超级用户和具有适当SET权限的用户才能更改此设置。
lc_monetary (string)
#
设置用于格式化货币量的区域，例如用to_char函数族。可接受的值是系统相关的；详见第 23.1 节。如果这个变量被设置为空字符串（默认），那么该值将以一种系统相关的方式从服务器的执行环境中继承。
lc_numeric (string)
#
设置用于格式化数字的区域，例如用to_char函数族。可接受的值是系统相关的；详见第 23.1 节。如果这个变量被设置为空字符串（默认），那么该值将以一种系统相关的方式从服务器的执行环境中继承。
lc_time (string)
#
设置用于格式化日期和时间的区域，例如用to_char函数族。可接受的值是系统相关的；详见第 23.1 节。如果这个变量被设置为空字符串（默认），那么该值将以一种系统相关的方式从服务器的执行环境中继承。
icu_validation_level (enum)
#
当遇到ICU区域设置验证问题时，控制用于报告问题的
消息级别。
有效值包括DISABLED、DEBUG5、
DEBUG4、DEBUG3、
DEBUG2、DEBUG1、
INFO、NOTICE、
WARNING、ERROR和
LOG。
如果设置为DISABLED，则完全不报告验证问题。否则，会以给定的消息级别报告问题。
默认值是WARNING。
default_text_search_config (string)
#
选择被那些没有显式参数指定配置的文本搜索函数变体使用的文本搜索配置。详见第 12 章。内建默认值是pg_catalog.simple，但是如果能够标识一个匹配的配置，initdb将用对应于选中的lc_ctype区域的设置初始化配置文件。
19.11.3. 共享库预加载 #
为了载入附加的功能或者达到提高性能的目的，可用多个设置来预先载入共享库到服务器中。
例如'$libdir/mylib'设置可能会导致mylib.so（或者某些平台上的mylib.sl）从安装的标准库目录被预加载。这些设置之间的区别在于生效的时间以及改变它们所需的特权。
可以用这个方法预加载PostgreSQL的过程语言库，通常是使用'$libdir/plXXX'语法，其中的XXX是pgsql、perl、tcl或python。
只有特别为与PostgreSQL一起使用设计的共享库才能以这种方式载入。每一个PostgreSQL支持
的库都有一个“魔法块”，它会被检查以保证兼容性。由于这个原因，非PostgreSQL库无法
以这种方式被载入。你可能可以使用操作系统的工具（如LD_PRELOAD）载入它。
总之，请参考特定模块的文档来用推荐的方法加载它。
local_preload_libraries (string)
#
这个变量指定一个或者多个要在连接开始时预加载的共享库。
它包含一个由逗号分隔的库名列表，其中每个名称都会按LOAD命令的方式解析。
项之间的空格会被忽略，如果需要在库名中包含空格或者逗号，请把库名放在双引号内。
这个参数值只在连接开始时生效。后续的更改不会有任何效果。
如果一个指定的库没有找到，连接尝试将会失败。
任何用户都能设置这个选项。正因为如此，能被这样载入的库被严格限制为出现于安装的标准库
目录中plugins子目录下的共享库（保证只有“安全”库被安装到
这里是数据库管理员的责任）。local_preload_libraries中的项可以显式
指定这个目录，例如$libdir/plugins/mylib，或者只是指定库的
名称 — mylib 和
$libdir/plugins/mylib的效果是相同的。
这个特性的目的是允许非特权用户在特定的会话中载入调试或性能测量库，
而无需一个显式的LOAD命令。为了这个目的，通常通过使用客
户端的PGOPTIONS环境变量或者
ALTER ROLE SET来设置这个参数。
不过，除非一个模块被特别设计成由非超级用户以这种方式使用，通常不推荐使用这个设置。应该看看
session_preload_libraries。
session_preload_libraries (string)
#
这个变量指定在连接开始时要预加载的一个或多个共享库。
它包含一个逗号分隔的库名称列表，其中每个名称的解释方式与LOAD命令相同。
条目之间的空格会被忽略；如果需要在名称中包含空格或逗号，请用双引号括起库名称。
参数值仅在连接开始时生效。后续更改不会生效。如果指定的库未找到，连接尝试将失败。
只有超级用户和具有适当SET权限的用户才能更改此设置。
这个特性的意图是允许在特定会话中载入调试或
性能测量库，而不需要显式的给出一个
LOAD命令。例如，通过用ALTER ROLE SET设置这个参数可以
为一个给定用户名下的所有会话启用auto_explain。还有，无需重启
服务器就能更改这个参数（但是只有新会话启动时才会生效），这样可以以这种方式更容易地增
加新模块，即便它们会应用到所有会话。
和shared_preload_libraries不同，相对于在库被第一次使用
时载入它，在会话开始时载入库并没有什么性能优势。不过，当使用连接池时这样做还是有一些
优势。
shared_preload_libraries (string)
#
这个变量指定一个或多个要在服务器启动时预载入的共享库。
它包含一个由逗号分隔的库名列表，其中每个名称都会按LOAD命令的方式解析。
项之间的空格会被忽略；如果需要在库名中包含空格或逗号，请把库名放在双引号内。
这个参数只能在服务器启动时设置。如果指定的库没有找到，服务器将无法启动。
有些库需要执行只能在postmaster启动时发生的特定操作，例如分配共享内存、保留轻量级锁
或者启动后台工作进程。这些库必须通过这个参数在服务器启动时载入。每个库的详情请见文档。
其他库也能被预载入。通过预载入一个共享库，当该库被第一次使用时就可以避免库的启动时间。
不过，启动每个新服务器进程的时间可能会略有增加，即使该进程从不使用该库。因此，推荐只
把这个参数用于那些要在大多数会话中使用的库上。此外，改变这个参数要求重启服务器，因此
对于短期的调试任务来说这不是好的选择，应该转用
session_preload_libraries。
注意
在 Windows 主机上，在服务器启动时预载入一个库并不会减少启动每个新服务器进程所需的
时间；每个服务器进程将会重新载入预载入的库。不过，对于那些要在postmaster启动时
执行操作的库来说，Windows 主机上的
shared_preload_libraries仍然有用。
jit_provider (string)
#
这个变量是要使用的JIT提供者库的名称（见第 30.4.2 节）。
默认是llvmjit。这个参数只能在服务器启动时设置。
如果设置为一个不存在的库，JIT将不可用，但不会发生错误。这种特性允许在主
PostgreSQL包之外单独安装JIT支持。
19.11.4. 其他默认值 #dynamic_library_path (string)
#
如果需要打开一个可以动态装载的模块并且在CREATE FUNCTION或LOAD命令中指定的文件名没有目录部分（即名字中不包含斜线），那么系统将搜索这个路径以查找所需的文件。
dynamic_library_path的值必须是一个冒号分隔（或者在 Windows 上以分号分隔）的绝对目录路径的列表。如果一个列表元素以特殊字符串开始，$libdir，则用编译的PostgreSQL包中库目录替换$libdir；这里是PostgreSQL发布提供的模块被安装的位置。（使用pg_config --pkglibdir来找到这个目录的名字。）例如：
dynamic_library_path = '/usr/local/lib/postgresql:/home/my_project/lib:$libdir'
或者在 Windows 环境中：
dynamic_library_path = 'C:\tools\postgresql;H:\my_project\lib;$libdir'
这个参数的默认值是'$libdir'。如果该值被设置为一个空字符串，则关闭自动路径搜索。
这个参数可以由超级用户和具有适当SET特权的用户在运行时更改，但以这种方式进行的设置只会持续到客户端连接结束，因此这种方法应该保留用于开发目的。推荐设置此参数的方法是在postgresql.conf配置文件中。
extension_control_path (string)
#
用于搜索扩展的路径，特别是扩展控制文件
(name.control)。
然后从找到主控制文件的同一目录加载其余的扩展脚本和
次级控制文件。有关详细信息，请参见
第 36.17.1 节。
extension_control_path 的值必须是一个
由冒号分隔的绝对目录路径列表（在 Windows 上用分号分隔）。
如果列表元素以特殊字符串 $system 开头，
则用编译的 PostgreSQL 扩展目录替换
$system；这是标准
PostgreSQL 发行版提供的扩展安装的位置。
（使用 pg_config --sharedir 查找此目录的名称。）
例如：
extension_control_path = '/usr/local/share/postgresql:/home/my_project/share:$system'
或在 Windows 环境中：
extension_control_path = 'C:\tools\postgresql;H:\my_project\share;$system'
请注意，指定的路径元素预计会有一个子目录
extension，其中将包含
.control 和 .sql 文件；
extension 后缀会自动附加到每个路径元素。
此参数的默认值为 '$system'。如果值设置为空
字符串，则也假定为默认值 '$system'。
如果在配置路径中的多个目录中存在同名的扩展，则
仅使用路径中首先找到的实例。
这个参数可以由超级用户和具有适当SET特权的用户在运行时更改，
但以这种方式进行的设置只会持续到客户端连接结束，因此这种方法应该保留用于开发目的。
推荐设置此参数的方法是在postgresql.conf配置文件中。
请注意，如果您设置此参数以便能够从非标准位置加载扩展，
您很可能还需要将 dynamic_library_path
设置为相应的位置，例如：
extension_control_path = '/usr/local/share/postgresql:$system'
dynamic_library_path = '/usr/local/lib/postgresql:$libdir'
gin_fuzzy_search_limit (integer)
#
GIN 索引返回的集合尺寸的软上限。有关更多信息，请参见 第 65.4.5 节。
上一页 上一级 下一页19.10. 清理 起始页 19.12. 锁管理
