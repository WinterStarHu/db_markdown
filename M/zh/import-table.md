# 13.2.5 导入表语句_MySQL 8.0 参考手册

13.2.5 导入表语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.11 子查询1
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.5 导入表语句
13.2.5 导入表语句
IMPORT TABLE FROM sdi_file [, sdi_file] ...
该IMPORT TABLE语句
根据（序列化字典信息）元数据文件MyISAM中包含的信息导入表
。
需要读取和表内容文件的
权限，以及要创建的表的权限。
.sdiIMPORT TABLEFILE.sdiCREATE
可以使用
mysqldump将表从一台服务器导出以写入 SQL 语句文件，然后使用mysql处理转储文件将表导入到另一台服务器。使用“原始”表文件
IMPORT TABLE
提供更快的替代方案。
在导入之前，提供表内容的文件必须放在导入服务器的适当架构目录中，并且该.sdi文件必须位于服务器可访问的目录中。例如，
.sdi文件可以放在secure_file_priv
系统变量命名的目录中，或者（如果
secure_file_priv为空）服务器数据目录下的目录中。
以下示例描述了如何
从一台服务器的架构中导出MyISAM名为
employees和的表，并将它们导入到另一台服务器的架构中。该示例使用这些假设（要在您自己的系统上执行类似操作，请适当修改路径名）：
managershrhr
对于导出服务器，
export_basedir表示其基本目录，其数据目录为
export_basedir/data.
对于导入服务器，
import_basedir表示其基本目录，其数据目录为
import_basedir/data.
表文件从导出服务器导出到
/tmp/export目录中，这个目录是安全的（其他用户无法访问）。
导入服务器/tmp/mysql-files
用作由其
secure_file_priv系统变量命名的目录。
要从导出服务器导出表，请使用以下过程：
通过执行以下语句锁定表以确保快照一致，以便在导出期间无法修改它们：
mysql> FLUSH TABLES hr.employees, hr.managers WITH READ LOCK;
当锁定生效时，表仍然可以使用，但只能用于读访问。
在文件系统级别，将schema 目录.sdi
和表内容文件复制hr到安全导出目录：
该.sdi文件位于
hr模式目录中，但可能与表名的基本名称不完全相同。例如，和
表的.sdi文件
可能被命名为
and
。
employeesmanagersemployees_125.sdimanagers_238.sdi
对于一个MyISAM表，内容文件是它的.MYD数据文件和
.MYI索引文件。
给定这些文件名，复制命令如下所示：
$> cd export_basedir/data/hr
$> cp employees_125.sdi /tmp/export
$> cp managers_238.sdi /tmp/export
$> cp employees.{MYD,MYI} /tmp/export
$> cp managers.{MYD,MYI} /tmp/export
解锁表格：
mysql> UNLOCK TABLES;
要将表导入导入服务器，请使用以下过程：
导入模式必须存在。如有必要，执行此语句来创建它：
mysql> CREATE SCHEMA hr;
在文件系统级别，将.sdi
文件复制到导入服务器
secure_file_priv目录，
/tmp/mysql-files. 此外，将表内容文件复制到hr架构目录：
$> cd /tmp/export
$> cp employees_125.sdi /tmp/mysql-files
$> cp managers_238.sdi /tmp/mysql-files
$> cp employees.{MYD,MYI} import_basedir/data/hr
$> cp managers.{MYD,MYI} import_basedir/data/hr
通过执行命名文件
的IMPORT
TABLE语句
导入表：.sdimysql> IMPORT TABLE FROM
'/tmp/mysql-files/employees.sdi',
'/tmp/mysql-files/managers.sdi';
如果系统变量为空，则.sdi文件不需要放在由系统变量命名的导入服务器目录
中；secure_file_priv它可以位于服务器可访问的任何目录中，包括导入表的模式目录。但是，如果.sdi文件放在那个目录中，它可能会被重写；导入操作为表创建一个新.sdi文件，如果该操作对新文件使用相同的文件名，它将覆盖旧.sdi文件。
每个sdi_file值都必须是.sdi为表命名文件的字符串文字，或者是与.sdi文件匹配的模式。如果字符串是模式，则
.sdi必须按字面给出任何前导目录路径和文件名后缀。模式字符仅允许出现在文件名的基本名称部分：
?匹配任何单个字符
*匹配任何字符序列，包括无字符
使用模式，前面的IMPORT
TABLE语句可以这样写（假设/tmp/mysql-files目录不包含.sdi与模式匹配的其他文件）：
IMPORT TABLE FROM '/tmp/mysql-files/*.sdi';
为了解释.sdi文件路径名的位置，服务器使用与
IMPORT TABLE服务器端规则相同的规则LOAD DATA（即非LOCAL规则）。请参阅
第 13.2.7 节，“加载数据语句”，特别注意用于解释相对路径名的规则。
IMPORT TABLE如果无法
.sdi找到 或 表文件，则失败。导入表后，服务器会尝试打开它并将检测到的任何问题报告为警告。要尝试修复以纠正任何报告的问题，请使用REPAIR TABLE。
IMPORT TABLE不写入二进制日志。
限制和限制
IMPORT TABLE仅适用于非TEMPORARY MyISAM
表。它不适用于使用事务存储引擎创建的表
CREATE TEMPORARY
TABLE、使用 或视图创建的表。
导入操作中使用的.sdi文件必须在与导入服务器具有相同数据字典版本和sdi版本的服务器上生成。生成服务器的版本信息在
.sdi文件中找到：
{
"mysqld_version_id":80019,
"dd_version":80017,
"sdi_version":80016,
...
}
要确定导入服务器的数据字典和sdi版本，可以查看.sdi导入服务器上最近创建的表的文件。
在导入操作之前，表数据和索引文件必须放在导入服务器的模式目录中，除非导出服务器上定义的表使用
DATA DIRECTORY或INDEX
DIRECTORY表选项。IMPORT TABLE
在这种情况下，请在执行语句
之前使用以下替代方法之一修改导入过程：
将数据和索引文件放入导入服务器主机上与导出服务器主机上相同的目录中，并在导入服务器架构目录中创建指向这些文件的符号链接。
将数据和索引文件放入不同于导出服务器主机上的导入服务器主机目录，并在导入服务器架构目录中创建指向这些文件的符号链接。此外，修改
.sdi文件以反映不同的文件位置。
将数据和索引文件放到导入服务器主机上的schema目录下，修改
.sdi文件去掉数据和索引目录表选项。
文件中存储的任何归类 ID.sdi必须引用导出和导入服务器上的相同归类。
表的触发器信息未序列化到表
.sdi文件中，因此导入操作不会恢复触发器。
.sdi在执行语句之前允许
对文件进行一些编辑IMPORT
TABLE，而其他的则有问题甚至可能导致导入操作失败：
如果数据和索引文件的位置在导出服务器和导入服务器之间不同，则需要更改数据目录和索引目录表选项。
需要更改架构名称才能将表导入到导入服务器上与导出服务器上不同的架构中。
可能需要更改架构和表名称以适应导出和导入服务器上文件系统区分大小写语义之间的差异或
lower_case_table_names
设置中的差异。更改文件中的表名
.sdi可能还需要重命名表文件。
在某些情况下，允许更改列定义。更改数据类型可能会导致问题。
© Mysql 中文网
