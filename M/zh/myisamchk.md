# 4.6.4 myisamchk — MyISAM 表维护实用程序_MySQL 8.0 参考手册

4.6.4 myisamchk — MyISAM 表维护实用程序_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.4.1 myisamchk 常规选项
4.6.4.2 myisamchk 检查选项
4.6.4.3 myisamchk 修复选项
4.6.4.4 其他 myisamchk 选项
4.6.4.5 用myisamchk获取表信息
4.6.4.6 myisamchk 内存使用
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.4 myisamchk — MyISAM 表维护实用程序
4.6.4 myisamchk — MyISAM 表维护实用程序
4.6.4.1 myisamchk 常规选项4.6.4.2 myisamchk 检查选项4.6.4.3 myisamchk 修复选项4.6.4.4 其他 myisamchk 选项4.6.4.5 用myisamchk获取表信息4.6.4.6 myisamchk 内存使用
myisamchk实用程序获取有关数据库表的信息或检查、修复或优化它们
。myisamchk使用
MyISAM表（具有
用于存储数据和索引的文件的表）
.MYD。.MYI
您还可以使用CHECK TABLE
andREPAIR TABLE语句来检查和修复MyISAM表。请参阅
第 13.7.3.2 节，“CHECK TABLE 语句”和
第 13.7.3.5 节，“REPAIR TABLE 语句”。
不支持对分区表
使用myisamchk 。
警告
最好在执行表修复操作之前对表进行备份；在某些情况下，该操作可能会导致数据丢失。可能的原因包括但不限于文件系统错误。
像这样调用myisamchk：
myisamchk [options] tbl_name ...options指定您希望
myisamchk执行
的操作。它们在以下部分中描述。您还可以通过调用myisamchk --help获取选项列表。
没有选项，myisamchk只是检查你的表作为默认操作。要获得更多信息或告诉myisamchk采取纠正措施，请按照以下讨论中所述指定选项。
tbl_name是要检查或修复的数据库表。如果
在数据库目录以外的地方
运行myisamchk ，则必须指定数据库目录的路径，因为myisamchk不知道数据库位于何处。事实上，myisamchk实际上并不关心您正在处理的文件是否位于数据库目录中。您可以将对应于数据库表的文件复制到其他某个位置，并在那里对它们执行恢复操作。
如果愿意，您可以在myisamchk命令行
上命名多个表。您也可以通过命名其索引文件（具有.MYI
后缀的文件）来指定表。这使您能够使用模式指定目录中的所有表*.MYI。例如，如果您在数据库目录中，您可以
MyISAM像这样检查该目录中的所有表：
myisamchk *.MYI
如果您不在数据库目录中，则可以通过指定目录路径来检查那里的所有表：
myisamchk /path/to/database_dir/*.MYI
您甚至可以通过指定带有 MySQL 数据目录路径的通配符来检查所有数据库中的所有表：
myisamchk /path/to/datadir/*/*.MYI
快速检查所有
MyISAM表的推荐方法是：
myisamchk --silent --fast /path/to/datadir/*/*.MYI
如果要检查所有MyISAM表并修复任何损坏的表，可以使用以下命令：
myisamchk --silent --force --fast --update-state \
--key_buffer_size=64M --myisam_sort_buffer_size=64M \
--read_buffer_size=1M --write_buffer_size=1M \
/path/to/datadir/*/*.MYI
此命令假定您有超过 64MB 的可用空间。有关使用
myisamchk进行内存分配的更多信息，请参阅
第 4.6.4.6 节，“myisamchk 内存使用”。
有关使用
myisamchk的其他信息，请参阅
第 7.6 节，“MyISAM 表维护和崩溃恢复”。
重要的
您必须确保在运行
myisamchk时没有其他程序正在使用这些表。最有效的方法是在运行myisamchk时关闭 MySQL 服务器，或者锁定所有正在使用
myisamchk的表。
否则，当您运行myisamchk时，它可能会显示以下错误消息：
warning: clients are using or haven't closed the table properly
这意味着您正在尝试检查一个已被另一个程序（例如
mysqld服务器）更新的表，该程序尚未关闭文件或在没有正确关闭文件的情况下已经死亡，这有时会导致损坏一张或多
MyISAM张桌子。
如果mysqld正在运行，您必须使用 强制它刷新仍在内存中缓冲的所有表修改FLUSH TABLES。然后，您应该确保在运行myisamchk时没有人在使用这些表
但是，避免此问题的最简单方法是使用
CHECK TABLE而不是
myisamchk来检查表。请参阅
第 13.7.3.2 节，“CHECK TABLE 语句”。
myisamchk支持以下选项，可以在命令行或
[myisamchk]选项文件组中指定。有关 MySQL 程序使用的选项文件的信息，请参阅
第 4.2.2.2 节，“使用选项文件”。
表 4.19 myisamchk 选项
选项名称
描述
- 分析
分析键值的分布
--备份
将 .MYD 文件备份为 file_name-time.BAK
--块搜索
查找给定偏移量处的块所属的记录
- 查看
检查表格是否有错误
--check-only-changed
仅检查自上次检查以来更改过的表
--正确校验和
更正表的校验和信息
--数据文件长度
数据文件的最大长度（当数据文件已满重新创建时）
--调试
写调试日志
--decode_bits
解码位
--defaults-extra-file
除了通常的选项文件外，还读取命名的选项文件
--defaults-文件
只读命名选项文件
--defaults-group-suffix
选项组后缀值
- 描述
打印一些关于表的描述信息
--扩展检查
进行非常彻底的表检查或修复，尝试从数据文件中恢复每一行
- 快速地
只检查没有正确关闭的表
- 力量
如果 myisamchk 在表中发现任何错误，则自动执行修复操作
- 力量
覆盖旧的临时文件。与 -r 或 -o 选项一起使用
--ft_max_word_len
FULLTEXT 索引的最大字长
--ft_min_word_len
FULLTEXT 索引的最小字长
--ft_stopword_file
使用此文件中的停用词而不是内置列表
- 帮助
显示帮助信息并退出
- 帮助
显示帮助信息并退出
- 信息
打印有关被检查表的信息统计信息
--key_buffer_size
用于 MyISAM 表的索引块的缓冲区大小
--keys-used
指示要更新哪些索引的位值
--最大记录长度
如果 myisamchk 不能分配内存来保存它们，则跳过大于给定长度的行
--medium-check
执行比 --extend-check 操作更快的检查
--myisam_block_size
用于 MyISAM 索引页的块大小
--myisam_sort_buffer_size
在执行 REPAIR 或使用 CREATE INDEX 或 ALTER TABLE 创建索引时对索引进行排序时分配的缓冲区
--no-defaults
不读取选项文件
--并行恢复
使用与 -r 和 -n 相同的技术，但使用不同的线程并行创建所有密钥（测试版）
--print-defaults
打印默认选项
- 快的
通过不修改数据文件实现更快的修复
--read_buffer_size
每个执行顺序扫描的线程都会为其扫描的每个表分配一个此大小的缓冲区
- 只读
不要将表标记为已选中
- 恢复
进行修复，几乎可以解决任何问题，但不唯一的唯一键除外
--安全恢复
使用旧的恢复方法进行修复，该方法按顺序读取所有行并根据找到的行更新所有索引树
--设置自动增量
强制新记录的 AUTO_INCREMENT 编号从给定值开始
--set-整理
指定用于对表索引进行排序的排序规则
- 沉默的
静音模式
--sort_buffer_size
在执行 REPAIR 或使用 CREATE INDEX 或 ALTER TABLE 创建索引时对索引进行排序时分配的缓冲区
--排序索引
按高低顺序对索引树块进行排序
--sort_key_blocks
排序键块
--排序记录
根据特定索引对记录进行排序
--排序恢复
强制 myisamchk 使用排序来解析键，即使临时文件会非常大
--stats_method
指定 MyISAM 索引统计信息收集代码应如何处理 NULL
--tmpdir
用于存放临时文件的目录
--解包
解压一个用 myisampack 打包的表
--更新状态
在 .MYI 文件中存储信息以指示表何时被检查以及表是否崩溃
--冗长
详细模式
- 版本
显示版本信息并退出
--write_buffer_size
写入缓冲区大小
© Mysql 中文网
