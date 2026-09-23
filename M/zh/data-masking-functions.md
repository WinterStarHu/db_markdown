# 6.5.5 MySQL企业数据脱敏和去标识化功能说明_MySQL 8.0 参考手册

6.5.5 MySQL企业数据脱敏和去标识化功能说明_MySQL 8.0 参考手册
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
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.5.1 MySQL 企业数据屏蔽和去标识化元素1
6.5.2 安装或卸载 MySQL Enterprise Data Masking and De-Identification1
6.5.3 使用 MySQL 企业数据屏蔽和去标识化1
6.5.4 MySQL企业数据脱敏和去标识化功能参考1
6.5.5 MySQL企业数据脱敏和去标识化功能说明1
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.5 MySQL 企业数据屏蔽和去标识化  /
6.5.5 MySQL企业数据脱敏和去标识化功能说明
6.5.5 MySQL企业数据脱敏和去标识化功能说明
MySQL Enterprise Data Masking and De-Identification 插件库包括几个函数，可以分为以下几类：
数据屏蔽功能随机数据生成函数基于随机数据字典的函数
从 MySQL 8.0.19 开始，这些函数支持字符串参数和返回值的单字节
latin1字符集。在 MySQL 8.0.19 之前，函数将字符串参数视为二进制字符串（这意味着它们不区分大小写），字符串返回值是二进制字符串。可以看到返回值字符集的区别如下：
MySQL 8.0.19 及更高版本：
mysql> SELECT CHARSET(gen_rnd_email());
+--------------------------+
| CHARSET(gen_rnd_email()) |
+--------------------------+
| latin1                   |
+--------------------------+
在 MySQL 8.0.19 之前：
mysql> SELECT CHARSET(gen_rnd_email());
+--------------------------+
| CHARSET(gen_rnd_email()) |
+--------------------------+
| binary                   |
+--------------------------+
对于任何版本，如果一个字符串返回值应该在不同的字符集中，转换它。以下示例显示如何将 的结果转换为
gen_rnd_email()字符
utf8mb4集：
SET @email = CONVERT(gen_rnd_email() USING utf8mb4);
要显式生成二进制字符串（例如，生成类似于 8.0.19 之前的 MySQL 版本的结果），请执行以下操作：
SET @email = CONVERT(gen_rnd_email() USING binary);
可能还需要转换字符串参数，如
使用掩码数据进行客户识别中所示。
如果从
MySQL客户端中调用 MySQL 企业数据屏蔽和去标识化功能，二进制字符串结果将使用十六进制表示法显示，具体取决于
--binary-as-hex. 有关该选项的更多信息，请参阅第 4.5.1 节，“mysql — MySQL 命令行客户端”。
数据屏蔽功能
本节中的每个函数对其字符串参数执行屏蔽操作并返回屏蔽结果。
mask_inner(str,
margin1,
margin2 [,
mask_char])
屏蔽字符串的内部部分，保留两端不变，并返回结果。可以指定一个可选的屏蔽字符。
参数：
str: 要屏蔽的字符串。
margin1：一个非负整数，指定字符串左端要保持未屏蔽的字符数。如果该值为 0，则没有左端字符保持未屏蔽状态。
margin2：一个非负整数，指定字符串右端要保持未屏蔽的字符数。如果该值为 0，则没有右端字符保持未屏蔽状态。
mask_char：（可选）用于屏蔽的单个字符。'X'如果
mask_char没有给出
默认值
。
屏蔽字符必须是单字节字符。尝试使用多字节字符会产生错误。
返回值：
被屏蔽的字符串，或者NULL任何一个边距是否为负。
如果 margin 值的总和大于参数长度，则不会发生屏蔽并且参数将原封不动地返回。
例子：
mysql> SELECT mask_inner('abcdef', 1, 2), mask_inner('abcdef',0, 5);
+----------------------------+---------------------------+
| mask_inner('abcdef', 1, 2) | mask_inner('abcdef',0, 5) |
+----------------------------+---------------------------+
| aXXXef                     | Xbcdef                    |
+----------------------------+---------------------------+
mysql> SELECT mask_inner('abcdef', 1, 2, '*'), mask_inner('abcdef',0, 5, '#');
+---------------------------------+--------------------------------+
| mask_inner('abcdef', 1, 2, '*') | mask_inner('abcdef',0, 5, '#') |
+---------------------------------+--------------------------------+
| a***ef                          | #bcdef                         |
+---------------------------------+--------------------------------+
mask_outer(str,
margin1,
margin2 [,
mask_char])
屏蔽字符串的左右两端，不屏蔽内部，并返回结果。可以指定一个可选的屏蔽字符。
参数：
str: 要屏蔽的字符串。
margin1：一个非负整数，指定要屏蔽的字符串左端的字符数。如果该值为 0，则不屏蔽左端字符。
margin2：一个非负整数，指定要屏蔽的字符串右端的字符数。如果该值为 0，则不屏蔽任何右端字符。
mask_char：（可选）用于屏蔽的单个字符。'X'如果
mask_char没有给出
默认值
。
屏蔽字符必须是单字节字符。尝试使用多字节字符会产生错误。
返回值：
被屏蔽的字符串，或者NULL任何一个边距是否为负。
如果边距值的总和大于参数长度，则整个参数都被屏蔽。
例子：
mysql> SELECT mask_outer('abcdef', 1, 2), mask_outer('abcdef',0, 5);
+----------------------------+---------------------------+
| mask_outer('abcdef', 1, 2) | mask_outer('abcdef',0, 5) |
+----------------------------+---------------------------+
| XbcdXX                     | aXXXXX                    |
+----------------------------+---------------------------+
mysql> SELECT mask_outer('abcdef', 1, 2, '*'), mask_outer('abcdef',0, 5, '#');
+---------------------------------+--------------------------------+
| mask_outer('abcdef', 1, 2, '*') | mask_outer('abcdef',0, 5, '#') |
+---------------------------------+--------------------------------+
| *bcd**                          | a#####                         |
+---------------------------------+--------------------------------+
mask_pan(str)
屏蔽支付卡主帐号并返回除最后四位以外的所有数字都被
'X'字符替换的号码。
参数：
str: 要屏蔽的字符串。该字符串的长度必须适合主帐号，但不进行其他检查。
返回值：
作为字符串的屏蔽支付号码。如果参数比要求的短，则原样返回。
例子：
mysql> SELECT mask_pan(gen_rnd_pan());
+-------------------------+
| mask_pan(gen_rnd_pan()) |
+-------------------------+
| XXXXXXXXXXXX9102        |
+-------------------------+
mysql> SELECT mask_pan(gen_rnd_pan(19));
+---------------------------+
| mask_pan(gen_rnd_pan(19)) |
+---------------------------+
| XXXXXXXXXXXXXXX8268       |
+---------------------------+
mysql> SELECT mask_pan('a*Z');
+-----------------+
| mask_pan('a*Z') |
+-----------------+
| a*Z             |
+-----------------+
mask_pan_relaxed(str)
屏蔽支付卡主帐号并返回除前六位和后四位以外的所有数字都替换为'X'字符的号码。前六位数字表示支付卡发行机构。
参数：
str: 要屏蔽的字符串。该字符串的长度必须适合主帐号，但不进行其他检查。
返回值：
作为字符串的屏蔽支付号码。如果参数比要求的短，则原样返回。
例子：
mysql> SELECT mask_pan_relaxed(gen_rnd_pan());
+---------------------------------+
| mask_pan_relaxed(gen_rnd_pan()) |
+---------------------------------+
| 551279XXXXXX3108                |
+---------------------------------+
mysql> SELECT mask_pan_relaxed(gen_rnd_pan(19));
+-----------------------------------+
| mask_pan_relaxed(gen_rnd_pan(19)) |
+-----------------------------------+
| 462634XXXXXXXXX6739               |
+-----------------------------------+
mysql> SELECT mask_pan_relaxed('a*Z');
+-------------------------+
| mask_pan_relaxed('a*Z') |
+-------------------------+
| a*Z                     |
+-------------------------+
mask_ssn(str)
屏蔽美国社会安全号码并返回除最后四位以外的所有数字都被
'X'字符替换的号码。
参数：
str: 要屏蔽的字符串。该字符串的长度必须为 11 个字符。
返回值：
掩码的社会安全号码作为字符串，如果参数长度不正确，则为错误。
例子：
mysql> SELECT mask_ssn('909-63-6922'), mask_ssn('abcdefghijk');
+-------------------------+-------------------------+
| mask_ssn('909-63-6922') | mask_ssn('abcdefghijk') |
+-------------------------+-------------------------+
| XXX-XX-6922             | XXX-XX-hijk             |
+-------------------------+-------------------------+
mysql> SELECT mask_ssn('909');
ERROR 1123 (HY000): Can't initialize function 'mask_ssn'; MASK_SSN: Error:
String argument width too small
mysql> SELECT mask_ssn('123456789123456789');
ERROR 1123 (HY000): Can't initialize function 'mask_ssn'; MASK_SSN: Error:
String argument width too large
随机数据生成函数
本节中的函数为不同类型的数据生成随机值。如果可能，生成的值具有保留用于演示或测试值的特征，以避免将它们误认为合法数据。例如，
gen_rnd_us_phone()返回一个使用555区号的美国电话号码，在实际使用中并没有分配给电话号码。个别功能描述描述了此原则的任何例外情况。
gen_range(lower,
upper)
生成从指定范围中选择的随机数。
参数：
lower: 一个整数，指定范围的下边界。
upper：一个整数，指定范围的上限，不能小于下限。
返回值：
范围从
lower到
的随机整数upper（含），或者
NULL如果
upper参数小于
lower.
例子：
mysql> SELECT gen_range(100, 200), gen_range(-1000, -800);
+---------------------+------------------------+
| gen_range(100, 200) | gen_range(-1000, -800) |
+---------------------+------------------------+
|                 177 |                   -917 |
+---------------------+------------------------+
mysql> SELECT gen_range(1, 0);
+-----------------+
| gen_range(1, 0) |
+-----------------+
|            NULL |
+-----------------+
gen_rnd_email()
example.com在域中
生成一个随机电子邮件地址
。
参数：
没有任何。
返回值：
作为字符串的随机电子邮件地址。
例子：
mysql> SELECT gen_rnd_email();
+---------------------------+
| gen_rnd_email()           |
+---------------------------+
| ijocv.mwvhhuf@example.com |
+---------------------------+
gen_rnd_pan([size])
生成随机支付卡主帐号。该号码通过了 Luhn 校验（一种针对校验位执行校验和验证的算法）。
警告
从返回的值
gen_rnd_pan()应仅用于测试目的，不适合发布。无法保证给定的返回值不会分配给合法的支付账户。如果有必要发布
gen_rnd_pan()结果，请考虑使用
mask_pan()或
对其进行屏蔽mask_pan_relaxed()。
参数：
size：（可选）指定结果大小的整数。size如果未给出，则默认值为 16 。如果给定，size则必须是 12 到 19 范围内的整数。
返回值：
一个作为字符串的随机支付数字，或者
NULL如果size
给出了允许范围之外的参数。
例子：
mysql> SELECT mask_pan(gen_rnd_pan());
+-------------------------+
| mask_pan(gen_rnd_pan()) |
+-------------------------+
| XXXXXXXXXXXX5805        |
+-------------------------+
mysql> SELECT mask_pan(gen_rnd_pan(19));
+---------------------------+
| mask_pan(gen_rnd_pan(19)) |
+---------------------------+
| XXXXXXXXXXXXXXX5067       |
+---------------------------+
mysql> SELECT mask_pan_relaxed(gen_rnd_pan());
+---------------------------------+
| mask_pan_relaxed(gen_rnd_pan()) |
+---------------------------------+
| 398403XXXXXX9547                |
+---------------------------------+
mysql> SELECT mask_pan_relaxed(gen_rnd_pan(19));
+-----------------------------------+
| mask_pan_relaxed(gen_rnd_pan(19)) |
+-----------------------------------+
| 578416XXXXXXXXX6509               |
+-----------------------------------+
mysql> SELECT gen_rnd_pan(11), gen_rnd_pan(20);
+-----------------+-----------------+
| gen_rnd_pan(11) | gen_rnd_pan(20) |
+-----------------+-----------------+
| NULL            | NULL            |
+-----------------+-----------------+
gen_rnd_ssn()
生成一个随机的美国社会安全号码
格式。大于 900 的部分和小于 70 的部分是合法社会安全号码不使用的特征。
AAA-BB-CCCCAAABB
参数：
没有任何。
返回值：
作为字符串的随机社会安全号码。
例子：
mysql> SELECT gen_rnd_ssn();
+---------------+
| gen_rnd_ssn() |
+---------------+
| 951-26-0058   |
+---------------+
gen_rnd_us_phone()
生成一个随机的美国电话号码
格式。555 区号不用于合法电话号码。
1-555-AAA-BBBB
参数：
没有任何。
返回值：
作为字符串的随机美国电话号码。
例子：
mysql> SELECT gen_rnd_us_phone();
+--------------------+
| gen_rnd_us_phone() |
+--------------------+
| 1-555-682-5423     |
+--------------------+
基于随机数据字典的函数
本节中的函数操作术语词典并根据它们执行生成和屏蔽操作。其中一些功能需要
SUPER特权。
加载字典时，它成为字典注册表的一部分，并被分配一个名称以供其他字典功能使用。字典是从每行包含一个术语的纯文本文件加载的。空行被忽略。要有效，字典文件必须包含至少一个非空行。
gen_blacklist(str,
dictionary_name,
replacement_dictionary_name)
用第二个词典中的术语替换一个词典中存在的术语并返回替换术语。这通过替换掩盖了原始术语。此函数在 MySQL 8.0.23 中已弃用；改用
gen_blocklist()。
gen_blocklist(str,
dictionary_name,
replacement_dictionary_name)
用第二个词典中的术语替换一个词典中存在的术语并返回替换术语。这通过替换掩盖了原始术语。MySQL 8.0.23新增此功能；用它代替
gen_blacklist().
参数：
str：一个字符串，指示要替换的术语。
dictionary_name: 一个字符串，它命名包含要替换的术语的字典。
replacement_dictionary_name：一个字符串，它命名要从中选择替换术语的词典。
返回值：
从中随机选择的字符串
replacement_dictionary_name作为 的替代品str，或者
str如果它没有出现在 中
dictionary_name，或者
NULL字典名称不在字典注册表中。
如果要替换的术语同时出现在两个词典中，则返回值可能是同一个术语。
例子：
mysql> SELECT gen_blocklist('Berlin', 'DE_Cities', 'US_Cities');
+---------------------------------------------------+
| gen_blocklist('Berlin', 'DE_Cities', 'US_Cities') |
+---------------------------------------------------+
| Phoenix                                           |
+---------------------------------------------------+
gen_dictionary(dictionary_name)
从字典中返回一个随机术语。
参数：
dictionary_name：一个字符串，用于命名要从中选择术语的词典。
返回值：
字典中的随机术语作为字符串，或者
NULL如果字典名称不在字典注册表中。
例子：
mysql> SELECT gen_dictionary('mydict');
+--------------------------+
| gen_dictionary('mydict') |
+--------------------------+
| My term                  |
+--------------------------+
mysql> SELECT gen_dictionary('no-such-dict');
+--------------------------------+
| gen_dictionary('no-such-dict') |
+--------------------------------+
| NULL                           |
+--------------------------------+
gen_dictionary_drop(dictionary_name)
从字典注册表中删除字典。
此功能需要
SUPER权限。
参数：
dictionary_name: 命名要从字典注册表中删除的字典的字符串。
返回值：
指示删除操作是否成功的字符串。Dictionary removed表示成功。Dictionary removal error
表示失败。
例子：
mysql> SELECT gen_dictionary_drop('mydict');
+-------------------------------+
| gen_dictionary_drop('mydict') |
+-------------------------------+
| Dictionary removed            |
+-------------------------------+
mysql> SELECT gen_dictionary_drop('no-such-dict');
+-------------------------------------+
| gen_dictionary_drop('no-such-dict') |
+-------------------------------------+
| Dictionary removal error            |
+-------------------------------------+
gen_dictionary_load(dictionary_path,
dictionary_name)
将文件加载到字典注册表中，并为字典分配一个名称，以便与需要字典名称参数的其他函数一起使用。
此功能需要
SUPER权限。
重要的
字典不是持久的。应用程序使用的任何字典都必须在每次服务器启动时加载。
一旦加载到注册表中，字典就会按原样使用，即使基础字典文件发生变化也是如此。要重新加载字典，首先使用 将其删除
gen_dictionary_drop()，然后使用 再次加载它
gen_dictionary_load()。
参数：
dictionary_path: 一个字符串，指定字典文件的路径名。
dictionary_name：为字典提供名称的字符串。
返回值：
指示加载操作是否成功的字符串。Dictionary load success
表示成功。Dictionary load error
表示失败。字典加载失败的原因有多种，包括：
已加载具有给定名称的字典。
找不到词典文件。
词典文件不包含术语。
设置了secure_file_priv
系统变量，字典文件不在变量命名的目录中。
例子：
mysql> SELECT gen_dictionary_load('/usr/local/mysql/mysql-files/mydict','mydict');
+---------------------------------------------------------------------+
| gen_dictionary_load('/usr/local/mysql/mysql-files/mydict','mydict') |
+---------------------------------------------------------------------+
| Dictionary load success                                             |
+---------------------------------------------------------------------+
mysql> SELECT gen_dictionary_load('/dev/null','null');
+-----------------------------------------+
| gen_dictionary_load('/dev/null','null') |
+-----------------------------------------+
| Dictionary load error                   |
+-----------------------------------------+
© Mysql 中文网
