# 5.6.1 安装和卸载插件_MySQL 8.0 参考手册

5.6.1 安装和卸载插件_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.6.1 安装和卸载插件1
5.6.2 获取服务器插件信息1
5.6.3 MySQL企业级线程池1
5.6.4 重写器查询重写插件1
5.6.5 ddl_rewriter 插件1
5.6.6 版本令牌1
5.6.7 克隆插件1
5.6.8 密钥环代理桥插件1
5.6.9 MySQL 插件服务1
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.6 MySQL 服务器插件  /
5.6.1 安装和卸载插件
5.6.1 安装和卸载插件
服务器插件必须先加载到服务器才能使用。MySQL 支持在服务器启动和运行时加载插件。还可以在启动时控制加载插件的激活状态，并在运行时卸载它们。
加载插件时，有关它的信息可用，如第 5.6.2 节“获取服务器插件信息”中所述。
安装插件控制插件激活状态卸载插件插件和可加载函数
安装插件
在可以使用服务器插件之前，必须使用以下方法之一安装它。在描述中，
plugin_name代表插件名称，例如innodb、csv或
validate_password。
内置插件在 mysql.plugin 系统表中注册的插件使用命令行选项命名的插件使用 INSTALL PLUGIN 语句安装的插件
内置插件
服务器自动识别内置插件。默认情况下，服务器在启动时启用插件。一些内置插件允许使用
选项更改它。
--plugin_name[=activation_state]
在 mysql.plugin 系统表中注册的插件
系统表用作插件的mysql.plugin注册表（内置插件除外，不需要注册）。在正常的启动序列中，服务器加载表中注册的插件。默认情况下，对于从mysql.plugin表中加载的插件，服务器也会启用该插件。这可以通过
选项更改。
--plugin_name[=activation_state]
如果服务器以该
--skip-grant-tables选项启动，则表中注册的插件mysql.plugin不会加载并且不可用。
使用命令行选项命名的插件
位于插件库文件中的插件可以在服务器启动时使用
--plugin-load、
--plugin-load-add或
--early-plugin-load选项加载。通常，对于启动时加载的插件，服务器也会启用该插件。这可以通过
选项更改。
--plugin_name[=activation_state]
和选项在内置插件和存储引擎在服务器启动序列期间初始化后加载插件--plugin-load。
--plugin-load-add该
--early-plugin-load选项用于加载在初始化内置插件和存储引擎之前必须可用的插件。
每个插件加载选项的值是以分号分隔的plugin_library和
值列表。每个都是包含插件代码的库文件的名称，每个
都是要加载的插件的名称。如果一个插件库的命名没有任何前面的插件名称，服务器将加载库中的所有插件。使用前面的插件名称，服务器仅从库中加载指定的插件。服务器在系统变量
命名的目录中查找插件库文件
。name=plugin_libraryplugin_librarynameplugin_dir
插件加载选项不会在
mysql.plugin表中注册任何插件。对于随后的重新启动，服务器仅在
--plugin-load、
--plugin-load-add或
--early-plugin-load再次给出时再次加载插件。也就是说，该选项会产生一个一次性的插件安装操作，该操作持续存在于单个服务器调用中。
--plugin-load,
--plugin-load-add, 和
--early-plugin-loadenable plugins 即使在
--skip-grant-tables给定的情况下也能加载（这会导致服务器忽略该
mysql.plugin表）。
--plugin-load,
--plugin-load-add, 并且
--early-plugin-load还允许在启动时加载无法在运行时加载的插件。
该--plugin-load-add选项补充了该--plugin-load
选项：
每个实例
--plugin-load都会重置插件集以在启动时加载，而
--plugin-load-add将一个或多个插件添加到要加载的插件集中而不重置当前集。因此，如果--plugin-load
指定了多个实例，则仅适用最后一个。对于 的多个实例
--plugin-load-add，它们都适用。
参数格式与 for 相同
--plugin-load，但可以使用多个实例
--plugin-load-add来避免将一大组插件指定为单个长而笨拙的--plugin-load
参数。
--plugin-load-add可以在没有 的情况下给出
，但是
之前出现
--plugin-load的任何实例都没有效果，因为重置了要加载的插件集。
--plugin-load-add--plugin-load--plugin-load
例如，这些选项：
--plugin-load=x --plugin-load-add=y
等同于这些选项：
--plugin-load-add=x --plugin-load-add=y
并且也等同于此选项：
--plugin-load="x;y"
但是这些选项：
--plugin-load-add=y --plugin-load=x
相当于这个选项：
--plugin-load=x
使用 INSTALL PLUGIN 语句安装的插件
位于插件库文件中的插件可以在运行时使用该INSTALL PLUGIN
语句加载。该语句还在
mysql.plugin表中注册插件，使服务器在随后的重新启动时加载它。为此，
INSTALL PLUGIN需要表的
INSERT权限
mysql.plugin。
插件库文件基本名称取决于您的平台。通用后缀.so用于 Unix 和类 Unix 系统，.dll用于 Windows。
示例：该--plugin-load-add
选项在服务器启动时安装插件。要安装myplugin从名为 的插件库文件命名的插件，请somepluglib.so在文件中使用以下行
my.cnf：
[mysqld]
plugin-load-add=myplugin=somepluglib.so
在这种情况下，插件未在
mysql.plugin. 在没有该选项的情况下重新启动服务器--plugin-load-add会导致在启动时不加载插件。
或者，该INSTALL PLUGIN
语句使服务器在运行时从库文件加载插件代码：
INSTALL PLUGIN myplugin SONAME 'somepluglib.so';
INSTALL PLUGIN还会导致
“永久”插件注册：插件列在mysql.plugin表中以确保服务器在随后的重新启动时加载它。
许多插件可以在服务器启动时或运行时加载。但是，如果插件设计为必须在服务器启动期间加载和初始化，则尝试在运行时加载它INSTALL
PLUGIN会产生错误：
mysql> INSTALL PLUGIN myplugin SONAME 'somepluglib.so';
ERROR 1721 (HY000): Plugin 'myplugin' is marked as not dynamically
installable. You have to stop the server to install it.
在这种情况下，您必须使用
--plugin-load、
--plugin-load-add或
--early-plugin-load。
如果插件在表中同时使用 、 或 选项命名
--plugin-load（
--plugin-load-add作为
--early-plugin-load较早INSTALL
PLUGIN语句的结果）
mysql.plugin，则服务器启动但将这些消息写入错误日志：
[ERROR] Function 'plugin_name' already exists
[Warning] Couldn't load plugin named 'plugin_name'
with soname 'plugin_object_file'.
控制插件激活状态
如果服务器在启动时知道插件（例如，因为插件使用
--plugin-load-add选项命名或在mysql.plugin表中注册），则服务器默认加载并启用该插件。可以使用
启动选项控制此类插件的激活状态，其中是要影响的插件名称，例如
、或
。与其他选项一样，破折号和下划线在选项名称中可以互换。此外，激活状态值不区分大小写。例如，和
是等价的。
--plugin_name[=activation_state]plugin_nameinnodbcsvvalidate_password--my_plugin=ON--my-plugin=on
--plugin_name=OFF
告诉服务器禁用插件。这对于某些内置插件可能是不可能的，例如
mysql_native_password.
--plugin_name[=ON]
告诉服务器启用插件。（将选项指定为
没有值具有相同的效果。）如果插件无法初始化，则服务器将在禁用插件的情况下运行。
--plugin_name
--plugin_name=FORCE
告诉服务器启用插件，但如果插件初始化失败，则服务器不会启动。换句话说，此选项强制服务器在启用或根本不启用插件的情况下运行。
--plugin_name=FORCE_PLUS_PERMANENT
喜欢FORCE，但另外防止插件在运行时被卸载。如果用户尝试使用 执行此操作UNINSTALL PLUGIN，则会发生错误。
LOAD_OPTION插件激活状态在表格的列
中可见
INFORMATION_SCHEMA.PLUGINS。
假设CSV、
BLACKHOLE和ARCHIVE是内置的可插拔存储引擎，并且您希望服务器在启动时加载它们，但要满足以下条件：如果CSV初始化失败，则允许服务器运行，必须要求BLACKHOLE
初始化成功，并且应该禁用
ARCHIVE。为此，请在选项文件中使用这些行：
[mysqld]
csv=ON
blackhole=FORCE
archive=OFF选项格式
是
.
和
选项
格式是
.
--enable-plugin_name--plugin_name=ON--disable-plugin_name--skip-plugin_name--plugin_name=OFF
如果插件被禁用，无论是显式禁用
OFF还是隐式启用
ON但未能初始化，服务器操作的各个方面都需要更改插件。例如，如果插件实现了存储引擎，则存储引擎的现有表变得不可访问，并尝试为存储引擎创建新表导致表使用默认存储引擎，除非
NO_ENGINE_SUBSTITUTION启用 SQL 模式导致错误反而发生。
禁用插件可能需要调整其他选项。例如，如果您使用
--skip-innodb
disable启动服务器，则启动时
可能还需要省略InnoDB其他
选项。另外，因为是默认的存储引擎，除非你指定另一个可用的存储引擎，否则它无法启动
。您还必须设置
.
innodb_xxxInnoDB--default_storage_engine--default_tmp_storage_engine
卸载插件
在运行时，该UNINSTALL PLUGIN
语句禁用并卸载服务器已知的插件。该语句卸载插件并将其从
mysql.plugin系统表中删除（如果它已在系统表中注册）。因此，
UNINSTALL PLUGIN语句需要表的DELETE特权mysql.plugin。由于插件不再在表中注册，服务器在随后的重新启动期间不会加载插件。
UNINSTALL PLUGIN可以卸载插件，无论它是在运行时加载
INSTALL PLUGIN还是在启动时使用插件加载选项加载，但要满足以下条件：
它无法卸载服务器内置的插件。这些可以被识别为那些
在或
NULL的输出
中具有库名称的库。
INFORMATION_SCHEMA.PLUGINSSHOW PLUGINS
它无法卸载服务器以 启动的
插件，这会阻止在运行时卸载插件。这些可以从表的列中识别出来
。
--plugin_name=FORCE_PLUS_PERMANENTLOAD_OPTIONINFORMATION_SCHEMA.PLUGINS
要卸载当前在服务器启动时使用插件加载选项加载的插件，请使用此过程。
从my.cnf文件中删除与插件相关的任何选项和系统变量。如果任何插件系统变量被保存到
mysqld-auto.cnf文件中，请使用
for each one 将其删除。
RESET PERSIST
var_name
重新启动服务器。
插件通常在启动时或在运行时使用插件加载选项安装INSTALL
PLUGIN，但不能同时使用。但是，从my.cnf
文件中删除插件的选项可能不足以卸载它，如果在某些时候
INSTALL PLUGIN也被使用过的话。如果插件仍然出现在
INFORMATION_SCHEMA.PLUGINS或
的输出中SHOW PLUGINS，请使用
UNINSTALL PLUGIN将其从mysql.plugin表中删除。然后再次重启服务器。
插件和可加载函数
插件在安装时也可能会自动安装相关的可加载功能。如果是这样，插件在卸载时也会自动卸载这些功能。
© Mysql 中文网
