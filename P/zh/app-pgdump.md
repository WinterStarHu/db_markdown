# pg_dump

pg_dump
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_dumppg_dump —
将 PostgreSQL 数据库导出为 SQL 脚本或其他格式
大纲pg_dump [connection-option...] [option...] [dbname]描述
pg_dump 是一个用于导出 PostgreSQL 数据库的工具。即使数据库正在被并发使用，它也能进行一致的导出。pg_dump 不会阻塞其他用户访问数据库（读取或写入）。然而，请注意，除非在简单情况下，pg_dump 通常不是进行生产数据库定期备份的正确选择。有关进一步讨论，请参见 第 25 章。
pg_dump 仅导出单个数据库。要导出整个集群，或导出所有数据库中共有的全局对象（如角色和表空间），请使用 pg_dumpall。
转储可以被输出到脚本或归档文件格式。脚本转储是包含 SQL 命令的纯文本文件，它们可以用来重构数据库到它被转储时的状态。要从这样一个脚本恢复，将它喂给 psql。脚本文件甚至可以被用来在其他机器和其他架构上重构数据库。在经过一些修改后，甚至可以在其他 SQL 数据库产品上重构数据库。
另一种可选的归档文件格式必须与 pg_restore 配合使用来重建数据库。它们允许 pg_restore 能选择恢复什么，或者甚至在恢复之前对条目重排序。归档文件格式被设计为在架构之间可移植。
当与某种归档文件格式结合使用并与 pg_restore 一起使用时，pg_dump 提供了灵活的归档和传输机制。pg_dump 可用于导出整个数据库，然后可以使用 pg_restore 检查归档和/或选择要恢复的数据库部分。最灵活的输出文件格式是 “custom” 格式 (-Fc) 和 “directory” 格式 (-Fd)。它们允许选择和重新排序所有归档项目，支持并行恢复，并且默认情况下是压缩的。“directory” 格式是唯一支持并行导出的格式。
当运行pg_dump时，我们应该检查输出中有没有任何警告（打印在标准错误上），特别是考虑到下面列出的限制。
警告
恢复转储会导致目标执行源超级用户选择的任意代码。部分转储和部分恢复并不限制这一点。如果源超级用户不受信任，则必须在恢复之前检查转储的 SQL 语句。可以使用 pg_restore 的 --file 选项检查非纯文本转储。请注意，运行转储和恢复的客户端不需要信任源或目标超级用户。
选项
以下命令行选项控制输出的内容和格式。
dbname
指定要转储的数据库名称。如果未指定，则使用环境变量PGDATABASE。如果未设置该变量，则使用连接指定的用户名。
-a--data-only
仅转储数据，而不转储模式（数据定义）或统计信息。表数据、大对象和序列值会被转储。
这个选项与指定 --section=data 类似，但由于历史原因并不完全相同。
-b--large-objects--blobs（已弃用）
在转储中包含大对象。这是默认行为，除非指定 --schema、--table、--schema-only、--statistics-only 或 --no-data。因此，-b 开关仅在请求特定模式或表时对添加大对象到转储有用。请注意，大对象被视为数据，因此在使用 --data-only 时会被包含，但在使用 --schema-only 或 --statistics-only 时则不会。
-B--no-large-objects--no-blobs（已弃用）
在转储中排除大对象。
当同时给出-b和-B时，行为是在转储数据时输出大对象，
请参阅-b文档。
-c--clean
输出命令以 DROP 所有转储的数据库对象，然后再输出创建这些对象的命令。这个选项在恢复时需要覆盖现有数据库时非常有用。如果目标数据库中没有某些对象，恢复过程中会报告可忽略的错误消息，除非同时指定了 --if-exists。
当生成一个归档（非文本）输出文件时，此选项将被忽略。对于归档格式，您可以在调用pg_restore时指定该选项。
-C--create
首先输出一个创建数据库的命令，并重新连接到创建的数据库。（使用这种形式的脚本，运行之前连接到目标安装中的哪个数据库并不重要。）如果同时指定了 --clean，脚本将在重新连接之前删除并重新创建目标数据库。
使用--create，输出还包括数据库的注释（如果有的话），
以及特定于该数据库的任何配置变量设置，也就是说，
提及该数据库的任何ALTER DATABASE ... SET ...
和ALTER ROLE ... IN DATABASE ... SET ...命令。
除非指定了--no-acl，否则还会转储数据库本身的访问权限。
当生成一个归档（非文本）输出文件时，此选项将被忽略。对于归档格式，您可以在调用pg_restore时指定该选项。
-e pattern--extension=pattern
仅转储与pattern匹配的扩展。
当未指定此选项时，将转储目标数据库中的所有非系统扩展。
可以通过编写多个-e参数来选择多个扩展。
psql的\d命令使用相同规则解释pattern参数
（请参阅Patterns），
因此也可以通过在模式中使用通配符来选择多个扩展。
使用通配符时，要小心引用模式，以防止shell扩展通配符。
任何由pg_extension_config_dump注册的配置关系，
如果其扩展被--extension指定，则包含在转储中。
注意
当指定-e选项时，
pg_dump不会尝试转储所选扩展可能依赖的任何其他数据库对象。
因此，不能保证特定扩展的转储结果可以成功地单独恢复到一个干净的数据库中。
-E encoding--encoding=encoding
在指定的字符集编码中创建转储。默认情况下，转储将以数据库编码创建。
（获得相同结果的另一种方法是将PGCLIENTENCODING环境变量设置为所需的转储编码。）
支持的编码在第 23.3.1 节中描述。
-f file--file=file
将输出发送到指定的文件。对于基于文件的输出格式，可以省略此参数，此时使用标准输出。
但是，在目录输出格式中，必须提供此参数，指定目标目录而不是文件。在这种情况下，目录由pg_dump创建，且在此之前不得存在。
-F format--format=format
选择输出的格式。
format可以是以下之一：
pplain
输出一个纯文本的SQL脚本文件（默认选项）。
ccustom
输出一个自定义格式的归档文件，适合用于pg_restore。
与目录输出格式一起使用时，这是最灵活的输出格式，因为它允许在恢复
期间手动选择和重新排序归档项目。此格式默认情况下也会被压缩。
ddirectory
输出一个目录格式的归档文件，适合用于pg_restore。
这将创建一个目录，其中每个表和大对象都会有一个文件，外加一个所谓的
内容表文件，用于以机器可读的格式描述被转储的对象，
pg_restore可以读取该文件。
目录格式的归档文件可以使用标准的Unix工具进行操作；例如，
未压缩的归档文件中的文件可以使用gzip、
lz4或zstd工具进行压缩。
此格式默认使用gzip进行压缩，并且还支持并行转储。
ttar
输出一个tar格式的归档文件，适合用于
pg_restore。tar格式与目录格式兼容：
提取一个tar格式的归档文件会生成一个有效的目录格式归档文件。
然而，tar格式不支持压缩。此外，使用tar格式时，表数据项的相对顺序
在恢复期间无法更改。
-j njobs--jobs=njobs
并行运行转储操作，同时转储njobs个表。这个选项可能会减少执行转储所需的时间，但也会增加数据库服务器的负载。您只能在目录输出格式下使用此选项，因为这是唯一一个多个进程可以同时写入数据的输出格式。
pg_dump将打开njobs
+ 1个连接到数据库，因此请确保您的max_connections
设置足够高，以容纳所有连接。
在运行并行转储时请求对数据库对象的排他锁可能导致转储失败。原因是pg_dump领导进程
请求对稍后工作进程将要转储的对象的共享锁(ACCESS SHARE)，
以确保在转储运行时没有人删除它们并使其消失。
如果另一个客户端请求对表的排他锁，该锁将不会被授予，而是排队等待领导进程的共享锁被释放。
因此，对表的任何其他访问也不会被授予，并且将在排队等待排他锁请求之后进行。这包括尝试转储表的工作进程。
没有任何预防措施，这将是一个典型的死锁情况。
为了检测这种冲突，pg_dump工作进程使用NOWAIT选项请求另一个
共享锁。如果工作进程未被授予此共享锁，则意味着在此期间其他人必须请求了排他锁，
并且没有办法继续转储，因此pg_dump别无选择，只能中止转储。
要执行并行转储，数据库服务器需要支持同步快照，这是在PostgreSQL 9.2中为主服务器引入的功能，
并在10中为备用服务器引入。有了这个功能，数据库客户端可以确保他们看到相同的数据集，即使他们使用不同的连接。
pg_dump -j使用多个数据库连接；它一次与领导进程连接到数据库，然后为每个工作任务再次连接一次。
没有同步快照功能，不同的工作任务在每个连接中看到的数据可能不一致，这可能导致不一致的备份。
-n pattern--schema=pattern
仅转储与模式匹配的模式；这将选择模式本身以及其包含的所有对象。
如果未指定此选项，将转储目标数据库中所有非系统模式。可以通过编写多个
-n开关来选择多个模式。模式
参数根据psql的\d命令使用的相同规则
被解释为模式（参见Patterns），因此也可以通过在模式中
编写通配符来选择多个模式。使用通配符时，请注意在必要时引用模式以防止
shell展开通配符；参见下面的Examples。
注意
当指定-n选项时，pg_dump
不会尝试转储所选模式(s)可能依赖的任何其他数据库对象。因此，不能保证
特定模式转储的结果能够成功地单独恢复到一个干净的数据库中。
注意
当指定-n时，非模式对象（如大对象）不会被转储。您可以使用
--large-objects选项将大对象重新添加到转储中。
-N pattern--exclude-schema=pattern
不转储与pattern匹配的任何模式。该模式的解释规则与-n相同。-N可以多次使用，以排除与多个模式匹配的模式。
当同时给出-n和-N选项时，行为是仅转储至少匹配一个
-n选项但不匹配-N选项的模式。
如果-N出现而没有-n，那么与-N
匹配的模式将被排除在否则是正常转储的内容之外。
-O--no-owner
不输出设置对象所有权以匹配原始数据库的命令。默认情况下，pg_dump 会发出 ALTER OWNER 或 SET SESSION AUTHORIZATION 语句来设置创建的数据库对象的所有权。这些语句在脚本运行时会失败，除非是由超级用户（或拥有脚本中所有对象的相同用户）启动。要创建一个可以被任何用户恢复的脚本，并将所有对象的所有权授予该用户，可以指定 -O。
当生成一个归档（非文本）输出文件时，此选项将被忽略。对于归档格式，您可以在调用 pg_restore 时指定该选项。
-R--no-reconnect
该选项已经过时，但仍然被接受以保持向后兼容性。
-s--schema-only
仅转储对象定义（模式），不转储数据或统计信息。
此选项不能与 --data-only 或 --statistics-only 一起使用。它类似于，但由于历史原因并不完全相同于，指定 --section=pre-data --section=post-data。
(不要将此与 --schema 选项混淆，该选项使用单词 “schema” 具有不同的含义。)
要仅排除数据库中某些表的表数据，请参见 --exclude-table-data。
-S username--superuser=username
指定在禁用触发器时要使用的超级用户用户名。
这仅在使用 --disable-triggers 时才相关。
（通常，最好将其省略，而是以超级用户身份启动生成的脚本。）
-t pattern--table=pattern
仅导出名称匹配
pattern的表。可以通过多次
使用-t开关来选择多个表。
pattern参数根据
psql的\d命令
（参见Patterns）使用的相同规则被解释为
一个模式，因此也可以通过在模式中使用通配符来选择多个表。
使用通配符时，请注意在必要时对模式加引号，以防止 shell 展开通配符；
参见下面的Examples。
除了表外，此选项还可用于转储匹配的视图、物化视图、外部表和序列的定义。它不会转储视图或物化视图的内容，
只有在使用--include-foreign-data指定相应外部服务器时，才会转储外部表的内容。
-n和-N开关在使用-t时没有效果，因为被-t选择的表将被转储，而不管这些开关如何设置，非表对象将不会被转储。
注意
当指定-t选项时，pg_dump
不会尝试转储所选表可能依赖的任何其他数据库对象。因此，不能保证
特定表的转储结果能够成功地单独恢复到一个干净的数据库中。
-T pattern--exclude-table=pattern
不导出任何与 pattern 匹配的表。该模式的解释规则与 -t 相同。-T 可以多次使用，以排除与多个模式匹配的表。
当同时给出-t和-T选项时，行为是仅转储至少匹配一个-t开关但没有-T开关的表。
如果-T出现而没有-t，那么与-T匹配的表将被排除在否则是正常转储的内容之外。
-v--verbose
指定详细模式。这将导致pg_dump将详细的对象注释和开始/停止时间输出到转储文件，并将进度消息输出到标准错误。
重复该选项会导致额外的调试级别消息出现在标准错误上。
-V--version
打印pg_dump的版本并退出。
-x--no-privileges--no-acl
防止访问权限的转储（grant/revoke命令）。
-Z level-Z method[:detail]--compress=level--compress=method[:detail]
指定要使用的压缩方法和/或压缩级别。
压缩方法可以设置为gzip、
lz4、zstd，
或none（无压缩）。
可以选择性地指定一个压缩细节字符串。如果细节字符串是一个整数，
它表示压缩级别。否则，它应该是一个逗号分隔的项目列表，
每个项目的形式为keyword或
keyword=value。
当前支持的关键字是level和
long。
如果未指定压缩级别，将使用默认的压缩级别。如果仅指定了级别而未提及
算法，当级别大于0时，将使用gzip压缩，
而当级别为0时，将不使用压缩。
对于自定义和目录归档格式，这指定了对单个表数据段的压缩，默认是使用
gzip以中等水平进行压缩。对于纯文本输出，
设置非零压缩级别会导致整个输出文件被压缩，就像它通过
gzip、lz4或
zstd处理一样；但默认情况下不进行压缩。
使用zstd压缩时，long模式可能会提高压缩比，
但代价是增加内存使用。
当前的 tar 存档格式完全不支持压缩。
--binary-upgrade
此选项供就地升级实用程序使用。不建议或支持将其用于其他目的。该选项的行为可能在未来的版本中更改而不另行通知。
--column-inserts--attribute-inserts
将数据转储为带有显式列名的INSERT命令
(INSERT INTO
table
(column, ...) VALUES
...)。这将使恢复过程非常缓慢；主要用于创建可以加载到非PostgreSQL数据库中的转储文件。
在恢复过程中发生任何错误将导致只有属于有问题的INSERT的行丢失，而不是整个表的内容。
--disable-dollar-quoting
这个选项禁用了在函数体中使用美元引用的功能，并强制使用SQL标准字符串语法进行引用。
--disable-triggers
此选项仅在创建包含数据但不包含模式的转储时相关。它指示 pg_dump 包含在恢复数据时暂时禁用目标表上的触发器的命令。如果您在表上有引用完整性检查或其他触发器，而在数据恢复期间不希望触发它们，请使用此选项。
目前，为了--disable-triggers选项发出的命令必须由超级用户执行。
因此，您还应该使用-S指定一个超级用户名称，或者最好小心地
以超级用户身份启动生成的脚本。
当生成一个归档（非文本）输出文件时，此选项将被忽略。对于归档格式，您可以在调用pg_restore时指定该选项。
--enable-row-security
此选项仅在转储具有行安全性的表的内容时才相关。默认情况下，pg_dump将设置
row_security为关闭，以确保从表中转储所有数据。如果用户没有足够的权限来绕过行安全性，则会抛出错误。
此参数指示pg_dump将row_security设置为打开，允许用户转储他们有权限访问的表内容的部分。
请注意，如果您当前使用此选项，您可能还希望将转储文件格式设置为INSERT，
因为在还原期间COPY FROM不支持行安全性。
--exclude-extension=pattern
不要转储任何匹配pattern的扩展名。
该模式的解释规则与-e相同。可以多次使用--exclude-extension
来排除匹配多个模式中的任意一个的扩展名。
当同时给出-e和--exclude-extension时，行为是仅转储至少匹配一个
-e开关但不匹配任何--exclude-extension开关的扩展名。
如果出现--exclude-extension而没有-e，则匹配
--exclude-extension的扩展名将从正常转储中排除。
--exclude-table-and-children=pattern
这与-T/--exclude-table选项相同，
不同之处在于它还排除了与
模式匹配的表的任何分区或继承子表。
--exclude-table-data=pattern
不要为任何匹配pattern的表转储数据。
该模式的解释方式与-t的规则相同。
可以多次使用--exclude-table-data来排除匹配任何几个模式的表。
当您需要特定表的定义但不需要其中的数据时，此选项非常有用。
要排除数据库中所有表的数据，请参见 --schema-only 或 --statistics-only。
--exclude-table-data-and-children=pattern
这与--exclude-table-data选项相同，
不同之处在于它还排除了与
模式匹配的表的任何分区或继承子表的数据。
--extra-float-digits=ndigits
使用指定值extra_float_digits来转储浮点数据，而不是使用最大可用精度。
用于备份目的的例程不应使用此选项。
--filter=filename
指定一个文件名，从中读取用于包含或排除转储对象的模式。模式的解释规则与
相应选项相同：
-t/--table，
--table-and-children，
-T/--exclude-table，以及
--exclude-table-and-children 用于表，
-n/--schema 和
-N/--exclude-schema 用于模式，
--include-foreign-data 用于外部服务器上的数据，
--exclude-table-data 和
--exclude-table-data-and-children 用于表数据，以及
-e/--extension 和
--exclude-extension 用于扩展。
若要从 STDIN 读取，使用 - 作为文件名。
--filter 选项可以与上述包含或排除对象的选项一起指定，
并且可以多次指定以使用多个过滤文件。
该文件每行列出一个对象模式，格式如下：
{ include | exclude } { extension | foreign_data | table | table_and_children | table_data | table_data_and_children | schema } PATTERN
第一个关键字指定模式匹配的对象是包含还是排除。第二个关键字指定使用模式过滤的对象类型：
extension：扩展。这类似于
-e/--extension或
--exclude-extension选项。
foreign_data：外部服务器上的数据。这类似于
--include-foreign-data选项。此关键字只能与
include关键字一起使用。
table：表。这类似于
-t/--table或
-T/--exclude-table选项。
table_and_children：表，包括任何分区或继承的子表。这类似于
--table-and-children或
--exclude-table-and-children选项。
table_data：匹配pattern的任何表的数据。这类似于
--exclude-table-data选项。此关键字只能与
exclude关键字一起使用。
table_data_and_children：匹配pattern的任何表的数据，以及该表的任何分区或继承子表的数据。
这类似于--exclude-table-data-and-children选项。此关键字只能与
exclude关键字一起使用。
schema：模式。这类似于
-n/--schema或
-N/--exclude-schema选项。
以#开头的行被视为注释并且会被忽略。注释也可以放在对象模式行之后。
空白行同样会被忽略。请参见Patterns了解如何在模式中进行引用。
示例文件列在下面的Examples章节中。
--if-exists
使用DROP ... IF EXISTS命令在--clean模式下删除对象。
这将抑制可能会报告的“不存在”错误。除非还指定了--clean，否则此选项无效。
--include-foreign-data=foreignserver
转储与匹配foreignserver
模式的外部服务器相关的任何外部表的数据。可以通过编写多个
--include-foreign-data开关来选择多个外部服务器。
此外，foreignserver参数
根据psql的\d命令
（参见Patterns）使用的相同规则被解释为一个模式，
因此也可以通过在模式中编写通配符字符来选择多个外部服务器。
使用通配符时，请注意在必要时引用模式以防止 shell 展开通配符；
参见下面的Examples。
唯一的例外是空模式是不允许的。
注意
在--include-foreign-data中使用通配符可能会导致访问意外的外部服务器。
此外，为了安全地使用此选项，请确保指定的服务器必须由可信的所有者拥有。
注意
当指定--include-foreign-data选项时，
pg_dump不会检查外部表是否可写。
因此，不能保证外部表转储的结果可以成功恢复。
--inserts
将数据转储为INSERT命令（而不是COPY）。
这将使恢复过程非常缓慢；主要用于创建可以加载到非PostgreSQL数据库中的转储文件。
在恢复过程中发生任何错误将导致只有属于有问题的INSERT的行丢失，而不是整个表的内容。
请注意，如果您重新排列了列的顺序，恢复可能会完全失败。
--column-inserts选项可以防止列顺序更改，尽管速度更慢。
--load-via-partition-root
当为表分区转储数据时，使COPY或INSERT语句
指向包含它的分区层次结构的根，而不是分区本身。这会导致在加载数据时为每一行重新确定适当的分区。
当在一个服务器上恢复数据时，这可能很有用，因为行不总是落入与原始服务器上相同的分区中。
例如，如果分区列是文本类型，并且两个系统对用于对分区列进行排序的排序规则的定义不同。
--lock-wait-timeout=timeout
在转储开始时不要永远等待获取共享表锁。如果无法在指定的timeout内锁定表，则失败。
超时可以以SET statement_timeout接受的任何格式指定。（允许的格式因转储服务器版本而异，但所有版本都接受以毫秒为单位的整数。）
--no-comments
不转储 COMMENT 命令。
--no-data
不转储数据。
--no-policies
不转储行安全策略。
--no-publications
不转储发布。
--no-schema
不转储模式（数据定义）。
--no-security-labels
不转储安全标签。
--no-statistics
不要转储统计信息。这是默认。
--no-subscriptions
不要转储订阅。
--no-sync
默认情况下，pg_dump将等待所有文件被安全写入磁盘。
此选项导致pg_dump在不等待的情况下返回，这样更快，
但意味着随后的操作系统崩溃可能会导致转储文件损坏。通常，此选项在测试时很有用，
但在从生产安装中转储数据时不应使用。
--no-table-access-method
不输出选择表访问方法的命令。使用此选项时，所有对象将在恢复过程中采用默认的表访问方法进行创建。
当生成一个归档（非文本）输出文件时，此选项将被忽略。对于归档格式，您可以在调用pg_restore时指定该选项。
--no-tablespaces
不要输出选择表空间的命令。
使用此选项，所有对象将在恢复期间默认的表空间中创建。
当生成一个归档（非文本）输出文件时，此选项将被忽略。对于归档格式，您可以在调用pg_restore时指定该选项。
--no-toast-compression
不要输出命令来设置TOAST压缩方法。
使用此选项，所有列将以默认压缩设置恢复。
--no-unlogged-table-data
不要转储未记录表和序列的内容。此选项不影响是否转储表和序列的定义（模式）；
它只是抑制转储表和序列数据。从备用服务器转储时，未记录表和序列中的数据始终被排除。
--on-conflict-do-nothing
将 ON CONFLICT DO NOTHING 添加到 INSERT 命令中。
除非还指定了 --inserts、--column-inserts 或
--rows-per-insert，否则此选项无效。
--quote-all-identifiers
强制引用所有标识符。当从一个 PostgreSQL 主版本与 pg_dump 不同的服务器中导出数据库时，
或者当输出意图加载到一个不同主版本的服务器时，建议使用此选项。默认情况下，
pg_dump 仅引用其自身主版本中的保留字标识符。
这有时会导致与其他版本服务器处理时出现兼容性问题，可能具有稍有不同的保留字集合。
使用 --quote-all-identifiers 可以避免这些问题，但会导致生成的脚本更难阅读。
--restrict-key=restrict_key
使用提供的字符串作为 psql
\restrict 键在转储输出中。这只能
在纯文本转储中指定，即，当 --format 设置为
plain 或省略 --format 选项时。
如果未指定限制键，pg_dump 将根据需要生成一个随机键。
键只能包含字母数字字符。
此选项主要用于测试目的和其他需要可重复输出的场景
（例如，比较转储文件）。不建议一般使用，因为一个
恶意服务器如果提前知道密钥，可能会注入任意代码，
该代码将在运行 psql 的机器上执行
并使用转储输出。
--rows-per-insert=nrows
将数据转储为 INSERT 命令（而不是 COPY）。
控制每个 INSERT 命令的最大行数。指定的值必须是大于零的数字。
恢复过程中的任何错误将导致只有属于有问题的 INSERT 的行丢失，
而不是整个表的内容。
--section=sectionname
仅转储指定的部分。部分名称可以是
pre-data，data，或 post-data。
可以多次指定此选项以选择多个部分。默认情况下是转储所有部分。
数据部分包含实际的表数据、大对象内容、序列值以及
表、物化视图和外部表的统计信息。
后数据项包括索引、触发器、规则的定义，
索引的统计信息，以及其他约束（除了经过验证的检查
和非空约束）。
前数据项包括所有其他数据定义项。
--sequence-data
在转储中包含序列数据。这是默认行为，除非
指定 --no-data、--schema-only 或
--statistics-only。
--serializable-deferrable
使用 serializable 事务进行转储，以确保使用的快照与后续数据库
状态一致；但是通过等待事务流中不存在异常的点来实现这一点，以确保转储不会失败
或导致其他事务回滚，出现 serialization_failure。有关事务隔离和
并发控制的更多信息，请参见 第 13 章。
这个选项对于仅用于灾难恢复的转储并不有益。对于用于加载数据库副本以供报告或
其他只读负载共享的转储可能有用，而原始数据库仍在更新。如果没有它，转储可能
反映出与最终提交的事务的任何串行执行不一致的状态。例如，如果使用批处理技术，
一个批处理可能在转储中显示为关闭，而批处理中的所有项目都没有出现。
如果在启动 pg_dump 时没有活动的读写事务，则此选项不会产生任何影响。如果有
活动的读写事务，则转储的开始可能会延迟一段不确定的时间。一旦运行，使用此
开关与不使用开关时的性能是相同的。
--snapshot=snapshotname
在制作数据库转储时，请使用指定的同步快照（详细信息请参见
表 9.100）。
当需要将转储与逻辑复制插槽（参见 第 47 章）或与
并发会话同步时，此选项非常有用。
在并行转储的情况下，使用此选项定义的快照名称，而不是创建一个新的快照。
--statistics
转储优化器统计信息。
--statistics-only
仅转储统计信息，而不转储模式（数据定义）或数据。
表、物化视图、外部表和索引的优化器统计信息将被转储。
--strict-names
要求每个扩展(-e/--extension)、
模式(-n/--schema)和表(-t/--table)
模式至少匹配数据库中要转储的一个扩展/模式/表。
这也适用于与--filter一起使用的过滤器。
注意，如果扩展/模式/表模式都没有找到匹配项，
pg_dump即使没有--strict-names也会报错。
此选项对
--exclude-extension、
-N/--exclude-schema、
-T/--exclude-table、
或 --exclude-table-data无效。未匹配任何对象的排除模式不视为错误。
--sync-method=method
当设置为fsync（默认值）时，
pg_dump --format=directory将递归打开并同步归档目录中的所有文件。
在 Linux 上，可以使用 syncfs 来请求操作系统同步包含归档目录的整个文件系统。
有关使用 syncfs 时需要注意的事项，请参见 recovery_init_sync_method。
当使用--no-sync选项或--format未设置为directory时，
此选项无效。
--table-and-children=pattern
这与-t/--table选项相同，
不同之处在于它还包括与
模式匹配的表的任何分区或继承子表。
--use-set-session-authorization
输出SQL标准的SET SESSION AUTHORIZATION命令，而不是ALTER OWNER命令来确定对象所有权。
这使得转储更符合标准，但根据转储中对象的历史，可能无法正确恢复。
此外，使用SET SESSION AUTHORIZATION的转储肯定需要超级用户权限才能正确恢复，
而ALTER OWNER需要较低的权限。
-?--help
显示关于pg_dump命令行参数的帮助信息，并退出。
下列命令行选项控制数据库连接参数。
-d dbname--dbname=dbname
指定要连接的数据库的名称。这等效于在命令行上将dbname指定为第一个非选项参数。dbname
可以是连接字符串。如果是这样，连接字符串参数将覆盖所有冲突的命令行选项。
-h host--host=host
指定服务器正在运行的机器的主机名。如果该值开始于一个斜线，它被用作一个Unix域套接字的目录。默认是从PGHOST环境变量中取得（如果被设置），否则将尝试一次Unix域套接字连接。
-p port--port=port
指定服务器正在监听连接的TCP端口或本地Unix域套接字文件扩展名。默认是放在PGPORT环境变量中（如果被设置），否则使用编译在程序中的默认值。
-U username--username=username
要作为哪个用户连接。
-w--no-password
从不发出一个口令提示。如果服务器要求口令认证并且没有其他方式提供口令（例如一个.pgpass文件），那么连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W--password
强制pg_dump在连接到一个数据库之前提示要求一个口令。
这个选项从来不是必须的，因为如果服务器要求口令认证，pg_dump将自动提示要求一个口令。但是，pg_dump将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下，值得键入-W来避免额外的连接尝试。
--role=rolename
指定一个用来创建该转储的角色名。这个选项导致pg_dump在连接到数据库后发出一个SET ROLE rolename命令。当已认证用户（由-U指定）缺少pg_dump所需的特权但是能够切换到一个具有所需权利的角色时，这个选项很有用。一些安装有针对直接作为超级用户登录的策略，使用这个选项可以让转储在不违反该策略的前提下完成。
环境PGDATABASEPGHOSTPGOPTIONSPGPORTPGUSER
默认连接参数。
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
诊断
pg_dump在内部执行SELECT语句。如果你运行pg_dump时出现问题，确保你能够从正在使用的数据库中选择信息，例如psql。此外，libpq前端库所使用的任何默认连接设置和环境变量都将适用。
pg_dump的数据库活动通常由累积统计系统收集。
如果这是不希望的，您可以通过PGOPTIONS或ALTER
USER命令将参数track_counts设置为false。
注释
如果你的数据库集簇对于template1数据库有任何本地添加，要注意将pg_dump的输出恢复到一个真正的空数据库。否则你很可能由于增加对象的重复定义而得到错误。要创建一个不带任何本地添加的空数据库，从template0而不是template1复制它，例如：
CREATE DATABASE foo WITH TEMPLATE template0;
当选择不带模式的转储并使用选项 --disable-triggers
时，pg_dump 会发出命令
在插入数据之前禁用用户表上的触发器，
然后在数据插入后发出命令重新启用它们。
如果在中途停止恢复，系统目录可能会处于错误状态。
当指定 --statistics 时，
pg_dump 将在生成的转储文件中包含大多数优化器统计信息。
这并不包括所有统计信息，例如那些通过 CREATE STATISTICS 显式创建的，
扩展添加的自定义统计信息，或由累积统计系统收集的统计信息。
因此，在从转储文件恢复后运行 ANALYZE 以确保
最佳性能仍然是有用的；有关更多信息，请参见 第 24.1.3 节 和 第 24.1.6 节。
因为pg_dump用于将数据传输到更新版本的PostgreSQL，
所以可以预期pg_dump的输出可以加载到比pg_dump版本更新的
PostgreSQL服务器版本中。 pg_dump也可以从比其自身版本旧的
PostgreSQL服务器中转储数据。 （目前，支持的服务器版本可以追溯到9.2版本。）
但是，pg_dump无法从比其自身主要版本更新的PostgreSQL服务器中转储数据；
它将拒绝尝试，而不是冒险生成无效的转储文件。此外，不能保证pg_dump的输出可以加载到
较旧主要版本的服务器中 — 即使转储文件是从该版本的服务器中获取的。将转储文件加载到较旧的服务器可能需要手动编辑
转储文件，以删除较旧服务器不理解的语法。在跨版本情况下，建议使用--quote-all-identifiers选项，
因为它可以防止在不同PostgreSQL版本中由于保留字列表的差异而导致的问题。
当导出逻辑复制订阅时，pg_dump会生成使用
connect = false选项的CREATE SUBSCRIPTION命令，
这样恢复订阅时不会为创建复制槽或初始表复制建立远程连接。这样，转储
可以在不需要访问远程服务器网络的情况下恢复。然后由用户以合适的方式
重新激活订阅。如果涉及的主机发生变化，连接信息可能需要更改。启动新的
全表复制前，截断目标表也可能是合适的。如果用户打算在刷新期间复制初始
数据，必须使用two_phase = false创建复制槽。初始同步后，
two_phase
选项如果订阅最初是用two_phase = true创建的，订阅者会自动
启用该选项。
通常建议在从纯文本pg_dump脚本恢复数据库时使用
-X(--no-psqlrc)选项，以确保恢复过程干净，
并防止与非默认psql配置发生潜在冲突。
实例
要把一个数据库 mydb 转储到一个 SQL 脚本文件：
$ pg_dump mydb > db.sql
要将这样的脚本重新加载到一个（新创建的）名为 newdb 的数据库中：
$ psql -X -d newdb -f db.sql
要转储一个数据库到一个自定义格式归档文件：
$ pg_dump -Fc mydb > db.dump
要转储一个数据库到一个目录格式的归档：
$ pg_dump -Fd mydb -f dumpdir
要用 5 个并行的工作任务转储一个数据库到一个目录格式的归档：
$ pg_dump -Fd mydb -j 5 -f dumpdir
要把一个归档文件重新载入到一个（新创建的）名为 newdb 的数据库：
$ pg_restore -d newdb db.dump
把一个归档文件重新装载到同一个数据库（该归档正是从这个数据库中转储得来）中，丢掉那个数据库中的当前内容：
$ pg_restore -d postgres --clean --create db.dump
要转储一个名为mytab的表：
$ pg_dump -t mytab mydb > db.sql
要转储detroit模式中名称以emp开始的所有表，排除名为employee_log的表：
$ pg_dump -t 'detroit.emp*' -T detroit.employee_log mydb > db.sql
要转储名称以east或者west开始并且以gsm结束的所有模式，排除名称包含词test的任何模式：
$ pg_dump -n 'east*gsm' -n 'west*gsm' -N '*test*' mydb > db.sql
同样，用正则表达式记号法来合并开关：
$ pg_dump -n '(east|west)*gsm' -N '*test*' mydb > db.sql
要转储除了名称以ts_开头的表之外的所有数据库对象：
$ pg_dump -T 'ts_*' mydb > db.sql
要在-t和相关开关中指定大写或混合大小写的名称，您需要用双引号
引住该名称；否则它将被折叠为小写（参见Patterns）。
但是，双引号对 shell 来说是特殊字符，因此它们也必须被转义。因此，要导出
一个具有混合大小写名称的单个表，您需要类似以下内容：
$ pg_dump -t "\"MixedCaseName\"" mydb > mytab.sql
导出所有名称以mytable开头的表，除了表mytable2，指定一个过滤文件
filter.txt，内容如下：
include table mytable*
exclude table mytable2
$ pg_dump --filter=filter.txt mydb > db.sql
参见pg_dumpall, pg_restore, psql上一页 上一级 下一页pg_config 起始页 pg_dumpall
