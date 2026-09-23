# 10.10.1 Unicode 字符集_MySQL 8.0 参考手册

10.10.1 Unicode 字符集_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
10.10.1 Unicode 字符集1
10.10.2 西欧字符集1
10.10.3 中欧字符集1
10.10.4 南欧和中东字符集1
10.10.5 波罗的海字符集1
10.10.6 西里尔字符集1
10.10.7 亚洲字符集1
10.10.8 二进制字符集1
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.10 支持的字符集和归类  /
10.10.1 Unicode 字符集
10.10.1 Unicode 字符集
本节介绍可用于 Unicode 字符集的归类及其区别属性。有关 Unicode 的一般信息，请参阅
第 10.9 节 “Unicode 支持”。
MySQL 支持多种 Unicode 字符集：
utf8mb4：Unicode 字符集的 UTF-8 编码，每个字符使用一到四个字节。
utf8mb3：Unicode 字符集的 UTF-8 编码，每个字符使用一到三个字节。此字符集在 MySQL 8.0 中已弃用，您应该
utfmb4改用。
utf8: 的别名
utf8mb3。在 MySQL 8.0 中，这个别名已被弃用；改用utf8mb4。
utf8预计在未来的版本中将成为 . 的别名utf8mb4。
ucs2：Unicode 字符集的 UCS-2 编码，每个字符使用两个字节。在 MySQL 8.0.28 中弃用；您应该期望在未来的版本中删除对该字符集的支持。
utf16：Unicode 字符集的 UTF-16 编码，每个字符使用两个或四个字节。喜欢ucs2但带有补充字符的扩展名。
utf16le: Unicode 字符集的 UTF-16LE 编码。喜欢utf16但小端而不是大端。
utf32：Unicode 字符集的 UTF-32 编码，每个字符使用四个字节。
笔记
该utf8mb3字符集已弃用，您应该期望在未来的 MySQL 版本中将其删除。请utf8mb4改用。
utf8目前是 的别名
utf8mb3，但现在已弃用，utf8预计随后会成为 的引用utf8mb4。从 MySQL 8.0.28 开始，utf8mb3也显示在utf8Information Schema 表的列和 SQL
SHOW语句的输出中。
为避免 的含义出现歧义
utf8，请考虑
utf8mb4明确指定字符集引用。
utf8mb4、utf16、
utf16le和utf32支持基本多语言平面 (BMP) 字符和位于 BMP 之外的增补字符。utf8mb3
并且ucs2只支持 BMP 字符。
大多数 Unicode 字符集都有一个通用排序规则（_general在名称中用 表示或没有语言说明符）、二进制排序规则（
_bin在名称中用 表示）和几种特定于语言的排序规则（由语言说明符表示）。例如，forutf8mb4和
utf8mb4_general_ci是
utf8mb4_bin它的一般排序规则和二进制排序规则，并且utf8mb4_danish_ci是它特定于语言的排序规则之一。
大多数字符集都有一个二进制排序规则。
utf8mb4是一个异常，它有两个：
utf8mb4_binand (as of MySQL 8.0.17)
utf8mb4_0900_bin。这两个二进制归类具有相同的排序顺序，但通过它们的填充属性和归类权重特征来区分。请参阅
归类垫属性和
字符归类重量。
的归类支持utf16le是有限的。唯一可用的归类是
utf16le_general_ciand
utf16le_bin。这些类似于
utf16_general_ci和
utf16_bin。
Unicode 归类算法 (UCA) 版本归类垫属性特定于语言的排序规则_general_ci 与 _unicode_ci 归类字符整理权重杂项资料
Unicode 归类算法 (UCA) 版本
MySQL
xxx_unicode_ci
根据
http://www.unicode.org/reports/tr10/中描述的 Unicode 归类算法 (UCA) 实施归类。排序规则使用版本 4.0.0 UCA 权重键：
http ://www.unicode.org/Public/UCA/4.0.0/allkeys-4.0.0.txt 。这
xxx_unicode_ci
归类仅部分支持 Unicode 归类算法。不支持某些字符，不完全支持组合标记。这会影响越南语、约鲁巴语和纳瓦霍语等语言。在字符串比较中，组合字符被认为不同于用单个 unicode 字符编写的相同字符，并且这两个字符被认为具有不同的长度（例如，由
CHAR_LENGTH()函数返回或在结果集元数据中）。
基于高于 4.0.0 的 UCA 版本的 Unicode 归类包括归类名称中的版本。例子：
utf8mb4_unicode_520_ci基于 UCA 5.2.0 权重键 ( http://www.unicode.org/Public/UCA/5.2.0/allkeys.txt )，
utf8mb4_0900_ai_ci基于 UCA 9.0.0 权重密钥 ( http://www.unicode.org/Public/UCA/9.0.0/allkeys.txt )。
LOWER()和
函数
根据UPPER()其参数的排序规则执行大小写折叠。仅当参数排序规则使用足够高的 UCA 版本时，这些函数才会转换仅在高于 4.0.0 的 Unicode 版本中具有大写和小写版本的字符。
归类垫属性
基于 UCA 9.0.0 及更高版本的归类比基于 UCA 9.0.0 之前版本的归类更快。它们还具有 pad 属性，这与基于 9.0.0 之前的 UCA 版本的归类中使用的属性NO PAD形成对比。PAD SPACE对于非二进制字符串的比较，NO PAD归类将字符串末尾的空格视为任何其他字符（请参阅
比较中的尾随空格处理）。
要确定排序规则的 pad 属性，请使用
INFORMATION_SCHEMA
COLLATIONS包含一
PAD_ATTRIBUTE列的表。例如：
mysql> SELECT COLLATION_NAME, PAD_ATTRIBUTE
FROM INFORMATION_SCHEMA.COLLATIONS
WHERE CHARACTER_SET_NAME = 'utf8mb4';
+----------------------------+---------------+
| COLLATION_NAME             | PAD_ATTRIBUTE |
+----------------------------+---------------+
| utf8mb4_general_ci         | PAD SPACE     |
| utf8mb4_bin                | PAD SPACE     |
| utf8mb4_unicode_ci         | PAD SPACE     |
| utf8mb4_icelandic_ci       | PAD SPACE     |
...
| utf8mb4_0900_ai_ci         | NO PAD        |
| utf8mb4_de_pb_0900_ai_ci   | NO PAD        |
| utf8mb4_is_0900_ai_ci      | NO PAD        |
...
| utf8mb4_ja_0900_as_cs      | NO PAD        |
| utf8mb4_ja_0900_as_cs_ks   | NO PAD        |
| utf8mb4_0900_as_ci         | NO PAD        |
| utf8mb4_ru_0900_ai_ci      | NO PAD        |
| utf8mb4_ru_0900_as_cs      | NO PAD        |
| utf8mb4_zh_0900_as_cs      | NO PAD        |
| utf8mb4_0900_bin           | NO PAD        |
+----------------------------+---------------+
具有排序规则的非二进制字符串值（CHAR、VARCHAR和
TEXT）的比较NO PAD
在尾随空格方面不同于其他排序规则。比如，'a'和
'a '比较一样是不同的字符串，不是同一个字符串。这可以通过使用utf8mb4. 的填充属性
utf8mb4_bin是PAD
SPACE，而
utf8mb4_0900_bin它是NO
PAD。因此，涉及的
utf8mb4_0900_bin操作不会添加尾随空格，并且涉及带有尾随空格的字符串的比较对于两种排序规则可能不同：
mysql> CREATE TABLE t1 (c CHAR(10) COLLATE utf8mb4_bin);
Query OK, 0 rows affected (0.03 sec)
mysql> INSERT INTO t1 VALUES('a');
Query OK, 1 row affected (0.01 sec)
mysql> SELECT * FROM t1 WHERE c = 'a ';
+------+
| c    |
+------+
| a    |
+------+
1 row in set (0.00 sec)
mysql> ALTER TABLE t1 MODIFY c CHAR(10) COLLATE utf8mb4_0900_bin;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> SELECT * FROM t1 WHERE c = 'a ';
Empty set (0.00 sec)
特定于语言的排序规则
如果仅基于 Unicode 归类算法 (UCA) 的排序不适用于某种语言，则 MySQL 会实现特定于语言的 Unicode 归类。特定于语言的归类是基于 UCA 的，具有额外的语言定制规则。此类规则的示例将在本节后面出现。对于有关特定语言顺序的问题，
unicode.org在http://www.unicode.org/cldr/charts/30/collat ​​ion/index.html提供了通用语言环境数据存储库 (CLDR) 整理图表
。
例如，非语言特定
utf8mb4_0900_ai_ci和语言特定的
Unicode 排序规则各自具有以下特征：
utf8mb4_LOCALE_0900_ai_ci
排序规则基于 UCA 9.0.0 和 CLDR v30，不区分重音和大小写。这些特征在归类名称中由_0900、
_ai和表示。_ci例外：
utf8mb4_la_0900_ai_ci不是基于 CLDR，因为 CLDR 中没有定义古典拉丁语。
该排序规则适用于 [U+0, U+10FFFF] 范围内的所有字符。
如果排序规则不是特定于语言的，它会按默认顺序（如下所述）对所有字符（包括增补字符）进行排序。如果排序规则是特定于语言的，它会根据特定于语言的规则正确地对语言中的字符进行排序，并且按照默认顺序对不属于该语言的字符进行排序。
默认情况下，归类根据表中分配的权重值对具有 DUCET 表（默认 Unicode 归类元素表）中列出的代码点的字符进行排序。排序规则使用隐式权重值对 DUCET 表中没有列出代码点的字符进行排序，该权重值是根据 UCA 构造的。
对于非特定语言的归类，收缩序列中的字符被视为单独的字符。对于特定于语言的归类，缩写可能会更改字符排序顺序。
下表中显示的包含区域设置代码或语言名称的排序规则名称是特定于语言的排序规则。Unicode 字符集可能包括一种或多种这些语言的排序规则。
表 10.3 Unicode 归类语言说明符
语
语言说明符
波斯尼亚语
bs
保加利亚语
bg
中国人
zh
古典拉丁语
la或者roman
克罗地亚语
hr或者croatian
捷克语
cs或者czech
丹麦语
da或者danish
世界语
eo或者esperanto
爱沙尼亚语
et或者estonian
加利西亚语
gl
德国电话簿订单
de_pb或者german2
匈牙利
hu或者hungarian
冰岛的
is或者icelandic
日本人
ja
拉脱维亚语
lv或者latvian
立陶宛语
lt或者lithuanian
蒙
mn
挪威语/博克马尔语
nb
挪威语/尼诺斯克语
nn
波斯语
persian
抛光
pl或者polish
罗马尼亚语
ro或者romanian
俄语
ru
塞尔维亚
sr
僧伽罗语
sinhala
斯洛伐克语
sk或者slovak
斯洛文尼亚语
sl或者slovenian
现代西班牙语
es或者spanish
传统的西班牙语
es_trad或者spanish2
瑞典
sv或者swedish
土耳其
tr或者turkish
越南语
vi或者vietnamese
MySQL 8.0.30 及更高版本提供保加利亚排序规则
utf8mb4_bg_0900_ai_ci和
utf8mb4_bg_0900_as_cs.
克罗地亚语排序规则是为这些克罗地亚语字母量身定制的：
Č, Ć,
Dž, Đ,
Lj, Nj,
Š, Ž。
MySQL 8.0.30 及更高版本
为塞尔维亚语提供utf8mb4_sr_latn_0900_ai_ci和
排序规则，为波斯尼亚语提供和
排序规则，当这些语言是用拉丁字母书写时。
utf8mb4_sr_latn_0900_as_csutf8mb4_bs_0900_ai_ciutf8mb4_bs_0900_as_cs
从 MySQL 8.0.30 开始，MySQL 为挪威语的两种主要变体提供排序规则：对于 Bokmål，您可以使用
utf8mb4_nb_0900_ai_ciand
utf8mb4_nb_0900_as_cs；对于 Nynorsk，MySQL 现在提供utf8mb4_nn_0900_ai_ci和
utf8mb4_nn_0900_as_cs.
对于日语，utf8mb4字符集包括utf8mb4_ja_0900_as_cs和
utf8mb4_ja_0900_as_cs_ks排序规则。两种归类都区分重音和区分大小写。
utf8mb4_ja_0900_as_cs_ks也是假名敏感的，将片假名字符与平假名字符区分开来，而
utf8mb4_ja_0900_as_cs将片假名和平假名字符视为相同的排序。需要日语排序规则但不区分假名的应用程序可用于
utf8mb4_ja_0900_as_cs获得更好的排序性能。utf8mb4_ja_0900_as_cs使用三个权重级别进行排序；
utf8mb4_ja_0900_as_cs_ks使用四个。
对于不区分重音的古典拉丁语归类，
IandJ比较相等，UandV
比较相等。Iand
J, and Uand
V比较在基本字母级别上是否相等。换句话说，J被视为重音I，U被视为重音V。
MySQL 8.0.30 及更高版本在使用西里尔字符编写时为蒙古语提供排序规则，
utf8mb4_mn_cyrl_0900_ai_ci而
utf8mb4_mn_cyrl_0900_as_cs.
西班牙语排序规则可用于现代和传统西班牙语。对于两者， (n-tilde) 是和
ñ之间的单独字母。此外，对于传统的西班牙语，
是和之间的单独字母
，并且
是和之间的单独字母
。
nochcdlllm
传统的西班牙语排序规则也可用于阿斯图里亚斯语和加利西亚语。从 MySQL 8.0.30 开始，MySQL 还提供
了加利西亚语的排序utf8mb4_gl_0900_ai_ci规则
。utf8mb4_gl_0900_as_cs（这些排序规则分别与
utf8mb4_es_0900_ai_ci和
相同utf8mb4_es_0900_as_cs。）
瑞典归类包括瑞典规则。例如，在瑞典语中，存在以下关系，这不是说德语或法语的人所期望的：
Ü = Y < Ö
_general_ci 与 _unicode_ci 归类
对于任何 Unicode 字符集，使用排序规则执行的操作
xxx_general_ci
比使用排序规则的操作更快
xxx_unicode_ci
。例如，
utf8mb4_general_ci排序规则的比较比
utf8mb4_unicode_ci. 原因是
utf8mb4_unicode_ci支持扩展等映射；也就是说，当一个字符与其他字符的组合比较时。例如，
在德语和其他一些语言
ß中等于。还支持缩写和可忽略的字符。
ssutf8mb4_unicode_ciutf8mb4_general_ci是不支持扩展、收缩或可忽略字符的旧式排序规则。它只能在字符之间进行一对一的比较。
为了进一步说明，以下等式在
utf8mb4_general_ci和
中都成立utf8mb4_unicode_ci（有关比较或搜索中的效果，请参阅
第 10.8.6 节，“整理效果的示例”）：
Ä = A
Ö = O
Ü = U
排序规则之间的区别在于，这适用于
utf8mb4_general_ci：
ß = s
而对于
utf8mb4_unicode_ci支持德语 DIN-1 排序（也称为字典顺序）的 ，情况也是如此：
ß = ss
如果排序utf8mb4_unicode_ci不适用于一种语言，MySQL 将实现特定于语言的 Unicode 排序规则。例如，
utf8mb4_unicode_ci适用于德语词典顺序和法语，因此无需创建特殊utf8mb4排序规则。
utf8mb4_general_ci对德语和法语来说也是令人满意的，只是ß等于s，而不是
ss。如果这对您的应用程序来说是可以接受的，您应该使用
它，utf8mb4_general_ci因为它更快。如果这是不可接受的（例如，如果您需要德语词典顺序），请使用它，utf8mb4_unicode_ci
因为它更准确。
如果您需要德国 DIN-2（电话簿）排序，请使用
utf8mb4_german2_ci排序规则，它将以下字符集比较为相等：
Ä = Æ = AE
Ö = Œ = OE
Ü = UE
ß = ss
utf8mb4_german2_ci类似于
latin1_german2_ci，但后者不比较Æ等于AE
或Œ等于OE。没有utf8mb4_german_ci对应
latin1_german_ci的德语词典顺序，因为utf8mb4_general_ci足够了。
字符整理权重
字符的整理权重确定如下：
对于除（二进制）排序规则之外的所有 Unicode 排序
_bin规则，MySQL 执行表查找以查找字符的排序权重。
对于_binexcept 的排序
utf8mb4_0900_bin规则，权重基于代码点，可能添加前导零字节。
对于utf8mb4_0900_bin，权重是
utf8mb4编码字节。排序顺序与 for 相同utf8mb4_bin，但速度更快。
可以使用该
WEIGHT_STRING()功能显示整理重量。（请参阅
第 12.8 节，“字符串函数和运算符”。）如果排序规则使用权重查找表，但字符不在表中（例如，因为它是“新”字符），则排序权重确定变得更加复杂:
对于通用排序规则 ( xxx_general_ci) 中的 BMP 字符，权重是代码点。
对于 UCA 归类（例如，
xxx_unicode_ci
特定于语言的归类）中的 BMP 字符，应用以下算法：
if (code >= 0x3400 && code <= 0x4DB5)
base= 0xFB80; /* CJK Ideograph Extension */
else if (code >= 0x4E00 && code <= 0x9FA5)
base= 0xFB40; /* CJK Ideograph */
else
base= 0xFBC0; /* All other characters */
aaaa= base +  (code >> 15);
bbbb= (code & 0x7FFF) | 0x8000;
结果是两个整理元素的序列，
aaaa后跟
bbbb. 例如：
mysql> SELECT HEX(WEIGHT_STRING(_ucs2 0x04CF COLLATE ucs2_unicode_ci));
+----------------------------------------------------------+
| HEX(WEIGHT_STRING(_ucs2 0x04CF COLLATE ucs2_unicode_ci)) |
+----------------------------------------------------------+
| FBC084CF                                                 |
+----------------------------------------------------------+
因此，对于所有 UCA 4.0.0 归类， U+04cf CYRILLIC SMALL LETTER
PALOCHKA( )ӏ大于U+04c0
CYRILLIC LETTER PALOCHKA
( Ӏ)。使用 UCA 5.2.0 归类，所有 palochkas 一起排序。
对于一般排序规则中的增补字符，权重是 的权重0xfffd REPLACEMENT
CHARACTER。对于 UCA 4.0.0 归类中的增补字符，它们的归类权重是
0xfffd. 也就是说，对于MySQL来说，所有的增补字符都是相等的，并且大于几乎所有的BMP字符。
Deseret 字符和的示例
COUNT(DISTINCT)：
CREATE TABLE t (s1 VARCHAR(5) CHARACTER SET utf32 COLLATE utf32_unicode_ci);
INSERT INTO t VALUES (0xfffd);   /* REPLACEMENT CHARACTER */
INSERT INTO t VALUES (0x010412); /* DESERET CAPITAL LETTER BEE */
INSERT INTO t VALUES (0x010413); /* DESERET CAPITAL LETTER TEE */
SELECT COUNT(DISTINCT s1) FROM t;
结果为 2，因为在 MySQL
xxx_unicode_ci
排序规则中，替换字符的权重为
0x0dc6，而 Deseret Bee 和 Deseret Tee 的权重均为0xfffd。（如果使用utf32_general_ci排序规则，则结果为 1，因为所有三个字符0xfffd在该排序规则中的权重均为。）
楔形文字字符和 的示例
WEIGHT_STRING()：
/*
The four characters in the INSERT string are
00000041  # LATIN CAPITAL LETTER A
0001218F  # CUNEIFORM SIGN KAB
000121A7  # CUNEIFORM SIGN KISH
00000042  # LATIN CAPITAL LETTER B
*/
CREATE TABLE t (s1 CHAR(4) CHARACTER SET utf32 COLLATE utf32_unicode_ci);
INSERT INTO t VALUES (0x000000410001218f000121a700000042);
SELECT HEX(WEIGHT_STRING(s1)) FROM t;
结果是：
0E33 FFFD FFFD 0E4A
0E33并且0E4A是
UCA 4.0.0中的主要权重。FFFD是 KAB 和 KISH 的权重。
所有增补字符彼此相等的规则不是最优的，但预计不会造成麻烦。这些字符非常罕见，因此多字符字符串完全由增补字符组成的情况非常罕见。在日本，由于补充字符是晦涩的汉字表意文字，所以一般用户无论如何都不关心它们的顺序。如果您真的希望行按 MySQL 规则排序，然后按代码点值排序，很容易：
ORDER BY s1 COLLATE utf32_unicode_ci, s1 COLLATE utf32_bin
对于基于高于 4.0.0 的 UCA 版本的增补字符（例如，
xxx_unicode_520_ci），增补字符不一定都具有相同的整理权重。有些具有来自 UCAallkeys.txt文件的明确权重。其他人根据此算法计算权重：
aaaa= base +  (code >> 15);
bbbb= (code & 0x7FFF) | 0x8000;
“按字符的代码值排序”和“按字符的二进制表示排序”
之间存在差异，这种差异仅在 , 中出现utf16_bin，因为有代理项。
假设utf16_bin（的二进制排序规则）是“逐字节”而不是
“逐字符utf16”的二进制比较。”如果是这样，字符的顺序将与 中的顺序不同。例如，下图显示了两个稀有字符。第一个字符在范围内
- ，因此它大于代理项但小于补充项。第二个字符是一个补充。
utf16_binutf8mb4_binE000FFFFCode point  Character                    utf8mb4      utf16
----------  ---------                    -------      -----
0FF9D       HALFWIDTH KATAKANA LETTER N  EF BE 9D     FF 9D
10384       UGARITIC LETTER DELTA        F0 90 8E 84  D8 00 DF 84
图表中的两个字符按代码点值排序，因为0xff9d<
0x10384。它们按
utf8mb4值排序，因为
0xef< 0xf0。utf16但是如果我们使用逐字节比较，它们不是按值排序的，因为0xff>
0xd8。
所以MySQL的utf16_bin排序不是
“逐字节的”。”它是“按代码点。”当 MySQL 在 中看到增补字符编码时utf16，它会转换为字符的代码点值，然后进行比较。因此，
utf8mb4_bin和
utf16_bin是相同的排序。这与 UCS_BASIC 归类的 SQL:2008 标准要求一致：“UCS_BASIC 是一种排序规则，其中排序完全由要排序的字符串中字符的 Unicode 标量值决定。它适用于 UCS 字符库。由于每个字符指令集都是 UCS 指令集的一个子集，因此 UCS_BASIC 归类可能适用于每个字符集。注 11：字符的 Unicode 标量值是将其代码点视为无符号整数。”
如果字符集是ucs2，则比较是逐字节进行的，但ucs2无论如何，字符串不应包含代理项。
杂项资料
xxx_general_mysql500_ci
归类保留原始归类的 pre-5.1.24 顺序，
并
xxx_general_ci
允许升级在 MySQL 5.1.24 之前创建的表（错误 #27877）。
© Mysql 中文网
