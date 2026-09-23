# 7.4.3 使用 mysqldump 以定界文本格式转储数据_MySQL 8.0 参考手册

7.4.3 使用 mysqldump 以定界文本格式转储数据_MySQL 8.0 参考手册
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
7.1 备份和恢复类型
7.2 数据库备份方式
7.3 示例备份和恢复策略
7.4 使用 mysqldump 进行备份
7.4.1 使用 mysqldump 转储 SQL 格式的数据1
7.4.2 重新加载 SQL 格式的备份1
7.4.3 使用 mysqldump 以定界文本格式转储数据1
7.4.4 重新加载定界文本格式备份1
7.4.5 mysqldump 提示1
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.4 使用 mysqldump 进行备份  /
7.4.3 使用 mysqldump 以定界文本格式转储数据
7.4.3 使用 mysqldump 以定界文本格式转储数据
本节介绍如何使用mysqldump
创建分隔文本转储文件。有关重新加载此类转储文件的信息，请参阅
第 7.4.4 节，“重新加载分隔文本格式备份”。
如果您使用该
选项调用mysqldump ，它将用作输出目录，并使用每个表的两个文件将表单独转储到该目录中。表名是这些文件的基本名称。对于名为 的表，文件名为和
。该文件包含表的语句。该文件包含表格数据，每个表格行一行。
--tab=dir_namedir_namet1t1.sqlt1.txt.sqlCREATE TABLE.txt
以下命令将数据库的内容转储到
db1数据库中的文件中
/tmp：
$> mysqldump --tab=/tmp db1
包含表数据的.txt文件由服务器写入，因此它们由用于运行服务器的系统帐户拥有。服务器用于
SELECT ... INTO
OUTFILE写入文件，因此您必须具有执行此操作的
权限，如果给定文件已存在
FILE，则会发生错误
。.txt
服务器将CREATE转储表的定义发送到mysqldump，后者将它们写入.sql文件。因此，这些文件归执行mysqldump的用户所有。
最好--tab只用于转储一个本地服务器。如果与远程服务器一起使用，该--tab目录必须在本地和远程主机上都存在，
.txt文件由服务器写入远程目录（在服务器主机上），而
.sql文件由
mysqldump写入本地目录（在客户端主机上）。
对于mysqldump --tab，服务器默认将表数据.txt每行​​一行写入文件，列值之间有制表符，列值周围没有引号，换行符作为行终止符。（这些默认值与 . 相同
SELECT ... INTO
OUTFILE。）
为了使数据文件能够使用不同的格式写入，
mysqldump支持这些选项：
--fields-terminated-by=str
用于分隔列值的字符串（默认值：制表符）。
--fields-enclosed-by=char
包含列值的字符（默认值：无字符）。
--fields-optionally-enclosed-by=char
包含非数字列值的字符（默认值：无字符）。
--fields-escaped-by=char
转义特殊字符的字符（默认值：不转义）。
--lines-terminated-by=str
行终止字符串（默认值：换行符）。
根据您为这些选项中的任何一个指定的值，可能需要在命令行上为您的命令解释器适当地引用或转义该值。或者，使用十六进制表示法指定值。假设您希望
mysqldump在双引号内引用列值。为此，请将双引号指定为
--fields-enclosed-by
选项的值。但是这个字符对于命令口译员来说往往是特殊的，必须特殊对待。例如，在 Unix 上，您可以像这样引用双引号：
--fields-enclosed-by='"'
在任何平台上，您都可以用十六进制指定值：
--fields-enclosed-by=0x22
一起使用多个数据格式化选项是很常见的。例如，要以逗号分隔值格式转储表，行以回车符/换行符对 ( \r\n) 结尾，请使用此命令（在一行中输入）：
$> mysqldump --tab=/tmp --fields-terminated-by=,
--fields-enclosed-by='"' --lines-terminated-by=0x0d0a db1
如果您使用任何数据格式选项来转储表数据，您需要在稍后重新加载数据文件时指定相同的格式，以确保正确解释文件内容。
© Mysql 中文网
