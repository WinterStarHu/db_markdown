# 8.9.5 优化器成本模型_MySQL 8.0 参考手册

8.9.5 优化器成本模型_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.9.1 控制查询计划评估1
8.9.2 可切换优化1
8.9.3 优化器提示1
8.9.4 索引提示1
8.9.5 优化器成本模型1
8.9.6 优化器统计1
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.9 控制查询优化器  /
8.9.5 优化器成本模型
8.9.5 优化器成本模型
为了生成执行计划，优化器使用了一个成本模型，该模型基于对查询执行期间发生的各种操作的成本的估计。优化器有一组内置的默认“成本常量”，可用于做出有关执行计划的决策。
优化器还有一个成本估算数据库，可在执行计划构建期间使用。这些估计存储在系统数据库的server_cost表
engine_cost中，
mysql可以随时配置。这些表的目的是可以轻松调整优化器在尝试得出查询执行计划时使用的成本估算。
成本模型一般操作成本模型数据库更改成本模型数据库
成本模型一般操作
可配置优化器成本模型的工作原理如下：
服务器在启动时将成本模型表读入内存，并在运行时使用内存中的值。表中指定的任何非NULL成本估算都优先于相应的编译默认成本常量。任何NULL
估计都指示优化器使用编译的默认值。
在运行时，服务器可能会重新读取成本表。当动态加载存储引擎或FLUSH OPTIMIZER_COSTS
执行语句时会发生这种情况。
成本表使服务器管理员能够通过更改表中的条目轻松调整成本估算。通过将条目的成本设置为 ，也可以轻松恢复为默认值NULL。优化器使用内存中的成本值，因此对表的更改应随后
FLUSH OPTIMIZER_COSTS生效。
客户端会话开始时的当前内存中成本估算将在整个会话期间应用，直至结束。特别是，如果服务器重新读取成本表，则任何更改的估计仅适用于随后启动的会话。现有会话不受影响。
成本表特定于给定的服务器实例。服务器不会将成本表更改复制到副本。
成本模型数据库
优化器成本模型数据库由mysql系统数据库中的两个表组成，其中包含查询执行期间发生的操作的成本估算信息：
server_cost：一般服务器操作的优化器成本估算
engine_cost：针对特定存储引擎特定操作的优化器成本估算
该server_cost表包含以下列：
cost_name
成本模型中使用的成本估算的名称。该名称不区分大小写。如果服务器在读取此表时无法识别成本名称，则会将警告写入错误日志。
cost_value
成本估算值。如果该值为非NULL，则服务器将其用作成本。否则，它使用默认估计值（编译值）。DBA 可以通过更新此列来更改成本估算。如果服务器在读取此表时发现成本值无效（非正），则会将警告写入错误日志。
要覆盖默认成本估算（对于指定 的条目NULL），请将成本设置为非NULL值。要恢复为默认值，请将值设置为NULL。然后执行FLUSH
OPTIMIZER_COSTS告诉服务器重新读取成本表。
last_update
最后一行更新的时间。
comment
与成本估算相关联的描述性注释。DBA 可以使用此列来提供有关成本估算行存储特定值的原因的信息。
default_value
成本估算的默认（编译）值。此列是一个只读的生成列，即使关联的成本估算发生更改，它也会保留其值。对于在运行时添加到表中的行，此列的值为NULL。
该server_cost表的主键是cost_name列，因此不可能为任何成本估算创建多个条目。
服务器识别表cost_name
的这些值server_cost：
disk_temptable_create_cost,
disk_temptable_row_cost
存储在基于磁盘的存储引擎（
InnoDB或MyISAM）中的内部创建的临时表的成本估算。增加这些值会增加使用内部临时表的成本估算，并使优化器更喜欢使用较少的查询计划。有关此类表的信息，请参阅
第 8.4.4 节，“MySQL 中的内部临时表使用”。
memory_temptable_create_cost与相应内存参数 ( ,
)
的默认值相比，这些磁盘参数的默认值memory_temptable_row_cost较大，反映了处理基于磁盘的表的成本较高。
key_compare_cost
比较记录键的成本。增加此值会导致比较许多键的查询计划变得更加昂贵。例如，
filesort与避免使用索引进行排序的查询计划相比，执行 a 的查询计划变得相对更昂贵。
memory_temptable_create_cost,
memory_temptable_row_cost
存储在MEMORY存储引擎中的内部创建的临时表的成本估算。增加这些值会增加使用内部临时表的成本估算，并使优化器更喜欢使用较少的查询计划。有关此类表的信息，请参阅
第 8.4.4 节，“MySQL 中的内部临时表使用”。
disk_temptable_create_cost与相应磁盘参数 ( ,
)
的默认值相比，这些内存参数的默认值disk_temptable_row_cost较小反映了处理基于内存的表的成本较低。
row_evaluate_cost
评估记录条件的成本。与检查较少行的查询计划相比，增加此值会导致检查许多行的查询计划变得更加昂贵。例如，与读取较少行的范围扫描相比，表扫描变得相对更昂贵。
该engine_cost表包含以下列：
engine_name
此成本估算适用的存储引擎的名称。该名称不区分大小写。如果值为
default，则它适用于所有没有自己的命名条目的存储引擎。如果服务器在读取此表时无法识别引擎名称，则会将警告写入错误日志。
device_type
此成本估算适用的设备类型。该列旨在为不同的存储设备类型指定不同的成本估算，例如硬盘驱动器与固态驱动器。目前，不使用此信息，0 是唯一允许的值。
cost_name
与server_cost表中相同。
cost_value
与server_cost表中相同。
last_update
与server_cost表中相同。
comment
与server_cost表中相同。
default_value
成本估算的默认（编译）值。此列是一个只读的生成列，即使关联的成本估算发生更改，它也会保留其值。对于在运行时添加到表中的行，此列的值为NULL，但如果该行cost_name与原始行之一具有相同的值
，则该列与该行具有default_value相同的值。
该engine_cost表的主键是一个包含 ( cost_name,
engine_name,
device_type) 列的元组，因此无法为这些列中的任意值组合创建多个条目。
服务器识别表cost_name
的这些值engine_cost：
io_block_read_cost
从磁盘读取索引或数据块的成本。与读取较少磁盘块的查询计划相比，增加此值会导致读取许多磁盘块的查询计划变得更加昂贵。例如，与读取较少块的范围扫描相比，表扫描变得相对更昂贵。
memory_block_read_cost
类似于io_block_read_cost，但表示从内存数据库缓冲区读取索引或数据块的成本。
如果io_block_read_cost和
memory_block_read_cost值不同，则执行计划可能会在同一查询的两次运行之间发生变化。假设内存访问的成本低于磁盘访问的成本。在这种情况下，在数据被读入缓冲池之前在服务器启动时，您可能会得到一个与查询运行后不同的计划，因为那时数据在内存中。
更改成本模型数据库
对于希望更改成本模型参数的默认值的 DBA，请尝试将值加倍或减半并衡量效果。
对io_block_read_cost和
memory_block_read_cost参数的更改最有可能产生有价值的结果。这些参数值使数据访问方法的成本模型能够考虑从不同来源读取信息的成本；也就是说，从磁盘读取信息与读取内存缓冲区中已有信息的成本。例如，在所有其他条件相同的情况下，设置
io_block_read_cost为大于的值
memory_block_read_cost会导致优化器更喜欢读取已保存在内存中的信息的查询计划，而不是必须从磁盘读取的计划。
此示例显示如何更改 的默认值
io_block_read_cost：
UPDATE mysql.engine_cost
SET cost_value = 2.0
WHERE cost_name = 'io_block_read_cost';
FLUSH OPTIMIZER_COSTS;
此示例显示如何
io_block_read_cost仅
更改InnoDB存储引擎的值：
INSERT INTO mysql.engine_cost
VALUES ('InnoDB', 0, 'io_block_read_cost', 3.0,
CURRENT_TIMESTAMP, 'Using a slower disk for InnoDB');
FLUSH OPTIMIZER_COSTS;
© Mysql 中文网
