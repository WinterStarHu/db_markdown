# 13.2.7 加载数据语句_MySQL 8.0 参考手册

13.2.7 加载数据语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.11 子查询1
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.7 加载数据语句
13.2.7 加载数据语句
LOAD DATA
[LOW_PRIORITY | CONCURRENT] [LOCAL]
INFILE 'file_name'
[REPLACE | IGNORE]
INTO TABLE tbl_name
[PARTITION (partition_name [, partition_name] ...)]
[CHARACTER SET charset_name]
[{FIELDS | COLUMNS}
[TERMINATED BY 'string']
[[OPTIONALLY] ENCLOSED BY 'char']
[ESCAPED BY 'char']
]
[LINES
[STARTING BY 'string']
[TERMINATED BY 'string']
]
[IGNORE number {LINES | ROWS}]
[(col_name_or_user_var
[, col_name_or_user_var] ...)]
[SET col_name={expr | DEFAULT}
[, col_name={expr | DEFAULT}] ...]
该LOAD DATA语句以非常高的速度将文本文件中的行读入表中。该文件可以从服务器主机或客户端主机读取，具体取决于是否LOCAL给出修饰符。
LOCAL还会影响数据解释和错误处理。
LOAD DATA是的补充
SELECT ... INTO
OUTFILE。（请参阅第 13.2.10.1 节，“SELECT ... INTO 语句”。）要将数据从表写入文件，请使用
SELECT ... INTO
OUTFILE. 要将文件读回表中，请使用
LOAD DATA. FIELDS两个语句的and子句语法
LINES相同。
mysqlimport实用程序提供了另一种加载数据文件
的方法；它通过向
LOAD DATA服务器发送语句来运行。请参阅第 4.5.5 节，“mysqlimport — 数据导入程序”。
有关
INSERTvs
LOAD DATA和加速
的效率的信息LOAD DATA，请参阅
第 8.2.5.1 节，“优化 INSERT 语句”。
非本地与本地操作输入文件字符集输入文件位置安全要求重复键和错误处理索引处理现场和线路处理列列表规范输入预处理列值赋值分区表支持并发注意事项报表结果信息复制注意事项杂项话题
非本地与本地操作
与非操作
相比，
修饰符LOCAL会影响这些方面
：LOAD DATALOCAL
它改变了输入文件的预期位置；请参阅
输入文件位置。
它改变了声明的安全要求；请参阅
安全要求。
IGNORE
与修饰符对输入文件内容的解释和错误处理
具有相同的作用；请参阅
Duplicate-Key and Error Handling和
Column Value Assignment。
LOCAL仅当服务器和您的客户端都已配置为允许时才有效。例如，如果
mysqld是在
local_infile禁用系统变量的情况下启动的，则会LOCAL产生错误。请参阅
第 6.1.6 节，“LOAD DATA LOCAL 的安全注意事项”。
输入文件字符集
文件名必须作为文字字符串给出。在 Windows 上，将路径名中的反斜杠指定为正斜杠或双反斜杠。character_set_filesystem服务器使用系统变量
指示的字符集解释文件名
。
默认情况下，服务器使用
character_set_database系统变量指示的字符集解释文件内容。如果文件内容使用的字符集与此默认值不同，最好使用CHARACTER SET子句指定该字符集。字符集binary指定“不转换。”
SET NAMES和设置
character_set_client不影响文件内容的解释。
LOAD DATA将文件中的所有字段解释为具有相同的字符集，而不管字段值加载到的列的数据类型如何。为了正确解释文件，您必须确保它是用正确的字符集编写的。例如，如果您使用mysqldump -T或通过在mysql中发出SELECT
... INTO OUTFILE语句来
写入数据文件，请务必使用一个
选项以在文件加载时使用的字符集写入输出。
--default-character-setLOAD DATA
笔记
无法加载使用
ucs2、utf16、
utf16le或utf32
字符集的数据文件。
输入文件位置
这些规则决定了LOAD
DATA输入文件的位置：
如果LOCAL未指定，则文件必须位于服务器主机上。服务器直接读取文件，定位如下：
如果文件名是绝对路径名，服务器将按给定的方式使用它。
如果文件名是具有前导组件的相对路径名，则服务器将查找相对于其数据目录的文件。
如果文件名没有前导部分，服务器将在默认数据库的数据库目录中查找该文件。
如果LOCAL指定，则文件必须位于客户端主机上。客户端程序读取文件，定位如下：
如果文件名是绝对路径名，则客户端程序按给定的方式使用它。
如果文件名是相对路径名，则客户端程序查找相对于其调用目录的文件。
使用LOCAL时，客户端程序读取文件并将其内容发送到服务器。服务器在存储临时文件的目录中创建该文件的副本。请参阅
第 B.3.3.5 节，“MySQL 存储临时文件的位置”。此目录中的副本空间不足会导致
LOAD DATA
LOCAL语句失败。
非LOCAL规则意味着服务器读取一个名为 as 的文件相对于它的数据目录，而它从默认数据库的数据库目录./myfile.txt读取一个名为 as 的文件
。myfile.txt例如，如果在
默认数据库LOAD DATA中执行以下语句，服务器会从数据库目录中读取文件，即使该语句显式地将文件加载到
数据库中的表中也是如此：
db1data.txtdb1db2LOAD DATA INFILE 'data.txt' INTO TABLE db2.my_table;
笔记
服务器还使用非LOCAL规则来定位语句
.sdi的文件
。IMPORT TABLE
安全要求
对于非LOCAL加载操作，服务器读取位于服务器主机上的文本文件，因此必须满足以下安全要求：
你必须有FILE
特权。请参阅第 6.2.2 节，“MySQL 提供的权限”。
操作以
secure_file_priv系统变量设置为准：
如果变量值是一个非空目录名，则该文件必须位于该目录中。
如果变量值为空（这是不安全的），则该文件只需要可由服务器读取。
对于LOCAL加载操作，客户端程序读取位于客户端主机上的文本文件。因为文件内容是由客户端通过连接发送到服务器的，所以使用LOCAL比服务器直接访问文件要慢一点。另一方面，您不需要FILE
特权，文件可以位于客户端程序可以访问的任何目录中。
重复键和错误处理
REPLACE和IGNORE
修饰符控制在唯一键值（PRIMARY
KEY或UNIQUE索引值）
上复制现有表行的新（输入）行
的处理：
使用REPLACE，与现有行中的唯一键值具有相同值的新行将替换现有行。请参阅第 13.2.9 节，“REPLACE 语句”。
使用IGNORE，将丢弃在唯一键值上复制现有行的新行。有关详细信息，请参阅
IGNORE 对语句执行的影响。
修饰符与LOCAL具有相同的效果
IGNORE。发生这种情况是因为服务器无法在操作过程中停止文件的传输。
如果未指定REPLACE、
IGNORE或LOCAL，则在找到重复的键值时会发生错误，并忽略文本文件的其余部分。
除了影响刚刚描述的重复键处理外，IGNORE还会
LOCAL影响错误处理：
对于 neither IGNOREnor
LOCAL，数据解释错误会终止操作。
使用IGNOREorLOCAL时，数据解释错误变为警告并且加载操作继续，即使 SQL 模式是限制性的。有关示例，请参阅
列值分配。
索引处理
要在加载操作期间忽略外键约束，请在执行SET foreign_key_checks = 0
之前执行一条语句LOAD
DATA。
如果您LOAD DATA在空
MyISAM表上使用，所有非唯一索引都将在单独的批次中创建（对于REPAIR
TABLE）。通常，LOAD
DATA当您有很多索引时，这会更快。在某些极端情况下，您可以更快地创建索引，方法是ALTER
TABLE ... DISABLE KEYS在将文件加载到表中之前关闭它们，并在加载文件后重新创建索引
ALTER TABLE ...
ENABLE KEYS。请参阅
第 8.2.5.1 节，“优化 INSERT 语句”。
现场和线路处理
对于LOAD DATAand
SELECT ... INTO
OUTFILE语句，
FIELDSandLINES子句的语法是相同的。这两个子句都是可选的，但
如果两者都指定
，则FIELDS必须放在前面。LINES
如果您指定一个FIELDS子句，则其每个子句（TERMINATED BY、
[OPTIONALLY] ENCLOSED BY和
ESCAPED BY）也是可选的，除非您必须至少指定其中一个。这些子句的参数只允许包含 ASCII 字符。
如果您指定 no FIELDSor
LINES子句，则默认值与您编写此内容时的默认值相同：
FIELDS TERMINATED BY '\t' ENCLOSED BY '' ESCAPED BY '\\'
LINES TERMINATED BY '\n' STARTING BY ''
反斜杠是 SQL 语句中字符串中的 MySQL 转义字符。因此，要指定文字反斜杠，您必须为要解释为单个反斜杠的值指定两个反斜杠。转义序列'\t'
分别'\n'指定制表符和换行符。
换句话说，默认值会导致LOAD
DATA读取输入时的行为如下：
在换行处寻找行边界。
不要跳过任何行前缀。
在选项卡处将行分成字段。
不要期望字段包含在任何引号字符中。
将转义字符前面的字符解释
\为转义序列。例如，
\t、\n和
\\分别表示制表符、换行符和反斜杠。FIELDS ESCAPED
BY有关转义序列的完整列表，
请参阅稍后的讨论。
相反，默认值会导致
SELECT ... INTO
OUTFILE写入输出时的行为如下：
在字段之间写制表符。
不要将字段括在任何引号字符中。
用于\转义制表符、换行符或\出现在字段值中的实例。
在行尾写换行符。
笔记
对于在 Windows 系统上生成的文本文件，可能需要正确读取文件，LINES TERMINATED BY
'\r\n'因为 Windows 程序通常使用两个字符作为行终止符。某些程序（例如
写字板）可能会\r在写入文件时用作行终止符。要读取此类文件，请使用
LINES TERMINATED BY '\r'.
如果所有输入行都有一个你想忽略的公共前缀，你可以使用跳过前缀和它之前的任何内容。如果一行不包含前缀，则跳过整行。假设您发出以下语句：
LINES STARTING BY
'prefix_string'LOAD DATA INFILE '/tmp/test.txt' INTO TABLE test
FIELDS TERMINATED BY ','  LINES STARTING BY 'xxx';
如果数据文件是这样的：
xxx"abc",1
something xxx"def",2
"ghi",3
结果行是("abc",1)和
("def",2)。文件中的第三行被跳过，因为它不包含前缀。
该子句可用于忽略文件开头的行。例如，您可以使用跳过包含列名的初始标题行：
IGNORE number
LINESIGNORE 1
LINESLOAD DATA INFILE '/tmp/test.txt' INTO TABLE test IGNORE 1 LINES;
当您SELECT
... INTO OUTFILE串联使用 with
LOAD DATA将数据从数据库写入文件，然后稍后将该文件读回数据库时，这两个语句的字段和行处理选项必须匹配。否则，LOAD
DATA不会正确解释文件的内容。假设您
SELECT ... INTO
OUTFILE用来编写一个文件，其中的字段以逗号分隔：
SELECT * INTO OUTFILE 'data.txt'
FIELDS TERMINATED BY ','
FROM table2;
要读取逗号分隔的文件，正确的说法是：
LOAD DATA INFILE 'data.txt' INTO TABLE table2
FIELDS TERMINATED BY ',';
相反，如果您尝试使用如下所示的语句读取文件，它将不起作用，因为它指示
LOAD DATA在字段之间查找制表符：
LOAD DATA INFILE 'data.txt' INTO TABLE table2
FIELDS TERMINATED BY '\t';
可能的结果是每个输入行都将被解释为一个字段。
LOAD DATA可用于读取从外部源获取的文件。例如，许多程序可以以逗号分隔值 (CSV) 格式导出数据，这样行中的字段由逗号分隔并括在双引号中，首行是列名。如果此类文件中的行以回车符/换行符对终止，此处显示的语句说明了用于加载文件的字段和行处理选项：
LOAD DATA INFILE 'data.txt' INTO TABLE tbl_name
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
如果输入值不一定用引号引起来，请在选项
OPTIONALLY前
使用。ENCLOSED BY
任何字段或行处理选项都可以指定一个空字符串 ( '')。如果不为空，则
FIELDS [OPTIONALLY] ENCLOSED BY和
FIELDS ESCAPED BY值必须是单个字符。、FIELDS TERMINATED BY和
值可以LINES STARTING BY是LINES
TERMINATED BY多个字符。例如，要写入由回车符/换行符对终止的行，或要读取包含此类行的文件，请指定一个LINES TERMINATED BY '\r\n'子句。
要读取包含由 组成的行分隔的笑话的文件%%，您可以这样做
CREATE TABLE jokes
(a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
joke TEXT NOT NULL);
LOAD DATA INFILE '/tmp/jokes.txt' INTO TABLE jokes
FIELDS TERMINATED BY ''
LINES TERMINATED BY '\n%%\n' (joke);
FIELDS [OPTIONALLY] ENCLOSED BY控制字段的引用。对于输出 ( SELECT ... INTO
OUTFILE)，如果省略单词
OPTIONALLY，则所有字段都包含在
ENCLOSED BY字符中。此处显示了此类输出的示例（使用逗号作为字段分隔符）：
"1","a string","100.20"
"2","a string containing a , comma","102.20"
"3","a string containing a \" quote","102.20"
"4","a string containing a \", quote and comma","102.20"
如果您指定OPTIONALLY，则该
ENCLOSED BY字符仅用于包含具有字符串数据类型（例如
CHAR、
BINARY、
TEXT或
ENUM）的列中的值：
1,"a string",100.20
2,"a string containing a , comma",102.20
3,"a string containing a \" quote",102.20
4,"a string containing a \", quote and comma",102.20
字段值中字符的出现ENCLOSED BY通过在它们前面加上字符来转义
ESCAPED BY。此外，如果您指定一个空ESCAPED BY值，则可能会无意中生成 无法正确读取的输出
LOAD DATA。例如，如果转义字符为空，刚才显示的前面的输出将如下所示。观察第四行的第二个字段在引号后面包含一个逗号，它（错误地）似乎终止了该字段：
1,"a string",100.20
2,"a string containing a , comma",102.20
3,"a string containing a " quote",102.20
4,"a string containing a ", quote and comma",102.20
对于输入，该ENCLOSED BY字符（如果存在）将从字段值的末尾去除。（无论是否OPTIONALLY指定，这都是正确的；OPTIONALLY对输入解释没有影响。）ENCLOSED
BY字符前面的ESCAPED
BY字符的出现被解释为当前字段值的一部分。
如果字段以该字符开头，则该ENCLOSED BY
字符的实例仅在后跟字段或行
TERMINATED BY序列时才被识别为终止字段值。为避免歧义，ENCLOSED BY字段值中字符的出现次数可以加倍，并被解释为该字符的单个实例。例如，如果
ENCLOSED BY '"'指定，引号的处理方式如下所示：
"The ""BIG"" boss"  -> The "BIG" boss
The "BIG" boss      -> The "BIG" boss
The ""BIG"" boss    -> The ""BIG"" boss
FIELDS ESCAPED BY控制如何读取或写入特殊字符：
对于输入，如果该FIELDS ESCAPED BY
字符不为空，则该字符的出现将被剥离，并且后续字符将按字面意义作为字段值的一部分。一些例外的双字符序列，其中第一个字符是转义字符。这些序列显示在下表中（\用于转义字符）。处理规则NULL将在本节后面描述。
特点
转义序列
\0
一个 ASCII NUL ( X'00') 字符
\b
退格字符
\n
换行（换行）字符
\r
一个回车符
\t
制表符。
\Z
ASCII 26（控制+Z）
\N
无效的
有关\-escape 语法的更多信息，请参阅第 9.1.1 节，“字符串文字”。
如果该FIELDS ESCAPED BY字符为空，则不会进行转义序列解释。
对于输出，如果FIELDS ESCAPED BY
字符不为空，则用于在输出时为以下字符添加前缀：
FIELDS ESCAPED BY性格
。FIELDS [OPTIONALLY] ENCLOSED BY
性格
。FIELDS TERMINATED
BY和值
的第一个字符LINES TERMINATED BY
，如果该ENCLOSED BY字符为空或未指定。
ASCII 0（转义符后面实际写的是 ASCII
0，不是零值字节）。
如果该FIELDS ESCAPED BY字符为空，则不会转义任何字符并NULL
输出为NULL，而不是
\N。指定一个空的转义字符可能不是一个好主意，尤其是当数据中的字段值包含刚刚给出的列表中的任何字符时。
在某些情况下，字段和行处理选项相互作用：
如果LINES TERMINATED BY是空字符串且FIELDS TERMINATED BY非空，则行也以 . 结尾FIELDS TERMINATED
BY。
如果FIELDS TERMINATED BY和
FIELDS ENCLOSED BY值均为空 ( '')，则使用固定行（非定界）格式。对于固定行格式，字段之间不使用分隔符（但您仍然可以使用行终止符）。相反，使用足够宽的字段宽度来读取和写入列值以容纳字段中的所有值。对于
TINYINT、
SMALLINT、
MEDIUMINT、
INT和
BIGINT，无论声明的显示宽度是多少，字段宽度分别为 4、6、8、11 和 20。
LINES TERMINATED BY仍然用于分隔行。如果一行不包含所有字段，则其余列将设置为其默认值。如果您没有行终止符，则应将其设置为
''. 在这种情况下，文本文件必须包含每一行的所有字段。
固定行格式也会影响
NULL值的处理，如后所述。
笔记
如果您使用多字节字符集，则固定大小格式不起作用。
值的处理NULL因使用的FIELDS选项而异LINES
：
对于默认值FIELDS和
LINES值，NULL写入\N为输出的字段值，输入的字段值为\N读取NULL（假设
ESCAPED BY字符为
\）。
如果FIELDS ENCLOSED BY不为空，则将包含文字词NULL作为其值的字段作为值读取NULL。这不同于NULL包含在FIELDS ENCLOSED BY字符中的单词，后者被读作 string 'NULL'。
如果FIELDS ESCAPED BY为空，
NULL则写为单词
NULL。
使用固定行格式（当FIELDS
TERMINATED BY和FIELDS ENCLOSED
BY均为空时使用），NULL写为空字符串。这会导致
NULL表中的值和空字符串在写入文件时无法区分，因为两者都被写入为空字符串。如果您需要在读回文件时能够区分两者，则不应使用固定行格式。
根据列值分配中描述的规则，
尝试加载NULL到NOT
NULL列中会产生警告或错误
。
某些情况不支持LOAD
DATA：
固定大小的行（FIELDS TERMINATED BY并且
FIELDS ENCLOSED BY都是空的）和
BLOB/或
TEXT列。
如果您指定一个与另一个相同的分隔符或前缀，LOAD DATA则无法正确解释输入。例如，以下
FIELDS子句会导致问题：
FIELDS TERMINATED BY '"' ENCLOSED BY '"'
如果FIELDS ESCAPED BY为空，则包含值出现FIELDS
ENCLOSED BY或LINES TERMINATED
BY后跟FIELDS TERMINATED
BY值的字段值会导致LOAD
DATA过早停止读取字段或行。发生这种情况是因为LOAD
DATA无法正确确定字段或行值的结束位置。
列列表规范
以下示例加载表的所有列
persondata：
LOAD DATA INFILE 'persondata.txt' INTO TABLE persondata;
默认情况下，当
LOAD DATA语句末尾未提供列列表时，输入行应包含每个表列的字段。如果只想加载表的某些列，请指定列列表：
LOAD DATA INFILE 'persondata.txt' INTO TABLE persondata
(col_name_or_user_var [, col_name_or_user_var] ...);
如果输入文件中字段的顺序与表中列的顺序不同，您还必须指定一个列列表。否则，MySQL 无法判断如何将输入字段与表列相匹配。
输入预处理
col_name_or_user_var
in语法的
每个实例LOAD DATA都是列名或用户变量。对于用户变量，该
SET子句使您能够在将结果分配给列之前对其值执行预处理转换。
子句中的用户变量SET可以多种方式使用。以下示例直接使用第一个输入列作为 的值t1.column1，并将第二个输入列分配给一个用户变量，该用户变量经过除法运算后才用于 的值t1.column2：
LOAD DATA INFILE 'file.txt'
INTO TABLE t1
(column1, @var1)
SET column2 = @var1/100;
该SET子句可用于提供不是从输入文件派生的值。以下语句设置
column3为当前日期和时间：
LOAD DATA INFILE 'file.txt'
INTO TABLE t1
(column1, column2)
SET column3 = CURRENT_TIMESTAMP;
您还可以通过将输入值分配给用户变量而不将该变量分配给任何表列来丢弃输入值：
LOAD DATA INFILE 'file.txt'
INTO TABLE t1
(column1, @dummy, column2, @dummy, column3);
列/变量列表和SET
子句的使用受以下限制：
子句中的赋值SET应该只有赋值运算符左侧的列名。
SET您可以在分配
的右侧使用子查询
。返回要分配给列的值的子查询可能只是标量子查询。此外，您不能使用子查询从正在加载的表中进行选择。
不为列/变量列表或子句处理
被子句忽略的行。
IGNORE
number LINESSET
加载固定行格式的数据时不能使用用户变量，因为用户变量没有显示宽度。
列值赋值
要处理输入行，LOAD
DATA将其拆分为字段并根据列/变量列表和
SET子句（如果存在）使用值。然后将结果行插入表中。如果表有
BEFORE INSERT或AFTER
INSERT触发器，它们分别在插入行之前或之后被激活。
字段值的解释和表列的分配取决于以下因素：
SQL模式（
sql_mode系统变量的值）。该模式可以是非限制性的，或者以各种方式限制性的。例如，可以启用严格的 SQL 模式，或者该模式可以包含诸如
NO_ZERO_DATE或
之类的值NO_ZERO_IN_DATE。
是否存在IGNORE和
LOCAL修饰符。
这些因素结合起来通过以下方式产生限制性或非限制性数据解释LOAD DATA：
如果 SQL 模式是限制性的并且既IGNORE没有LOCAL指定修饰符也没有指定修饰符，则数据解释是限制性的。错误终止加载操作。
如果 SQL 模式是非限制性的或指定了IGNOREor
LOCAL修饰符，则数据解释是非限制性的。（特别是，如果指定任何一个修饰符都会
覆盖限制性 SQL 模式。）错误变成警告并且加载操作继续。
限制性数据解释使用以下规则：
太多或太少的字段都会导致错误。
NULL将（即
）
分配\N给非NULL
列会导致错误。
超出列数据类型范围的值会导致错误。
无效值会产生错误。例如，
'x'数字列的值会导致错误，而不是转换为 0。
相比之下，非限制性数据解释使用以下规则：
如果输入行的字段过多，则忽略多余的字段并增加警告数。
如果输入行的字段太少，则为缺少输入字段的列分配默认值。默认值分配在
第 11.6 节，“数据类型默认值”中描述。
NULL将（即
）
分配\N给非NULL
列会导致为列数据类型分配隐式默认值。隐式默认值在第 11.6 节，“数据类型默认值”中描述。
无效值会产生警告而不是错误，并且会转换为列数据类型的“最接近”有效值。例子：
诸如'x'数字列之类的值会导致转换为 0。
超出范围的数值或时间值被裁剪到列数据类型范围的最近端点。
无论 SQL 模式设置如何，都会将DATETIME、
DATE或列
的无效值TIME
作为隐式默认值插入
。NO_ZERO_DATE隐式默认
值是类型（、
或
）的适当“零”值。请参阅
第 11.2 节，“日期和时间数据类型”。
'0000-00-00 00:00:00''0000-00-00''00:00:00'
LOAD DATA以不同于缺失字段的方式解释空字段值：
对于字符串类型，该列设置为空字符串。
对于数字类型，该列设置为
0。
对于日期和时间类型，该列设置为该类型的适当“零”值。请参阅
第 11.2 节，“日期和时间数据类型”。
INSERT这些值与在or
UPDATE语句
中将空字符串显式分配给字符串、数字或日期或时间类型时产生的值相同。
TIMESTAMP仅当列有NULL
值（即\N）且列未声明为允许NULL值时，或者TIMESTAMP列默认值为当前时间戳且字段中省略时，列才设置为当前日期和时间指定字段列表时的列表。
LOAD DATA将所有输入视为字符串，因此您不能像 with语句那样为ENUM或
SET列
使用数值
。INSERT所有
ENUM和
SET值都必须指定为字符串。
BIT不能使用二进制表示法（例如
b'011010'）直接加载值。要解决此问题，请使用该
SET子句去除前导
b'和尾随'并执行 base-2 到 base-10 的转换，以便 MySQL 将值BIT正确加载到列中：
$> cat /tmp/bit_test.txt
b'10'
b'1111111'
$> mysql test
mysql> LOAD DATA INFILE '/tmp/bit_test.txt'
INTO TABLE bit_test (@var1)
SET b = CAST(CONV(MID(@var1, 3, LENGTH(@var1)-3), 2, 10) AS UNSIGNED);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Deleted: 0  Skipped: 0  Warnings: 0
mysql> SELECT BIN(b+0) FROM bit_test;
+----------+
| BIN(b+0) |
+----------+
| 10       |
| 1111111  |
+----------+
2 rows in set (0.00 sec)
对于二进制表示法BIT中的值
0b（例如
0b011010），请改用此SET
子句去除前导0b：
SET b = CAST(CONV(MID(@var1, 3, LENGTH(@var1)-2), 2, 10) AS UNSIGNED)
分区表支持
LOAD DATAPARTITION
使用带有一个或多个逗号分隔的分区、子分区或两者名称列表的子句支持显式分区选择。使用此子句时，如果文件中的任何行无法插入到列表中指定的任何分区或子分区中，则该语句将失败并显示错误Found a row not matching the given partition set。有关更多信息和示例，请参阅第 24.5 节，“分区选择”。
并发注意事项
使用LOW_PRIORITY修饰符，LOAD DATA语句的执行被延迟，直到没有其他客户端从表中读取。这只会影响仅使用表级锁定的存储引擎（例如MyISAM、MEMORY和MERGE）。
使用CONCURRENT修饰符和
MyISAM满足并发插入条件的表（即中间不包含空闲块），其他线程可以在
LOAD DATA执行时从表中检索数据。此修饰符会LOAD
DATA稍微影响性能，即使没有其他线程同时使用该表也是如此。
报表结果信息
语句完成LOAD DATA后，它会返回以下格式的信息字符串：
Records: 1  Deleted: 0  Skipped: 0  Warnings: 0INSERT
警告发生在与使用语句
插入值时相同的情况下（请参阅第 13.2.6 节，“INSERT 语句”），除了
LOAD DATA当输入行中的字段太少或太多时也会生成警告。
您可以使用SHOW WARNINGSto 获取第一个
max_error_count警告的列表，作为有关出错原因的信息。请参阅
第 13.7.7.42 节，“显示警告声明”。
mysql_info()如果您使用的是 C API，则可以通过调用函数
来获取有关语句的信息
。请参阅
mysql_info()。
复制注意事项
LOAD DATA对于基于语句的复制来说被认为是不安全的。如果使用
LOAD DATAwith
binlog_format=STATEMENT，每个要应用更改的副本都会创建一个包含数据的临时文件。此临时文件未加密，即使源上的二进制日志加密处于活动状态，如果需要加密，请改用基于行或混合二进制日志记录格式，副本不会为其创建临时文件。有关
LOAD DATA复制和复制之间交互的更多信息，请参阅
第 17.5.1.19 节，“复制和加载数据”。
杂项话题
在 Unix 上，如果需要LOAD DATA从管道读取数据，可以使用以下技术（示例将/目录列表加载到表中db1.t1）：
mkfifo /mysql/data/db1/ls.dat
chmod 666 /mysql/data/db1/ls.dat
find / -ls > /mysql/data/db1/ls.dat &
mysql -e "LOAD DATA INFILE 'ls.dat' INTO TABLE t1" db1
此处必须在不同的终端运行生成待加载数据的命令和mysql命令，或者在后台运行数据生成过程（如上例所示）。如果不这样做，管道将阻塞，直到
mysql进程读取数据。
© Mysql 中文网
