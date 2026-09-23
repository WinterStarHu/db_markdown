# 1.1 关于本手册_MySQL 8.0 参考手册

1.1 关于本手册_MySQL 8.0 参考手册
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
1.1 关于本手册
1.2 MySQL数据库管理系统概述
1.3 MySQL 8.0 的新特性
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
1.5 MySQL信息源
1.6 如何报告错误或问题
1.7 MySQL 标准合规性
1.8 学分
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
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第一章 一般信息  /
1.1 关于本手册
1.1 关于本手册
这是 MySQL 数据库系统 8.0 版到 8.0.31 版的参考手册。MySQL 8.0 次要版本之间的差异在当前文本中参考版本号 (8.0. x) 进行了说明。有关许可信息，请参阅法律声明。
由于 MySQL 8.0 与以前版本之间存在许多功能和其他差异，本手册不适用于旧版本的 MySQL 软件。如果您使用的是较早版本的 MySQL 软件，请参阅相应的手册。例如，
MySQL 5.7 参考手册
涵盖了 5.7 系列的 MySQL 软件版本。
因为本手册用作参考，所以它不提供有关 SQL 或关系数据库概念的一般说明。它也没有教您如何使用操作系统或命令行解释器。
MySQL 数据库软件不断发展，参考手册也经常更新。该手册的最新版本可在
https://mysql.net.cn/doc/以可搜索的形式在线获取。那里还提供其他格式，包括可下载的 HTML 和 PDF 版本。
MySQL 本身的源代码包含使用 Doxygen 编写的内部文档。生成的 Doxygen 内容可用
https://mysql.net.cn/doc/index-other.html。也可以使用
第 2.9.10 节“生成 MySQL Doxygen 文档内容”中的说明从 MySQL 源代码分发本地生成此内容。
如果您对使用 MySQL 有疑问，请加入
MySQL Community Slack，或在我们的论坛中提问；请参阅MySQL 论坛上的 MySQL 社区支持。如果您有关于手册本身的补充或更正的建议，请将它们发送到
http://www.mysql.com/company/contact/。
印刷和语法约定
本手册使用某些排版约定：
Text in this style用于SQL语句；数据库、表和列名称；程序清单和源代码；和环境变量。示例：“要重新加载授权表，请使用FLUSH
PRIVILEGES语句。”
Text in this style表示您在示例中键入的输入。
这种风格的文本表示可执行程序和脚本的名称，例如
mysql（MySQL 命令行客户端程序）和mysqld（MySQL 服务器可执行文件）。
Text in this style用于变量输入，您应该为其替换您自己选择的值。
这种样式的文本用于强调。
这种风格的文本用于表格标题，并传达特别强烈的强调。
Text in this style用于指示影响程序如何执行的程序选项，或提供程序以某种方式运行所需的信息。示例：“选项（缩写形式）告诉mysql客户端程序它应该连接到的 MySQL 服务器的主机名或 IP地址
--host-h”。
文件名和目录名这样写：“全局my.cnf文件位于
/etc目录中。”
字符序列是这样写的：“要指定通配符，请使用' %'
字符。”
当命令或语句以提示为前缀时，我们使用这些：
$> type a command here
#> type a command as root here
C:\> type a command here (Windows only)
mysql> type a mysql statement here
命令在您的命令解释器中发出。在 Unix 上，这通常是一个程序，例如sh、
csh或bash。在 Windows 上，等效程序是command.com或
cmd.exe，通常在控制台窗口中运行。以 为前缀的语句在mysql命令行客户端
mysql中发出
。
笔记
当您输入示例中显示的命令或语句时，请不要键入示例中显示的提示。
在某些领域，不同的系统可能会相互区分，以表明命令应该在两个不同的环境中执行。例如，在使用复制时，命令可能以sourceand
为前缀replica：
source> type a mysql statement on the replication source here
replica> type a mysql statement on the replica here
数据库、表和列名称必须经常替换到语句中。为了表明这种替换是必要的，本手册使用db_name、
tbl_name和
col_name。例如，您可能会看到这样的语句：
mysql> SELECT col_name FROM db_name.tbl_name;
这意味着如果您要输入类似的语句，您将提供自己的数据库、表和列名称，可能如下所示：
mysql> SELECT author_name FROM biblio_db.author_list;
SQL 关键字不区分大小写，可以使用任何字母大小写。本手册使用大写字母。
在句法描述中，方括号（“ [”和
“ ]”）表示可选词或从句。例如，在以下语句中，IF
EXISTS是可选的：
DROP TABLE [IF EXISTS] tbl_name
当一个句法元素由多个备选项组成时，备选项之间用竖线（“ |”）隔开。当可以从一组选项中选择一个成员时，备选方案列在方括号（“ [”
和“ ]”）内：
TRIM([[BOTH | LEADING | TRAILING] [remstr] FROM] str)当必须
从一组选项中选择一个成员时，备选方案列在大括号（“ {”和
“ }”）中：
{DESCRIBE | DESC} tbl_name [col_name | wild]
省略号 ( ...) 表示省略语句的一部分，通常是为了提供更复杂语法的更短版本。例如，
是在语句的其他部分后面
有一个子句的语句
SELECT ... INTO
OUTFILE形式的简写
。SELECTINTO OUTFILE
省略号还可以指示语句的前面语法元素可能会重复。在以下示例中，
reset_option可以给出多个值，每个值都在第一个值之后以逗号开头：
RESET reset_option [,reset_option] ...
使用 Bourne shell 语法显示用于设置 shell 变量的命令。例如，设置CC
环境变量和运行configure
命令的顺序在 Bourne shell 语法中如下所示：
$> CC=gcc ./configure
如果您使用的是csh或tcsh，则必须以稍微不同的方式发出命令：
$> setenv CC gcc
$> ./configure
手册作者身份
参考手册源文件以 DocBook XML 格式编写。HTML 版本和其他格式是自动生成的，主要使用 DocBook XSL 样式表。有关 DocBook 的信息，请参阅
http://docbook.org/
本手册最初由 David Axmark 和 Michael
“ Monty ” Widenius 编写。它由 MySQL 文档团队维护，该团队由 Chris Cole、Margaret Fisher、Edward Gilmore、Stefan Hinz、Philip Olson、Daniel Price、Daniel So 和 Jon Stephens 组成。
© Mysql 中文网
