# 10.15 字符集配置_MySQL 8.0 参考手册

10.15 字符集配置_MySQL 8.0 参考手册
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
10.15 字符集配置
10.15 字符集配置
MySQL 服务器有一个内置的默认字符集和排序规则。要更改这些默认值，
请在启动服务器时使用--character-set-server和
选项。--collation-server请参阅第 5.1.7 节，“服务器命令选项”。归类必须是默认字符集的合法归类。要确定每个字符集可用的排序规则，请使用SHOW COLLATION
语句或查询INFORMATION_SCHEMA
COLLATIONS表。
如果您尝试使用未编译到二进制文件中的字符集，您可能会遇到以下问题：
如果您的程序使用不正确的路径来确定字符集的存储位置（通常是 MySQL 安装目录下的
share/mysql/charsets或
share/charsets目录），则可以通过
--character-sets-dir在运行程序时使用该选项来修复此问题。例如，要指定 MySQL 客户端程序使用的目录，请将其列在
[client]您的选项文件组中。此处给出的示例分别显示了 Unix 或 Windows 的设置：
[client]
character-sets-dir=/usr/local/mysql/share/mysql/charsets
[client]
character-sets-dir="C:/Program Files/MySQL/MySQL Server 8.0/share/charsets"
如果字符集是不能动态加载的复杂字符集，则必须重新编译程序以支持该字符集。
对于 Unicode 字符集，您可以使用 LDML 表示法定义排序规则而无需重新编译。请参阅
第 10.14.4 节，“将 UCA 归类添加到 Unicode 字符集”。
如果字符集是一个动态字符集，但你没有它的配置文件，你应该从一个新的 MySQL 发行版中安装字符集的配置文件。
如果您的字符集索引文件 ( Index.xml) 不包含字符集的名称，您的程序将显示一条错误消息：
Character set 'charset_name' is not a compiled character set and is not
specified in the '/usr/share/mysql/charsets/Index.xml' file
要解决这个问题，您应该获取一个新的索引文件，或者手动将任何缺失字符集的名称添加到当前文件中。
您可以强制客户端程序使用特定的字符集，如下所示：
[client]
default-character-set=charset_name
这通常是不必要的。但是，当
character_set_system与
character_set_server或
不同character_set_client，并且您手动输入字符（如数据库对象标识符、列值或两者）时，这些字符可能无法正确显示在客户端的输出中，或者输出本身的格式可能不正确。在这种情况下，启动 mysql 客户端
— 即设置客户端字符集以匹配系统字符集 — 应该可以解决问题。
--default-character-set=system_character_set
© Mysql 中文网
