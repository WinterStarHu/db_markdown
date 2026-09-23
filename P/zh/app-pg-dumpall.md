# pg_dumpall

pg_dumpall
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_dumpallpg_dumpall — 将一个PostgreSQL数据库集群抽取到一个脚本文件中大纲pg_dumpall [connection-option...] [option...]描述
pg_dumpall是一个用于将集群中所有PostgreSQL数据库
写入（“dumping”）到一个脚本文件的实用程序。脚本文件包含
可以作为输入传递给psql以恢复数据库的SQL命令。
它通过为集群中的每个数据库调用pg_dump来实现这一点。
pg_dumpall还会转储对所有数据库通用的全局对象，
即数据库角色、表空间和配置参数的权限授予。
（pg_dump不保存这些对象。）
因为pg_dumpall从所有数据库中读取表，所以你很可能需要以一个数据库
超级用户的身份连接以便生成完整的转储。同样，你也需要超级用户特权执行保存下来的脚本，
这样才能增加角色和创建数据库。
SQL脚本将被写出到标准输出。使用-f/--file选项或者
shell操作符可以把它重定向到一个文件。
pg_dumpall需要多次连接到PostgreSQL服务器（每个数据库一次）。
如果你使用口令认证，可能每次都会要求口令。这种情况下使用一个~/.pgpass会比较方便。
详见第 32.16 节。
警告
恢复转储会导致目标执行源超级用户选择的任意代码。部分转储和部分恢复并不限制
这一点。如果源超级用户不可信，则必须在恢复之前检查转储的SQL语句。请注意，
运行转储和恢复的客户端不需要信任源或目标超级用户。
选项
以下命令行选项控制输出的内容和格式。
-a--data-only
仅转储数据，而不转储模式（数据定义）或统计信息。
-c--clean
发出SQL命令以在重新创建它们之前DROP所有已转储的数据库、角色和表空间。
当恢复是为了覆盖现有集群时，此选项很有用。
如果目标集群中不存在任何对象，则在恢复过程中将报告可忽略的错误消息，除非还指定了--if-exists。
-E encoding--encoding=encoding
在指定的字符集编码中创建转储。默认情况下，转储将以数据库编码创建。
（获得相同结果的另一种方法是将PGCLIENTENCODING环境变量设置为所需的转储编码。）
-f filename--file=filename
将输出发送到指定的文件。如果省略此选项，则使用标准输出。
-g--globals-only
仅转储全局对象（角色和表空间），不包括数据库。
-O--no-owner
不要输出命令来设置对象的所有权以匹配原始数据库。
默认情况下，pg_dumpall会发出
ALTER OWNER或
SET SESSION AUTHORIZATION语句来设置创建的模式元素的所有权。
当运行脚本时，这些语句将失败，除非由超级用户启动
（或拥有脚本中所有对象的相同用户）。
要创建一个可以被任何用户恢复的脚本，但会将
所有对象的所有权交给该用户，请指定-O。
-r--roles-only
仅转储角色，不包括数据库或表空间。
-s--schema-only
仅转储对象定义（模式），不包括数据。
-S username--superuser=username
指定在禁用触发器时要使用的超级用户用户名。
这仅在使用--disable-triggers时才相关。
（通常，最好将其省略，而是以超级用户身份启动生成的脚本。）
-t--tablespaces-only
仅转储表空间，不包括数据库或角色。
-v--verbose
指定详细模式。这将导致pg_dumpall将开始/停止时间输出到转储文件，
并将进度消息输出到标准错误。重复该选项会导致额外的调试级别消息出现在标准错误上。
该选项也会传递给pg_dump。
-V--version
打印pg_dumpall的版本并退出。
-x--no-privileges--no-acl
防止访问权限的泄露（grant/revoke命令）。
--binary-upgrade
此选项供就地升级实用程序使用。不建议或支持将其用于其他目的。该选项的行为可能在未来的版本中更改而不另行通知。
--column-inserts--attribute-inserts
将数据转储为带有显式列名的INSERT命令
(INSERT INTO
table
(column, ...) VALUES
...)。这将使恢复过程非常缓慢；主要用于创建可加载到非PostgreSQL数据库中的转储文件。
--disable-dollar-quoting
这个选项禁用了在函数体中使用美元引用的功能，并强制使用SQL标准字符串语法进行引用。
--disable-triggers
此选项仅在创建包含数据而不包含模式的转储时相关。它指示 pg_dumpall 包含命令，以在数据恢复期间暂时禁用目标表上的触发器。如果您在表上有引用完整性检查或其他不希望在数据恢复期间触发的触发器，请使用此选项。
目前，为了--disable-triggers选项发出的命令必须由超级用户执行。
因此，您还应该使用-S指定一个超级用户名称，或者最好小心地
以超级用户身份启动生成的脚本。
--exclude-database=pattern
不要转储名称匹配
pattern的数据库。
可以通过编写多个
--exclude-database开关来排除多个模式。
pattern参数根据
psql的\d
命令使用的相同规则解释（参见
Patterns），因此也可以通过在模式中
编写通配符来排除多个数据库。使用通配符时，请注意在必要时
引用模式以防止 shell 通配符扩展。
--extra-float-digits=ndigits
使用指定的extra_float_digits值来转储浮点数据，而不是使用最大可用精度。
为了备份目的而进行的例行转储不应该使用这个选项。
--filter=filename
指定一个文件名，从中读取用于排除导出数据库的模式。模式的解释规则与
--exclude-database相同。
要从STDIN读取，请使用-作为文件名。
--filter选项可以与--exclude-database一起
使用以排除数据库，也可以多次指定以使用多个过滤文件。
该文件每行列出一个数据库模式，格式如下：
exclude database PATTERN
以#开头的行被视为注释并且会被忽略。注释也可以放在对象模式行之后。
空白行同样会被忽略。请参见Patterns了解如何在模式中进行引用。
--if-exists
使用DROP ... IF EXISTS命令在--clean模式下删除对象。
这将抑制可能会报告的“不存在”错误。除非还指定了--clean，否则此选项无效。
--inserts
将数据转储为INSERT命令（而不是COPY）。
这将使恢复非常缓慢；主要用于创建可以加载到非PostgreSQL数据库中的转储文件。
请注意，如果您重新排列了列的顺序，恢复可能会完全失败。
--column-inserts选项更安全，尽管更慢。
--load-via-partition-root
当为表分区转储数据时，使COPY或INSERT语句
指向包含它的分区层次结构的根，而不是分区本身。这会导致在加载数据时为每一行重新确定适当的分区。
当在一个服务器上恢复数据时，这可能很有用，因为行不总是落入与原始服务器上相同的分区中。
例如，如果分区列是文本类型，并且两个系统对用于对分区列进行排序的排序规则的定义不同。
--lock-wait-timeout=timeout
不要在转储开始时永远等待获取共享表锁。相反，如果在指定的timeout内无法锁定表，则失败。
超时可以以SET statement_timeout接受的任何格式指定。
--no-comments
不转储COMMENT命令。
--no-data
不要转储数据。
--no-policies
不要转储行安全策略。
--no-publications
不要转储出版物。
--no-role-passwords
不要为角色转储密码。恢复时，角色将具有空密码，密码验证将始终失败，直到设置密码。
当指定此选项时，不需要密码值，角色信息将从目录视图pg_roles中读取，
而不是从pg_authid中读取。因此，如果某些安全策略限制对pg_authid的访问，
此选项也会有所帮助。
--no-schema
不要转储模式（数据定义）。
--no-security-labels
不要转储安全标签。
--no-statistics
不要转储统计信息。这是默认设置。
--no-subscriptions
不要转储订阅。
--no-sync
默认情况下，pg_dumpall将等待所有文件安全写入磁盘。
此选项导致pg_dumpall在不等待的情况下返回，这样更快，
但意味着随后的操作系统崩溃可能会导致转储文件损坏。通常，此选项在测试时很有用，
但在从生产安装中转储数据时不应使用。
--no-table-access-method
不要输出命令来选择表访问方法。
使用此选项，在恢复期间将使用默认的表访问方法创建所有对象。
--no-tablespaces
不要输出创建表空间的命令，也不要为对象选择表空间。
使用此选项，所有对象将在恢复期间默认的表空间中创建。
--no-toast-compression
不要输出命令来设置TOAST压缩方法。
使用此选项，所有列将以默认压缩设置恢复。
--no-unlogged-table-data
不要转储未记录表的内容。此选项不影响是否转储表定义（模式）；
它只是抑制转储表数据。
--on-conflict-do-nothing
在INSERT命令中添加ON CONFLICT DO NOTHING。
除非还指定了--inserts或--column-inserts，否则此选项无效。
--quote-all-identifiers
强制引用所有标识符。当从一个主版本与PostgreSQL不同的服务器转储数据库时，
或者当输出意图加载到一个不同主版本的服务器时，建议使用此选项。默认情况下，
pg_dumpall仅引用其自身主版本中的保留字标识符。
这有时会导致与其他版本服务器处理时出现兼容性问题，可能具有稍有不同的保留字集。
使用--quote-all-identifiers可以避免这些问题，但会导致转储脚本更难阅读。
--restrict-key=restrict_key
使用提供的字符串作为转储输出中的 psql
\restrict 键。如果未指定限制键，pg_dumpall 将根据需要生成一个随机键。键只能包含字母数字字符。
此选项主要用于测试目的和其他需要可重复输出的场景
（例如，比较转储文件）。不建议一般使用，因为一个
恶意服务器如果提前知道密钥，可能会注入任意代码，
该代码将在运行 psql 的机器上执行
并使用转储输出。
--rows-per-insert=nrows
将数据转储为INSERT命令（而不是COPY）。
控制每个INSERT命令的最大行数。指定的值必须是大于零的数字。
恢复过程中的任何错误将导致只有属于有问题的INSERT的行丢失，
而不是整个表的内容。
--statistics
转储优化器统计信息。
--statistics-only
仅转储统计信息，而不转储模式（数据定义）或数据。
表、物化视图、外部表和索引的优化器统计信息将被转储。
--sequence-data
在转储中包含序列数据。这是默认行为，除非
指定 --no-data、--schema-only 或
--statistics-only。
--use-set-session-authorization
输出SQL标准的SET SESSION AUTHORIZATION命令，而不是ALTER OWNER命令来确定对象所有权。
这使得转储更符合标准，但根据转储中对象的历史，可能无法正确恢复。
-?--help
显示关于pg_dumpall命令行参数的帮助信息，并退出。
下列命令行选项控制数据库连接参数。
-d connstr--dbname=connstr
指定用于连接到服务器的参数，比如连接字符串；这些将覆盖所有冲突的命令行选项。
这个选项被称为--dbname是为了和其他客户端应用一致，但是因为pg_dumpall需要连接多个数据库，连接字符串中的数据库名将被忽略。使用-l选项指定一个数据库，该数据库被用于初始连接，这将转储全局对象并且发现需要转储哪些其他数据库。
-h host--host=host
指定服务器正在运行的机器的主机名。如果该值开始于一个斜线，它被用作一个 Unix 域套接字的目录。默认是从PGHOST环境变量中取得（如果被设置），否则将尝试一次 Unix 域套接字连接。
-l dbname--database=dbname
指定要连接到哪个数据库转储全局对象以及发现要转储哪些其他数据库。如果没有指定，将会使用postgres数据库，如果postgres不存在，就使用 template1。
-p port--port=port
指定服务器正在监听连接的 TCP 端口或本地 Unix 域套接字文件扩展名。默认是放在PGPORT环境变量中（如果被设置），否则使用编译在程序中的默认值。
-U username--username=username
要作为哪个用户连接。
-w--no-password
从不发出一个口令提示。如果服务器要求口令认证并且没有其他方式提供口令（例如一个.pgpass文件），那儿连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W--password
强制pg_dumpall在连接到一个数据库之前提示要求一个口令。
这个选项从来不是必须的，因为如果服务器要求口令认证，pg_dumpall将自动提示要求一个口令。但是，pg_dumpall将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下，值得键入-W来避免额外的连接尝试。
注意对每个要被转储的数据库，口令提示都会再次出现。通常，最好设置一个~/.pgpass文件来减少手工口令输入。
--role=rolename
指定一个用来创建该转储的角色名。这个选项导致pg_dumpall在连接到数据库后发出一个SET ROLE rolename命令。当已认证用户（由-U指定）缺少pg_dumpall所需的特权但是能够切换到一个具有所需权利的角色时，这个选项很有用。一些安装有针对直接作为超级用户登录的策略，使用这个选项可以让转储在不违反该策略的前提下完成。
环境PGHOSTPGOPTIONSPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
备注
因为pg_dumpall在内部调用pg_dump，所以一些诊断消息会参考pg_dump。
即使当用户的目的是把转储脚本恢复到一个空的集簇中，--clean选项也有用武之地。--clean的使用让该脚本删除并重建内建的postgres和template1数据库，确保这两个数据库保持与源集簇中相同的属性（例如，locale和编码）。如果不用这个选项，这两个数据库将保持它们现有的数据库级属性以及任何已有的内容。
当指定--statistics时，pg_dumpall将会在生成的转储文件中包含大多数优化器统计信息。这并不包括所有统计信息，例如那些通过CREATE STATISTICS显式创建的统计信息、扩展添加的自定义统计信息或由累积统计系统收集的统计信息。因此，在从转储文件恢复后，运行ANALYZE以确保最佳性能仍然是有用的。您还可以运行vacuumdb -a -z来分析所有数据库。
不应该预期转储脚本运行到结束都不出错。特别是由于脚本将为源集簇中已有的每一个角色发出CREATE ROLE语句，对于bootstrap超级用户当然会得到一个“role already exists”错误，除非目标集簇用一个不同的bootstrap超级用户名完成初始化。这种错误是无害的并且应该被忽略。--clean选项的使用很可能会产生额外的关于不存在对象的无害错误消息，不过可以通过加上--if-exists减少这类错误消息。
pg_dumpall要求所有需要的表空间目录在进行恢复之前就必须存在；否则，数据库创建将会因为在非默认位置创建数据库而失败。
通常建议在从pg_dumpall脚本恢复数据库时使用
-X(--no-psqlrc)选项，以确保恢复过程干净
并防止与非默认psql配置的潜在冲突。此外，由于
pg_dumpall脚本可能包含
psql元命令，因此它可能与
psql以外的客户端不兼容。
示例
要转储所有数据库：
$ pg_dumpall > db.out
要从此文件中恢复数据库，可以使用：
$ psql -X -f db.out -d postgres
在这里连接到哪个数据库并不重要，因为由
pg_dumpall创建的脚本文件将包含创建和连接到
保存的数据库的适当命令。例外情况是，如果您指定了--clean，
则必须最初连接到postgres数据库；脚本将尝试立即删除
其他数据库，而这将对您当前连接的数据库失败。
另请参阅
详细信息请查看pg_dump。
上一页 上一级 下一页pg_dump 起始页 pg_isready
