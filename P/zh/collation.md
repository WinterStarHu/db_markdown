# 23.2. 排序规则支持

23.2. 排序规则支持
版本：
纠错本页面
搜索
目录导航
❮
❯
23.2. 排序规则支持 #23.2.1. 概念23.2.2. 管理排序规则23.2.3. ICU 自定义排序规则
排序规则特性允许指定每一列甚至每一个操作的数据的排序顺序和字符分类行为。这放松了数据库的LC_COLLATE和LC_CTYPE设置自创建后就不能更改这一限制。
23.2.1. 概念 #
从概念上讲，每个可排序数据类型的表达式都有一个排序规则。
（内置的可排序数据类型包括text、varchar和char。
用户定义的基本类型也可以标记为可排序，当然，基于可排序数据类型的domain也是可排序的。）
如果表达式是列引用，则表达式的排序规则是列的定义排序规则。
如果表达式是常量，则排序规则是常量的数据类型的默认排序规则。
更复杂表达式的排序规则是从其输入的排序规则派生的，如下所述。
一个表达式的排序规则可以是“默认”排序规则，它表示数据库的区域设置。一个表达式的排序规则也可能是不确定的。在这种情况下，排序操作和其他需要知道排序规则的操作会失败。
当数据库系统必须要执行一次排序或者字符分类时，它使用输入表达式的排序规则。这会在使用例如ORDER BY子句以及函数或操作符调用（如<）时发生。应用于ORDER BY子句的排序规则就是排序键的排序规则。应用于函数或操作符调用的排序规则从它们的参数得来，具体如下文所述。除比较操作符之外，在大小写字母之间转换的函数会考虑排序规则，例如lower、upper和initcap。模式匹配操作符和to_char及相关函数也会考虑排序规则。
对于一个函数或操作符调用，其排序规则通过检查在执行指定操作时参数的排序规则来获得。如果该函数或操作符调用的结果是一种可排序的数据类型，万一有外围表达式要求函数或操作符表达式的排序规则，在解析时结果的排序规则也会被用作函数或操作符表达式的排序规则。
一个表达式的排序规则派生可以是显式或隐式。该区别会影响多个不同的排序规则出现在同一个表达式中时如何组合它们。当使用一个COLLATE子句时，将发生显式排序规则派生。所有其他排序规则派生都是隐式的。当多个排序规则需要被组合时（例如在一个函数调用中），将使用下面的规则：
如果任何一个输入表达式具有一个显式排序规则派生，则在输入表达式之间的所有显式派生的排序规则必须相同，否则将产生一个错误。如果任何一个显式派生的排序规则存在，它就是排序规则组合的结果。
否则，所有输入表达式必须具有相同的隐式排序规则派生或默认排序规则。如果任何一个非默认排序规则存在，它就是排序规则组合的结果。否则，结果是默认排序规则。
如果在输入表达式之间存在冲突的非默认隐式排序规则，则组合被认为是具有不确定排序规则。这并非一种错误情况，除非被调用的特定函数要求提供排序规则的知识。如果它确实这样做，运行时将发生一个错误。
例如，考虑这个表定义：
CREATE TABLE test1 (
a text COLLATE "de_DE",
b text COLLATE "es_ES",
...
);
然后在
SELECT a < 'foo' FROM test1;
中，<比较被根据de_DE规则执行，因为表达式组合了一个隐式派生的排序规则和默认排序规则。但是在
SELECT a < ('foo' COLLATE "fr_FR") FROM test1;
中，比较被使用fr_FR规则执行，因为显式排序规则派生重载了隐式排序规则。更进一步，给定
SELECT a < b FROM test1;
解析器不能确定要应用哪个排序规则，因为a列和b列具有冲突的隐式排序规则。由于<操作符需要知道到底使用哪一个排序规则，这将会导致一个错误。该错误可以通过在一个输入表达式上附加一个显式排序规则说明符来解决，因此：
SELECT a < b COLLATE "de_DE" FROM test1;
或者等效的
SELECT a COLLATE "de_DE" < b FROM test1;
在另一方面，结构相似的情况
SELECT a || b FROM test1;
不会导致一个错误，因为||操作符不关心排序规则：不管排序规则怎样它的结果都相同。
如果一个函数或操作符返回一个具有可排序数据类型的结果，分配给该函数或操作符的组合输入表达式的排序规则也被考虑应用在函数或操作符的结果。因此，在
SELECT * FROM test1 ORDER BY a || 'foo';
中排序将根据de_DE规则完成。但这个查询：
SELECT * FROM test1 ORDER BY a || b;
会导致一个错误，因为即使||操作符不需要知道排序规则，但ORDER BY子句需要。按照以前，冲突可以通过使用一个显式排序规则说明符来解决：
SELECT * FROM test1 ORDER BY a || b COLLATE "fr_FR";
23.2.2. 管理排序规则 #
一个排序规则是一个SQL模式对象，将一个SQL名称映射到操作系统中安装的库提供的区域设置。
排序规则定义有一个提供者，指定哪个库提供区域设置数据。
一个标准的提供者名称是libc，它使用操作系统C库提供的区域设置。
这些是大多数操作系统提供的工具使用的区域设置。
另一个提供者是icu，它使用外部ICU库。
只有在构建PostgreSQL时配置了对ICU的支持，才能使用ICU区域设置。
libc提供的一个排序规则对象映射到LC_COLLATE
和LC_CTYPE设置的组合，
如setlocale()系统库调用所接受的。
（正如其名字所说的，一个排序规则的主要目的是设置LC_COLLATE，
它控制排序顺序。但是在实际中LC_CTYPE设置与LC_COLLATE
不同是很少有必要的，因此通过一个概念来收集这些信息比为了设置每一个表达式的
LC_CTYPE而创建另一种架构要更加方便）。此外，
一个libc排序规则是和一个字符集编码（见第 23.3 节）
绑定在一起的。相同的排序规则名字可能存在于不同的编码中。
由icu提供的排序规则对象映射到由ICU库提供的指定整理器。
ICU不支持单独的“collate”和“ctype”设置，
所以它们总是相同的。此外，ICU排序规则与编码无关，
因此在数据库中总是只有一个给定名称的ICU排序规则。
23.2.2.1. 标准排序规则 #
在所有平台上，均支持以下排序规则：
unicode
该 SQL 标准排序规则使用带默认 Unicode 排序元素表的 Unicode 排序算法进行排序，
适用于所有编码。使用此排序规则需要 ICU 支持，若 PostgreSQL
使用不同版本的 ICU 构建，行为可能会发生变化。（此排序规则与 ICU 根区域设置
行为相同；请参阅 und-x-icu（表示“未定义”）。）
ucs_basic
该 SQL 标准排序规则按 Unicode 代码点值而非自然语言顺序排序，
只有 ASCII 字母 “A” 到
“Z” 被视为字母。其行为在所有版本中
高效且稳定，仅适用于 UTF8 编码。（此排序规则与
C 在 UTF8 编码中的 libc 区域设置规范
行为相同。）
pg_unicode_fast
该排序规则按 Unicode 代码点值而非自然语言顺序排序。对于
lower、initcap 和
upper 函数，使用 Unicode 完整大小写映射。
对于模式匹配（包括正则表达式），使用 Unicode 兼容属性
的标准变体。在 Postgres 主版本内行为高效稳定，
仅适用于 UTF8 编码。
pg_c_utf8
该排序规则按 Unicode 代码点值而非自然语言顺序排序。对于
lower、initcap 和
upper 函数，使用 Unicode 简单大小写映射。
对于模式匹配（包括正则表达式），使用 Unicode 兼容属性
的 POSIX 兼容变体。在 PostgreSQL 主版本内
行为高效稳定，仅适用于 UTF8 编码。
C（等价于 POSIX）
C 和 POSIX 排序规则基于
“传统 C” 行为。它们按字节值而非自然语言顺序排序，
只有 ASCII 字母 “A” 到
“Z” 被视为字母。对于给定数据库编码，
其行为在所有版本中高效且稳定，但不同数据库编码间行为可能有所不同。
default
default 排序规则选择数据库创建时指定的区域设置。
额外的排序规则可能会根据操作系统的支持而有所不同。 这些额外排序规则的效率和稳定性
取决于排序提供者、提供者版本以及区域设置。
23.2.2.2. 预定义的排序规则 #
如果操作系统支持在一个程序中使用多个区域（newlocale和相关函数），
或者配置了ICU支持，那么在一个数据库集簇被初始化时，initdb
将以它在操作系统中能找到的所有区域为基础在系统目录pg_collation
中填充排序规则。
要检查当前可用的语言环境，请在psql中使用查询
SELECT * FROM pg_collation或命令\dOS+。
23.2.2.2.1. libc 排序规则 #
例如，操作系统可能会提供一个名为de_DE.utf8的区域。initdb则会创建一个用于编码UTF8的名为de_DE.utf8的排序规则，在其中LC_COLLATE和LC_CTYPE都被设置为de_DE.utf8。它也会创建一个具有去掉名称的.utf8标签的排序规则。这样你也可以使用名字de_DE来使用该排序规则，这写起来更简单并且使得名字更加独立于编码。不过要注意，最初的排序规则名称的集合是平台依赖的。
由libc提供的默认排序规则直接映射到操作系统中安装的语言环境，
可以使用命令locale -a列出。如果所需的libc
排序规则与LC_COLLATE和LC_CTYPE的值不同，
或者在数据库系统初始化之后，
操作系统中安装了新的语言环境，可以使用CREATE COLLATION
命令创建新的排序规则。新的操作系统语言环境也可以使用
pg_import_system_collations()
函数集中导入。
在任何特定的数据库中，只有使用数据库编码的排序规则是令人感兴趣的。其他pg_collation中的项会被忽略。
因此，一个如de_DE的被剥离的排序规则名在一个给定数据库中可以被认为是唯一的，即使它在全局上并不唯一。
我们推荐使用被剥离的排序规则名，因为在你决定要更改到另一个数据库编码时需要做的事情更少。
但是要注意default、C和POSIX排序规则在使用时可以不考虑数据库编码。
PostgreSQL在碰到具有相同属性的不同排序规则对象时会认为它们是不兼容的。因此对于例子：
SELECT a COLLATE "C" < b COLLATE "POSIX" FROM test1;
将会得到一个错误，即使C和POSIX排序规则具有相同的行为。因此，我们不推荐混合使用被剥离的和非被剥离的排序规则名。
23.2.2.2.2. ICU 排序规则 #
对于ICU，枚举所有可能的语言环境名称并不明智。
ICU为语言环境使用特定的命名系统，但命名语言环境的方法多于实际上不同的语言环境。
initdb使用ICU API提取一组不同的语言环境以填充初始排序规则集合。
由ICU提供的排序规则是在SQL环境中创建的，名称采用BCP 47语言标记格式，
并附有一个“专用使用”扩展名-x-icu，
以将它们与libc语言环境区分开来。
以下是一些可能创建的排序规则示例：
de-x-icu #德语排序规则，默认变体de-AT-x-icu #奥地利德语排序规则，默认变体
（还有例如de-DE-x-icu或de-CH-x-icu，
但截至撰写本文时，它们等同于de-x-icu。）
und-x-icu（表示“未定义”） #
ICU “根”排序规则。使用此规则可以获得合理的与语言无关的排序顺序。
一些（不常用的）编码不受ICU支持。当数据库编码是其中之一时，
忽略pg_collation中的ICU排序规则项。
试图使用其中一个将会抛出一个类似“collation "de-x-icu" for
encoding "WIN874" does not exist”的错误。
23.2.2.3. 创建新的排序规则对象 #
如果标准和预定义的排序规则不够用，用户可以使用SQL命令
CREATE COLLATION创建自己的排序规则对象。
与所有预定义的对象一样，标准和预定义的排序规则在模式
pg_catalog中。用户定义的排序规则应该在用户模式中创建。
这也确保它们由pg_dump保存。
23.2.2.3.1. libc 排序规则 #
可以像这样创建新的libc排序规则：
CREATE COLLATION german (provider = libc, locale = 'de_DE');
该命令中locale子句可接受的确切值取决于操作系统。
在类Unix系统上，命令locale -a将显示一个列表。
由于预定义的libc排序规则已经包含了数据库实例初始化时在操作系统中定义的所有排序规则，
因此通常不需要手动创建新排序规则。如果需要不同的命名系统（在这种情况下，
另请参阅第 23.2.2.3.3 节），
或者操作系统已经升级以提供新的区域设置定义（在这种情况下，
另请参阅pg_import_system_collations()），
可能需要手动创建。
23.2.2.3.2. ICU 排序规则 #
可以像这样创建ICU排序规则：
CREATE COLLATION german (provider = icu, locale = 'de-DE');
ICU区域设置被指定为BCP 47 语言标签，但也可以接受大多数
libc风格的区域设置名称。如果可能，libc风格的区域设置名称会
转换为语言标签。
新的ICU排序规则可以通过在语言标签中包含排序属性来广泛定制排序行为。
请参阅第 23.2.3 节了解详细信息和示例。
23.2.2.3.3. 复制排序规则 #
也可以使用命令CREATE COLLATION
从现有的排序规则创建新的排序规则，
这对于能够在应用程序中使用与操作系统无关的排序规则名称、
创建兼容性名称或以更易读的名称使用ICU提供的排序规则很有帮助。例如：
CREATE COLLATION german FROM "de_DE";
CREATE COLLATION french FROM "fr-x-icu";
23.2.2.4. 非确定性排序规则 #
排序规则要么是确定性的，要么是非确定性的。
确定性排序规则使用确定性比较，这意味着字符串要认为是相等，只有在它们由相同的字节序列组成时。
非确定性比较可以确定字符串相等，即使它们由不同字节组成。
典型的情形包括大小写不敏感比较、重音不敏感比较，以及不同Unicode规范形式的字符串比较。
实际上，非敏感比较是由排序规则提供程序来实现的；确定性标志仅确定在使用按字节比较时是否要打破平局。
另请参见Unicode技术标准10以获取更多术语信息。
创建非确定性排序规则时，指定属性deterministic = false以CREATE COLLATION，例如：
CREATE COLLATION ndcoll (provider = icu, locale = 'und', deterministic = false);
该例子以非确定性方式使用标准的Unicode排序规则。特别地，这将允许不同规范形式的字符串能正确地比较。更有趣的例子是使用上述的ICU定制化功能。例如：
CREATE COLLATION case_insensitive (provider = icu, locale = 'und-u-ks-level2', deterministic = false);
CREATE COLLATION ignore_accents (provider = icu, locale = 'und-u-ks-level1-kc-true', deterministic = false);
所有标准和预定义排序规则都是确定性的，所有用户自定义排序规则默认也是
确定性的。虽然非确定性排序规则提供了更“正确”的行为
（尤其在考虑Unicode的全部功能及其众多特殊情况时），但也有一些缺点。
首先，使用它们会带来性能损失。特别注意，B-tree不能对使用非确定性
排序规则的索引进行去重。此外，某些操作（如某些模式匹配操作）在
非确定性排序规则下不可用。因此，只应在明确需要时使用它们。
提示
要处理不同Unicode规范化格式中的文本，还有一个选项，使用函数/表达式normalize 和 is normalized预处理或检查字符串，而不是使用非确定性排序规则。每种方法都有不同的权衡。
23.2.3. ICU 自定义排序规则 #
ICU通过在语言标签中定义新的排序规则和排序设置，允许对排序行为进行广泛
控制。这些设置可以修改排序顺序以满足各种需求。例如：
-- 忽略重音和大小写的差异
CREATE COLLATION ignore_accent_case (provider = icu, deterministic = false, locale = 'und-u-ks-level1');
SELECT 'Å' = 'A' COLLATE ignore_accent_case; -- true
SELECT 'z' = 'Z' COLLATE ignore_accent_case; -- true
-- 大写字母排在小写字母之前。
CREATE COLLATION upper_first (provider = icu, locale = 'und-u-kf-upper');
SELECT 'B' < 'b' COLLATE upper_first; -- true
-- 数字按数值排序并忽略标点符号
CREATE COLLATION num_ignore_punct (provider = icu, deterministic = false, locale = 'und-u-ka-shifted-kn');
SELECT 'id-45' < 'id-123' COLLATE num_ignore_punct; -- true
SELECT 'w;x*y-z' = 'wxyz' COLLATE num_ignore_punct; -- true
可用选项中的许多内容在第 23.2.3.2 节中有描述，
或者参见第 23.2.3.5 节了解更多详细信息。
23.2.3.1. ICU 比较级别 #
在ICU中，两个字符串的比较（排序）是由一个多级过程决定的，
其中文本特性被分组为“级别”。每个级别的处理由
排序设置控制。
更高的级别对应于更细致的文本特性。
表 23.1显示了在确定给定级别的相等性时，
哪些文本特征差异被认为是重要的。Unicode字符U+2063
是一个不可见的分隔符，正如表中所示，在所有低于identic
的比较级别中都会被忽略。
表 23.1. ICU 排序级别级别描述'f' = 'f''ab' = U&'a\2063b''x-y' = 'x_y''g' = 'G''n' = 'ñ''y' = 'z'级别1基本字符truetruetruetruetruefalse级别2重音truetruetruetruefalsefalse级别3案例/变体truetruetruefalsefalsefalse级别4标点符号[a]truetruefalsefalsefalsefalse相同所有truefalsefalsefalsefalsefalse[a] 仅适用于
ka-shifted；参见 表 23.2
在每个级别，即使完全关闭规范化，也会执行基本的规范化。例如，
'á'可能由代码点U&'\0061\0301'
或单个代码点U&'\00E1'组成，这些序列即使在
identic级别也会被视为相等。要将代码点表示中的
任何差异视为不同，请使用设置了deterministic
为true的排序规则。
23.2.3.1.1. 排序级别示例 #
CREATE COLLATION level3 (provider = icu, deterministic = false, locale = 'und-u-ka-shifted-ks-level3');
CREATE COLLATION level4 (provider = icu, deterministic = false, locale = 'und-u-ka-shifted-ks-level4');
CREATE COLLATION identic (provider = icu, deterministic = false, locale = 'und-u-ka-shifted-ks-identic');
-- invisible separator ignored at all levels except identic
SELECT 'ab' = U&'a\2063b' COLLATE level4; -- true
SELECT 'ab' = U&'a\2063b' COLLATE identic; -- false
-- punctuation ignored at level3 but not at level 4
SELECT 'x-y' = 'x_y' COLLATE level3; -- true
SELECT 'x-y' = 'x_y' COLLATE level4; -- false
23.2.3.2. ICU区域设置的排序规则设置 #
表 23.2显示了可用的排序设置，
这些设置可以作为语言标签的一部分，用于自定义排序。
表 23.2. ICU 排序设置键值默认值描述coemoji, phonebk, standard, ...standard
排序类型。有关其他选项和详细信息，请参阅
第 23.2.3.5 节。
kanoignore, shiftednoignore
如果设置为shifted，会导致某些字符（例如标点符号或空格）
在比较中被忽略。键ks必须设置为level3
或更低才能生效。设置键kv以控制忽略哪些字符类别。
kbtrue, falsefalse
对于第二级差异的反向比较。例如，区域设置
und-u-kb将'àe'排在
'aé'之前。
kctrue, falsefalse
将大小写分隔为“2.5级”，介于重音和其他3级特性之间。
如果设置为true并且ks设置为
level1，将忽略重音但考虑大小写。
kf
upper, lower,
false
false
如果设置为upper，大写字母会排在小写字母之前。
如果设置为lower，小写字母会排在大写字母之前。
如果设置为false，排序取决于区域设置的规则。
kntrue, falsefalse
如果设置为true，字符串中的数字将被视为单个数值，
而不是一串数字。例如，'id-45'会排在
'id-123'之前。
kktrue, falsefalse
启用完全规范化；可能会影响性能。即使设置为
false，也会执行基本规范化。需要完全规范化的语言的区域
通常默认启用此功能。
在某些情况下，完全规范化非常重要，例如当多个重音应用于单个字符时。
例如，代码点序列U&'\0065\0323\0302'和
U&'\0065\0302\0323'表示一个带有抑扬符和下点重音的
e，但应用顺序不同。启用完全规范化时，这些代码点序列
被视为相等；否则它们是不相等的。
kr
space, punct,
symbol, currency,
digit, script-id
设置为一个或多个有效值，或任何 BCP 47
script-id，例如 latn
（“拉丁”）或 grek（“希腊”）。多个值用
"-" 分隔。
重新定义字符类别的排序；属于列表中较早类别的字符在属于较晚类别的
字符之前排序。例如，值 digit-currency-space
（作为语言标签的一部分，如 und-u-kr-digit-currency-space）
会将标点符号排序在数字和空格之前。
kslevel1, level2, level3,
level4, identiclevel3
敏感度（或“强度”）在确定相等性时，level1对差异的敏感度最低，
而identic对差异的敏感度最高。详见
表 23.1。
kv
space，punct，
symbol，currency
punct
在第3级比较时忽略的字符类别。设置为更高的值时会包含较低的值；
例如，symbol还包括punct和
space在要忽略的字符中。键ka必须
设置为shifted，键ks必须设置为
level3或更低才能生效。
默认值可能取决于区域设置。上表并不意味着是完整的。请参阅
第 23.2.3.5 节以获取更多选项和详细信息。
注意
对于许多排序设置，您必须将deterministic设置为
false来创建排序，以实现所需的效果（请参阅
第 23.2.2.4 节）。此外，某些设置仅在
键ka设置为shifted时生效
（请参阅表 23.2）。
23.2.3.3. 排序设置示例 #CREATE COLLATION "de-u-co-phonebk-x-icu" (provider = icu, locale = 'de-u-co-phonebk'); #带有电话簿排序类型的德语排序CREATE COLLATION "und-u-co-emoji-x-icu" (provider = icu, locale = 'und-u-co-emoji'); #
根排序使用表情符号排序类型，根据 Unicode 技术标准 #51
CREATE COLLATION latinlast (provider = icu, locale = 'en-u-kr-grek-latn'); #
在拉丁字母之前排序希腊字母。（默认是拉丁字母在希腊字母之前。）
CREATE COLLATION upperfirst (provider = icu, locale = 'en-u-kf-upper'); #
将大写字母排在小写字母之前。（默认是小写字母优先。）
CREATE COLLATION special (provider = icu, locale = 'en-u-kf-upper-kr-grek-latn'); #
结合了以上两种选项。
23.2.3.4. ICU 定制规则 #
如果上述排序设置提供的选项不够充分，可以通过定制规则更改排序
元素的顺序，其语法详见https://unicode-org.github.io/icu/userguide/collation/customization/。
这个小例子基于根区域设置创建了一个排序规则，并使用了以下定制规则：
CREATE COLLATION custom (provider = icu, locale = 'und', rules = '&V << w <<< W');
根据这个规则，字母“W”被排序在“V”之后，
但被视为类似于重音的次要差异。这类规则包含在某些语言的区域设置定义中。
（当然，如果区域设置定义已经包含了所需的规则，那么就不需要再次显式指定了。）
这里是一个更复杂的示例。以下语句设置了一个名为
ebcdic的排序规则，用于按照EBCDIC编码的顺序对
US-ASCII字符进行排序。
CREATE COLLATION ebcdic (provider = icu, locale = 'und',
rules = $$
& ' ' < '.' < '<' < '(' < '+' < \|
< '&' < '!' < '$' < '*' < ')' < ';'
< '-' < '/' < ',' < '%' < '_' < '>' < '?'
< '`' < ':' < '#' < '@' < \' < '=' < '"'
<*a-r < '~' <*s-z < '^' < '[' < ']'
< '{' <*A-I < '}' <*J-R < '\' <*S-Z <*0-9
$$);
SELECT c
FROM (VALUES ('a'), ('b'), ('A'), ('B'), ('1'), ('2'), ('!'), ('^')) AS x(c)
ORDER BY c COLLATE ebcdic;
c
---
!
a
b
^
A
B
1
2
23.2.3.5. ICU 的外部参考 #
本节 (第 23.2.3 节) 只是对ICU行为和语言标签的简要
概述。有关技术细节、附加选项和新行为，请参阅以下文档：
Unicode 技术标准 #35
BCP 47
CLDR 资源库
https://unicode-org.github.io/icu/userguide/locale/
https://unicode-org.github.io/icu/userguide/collation/
上一页 上一级 下一页23.1. 区域支持 起始页 23.3. 字符集支持
