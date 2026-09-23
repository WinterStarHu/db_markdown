# 10.5 配置应用程序字符集和排序规则_MySQL 8.0 参考手册

10.5 配置应用程序字符集和排序规则_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  /
10.5 配置应用程序字符集和排序规则
10.5 配置应用程序字符集和排序规则
对于使用默认 MySQL 字符集和排序规则 ( utf8mb4,
utf8mb4_0900_ai_ci) 存储数据的应用程序，不需要特殊配置。如果应用程序需要使用不同的字符集或排序规则存储数据，您可以通过多种方式配置字符集信息：
指定每个数据库的字符设置。例如，使用一个数据库的应用程序可能使用默认的
utf8mb4，而使用另一个数据库的应用程序可能使用sjis.
在服务器启动时指定字符设置。这会导致服务器对所有未进行其他安排的应用程序使用给定的设置。
如果您从源代码构建 MySQL，请在配置时指定字符设置。这会导致服务器使用给定的设置作为所有应用程序的默认设置，而不必在服务器启动时指定它们。
当不同的应用程序需要不同的字符设置时，每个数据库技术提供了很大的灵活性。如果大多数或所有应用程序使用相同的字符集，则在服务器启动或配置时指定字符设置可能是最方便的。
对于每个数据库或服务器启动技术，设置控制数据存储的字符集。应用程序还必须告诉服务器哪个字符集用于客户端/服务器通信，如以下说明中所述。
此处显示的示例假定在特定上下文中使用
latin1字符集和
排序规则作为默认值和
latin1_swedish_ci的替代方法
。
utf8mb4utf8mb4_0900_ai_ci
指定每个数据库的字符设置。
要创建一个数据库，使其表使用给定的默认字符集和数据存储排序规则，请使用
CREATE DATABASE如下语句：
CREATE DATABASE mydb
CHARACTER SET latin1
COLLATE latin1_swedish_ci;
在数据库中创建的表默认使用latin1
和latin1_swedish_ci任何字符列。
使用数据库的应用程序还应该在每次连接时配置它们与服务器的连接。这可以通过SET NAMES 'latin1'
在连接后执行一条语句来完成。无论连接方法（ mysql
客户端、PHP 脚本等）
如何，都可以使用该语句。
在某些情况下，可以将连接配置为以其他方式使用所需的字符集。例如，要使用mysql进行连接，您可以指定
--default-character-set=latin1
命令行选项来实现与SET
NAMES 'latin1'.
有关配置客户端连接的更多信息，请参阅
第 10.4 节，“连接字符集和排序规则”。
笔记
如果您用于ALTER DATABASE更改数据库默认字符集或排序规则，则必须删除并重新创建数据库中使用这些默认值的现有存储例程，以便它们使用新的默认值。（在存储例程中，如果未明确指定字符集或排序规则，则具有字符数据类型的变量使用数据库默认值。请参阅
第 13.1.17 节，“CREATE PROCEDURE 和 CREATE FUNCTION 语句”。）
在服务器启动时指定字符设置。
要在服务器启动时选择字符集和排序规则，请使用
--character-set-server和
--collation-server选项。例如，要在选项文件中指定选项，请包括以下行：
[mysqld]
character-set-server=latin1
collation-server=latin1_swedish_ci
这些设置在服务器范围内应用，并作为任何应用程序创建的数据库以及在这些数据库中创建的表的默认值应用。
SET NAMES如前所述
，应用程序在连接后仍然需要使用或等效配置它们的连接。您可能会想要启动服务器，并
--init_connect="SET NAMES
'latin1'"选择SET
NAMES让每个连接的客户端自动执行的选项。但是，这可能会产生不一致的结果，因为init_connect
不会为拥有
CONNECTION_ADMIN特权（或弃用SUPER
特权）的用户执行该值。
在 MySQL 配置时指定字符设置。
如果从源配置和构建 MySQL，要选择字符集和排序规则，请使用
DEFAULT_CHARSET和
CMake选项：
DEFAULT_COLLATION
cmake . -DDEFAULT_CHARSET=latin1 \
-DDEFAULT_COLLATION=latin1_swedish_ci
生成的服务器使用latin1和
latin1_swedish_ci作为数据库和表以及客户端连接的默认设置。不必在服务器启动时使用
--character-set-server和
--collation-server指定这些默认值。SET NAMES应用程序在连接到服务器后
也没有必要使用或等效配置它们的连接
。
无论您如何配置 MySQL 字符集供应用程序使用，您还必须考虑这些应用程序执行的环境。例如，如果您打算使用从您在编辑器中创建的文件中获取的 UTF-8 文本发送语句，您应该将环境的语言环境设置为 UTF-8 来编辑该文件，以便文件编码正确等操作系统正确处理它。如果你使用
mysql从终端窗口中访问客户端，该窗口必须配置为使用 UTF-8，否则字符可能无法正确显示。对于在 Web 环境中执行的脚本，脚本必须正确处理字符编码以与 MySQL 服务器交互，并且它必须生成正确指示编码的页面，以便浏览器知道如何显示页面内容。例如，您可以在您的元素
中包含此<meta>标记
：<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
© Mysql 中文网
