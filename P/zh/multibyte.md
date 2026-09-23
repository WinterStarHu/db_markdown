# 23.3. 字符集支持

23.3. 字符集支持
版本：
纠错本页面
搜索
目录导航
❮
❯
23.3. 字符集支持 #23.3.1. 支持的字符集23.3.2. 设置字符集23.3.3. 服务器和客户端之间的自动字符集转换23.3.4. 可用的字符集转换23.3.5. 进一步阅读
PostgreSQL中的字符集支持允许你以各种字符集存储文本（也称为编码），包括单字节字符集，如 ISO 8859 系列，以及多字节字符集，如 EUC（扩展 Unix 编码）、UTF-8 和 Mule 内部编码。所有支持的字符集都可以被客户端透明地使用，但有一些字符集不支持在服务器内部使用（即作为服务器端编码）。默认字符集是在使用 initdb 初始化你的 PostgreSQL 数据库集簇时选择的。在创建数据库时可以重载它，因此你可以拥有多个每个使用不同字符集的数据库。
但是，一个重要的限制是每个数据库的字符集必须与数据库的 LC_CTYPE （字符分类）和 LC_COLLATE （字符串排序顺序）区域设置兼容。对于 C 或 POSIX 区域，任何字符集都是允许的，但对于其他 libc 提供的区域，只有一种字符集可以正确工作。（不过，在 Windows 上，UTF-8 编码可以与任何区域配合使用。）如果你配置了 ICU 支持，则 ICU 提供的区域设置可以与大多数但不是所有服务器端编码一起使用。
23.3.1. 支持的字符集 #
表 23.3 显示了可用于 PostgreSQL 的字符集。
表 23.3. PostgreSQL 字符集名称描述语言是否服务器端？ICU?字节/​字符别名BIG5Big Five繁体中文否否1–2WIN950, Windows950EUC_CNExtended UNIX Code-CN简体中文是是1–3 EUC_JPExtended UNIX Code-JP日文是是1–3 EUC_JIS_2004Extended UNIX Code-JP, JIS X 0213日文是否1–3 EUC_KRExtended UNIX Code-KR韩文是是1–3 EUC_TWExtended UNIX Code-TW繁体中文，台湾是是1–4 GB18030国家标准中文否否1–4 GBK扩展国家标准简体中文否否1–2WIN936, Windows936ISO_8859_5ISO 8859-5, ECMA 113拉丁语/西里尔语是是1 ISO_8859_6ISO 8859-6, ECMA 114拉丁语/阿拉伯语是是1 ISO_8859_7ISO 8859-7, ECMA 118拉丁语/希腊语是是1 ISO_8859_8ISO 8859-8, ECMA 121拉丁语/希伯来语是是1 JOHABJOHAB韩文（Hangul）否否1–3 KOI8RKOI8-R西里尔语（俄语）是是1KOI8KOI8UKOI8-U西里尔语（乌克兰语）是是1 LATIN1ISO 8859-1, ECMA 94西欧是是1ISO88591LATIN2ISO 8859-2, ECMA 94中欧是是1ISO88592LATIN3ISO 8859-3, ECMA 94南欧是是1ISO88593LATIN4ISO 8859-4, ECMA 94北欧是是1ISO88594LATIN5ISO 8859-9, ECMA 128土耳其语是是1ISO88599LATIN6ISO 8859-10, ECMA 144北欧语言是是1ISO885910LATIN7ISO 8859-13波罗的海是是1ISO885913LATIN8ISO 8859-14凯尔特语是是1ISO885914LATIN9ISO 8859-15带欧元符号和口音的LATIN1是是1ISO885915LATIN10ISO 8859-16, ASRO SR 14111罗马尼亚语是否1ISO885916MULE_INTERNALMule内部编码多语言Emacs是否1–4 SJISShift JIS日语否否1–2Mskanji, ShiftJIS, WIN932, Windows932SHIFT_JIS_2004Shift JIS, JIS X 0213日语否否1–2 SQL_ASCII未指定（见文本）任意是否1 UHC统一韩文编码韩语否否1–2WIN949, Windows949UTF8Unicode, 8-bit所有是是1–4UnicodeWIN866Windows CP866西里尔文是是1ALTWIN874Windows CP874泰文是否1 WIN1250Windows CP1250中欧语言是是1 WIN1251Windows CP1251西里尔文是是1WINWIN1252Windows CP1252西欧语言是是1 WIN1253Windows CP1253希腊文是是1 WIN1254Windows CP1254土耳其文是是1 WIN1255Windows CP1255希伯来文是是1 WIN1256Windows CP1256阿拉伯语是是1 WIN1257Windows CP1257波罗的海语是是1 WIN1258Windows CP1258越南语是是1ABC, TCVN, TCVN5712, VSCII
并非所有的客户端API都支持上面列出的字符集。比如，PostgreSQL的JDBC驱动就不支持MULE_INTERNAL、LATIN6、LATIN8和LATIN10。
SQL_ASCII设置与其他设置表现得相当不同。
如果服务器字符集是SQL_ASCII，服务器把字节值0–127根据ASCII标准解释，而字节值128–255则当作无法解析的字符。
如果设置为SQL_ASCII，就不会有编码转换。因此，这个设置基本不是用来声明所使用的指定编码，因为这个声明会忽略编码。
在大多数情况下，如果你使用了任何非ASCII数据，那么使用SQL_ASCII设置都是不明智的，因为PostgreSQL将无法帮助你转换或者校验非ASCII字符。
23.3.2. 设置字符集 #
initdb为一个PostgreSQL集簇定义缺省的字符集（编码）。比如：
initdb -E EUC_JP
把缺省字符集设置为EUC_JP（用于日文的扩展Unix编码）。如果你喜欢用长选项字符串，你可以用--encoding代替-E。 如果没有给出-E或者--encoding选项，initdb会尝试基于指定的或者默认的区域判断要使用的合适编码。
你可以在数据库创建时指定一个非默认编码，提供的编码应和选择的区域兼容：
createdb -E EUC_KR -T template0 --lc-collate=ko_KR.euckr --lc-ctype=ko_KR.euckr korean
将创建一个使用EUC_KR字符集和ko_KR区域的名为korean的数据库。 另外一种实现方法是使用SQL命令：
CREATE DATABASE korean WITH ENCODING 'EUC_KR' LC_COLLATE='ko_KR.euckr' LC_CTYPE='ko_KR.euckr' TEMPLATE=template0;
注意上述命令指定拷贝template0数据库。在拷贝任何其他数据库时，不能更改从源数据库得来的编码和区域设置，因为这可能会导致破坏数据。详见第 22.3 节。
数据库的编码存储在系统目录pg_database中。您可以通过使用psql -l选项或\l命令来查看。
$ psql -l
List of databases
Name    |  Owner   | Encoding  |  Collation  |    Ctype    |          Access Privileges
-----------+----------+-----------+-------------+-------------+-------------------------------------
clocaledb | hlinnaka | SQL_ASCII | C           | C           |
englishdb | hlinnaka | UTF8      | en_GB.UTF8  | en_GB.UTF8  |
japanese  | hlinnaka | UTF8      | ja_JP.UTF8  | ja_JP.UTF8  |
korean    | hlinnaka | EUC_KR    | ko_KR.euckr | ko_KR.euckr |
postgres  | hlinnaka | UTF8      | fi_FI.UTF8  | fi_FI.UTF8  |
template0 | hlinnaka | UTF8      | fi_FI.UTF8  | fi_FI.UTF8  | {=c/hlinnaka,hlinnaka=CTc/hlinnaka}
template1 | hlinnaka | UTF8      | fi_FI.UTF8  | fi_FI.UTF8  | {=c/hlinnaka,hlinnaka=CTc/hlinnaka}
(7 rows)
重要
在大部分现代操作系统上，PostgreSQL可以判断LC_CTYPE设置意味着哪一种字符集，并且它强制只有匹配的数据库编码被使用。在旧的系统上你需要自己负责确保所使用的编码就是你所选择的区域所期望的。在这里的一个错误很可能导致区域依赖的操作产生奇怪的行为，例如排序。
即使LC_CTYPE不是C或POSIX时，PostgreSQL将允许超级用户使用SQL_ASCII编码创建数据库。正如前文所述，SQL_ASCII并不强制存储在数据库中的数据具有任何特定的编码，并且这种选择存在着区域依赖的不正当行为的风险。使用这种设置组合的做法已经被废弃，并且在某天将被完全禁止。
23.3.3. 服务器和客户端之间的自动字符集转换 #
PostgreSQL支持服务器和客户端之间许多字符集组合的自动字符集转换（第 23.3.4 节 显示了哪些组合）。
要想启用自动字符集转换功能，你必须告诉PostgreSQL你想在客户端使用的字符集（编码）。你可以用好几种方法来完成：
用psql里的\encoding命令。\encoding允许你动态修改客户端编码。比如，把编码改变为SJIS，键入：
\encoding SJIS
libpq（第 32.11 节）中提供函数控制客户端编码。
使用SET client_encoding TO。
可以使用这个SQL命令设置客户端编码：
SET CLIENT_ENCODING TO 'value';
你还可以把标准SQL语法里的SET NAMES用于这个目的：
SET NAMES 'value';
要查询当前客户端编码：
SHOW client_encoding;
要返回到缺省编码：
RESET client_encoding;
使用PGCLIENTENCODING。如果在客户端的环境里定义了PGCLIENTENCODING环境变量， 那么在与服务器进行了连接后将自动选择客户端编码（这个设置随后可以用上文提到的任何其他方法重载）。
使用client_encoding配置变量。如果client_encoding变量被设置， 那么在与服务器建立了连接之后，这个客户端编码将被自动选定（这个设置随后可以用上文提到的其他方法重载）。
假如无法进行一个特定字符的转换 — 假如你选的服务器编码是EUC_JP而客户端是LATIN1，那么有些日文字符不能转换成LATIN1 — 将会报告一个错误。
如果客户端字符集定义成了SQL_ASCII，那么编码转换会被禁用，不管服务器的字符集是什么都一样。
（但是，如果服务器的字符集不是SQL_ASCII，服务器仍将检查传入数据是否对该编码有效;所以最终的效果是客户端字符集和服务器的字符集是一样的。）
和服务器一样，除非你的工作环境全部是ASCII数据，否则使用SQL_ASCII是不明智的。
23.3.4. 可用的字符集转换 #
PostgreSQL 允许在pg_conversion系统目录中列出的转换函数之间进行任何两个字符集的转换。
PostgreSQL 带了一些预定义的转换，概括在表 23.4中，并在表 23.5中显示更详细的信息。
你可以使用 SQL 命令CREATE CONVERSION建立一个新的转换。（要用于自动的客户端/服务器转换，该字符集组合的转换必须标记为“default”。
表 23.4. 内置客户端/服务器字符集转换服务器字符集可用的客户端字符集BIG5不支持作为服务器编码
EUC_CNEUC_CN,
MULE_INTERNAL,
UTF8
EUC_JPEUC_JP,
MULE_INTERNAL,
SJIS,
UTF8
EUC_JIS_2004EUC_JIS_2004,
SHIFT_JIS_2004,
UTF8
EUC_KREUC_KR,
MULE_INTERNAL,
UTF8
EUC_TWEUC_TW,
BIG5,
MULE_INTERNAL,
UTF8
GB18030不支持作为服务器编码
GBK不支持作为服务器编码
ISO_8859_5ISO_8859_5,
KOI8R,
MULE_INTERNAL,
UTF8,
WIN866,
WIN1251
ISO_8859_6ISO_8859_6,
UTF8
ISO_8859_7ISO_8859_7,
UTF8
ISO_8859_8ISO_8859_8,
UTF8
JOHAB不支持作为服务器编码
KOI8RKOI8R,
ISO_8859_5,
MULE_INTERNAL,
UTF8,
WIN866,
WIN1251
KOI8UKOI8U,
UTF8
LATIN1LATIN1,
MULE_INTERNAL,
UTF8
LATIN2LATIN2,
MULE_INTERNAL,
UTF8,
WIN1250
LATIN3LATIN3,
MULE_INTERNAL,
UTF8
LATIN4LATIN4,
MULE_INTERNAL,
UTF8
LATIN5LATIN5,
UTF8
LATIN6LATIN6,
UTF8
LATIN7LATIN7,
UTF8
LATIN8LATIN8,
UTF8
LATIN9LATIN9,
UTF8
LATIN10LATIN10,
UTF8
MULE_INTERNALMULE_INTERNAL,
BIG5,
EUC_CN,
EUC_JP,
EUC_KR,
EUC_TW,
ISO_8859_5,
KOI8R,
LATIN1 to LATIN4,
SJIS,
WIN866,
WIN1250,
WIN1251
SJIS不支持作为服务器编码
SHIFT_JIS_2004不支持作为服务器编码
SQL_ASCII任何 (不会执行转换)
UHC不支持作为服务器编码
UTF8所有支持的编码
WIN866WIN866,
ISO_8859_5,
KOI8R,
MULE_INTERNAL,
UTF8,
WIN1251
WIN874WIN874,
UTF8
WIN1250WIN1250,
LATIN2,
MULE_INTERNAL,
UTF8
WIN1251WIN1251,
ISO_8859_5,
KOI8R,
MULE_INTERNAL,
UTF8,
WIN866
WIN1252WIN1252,
UTF8
WIN1253WIN1253,
UTF8
WIN1254WIN1254,
UTF8
WIN1255WIN1255,
UTF8
WIN1256WIN1256,
UTF8
WIN1257WIN1257,
UTF8
WIN1258WIN1258,
UTF8
表 23.5. 所有内置字符集转换Conversion Name
[a]
源编码目标编码big5_to_euc_twBIG5EUC_TWbig5_to_micBIG5MULE_INTERNALbig5_to_utf8BIG5UTF8euc_cn_to_micEUC_CNMULE_INTERNALeuc_cn_to_utf8EUC_CNUTF8euc_jp_to_micEUC_JPMULE_INTERNALeuc_jp_to_sjisEUC_JPSJISeuc_jp_to_utf8EUC_JPUTF8euc_kr_to_micEUC_KRMULE_INTERNALeuc_kr_to_utf8EUC_KRUTF8euc_tw_to_big5EUC_TWBIG5euc_tw_to_micEUC_TWMULE_INTERNALeuc_tw_to_utf8EUC_TWUTF8gb18030_to_utf8GB18030UTF8gbk_to_utf8GBKUTF8iso_8859_10_to_utf8LATIN6UTF8iso_8859_13_to_utf8LATIN7UTF8iso_8859_14_to_utf8LATIN8UTF8iso_8859_15_to_utf8LATIN9UTF8iso_8859_16_to_utf8LATIN10UTF8iso_8859_1_to_micLATIN1MULE_INTERNALiso_8859_1_to_utf8LATIN1UTF8iso_8859_2_to_micLATIN2MULE_INTERNALiso_8859_2_to_utf8LATIN2UTF8iso_8859_2_to_windows_1250LATIN2WIN1250iso_8859_3_to_micLATIN3MULE_INTERNALiso_8859_3_to_utf8LATIN3UTF8iso_8859_4_to_micLATIN4MULE_INTERNALiso_8859_4_to_utf8LATIN4UTF8iso_8859_5_to_koi8_rISO_8859_5KOI8Riso_8859_5_to_micISO_8859_5MULE_INTERNALiso_8859_5_to_utf8ISO_8859_5UTF8iso_8859_5_to_windows_1251ISO_8859_5WIN1251iso_8859_5_to_windows_866ISO_8859_5WIN866iso_8859_6_to_utf8ISO_8859_6UTF8iso_8859_7_to_utf8ISO_8859_7UTF8iso_8859_8_to_utf8ISO_8859_8UTF8iso_8859_9_to_utf8LATIN5UTF8johab_to_utf8JOHABUTF8koi8_r_to_iso_8859_5KOI8RISO_8859_5koi8_r_to_micKOI8RMULE_INTERNALkoi8_r_to_utf8KOI8RUTF8koi8_r_to_windows_1251KOI8RWIN1251koi8_r_to_windows_866KOI8RWIN866koi8_u_to_utf8KOI8UUTF8mic_to_big5MULE_INTERNALBIG5mic_to_euc_cnMULE_INTERNALEUC_CNmic_to_euc_jpMULE_INTERNALEUC_JPmic_to_euc_krMULE_INTERNALEUC_KRmic_to_euc_twMULE_INTERNALEUC_TWmic_to_iso_8859_1MULE_INTERNALLATIN1mic_to_iso_8859_2MULE_INTERNALLATIN2mic_to_iso_8859_3MULE_INTERNALLATIN3mic_to_iso_8859_4MULE_INTERNALLATIN4mic_to_iso_8859_5MULE_INTERNALISO_8859_5mic_to_koi8_rMULE_INTERNALKOI8Rmic_to_sjisMULE_INTERNALSJISmic_to_windows_1250MULE_INTERNALWIN1250mic_to_windows_1251MULE_INTERNALWIN1251mic_to_windows_866MULE_INTERNALWIN866sjis_to_euc_jpSJISEUC_JPsjis_to_micSJISMULE_INTERNALsjis_to_utf8SJISUTF8windows_1258_to_utf8WIN1258UTF8uhc_to_utf8UHCUTF8utf8_to_big5UTF8BIG5utf8_to_euc_cnUTF8EUC_CNutf8_to_euc_jpUTF8EUC_JPutf8_to_euc_krUTF8EUC_KRutf8_to_euc_twUTF8EUC_TWutf8_to_gb18030UTF8GB18030utf8_to_gbkUTF8GBKutf8_to_iso_8859_1UTF8LATIN1utf8_to_iso_8859_10UTF8LATIN6utf8_to_iso_8859_13UTF8LATIN7utf8_to_iso_8859_14UTF8LATIN8utf8_to_iso_8859_15UTF8LATIN9utf8_to_iso_8859_16UTF8LATIN10utf8_to_iso_8859_2UTF8LATIN2utf8_to_iso_8859_3UTF8LATIN3utf8_to_iso_8859_4UTF8LATIN4utf8_to_iso_8859_5UTF8ISO_8859_5utf8_to_iso_8859_6UTF8ISO_8859_6utf8_to_iso_8859_7UTF8ISO_8859_7utf8_to_iso_8859_8UTF8ISO_8859_8utf8_to_iso_8859_9UTF8LATIN5utf8_to_johabUTF8JOHAButf8_to_koi8_rUTF8KOI8Rutf8_to_koi8_uUTF8KOI8Uutf8_to_sjisUTF8SJISutf8_to_windows_1258UTF8WIN1258utf8_to_uhcUTF8UHCutf8_to_windows_1250UTF8WIN1250utf8_to_windows_1251UTF8WIN1251utf8_to_windows_1252UTF8WIN1252utf8_to_windows_1253UTF8WIN1253utf8_to_windows_1254UTF8WIN1254utf8_to_windows_1255UTF8WIN1255utf8_to_windows_1256UTF8WIN1256utf8_to_windows_1257UTF8WIN1257utf8_to_windows_866UTF8WIN866utf8_to_windows_874UTF8WIN874windows_1250_to_iso_8859_2WIN1250LATIN2windows_1250_to_micWIN1250MULE_INTERNALwindows_1250_to_utf8WIN1250UTF8windows_1251_to_iso_8859_5WIN1251ISO_8859_5windows_1251_to_koi8_rWIN1251KOI8Rwindows_1251_to_micWIN1251MULE_INTERNALwindows_1251_to_utf8WIN1251UTF8windows_1251_to_windows_866WIN1251WIN866windows_1252_to_utf8WIN1252UTF8windows_1256_to_utf8WIN1256UTF8windows_866_to_iso_8859_5WIN866ISO_8859_5windows_866_to_koi8_rWIN866KOI8Rwindows_866_to_micWIN866MULE_INTERNALwindows_866_to_utf8WIN866UTF8windows_866_to_windows_1251WIN866WINwindows_874_to_utf8WIN874UTF8euc_jis_2004_to_utf8EUC_JIS_2004UTF8utf8_to_euc_jis_2004UTF8EUC_JIS_2004shift_jis_2004_to_utf8SHIFT_JIS_2004UTF8utf8_to_shift_jis_2004UTF8SHIFT_JIS_2004euc_jis_2004_to_shift_jis_2004EUC_JIS_2004SHIFT_JIS_2004shift_jis_2004_to_euc_jis_2004SHIFT_JIS_2004EUC_JIS_2004[a]
转换名称遵循标准命名模式：源编码的正式名称，所有非字母数字字符都替换为下划线，后跟_to_，后跟类似处理的目标编码名称。
因此，这些名称有时会偏离表 23.3中显示的自定义编码名。
23.3.5. 进一步阅读 #
这些是开始学习各种编码系统的好资源。
CJKV信息处理：中日韩越计算
包含对EUC_JP、
EUC_CN、EUC_KR和
EUC_TW的详细解释。
https://www.unicode.org/
Unicode Consortium的网站。
RFC 3629
UTF-8 (8位UCS/Unicode转换格式)在这里定义。
上一页 上一级 下一页23.2. 排序规则支持 起始页 第 24 章 日常数据库维护任务
