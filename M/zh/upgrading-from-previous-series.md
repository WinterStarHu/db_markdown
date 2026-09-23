# 2.11.4 MySQL 8.0 的变化_MySQL 8.0 参考手册

2.11.4 MySQL 8.0 的变化_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.11.1 开始之前1
2.11.2 升级路径1
2.11.3 MySQL升级过程升级了什么1
2.11.4 MySQL 8.0 的变化1
2.11.5 准备升级安装1
2.11.6 在 Unix/Linux 上升级 MySQL 二进制或基于包的安装1
2.11.7 使用 MySQL Yum 仓库升级 MySQL1
2.11.8 使用MySQL APT Repository升级MySQL1
2.11.9 使用 MySQL SLES 存储库升级 MySQL1
2.11.10 Windows 升级MySQL1
2.11.11 升级MySQL的Docker安装1
2.11.12 升级故障处理1
2.11.13 重建或修复表或索引1
2.11.14 复制MySQL数据库到另一台机器1
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.11 升级MySQL  /
2.11.4 MySQL 8.0 的变化
2.11.4 MySQL 8.0 的变化
在升级到 MySQL 8.0 之前，请查看本节中描述的更改以确定适用于您当前的 MySQL 安装和应用程序的更改。执行任何建议的操作。
标记为不兼容更改的更改与早期版本的 MySQL 不兼容，可能需要您在升级前注意。我们的目标是避免这些更改，但有时它们是纠正比版本之间不兼容更糟糕的问题所必需的。如果适用于您的安装的升级问题涉及不兼容性，请按照说明中给出的说明进行操作。
数据字典更改caching_sha2_password 作为首选身份验证插件配置更改服务器变更InnoDB 的变化SQL 更改更改服务器默认值
数据字典更改
MySQL Server 8.0 合并了一个全局数据字典，其中包含有关事务表中数据库对象的信息。在之前的 MySQL 系列中，字典数据存储在元数据文件和非事务性系统表中。因此，升级过程需要您通过检查特定的先决条件来验证安装的升级准备情况。有关详细信息，请参阅
第 2.11.5 节 “准备升级安装”。启用数据字典的服务器需要一些一般的操作差异；参见
第 14.7 节，“数据字典使用差异”。
caching_sha2_password 作为首选身份验证插件
和caching_sha2_password身份
sha256_password验证插件提供比插件更安全的密码加密
mysql_native_password，并
caching_sha2_password提供比sha256_password. 由于这些卓越的安全性和性能特征
caching_sha2_password，它是 MySQL 8.0 的首选身份验证插件，也是默认的身份验证插件，而不是
mysql_native_password. 此更改会影响服务器和libmysqlclient客户端库：
对于服务器，
default_authentication_plugin
系统变量的默认值从
mysql_native_password变为
caching_sha2_password。
此更改仅适用于安装或升级到 MySQL 8.0 或更高版本后创建的新帐户。对于已存在于升级安装中的帐户，其身份验证插件保持不变。希望切换到的现有用户caching_sha2_password
可以使用以下ALTER
USER语句：
ALTER USER user
IDENTIFIED WITH caching_sha2_password
BY 'password';
该libmysqlclient库
caching_sha2_password将
mysql_native_password.
以下各节讨论 的更突出作用的含义caching_sha2_password：
caching_sha2_password 兼容性问题及解决方案caching_sha2_password 兼容的客户端和连接器caching_sha2_password 和根管理帐户caching_sha2_password 和复制
caching_sha2_password 兼容性问题及解决方案
重要的
如果您的 MySQL 安装必须为 8.0 之前的客户端提供服务，并且在升级到 MySQL 8.0 或更高版本后遇到兼容性问题，解决这些问题并恢复 8.0 之前兼容性的最简单方法是重新配置服务器以恢复到以前的默认身份验证插件（mysql_native_password). 例如，在服务器选项文件中使用这些行：
[mysqld]
default_authentication_plugin=mysql_native_password
该设置使 8.0 之前的客户端能够连接到 8.0 服务器，直到您安装中使用的客户端和连接器升级为了解
caching_sha2_password. 但是，该设置应被视为临时的，而不是长期或永久的解决方案，因为它会导致使用有效设置创建的新帐户放弃由 提供的改进的身份验证安全性caching_sha2_password。
使用caching_sha2_password提供了比
mysql_native_password（以及随之而来的改进的客户端连接身份验证）更安全的密码散列。但是，它也具有兼容性影响，可能会影响现有的 MySQL 安装：
尚未更新的客户端和连接器caching_sha2_password可能无法连接到配置
caching_sha2_password为默认身份验证插件的 MySQL 8.0 服务器，即使使用未使用caching_sha2_password. 发生此问题是因为服务器将其默认身份验证插件的名称指定给客户端。如果客户端或连接器基于无法正常处理无法识别的默认身份验证插件的客户端/服务器协议实现，则它可能会失败并出现以下错误之一：
Authentication plugin 'caching_sha2_password' is not supportedAuthentication plugin 'caching_sha2_password' cannot be loaded:
dlopen(/usr/local/mysql/lib/plugin/caching_sha2_password.so, 2):
image not foundWarning: mysqli_connect(): The server requested authentication
method unknown to the client [caching_sha2_password]
有关编写连接器以优雅地处理服务器对未知默认身份验证插件的请求的信息，请参阅
身份验证插件连接器编写注意事项。
使用经过身份验证的帐户的客户端
caching_sha2_password必须使用安全连接（使用使用 TLS/SSL 凭据的 TCP、Unix 套接字文件或共享内存），或使用 RSA 密钥对支持密码交换的未加密连接。此安全要求不适用于
mysql_native_passsword，因此切换到
caching_sha2_password可能需要额外的配置（请参阅
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”）。但是，MySQL 8.0 中的客户端连接默认首选使用 TLS/SSL，因此已经符合该首选项的客户端可能不需要额外的配置。
尚未更新以了解的客户端和连接器caching_sha2_password
无法连接到通过身份验证的帐户，caching_sha2_password
因为它们不认为此插件有效。（这是客户端/服务器身份验证插件兼容性要求如何应用的特定实例，如
身份验证插件客户端/服务器兼容性中所讨论。）要解决此问题，请重新链接客户端与
libmysqlclientMySQL 8.0 或更高版本，或获取可识别的更新连接器
caching_sha2_password.
因为caching_sha2_password现在也是
libmysqlclient客户端库中的默认身份验证插件，身份验证需要在客户端/服务器协议中进行额外的往返，以便从 MySQL 8.0 客户端连接到使用
mysql_native_password（以前的默认身份验证插件）的帐户，除非客户端程序被调用一个
--default-auth=mysql_native_password
选项。
MySQL 8.0 之前版本的libmysqlclient客户端库能够连接到 MySQL 8.0 服务器（使用 进行身份验证的帐户除外
caching_sha2_password）。这意味着基于 pre-8.0 的客户端libmysqlclient也应该能够连接。例子：
标准的 MySQL 客户端，例如mysql和
mysqladmin都是
libmysqlclient基于 的。
Perl DBI 的 DBD::mysql 驱动程序是
libmysqlclient基于 DBD::mysql 的。
MySQL 连接器/Python 有一个
libmysqlclient基于 的 C 扩展模块。要使用它，请use_pure=False在连接时包含该选项。
当现有的 MySQL 8.0 安装升级到 MySQL 8.0.4 或更高版本时，一些
libmysqlclient基于旧版本的客户端
如果是动态链接的，可能会“自动”升级，因为它们使用升级安装的新客户端库。例如，如果 Perl DBI 的 DBD::mysql 驱动程序使用动态链接，它可以
libmysqlclient在升级到 MySQL 8.0.4 或更高版本后使用 in place，结果如下：
在升级之前，使用 DBD::mysql 的 DBI 脚本可以连接到 MySQL 8.0 服务器，除了使用caching_sha2_password.
升级后，相同的脚本也可以使用
caching_sha2_password帐户。
但是，出现上述结果是因为
libmysqlclient8.0.4 之前的 MySQL 8.0 安装实例是二进制兼容的：它们都使用共享库主版本号 21。对于libmysqlclient从 MySQL 5.7 或更早版本链接的客户端，它们链接到共享库二进制不兼容的不同版本号。在这种情况下，客户端必须libmysqlclient
从 8.0.4 或更高版本重新编译，以完全兼容 MySQL 8.0 服务器和caching_sha2_password帐户。
MySQL Connector/J 5.1 到 8.0.8 能够连接到 MySQL 8.0 服务器，除了使用
caching_sha2_password. （需要 Connector/J 8.0.9 或更高版本才能连接到
caching_sha2_password帐户。）
使用客户端/服务器协议实现的客户端libmysqlclient可能需要升级到理解新身份验证插件的较新版本。例如，在 PHP 中，MySQL 连接通常基于mysqlnd，目前还不知道caching_sha2_password. 在更新版本mysqlnd可用之前，使 PHP 客户端能够连接到 MySQL 8.0 的方法是重新配置服务器以恢复
mysql_native_password为默认身份验证插件，如前所述。
如果客户端或连接器支持显式指定默认身份验证插件的选项，请使用它来命名插件而不是caching_sha2_password. 例子：
一些 MySQL 客户端支持一个
--default-auth选项。（标准的 MySQL 客户端如mysql和
mysqladmin支持这个选项，但没有它也可以成功连接到 8.0 服务器。但是，其他客户端可能支持类似的选项。如果是这样，值得尝试。）
使用libmysqlclientC API 的程序可以调用
带选项
的mysql_options()函数。MYSQL_DEFAULT_AUTH
使用客户端/服务器协议的本机 Python 实现的 MySQL 连接器/Python 脚本可以指定
auth_plugin连接选项。（或者，使用连接器/Python C 扩展，它能够连接到 MySQL 8.0 服务器而无需
auth_plugin.）
caching_sha2_password 兼容的客户端和连接器
如果可用的客户端或连接器已更新为知道caching_sha2_password，则使用它是确保连接到配置
caching_sha2_password为默认身份验证插件的 MySQL 8.0 服务器时的兼容性的最佳方法。
这些客户端和连接器已升级为支持
caching_sha2_password：
MySQL 8.0（8.0.4 或更高版本）中的libmysqlclient客户端库。标准的 MySQL 客户端，如
mysql和mysqladmin
都是libmysqlclient基于 -based 的，所以它们也是兼容的。
MySQL 5.7（5.7.23 或更高版本）中的libmysqlclient客户端库。标准的 MySQL 客户端，如
mysql和mysqladmin
都是libmysqlclient基于 -based 的，所以它们也是兼容的。
MySQL 连接器/C++ 1.1.11 或更高版本或 8.0.7 或更高版本。
MySQL 连接器/J 8.0.9 或更高版本。
MySQL Connector/NET 8.0.10 或更高版本（通过经典的 MySQL 协议）。
MySQL 连接器/Node.js 8.0.9 或更高版本。
PHP：X DevAPI PHP 扩展 (mysql_xdevapi) 支持
caching_sha2_password.
PHP：PDO_MySQL 和 ext/mysqli 扩展不支持
caching_sha2_password. 另外，PHP 7.1.16之前的版本和7.2.4之前的PHP 7.2使用时，
default_authentication_plugin=caching_sha2_password
即使caching_sha2_password不使用也连接不上。
caching_sha2_password 和根管理帐户
升级到MySQL 8.0，现有账户的认证插件保持不变，包括针对
'root'@'localhost'管理账户的插件。
对于新的 MySQL 8.0 安装，当您初始化数据目录时（使用
第 2.10.1 节“初始化数据目录”中的说明），将
'root'@'localhost'创建该帐户，并且该帐户caching_sha2_password默认使用。因此，要在数据目录初始化后连接到服务器，您必须使用支持caching_sha2_password. 如果您可以执行此操作但希望在安装后root使用该帐户mysql_native_password，请像往常一样安装 MySQL 并初始化数据目录。然后用as连接服务器root，使用ALTER USER如下修改账号认证插件和密码：
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password
BY 'password';
如果您使用的客户端或连接器尚不支持
caching_sha2_password，您可以使用经过修改的数据目录初始化程序，该程序在
创建root帐户后
mysql_native_password立即将其关联。为此，请使用以下任一技术：
与或
一起提供
一个
--default-authentication-plugin=mysql_native_password
选项
。
--initialize--initialize-insecure
在选项文件中设置
default_authentication_plugin
为，并使用带有或
的选项mysql_native_password命名该选项文件
。（在这种情况下，如果您继续使用该选项文件进行后续服务器启动，则
除非您从选项文件中删除
设置，否则将创建新帐户而不是
。）
--defaults-file--initialize--initialize-insecuremysql_native_passwordcaching_sha2_passworddefault_authentication_plugin
caching_sha2_password 和复制
在所有服务器都已升级到 MySQL 8.0.4 或更高版本的复制方案中，与源服务器的副本连接可以使用通过
caching_sha2_password. 对于此类连接，同样的要求适用于其他使用通过以下方式进行身份验证的帐户的客户端
caching_sha2_password：使用安全连接或基于 RSA 的密码交换。
要连接到caching_sha2_password用于源/副本复制的帐户：
使用以下任一CHANGE MASTER
TO选项：
MASTER_SSL = 1
GET_MASTER_PUBLIC_KEY = 1
MASTER_PUBLIC_KEY_PATH='path to RSA public key file'
或者，如果在服务器启动时提供了所需的密钥，则可以使用与 RSA 公钥相关的选项。
要连接到一个caching_sha2_password帐户以进行组复制：
对于使用 OpenSSL 构建的 MySQL，设置以下任一系统变量：
SET GLOBAL group_replication_recovery_use_ssl = ON;
SET GLOBAL group_replication_recovery_get_public_key = 1;
SET GLOBAL group_replication_recovery_public_key_path = 'path to RSA public key file';
或者，如果在服务器启动时提供了所需的密钥，则可以使用与 RSA 公钥相关的选项。
配置更改
不兼容的更改：MySQL 存储引擎现在负责提供自己的分区处理程序，MySQL 服务器不再提供通用分区支持。
InnoDB并且
NDB是唯一提供 MySQL 8.0 支持的本机分区处理程序的存储引擎。使用任何其他存储引擎的分区表必须
在升级服务器之前InnoDB进行更改——要么将其转换为或NDB，要么删除其分区
，否则之后将无法使用。
有关将MyISAM
表转换为 的信息InnoDB，请参阅
第 15.6.1.5 节，“将表从 MyISAM 转换为 InnoDB”。
在 MySQL 8.0 中
，使用没有此类支持的存储引擎导致分区表的表创建语句失败并出现错误 ( ER_CHECK_NOT_IMPLEMENTED )。如果您使用
mysqldump从 MySQL 5.7（或更早版本）创建的转储文件导入数据库到 MySQL 8.0 服务器，则必须确保创建分区表的任何语句也不会指定不受支持的存储引擎，方法是删除对分区的任何引用，或者通过将存储引擎指定为
InnoDB或允许将其设置为
InnoDB默认值。
笔记
第 2.11.5 节“准备升级安装”中
给出的过程
描述了如何识别在升级到 MySQL 8.0 之前必须更改的分区表。
有关详细信息，请参阅
第 24.6.2 节，“与存储引擎相关的分区限制”。
不兼容的更改：几个服务器错误代码未使用并已被删除（有关列表，请参阅
MySQL 8.0 中删除的功能）。应更新专门针对其中任何一项进行测试的应用程序。
重要更改：默认字符集已从更改
latin1为utf8mb4。这些系统变量受到影响：
character_set_server
和
系统变量
的默认值
character_set_database
已从更改
latin1为utf8mb4。
collation_server和
系统变量
的默认值
collation_database
已从更改
latin1_swedish_ci为
utf8mb4_0900_ai_ci。
因此，新对象的默认字符集和排序规则与以前不同，除非指定了明确的字符集和排序规则。这包括数据库和其中的对象，例如表、视图和存储的程序。假设使用了以前的默认值，一种保留它们的方法是使用my.cnf文件中的这些行启动服务器：
[mysqld]
character_set_server=latin1
collation_server=latin1_swedish_ci
在复制设置中，从 MySQL 5.7 升级到 8.0 时，建议在升级前将默认字符集更改回 MySQL 5.7 中使用的字符集。升级完成后，可以将默认字符集更改为utf8mb4.
不兼容的更改：从 MySQL 8.0.11 开始，禁止
lower_case_table_names
使用与服务器初始化时使用的设置不同的设置启动服务器。该限制是必要的，因为各种数据字典表字段使用的排序规则基于
lower_case_table_names
服务器初始化时定义的设置，并且使用不同的设置重新启动服务器会导致标识符的排序和比较方式不一致。
服务器变更
在 MySQL 8.0.11 中，删除了一些与账户管理相关的弃用特性，例如使用
GRANT语句修改用户账户的非特权特征、
NO_AUTO_CREATE_USERSQL 模式、
PASSWORD()函数和
old_passwords系统变量。
将引用这些已删除功能的语句从 MySQL 5.7 复制到 8.0 可能会导致复制失败。使用任何已删除功能的应用程序应进行修改以避免它们并尽可能使用替代品，如MySQL 8.0 中删除的功能中所述。
为避免在 MySQL 8.0 上启动失败，请NO_AUTO_CREATE_USER从
sql_modeMySQL 选项文件中的系统变量设置中删除任何实例。
将存储程序定义中包含
NO_AUTO_CREATE_USERSQL 模式的转储文件加载到 MySQL 8.0 服务器中会导致失败。从 MySQL 5.7.24 和 MySQL 8.0.13 开始，
mysqldumpNO_AUTO_CREATE_USER从存储的程序定义中删除
。mysqldump必须手动修改使用早期版本创建的转储文件
以删除NO_AUTO_CREATE_USER.
在
MySQL 8.0.11
中DB2，
删除了
这些已弃用的兼容 SQL模式
：、、、、、、、、、、、、
。
它们不能再分配给系统变量或用作
mysqldump选项的允许值。
MAXDBMSSQLMYSQL323MYSQL40ORACLEPOSTGRESQLNO_FIELD_OPTIONSNO_KEY_OPTIONSNO_TABLE_OPTIONSsql_mode
--compatible
删除MAXDB意味着
or
的TIMESTAMP数据类型
不再被视为.
CREATE TABLEALTER TABLEDATETIME
从 MySQL 5.7 到 8.0 的引用已删除 SQL 模式的语句的复制可能导致复制失败。这包括在当前值包括任何已删除模式CREATE时执行的存储程序（存储过程和函数、触发器和事件）语句的
复制。sql_mode应修改使用任何已删除模式的应用程序以避免它们。
从 MySQL 8.0.3 开始，空间数据类型允许一个
SRID属性，以明确指示存储在列中的值的空间参考系统 (SRS)。请参阅第 11.4.1 节，“空间数据类型”。
具有显式SRID
属性的空间列是受 SRID 限制的：该列仅采用具有该 ID 的值，并且SPATIAL该列上的索引将由优化器使用。优化器忽略没有属性SPATIAL的空间列上的索引。SRID请参阅
第 8.3.3 节，“空间索引优化”。如果您希望优化器考虑SPATIAL不受 SRID 限制的空间列上的索引，则应修改每个此类列：
验证列中的所有值是否具有相同的 SRID。要确定几何列中包含的 SRID col_name，请使用以下查询：
SELECT DISTINCT ST_SRID(col_name) FROM tbl_name;
如果查询返回多行，则该列包含 SRID 的混合。在这种情况下，修改其内容，使所有值都具有相同的 SRID。
重新定义列以具有显式
SRID属性。
重新创建SPATIAL索引。
MySQL 8.0.0 中删除了几个空间函数，因为空间函数名称空间更改
ST_为执行精确操作的函数实现了前缀，或者MBR为基于最小边界矩形执行操作的函数实现了前缀。在生成的列定义中使用已删除的空间函数可能会导致升级失败。在升级之前，为删除的空间函数运行mysqlcheck --check-upgrade并将找到的任何替换为它们的ST_
或MBR命名的替换项。有关已删除空间函数的列表，请参阅
MySQL 8.0 中删除的功能.
当执行到 MySQL 8.0.3 或更高版本的就地升级时，
该BACKUP_ADMIN权限会自动授予具有权限的用户
。RELOAD
从 MySQL 8.0.13 开始，由于基于行或混合的复制模式与基于语句的复制模式在处理临时表的方式上存在差异，因此在运行时切换二进制日志格式有新的限制。
SET @@SESSION.binlog_format如果会话有任何打开的临时表，则不能使用。
SET @@global.binlog_format如果任何复制通道有任何打开的临时表，
SET @@persist.binlog_format则不能使用。SET
@@persist_only.binlog_format如果复制通道有打开的临时表，则允许，因为与 不同PERSIST，
PERSIST_ONLY不会修改运行时全局系统变量值。
SET @@global.binlog_format如果任何复制通道应用程序正在运行，
SET @@persist.binlog_format则不能使用。这是因为更改仅在其应用程序重新启动时才对复制通道生效，此时复制通道可能已打开临时表。此行为比以前更具限制性。SET
@@persist_only.binlog_format如果任何复制通道应用程序正在运行，则允许。
从 MySQL 8.0.27 开始，配置会话设置
internal_tmp_mem_storage_engine
需要
SESSION_VARIABLES_ADMIN
或
SYSTEM_VARIABLES_ADMIN
权限。
从 MySQL 8.0.27 开始，克隆插件允许在克隆操作正在进行时对供体 MySQL 服务器实例进行并发 DDL 操作。以前，在克隆操作期间会持有一个备份锁，以防止对捐赠者进行并发 DDL。要恢复到先前在克隆操作期间阻止捐助者上的并发 DDL 的行为，请启用该
clone_block_ddl
变量。请参阅
第 5.6.7.4 节，“克隆和并发 DDL”。
从 MySQL 8.0.30 开始，启动时值中列出的错误日志组件在
log_error_servicesMySQL 服务器启动序列的早期隐式加载。如果您之前使用安装了可加载错误日志组件，INSTALL
COMPONENT并且在启动时读取的设置中列出了这些组件
log_error_services（例如，从选项文件），则应更新您的配置以避免启动警告。有关详细信息，请参阅
错误日志配置方法。
InnoDB 的变化
INFORMATION_SCHEMA基于InnoDB系统表的视图被数据字典表的内部系统视图所取代。受影响
InnoDB
INFORMATION_SCHEMA的视图已重命名：
表 2.16 重命名的 InnoDB 信息模式视图
旧名称
新名字
INNODB_SYS_COLUMNS
INNODB_COLUMNS
INNODB_SYS_DATAFILES
INNODB_DATAFILES
INNODB_SYS_FIELDS
INNODB_FIELDS
INNODB_SYS_FOREIGN
INNODB_FOREIGN
INNODB_SYS_FOREIGN_COLS
INNODB_FOREIGN_COLS
INNODB_SYS_INDEXES
INNODB_INDEXES
INNODB_SYS_TABLES
INNODB_TABLES
INNODB_SYS_TABLESPACES
INNODB_TABLESPACES
INNODB_SYS_TABLESTATS
INNODB_TABLESTATS
INNODB_SYS_VIRTUAL
INNODB_VIRTUAL
升级到 MySQL 8.0.3 或更高版本后，更新任何引用以前InnoDB
INFORMATION_SCHEMA视图名称的脚本。
与 MySQL 捆绑的zlib 库
版本从 1.2.3 版本提升到 1.2.11 版本。
zlib 1.2.11 中的 zlibcompressBound()函数返回比 zlib 版本 1.2.3 中压缩给定字节长度所需的缓冲区大小略高的估计值。该函数由确定创建压缩表或在压缩表中插入和更新行时允许的最大行大小的compressBound()
函数调用
。因此，
在
早期版本中成功的行大小非常​​接近最大行大小的、 和
操作现在可能会失败。为避免此问题，请测试
压缩语句InnoDBInnoDBInnoDBCREATE TABLE
... ROW_FORMAT=COMPRESSEDINSERTUPDATECREATE TABLEInnoDB升级前 MySQL 8.0 测试实例上的大行表。
随着该
--innodb-directories
功能的引入，使用绝对路径或在数据目录之外的位置创建的 file-per-table 和通用表空间文件的位置应添加到innodb_directories
参数值中。否则，InnoDB在恢复期间无法找到这些文件。要查看表空间文件位置，请查询
INFORMATION_SCHEMA.FILES表：
SELECT TABLESPACE_NAME, FILE_NAME FROM INFORMATION_SCHEMA.FILES \G
撤消日志不能再驻留在系统表空间中。在 MySQL 8.0 中，undo 日志默认驻留在两个 undo 表空间中。有关详细信息，请参阅
第 15.6.3.4 节，“撤消表空间”。
从 MySQL 5.7 升级到 MySQL 8.0 时，MySQL 5.7 实例中存在的任何撤消表空间都将被删除，并由两个新的默认撤消表空间替换。innodb_undo_directory
默认撤消表空间是在变量定义的位置创建的
。如果
innodb_undo_directory
变量未定义，则在数据目录中创建撤消表空间。从 MySQL 5.7 升级到 MySQL 8.0 需要缓慢关闭，以确保 MySQL 5.7 实例中的撤消表空间为空，从而可以安全地删除它们。
从较早的 MySQL 8.0 版本升级到 MySQL 8.0.14 或更高版本时，由于
innodb_undo_tablespaces
设置大于 2 而存在于升级前实例中的撤消表空间被视为用户定义的撤消表空间，可以停用和删除升级后分别使用
ALTER UNDO
TABLESPACE和
语法。DROP UNDO
TABLESPACEMySQL 8.0 版本系列中的升级可能并不总是需要缓慢关闭，这意味着现有的撤消表空间可能包含撤消日志。因此，升级过程不会删除现有的撤消表空间。
不兼容的更改：从 MySQL 8.0.17 开始，该
CREATE
TABLESPACE ... ADD DATAFILE子句不允许循环目录引用。例如，/../以下语句中的循环目录引用 ( ) 是不允许的：
CREATE TABLESPACE ts1 ADD DATAFILE ts1.ibd 'any_directory/../ts1.ibd';
Linux 上存在该限制的一个例外，如果前面的目录是符号链接，则允许循环目录引用。例如，如果
any_directory是符号链接，则允许上例中的数据文件路径。（仍然允许数据文件路径以 ' ../' 开头。）
为避免升级问题，请在升级到 MySQL 8.0.17 或更高版本之前从表空间数据文件路径中删除任何循环目录引用。要检查表空间路径，请查询
INFORMATION_SCHEMA.INNODB_DATAFILES
表。
由于 MySQL 8.0.14 中引入的回归，对于具有分区表和
lower_case_table_names=1. 失败是由与分区表文件名相关的大小写不匹配问题引起的。引入回归的修复程序已恢复，允许从 MySQL 5.7 或 MySQL 8.0.14 之前的 MySQL 8.0 版本升级到 MySQL 8.0.17 以正常运行。但是，回归仍然存在于 MySQL 8.0.14、8.0.15 和 8.0.16 版本中。
在将二进制文件或包升级到 MySQL 8.0.17 后启动服务器时，在区分大小写的文件系统上从 MySQL 8.0.14、8.0.15 或 8.0.16 到 MySQL 8.0.17 的就地升级失败，如果分区表存在并且
lower_case_table_names=1：
Upgrading from server version version_number with
partitioned tables and lower_case_table_names == 1 on a case sensitive file
system may cause issues, and is therefore prohibited. To upgrade anyway, restart
the new server version with the command line option 'upgrade=FORCE'. When
upgrade is completed, please execute 'RENAME TABLE part_table_name
TO new_table_name; RENAME TABLE new_table_name
TO part_table_name;' for each of the partitioned tables.
Please see the documentation for further information.
如果升级到 MySQL 8.0.17 时遇到此错误，请执行以下解决方法：
重新启动服务器
--upgrade=force以强制升级操作继续进行。
使用小写分区名称分隔符(#p#或
#sp#) 标识分区表文件名：
mysql> SELECT FILE_NAME FROM INFORMATION_SCHEMA.FILES WHERE FILE_NAME LIKE '%#p#%' OR FILE_NAME LIKE '%#sp#%';
对于每个识别的文件，使用临时名称重命名关联的表，然后将表重命名回其原始名称。
mysql> RENAME TABLE table_name TO temporary_table_name;
mysql> RENAME TABLE temporary_table_name TO table_name;
验证没有分区表文件名小写分区名称定界符（应返回空结果集）。
mysql> SELECT FILE_NAME FROM INFORMATION_SCHEMA.FILES WHERE FILE_NAME LIKE '%#p#%' OR FILE_NAME LIKE '%#sp#%';
Empty set (0.00 sec)
在每个重命名的表上运行ANALYZE TABLE以更新
mysql.innodb_index_stats和
mysql.innodb_table_stats表中的优化器统计信息。
由于 MySQL 8.0.14、8.0.15 和 8.0.16 版本中仍然存在回归，因此不支持将分区表从 MySQL 8.0.14、8.0.15 或 8.0.16 导入 MySQL 8.0.17敏感文件系统，其中
lower_case_table_names=1. 尝试这样做会导致“表缺少表空间”错误。
MySQL 在为表分区构造表空间名称和文件名时使用分隔符字符串。“ ”
#p# 分隔符字符串位于分区名称之前，“  #sp#
”分隔符字符串位于子分区名称之前，如下所示
：      schema_name.table_name#p#partition_name#sp#subpartition_name
table_name#p#partition_name#sp#subpartition_name.ibd
从历史上看，分隔符字符串在区分大小写的文件系统（例如 Linux）上是大写的（#P#和），在不区分大小写的文件系统（例如 Windows）上是小写的（和）。从 MySQL 8.0.19 开始，分隔符字符串在所有文件系统上都是小写的。此更改可防止在区分大小写和不区分大小写的文件系统之间迁移数据目录时出现问题。不再使用大写分隔符字符串。
#SP##p##sp#
此外，无论设置如何，基于用户指定的分区或子分区名称生成的分区表空间名称和文件名（可以指定为大写或小写）现在都以小写形式生成（并在内部存储）
lower_case_table_names
以确保不区分大小写。例如，如果创建一个名为 name 的表分区，则生成
PART_1的表空间名称和文件名都是小写的：
schema_name.table_name#p#part_1
table_name#p#part_1.ibd
在升级过程中，MySQL 会根据需要进行检查和修改：
磁盘和数据字典中的分区文件名确保小写分隔符和分区名称。
对数据字典中的元数据进行分区，以解决之前错误修复引入的相关问题。
InnoDB先前错误修复引入的相关问题的统计数据。
在表空间导入操作期间，检查磁盘上的分区表空间文件名并在必要时修改以确保小写分隔符和分区名称。
从 MySQL 8.0.21 开始，如果发现表空间数据文件驻留在未知目录中，则会在启动时或从 MySQL 5.7 升级时向错误日志写入警告。已知目录是由
datadir、
innodb_data_home_dir和
innodb_directories
变量定义的目录。要使目录已知，请将其添加到
innodb_directories设置中。使目录已知可确保在恢复期间可以找到数据文件。有关详细信息，请参阅
崩溃恢复期间的表空间发现。
重要变化：从 MySQL 8.0.30 开始，该
innodb_redo_log_capacity
变量控制重做日志文件占用的磁盘空间量。通过此更改，重做日志文件的默认数量及其位置也发生了变化。从MySQL 8.0.30开始，在data目录InnoDB下的目录下维护了32个redo log文件#innodb_redo之前InnoDB
默认在data目录下创建了两个redo log文件，redo log文件的数量和大小由
innodb_log_files_in_group
和innodb_log_file_size
变量控制。这两个变量现在已弃用。
innodb_redo_log_capacity
定义
设置
时
innodb_log_files_in_group
，innodb_log_file_size
忽略设置；否则，这些设置用于计算innodb_redo_log_capacity
设置 ( innodb_log_files_in_group*
innodb_log_file_size=
innodb_redo_log_capacity)。如果没有设置这些变量，重做日志容量将设置为
innodb_redo_log_capacity默认值，即 104857600 字节 (100MB)。
正如任何升级通常需要的那样，此更改需要在升级前干净关闭。
有关此功能的更多信息，请参阅
第 15.6.5 节，“重做日志”。
SQL 更改
不兼容的更改：从 MySQL 8.0.13 开始，已删除子句ASC或
DESC限定符GROUP
BY以前依赖于GROUP BY排序的查询可能会产生与以前的 MySQL 版本不同的结果。要生成给定的排序顺序，请提供一个ORDER
BY子句。
MySQL 8.0.12 或更低版本中使用ASC或
DESC限定符的GROUP
BY子句的查询和存储程序定义应进行修改。否则，升级到 MySQL 8.0.13 或更高版本可能会失败，复制到 MySQL 8.0.13 或更高版本的副本服务器也可能会失败。
一些关键字可能在 MySQL 8.0 中保留，而在 MySQL 5.7 中没有保留。请参阅
第 9.3 节，“关键字和保留字”。这可能会导致以前用作标识符的词变得非法。要修复受影响的语句，请使用标识符引用。请参阅
第 9.2 节，“模式对象名称”。
升级后，建议您测试应用程序代码中指定的优化器提示，以确保仍然需要这些提示来实现所需的优化策略。优化器增强功能有时会使某些优化器提示变得不必要。在某些情况下，不必要的优化器提示甚至可能适得其反。
不兼容的更改：在 MySQL 5.7 中，子句
表
FOREIGN KEY
定义不带 a 的关键字
会导致
使用生成的约束名称。这种行为在 MySQL 8.0 中发生了变化，使用
值而不是生成的名称。因为每个模式（数据库）的约束名称必须是唯一的，所以更改导致错误是由于每个模式的外键索引名称不是唯一的。为避免此类错误，新的约束命名行为已在 MySQL 8.0.16 中恢复，并且InnoDBCONSTRAINT symbol
CONSTRAINTsymbolInnoDBInnoDBFOREIGN KEY index_name
InnoDB再次使用生成的约束名称。
为了与 保持一致InnoDB，
NDB基于 MySQL 8.0.16 或更高版本的版本在
未指定子句或指定
关键字时使用生成的约束名称而不带
. 基于 MySQL 5.7 的版本和更早的 MySQL 8.0 版本使用该
值。
CONSTRAINT symbol
CONSTRAINTsymbolNDBFOREIGN KEY index_name
上述更改可能会导致依赖于以前的外键约束命名行为的应用程序不兼容。
MySQL流控函数对系统变量值的处理，例如在MySQL 8.0.22中改变IFNULL()
；CASE()系统变量值现在作为具有相同字符和排序规则的列值处理，而不是作为常量处理。一些将这些函数与先前成功的系统变量一起使用的查询随后可能会被Illegal mix of collat​​ions拒绝。在这种情况下，将系统变量转换为正确的字符集和排序规则。
不兼容的更改：MySQL 8.0.28 修复了以前 MySQL 8.0 版本中的一个问题，即该CONVERT()函数有时允许将值无效转换
BINARY二进制字符集。应检查可能依赖此行为的应用程序，并在必要时在升级前进行修改。
特别是，whereCONVERT()被用作索引生成列的表达式的一部分，在升级到 MySQL 8.0.28 后，函数行为的变化可能会导致索引损坏。您可以按照以下步骤防止这种情况发生：
在执行升级之前，更正任何无效的输入数据。
删除然后重新创建索引。
您也可以使用
, 来强制重建表。
ALTER TABLE
table FORCE
升级MySQL软件。
如果无法事先验证输入数据，则在执行到 MySQL 8.0.28 的升级之前，不应重新创建索引或重建表。
更改服务器默认值
MySQL 8.0 改进了默认设置，旨在提供最佳的开箱即用体验。这些变化是由以下事实驱动的：技术在进步（机器有更多的 CPUS、使用 SSD 等）、更多的数据正在存储、MySQL 在发展（InnoDB、Group Replication、AdminAPI）等等。下表总结了为大多数用户提供最佳 MySQL 体验而更改的默认值。
选项/参数
旧默认
新默认
服务器更改
character_set_server
拉丁语1
utf8mb4
collation_server
latin1_swedish_ci
utf8mb4_0900_ai_ci
explicit_defaults_for_timestamp
离开
上
optimizer_trace_max_mem_size
16KB
1MB
validate_password_check_user_name
离开
上
back_log
-1（自动调整大小）更改自：back_log = 50 + (max_connections / 5)
-1（自动调整大小）更改为：back_log = max_connections
max_allowed_packet
4194304 (4MB)
67108864 (64MB)
max_error_count
64
1024
event_scheduler
离开
上
table_open_cache
2000
4000
log_error_verbosity
3（注释）
2（警告）
local_infile
开启 (5.7)
离开
InnoDB 的变化
innodb_undo_tablespaces
0
2个
innodb_undo_log_truncate
离开
上
innodb_flush_method
无效的
fsync (Unix)，无缓冲 (Windows)
innodb_autoinc_lock_mode
1（连续）
2（交错）
innodb_flush_neighbors
1（启用）
0（禁用）
innodb_max_dirty_pages_pct_lwm
0 (%)
10 (%)
innodb_max_dirty_pages_pct
75 (%)
90 (%)
性能架构更改
performance-schema-instrument='wait/lock/metadata/sql/%=ON'
离开
上
performance-schema-instrument='memory/%=COUNTED'
离开
计数
performance-schema-consumer-events-transactions-current=ON
离开
上
performance-schema-consumer-events-transactions-history=ON
离开
上
performance-schema-instrument='transaction%=ON'
离开
上
复制更改
log_bin
离开
上
server_id
0
1个
log-slave-updates
离开
上
expire_logs_days
0
30
master-info-repository
文件
桌子
relay-log-info-repository
文件
桌子
transaction-write-set-extraction
离开
XXHASH64
slave_rows_search_algorithms
INDEX_SCAN，TABLE_SCAN
INDEX_SCAN、HASH_SCAN
slave_pending_jobs_size_max
16M
128M
gtid_executed_compression_period
1000
0
组复制更改
group_replication_autorejoin_tries
0
3个
group_replication_exit_state_action
中止服务器
只读
group_replication_member_expel_timeout
0
5个
有关已添加的选项或变量的更多信息，请参阅MySQL 服务器版本参考中的
MySQL 8.0 的选项/变量更改。
以下部分解释了对默认值的更改以及它们可能对您的部署产生的任何影响。
服务器默认值character_set_server系统变量和命令行选项
的默认值由
--character-set-server
更改latin1为
utf8mb4。这是服务器的默认字符集。目前，UTF8MB4 是 web 的主要字符编码，这一变化使绝大多数 MySQL 用户的生活更加轻松。从 5.7 升级到 8.0 不会更改任何现有数据库对象的任何字符集。但是，除非您指定
character_set_server回以前的默认值或明确设置字符集，否则默认情况下新模式、表或列使用
utf8mb4. 我们建议您搬到 utf8mb4只要有可能。
collation_server系统变量和命令行参数
的默认值
--collation-server从更改latin1_swedish_ci
为 utf8mb4_0900_ai_ci。这是服务器的默认排序规则，即字符集中字符的排序。排序规则和字符集之间存在联系，因为每个字符集都带有一个可能的排序规则列表。从 5.7 升级到 8.0 不会更改任何现有数据库对象的任何排序规则，但会对新对象生效。
系统变量的默认值
explicit_defaults_for_timestamp
从OFF（MySQL 遗留行为）更改为ON（SQL 标准行为）。这个选项最初是在 5.6 中引入的，OFF在 5.6 和 5.7 中都有。
optimizer_trace_max_mem_size
系统变量
的默认值由
更改16KB为
1MB。旧的默认值导致优化器跟踪被任何非平凡查询截断。此更改确保对大多数查询有用的优化器跟踪。
validate_password_check_user_name
系统变量
的默认值由
更改OFF为
ON。这意味着当
validate_password启用插件时，默认情况下它现在拒绝与当前会话用户名匹配的密码。
系统变量的自动大小算法
back_log已更改。autosize (-1) 的值现在设置为 的值max_connections，该值大于 的计算值50 +
(max_connections / 5)。在
back_log服务器无法跟上传入请求的情况下，对传入的 IP 连接请求进行排队。在最坏的情况下，有
max_connections多个客户端同时尝试重新连接，例如在网络故障之后，它们都可以被缓冲并避免拒绝重试循环。
系统变量的默认值
max_allowed_packet从4194304(4M) 更改为
67108864(64M)。这个较大的默认值的主要优点是接收有关插入或查询大于
max_allowed_packet. 它应该与您要使用的最大的第 11.3.4 节“BLOB 和 TEXT 类型”一样大。要恢复到以前的行为，请设置
max_allowed_packet=4194304。
max_error_count系统变量
的默认值由
更改64为
1024。这可确保 MySQL 处理更多的警告，例如涉及 1000 行的 UPDATE 语句，其中许多会给出转换警告。许多工具通常会批量更新，以帮助减少复制滞后。pt-online-schema-change 等外部工具默认为 1000，gh-ost 默认为 100。MySQL 8.0 涵盖了这两个用例的完整错误历史记录。没有静态分配，因此此更改只会影响生成大量警告的语句的内存消耗。
event_scheduler系统变量
的默认值由
更改OFF为
ON。换句话说，默认情况下启用事件调度程序。这是 SYS 中新功能的促成因素，例如“终止空闲事务”。
table_open_cache系统变量
的默认值由
更改2000为
4000。这是一个小的变化，它增加了表访问的会话并发性。
log_error_verbosity系统变量
的默认值
由3（注释）更改为
2（警告）。目的是让 MySQL 8.0 的错误日志默认不那么冗长。
InnoDB 默认值
不兼容的更改innodb_undo_tablespaces
系统变量的默认值
0为
2。配置 InnoDB 使用的撤消表空间的数量。在 MySQL 8.0 中，最小值为innodb_undo_tablespaces
2，并且不能再在系统表空间中创建回滚段。因此，在这种情况下您无法恢复到 5.7 行为。此更改的目的是能够自动截断撤消日志（请参阅下一项），回收（偶尔）长事务（如mysqldump ）使用的磁盘空间。
innodb_undo_log_truncate
系统变量
的默认值由
更改OFF为
ON。启用后，超过定义的阈值的撤消表空间将
innodb_max_undo_log_size
被标记为截断。只能截断撤消表空间。不支持截断驻留在系统表空间中的撤消日志。从 5.7 升级到 8.0 会自动将您的系统转换为使用撤消表空间，使用系统表空间在 8.0 中不是一个选项。
innodb_flush_method系统变量
的默认值
在类 Unix 系统上从
更改为 ，NULL在
Windows 系统上从 更改为 。这更多是术语和选项清理，没有任何实际影响。对于 Unix，这只是一个文档更改，因为默认值
也在 5.7 中（默认值
意味着）。同样在 Windows 上，
default
在 5.7 中表示
，在 8.0中被 default 替换，与现有的 default 组合
具有相同的效果。
fsyncNULLunbufferedfsyncNULLfsyncinnodb_flush_methodNULLasync_unbufferedunbufferedinnodb_use_native_aio=ON
Incompatible changeinnodb_autoinc_lock_mode
系统变量的默认值
1
（consecutive）变为2（interleaved）。将交错锁模式更改为默认设置反映了从基于语句的复制到基于行的复制作为默认复制类型的更改，这发生在 MySQL 5.7 中。基于语句的复制需要连续的自增锁模式，以确保对于给定的 SQL 语句序列，自动增量值以可预测和可重复的顺序分配，而
基于行的复制对SQL语句的执行顺序不敏感。因此，已知此更改与基于语句的复制不兼容，并且可能会破坏某些依赖于顺序自动增量的应用程序或用户生成的测试套件。可以通过设置恢复之前的默认值
innodb_autoinc_lock_mode=1;
innodb_flush_neighbors
系统变量
的默认值
由1（enable）变为0（disable）。这样做是因为快速 IO (SSD) 现在是部署的默认设置。我们预计，对于大多数用户而言，这会带来较小的性能提升。使用较慢硬盘驱动器的用户可能会看到性能下降，并鼓励通过设置恢复到以前的默认值
innodb_flush_neighbors=1。
innodb_max_dirty_pages_pct_lwm
系统变量
的默认值
由0（%）更改为
10（%）。使用
innodb_max_dirty_pages_pct_lwm=10，当 >10% 的缓冲池包含修改的（“脏”）页面时，InnoDB 会增加其刷新活动。此更改的目的是稍微权衡峰值吞吐量，以换取更一致的性能。
innodb_max_dirty_pages_pct
系统变量
的默认值
由75（%）更改为
90（%）。此更改与更改相结合，
innodb_max_dirty_pages_pct_lwm
它们共同确保了 InnoDB 的平滑刷新行为，避免了刷新突发。要恢复到以前的行为，请设置
innodb_max_dirty_pages_pct=75和
innodb_max_dirty_pages_pct_lwm=0。
性能模式默认值
默认情况下，性能模式元数据锁定 (MDL) 检测处于打开状态。的编译默认值
performance-schema-instrument='wait/lock/metadata/sql/%=ON'
从更改OFF为
ON。这是在 SYS 中添加面向 MDL 的视图的启动器。
默认情况下，性能架构内存检测处于打开状态。的编译默认值
performance-schema-instrument='memory/%=COUNTED'
从更改OFF为
COUNTED。这很重要，因为如果在服务器启动后启用检测，则记帐是不正确的，并且您可能会因缺少分配而获得负余额，但获得了免费分配。
Performance Schema Transaction instrumentation 默认开启。performance-schema-consumer-events-transactions-current=ON、
performance-schema-consumer-events-transactions-history=ON和
的编译默认值
performance-schema-instrument='transaction%=ON'
从 更改OFF为
ON。
复制默认值log_bin系统变量
的默认值由
更改OFF为
ON。换句话说，默认情况下启用二进制日志记录。几乎所有的生产安装都启用了二进制日志，因为它用于复制和时间点恢复。因此，通过默认启用二进制日志，我们消除了一个配置步骤，稍后启用它需要重新启动mysqld。默认情况下启用它还可以提供更好的测试覆盖率，并且更容易发现性能回归。记住还要设置server_id（请参阅以下更改）。8.0 的默认行为就好像你发布了./mysqld --log-bin --server-id=1. 如果您使用的是 8.0 并且想要 5.7 的行为，您可以发出 ./mysqld --skip-log-bin
--server-id=0.
server_id系统变量
的默认值
从更改0为
1（与更改相结合
log_bin=ON）。服务器可以使用此默认 ID 启动，但实际上您必须server-id根据正在部署的复制基础结构设置，以避免出现重复的服务器 ID。
log-slave-updates系统变量
的默认值由
更改OFF为
ON。这会导致副本将复制的事件记录到它自己的二进制日志中。组复制需要此选项，并且还确保在各种复制链设置中的正确行为，这已成为当今的规范。
expire_logs_days系统变量
的默认值由
更改0为
30。新的默认值30
导致mysqld定期清除超过 30 天的未使用的二进制日志。此更改有助于防止在复制或恢复目的不再需要的二进制日志上浪费过多的磁盘空间。旧值0
禁用任何自动二进制日志清除。
master_info_repository和
系统变量
的默认值
relay_log_info_repository
从FILE变为
TABLE。因此在 8.0 中，复制元数据默认存储在 InnoDB 中。这增加了默认情况下尝试实现崩溃安全复制的可靠性。
transaction-write-set-extraction
系统变量
的默认值由
更改OFF为
XXHASH64。此更改默认启用事务写集。通过使用 Transaction Write Sets，source 必须做更多的工作来生成 write sets，但结果有助于冲突检测。这是组复制的要求，新的默认值使得在源上启用二进制日志写集并行化以加速复制变得容易。
slave_rows_search_algorithms
系统变量
的默认值由
更改INDEX_SCAN,TABLE_SCAN为
INDEX_SCAN,HASH_SCAN。此更改通过减少副本应用程序将更改应用到没有主键的表而必须执行的表扫描次数来加快基于行的复制。
slave_pending_jobs_size_max
系统变量
的默认值由
更改16M为
128M。此更改增加了多线程副本可用的内存量。
gtid_executed_compression_period
系统变量
的默认值由
更改1000为
0。此更改确保mysql.gtid_executed表的压缩仅在需要时隐式发生。
组复制默认值
默认值
group_replication_autorejoin_tries
从 0 更改为 3，这意味着默认启用自动重新加入。此系统变量指定成员尝试自动重新加入组的次数，如果它被开除，或者如果在
group_replication_unreachable_majority_timeout
达到设置之前无法联系组中的大多数人。
的默认值从
group_replication_exit_state_action
更改ABORT_SERVER为
READ_ONLY。这意味着当成员退出组时，例如在网络故障后，实例变为只读，而不是被关闭。
默认值
group_replication_member_expel_timeout
从 0 更改为 5，这意味着在 5 秒检测期后的 5 秒后，怀疑与该组失去联系的成员将被驱逐。
这些默认值中的大多数对于开发和生产环境都相当不错。有一个例外，我们决定保留名为
innodb_dedicated_serverset to
的新选项，OFF尽管我们建议将其
ON用于生产环境。默认为的原因OFF是它会导致共享环境（例如开发人员笔记本电脑）变得不可用，因为它占用了它可以找到的所有内存。
对于生产环境，我们建议设置
innodb_dedicated_server为
ON. 当设置为ON以下 InnoDB 变量（如果未明确指定）时，将根据可用内存
innodb_buffer_pool_size、
innodb_log_file_size和
自动缩放innodb_flush_method。请参阅
第 15.8.12 节，“为专用 MySQL 服务器启用自动配置”。
尽管新默认值是大多数用例的最佳配置选择，但也有特殊情况，以及使用现有 5.7 配置选择的遗留原因。例如，有些人喜欢升级到 8.0，并尽可能少地更改他们的应用程序或操作环境。我们建议评估所有新的默认值并尽可能多地使用。大多数新的默认值可以在 5.7 中进行测试，因此您可以在升级到 8.0 之前在 5.7 生产中验证新的默认值。对于需要旧 5.7 值的少数默认值，请在操作环境中设置相应的配置变量或启动选项。
MySQL 8.0 有 Performance Schema
variables_info表，它为每个系统变量显示最近设置它的来源，以及它的值范围。这提供了对配置变量及其值的所有了解的 SQL 访问。
© Mysql 中文网
