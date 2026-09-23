# pg_restore

pg_restore
版本：
纠错本页面
搜索
目录导航
❮
❯
pg_restorepg_restore —
从一个由pg_dump创建的归档文件恢复一个PostgreSQL数据库
大纲pg_restore [connection-option...] [option...] [filename]描述
pg_restore是一个用来从pg_dump创建的非纯文本格式归档恢复PostgreSQL数据库的工具。它将发出必要的命令把该数据库重建成它被保存时的状态。这些归档文件还允许pg_restore选择恢复哪些内容或者在恢复前对恢复项重排序。这些归档文件被设计为可以在不同的架构之间迁移。
pg_restore可以在两种模式下操作。如果指定了一个数据库名称，pg_restore会连接那个数据库并且把归档内容直接恢复到该数据库中。否则，会创建一个脚本，其中包含重建该数据库所必要的 SQL 命令，它会被写入到一个文件或者标准输出。这个脚本输出等效于pg_dump的纯文本输出格式。因此，一些控制输出的选项与pg_dump的选项类似。
显然，pg_restore无法恢复不在归档文件中的信息。例如，如果归档使用“以INSERT命令转储数据”选项创建，pg_restore将无法使用COPY语句装载数据。
警告
恢复转储会导致目标执行源超级用户选择的任意代码。部分转储和部分恢复并不限制这一点。如果源超级用户不受信任，则必须在恢复之前检查转储的 SQL 语句。可以使用pg_restore的--file选项检查非纯文本转储。请注意，运行转储和恢复的客户端不需要信任源或目标超级用户。
选项
pg_restore接受以下命令行参数。
filename
指定要恢复的存档文件（或目录，对于目录格式的存档）的位置。
如果未指定，则使用标准输入。
-a--data-only
仅恢复数据，不恢复模式（数据定义）或统计信息。
表数据、大对象和序列值会被恢复，
如果它们存在于归档中。
这个选项类似于，但出于历史原因并不完全相同于，指定--section=data。
-c--clean
在恢复数据库对象之前，发出命令以DROP所有将被恢复的对象。
此选项对覆盖现有数据库很有用。
如果目标数据库中不存在任何对象，则会报告可忽略的错误消息，
除非还指定了--if-exists。
-C--create
在恢复之前创建数据库。
如果还指定了--clean选项，则在连接到目标数据库之前删除并重新创建它。
使用--create选项，pg_restore
还会恢复数据库的注释（如果有的话），以及特定于此数据库的任何配置变量设置，
也就是任何提及此数据库的ALTER DATABASE ... SET ...
和ALTER ROLE ... IN DATABASE ... SET ...命令。
除非指定了--no-acl，否则还会恢复数据库本身的访问权限。
当使用此选项时，仅使用名为-d的数据库来发出初始的DROP DATABASE和CREATE DATABASE命令。
所有数据都将恢复到存档中显示的数据库名称中。
-d dbname--dbname=dbname
连接到数据库dbname并直接恢复到数据库中。
dbname可以是一个连接字符串。
如果是这样，连接字符串参数将覆盖任何冲突的命令行选项。
-e--exit-on-error
如果在向数据库发送SQL命令时遇到错误，则退出。默认情况下会继续执行，并在恢复结束时显示错误计数。
-f filename--file=filename
指定生成脚本的输出文件，或者与-l一起使用时用于列表的文件。
使用-代表stdout。
-F format--format=format
指定存档的格式。不需要指定格式，因为pg_restore会自动确定格式。
如果指定，可以是以下之一：
ccustom
存档是pg_dump的自定义格式。
ddirectory
存档是一个目录存档。
ttar
存档是一个tar存档。
-I index--index=index
仅恢复命名索引的定义。可以使用多个-I开关指定多个索引。
-j number-of-jobs--jobs=number-of-jobs
运行pg_restore中最耗时的步骤 — 即加载数据、
创建索引或创建约束 — 并发地，使用最多number-of-jobs
个并发会话。这个选项可以显著减少将大型数据库恢复到运行在多处理器机器上的服务器上所需的时间。
当生成脚本而不是直接连接到数据库服务器时，此选项将被忽略。
每个作业是一个进程或一个线程，取决于操作系统，并使用一个独立的连接到服务器。
该选项的最佳值取决于服务器、客户端和网络的硬件设置。因素包括CPU核心数量和磁盘设置。
一个好的起点是服务器上的CPU核心数量，但在许多情况下，更大的值也可以导致更快的恢复时间。
当然，值过高会因为抖动而导致性能下降。
仅支持使用此选项的自定义和目录存档格式。
输入必须是常规文件或目录（例如，不是管道或标准输入）。
此外，无法与选项--single-transaction一起使用多个作业。
-l--list
列出存档的目录。此操作的输出可用作-L选项的输入。请注意，
如果与-l一起使用过滤开关，如-n或-t，
它们将限制所列项目。
-L list-file--use-list=list-file
仅还原列在list-file中的存档元素，并按照它们在文件中出现的顺序进行还原。请注意，如果与-L一起使用过滤开关，如-n或-t，它们将进一步限制所还原的项目。
list-file通常是通过编辑先前-l操作的输出创建的。
可以移动或删除行，也可以通过在行首放置分号（;）进行注释。
请参见下面的示例。
-n schema--schema=schema
仅还原位于指定模式中的对象。可以使用多个-n开关指定多个模式。
这可以与-t选项结合使用，仅还原特定表。
-N schema--exclude-schema=schema
不要恢复位于指定模式中的对象。可以使用多个-N开关指定要排除的多个模式。
当为同一模式名称同时指定-n和-N时，
-N开关胜出，该模式将被排除。
-O--no-owner
不要输出命令来设置对象的所有权以匹配原始数据库。
默认情况下，pg_restore会发出
ALTER OWNER或
SET SESSION AUTHORIZATION语句来设置创建的模式元素的所有权。
这些语句将失败，除非对数据库的初始连接是由超级用户
（或拥有脚本中所有对象的相同用户）进行的。
使用-O，可以使用任何用户名进行初始连接，并且此用户将拥有所有创建的对象。
-P function-name(argtype [, ...])--function=function-name(argtype [, ...])
仅还原指定的函数。请小心拼写函数名和参数，确保与转储文件目录中的内容完全一致。
可以使用多个-P开关指定多个函数。
-R--no-reconnect
该选项已经过时，但仍然被接受以保持向后兼容性。
-s--schema-only
仅恢复模式（数据定义），而不是数据，只要存档中存在模式条目。
此选项不能与 --data-only
或 --statistics-only 一起使用。
它与指定
--section=pre-data --section=post-data --no-statistics
类似，但由于历史原因并不完全相同。
(不要将此与--schema选项混淆，该选项使用单词“schema”具有不同的含义。)
-S username--superuser=username
指定超级用户用户名以在禁用触发器时使用。
这仅在使用--disable-triggers时才相关。
-t table--table=table
恢复仅指定表的定义和/或数据。
为此，“table”包括视图、物化视图、序列和外部表。可以通过写多个
-t开关来选择多个表。此选项可以与-n选项结合使用，
以指定特定模式中的表。
注意
当指定-t选项时，pg_restore
不会尝试恢复所选表可能依赖的任何其他数据库对象。因此，不能保证将特定表还原到干净数据库中会成功。
注意
这个标志与-t标志的pg_dump的行为不完全相同。
pg_restore目前没有通配符匹配的功能，
也不能在pg_restore的-t中包含模式名称。
而pg_dump的-t标志还会导出所选表的附属对象（如索引），
pg_restore的-t标志不包括这些附属对象。
注意
在PostgreSQL 9.6之前的版本中，此标志仅匹配表，而不匹配任何其他类型的关系。
-T trigger--trigger=trigger
仅恢复命名触发器。可以使用多个-T开关指定多个触发器。
-v--verbose
指定详细模式。这将导致pg_restore将详细的对象注释和开始/停止时间输出到输出文件，并将进度消息输出到标准错误。
重复该选项会导致额外的调试级别消息出现在标准错误上。
-V--version
打印pg_restore版本并退出。
-x--no-privileges--no-acl
防止恢复访问权限（授予/撤销命令）。
-1--single-transaction
将恢复操作作为一个单独的事务执行（即，在BEGIN/COMMIT中包装发出的命令）。
这样可以确保要么所有命令成功完成，要么不应用任何更改。此选项意味着
--exit-on-error。
--disable-triggers
此选项仅在执行不带模式的恢复时相关。
它指示pg_restore执行命令
在恢复数据时暂时禁用目标表上的触发器。
如果您在表上有引用完整性检查或其他触发器，
而您不希望在数据恢复期间触发它们，请使用此选项。
目前，为--disable-triggers发出的命令必须由超级用户执行。
因此，您还应该使用-S指定一个超级用户名称，或者更好地，
以pg_restore作为PostgreSQL超级用户运行。
--enable-row-security
该选项仅在恢复具有行安全性的表的内容时才相关。默认情况下，pg_restore将设置
row_security为off，以确保所有数据都被恢复到表中。如果用户没有足够的权限来绕过行安全性，则会抛出错误。
此参数指示pg_restore将row_security设置为on，允许用户尝试恢复
启用行安全性的表的内容。如果用户没有权限将转储中的行插入到表中，这仍可能失败。
请注意，此选项目前还要求转储以INSERT格式进行，因为COPY FROM不支持行安全性。
--filter=filename
指定一个文件名，从中读取用于排除或包含恢复对象的模式。模式的解释规则与
-n/--schema 用于包含模式中的对象、
-N/--exclude-schema 用于排除模式中的对象、
-P/--function 用于恢复指定函数、
-I/--index 用于恢复指定索引、
-t/--table 用于恢复指定表、
或 -T/--trigger 用于恢复触发器的规则相同。
若要从 STDIN 读取，请使用 - 作为文件名。
--filter 选项可以与上述用于包含或排除对象的选项一起指定，
并且可以多次指定以使用多个过滤文件。
该文件每行列出一个数据库模式，格式如下：
{ include | exclude } { function | index | schema | table | trigger } PATTERN
第一个关键字指定模式匹配的对象是包含还是排除。第二个关键字指定使用模式过滤的对象类型：
function：函数，作用类似于-P/--function选项。
该关键字只能与include关键字一起使用。
index：索引，作用类似于-I/--indexes选项。
该关键字只能与include关键字一起使用。
schema：模式，作用类似于-n/--schema和
-N/--exclude-schema选项。
table：表，作用类似于-t/--table选项。
该关键字只能与include关键字一起使用。
trigger：触发器，作用类似于-T/--trigger选项。
该关键字只能与include关键字一起使用。
以#开头的行被视为注释并且会被忽略。注释也可以放在对象模式行之后。
空白行同样会被忽略。请参见Patterns了解如何在模式中进行引用。
--if-exists
使用DROP ... IF EXISTS命令在--clean模式下删除对象。
这将抑制可能会报告的“不存在”错误。除非还指定了--clean，否则此选项无效。
--no-comments
不要输出命令来恢复注释，即使存档中包含它们。
--no-data
不要输出命令来恢复数据，即使归档中包含它们。
--no-data-for-failed-tables
默认情况下，即使表的创建命令失败（例如，因为表已经存在），表数据也会被恢复。
使用此选项，将跳过这样一个表的数据。
如果目标数据库已经包含所需的表内容，则此行为很有用。例如，
PostgreSQL扩展的辅助表
（如PostGIS）可能已经加载到目标数据库中；
指定此选项可防止重复或过时的数据被加载到其中。
该选项仅在直接恢复到数据库时有效，而不在生成SQL脚本输出时有效。
--no-policies
不要输出命令来恢复行安全策略，即使归档中包含它们。
--no-publications
不要输出命令来恢复出版物，即使存档中包含它们。
--no-schema
不要输出命令来恢复模式（数据定义），即使归档中包含它们。
--no-security-labels
不要输出命令来恢复安全标签，即使存档中包含它们。
--no-statistics
不输出恢复统计信息的命令，即使归档中包含这些命令。
--no-subscriptions
不输出命令来恢复订阅，即使归档中包含它们。
--no-table-access-method
不输出选择表访问方法的命令。使用此选项时，所有对象将在恢复过程中采用默认的表访问方法进行创建。
--no-tablespaces
不输出选择表空间的命令。
使用此选项，所有对象将在恢复期间默认的表空间中创建。
--restrict-key=restrict_key
使用提供的字符串作为 psql
\restrict 键在转储输出中。 这只能在
SQL 脚本输出中指定，即，当使用 --file
选项时。如果未指定限制键，
pg_restore 将根据需要生成一个随机键。
键只能包含字母数字字符。
此选项主要用于测试目的和其他需要可重复输出的场景
（例如，比较转储文件）。不建议一般使用，因为一个
恶意服务器如果提前知道密钥，可能会注入任意代码，
该代码将在运行 psql 的机器上执行
并使用转储输出。
--section=sectionname
只恢复指定的部分。部分名称可以是pre-data、data或post-data。
可以多次指定此选项以选择多个部分。默认情况下恢复所有部分。
数据部分包含实际的表数据以及大对象定义。
数据后项包括索引、触发器、规则和除验证检查约束之外的约束的定义。
数据前项包括所有其他数据定义项。
--statistics
输出恢复统计信息的命令，如果归档中包含它们。
这是默认设置。
--statistics-only
仅恢复统计信息，不恢复模式（数据定义）或数据。
--strict-names
要求每个模式
(-n/--schema) 和表
(-t/--table) 限定符至少与
要恢复的文件中的一个模式/表匹配。
--transaction-size=N
以一系列事务执行恢复，每个事务处理最多
N 个数据库对象。此选项意味着
--exit-on-error。
--transaction-size 提供了一个介于默认行为（每个 SQL 命令一个事务）
和 -1/--single-transaction（所有恢复对象共用一个事务）
之间的中间选择。
虽然 --single-transaction 的开销最小，但对于大型数据库可能不切实际，
因为事务会对每个恢复对象加锁，可能会耗尽服务器的锁表空间。
使用 --transaction-size 并设置为几千个对象的大小，
可以提供几乎相同的性能优势，同时限制所需的锁表空间量。
--use-set-session-authorization
输出SQL标准的SET SESSION AUTHORIZATION命令，而不是ALTER OWNER命令来确定对象所有权。
这样做可以使转储更符合标准，但根据转储中对象的历史，可能无法正确恢复。
-?--help
显示关于pg_restore命令行参数的帮助信息，并退出。
pg_restore也接受下列用于连接参数的命令行参数：
-h host--host=host
指定服务器正在运行的机器的主机名。如果该值开始于一个斜线，它被用作一个 Unix 域套接字的目录。默认是从PGHOST环境变量中取得（如果被设置），否则将尝试一次 Unix 域套接字连接。
-p port--port=port
指定服务器正在监听连接的 TCP 端口或本地 Unix 域套接字文件扩展名。默认是放在PGPORT环境变量中（如果被设置），否则使用编译在程序中的默认值。
-U username--username=username
要作为哪个用户连接。
-w--no-password
不发出一个口令提示。如果服务器要求口令认证并且没有其他方式提供口令（例如一个.pgpass文件），那么连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W--password
强制pg_restore在连接到一个数据库之前提示要求一个口令。
这个选项不是必须的，因为如果服务器要求口令认证，pg_restore将自动提示要求一个口令。但是，pg_restore将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下，值得键入-W来避免额外的连接尝试。
--role=rolename
指定一个用来执行恢复的角色名。这个选项导致pg_restore在连接到数据库后发出一个SET ROLE rolename命令。当已认证用户（由-U指定）缺少pg_restore所需的特权但是能够切换到一个具有所需权利的角色时，这个选项很有用。一些安装有针对直接作为超级用户登录的策略，使用这个选项可以让恢复在不违反该策略的前提下完成。
环境PGHOSTPGOPTIONSPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。然而，当未提供数据库名称时，它不会读取PGDATABASE。
诊断
当使用-d选项指定一个直接数据库连接时，pg_restore在内部执行SQL语句。如果你运行pg_restore时出现问题，确保你能够从数据库中选择信息，例如psql。此外，libpq前端库所使用的任何默认连接设置和环境变量都将适用。
备注
如果你的安装对template1数据库有任何本地添加，要注意将pg_restore的输出载入到一个真正的空数据库；否则你很可能由于增加对象的重复定义而得到错误。要创建一个不带任何本地添加的空数据库，从template0而不是template1复制它，例如：
CREATE DATABASE foo WITH TEMPLATE template0;
下面将详细介绍pg_restore的局限性。
在恢复数据到一个已经存在的表中并且使用了选项--disable-triggers时，pg_restore会在插入数据之前发出命令禁用用户表上的触发器，然后在完成数据插入后重新启用它们。如果恢复在中途停止，可能会让系统目录处于错误的状态。
pg_restore不能有选择地恢复大对象，例如只恢复特定表的大对象。如果一个归档包含大对象，那么所有的大对象都会被恢复，如果通过-L、-t或者其他选项进行了排除，它们一个也不会被恢复。
pg_dump的局限性详见pg_dump文档。
默认情况下，pg_restore将恢复优化器统计信息
如果包含在转储文件中。如果没有恢复所有统计信息，
在每个恢复的表上运行ANALYZE可能会很有用，
以便优化器拥有有用的统计信息；有关更多信息，请参见第 24.1.3 节和第 24.1.6 节。
示例
假设我们已经以自定义格式转储了一个叫做mydb的数据库：
$ pg_dump -Fc mydb > db.dump
要删除该数据库并从转储中重新创建它：
$ dropdb mydb
$ pg_restore -C -d postgres db.dump
-d开关中提到的数据库可以是任何已经存在于集簇中的数据库，pg_restore只会用它来为mydb发出CREATE DATABASE命令。通过-C，数据总是会被恢复到出现在归档文件的数据库名中。
要将转储还原到名为newdb的新数据库中：
$ createdb -T template0 newdb
$ pg_restore -d newdb db.dump
请注意，我们不使用-C，而是直接连接到要还原的数据库。
还要注意，我们是从template0而不是template1克隆新数据库，
以确保它最初是空的。
要对数据库项重排序，首先需要转储归档的表内容：
$ pg_restore -l db.dump > db.list
列表文件由一个头部和一些行组成，这些行每一个都用于一个项，例如：
;
; Archive created at Mon Sep 14 13:55:39 2009
;     dbname: DBDEMOS
;     TOC Entries: 81
;     Compression: 9
;     Dump Version: 1.10-0
;     Format: CUSTOM
;     Integer: 4 bytes
;     Offset: 8 bytes
;     Dumped from database version: 8.3.5
;     Dumped by pg_dump version: 8.3.8
;
;
; Selected TOC Entries:
;
3; 2615 2200 SCHEMA - public pasha
1861; 0 0 COMMENT - SCHEMA public pasha
1862; 0 0 ACL - public pasha
317; 1247 17715 TYPE public composite pasha
319; 1247 25899 DOMAIN public domain0 pasha
分号表示开始一段注释，行首的数字表明了分配给每个项的内部归档 ID。
文件中的行可以被注释掉、删除以及重排序。例如：
10; 145433 TABLE map_resolutions postgres
;2; 145344 TABLE species postgres
;4; 145359 TABLE nt_header postgres
6; 145402 TABLE species_records postgres
;8; 145416 TABLE ss_old postgres
把这样一个文件作为pg_restore的输入将会只恢复项 10 和 6，并且先恢复 10 再恢复 6。
$ pg_restore -L db.list db.dump
另见pg_dump, pg_dumpall, psql上一页 上一级 下一页pg_recvlogical 起始页 pg_verifybackup
