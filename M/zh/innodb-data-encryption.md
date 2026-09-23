# 15.13 InnoDB静态数据加密_MySQL 8.0 参考手册

15.13 InnoDB静态数据加密_MySQL 8.0 参考手册
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
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  /
15.13 InnoDB静态数据加密
15.13 InnoDB静态数据加密
InnoDB支持
file-per-table 表
空间、通用
表空间、mysql系统表空间、重做日志和撤消日志的静态数据加密。
从 MySQL 8.0.16 开始，还支持为模式和通用表空间设置加密默认值，这允许 DBA 控制在这些模式和表空间中创建的表是否被加密。
InnoDB静态数据加密特性和功能在本节的以下主题下进行了描述。
关于静态数据加密加密先决条件为模式和通用表空间定义加密默认值File-Per-Table 表空间加密通用表空间加密双写文件加密mysql系统表空间加密重做日志加密撤消日志加密主密钥轮换加密和恢复导出加密表空间加密和复制识别加密的表空间和模式监控加密进度加密使用注意事项加密限制
关于静态数据加密
InnoDB使用两层加密密钥架构，由主加密密钥和表空间密钥组成。当表空间被加密时，表空间密钥被加密并存储在表空间头中。当应用程序或经过身份验证的用户想要访问加密的表空间数据时，
InnoDB使用主加密密钥来解密表空间密钥。表空间密钥的解密版本永远不会改变，但可以根据需要更改主加密密钥。此操作称为主密钥轮换。
静态数据加密功能依赖于用于主加密密钥管理的密钥环组件或插件。
所有 MySQL 版本都提供一个
component_keyring_file组件和
keyring_file插件，每个组件和插件都将密钥环数据存储在服务器主机的本地文件中。
MySQL 企业版提供额外的密钥环组件和插件：
component_keyring_encrypted_file：将密钥环数据存储在服务器主机本地的加密、受密码保护的文件中。
keyring_encrypted_file：将密钥环数据存储在服务器主机本地的加密、受密码保护的文件中。
keyring_okv：用于与 KMIP 兼容的后端密钥环存储产品一起使用的 KMIP 1.1 插件。受支持的 KMIP 兼容产品包括集中式密钥管理解决方案，例如 Oracle Key Vault、Gemalto KeySecure、Thales Vormetric 密钥管理服务器和 Fornetix Key Orchestration。
keyring_aws：与作为密钥生成后端的 Amazon Web Services 密钥管理服务 (AWS KMS) 通信，并使用本地文件进行密钥存储。
keyring_hashicorp：与 HashiCorp Vault 通信以进行后端存储。
警告
对于加密密钥管理，
component_keyring_file和
component_keyring_encrypted_file组件以及 和keyring_file和
keyring_encrypted_file插件并非旨在作为法规遵从性解决方案。PCI、FIPS 等安全标准要求使用密钥管理系统来保护、管理和保护密钥库或硬件安全模块 (HSM) 中的加密密钥。
安全且强大的加密密钥管理解决方案对于安全性和符合各种安全标准至关重要。当静态数据加密功能使用集中式密钥管理解决方案时，该功能称为“ MySQL 企业透明数据加密 (TDE) ”。
静态数据加密功能支持高级加密标准 (AES) 基于块的加密算法。它使用电子密码本 (ECB) 块加密模式进行表空间密钥加密，使用密码块链接 (CBC) 块加密模式进行数据加密。
有关静态数据加密功能的常见问题，请参阅第 A.17 节，“MySQL 8.0 常见问题解答：InnoDB 静态数据加密”。
加密先决条件
必须在启动时安装和配置密钥环组件或插件。早期加载确保组件或插件在
InnoDB存储引擎初始化之前可用。有关密钥环安装和配置说明，请参阅
第 6.4.4 节，“MySQL 密钥环”。这些说明显示了如何确保所选组件或插件处于活动状态。
一次只能启用一个密钥环组件或插件。不支持启用多个密钥环组件或插件，结果可能与预期不同。
重要的
一旦在 MySQL 实例中创建了加密表空间，在创建加密表空间时加载的密钥环组件或插件必须在启动时继续加载。不这样做会导致在启动服务器时和InnoDB恢复期间出错。
加密生产数据时，确保采取措施防止丢失主加密密钥。如果主加密密钥丢失，存储在加密表空间文件中的数据将无法恢复。如果您使用
component_keyring_fileor
component_keyring_encrypted_file组件或keyring_fileor
keyring_encrypted_file插件，请在创建第一个加密表空间之后、主密钥轮换之前和主密钥轮换之后立即创建密钥环数据文件的备份。对于每个组件，其配置文件指示数据文件位置。keyring_file_data
配置选项定义keyring_file插件的
密钥环数据文件位置。这
keyring_encrypted_file_data
配置选项定义keyring_encrypted_file插件的密钥环数据文件位置。如果您使用keyring_okv或
keyring_aws插件，请确保您已执行必要的配置。有关说明，请参阅
第 6.4.4 节，“MySQL 密钥环”。
为模式和通用表空间定义加密默认值
从 MySQL 8.0.16 开始，
default_table_encryption系统变量定义模式和通用表空间的默认加密设置。CREATE
TABLESPACE和
CREATE
SCHEMA操作在
未明确指定子句
default_table_encryption时应用设置。ENCRYPTION
ALTER
SCHEMA并且ALTER
TABLESPACE操作不应用该
default_table_encryption设置。ENCRYPTION必须明确指定
一个子句来更改现有模式或通用表空间的加密。default_table_encryption
可以为单个客户端连接或全局使用
语法SET
设置变量。例如，以下语句全局启用默认架构和表空间加密：
mysql> SET GLOBAL default_table_encryption=ON;
模式的默认加密设置也可以DEFAULT ENCRYPTION在创建或更改模式时使用子句定义，如本例所示：
mysql> CREATE SCHEMA test DEFAULT ENCRYPTION = 'Y';
如果DEFAULT ENCRYPTION在创建模式时未指定该子句，
default_table_encryption则应用该设置。DEFAULT ENCRYPTION必须指定该子句以更改现有模式的默认加密。否则，模式会保留其当前的加密设置。
默认情况下，表会继承创建它的架构或通用表空间的加密设置。例如，在启用加密的架构中创建的表默认情况下是加密的。此行为使 DBA 能够通过定义和实施架构和一般表空间加密默认值来控制表加密的使用。
加密默认值是通过启用
table_encryption_privilege_check
系统变量来强制执行的。启用后，当
table_encryption_privilege_check
使用不同于设置的加密设置创建或更改模式或通用表空间
default_table_encryption时，或者使用不同于默认模式加密的加密设置创建或更改表时，将进行权限检查。禁用（默认）时
table_encryption_privilege_check
，不会进行权限检查，并且允许前面提到的操作进行警告。
启用TABLE_ENCRYPTION_ADMIN
时需要权限来覆盖默认加密设置
。table_encryption_privilege_checkDBA 可以授予此权限，使用户能够
default_table_encryption在创建或更改模式或通用表空间时偏离设置，或者在创建或更改表时偏离默认模式加密。此权限不允许在创建或更改表时偏离通用表空间的加密。表必须具有与其所在的通用表空间相同的加密设置。
File-Per-Table 表空间加密
从 MySQL 8.0.16 开始，file-per-table 表空间继承了创建表的模式的默认加密，除非在语句ENCRYPTION中明确指定了一个子句CREATE TABLE
。在 MySQL 8.0.16 之前，
ENCRYPTION必须指定该子句才能启用加密。
mysql> CREATE TABLE t1 (c1 INT) ENCRYPTION = 'Y';
要更改现有的 file-per-table 表空间的加密，ENCRYPTION必须指定一个子句。
mysql> ALTER TABLE t1 ENCRYPTION = 'Y';
从 MySQL 8.0.16 开始，如果
table_encryption_privilege_check
启用了该变量，则指定ENCRYPTION
一个设置不同于默认模式加密的子句需要
TABLE_ENCRYPTION_ADMIN权限。请参阅为架构和通用表空间定义加密默认值。
通用表空间加密
从 MySQL 8.0.16 开始，该
default_table_encryption变量确定新创建的通用表空间的加密，除非在语句ENCRYPTION中明确指定子句CREATE TABLESPACE
。在 MySQL 8.0.16 之前，ENCRYPTION
必须指定一个子句才能启用加密。
mysql> CREATE TABLESPACE `ts1` ADD DATAFILE 'ts1.ibd' ENCRYPTION = 'Y' Engine=InnoDB;
要更改现有通用表空间的加密，
ENCRYPTION必须指定一个子句。
mysql> ALTER TABLESPACE ts1 ENCRYPTION = 'Y';
从 MySQL 8.0.16 开始，如果
table_encryption_privilege_check
启用了变量，则指定具有ENCRYPTION
不同于设置的设置的子句
default_table_encryption需要TABLE_ENCRYPTION_ADMIN
权限。请参阅
为架构和通用表空间定义加密默认值。
双写文件加密
从 MySQL 8.0.23 开始，对双写文件的加密支持可用。InnoDB自动加密属于加密表空间的双写文件页。无需任何操作。双写文件页面使用关联表空间的加密密钥进行加密。写入表空间数据文件的相同加密页面也会写入双写文件。属于未加密表空间的双写文件页面保持未加密状态。
在恢复期间，加密的双写文件页面未加密并检查是否损坏。
mysql系统表空间加密
从 MySQL 8.0.16 开始，对系统表空间的加密支持mysql可用。
系统mysql表空间包含
mysql系统数据库和 MySQL 数据字典表。它默认是未加密的。要为系统表空间启用加密，请
在语句
中mysql指定表空间名称和ENCRYPTION选项
。ALTER TABLESPACEmysql> ALTER TABLESPACE mysql ENCRYPTION = 'Y';
要禁用mysql系统表空间的加密，请ENCRYPTION = 'N'使用
ALTER TABLESPACE语句进行设置。
mysql> ALTER TABLESPACE mysql ENCRYPTION = 'N';mysql
为系统表空间
启用或禁用加密需要CREATE
TABLESPACE对实例中所有表的特权 ( CREATE TABLESPACE on *.*).
重做日志加密
innodb_redo_log_encrypt
使用配置选项
启用重做日志数据加密
。默认情况下禁用重做日志加密。
与表空间数据一样，重做日志数据加密发生在重做日志数据写入磁盘时，解密发生在重做日志数据从磁盘读取时。一旦重做日志数据被读入内存，它就是未加密的形式。重做日志数据使用表空间加密密钥进行加密和解密。
启用时innodb_redo_log_encrypt，磁盘上存在的未加密重做日志页保持未加密状态，新重做日志页以加密形式写入磁盘。同样，
innodb_redo_log_encrypt禁用时，磁盘上存在的加密重做日志页保持加密状态，新的重做日志页以未加密的形式写入磁盘。
警告
MySQL 8.0.30 中引入的回归可防止在启用后禁用重做日志加密。（错误#108052，错误#34456802）。
从 MySQL 8.0.30 开始，重做日志加密元数据（包括表空间加密密钥）存储在具有最新检查点 LSN 的重做日志文件的标头中。在 MySQL 8.0.30 之前，重做日志加密元数据（包括表空间加密密钥）存储在第一个重做日志文件 ( ib_logfile0) 的标头中。如果删除带有加密元数据的重做日志文件，重做日志加密将被禁用。
一旦启用重做日志加密，在没有密钥环组件或插件或没有加密密钥的情况下正常重启是不可能的，因为InnoDB必须能够在启动期间扫描重做页面，如果重做日志页面被加密，这是不可能的。如果没有密钥环组件或插件或加密密钥，则只能在没有重做日志 ( SRV_FORCE_NO_LOG_REDO) 的情况下强制启动。请参阅
第 15.21.3 节，“强制 InnoDB 恢复”。
撤消日志加密
innodb_undo_log_encrypt
使用配置选项
启用撤消日志数据加密
。撤消日志加密适用于驻留在撤消表空间中的撤消日志。请参阅第 15.6.3.4 节，“撤消表空间”。默认情况下禁用撤消日志数据加密。
与表空间数据一样，undo log 数据加密发生在undo log 数据写入磁盘时，解密发生在undo log 数据从磁盘读取时。一旦撤消日志数据被读入内存，它就是未加密的形式。撤消日志数据使用表空间加密密钥进行加密和解密。
启用时innodb_undo_log_encrypt，磁盘上存在的未加密撤消日志页保持未加密状态，新的撤消日志页以加密形式写入磁盘。同样，
innodb_undo_log_encrypt禁用时，磁盘上存在的加密撤消日志页保持加密状态，新的撤消日志页以未加密的形式写入磁盘。
撤消日志加密元数据（包括表空间加密密钥）存储在撤消日志文件的标头中。
笔记
当撤消日志加密被禁用时，服务器继续需要用于加密撤消日志数据的密钥环组件或插件，直到包含加密撤消日志数据的撤消表空间被截断。（仅当撤消表空间被截断时，加密标头才会从撤消表空间中删除。）有关截断撤消表空间的信息，请参阅截断撤消表空间。
主密钥轮换
应定期轮换主加密密钥，并在您怀疑密钥已被泄露时进行轮换。
主密钥轮换是一个原子的、实例级的操作。每次轮换主加密密钥时，MySQL 实例中的所有表空间密钥都会重新加密并保存回各自的表空间标头。作为原子操作，一旦启动旋转操作，所有表空间密钥的重新加密必须成功。如果主密钥轮换因服务器故障而中断，InnoDB则在服务器重新启动时向前滚动操作。有关详细信息，请参阅
加密和恢复。
旋转主加密密钥只会更改主加密密钥并重新加密表空间密钥。它不会解密或重新加密关联的表空间数据。
轮换主加密密钥需要
ENCRYPTION_KEY_ADMIN特权（或已弃用的SUPER特权）。
要轮换主加密密钥，请运行：
mysql> ALTER INSTANCE ROTATE INNODB MASTER KEY;
ALTER INSTANCE ROTATE INNODB MASTER
KEY支持并发 DML。但是，它不能与表空间加密操作并发运行，并采用锁定来防止并发执行可能引起的冲突。如果一个ALTER INSTANCE ROTATE INNODB
MASTER KEY操作正在运行，它必须在表空间加密操作可以继续之前完成，反之亦然。
加密和恢复
如果在加密操作期间发生服务器故障，则该操作会在服务器重新启动时前滚。对于一般表空间，加密操作在后台线程中从最后处理的页面恢复。
如果在主密钥轮换期间发生服务器故障，
InnoDB则在服务器重新启动时继续操作。
密钥环组件或插件必须在存储引擎初始化之前加载，以便在InnoDB初始化和恢复活动访问表空间数据之前，可以从表空间标头中检索解密表空间数据页所需的信息。（请参阅
加密先决条件。）
当InnoDB初始化和恢复开始时，主密钥轮换操作恢复。由于服务器故障，一些表空间密钥可能已经使用新的主加密密钥进行了加密。InnoDB从每个表空间头中读取加密数据，如果数据表明表空间密钥是使用旧主加密密钥加密的，InnoDB则从密钥环中检索旧密钥并使用它来解密表空间密钥。
InnoDB然后使用新的主加密密钥重新加密表空间密钥，并将重新加密的表空间密钥保存回表空间头。
导出加密表空间
表空间导出仅支持 file-per-table 表空间。
导出加密表空间时，
InnoDB生成用于加密表空间密钥的传输密钥。加密的表空间密钥和传输密钥存储在一个
tablespace_name.cfp
文件中。执行导入操作需要此文件和加密的表空间文件。导入时，
InnoDB使用传输密钥解密
tablespace_name.cfp
文件中的表空间密钥。有关相关信息，请参阅
第 15.6.1.3 节，“导入 InnoDB 表”。
加密和复制
该ALTER INSTANCE ROTATE INNODB MASTER
KEY语句仅在源和副本运行支持表空间加密的 MySQL 版本的复制环境中受支持。
成功ALTER INSTANCE ROTATE INNODB
MASTER KEY的语句被写入二进制日志以在副本上进行复制。
如果一条ALTER INSTANCE ROTATE INNODB MASTER
KEY语句失败，它不会记录到二进制日志中，也不会复制到副本上。
ALTER INSTANCE ROTATE
INNODB MASTER KEY如果密钥环组件或插件安装在源上而不是副本上，则操作
复制失败。
如果keyring_fileor
keyring_encrypted_file插件同时安装在源和副本上，但副本没有密钥环数据文件，则复制的ALTER
INSTANCE ROTATE INNODB MASTER KEY语句会在副本上创建密钥环数据文件，假设密钥环文件数据未缓存在内存中。ALTER
INSTANCE ROTATE INNODB MASTER KEY使用缓存在内存中的密钥环文件数据（如果可用）。
识别加密的表空间和模式
该
INFORMATION_SCHEMA.INNODB_TABLESPACES
表在 MySQL 8.0.13 中引入，包括一个
ENCRYPTION可用于识别加密表空间的列。
mysql> SELECT SPACE, NAME, SPACE_TYPE, ENCRYPTION FROM INFORMATION_SCHEMA.INNODB_TABLESPACES
WHERE ENCRYPTION='Y'\G
*************************** 1. row ***************************
SPACE: 4294967294
NAME: mysql
SPACE_TYPE: General
ENCRYPTION: Y
*************************** 2. row ***************************
SPACE: 2
NAME: test/t1
SPACE_TYPE: Single
ENCRYPTION: Y
*************************** 3. row ***************************
SPACE: 3
NAME: ts1
SPACE_TYPE: General
ENCRYPTION: Y
当在or
语句ENCRYPTION中指定选项
时，它被记录在 的列中
。可以查询此列以识别驻留在加密的 file-per-table 表空间中的表。
CREATE TABLEALTER TABLECREATE_OPTIONSINFORMATION_SCHEMA.TABLESmysql> SELECT TABLE_SCHEMA, TABLE_NAME, CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES
WHERE CREATE_OPTIONS LIKE '%ENCRYPTION%';
+--------------+------------+----------------+
| TABLE_SCHEMA | TABLE_NAME | CREATE_OPTIONS |
+--------------+------------+----------------+
| test         | t1         | ENCRYPTION="Y" |
+--------------+------------+----------------+
查询
INFORMATION_SCHEMA.INNODB_TABLESPACES
以检索有关与特定模式和表关联的表空间的信息。
mysql> SELECT SPACE, NAME, SPACE_TYPE FROM INFORMATION_SCHEMA.INNODB_TABLESPACES WHERE NAME='test/t1';
+-------+---------+------------+
| SPACE | NAME    | SPACE_TYPE |
+-------+---------+------------+
|     3 | test/t1 | Single     |
+-------+---------+------------+
您可以通过查询
INFORMATION_SCHEMA.SCHEMATA表来识别启用加密的模式。
mysql> SELECT SCHEMA_NAME, DEFAULT_ENCRYPTION FROM INFORMATION_SCHEMA.SCHEMATA
WHERE DEFAULT_ENCRYPTION='YES';
+-------------+--------------------+
| SCHEMA_NAME | DEFAULT_ENCRYPTION |
+-------------+--------------------+
| test        | YES                |
+-------------+--------------------+
SHOW CREATE
SCHEMA也显示了DEFAULT
ENCRYPTION条款。
监控加密进度
您可以使用Performance Schema
监视一般表空间和mysql
系统表空间加密进度
。
一般表空间加密操作的stage/innodb/alter tablespace (encryption)
阶段事件工具报告WORK_ESTIMATED
和WORK_COMPLETED信息。
以下示例演示如何启用
stage/innodb/alter tablespace (encryption)
阶段事件工具和相关消费者表来监控一般表空间或mysql系统表空间加密进度。有关性能模式阶段事件工具和相关消费者的信息，请参阅
第 27.12.5 节，“性能模式阶段事件表”。
启用stage/innodb/alter tablespace
(encryption)仪器：
mysql> USE performance_schema;
mysql> UPDATE setup_instruments SET ENABLED = 'YES'
WHERE NAME LIKE 'stage/innodb/alter tablespace (encryption)';
启用阶段事件消费者表，其中包括
events_stages_current、
events_stages_history和
events_stages_history_long。
mysql> UPDATE setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%stages%';
运行表空间加密操作。在此示例中，名为的通用表空间ts1已加密。
mysql> ALTER TABLESPACE ts1 ENCRYPTION = 'Y';
通过查询 Performance Schema
events_stages_current表来检查加密操作的进度。
WORK_ESTIMATED报告表空间中的总页数。WORK_COMPLETED
报告处理的页数。
mysql> SELECT EVENT_NAME, WORK_ESTIMATED, WORK_COMPLETED FROM events_stages_current;
+--------------------------------------------+----------------+----------------+
| EVENT_NAME                                 | WORK_COMPLETED | WORK_ESTIMATED |
+--------------------------------------------+----------------+----------------+
| stage/innodb/alter tablespace (encryption) |           1056 |           1407 |
+--------------------------------------------+----------------+----------------+
如果加密操作已完成，该events_stages_current表将返回一个空集。在这种情况下，您可以检查
events_stages_history表以查看已完成操作的事件数据。例如：
mysql> SELECT EVENT_NAME, WORK_COMPLETED, WORK_ESTIMATED FROM events_stages_history;
+--------------------------------------------+----------------+----------------+
| EVENT_NAME                                 | WORK_COMPLETED | WORK_ESTIMATED |
+--------------------------------------------+----------------+----------------+
| stage/innodb/alter tablespace (encryption) |           1407 |           1407 |
+--------------------------------------------+----------------+----------------+
加密使用注意事项
ENCRYPTION在使用该选项
更改现有的 file-per-table 表空间时进行适当的计划。驻留在 file-per-table 表空间中的表使用该COPY算法重建。在更改通用表空间或系统表空间的属性时使用该
INPLACE算法
。该算法允许对驻留在通用表空间中的表进行并发 DML。并发 DDL 被阻止。
ENCRYPTIONmysqlINPLACE
当对通用表空间或mysql
系统表空间进行加密时，驻留在该表空间中的所有表都将被加密。同样，在加密表空间中创建的表也是加密的。
如果服务器在正常操作期间退出或停止，建议使用之前配置的相同加密设置重新启动服务器。
第一个主加密密钥在第一个新的或现有的表空间被加密时生成。
主密钥轮换会重新加密表空间密钥，但不会更改表空间密钥本身。要更改表空间键，您必须禁用并重新启用加密。对于 file-per-table 表空间，重新加密表空间是
ALGORITHM=COPY重建表的操作。对于普通表空间和
mysql系统表空间，是一个
ALGORITHM=INPLACE操作，不需要重建驻留在表空间中的表。
COMPRESSION
如果使用和
选项
创建表
ENCRYPTION
，则在加密表空间数据之前执行压缩。
如果密钥环数据文件（由
keyring_file_data或
命名的文件keyring_encrypted_file_data）为空或丢失，则第一次执行
ALTER INSTANCE ROTATE INNODB MASTER
KEY创建主加密密钥。
卸载component_keyring_file或
component_keyring_encrypted_file组件不会删除现有的密钥环数据文件。卸载keyring_file或
keyring_encrypted_file插件不会删除现有的密钥环数据文件。
建议您不要将密钥环数据文件放在与表空间数据文件相同的目录下。
在运行时或重新启动服务器时修改
keyring_file_data或
keyring_encrypted_file_data
设置可能会导致以前加密的表空间变得不可访问，从而导致数据丢失。
InnoDB
FULLTEXT添加索引时隐式创建
的索引表支持加密FULLTEXT。有关相关信息，请参阅
InnoDB 全文索引表。
加密限制
高级加密标准 (AES) 是唯一受支持的加密算法。InnoDB表空间加密使用电子密码本 (ECB) 块加密模式进行表空间密钥加密，使用密码块链接 (CBC) 块加密模式进行数据加密。填充不与 CBC 块加密模式一起使用。相反，
InnoDB确保要加密的文本是块大小的倍数。
仅file-per-table 表
空间、
通用
表空间和mysql系统表空间
支持加密
。MySQL 8.0.13 中引入了对通用表空间的加密支持。从 MySQL 8.0.16 开始，对系统表空间的加密支持
mysql可用。InnoDB
其他表空间类型（包括系统表空间）不支持加密。
您不能将表从加密的
file-per-table 表
空间、
通用
表空间或mysql系统表空间移动或复制到不支持加密的表空间类型。
您不能将表从加密表空间移动或复制到未加密表空间。但是，允许将表从未加密的表空间移动到加密的表空间。例如，您可以将表从未加密的
file-per-table或
通用
表空间移动或复制到加密的通用表空间。
默认情况下，表空间加密仅适用于表空间中的数据。重做日志和撤销日志数据可以通过启用
innodb_redo_log_encrypt和
加密innodb_undo_log_encrypt。请参阅
重做日志加密和
撤消日志加密。有关二进制日志文件和中继日志文件加密的信息，请参阅
第 17.3.2 节，“加密二进制日志文件和中继日志文件”。
不允许更改驻留在或以前驻留在加密表空间中的表的存储引擎。
© Mysql 中文网
