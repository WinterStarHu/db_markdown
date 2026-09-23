# CREATE DATABASE

CREATE DATABASE
版本：
纠错本页面
搜索
目录导航
❮
❯
CREATE DATABASECREATE DATABASE — 创建一个新数据库大纲
CREATE DATABASE name
[ WITH ] [ OWNER [=] user_name ]
[ TEMPLATE [=] template ]
[ ENCODING [=] encoding ]
[ STRATEGY [=] strategy ]
[ LOCALE [=] locale ]
[ LC_COLLATE [=] lc_collate ]
[ LC_CTYPE [=] lc_ctype ]
[ BUILTIN_LOCALE [=] builtin_locale ]
[ ICU_LOCALE [=] icu_locale ]
[ ICU_RULES [=] icu_rules ]
[ LOCALE_PROVIDER [=] locale_provider ]
[ COLLATION_VERSION = collation_version ]
[ TABLESPACE [=] tablespace_name ]
[ ALLOW_CONNECTIONS [=] allowconn ]
[ CONNECTION LIMIT [=] connlimit ]
[ IS_TEMPLATE [=] istemplate ]
[ OID [=] oid ]
描述
CREATE DATABASE 创建一个新的
PostgreSQL 数据库。
要创建一个数据库，你必须是超级用户或具有特殊的
CREATEDB 特权。
见 CREATE ROLE。
默认情况下，新数据库将通过克隆标准系统数据库 template1 被创建。可以通过写 TEMPLATE
name 指定一个不同的模板。特别地，通过写 TEMPLATE template0，你可以创建一个原始的数据库（其中没有用户定义的对象存在并且系统对象没有被更改），它将只包含你的 PostgreSQL 版本所预定义的标准对象。如果你希望避免拷贝任何可能被加入到 template1 中的本地安装对象，这将有所帮助。
参数name #
要创建的数据库名称。
user_name #
将拥有新数据库的用户的角色名称，或者DEFAULT以使用默认值
（即执行命令的用户）。要创建由其他角色拥有的数据库，您必须能够
SET ROLE切换到该角色。
template #
要从其创建新数据库的模板名称，或者用DEFAULT来使用默认模板（template1）。
encoding #
要在新数据库中使用的字符集编码。指定一个字符串常量（例如'SQL_ASCII'），或者一个整数编码编号，或者DEFAULT来使用默认的编码（即，模板数据库的编码）。PostgreSQL服务器所支持的字符集在第 23.3.1 节中描述。附加限制见下文。
strategy #
创建新数据库时使用的策略。如果使用 WAL_LOG 策略，
数据库将逐块复制，每块将单独写入预写日志。这是在模板数据库较小的情况下
最有效的策略，因此它是默认策略。较旧的 FILE_COPY 策略也可用。
此策略为目标数据库使用的每个表空间在预写日志中写入一个小记录。
每个这样的记录表示将整个目录复制到文件系统级别的新位置。
尽管这确实显著减少了预写日志的体积，尤其是当模板数据库较大时，
但它也迫使系统在创建新数据库之前和之后执行检查点。
在某些情况下，这可能对整体系统性能产生明显的负面影响。
FILE_COPY 策略受 file_copy_method 设置的影响。
locale #
设置新数据库中的默认排序规则和字符分类。排序规则影响字符串的排序顺序，
例如，在带有ORDER BY的查询中，以及文本列索引中使用的顺序。
字符分类影响字符的分类，例如，小写、大写和数字。还设置操作系统环境的相关
方面，LC_COLLATE和LC_CTYPE。默认设置与
模板数据库相同。详情请参阅第 23.2.2.3.1 节和
第 23.2.2.3.2 节。
可以通过单独设置 lc_collate, lc_ctype, builtin_locale, 或 icu_locale 来覆盖。
如果 locale_provider 是
builtin，则必须指定 locale 或
builtin_locale 并设置为
C、C.UTF-8 或
PG_UNICODE_FAST 之一。
提示
其他语言环境设置 lc_messages, lc_monetary,
lc_numeric, 和 lc_time 不是每个数据库固定的，
也不是由该命令设置的。
如果要将它们设置为特定数据库的默认值，则可以使用 ALTER DATABASE
... SET。
lc_collate #
在数据库服务器的操作系统环境中设置 LC_COLLATE。默认值是
locale 的设置（如果指定），否则与模板
数据库的设置相同。请参阅下文了解其他限制。
如果 locale_provider 是
libc，还会设置新数据库中使用的默认排序规则，
覆盖设置 locale。
lc_ctype #
在数据库服务器的操作系统环境中设置 LC_CTYPE。默认值是
locale 的设置（如果指定），否则与模板
数据库的设置相同。请参阅下文了解其他限制。
如果 locale_provider 是
libc，还会设置新数据库中使用的默认字符分类，
覆盖设置 locale。
builtin_locale #
指定数据库默认排序规则和字符分类的内置提供程序区域设置，覆盖设置
locale。
区域设置提供程序 必须是 builtin。默认值是 locale 的设置（如果指定）；否则与模板数据库的设置相同。
可用于 builtin 提供者的区域设置有
C、C.UTF-8 和
PG_UNICODE_FAST。
icu_locale #
指定 ICU 区域设置（参见 第 23.2.2.3.2 节）作为数据库默认的排序规则和字符分类，
覆盖 locale 的设置。区域设置提供程序 必须是 ICU。默认值
是 locale 的设置（如果指定）；否则与模板数据库
的设置相同。
icu_rules #
指定附加的排序规则以自定义此数据库默认排序的行为。这仅支持
ICU。详情请参见第 23.2.3.4 节。
locale_provider #
指定用于此数据库默认排序规则的提供程序。可能的值有builtin、
icu（如果服务器是使用 ICU 支持构建的）或
libc。默认情况下，提供程序与template相同。
详情请参见第 23.1.4 节。
collation_version #
指定要存储在数据库中的排序版本字符串。
通常，应该省略此选项，这将导致版本根据操作系统提供的数据库排序的实际版本进行计算。
此选项旨在供pg_upgrade使用，用于从现有安装中复制版本。
参见ALTER DATABASE，了解如何处理数据库排序规则版本不匹配的情况。
tablespace_name #
将与新数据库相关联的表空间名称，或者DEFAULT来使用模板数据库的表空间。这个表空间将是在这个数据库中创建的对象的表空间。详见CREATE TABLESPACE。
allowconn #
如果为假，则没有人能连接到这个数据库。默认为真，表示允许连接（除了
被其他机制约束以外，例如GRANT/REVOKE CONNECT）。
connlimit #
这个数据库允许多少并发连接。-1（默认值）表示没有限制。
istemplate #
如果为真，则任何具有CREATEDB特权的用户都可以从
这个数据库克隆。如果为假（默认），则只有超级用户或者该数据库的拥有者
可以克隆它。
oid #
用于新数据库的对象标识符。如果未指定此参数，PostgreSQL
将自动选择一个合适的OID。此参数主要用于pg_upgrade内部使用，
只有pg_upgrade可以指定小于16384的值。
可选的参数可以以任何顺序书写，而不仅仅是上面说明的顺序。
备注
CREATE DATABASE不能在一个事务块内执行。
带有一行“不能初始化数据库目录”的错误大部分与数据目录权限不足、磁盘满或其他文件系统问题有关。
使用DROP DATABASE来移除一个数据库。
程序createdb是这个命令的一个包装程序，为了方便使用而提供。
数据库级配置参数（通过ALTER DATABASE设置）和数据库级权限（通过
GRANT设置）不会从模板数据库中复制。
尽管可以通过指定一个数据库作为模板来从其中而不是template1复制，这（还）不是“COPY DATABASE”功能的一般目的。主要的限制是在模板数据库被拷贝期间其他会话不能连接到它。如果CREATE DATABASE启动时还存在任何其他连接，它将失败。否则，到模板数据库的新连接将被锁定，直到CREATE DATABASE完成。详见第 22.3 节。
为新数据库指定的字符集编码必须与选定的区域设置（LC_COLLATE和LC_CTYPE）相兼容。如果区域是C（或者等效的POSIX），那么所有编码都被允许，但是对于其他区域设置只有一种编码能正确工作（不过，在 Windows 上 UTF-8 编码能够与任何区域一起使用）。CREATE DATABASE将允许超级用户指定SQL_ASCII编码而不管区域设置，但是这种选择已被废弃并且可能在数据与数据库中存储的区域不是编码兼容时导致字符串函数行为失当。
编码和区域设置必须匹配模板数据库的编码和区域，除非template0被用作模板。这是因为其他数据库可能包含不匹配指定编码的数据，或者可能包含排序顺序受LC_COLLATE和LC_CTYPE影响的索引。拷贝这种数据将导致一个由于该新设置而损坏的数据库。不过，template0是不会含有任何可能被影响的数据或索引的。
目前没有选项可以使用数据库区域设置进行非确定性比较（请参见CREATE
COLLATION以获取解释）。如果需要这样做，那么需要使用逐列排序规则。
CONNECTION LIMIT选项大概是唯一会被强制的，如果两个新会话在大约同一时间开始并且那时该数据库只剩有一个连接“槽”，可能两者都会失败。还有，该限制对超级用户或后台工作进程无效。
示例
要创建一个新数据库：
CREATE DATABASE lusiadas;
要在一个默认表空间salesspace中创建一个被用户salesapp拥有的新数据库sales：
CREATE DATABASE sales OWNER salesapp TABLESPACE salesspace;
要用不同的语言环境创建数据库music：
CREATE DATABASE music
LOCALE 'sv_SE.utf8'
TEMPLATE template0;
在这个例子中，如果指定的语言环境与template1中的语言环境不同，
则需要TEMPLATE template0子句。（如果不是，则明确指定语言环境是多余的。）
要用不同的语言环境和不同的字符集编码创建数据库music2：
CREATE DATABASE music2
LOCALE 'sv_SE.iso885915'
ENCODING LATIN9
TEMPLATE template0;
指定的语言环境和编码设置必须匹配，否则会报告错误。
请注意，语言环境名称是特定于操作系统的，
因此上述命令可能无法在任何地方以相同的方式工作。
兼容性
在 SQL 标准中没有CREATE DATABASE语句。数据库等效于目录，而目录的创建由实现定义。
参见ALTER DATABASE, DROP DATABASE上一页 上一级 下一页CREATE CONVERSION 起始页 CREATE DOMAIN
