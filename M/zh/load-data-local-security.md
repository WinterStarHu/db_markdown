# 6.1.6 LOAD DATA LOCAL 的安全注意事项_MySQL 8.0 参考手册

6.1.6 LOAD DATA LOCAL 的安全注意事项_MySQL 8.0 参考手册
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
6.1.1 安全指南1
6.1.2 保证密码安全1
6.1.3 使 MySQL 免受攻击1
6.1.4 安全相关的 mysqld 选项和变量1
6.1.5 如何以普通用户运行MySQL1
6.1.6 LOAD DATA LOCAL 的安全注意事项1
6.1.7 客户端编程安全指南1
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.1 一般安全问题  /
6.1.6 LOAD DATA LOCAL 的安全注意事项
6.1.6 LOAD DATA LOCAL 的安全注意事项
该LOAD DATA语句将数据文件加载到表中。该语句可以加载位于服务器主机上的文件，或者如果LOCAL指定了关键字，则可以加载客户端主机上的文件。
的LOCAL版本LOAD
DATA有两个潜在的安全问题：
因为LOAD DATA
LOCAL是一条SQL语句，解析发生在服务器端，文件从客户端主机到服务器主机的传输是由MySQL服务器发起的，它告诉客户端语句中命名的文件。理论上，打过补丁的服务器可以告诉客户端程序传输服务器选择的文件，而不是声明中指定的文件。这样的服务器可以访问客户端用户具有读取权限的客户端主机上的任何文件。（打过补丁的服务器实际上可以用文件传输请求回复任何语句，而不仅仅是
LOAD DATA
LOCAL，所以一个更基本的问题是客户端不应该连接到不受信任的服务器。）
在客户端从 Web 服务器连接的 Web 环境中，用户可以
LOAD DATA
LOCAL用来读取 Web 服务器进程具有读取权限的任何文件（假设用户可以对 SQL 服务器运行任何语句）。在这种环境下，MySQL服务器的客户端实际上是Web服务器，而不是连接到Web服务器的用户运行的远程程序。
为避免连接到不受信任的服务器，客户端可以建立安全连接并通过使用
--ssl-mode=VERIFY_IDENTITY选项和适当的 CA 证书进行连接来验证服务器身份。要实施此级别的验证，您必须首先确保服务器的 CA 证书对副本可靠可用，否则会导致可用性问题。有关详细信息，请参阅
加密连接的命令选项。
为避免出现问题，除非已采取适当的客户端预防措施，否则
LOAD DATA客户应避免使用。LOCAL
为了控制本地数据加载，MySQL 允许启用或禁用该功能。此外，从 MySQL 8.0.21 开始，MySQL 允许客户端将本地数据加载操作限制为位于指定目录中的文件。
启用或禁用本地数据加载能力限制允许本地数据加载的文件MySQL Shell 和本地数据加载
启用或禁用本地数据加载能力
管理员和应用程序可以配置是否允许本地数据加载，如下所示：
在服务器端：
local_infile系统变量控制服务器端的
能力LOCAL
。根据
local_infile设置，服务器拒绝或允许请求本地数据加载的客户端加载本地数据。
默认情况下，
local_infile禁用。（这是对以前版本的 MySQL 的一个更改。）要使服务器
LOAD DATA
LOCAL显式拒绝或允许语句（无论客户端程序和库在构建时或运行时如何配置），请以
禁用或启用的
方式启动mysqld 。也可以在运行时设置。
local_infilelocal_infile
在客户端：
CMake选项控制 MySQL 客户端库
的编译默认功能（请参阅
第 2.9.7 节，“MySQL 源配置选项”）。因此，没有明确安排的客户端
根据
MySQL 构建时指定的设置禁用或启用功能。
ENABLED_LOCAL_INFILE
LOCALLOCALENABLED_LOCAL_INFILE
默认情况下，MySQL 二进制发行版中的客户端库在编译时
ENABLED_LOCAL_INFILE
禁用。如果您从源代码编译 MySQL，请ENABLED_LOCAL_INFILE
根据未做出明确安排的客户端是否应
LOCAL禁用或启用功能来将其配置为禁用或启用。
对于使用C API的客户端程序，本地数据加载能力由默认编译到MySQL客户端库中决定。要显式启用或禁用它，请调用
mysql_options()C API 函数来禁用或启用该
MYSQL_OPT_LOCAL_INFILE选项。请参阅
mysql_options()。
对于mysql客户端，本地数据加载能力是由默认编译到mysql客户端库中决定的。要明确禁用或启用它，请使用
--local-infile=0或
--local-infile[=1]选项。
对于mysqlimport客户端，默认不使用本地数据加载。要明确禁用或启用它，请使用
--local=0或
--local[=1]选项。
如果您
在 Perl 脚本或其他从选项文件LOAD DATA
LOCAL中读取组的程序中使用，则可以向该组添加
选项设置。为防止不理解此选项的程序出现问题，请使用
前缀指定它：
[client]local-infileloose-[client]
loose-local-infile=0
或者：
[client]
loose-local-infile=1
在所有情况下，客户端成功使用
LOCAL加载操作还需要服务器允许本地加载。
如果LOCAL禁用功能，则在服务器端或客户端，尝试发出
LOAD DATA
LOCAL语句的客户端会收到以下错误消息：
ERROR 3950 (42000): Loading local data is disabled; this must be
enabled on both the client and server side
限制允许本地数据加载的文件
从 MySQL 8.0.21 开始，MySQL 客户端库使客户端应用程序能够将本地数据加载操作限制为位于指定目录中的文件。某些 MySQL 客户端程序利用了此功能。
MYSQL_OPT_LOCAL_INFILE使用 C API 的客户端程序可以使用 C API 函数的和
MYSQL_OPT_LOAD_DATA_LOCAL_DIR选项
来控制哪些文件允许加载数据加载
mysql_options()（请参阅mysql_options()）。
的效果MYSQL_OPT_LOAD_DATA_LOCAL_DIR
取决于LOCAL数据加载是启用还是禁用：
如果LOCAL启用了数据加载，则默认情况下在 MySQL 客户端库中或通过显式启用MYSQL_OPT_LOCAL_INFILE，该
MYSQL_OPT_LOAD_DATA_LOCAL_DIR选项无效。
如果LOCAL数据加载被禁用，无论是默认在 MySQL 客户端库中还是通过显式禁用MYSQL_OPT_LOCAL_INFILE，该
MYSQL_OPT_LOAD_DATA_LOCAL_DIR选项可用于为本地加载的文件指定允许的目录。在这种情况下，LOCAL允许数据加载但仅限于位于指定目录中的文件。该值的解释
MYSQL_OPT_LOAD_DATA_LOCAL_DIR如下：
如果该值为空指针（默认值），则它不命名任何目录，结果是不允许任何文件进行LOCAL数据加载。
如果该值为目录路径名，
LOCAL则允许数据加载，但仅限于位于指定目录中的文件。无论底层文件系统是否区分大小写，目录路径名和要加载文件的路径名的比较都是区分大小写的。
MySQL客户端程序使用上述
mysql_options()选项如下：
mysql客户端有一个
选项
，--load-data-local-dir它接受一个目录路径或一个空字符串。
mysql使用选项值来设置
MYSQL_OPT_LOAD_DATA_LOCAL_DIR选项（使用空字符串将值设置为空指针）。效果
--load-data-local-dir取决于是否LOCAL启用数据加载：
如果LOCAL启用数据加载（默认情况下在 MySQL 客户端库中或通过指定
--local-infile[=1]），则该
--load-data-local-dir
选项将被忽略。
如果LOCAL禁用数据加载（默认情况下在 MySQL 客户端库中或通过指定
--local-infile=0），则
--load-data-local-dir
应用该选项。
应用时--load-data-local-dir
，选项值指定本地数据文件必须位于的目录。无论底层文件系统是否区分大小写，目录路径名和要加载文件的路径名的比较都是区分大小写的。如果选项值为空字符串，则它不命名目录，结果是不允许本地数据加载任何文件。
mysqlimport为它处理的每个文件设置
MYSQL_OPT_LOAD_DATA_LOCAL_DIR，以便包含该文件的目录是允许的本地加载目录。
对于
LOAD DATA语句对应的数据加载操作，
mysqlbinlog从二进制日志事件中提取文件，将其作为临时文件写入本地文件系统，并写入
LOAD DATA
LOCAL语句使文件加载。默认情况下，mysqlbinlog将这些临时文件写入特定于操作系统的目录。该--local-load选项可用于明确指定
mysqlbinlog应该准备本地临时文件的目录。
因为其他进程可以将文件写入默认的系统特定目录，所以建议为
mysqlbinlog--local-load指定选项以
指定数据文件的不同目录，然后
在处理
mysqlbinlog的输出时通过为mysql指定选项指定同一目录.
--load-data-local-dir
MySQL Shell 和本地数据加载
MySQL Shell 提供了许多实用程序来转储表、模式或服务器实例并将它们加载到其他实例中。当您使用这些实用程序处理数据时，MySQL Shell 会提供额外的功能，例如输入预处理、多线程并行加载、文件压缩和解压缩，以及处理对 Oracle Cloud Infrastructure 对象存储桶的访问。要获得最佳功能，请始终使用最新版本的 MySQL Shell 的转储和转储加载实用程序。
MySQL Shell 的数据上传实用程序使用
LOAD DATA LOCAL
INFILE语句上传数据，因此
local_infile必须ON在目标服务器实例上将系统变量设置为。您可以在上传数据之前执行此操作，然后再将其删除。这些实用程序安全地处理文件传输请求以处理本主题中讨论的安全注意事项。
MySQL Shell 包括这些转储和转储加载实用程序：
表导出实用程序util.exportTable()
将 MySQL 关系表导出到数据文件，可以使用 MySQL Shell 的并行表导入实用程序将其上传到 MySQL 服务器实例，导入到不同的应用程序，或用作逻辑备份。该实用程序具有预设选项和自定义选项以生成不同的输出格式。
并行表导入实用程序
util.importTable()
将数据文件导入 MySQL 关系表。数据文件可以是 MySQL Shell 的表导出实用程序的输出，也可以是该实用程序的预设和自定义选项支持的其他格式。该实用程序可以在将数据添加到表之前执行输入预处理。它可以接受多个数据文件合并到一个关系表中，并自动解压缩压缩文件。
实例转储实用程序
util.dumpInstance()、架构转储实用程序
util.dumpSchemas()和表转储实用程序util.dumpTables()
将实例、模式或表导出到一组转储文件，然后可以使用 MySQL Shell 的转储加载实用程序将其上传到 MySQL 实例。这些实用程序提供 Oracle Cloud Infrastructure 对象存储流、MySQL 数据库服务兼容性检查和修改，以及执行空运行以在继续转储之前识别问题的能力。
转储加载实用程序util.loadDump()
将使用 MySQL Shell 的实例、模式或表转储实用程序创建的转储文件导入 MySQL 数据库服务数据库系统或 MySQL 服务器实例。该实用程序管理上传过程并提供来自远程存储的数据流、表或表块的并行加载、进度状态跟踪、恢复和重置功能，以及转储仍在进行时并发加载的选项。MySQL Shell 的并行表导入实用程序可以与转储加载实用程序结合使用，在将数据上传到目标 MySQL 实例之前修改数据。
有关实用程序的详细信息，请参阅
MySQL Shell 实用程序。
© Mysql 中文网
