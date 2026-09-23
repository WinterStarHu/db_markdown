# 7.6.3 如何修复 MyISAM 表_MySQL 8.0 参考手册

7.6.3 如何修复 MyISAM 表_MySQL 8.0 参考手册
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
7.5 时间点（增量）恢复
7.6 MyISAM表维护和崩溃恢复
7.6.1 使用 myisamchk 进行崩溃恢复1
7.6.2 如何检查 MyISAM 表的错误1
7.6.3 如何修复 MyISAM 表1
7.6.4 MyISAM表优化1
7.6.5 设置 MyISAM 表维护计划1
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
MySQL 8.0 参考手册  / 第 7 章备份与恢复  / 7.6 MyISAM表维护和崩溃恢复  /
7.6.3 如何修复 MyISAM 表
7.6.3 如何修复 MyISAM 表
本节中的讨论描述了如何
在表（扩展和
）
上使用myisamchk 。MyISAM.MYI.MYD
您还可以使用CHECK TABLE
andREPAIR TABLE语句来检查和修复MyISAM表。请参阅
第 13.7.3.2 节，“CHECK TABLE 语句”和
第 13.7.3.5 节，“REPAIR TABLE 语句”。
损坏表的症状包括意外中止的查询和可观察到的错误，例如：
找不到文件
（
tbl_name.MYI
错误代码：）nnn
文件意外结束
记录文件崩溃
nnn从表处理程序中
得到错误
要获取有关错误的更多信息，请运行
perror nnn，其中
nnn是错误编号。以下示例显示如何使用perror查找指示表问题的最常见错误编号的含义：
$> perror 126 127 132 134 135 136 141 144 145
MySQL error code 126 = Index file is crashed
MySQL error code 127 = Record-file is crashed
MySQL error code 132 = Old database file
MySQL error code 134 = Record was already deleted (or record file crashed)
MySQL error code 135 = No more room in record file
MySQL error code 136 = No more room in index file
MySQL error code 141 = Duplicate unique key or constraint on write or update
MySQL error code 144 = Table is crashed and last repair failed
MySQL error code 145 = Table was marked as crashed and should be repaired
请注意，错误 135（记录文件中没有更多空间）和错误 136（索引文件中没有更多空间）不是可以通过简单修复来修复的错误。在这种情况下，您必须使用
ALTER TABLE增加
MAX_ROWS和
AVG_ROW_LENGTH表选项值：
ALTER TABLE tbl_name MAX_ROWS=xxx AVG_ROW_LENGTH=yyy;
如果您不知道当前表选项值，请使用
SHOW CREATE TABLE。
对于其他错误，您必须修复您的表。
myisamchk通常可以检测并修复发生的大多数问题。
修复过程最多涉及三个阶段，如下所述。在开始之前，您应该将位置更改为数据库目录并检查表文件的权限。在 Unix 上，确保它们对于
运行mysqld的用户是可读的（对您也是如此，因为您需要访问正在检查的文件）。如果事实证明您需要修改文件，那么它们也必须是您可写的。
本节适用于表检查失败的情况（例如第 7.6.2 节“如何检查 MyISAM 表是否有错误”中描述的情况），或者您想使用myisamchk
提供的扩展功能。
用于表维护
的myisamchk选项在第 4.6.4 节“myisamchk — MyISAM 表维护实用程序”中进行了描述。
myisamchk也有一些变量，您可以设置这些变量来控制可能提高性能的内存分配。参见
第 4.6.4.6 节，“myisamchk 内存使用”。
如果要从命令行修复表，必须先停止mysqld服务器。请注意，当您在远程服务器上关闭 mysqladmin时， mysqld服务器在mysqladmin返回后仍然可用一段时间，直到所有语句处理停止并且所有索引更改都已刷新到磁盘。
第 1 阶段：检查表格
如果您有更多时间，请
运行myisamchk *.MYI或myisamchk -e *.MYI 。使用
-s(silent) 选项来抑制不必要的信息。
如果mysqld服务器停止，您应该使用该--update-state选项告诉myisamchk将表标记为
“已检查”。”
您必须只修复那些
myisamchk宣布错误的表。对于这样的表，继续第 2 阶段。
如果在检查时出现意外错误（如out
of memory错误），或者myisamchk
崩溃，请转到第 3 阶段。
第 2 阶段：轻松安全维修
首先，尝试myisamchk -r -q
tbl_name（-r
-q意思是“快速恢复模式”）。这会尝试在不触及数据文件的情况下修复索引文件。如果数据文件包含它应该包含的所有内容，并且删除链接指向数据文件中的正确位置，那么这应该有效，并且表已修复。开始修复下一张表。否则，请使用以下过程：
在继续之前备份数据文件。
使用myisamchk -r
tbl_name
（-r意思是“恢复模式”）。这将从数据文件中删除不正确的行和已删除的行并重建索引文件。
如果前面的步骤失败，请使用myisamchk --safe-recover
tbl_name。安全恢复模式使用旧的恢复方法来处理常规恢复模式无法处理（但速度较慢）的一些情况。
笔记
如果您希望修复操作进行得更快，您应该
在运行
myisamchksort_buffer_size时将和
变量的值分别设置为可用内存的 25% 左右。
key_buffer_size
如果在修复时出现意外错误（如
out of memory错误），或者
myisamchk崩溃，请转到第 3 阶段。
第三阶段：修复困难
只有当索引文件中的第一个 16KB 块被破坏或包含不正确的信息，或者索引文件丢失时，您才应该到达此阶段。在这种情况下，有必要创建一个新的索引文件。这样做：
将数据文件移至安全位置。
使用表描述文件创建新的（空的）数据和索引文件：
$> mysql db_namemysql> SET autocommit=1;
mysql> TRUNCATE TABLE tbl_name;
mysql> quit
将旧数据文件复制回新创建的数据文件。（不要只是将旧文件移回新文件。您希望保留一份副本以防出现问题。）
重要的
如果您正在使用复制，您应该在执行上述过程之前停止它，因为它涉及文件系统操作，并且这些操作不会被 MySQL 记录。
回到第 2 阶段。myisamchk -r -q应该可以工作。（这不应该是一个无限循环。）
您还可以使用SQL 语句，它会自动执行整个过程。实用程序和服务器之间也不存在不需要的交互的可能性，因为在您使用. 请参阅
第 13.7.3.5 节，“REPAIR TABLE 语句”。
REPAIR TABLE
tbl_name USE_FRMREPAIR TABLE
© Mysql 中文网
