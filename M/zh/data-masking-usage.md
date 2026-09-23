# 6.5.3 使用 MySQL 企业数据屏蔽和去标识化_MySQL 8.0 参考手册

6.5.3 使用 MySQL 企业数据屏蔽和去标识化_MySQL 8.0 参考手册
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
6.5.3 使用 MySQL 企业数据屏蔽和去标识化
6.5.3 使用 MySQL 企业数据屏蔽和去标识化
在使用 MySQL Enterprise Data Masking and De-Identification 之前，请按照第 6.5.2 节“安装或卸载 MySQL Enterprise Data Masking and De-Identification”中提供的说明进行安装。
要在应用程序中使用 MySQL Enterprise Data Masking and De-Identification，请调用适合您希望执行的操作的函数。详细的功能说明，请参见
第 6.5.5 节，“MySQL 企业数据屏蔽和去标识化功能说明”。本节演示如何使用函数来执行一些有代表性的任务。它首先概述了可用的函数，然后是一些如何在现实环境中使用这些函数的示例：
屏蔽数据以删除识别特征生成具有特定特征的随机数据使用字典生成随机数据使用屏蔽数据进行客户识别创建显示屏蔽数据的视图
屏蔽数据以删除识别特征
MySQL 提供了屏蔽任意字符串的通用屏蔽函数，以及屏蔽特定类型值的专用屏蔽函数。
通用掩蔽函数
mask_inner()并且
mask_outer()是根据字符串中的位置屏蔽任意字符串部分的通用函数：
mask_inner()屏蔽其字符串参数的内部，不屏蔽两端。其他参数指定未屏蔽端的大小。
mysql> SELECT mask_inner('This is a string', 5, 1);
+--------------------------------------+
| mask_inner('This is a string', 5, 1) |
+--------------------------------------+
| This XXXXXXXXXXg                     |
+--------------------------------------+
mysql> SELECT mask_inner('This is a string', 1, 5);
+--------------------------------------+
| mask_inner('This is a string', 1, 5) |
+--------------------------------------+
| TXXXXXXXXXXtring                     |
+--------------------------------------+
mask_outer()相反，屏蔽其字符串参数的末端，不屏蔽内部。其他参数指定屏蔽端的大小。
mysql> SELECT mask_outer('This is a string', 5, 1);
+--------------------------------------+
| mask_outer('This is a string', 5, 1) |
+--------------------------------------+
| XXXXXis a strinX                     |
+--------------------------------------+
mysql> SELECT mask_outer('This is a string', 1, 5);
+--------------------------------------+
| mask_outer('This is a string', 1, 5) |
+--------------------------------------+
| Xhis is a sXXXXX                     |
+--------------------------------------+
默认情况下，mask_inner()用作
mask_outer()屏蔽
'X'字符，但允许使用可选的屏蔽字符参数：
mysql> SELECT mask_inner('This is a string', 5, 1, '*');
+-------------------------------------------+
| mask_inner('This is a string', 5, 1, '*') |
+-------------------------------------------+
| This **********g                          |
+-------------------------------------------+
mysql> SELECT mask_outer('This is a string', 5, 1, '#');
+-------------------------------------------+
| mask_outer('This is a string', 5, 1, '#') |
+-------------------------------------------+
| #####is a strin#                          |
+-------------------------------------------+
特殊用途的屏蔽函数
其他屏蔽函数需要一个表示特定类型值的字符串参数，并将其屏蔽以删除识别特征。
笔记
此处的示例使用返回适当类型值的随机值生成函数提供函数参数。有关生成函数的更多信息，请参阅
生成具有特定特征的随机数据。
支付卡主帐号屏蔽。
屏蔽功能提供严格和宽松的主帐号屏蔽。
mask_pan()屏蔽除号码的最后四位以外的所有数字：
mysql> SELECT mask_pan(gen_rnd_pan());
+-------------------------+
| mask_pan(gen_rnd_pan()) |
+-------------------------+
| XXXXXXXXXXXX2461        |
+-------------------------+
mask_pan_relaxed()类似但不屏蔽前六位数字，表示未屏蔽支付卡发行人：
mysql> SELECT mask_pan_relaxed(gen_rnd_pan());
+---------------------------------+
| mask_pan_relaxed(gen_rnd_pan()) |
+---------------------------------+
| 770630XXXXXX0807                |
+---------------------------------+
美国社会安全号码掩蔽。
mask_ssn()屏蔽除号码的最后四位以外的所有数字：
mysql> SELECT mask_ssn(gen_rnd_ssn());
+-------------------------+
| mask_ssn(gen_rnd_ssn()) |
+-------------------------+
| XXX-XX-1723             |
+-------------------------+
生成具有特定特征的随机数据
几个函数生成随机值。这些值可用于测试、模拟等。
gen_range()返回从给定范围中选择的随机整数：
mysql> SELECT gen_range(1, 10);
+------------------+
| gen_range(1, 10) |
+------------------+
|                6 |
+------------------+
gen_rnd_email()example.com返回域中
的随机电子邮件地址：mysql> SELECT gen_rnd_email();
+---------------------------+
| gen_rnd_email()           |
+---------------------------+
| ayxnq.xmkpvvy@example.com |
+---------------------------+
gen_rnd_pan()返回随机支付卡主帐号：
mysql> SELECT gen_rnd_pan();
（gen_rnd_pan()函数结果未显示，因为其返回值仅用于测试目的，不用于发布。不能保证该号码未分配给合法的支付账户。）
gen_rnd_ssn()返回一个随机的美国社会安全号码，第一部分和第二部分分别选自一个不用于合法号码的范围：
mysql> SELECT gen_rnd_ssn();
+---------------+
| gen_rnd_ssn() |
+---------------+
| 912-45-1615   |
+---------------+
gen_rnd_us_phone()返回未用于合法号码的 555 区号中的随机美国电话号码：
mysql> SELECT gen_rnd_us_phone();
+--------------------+
| gen_rnd_us_phone() |
+--------------------+
| 1-555-747-5627     |
+--------------------+
使用字典生成随机数据
MySQL Enterprise Data Masking and De-Identification 使字典可以用作随机值的来源。要使用字典，必须首先从文件中加载它并为其命名。每个加载的字典都成为字典注册表的一部分。然后可以从已注册的字典中选择项目并将其用作随机值或用作其他值的替换。
有效的字典文件具有以下特征：
文件内容为纯文本，每行一个术语。
空行被忽略。
该文件必须至少包含一个术语。
假设名为的文件de_cities.txt
包含德国的这些城市名称：
Berlin
Munich
Bremen
还假设名为的文件
us_cities.txt包含美国的这些城市名称：
Chicago
Houston
Phoenix
El Paso
Detroit
假设
secure_file_priv系统变量设置为
/usr/local/mysql/mysql-files. 在这种情况下，将字典文件复制到该目录，以便 MySQL 服务器可以访问它们。然后使用
gen_dictionary_load()将字典加载到字典注册表中并为它们分配名称：
mysql> SELECT gen_dictionary_load('/usr/local/mysql/mysql-files/de_cities.txt', 'DE_Cities');
+--------------------------------------------------------------------------------+
| gen_dictionary_load('/usr/local/mysql/mysql-files/de_cities.txt', 'DE_Cities') |
+--------------------------------------------------------------------------------+
| Dictionary load success                                                        |
+--------------------------------------------------------------------------------+
mysql> SELECT gen_dictionary_load('/usr/local/mysql/mysql-files/us_cities.txt', 'US_Cities');
+--------------------------------------------------------------------------------+
| gen_dictionary_load('/usr/local/mysql/mysql-files/us_cities.txt', 'US_Cities') |
+--------------------------------------------------------------------------------+
| Dictionary load success                                                        |
+--------------------------------------------------------------------------------+
要从字典中选择一个随机术语，请使用
gen_dictionary()：
mysql> SELECT gen_dictionary('DE_Cities');
+-----------------------------+
| gen_dictionary('DE_Cities') |
+-----------------------------+
| Berlin                      |
+-----------------------------+
mysql> SELECT gen_dictionary('US_Cities');
+-----------------------------+
| gen_dictionary('US_Cities') |
+-----------------------------+
| Phoenix                     |
+-----------------------------+
要从多个词典中选择一个随机术语，请随机选择一个词典，然后从中选择一个术语：
mysql> SELECT gen_dictionary(ELT(gen_range(1,2), 'DE_Cities', 'US_Cities'));
+---------------------------------------------------------------+
| gen_dictionary(ELT(gen_range(1,2), 'DE_Cities', 'US_Cities')) |
+---------------------------------------------------------------+
| Detroit                                                       |
+---------------------------------------------------------------+
mysql> SELECT gen_dictionary(ELT(gen_range(1,2), 'DE_Cities', 'US_Cities'));
+---------------------------------------------------------------+
| gen_dictionary(ELT(gen_range(1,2), 'DE_Cities', 'US_Cities')) |
+---------------------------------------------------------------+
| Bremen                                                        |
+---------------------------------------------------------------+
该gen_blocklist()函数使一个词典中的术语可以被另一个词典中的术语替换，从而通过替换实现掩码。它的参数是要替换的术语、出现该术语的词典以及从中选择替换项的词典。例如，要将美国城市替换为德国城市，反之亦然，请
gen_blocklist()像这样使用：
mysql> SELECT gen_blocklist('Munich', 'DE_Cities', 'US_Cities');
+---------------------------------------------------+
| gen_blocklist('Munich', 'DE_Cities', 'US_Cities') |
+---------------------------------------------------+
| Houston                                           |
+---------------------------------------------------+
mysql> SELECT gen_blocklist('El Paso', 'US_Cities', 'DE_Cities');
+----------------------------------------------------+
| gen_blocklist('El Paso', 'US_Cities', 'DE_Cities') |
+----------------------------------------------------+
| Bremen                                             |
+----------------------------------------------------+
如果要替换的术语不在第一个字典中，
gen_blocklist()则将其原封不动地返回：
mysql> SELECT gen_blocklist('Moscow', 'DE_Cities', 'US_Cities');
+---------------------------------------------------+
| gen_blocklist('Moscow', 'DE_Cities', 'US_Cities') |
+---------------------------------------------------+
| Moscow                                            |
+---------------------------------------------------+
使用屏蔽数据进行客户识别
在客户服务呼叫中心，一种常见的身份验证技术是要求客户提供他们的最后四位社会安全号码 (SSN) 数字。例如，客户可能会说她的名字是 Joanna Bond，她的 SSN 的最后四位数字是0007。
假设customer包含客户记录的表具有这些列：
id：客户 ID 号。
first_name: 客户的名字。
last_name: 客户姓氏。
ssn：客户社会安全号码。
例如，表可能定义如下：
CREATE TABLE customer
(
id         BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(40),
last_name  VARCHAR(40),
ssn        VARCHAR(11)
);
客户服务代表用来检查客户 SSN 的应用程序可能会执行如下查询：
mysql> SELECT id, ssn
mysql> FROM customer
mysql> WHERE first_name = 'Joanna' AND last_name = 'Bond';
+-----+-------------+
| id  | ssn         |
+-----+-------------+
| 786 | 906-39-0007 |
+-----+-------------+
但是，这会将 SSN 暴露给客户服务代表，他们除了最后四位数字之外不需要看到任何其他内容。相反，应用程序可以使用此查询仅显示屏蔽的 SSN：
mysql> SELECT id, mask_ssn(CONVERT(ssn USING binary)) AS masked_ssn
mysql> FROM customer
mysql> WHERE first_name = 'Joanna' AND last_name = 'Bond';
+-----+-------------+
| id  | masked_ssn  |
+-----+-------------+
| 786 | XXX-XX-0007 |
+-----+-------------+
现在代表只看到必要的内容，客户隐私得到保护。
为什么CONVERT()函数用于参数到
mask_ssn()？因为
mask_ssn()需要一个长度为 11 的参数。因此，即使ssn定义为VARCHAR(11)，如果该
ssn列具有多字节字符集，它在传递给可加载函数时可能看起来比 11 个字节长，并且会发生错误。将值转换为二进制字符串可确保函数看到长度为 11 的参数。
当字符串参数没有单字节字符集时，其他数据屏蔽函数可能需要类似的技术。
创建显示屏蔽数据的视图
如果表中的屏蔽数据用于多个查询，则定义生成屏蔽数据的视图可能会很方便。这样，应用程序就可以从视图中进行选择，而无需在各个查询中执行屏蔽。
例如，上customer
一节中表格的掩蔽视图可以这样定义：
CREATE VIEW masked_customer AS
SELECT id, first_name, last_name,
mask_ssn(CONVERT(ssn USING binary)) AS masked_ssn
FROM customer;
然后查找客户的查询变得更简单但仍然返回屏蔽数据：
mysql> SELECT id, masked_ssn
mysql> FROM masked_customer
mysql> WHERE first_name = 'Joanna' AND last_name = 'Bond';
+-----+-------------+
| id  | masked_ssn  |
+-----+-------------+
| 786 | XXX-XX-0007 |
+-----+-------------+
© Mysql 中文网
