# 23.3.5 带有表和数据的 NDB Cluster 示例_MySQL 8.0 参考手册

23.3.5 带有表和数据的 NDB Cluster 示例_MySQL 8.0 参考手册
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
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.3.1 在 Linux 上安装 NDB Cluster1
23.3.2 在 Windows 上安装 NDB Cluster1
23.3.3 NDB Cluster 的初始配置1
23.3.4 NDB Cluster 初始启动1
23.3.5 带有表和数据的 NDB Cluster 示例1
23.3.6 NDB Cluster 的安全关闭和重启1
23.3.7 升级和降级 NDB Cluster1
23.3.8 NDB Cluster 自动安装程序（不再支持）1
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.3 NDB Cluster 安装  /
23.3.5 带有表和数据的 NDB Cluster 示例
23.3.5 带有表和数据的 NDB Cluster 示例
笔记
本节中的信息适用于在 Unix 和 Windows 平台上运行的 NDB Cluster。
在 NDB Cluster 中使用数据库表和数据与在标准 MySQL 中没有太大区别。有两个要点需要牢记：
对于要在集群中复制的表，它必须使用
NDBCLUSTER存储引擎。要指定它，请在创建表时
使用ENGINE=NDBCLUSTERor
选项：ENGINE=NDBCREATE TABLE tbl_name (col_name column_definitions) ENGINE=NDBCLUSTER;
或者，对于使用不同存储引擎的现有表，使用ALTER TABLE
更改表以使用
NDBCLUSTER：
ALTER TABLE tbl_name ENGINE=NDBCLUSTER;
每个NDBCLUSTER表都有一个主键。如果创建表时用户没有定义主键，NDBCLUSTER
存储引擎会自动生成一个隐藏主键。这样的键占用空间就像任何其他表索引一样。（由于内存不足以容纳这些自动创建的索引而遇到问题的情况并不少见。）
如果您使用mysqldump
的输出从现有数据库导入表，您可以在文本编辑器中打开 SQL 脚本并将ENGINE
选项添加到任何表创建语句，或替换任何现有
ENGINE选项。假设您
world在另一个不支持 NDB Cluster 的 MySQL 服务器上有示例数据库，并且您想要导出
City表：
$> mysqldump --add-drop-table world City > city_table.sql
生成的city_table.sql文件包含此表创建语句（以及
INSERT导入表数据所需的语句）：
DROP TABLE IF EXISTS `City`;
CREATE TABLE `City` (
`ID` int(11) NOT NULL auto_increment,
`Name` char(35) NOT NULL default '',
`CountryCode` char(3) NOT NULL default '',
`District` char(20) NOT NULL default '',
`Population` int(11) NOT NULL default '0',
PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `City` VALUES (1,'Kabul','AFG','Kabol',1780000);
INSERT INTO `City` VALUES (2,'Qandahar','AFG','Qandahar',237500);
INSERT INTO `City` VALUES (3,'Herat','AFG','Herat',186800);
(remaining INSERT statements omitted)
您需要确保 MySQL 使用
NDBCLUSTER此表的存储引擎。有两种方法可以实现这一点。其中之一是在将表定义
导入集群数据库之前修改表定义。以City表为例，修改ENGINE定义的选项如下：
DROP TABLE IF EXISTS `City`;
CREATE TABLE `City` (
`ID` int(11) NOT NULL auto_increment,
`Name` char(35) NOT NULL default '',
`CountryCode` char(3) NOT NULL default '',
`District` char(20) NOT NULL default '',
`Population` int(11) NOT NULL default '0',
PRIMARY KEY  (`ID`)
) ENGINE=NDBCLUSTER DEFAULT CHARSET=latin1;
INSERT INTO `City` VALUES (1,'Kabul','AFG','Kabol',1780000);
INSERT INTO `City` VALUES (2,'Qandahar','AFG','Qandahar',237500);
INSERT INTO `City` VALUES (3,'Herat','AFG','Herat',186800);
(remaining INSERT statements omitted)
必须为要成为集群数据库一部分的每个表的定义完成此操作。完成此操作的最简单方法是对包含定义的文件进行搜索和替换，并将
或
的所有实例
替换为. 如果不想修改文件，可以使用未修改的文件创建表，然后使用改变它们的存储引擎。详情将在本节后面给出。
TYPE=engine_nameENGINE=engine_nameENGINE=NDBCLUSTERALTER TABLE
假设您已经在
world集群的 SQL 节点上创建了一个名为的数据库，那么您可以使用mysql命令行客户端以
city_table.sql通常的方式读取、创建和填充相应的表：
$> mysql world < city_table.sql
非常重要的是要记住，前面的命令必须在运行 SQL 节点的主机上执行（在本例中，在具有 IP 地址的机器上
198.51.100.20）。
要在 SQL 节点上创建整个world数据库的副本，请在非集群服务器上使用mysqldump将数据库导出到一个名为的文件
world.sql（例如，在
/tmp目录中）。然后像刚才描述的那样修改表定义并将文件导入到集群的 SQL 节点中，如下所示：
$> mysql world < /tmp/world.sql
如果将文件保存到其他位置，请相应地调整前面的说明。
在 SQL 节点上运行SELECT查询与在 MySQL 服务器的任何其他实例上运行它们没有什么不同。要从命令行运行查询，您首先需要以通常的方式登录到 MySQL Monitor（
在提示符
处指定root密码）：Enter
password:$> mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1 to server version: 8.0.32-ndb-8.0.32
Type 'help;' or '\h' for help. Type '\c' to clear the buffer.
mysql>
我们只使用 MySQL 服务器的root
帐户，并假设您已遵循安装 MySQL 服务器的标准安全预防措施，包括设置强root密码。有关详细信息，请参阅
第 2.10.4 节，“保护初始 MySQL 帐户”。
值得考虑的是，NDB Cluster 节点
在相互访问时不使用 MySQL 特权系统。设置或更改 MySQL 用户帐户（包括root帐户）仅影响访问 SQL 节点的应用程序，而不影响节点之间的交互。有关更多信息，请参阅
第 23.6.19.2 节，“NDB Cluster 和 MySQL 特权”。
ENGINE如果在导入 SQL 脚本之前
没有修改表定义中的子句，则此时应运行以下语句：mysql> USE world;
mysql> ALTER TABLE City ENGINE=NDBCLUSTER;
mysql> ALTER TABLE Country ENGINE=NDBCLUSTER;
mysql> ALTER TABLE CountryLanguage ENGINE=NDBCLUSTER;
选择数据库并对该数据库中的表运行SELECT查询也以通常的方式完成，就像退出 MySQL Monitor 一样：
mysql> USE world;
mysql> SELECT Name, Population FROM City ORDER BY Population DESC LIMIT 5;
+-----------+------------+
| Name      | Population |
+-----------+------------+
| Bombay    |   10500000 |
| Seoul     |    9981619 |
| São Paulo |    9968485 |
| Shanghai  |    9696300 |
| Jakarta   |    9604900 |
+-----------+------------+
5 rows in set (0.34 sec)
mysql> \q
Bye
$>
使用 MySQL 的应用程序可以使用标准 API 来访问
NDB表。请务必记住，您的应用程序必须访问 SQL 节点，而不是管理或数据节点。这个简短的示例展示了我们如何通过使用
在网络上其他地方的 Web 服务器上运行
SELECT的 PHP 5.X 扩展来执行刚才显示的语句：mysqli<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type"
content="text/html; charset=iso-8859-1">
<title>SIMPLE mysqli SELECT</title>
</head>
<body>
<?php
# connect to SQL node:
$link = new mysqli('198.51.100.20', 'root', 'root_password', 'world');
# parameters for mysqli constructor are:
#   host, user, password, database
if( mysqli_connect_errno() )
die("Connect failed: " . mysqli_connect_error());
$query = "SELECT Name, Population
FROM City
ORDER BY Population DESC
LIMIT 5";
# if no errors...
if( $result = $link->query($query) )
{
?>
<table border="1" width="40%" cellpadding="4" cellspacing ="1">
<tbody>
<tr>
<th width="10%">City</th>
<th>Population</th>
</tr>
<?
# then display the results...
while($row = $result->fetch_object())
printf("<tr>\n  <td align=\"center\">%s</td><td>%d</td>\n</tr>\n",
$row->Name, $row->Population);
?>
</tbody
</table>
<?
# ...and verify the number of rows that were retrieved
printf("<p>Affected rows: %d</p>\n", $link->affected_rows);
}
else
# otherwise, tell us what went wrong
echo mysqli_error();
# free the result set and the mysqli connection object
$result->close();
$link->close();
?>
</body>
</html>
我们假设 Web 服务器上运行的进程可以到达 SQL 节点的 IP 地址。
以类似的方式，您可以使用 MySQL C API、Perl-DBI、Python-mysql 或 MySQL 连接器来执行数据定义和操作任务，就像您通常使用 MySQL 一样。
© Mysql 中文网
