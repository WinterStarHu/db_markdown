# A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集_MySQL 8.0 参考手册

A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集_MySQL 8.0 参考手册
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
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
这组常见问题源于 MySQL 的支持和开发组在处理许多有关 CJK（中文-日文-韩文）问题的查询方面的经验。
A.11.1。
MySQL 中有哪些 CJK 字符集？
A.11.2。
我已将 CJK 字符插入到我的表中。为什么 SELECT 将它们显示为“？” 人物？
A.11.3.
使用Big5汉字集需要注意哪些问题？
A.11.4。
为什么日语字符集转换失败？
A.11.5。
SJIS 81CA转cp932怎么办？
A.11.6.
MySQL 是如何表示日元（¥）符号的？
A.11.7。
在 MySQL 中使用韩语字符集时应该注意哪些问题？
A.11.8。
为什么我会收到不正确的字符串值错误消息？
A.11.9.
为什么我的 GUI 前端或浏览器在我使用 Access、PHP 或其他 API 的应用程序中错误地显示 CJK 字符？
A.11.10。
我已经升级到 MySQL 8.0。关于字符集，我怎样才能恢复到 MySQL 4.0 中那样的行为？
A.11.11。
为什么某些使用 CJK 字符的 LIKE 和 FULLTEXT 搜索会失败？
A.11.12。
我如何知道字符 X 是否在所有字符集中都可用？
A.11.13。
为什么 CJK 字符串在 Unicode 中排序不正确？（我）
A.11.14。
为什么 CJK 字符串在 Unicode 中排序不正确？（二）
A.11.15。
为什么我的增补字符被 MySQL 拒绝？
A.11.16.
“CJK”应该是“CJKV”吗？
A.11.17.
MySQL 是否允许在数据库和表名中使用 CJK 字符？
A.11.18。
在哪里可以找到 MySQL 手册的中文、日文和韩文译本？
A.11.19。
我在哪里可以获得有关 CJK 和 MySQL 中相关问题的帮助？
A.11.1。
MySQL 中有哪些 CJK 字符集？
CJK 字符集列表可能因 MySQL 版本而异。例如，gb18030MySQL 5.7.4 之前的字符集是不支持的。但是，由于适用语言的名称出现在
表DESCRIPTION中每个条目的列中
INFORMATION_SCHEMA.CHARACTER_SETS
，您可以使用此查询获取所有非 Unicode CJK 字符集的当前列表：
mysql> SELECT CHARACTER_SET_NAME, DESCRIPTION
FROM INFORMATION_SCHEMA.CHARACTER_SETS
WHERE DESCRIPTION LIKE '%Chin%'
OR DESCRIPTION LIKE '%Japanese%'
OR DESCRIPTION LIKE '%Korean%'
ORDER BY CHARACTER_SET_NAME;
+--------------------+---------------------------------+
| CHARACTER_SET_NAME | DESCRIPTION                     |
+--------------------+---------------------------------+
| big5               | Big5 Traditional Chinese        |
| cp932              | SJIS for Windows Japanese       |
| eucjpms            | UJIS for Windows Japanese       |
| euckr              | EUC-KR Korean                   |
| gb18030            | China National Standard GB18030 |
| gb2312             | GB2312 Simplified Chinese       |
| gbk                | GBK Simplified Chinese          |
| sjis               | Shift-JIS Japanese              |
| ujis               | EUC-JP Japanese                 |
+--------------------+---------------------------------+
（有关更多信息，请参阅
第 26.3.4 节，“INFORMATION_SCHEMA CHARACTER_SETS 表”。）
MySQL 支持
中华人民共和国官方的GB（国标标准，或国家标准，或简体中文gb2312）字符集的三种变体： ，，gbk和（自 MySQL 5.7.4 起）gb18030。
有时人们会尝试将gbk字符插入到gb2312中，并且它在大多数情况下都有效，因为gbk它是 的超集
gb2312。但最终他们尝试插入一个更罕见的汉字，但它不起作用。（有关示例，请参见错误 #16072）。
在这里，我们参考官方文档
，尝试明确一下gb2312or中哪些字符是合法的。gbk请在报告gb2312或
gbk错误之前检查这些参考资料：
MySQLgbk字符集实际上是
“ Microsoft code page 936 ”。gbk这与字符
A1A4（中点）、
A1AA（破折号）、
A6E0-A6F5和
的官方不同A8BB-A8C0。
有关gbk/Unicode 映射的列表，请参阅
http://www.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP936.TXT。
也可以将 CJK 字符存储在 Unicode 字符集中，尽管可用的排序规则可能不会像您期望的那样对字符进行排序：
utf8和ucs2
字符集支持来自 Unicode 基本多语言平面 (BMP) 的字符
。这些字符的代码点值介于U+0000和
之间U+FFFF。
、utf8mb4、和字符集支持 BMP 字符utf16，
以及位于 BMP 之外的增补字符。增补字符的代码点值介于
和之间。
utf16leutf32U+10000U+10FFFF
用于 Unicode 字符集的排序规则决定了对集合中的字符进行排序（即区分）的能力：
基于 Unicode 归类算法 (UCA) 4.0.0 的归类仅区分 BMP 字符。
基于 UCA 5.2.0 或 9.0.0 的排序规则区分 BMP 和增补字符。
非 UCA 归类可能无法区分所有 Unicode 字符。例如，utf8mb4
默认排序规则是utf8mb4_general_ci，它只区分 BMP 字符。
此外，区分字符与按照给定 CJK 语言的约定对它们进行排序不同。目前，MySQL 只有一种特定于 CJK 的 UCA 排序规则
gb18030_unicode_520_ci（需要使用非 Unicodegb18030字符集）。
有关 Unicode 归类及其区分属性（包括增补字符的归类属性）的信息，请参阅
第 10.10.1 节，“Unicode 字符集”。
A.11.2。
我已将 CJK 字符插入到我的表中。为什么
SELECT将它们显示为
“ ？”人物？
此问题通常是由于 MySQL 中的设置与应用程序或操作系统的设置不匹配造成的。以下是纠正此类问题的一些常见步骤：
确定您使用的是什么 MySQL 版本。
使用语句SELECT VERSION();来确定这一点。
确保数据库实际使用所需的字符集。
人们通常认为客户端字符集总是与服务器字符集或用于显示目的的字符集相同。然而，这两个都是错误的假设。您可以通过检查结果来确定，或者更好的是，使用以下语句：
SHOW CREATE TABLE
tablenameSELECT character_set_name, collation_name
FROM information_schema.columns
WHERE table_schema = your_database_name
AND table_name = your_table_name
AND column_name = your_column_name;
确定未正确显示的一个或多个字符的十六进制值。
您可以
使用以下查询
获取column_name表中列的
此信息：table_nameSELECT HEX(column_name)
FROM table_name;
3F是
?字符的编码；这意味着这
?是实际存储在列中的字符。这最常发生是因为将特定字符从您的客户端字符集转换为目标字符集时出现问题。
确保往返是可能的。当你选择literal（或
_introducer hexadecimal-value）时，你得到literal的结果是？
例如日语的片假名字符
Pe ( ペ')存在于所有的CJK字符集中，其码点值（十六进制编码）0x30da。要测试此角色的往返行程，请使用以下查询：
SELECT 'ペ' AS `ペ`;         /* or SELECT _ucs2 0x30da; */
如果结果不是 also ペ，则往返失败。
对于有关此类故障的错误报告，我们可能会要求您跟进SELECT HEX('ペ');。然后我们可以判断客户端编码是否正确。
确保问题不是出在浏览器或其他应用程序上，而不是出在 MySQL上。
使用mysql客户端程序来完成这个任务。如果mysql正确显示字符但你的应用程序没有，你的问题可能是由于系统设置。
要确定您的设置，请使用
SHOW VARIABLES语句，其输出应类似于此处显示的内容：
mysql> SHOW VARIABLES LIKE 'char%';
+--------------------------+----------------------------------------+
| Variable_name            | Value                                  |
+--------------------------+----------------------------------------+
| character_set_client     | utf8                                   |
| character_set_connection | utf8                                   |
| character_set_database   | latin1                                 |
| character_set_filesystem | binary                                 |
| character_set_results    | utf8                                   |
| character_set_server     | latin1                                 |
| character_set_system     | utf8                                   |
| character_sets_dir       | /usr/local/mysql/share/mysql/charsets/ |
+--------------------------+----------------------------------------+utf8这些是连接到西方服务器（latin1是西欧字符集）
的面向国际的客户端（注意使用 Unicode）的典型字符集设置
。
尽管 Unicode（通常是utf8
Unix 上的ucs2变体和 Windows 上的变体）比拉丁语更可取，但它通常不是您的操作系统实用程序最支持的。许多 Windows 用户发现 Microsoft 字符集（例如
cp932日语 Windows）是合适的。
如果您无法控制服务器设置，并且不知道底层计算机使用什么设置，请尝试更改为您所在国家/地区的通用字符集（euckr= 韩国；
gb18030，gb2312或
gbk= 中华人民共和国；
big5= 台湾；sjis,
ujis, cp932, 或
eucjpms= 日本；ucs2
或utf8= 任何地方）。通常只需要更改客户端和连接以及结果设置。的SET
NAMES。语句同时更改所有三个。例如：
SET NAMES 'big5';my.cnf设置正确后，您可以通过编辑或
使其永久化my.ini。例如，您可以添加如下所示的行：
[mysqld]
character-set-server=big5
[client]
default-character-set=big5
您的应用程序中使用的 API 配置设置也可能存在问题；请参阅
为什么我的 GUI 前端或浏览器无法正确显示 CJK 字符...？了解更多信息。
A.11.3.
使用Big5汉字集需要注意哪些问题？
MySQL 支持香港和台湾（中华民国）通用的 Big5 字符集。MySQL
big5字符集实际上是 Microsoft 代码页 950，与原始
big5字符集非常相似。
HKSCS已提交
添加扩展的功能请求。需要此扩展的人可能会对 Bug #13577 的建议补丁感兴趣。
A.11.4。
为什么日语字符集转换失败？
MySQL 支持sjis、
ujis、cp932和
eucjpms字符集，以及 Unicode。一个常见的需求是在字符集之间进行转换。例如，可能有一个 Unix 服务器（通常带有
sjis或ujis）和一个 Windows 客户端（通常带有cp932）。
在下面的转换表中，ucs2
列代表源，sjis、
cp932、ujis和
eucjpms列代表目的地；也就是说，当我们使用CONVERT(ucs2)或将ucs2包含值的列
分配给sjis、cp932、
ujis或eucjpms列时，最后 4 列提供十六进制结果。
角色名字
ucs2
sjis
cp932
乌吉斯
eucjpms
断条
00A6
3F
3F
8FA2C3
3F
全宽断条
FFE4
3F
FA55
3F
8FA2
日元符号
00A5
3F
3F
20
3F
全角日元标志
FFE5
818F
818F
A1EF
3F
波浪线
007E
7E
7E
7E
7E
上划线
203E
3F
3F
20
3F
单杠
2015年
815C
815C
A1BD
A1BD
EM破折号
2014
3F
3F
3F
3F
反向固相线
005C
815F
5C
5C
5C
全角反向单线
最终幻想3
3F
815F
3F
A1C0
波浪冲刺
301C
8160
3F
A1C1
3F
全角波浪线
FF5E
3F
8160
3F
A1C1
双竖线
2016年
8161
3F
A1C2
3F
平行
2225
3F
8161
3F
A1C2
减号
2212
817C
3F
A1DD
3F
全角连字符减号
FF0D
3F
817C
3F
A1DD
美分符号
00A2
8191
3F
A1F1
3F
全角美分符号
FFE0
3F
8191
3F
A1F1
英镑符号
00A3
8192
3F
A1F2
3F
全角磅符号
FFE1
3F
8192
3F
A1F2
不签字
00AC
81CA
3F
A2CC
3F
全角无符号
FFE2
3F
81CA
3F
A2CC
现在考虑表的以下部分。
ucs2
sjis
cp932
不签字
00AC
81CA
3F
全角无符号
FFE2
3F
81CA
这意味着 MySQL 将NOT SIGN
(Unicode U+00AC) 转换为sjis
code point0x81CA和
cp932code point 3F。（3F是问号（“ ？ ”。这是无法执行转换时始终使用的问号。）
A.11.5。
如果我想将 SJIS 转换为 ，我应该怎么
81CA做cp932？
我们的回答是：“ ？”。这样做有缺点，许多人更喜欢“松散”
转换，这样81CA (NOT SIGN)in
sjis就变成81CA (FULLWIDTH NOT
SIGN)in 了cp932。
A.11.6.
MySQL 是如何表示日元( ¥) 符号的？
出现问题是因为某些版本的日文字符集（包括sjis和euc）将5C其视为
反斜线
（\，也称为反斜线），而其他版本将其视为日元符号 ( ¥)。
MySQL 只遵循一个版本的 JIS（日本工业标准）标准描述。在 MySQL 中，
5C总是反向斜线 ( \)。
A.11.7。
在 MySQL 中使用韩语字符集时应该注意哪些问题？
理论上，虽然有多个版本的
euckr（Extended Unix Code Korea）字符集，但只注意到一个问题。我们使用 EUC-KR 的“ ASCII ”变体，其中代码点0x5c为 REVERSE SOLIDUS，即\，而不是 EUC-KR 的
“ KS-Roman ”变体，其中代码点0x5c为WON SIGN
( ₩)。这意味着您不能将 Unicode 转换U+20A9为euckr：
mysql> SELECT
CONVERT('₩' USING euckr) AS euckr,
HEX(CONVERT('₩' USING euckr)) AS hexeuckr;
+-------+----------+
| euckr | hexeuckr |
+-------+----------+
| ?     | 3F       |
+-------+----------+A.11.8。
为什么我会收到不正确的字符串值错误消息？
要查看问题，请创建一个包含一个 Unicode ( ucs2) 列和一个中文 ( gb2312) 列的表。
mysql> CREATE TABLE ch
(ucs2 CHAR(3) CHARACTER SET ucs2,
gb2312 CHAR(3) CHARACTER SET gb2312);
在非严格 SQL 模式下，尝试将罕见字符
汌放在两列中。
mysql> SET sql_mode = '';
mysql> INSERT INTO ch VALUES ('A汌B','A汌B');
Query OK, 1 row affected, 1 warning (0.00 sec)
会INSERT产生警告。使用以下语句查看它是什么：
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Warning
Code: 1366
Message: Incorrect string value: '\xE6\xB1\x8CB' for column 'gb2312' at row 1
所以这只是关于该gb2312列的警告。
mysql> SELECT ucs2,HEX(ucs2),gb2312,HEX(gb2312) FROM ch;
+-------+--------------+--------+-------------+
| ucs2  | HEX(ucs2)    | gb2312 | HEX(gb2312) |
+-------+--------------+--------+-------------+
| A汌B | 00416C4C0042 | A?B    | 413F42      |
+-------+--------------+--------+-------------+
这里有几件事需要解释：
如前所述，
该汌字符不在
字符集中。gb2312
如果您使用的是旧版本的 MySQL，您可能会看到不同的消息。
出现警告而不是错误，因为 MySQL 未设置为使用严格 SQL 模式。在非严格模式下，MySQL 会尽力而为，以获得最佳匹配，而不是放弃。在严格 SQL 模式下，Incorrect string value消息作为错误而不是警告出现，并且INSERT
失败。
A.11.9.
为什么我的 GUI 前端或浏览器在我使用 Access、PHP 或其他 API 的应用程序中错误地显示 CJK 字符？
使用mysql客户端
获取到服务器的直接连接
，并在那里尝试相同的查询。如果mysql正确响应，问题可能是您的应用程序接口需要初始化。使用
mysql来告诉您它在语句中使用的字符集SHOW VARIABLES LIKE
'char%';。如果您使用的是 Access，则很可能使用连接器/ODBC 进行连接。在这种情况下，您应该检查
Configuring Connector/ODBC。例如，如果您使用big5，您将输入SET
NAMES 'big5'。（在这种情况下，不需要任何;
字符。）如果您使用的是 ASP，则可能需要添加SET NAMES在代码中。这是过去有效的示例：
<%
Session.CodePage=0
Dim strConnection
Dim Conn
strConnection="driver={MySQL ODBC 3.51 Driver};server=server;uid=username;" \
& "pwd=password;database=database;stmt=SET NAMES 'big5';"
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open strConnection
%>latin1以几乎相同的方式，如果您使用的是Connector/NET
以外的任何字符集，则必须在连接字符串中指定字符集。有关详细信息，请参阅
连接器/NET 连接。
如果您使用的是 PHP，请尝试以下操作：
<?php
$link = new mysqli($host, $usr, $pwd, $db);
if( mysqli_connect_errno() )
{
printf("Connect failed: %s\n", mysqli_connect_error());
exit();
}
$link->query("SET NAMES 'utf8'");
?>
在这种情况下，我们曾经SET NAMES
更改character_set_client、
character_set_connection和
character_set_results。
PHP 应用程序中经常遇到的另一个问题与浏览器所做的假设有关。有时添加或更改<meta>标签足以解决问题：例如，为了确保用户代理将页面内容解释为UTF-8，包含
<meta http-equiv="Content-Type" content="text/html;
charset=utf-8">在
<head>HTML 页面的部分中。
如果您使用的是 Connector/J，请参阅
使用字符集和 Unicode。
A.11.10。
我已经升级到 MySQL 8.0。关于字符集，我怎样才能恢复到 MySQL 4.0 中那样的行为？
在 MySQL 4.0 版中，服务器和客户端都有一个“全局”
字符集，使用哪个字符由服务器管理员决定。这从 MySQL 版本 4.1 开始发生了变化。现在发生的是“握手”，如
第 10.4 节“连接字符集和排序规则”中所述：
当客户端连接时，它向服务器发送它想要使用的字符集的名称。服务器使用名称来设置
character_set_client、
character_set_results和
character_set_connection
系统变量。实际上，服务器
SET NAMES使用字符集名称执行操作。
这样做的效果是您无法通过启动mysqld来
控制客户端字符集--character-set-server=utf8。然而，一些亚洲客户更喜欢 MySQL 4.0 的行为。为了能够保留此行为，我们添加了一个
mysqld开关，
--character-set-client-handshake可以使用 关闭它
--skip-character-set-client-handshake。如果您使用 启动mysqld，
--skip-character-set-client-handshake那么当客户端连接时，它会向服务器发送它想要使用的字符集的名称。但是，服务器忽略了客户端的这个请求。
例如，假设您最喜欢的服务器字符集是latin1. 进一步假设客户端使用utf8，因为这是客户端操作系统支持的。latin1使用默认字符集
启动服务器
：mysqld --character-set-server=latin1
然后使用默认字符集启动客户端
utf8：
mysql --default-character-set=utf8
通过查看以下输出可以看到生成的设置
SHOW VARIABLES：
mysql> SHOW VARIABLES LIKE 'char%';
+--------------------------+----------------------------------------+
| Variable_name            | Value                                  |
+--------------------------+----------------------------------------+
| character_set_client     | utf8                                   |
| character_set_connection | utf8                                   |
| character_set_database   | latin1                                 |
| character_set_filesystem | binary                                 |
| character_set_results    | utf8                                   |
| character_set_server     | latin1                                 |
| character_set_system     | utf8                                   |
| character_sets_dir       | /usr/local/mysql/share/mysql/charsets/ |
+--------------------------+----------------------------------------+
现在停止客户端，并使用
mysqladmin停止服务器。然后再次启动服务器，但这次告诉它跳过握手，如下所示：
mysqld --character-set-server=utf8 --skip-character-set-client-handshakeutf8再次以默认字符集
启动客户端，然后显示结果设置：mysql> SHOW VARIABLES LIKE 'char%';
+--------------------------+----------------------------------------+
| Variable_name            | Value                                  |
+--------------------------+----------------------------------------+
| character_set_client     | latin1                                 |
| character_set_connection | latin1                                 |
| character_set_database   | latin1                                 |
| character_set_filesystem | binary                                 |
| character_set_results    | latin1                                 |
| character_set_server     | latin1                                 |
| character_set_system     | utf8                                   |
| character_sets_dir       | /usr/local/mysql/share/mysql/charsets/ |
+--------------------------+----------------------------------------+
通过比较来自 的不同结果可以看出，
如果
使用该选项
SHOW VARIABLES，服务器将忽略客户端的初始设置
。--skip-character-set-client-handshakeA.11.11。
为什么某些使用 CJK 字符的LIKEand
FULLTEXT搜索会失败？
对于LIKE搜索，二进制字符串列类型（例如
BINARYand
）存在一个非常简单的问题BLOB：我们必须知道字符在哪里结束。对于多字节字符集，不同的字符可能具有不同的八位字节长度。例如，在 中
utf8，A需要一个字节，但ペ需要三个字节，如下所示：
+-------------------------+---------------------------+
| OCTET_LENGTH(_utf8 'A') | OCTET_LENGTH(_utf8 'ペ') |
+-------------------------+---------------------------+
|                       1 |                         3 |
+-------------------------+---------------------------+
如果我们不知道字符串中第一个字符在哪里结束，我们就不知道第二个字符从哪里开始，在这种情况下，即使是非常简单的搜索也会
LIKE '_A%'失败。解决方案是使用定义为具有正确 CJK 字符集的非二进制字符串列类型。例如：mycol
TEXT CHARACTER SET sjis。或者，在比较之前转换为 CJK 字符集。
这是 MySQL 不允许对不存在的字符进行编码的原因之一。如果拒绝错误输入不严格，它就无法知道字符在哪里结束。
对于FULLTEXT搜索，我们必须知道单词的开始和结束位置。对于西方语言，这很少成为问题，因为其中大多数（如果不是全部）使用易于识别的单词边界：空格字符。然而，亚洲写作通常不是这种情况。我们可以使用任意的折衷措施，比如假设所有汉字字符都代表单词，或者（对于日语）根据语法结尾从片假名到平假名的变化。然而，唯一确定的解决方案需要一个全面的单词列表，这意味着我们必须在服务器中为支持的每种亚洲语言包含一个字典。这根本不可行。
A.11.12。
我如何知道字符X是否在所有字符集中都可用？
大多数简体中文和基本的非半角日语假名字符出现在所有 CJK 字符集中。以下存储过程接受一个UCS-2
Unicode 字符，将其转换为其他字符集，并以十六进制显示结果。
DELIMITER //
CREATE PROCEDURE p_convert(ucs2_char CHAR(1) CHARACTER SET ucs2)
BEGIN
CREATE TABLE tj
(ucs2 CHAR(1) character set ucs2,
utf8 CHAR(1) character set utf8,
big5 CHAR(1) character set big5,
cp932 CHAR(1) character set cp932,
eucjpms CHAR(1) character set eucjpms,
euckr CHAR(1) character set euckr,
gb2312 CHAR(1) character set gb2312,
gbk CHAR(1) character set gbk,
sjis CHAR(1) character set sjis,
ujis CHAR(1) character set ujis);
INSERT INTO tj (ucs2) VALUES (ucs2_char);
UPDATE tj SET utf8=ucs2,
big5=ucs2,
cp932=ucs2,
eucjpms=ucs2,
euckr=ucs2,
gb2312=ucs2,
gbk=ucs2,
sjis=ucs2,
ujis=ucs2;
/* If there are conversion problems, UPDATE produces warnings. */
SELECT hex(ucs2) AS ucs2,
hex(utf8) AS utf8,
hex(big5) AS big5,
hex(cp932) AS cp932,
hex(eucjpms) AS eucjpms,
hex(euckr) AS euckr,
hex(gb2312) AS gb2312,
hex(gbk) AS gbk,
hex(sjis) AS sjis,
hex(ujis) AS ujis
FROM tj;
DROP TABLE tj;
END//
DELIMITER ;
输入可以是任何单个ucs2字符，也可以是该字符的代码值（十六进制表示）。例如，从Unicode的
ucs2编码和名称列表（http://www.unicode.org/Public/UNIDATA/UnicodeData.txt），我们知道片假名字符
Pe出现在所有的CJK字符集中，其编码值为X'30DA'. 如果我们将此值用作 的参数
p_convert()，结果如下所示：
mysql> CALL p_convert(X'30DA');
+------+--------+------+-------+---------+-------+--------+------+------+------+
| ucs2 | utf8   | big5 | cp932 | eucjpms | euckr | gb2312 | gbk  | sjis | ujis |
+------+--------+------+-------+---------+-------+--------+------+------+------+
| 30DA | E3839A | C772 | 8379  | A5DA    | ABDA  | A5DA   | A5DA | 8379 | A5DA |
+------+--------+------+-------+---------+-------+--------+------+------+------+
由于没有任何列值3F（即问号字符?），我们知道每次转换都有效。
A.11.13。
为什么 CJK 字符串在 Unicode 中排序不正确？（我）
utf8mb4从 MySQL 8.0 开始，可以通过使用字符集和
排序规则
解决旧版 MySQL 中出现的 CJK 排序问题
utf8mb4_ja_0900_as_cs。
A.11.14。
为什么 CJK 字符串在 Unicode 中排序不正确？（二）
utf8mb4从 MySQL 8.0 开始，可以通过使用字符集和
排序规则
解决旧版 MySQL 中出现的 CJK 排序问题
utf8mb4_ja_0900_as_cs。
A.11.15。
为什么我的增补字符被 MySQL 拒绝？
补充字符位于 Unicode基本多语言平面/平面 0之外。BMP 字符的代码点值介于U+0000和
之间U+FFFF。增补字符的代码点值介于U+10000和
之间U+10FFFF。
要存储增补字符，您必须使用允许它们的字符集：
和
字符集仅支持 BMP 字符
utf8。ucs2utf8字符集只允许
UTF-8占用最多三个字节
的字符。这导致了诸如 Bug #12600 之类的报告，我们认为它“不是错误”而予以拒绝。使用
utf8，MySQL 在遇到它不理解的字节时必须截断输入字符串。否则，不知道坏的多字节字符有多长。
一种可能的解决方法是使用ucs2
instead of utf8，在这种情况下，
“坏”字符将更改为问号。但是，不会发生截断。您还可以将数据类型更改为BLOB或
BINARY，这样不执行有效性检查。
、utf8mb4、和字符集支持 BMP 字符utf16，
以及 BMP 之外的增补字符。
utf16leutf32
A.11.16.“ CJK ”
应该是“ CJKV ”吗？
不是。术语“ CJKV ”
（中文日文韩文越南文）是指包含汉字（原本是中文）的越南文字符集。MySQL 支持使用西方字符的现代越南文字，但不支持使用汉字的旧越南文字。
从 MySQL 5.6 开始，Unicode 字符集有越南语排序规则，如
第 10.10.1 节，“Unicode 字符集”中所述。
A.11.17.
MySQL 是否允许在数据库和表名中使用 CJK 字符？
是的。
A.11.18。
在哪里可以找到 MySQL 手册的中文、日文和韩文译本？
MySQL 5.6 手册的日语翻译可以从https://mysql.net.cn/doc/下载。
A.11.19。
我在哪里可以获得有关 CJK 和 MySQL 中相关问题的帮助？
以下资源可用：
可以在
https://wikis.oracle.com/display/mysql/List+of+MySQL+User+Groups找到 MySQL 用户组列表。
在http://tinyurl.com/y6xcuf
查看与字符集问题相关的功能请求
。
访问 MySQL
字符集、排序规则、Unicode 论坛。
http://forums.mysql.com/也提供外语论坛。
© Mysql 中文网
