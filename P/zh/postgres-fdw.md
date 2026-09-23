# F.38. postgres_fdw — 访问存储在外部PostgreSQL 服务器中的数据

F.38. postgres_fdw — 访问存储在外部PostgreSQL 服务器中的数据
版本：
纠错本页面
搜索
目录导航
❮
❯
F.38. postgres_fdw —
访问存储在外部PostgreSQL
服务器中的数据 #F.38.1. postgres_fdw 的 FDW 选项F.38.2. FunctionsF.38.3. 连接管理F.38.4. 事务管理F.38.5. 远程查询优化F.38.6. 远程查询执行环境F.38.7. 跨版本兼容性F.38.8. 等待事件F.38.9. 配置参数F.38.10. 示例F.38.11. 作者
postgres_fdw模块提供了外部数据包装器postgres_fdw，它可以用来访问存储在外部PostgreSQL服务器中的数据。
这个模块提供的功能大体上覆盖了较老的dblink模块的功能。但是postgres_fdw提供了更透明且更兼容标准的语法来访问远程表，并且可以在很多情况下提供更好的性能。
要使用postgres_fdw来为远程访问做准备：
使用CREATE EXTENSION来安装postgres_fdw扩展。
使用CREATE SERVER创建一个外部服务器对象，它用来表示你想连接的每一个远程数据库。指定除了user和password之外的连接信息作为该服务器对象的选项。
使用CREATE USER MAPPING创建一个用户映射，每一个用户映射都代表你想允许一个数据库用户访问一个外部服务器。指定远程用户名和密码作为用户映射的user和password选项。
为每一个你想访问的远程表使用CREATE FOREIGN TABLE或者IMPORT FOREIGN SCHEMA创建一个外部表。外部表的列必须匹配被引用的远程表。但是，如果你在外部表对象的选项中指定了正确的远程名称，你可以使用不同于远程表的表名和/或列名。
现在，您只需要从外部表中SELECT来访问存储在其底层远程表中的数据。
您还可以使用INSERT、UPDATE、DELETE、
COPY或TRUNCATE修改远程表。
（当然，您在用户映射中指定的远程用户必须具有执行这些操作的权限。）
请注意，在访问或修改远程表时，SELECT、UPDATE、DELETE或TRUNCATE中指定的ONLY选项没有效果。
注意当前postgres_fdw缺少对带ON CONFLICT DO UPDATE子句的INSERT语句的支持。不过，它支持ON CONFLICT DO NOTHING子句，前提是省略唯一索引推断说明。
请注意，postgres_fdw还支持由在分区表上执行的UPDATE语句触发的行移动，但目前不处理远程分区选择插入移动行的情况，并且该远程分区本身也是同一命令中将在其他位置更新的UPDATE目标分区。
我们通常推荐一个外部表的列被声明为与被引用的远程表列完全相同的数据类型和排序规则（如果适用）。尽管postgres_fdw目前已经能够容忍在需要时执行数据类型转换，但是当类型或排序规则不匹配时可能会发生奇怪的语义异常，因为远程服务器解释查询条件时可能会与本地服务器有所不同。
注意一个外部表可以被声明比底层的远程表较少的列，或者使用一种不同的列顺序。与远程表的列匹配是通过名字而不是位置进行的。
F.38.1. postgres_fdw 的 FDW 选项 #F.38.1.1. 连接选项 #
使用 postgres_fdw 外部数据包装器的外部服务器可以拥有与
libpq 在连接字符串中接受的选项相同，如
第 32.1.2 节 所述，除了这些选项不被允许或有特殊处理：
user、password 和 sslpassword（请改为在用户映射中指定，或使用服务文件）
client_encoding（此项自动从本地服务器编码设置）
application_name - 这可能出现在
连接和/或两者 中，以及
postgres_fdw.application_name。
如果两者都存在，postgres_fdw.application_name
会覆盖连接设置。
与 libpq 不同，
postgres_fdw 允许
application_name 包含
“转义序列”。
详情请参见 postgres_fdw.application_name。
fallback_application_name（始终设置为
postgres_fdw）
sslkey 和 sslcert - 这些可能出现在
连接和/或两者 以及用户映射中。
如果两者都存在，用户映射设置会覆盖连接设置。
只有超级用户可以使用sslcert或sslkey设置创建或修改用户映射。
非超级用户可以使用密码认证或GSSAPI委派凭据连接到外部服务器，因此请为需要
密码认证的非超级用户的用户映射指定password选项。
超级用户可以通过设置用户映射选项password_required 'false'在每个用户映射的基础上覆盖此检查，例如，
ALTER USER MAPPING FOR some_non_superuser SERVER loopback_nopw
OPTIONS (ADD password_required 'false');
为了防止非特权用户利用正在运行的 postgres 服务器升级到超级用户权限的 unix 用户的身份验证权限，只有超级用户可以在用户映射上设置此选项。
需要小心确保这不会允许映射用户以超级用户身份连接到映射的数据库，
参见 CVE-2007-3278 和 CVE-2007-6601。不要在
public 角色上设置
password_required=false。请记住，映射用户可能会使用
任何客户端证书、.pgpass、.pg_service.conf 等，
这些文件位于 postgres 服务器运行的系统用户的 Unix 主目录中。
（有关如何找到主目录的详细信息，请参见 第 32.16 节。）
他们还可以使用通过身份验证模式（如 peer 或
ident 身份验证）授予的任何信任关系。
F.38.1.2. 对象名称选项 #
这些选项可以用来控制在发送到远程PostgreSQL服务器的 SQL 语句中使用的名称。当一个外部表被创建时，如果其名称不同于底层远程表的名称，就需要这些选项。
schema_name (string)
这个选项可以为一个外部表指定，用于给出在远程服务器上使用的外部表的模式名称。如果这个选项被忽略，将使用外部表的模式名称。
table_name (string)
这个选项可以为一个外部表指定，用于给出在远程服务器上使用的外部表的表名。如果这个选项被忽略，将使用外部表的名称。
column_name (string)
这个选项可以为外部表的列指定，给出在远程服务器上使用的列名。
如果省略此选项，则使用列的名称。
F.38.1.3. 代价估计选项 #
postgres_fdw通过在远程服务器上执行查询来检索远程数据，因此理想的扫描一个外部表的估计代价应该是在远程服务器上完成它的花销，外加一些通信开销。得到这样一个估计的最可靠的方法是询问远程服务器并加上一些开销 — 但是对于简单查询，不值得为获得一个代价估计而额外使用一次远程查询。因此postgres_fdw提供了下列选项来控制如何完成代价估计：
use_remote_estimate (boolean)
这个选项可以为外部表或外部服务器指定，控制postgres_fdw是否发出EXPLAIN命令来获得代价估计。
外部表的设置会覆盖其服务器的任何设置，但仅适用于该表。
默认值是false。
fdw_startup_cost (floating point)
这个选项是一个浮点值，添加到该服务器上任何外部表扫描的估计启动代价。
这表示建立连接、在远程端解析和规划查询等的额外开销。
默认值是100。
fdw_tuple_cost (floating point)
该选项可为外部服务器指定，是一个浮点值，用作该服务器上外部表扫描的每元组额外成本。
这表示服务器间数据传输的额外开销。您可以增加或减少此数值，以反映到远程服务器的网络延迟更高或更低。
默认值为0.2。
当use_remote_estimate为真时，postgres_fdw从远程服务器获得行计数和代价估计，然后在代价估计上加上fdw_startup_cost和fdw_tuple_cost。当use_remote_estimate为假时，postgres_fdw执行本地行计数和代价估计，并且接着在代价估计上加上fdw_startup_cost和fdw_tuple_cost。这种本地估计不会很准确，除非有远程表统计数据的本地拷贝可用。在外部表上运行ANALYZE是更新本地统计数据的方法，这将执行远程表的一次扫描并接着计算和存储统计数据，就好像表在本地一样。保留本地统计数据可能是一种有用的方法来减少一个远程表的查询规划负荷 — 但是如果远程表被频繁更新，本地统计数据将很快就被废弃。
以下选项控制ANALYZE操作的行为方式：
analyze_sampling (string)
此选项可以为外部表或外部服务器指定，用于确定对外部表执行
ANALYZE时，是在远程端对数据进行采样，还是读取并传输
所有数据并在本地进行采样。支持的值包括off、
random、system、
bernoulli和auto。
off禁用远程采样，因此所有数据都会被传输并在本地采样。
random使用random()函数进行远程采样以选择
返回的行，而system和bernoulli依赖于
内置的以这些名称命名的TABLESAMPLE方法。
random适用于所有远程服务器版本，而
TABLESAMPLE仅从9.5版本开始支持。
auto（默认值）会自动选择推荐的采样方法；
目前，这意味着根据远程服务器版本选择bernoulli
或random。
F.38.1.4. 远程执行选项 #
默认情况下，只有使用了内建操作符和函数的WHERE子句才会被考虑在远程服务器上执行。涉及非内建函数的子句将在取完行后在本地进行检查。如果这类函数在远程服务器上可用并且可以用来产生和本地执行时一样的结果，则可以通过将这种WHERE子句发送到远程执行来提高性能。可以用下面的选项控制这种行为：
extensions (string)
这个选项是一个用逗号分隔的已安装的PostgreSQL扩展名称列表，这些扩展在本地和远程服务器上具有兼容的版本。属于该列表中扩展的不可变函数和操作符将被考虑转移到远程服务器上执行。这个选项只能为外部服务器指定，无法逐个表指定。
在使用extensions选项时，用户应该负责确保列出的扩展在本地和远程服务器上都存在且行为一致。否则，远程查询可能失败或者行为异常。
fetch_size (integer)
这个选项指定在每次获取行的操作中postgres_fdw应该得到的行数。可以为一个外部表或者外部服务器指定这个选项。在表上指定的选项将会覆盖在服务器级别上指定的选项。默认值为100。
batch_size (integer)
这个选项指定每次插入操作中postgres_fdw的行数。它可以为一个外部表或一个外部服务器指定。在一个表上指定的选项覆盖为服务器指定的选项，默认是1。
请注意，postgres_fdw一次插入的实际行数取决于列数和提供的batch_size值。这个批处理作为一个单一的查询执行，并且libpq协议（postgres_fdw用来连接到远程服务器）将单个查询中的参数数量限制为65535。当列的数量 * batch_size超过限制时，batch_size将被调整以避免错误。
此选项同样适用于复制到外部表的情况。在这种情况下，postgres_fdw一次复制的实际行数与插入情况类似，但由于COPY命令的实现限制，最多限制为1000行。
F.38.1.5. Asynchronous Execution Options #
postgres_fdw 支持异步执行，可以并发地运行一个 Append 节点的多个部分，相比串行化的方式能获得更好的性能提升。可以使用以下选项来控制该执行行为：
async_capable (boolean)
这个选项控制postgres_fdw是否允许异步执行的外部表被同时扫描。它可以为一个外部表或一个外部服务器指定。一个表级的选项覆盖一个服务器级的选项。默认是false。
为了确保从外部服务器返回的数据一致性，postgres_fdw 只会为一个特定的外部服务器打开一个连接，并且顺序运行所有针对该服务器的查询，即使涉及多个外部表也是如此，除非这些表受不同用户映射的影响。在这种情况下，禁用此选项可能更有效，以消除运行异步查询所带来的开销。
在一个Append节点中，即使有部分子计划是同步执行，也有部分子计划是异步执行，异步执行仍被应用。在这种情况下，如果异步子计划是使用postgres_fdw处理的，则需要等到至少有一个同步子计划返回所有元组，才能返回异步子计划的元组，因为当异步子计划等待发送给外部服务器的异步查询的结果时，同步子计划正在执行。该行为可能会在未来的版本中更改。
F.38.1.6. Transaction Management Options #
如“事务管理”部分所述，在postgres_fdw中，通过创建相应的远程事务来管理事务，
通过创建相应的远程子事务来管理子事务。当当前本地事务涉及多个远程事务时，默认情况下，
postgres_fdw会在本地事务提交或中止时依次提交或中止这些远程事务。
当当前本地子事务涉及多个远程子事务时，默认情况下，
postgres_fdw会在本地子事务提交或中止时依次提交或中止这些远程子事务。
可以通过以下选项来提高性能：
parallel_commit (boolean)
此选项控制当本地事务提交时，postgres_fdw是否并行提交
在外部服务器上打开的远程事务。此设置同样适用于远程和本地子事务。
此选项只能为外部服务器指定，而不能为每个表指定。默认值为
false。
parallel_abort (boolean)
此选项控制当本地事务中止时，postgres_fdw是否并行中止
在远程服务器上打开的远程事务。此设置同样适用于远程和本地子事务。
此选项只能为外部服务器指定，而不能为每个表指定。默认值为
false。
如果多个启用了这些选项的外部服务器参与本地事务，当本地事务提交或
中止时，这些外部服务器上的多个远程事务将在这些外部服务器之间并行
提交或中止。
当启用这些选项时，具有许多远程事务的外部服务器可能会在本地事务
提交或中止时看到负面的性能影响。
F.38.1.7. 可更新性选项 #
默认情况下，所有使用postgres_fdw的外部表都被假定是可更新的。这可以使用下列选项覆盖：
updatable (boolean)
这个选项控制postgres_fdw是否允许外部表被使用INSERT、UPDATE和DELETE命令修改。它可以为一个外部表或一个外部服务器指定。一个表级选项会覆盖一个服务器级选项。默认值是true。
当然，如果远程表实际上并非可更新的，将产生一个错误。这个选项的使用主要是允许在不查询远程服务器的情况下在本地抛出错误。但是要注意information_schema视图会根据这个选项的设置报告一个postgres_fdw外部表是可更新的（或者不可更新），而不需要远程服务器的任何检查。
F.38.1.8. Truncatability Options #
默认情况下，使用 postgres_fdw 的所有外部表都被认为是可截断的。可以使用以下选项覆盖该行为：
truncatable (boolean)
此选项控制postgres_fdw是否允许使用 TRUNCATE 命令截断外部表。它可以指定为外部表或外部服务器。表级选项将覆盖服务器级选项。默认值是true。
当然，如果远程表实际上无法被截断，那么就会出现错误。该选项的使用主要可以在不查询远程服务器的情况下本地抛出错误。
F.38.1.9. 导入选项 #
postgres_fdw能使用IMPORT FOREIGN SCHEMA导入外部表定义。这个命令会在本地服务器上创建外部表定义，这些定义能匹配存在于远程服务器上的表或者视图。如果要被导入的远程表有用户自定义数据类型的列，本地服务器上也必须具有相同名称的兼容类型。
导入行为可以用下列选项自定义（在IMPORT FOREIGN SCHEMA命令中给出）：
import_collate (boolean)
这个选项控制是否在从外部服务器导入的外部表定义中包括列的COLLATE选项。默认是true。如果远程服务器具有和本地服务器不同的排序规则名集合，可能需要关闭这个选项，在不同的操作系统上运行时很可能就是这样。
这么做，然而有一个非常严重的风险，即导入表的列排序规则将不匹配基础数据，从而导致异常的查询行为。
即使此参数设置为true，导入远程服务器默认排序规则的列也存在风险。它们将以COLLATE "default"被导入，这将选择本地服务器的默认排序规则，而这可能是不同的。
import_default (boolean)
这个选项控制是否在从外部服务器导入的外部表定义中包括列的DEFAULT表达式。默认是false。如果启用这个选项，要当心在远程服务器和本地服务器上计算表达式的方式不同，nextval()常会导致这类问题。如果导入的默认值表达式使用了一个本地不存在的函数或者操作符，IMPORT将整个失败。
import_generated (boolean)
此选项控制导入自外部服务器的外部表定义是否包括列 GENERATED 表达式。默认值为 true。如果导入的生成表达式使用本地不存在的函数或运算符，则整个 IMPORT 将失败。
import_not_null (boolean)
这个选项控制是否在从外部服务器导入的外部表定义中包括列的 NOT NULL 约束。默认是 true。
注意除 NOT NULL 之外的约束将不会从远程表中导入。虽然 PostgreSQL 确实支持外部表上的检查约束，但不会自动导入它们，因为存在本地和远程服务器计算约束表达式方式不同的风险。检查约束中的任何这类不一致都可能导致查询优化中很难检测的错误。因此，如果你希望导入检查约束，你必须手工来做，并且你应该仔细地验证每一个这种约束的语义。有关处理外部表上检查约束的更多细节，请见 CREATE FOREIGN TABLE。
作为其他表的分区的表或外部表只在明确指定它们在 LIMIT TO 子句中时才被导入。否则，它们将自动从 IMPORT FOREIGN SCHEMA 中排除。由于可以通过分区层次结构的根即分区表来访问所有数据，因此仅导入分区表应该允许访问所有数据而不创建额外的对象。
F.38.1.10. Connection Management Options #
默认情况下，postgres_fdw 连接到外部服务器的所有连接都保持打开状态以便于重复使用。
keep_connections (boolean) #
该选项控制postgres_fdw是否保持与外部服务器的连接，以便后续查询可以重复使用它们。它仅适用于外部服务器。默认情况下为on。如果设置为off，则每个事务结束时将丢弃到该外部服务器的所有连接。
use_scram_passthrough (boolean) #
此选项控制 postgres_fdw 是否使用 SCRAM
透传身份验证连接到外部服务器。使用 SCRAM 透传身份验证时，
postgres_fdw 使用 SCRAM 哈希的密钥而不是
明文用户密码来连接远程服务器。这避免了在 PostgreSQL 系统
目录中存储明文用户密码。
要使用 SCRAM 透传身份验证：
远程服务器必须请求 scram-sha-256
身份验证方法；否则，连接将失败。
远程服务器可以是任何支持 SCRAM 的 PostgreSQL 版本。
对 use_scram_passthrough 的支持仅在客户端
侧（FDW 侧）是必需的。
用户映射密码不被使用。
运行 postgres_fdw 的服务器和远程服务器
必须对在 postgres_fdw 上用于在外部服务器
身份验证的用户具有相同的 SCRAM 密钥（加密密码），
（相同的盐和迭代次数，而不仅仅是相同的密码）。
作为推论，如果要对多个主机进行 FDW 连接，例如用于分区外部表/分片，
则所有主机必须对相关用户具有相同的 SCRAM 密钥。
发起出站 FDW 连接的 PostgreSQL 实例上的当前会话也必须
对其传入客户端连接使用 SCRAM 身份验证。
（因此 “pass-through”：SCRAM 必须在进出时都使用。）
这是 SCRAM 协议的技术要求。
F.38.2. Functions #postgres_fdw_get_connections(
IN check_conn boolean DEFAULT false, OUT server_name text,
OUT user_name text, OUT valid boolean, OUT used_in_xact boolean,
OUT closed boolean, OUT remote_backend_pid int4)
returns setof record
此函数返回 postgres_fdw 从本地会话到外部服务器建立的
所有开放连接的信息。如果没有开放连接，则不返回任何记录。
如果 check_conn 设置为 true，
则该函数检查每个连接的状态，并在 closed 列中显示结果。
此功能目前仅在支持非标准 POLLRDHUP 扩展的系统上可用，
包括 Linux。这对于检查在事务中使用的所有连接是否仍然开放非常有用。
如果任何连接关闭，则事务无法成功提交，因此最好在检测到关闭连接后
尽快回滚，而不是继续到结束。如果函数报告同时
used_in_xact 和 closed 都为
true，用户可以立即回滚事务。
函数的示例用法：
postgres=# SELECT * FROM postgres_fdw_get_connections(true);
server_name | user_name | valid | used_in_xact | closed | remote_backend_pid
-------------+-----------+-------+--------------+-------+--------------------
loopback1   | postgres  | t     | t            | f     |            1353340
loopback2   | public    | t     | t            | f     |            1353120
loopback3   |           | f     | t            | f     |            1353156
输出列的描述见
表 F.28。
表 F.28. postgres_fdw_get_connections 输出列列类型描述server_nametext
此连接的外部服务器名称。如果服务器被删除但连接仍然开放
（即，标记为无效），则此值将为 NULL。
user_nametext
映射到此连接的外部服务器的本地用户名称，或者如果使用公共映射，则为
public。如果用户映射被删除但连接仍然开放
（即，标记为无效），则此值将为 NULL。
validboolean
如果此连接无效，则为 False，意味着它在当前事务中被使用，
但其外部服务器或用户映射已被更改或删除。
无效连接将在事务结束时关闭。否则返回 True。
used_in_xactboolean
如果此连接在当前事务中被使用，则为 True。
closedboolean
如果此连接已关闭，则为真，否则为假。
NULL 在 check_conn
设置为 false 或连接状态检查
在此平台上不可用时返回。
remote_backend_pidint4
处理连接的远程后端的进程 ID，
在外部服务器上。如果远程后端被终止并且
连接关闭（closed 设置为
true），这仍然显示已终止后端的进程 ID。
postgres_fdw_disconnect(server_name text) returns boolean
此函数会断开由postgres_fdw从本地会话到
指定名称的外部服务器之间建立的打开连接。
请注意，可以使用不同的用户映射在给定服务器上建立多个连接。
如果这些连接在当前本地事务中被使用，则它们不会被断开，并且会报告警告消息。
如果此函数断开至少一个连接，则返回true，否则返回false。
如果找不到具有给定名称的外部服务器，则会报告错误。
函数的示例用法：
postgres=# SELECT postgres_fdw_disconnect('loopback1');
postgres_fdw_disconnect
-−-−-−-−-−-−-−-−-−-−-−-−-
t
postgres_fdw_disconnect_all() returns boolean
此函数会断开由postgres_fdw从本地会话到
外部服务器之间建立的所有打开连接。
如果这些连接在当前本地事务中被使用，它们不会被断开，并且会报告警告消息。
如果至少断开了一个连接，该函数返回true，否则返回false。
函数的示例用法：
postgres=# SELECT postgres_fdw_disconnect_all();
postgres_fdw_disconnect_all
-−-−-−-−-−-−-−-−-−-−-−-−-−-−-
t
F.38.3. 连接管理 #
postgres_fdw在第一个使用关联到外部服务器的外部表的查询期间建立一个到外部服务器的连接。默认情况下，这个连接会被保持，并被重用于同一个会话中的后续查询。这个行为可以通过外部服务器的keep_connections选项来控制。如果使用了多个用户实体（用户映射）来访问外部服务器，会为每一个用户映射建立一个连接。
当更改外部服务器或用户映射的定义或删除它们时，相关的连接会关闭。但是请注意，如果在当前本地事务中使用任何连接，则将其保留到事务结束。已关闭的连接将在未来使用一个外部表的查询时重新建立。
一旦与外部服务器建立了连接，默认情况下会一直保持直到相应本地或远程会话退出。如果想显式断开一个连接，可以将外部服务器的keep_connections选项禁用，或使用postgres_fdw_disconnect和postgres_fdw_disconnect_all函数。例如，这些函数对于关闭不再需要的连接很有用，从而释放外部服务器上的连接。
F.38.4. 事务管理 #
在一个引用外部服务器上任何远程表的查询期间，如果还没有根据当前的本地事务打开一个远程事务，postgres_fdw将在远程服务器上打开一个事务。当本地事务提交或中止时，远程事务也被提交或中止。保存点也相似地通过创建相应的远程保存点来管理。
当本地事务为SERIALIZABLE隔离级别时，远程事务使用SERIALIZABLE隔离级别；否则它使用REPEATABLE READ隔离级别。如果一个查询在远程服务器上执行多个表扫描，这种选择保证它将为所有扫描得到快照一致的结果。一种后果是在单一事务中的后继查询将会看到来自远程服务器的相同数据，即便由于其他活动在远程服务器上发生了其他并发更新。如果本地事务使用SERIALIZABLE或REPEATABLE READ隔离级别，这种行为也是可以预期的，但是对于一个READ COMMITTED本地事务它是令人惊讶的。一个未来的PostgreSQL发布可能会修改这些规则。
请注意postgres_fdw当前不支持为两阶段提交准备远程事务。
F.38.5. 远程查询优化 #
postgres_fdw尝试优化远程查询来减少从外部服务器传来的数据量。这可以通过把查询的WHERE子句发送给远程服务器执行来完成，并且还可以不检索当前查询不需要的表列。为了降低查询被误执行的风险，除非WHERE子句使用的数据类型、操作符和函数都是内建的或者属于列在该外部服务器的extensions选项中的一个扩展，将不会把WHERE子句发送到远程服务器。这些子句中的操作符和函数也必须是IMMUTABLE。对于UPDATE或者DELETE查询，
如果没有不能发送给远程服务器的WHERE子句、
没有查询的本地连接、目标表上没有本地的行级BEFORE或AFTER触发器或存储生成的列，
并且没有来自父视图的CHECK OPTION约束，postgres_fdw会尝试通过将整个查询发送给远程服务器来优化查询的执行。在UPDATE中，赋值给目标列的表达式只能使用内建数据类型、IMMUTABLE操作符或者IMMUTABLE函数，这样能降低查询被误执行的风险。
当postgres_fdw碰到同一个外部服务器上的外部表之间的连接时，它会把整个连接发送给外部服务器，除非由于某些原因它认为逐个从每一个表取得行的效率更高或者涉及的表引用属于不同的用户映射。在发送JOIN子句时，它也会采取和上述WHERE子句相同的预防措施。
实际被发送到远程服务器执行的查询可以使用EXPLAIN VERBOSE来检查。
F.38.6. 远程查询执行环境 #
在postgres_fdw开启的远程会话中，search_path参数只被设置为pg_catalog，因此只有内建对象可以在无模式限定时可见。这对于postgres_fdw本身产生的查询来说不是问题，因为它总是会提供这样的限定。不过，这可能会对在远程服务器上通过触发器或者远程表上的规则执行的函数带来风险。例如，如果一个远程表实际是一个视图，任何在该视图中使用的函数都将被在这个受限的搜索路径中执行。我们推荐在这类函数中用模式限定所有名称，或者为这类函数附着SET search_path选项（见CREATE FUNCTION）来建立它们所期望的搜索路径环境。
postgres_fdw同样为各种参数建立远程会话设置：
TimeZone设置为UTC
DateStyle设置为ISO
IntervalStyle设置为postgres
对于远程服务器9.0和更新版本，extra_float_digits
设置为3，并且针对更老版本设置为2
这些不如search_path有那么多问题，但是如果需要也可以使用函数
SET选项来处理。
我们不推荐通过更改这些参数的会话级设置来推翻这种行为，这很可能会导致postgres_fdw故障。
F.38.7. 跨版本兼容性 #
postgres_fdw 可以与早至
PostgreSQL 8.3 的远程服务器一起使用。
只读功能可追溯到 8.1。
然而，一个限制是 postgres_fdw
通常假设不可变的内置函数和运算符是
安全的，可以发送到远程服务器执行，如果它们出现在
WHERE 子句中。因此，自远程服务器发布以来添加的内置
函数可能会被发送到其上执行，导致 “函数不存在” 或
类似的错误。这种类型的失败可以通过
重写查询来解决，例如通过将外部表
引用嵌入到带有 OFFSET 0 的子-SELECT 中作为
优化边界，并将有问题的函数或运算符放在子-SELECT 之外。
另一个限制是，当在外部表上执行带有
ON CONFLICT DO NOTHING 子句的 INSERT
语句时，远程服务器必须运行
PostgreSQL 9.5 或更高版本，
因为早期版本不支持此功能。
F.38.8. 等待事件 #
postgres_fdw 可以报告以下等待事件，
这些事件属于等待事件类型 Extension：
PostgresFdwCleanupResult
正在等待远程服务器上的事务中止。
PostgresFdwConnect
正在等待与远程服务器建立连接。
PostgresFdwGetResult
等待从远程服务器接收查询结果。
F.38.9. 配置参数 #
postgres_fdw.application_name (string)
#
指定一个值用于application_name配置参数，
当postgres_fdw建立到外部服务器的连接时使用。
这将覆盖服务器对象的application_name选项。
请注意，更改此参数不会影响任何现有的连接，直到它们重新建立。
postgres_fdw.application_name 可以是任何长度的任意字符串，
甚至可以包含非ASCII字符。然而，当它被传递并用作外部服务器中的
application_name 时，请注意它将被截断为少于
NAMEDATALEN 个字符。
任何非可打印的ASCII字符都会被替换为
C风格的十六进制转义。
有关详细信息，请参见 application_name。
%字符开始“转义序列”，这些序列将被下面概述的状态信息替换。
未识别的转义将被忽略。其他字符将直接复制到应用程序名称中。
请注意，在选项之前和%之后不允许指定加号/减号或数字文字，用于对齐和填充。
转义效果%a本地服务器上的应用程序名称%c
本地服务器上的会话ID
(详细信息请参见log_line_prefix)
%C
本地服务器上的集群名称
(详细信息请参见cluster_name)
%u本地服务器上的用户名称%d本地服务器上的数据库名称%p本地服务器上后端的进程ID%%字面量 %
例如，假设用户local_user从数据库local_db建立连接到foreign_db，
作为用户foreign_user，设置'db=%d, user=%u'被替换为'db=local_db, user=local_user'。
F.38.10. 示例 #
这里是一个用postgres_fdw创建外部表的示例。首先安装该扩展：
CREATE EXTENSION postgres_fdw;
然后使用CREATE SERVER创建一个外部服务器。在这个例子中我们希望连接到一个位于主机192.83.123.89上并且监听5432端口的PostgreSQL服务器。在该远程服务器上要连接的数据库名为foreign_db：
CREATE SERVER foreign_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host '192.83.123.89', port '5432', dbname 'foreign_db');
需要用CREATE USER MAPPING定义一个用户映射来标识在远程服务器上使用哪个角色：
CREATE USER MAPPING FOR local_user
SERVER foreign_server
OPTIONS (user 'foreign_user', password 'password');
现在就可以使用CREATE FOREIGN TABLE创建外部表了。在这个例子中我们希望访问远程服务器上名为some_schema.some_table的表。它的本地名称是foreign_table：
CREATE FOREIGN TABLE foreign_table (
id integer NOT NULL,
data text
)
SERVER foreign_server
OPTIONS (schema_name 'some_schema', table_name 'some_table');
CREATE FOREIGN TABLE中声明的列数据类型和其他属性必须要匹配实际的远程表。列名也必须匹配，不过也可以为个别列附上column_name选项以表示它们在远程表中对应哪个列。在很多情况下，使用IMPORT FOREIGN SCHEMA会比手工构造外部表定义更好。
F.38.11. 作者 #
Shigeru Hanada <shigeru.hanada@gmail.com>
上一页 上一级 下一页F.37. pg_walinspect — 低级 WAL 检查 起始页 F.39. seg — 表示线段或浮点区间的数据类型
