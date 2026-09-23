# 9.6 查询属性_MySQL 8.0 参考手册

9.6 查询属性_MySQL 8.0 参考手册
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
9.1 文字值
9.2 模式对象名称
9.3 关键字和保留字
9.4 用户自定义变量
9.5 表达式
9.6 查询属性
9.7 评论
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
MySQL 8.0 参考手册  / 第9章语言结构  /
9.6 查询属性
9.6 查询属性
SQL 语句最明显的部分是语句的文本。从 MySQL 8.0.23 开始，客户端还可以定义应用于发送到服务器执行的下一条语句的查询属性：
属性在发送语句之前定义。
属性一直存在到语句执行结束，此时属性集被清除。
虽然存在属性，但可以在服务器端访问它们。
可以使用查询属性的方式示例：
Web 应用程序生成生成数据库查询的页面，并且对于每个查询都必须跟踪生成它的页面的 URL。
应用程序通过每个查询传递额外的处理信息，供审计插件或查询重写插件等插件使用。
MySQL 支持这些功能而无需使用变通方法，例如在查询字符串中包含特殊格式的注释。本节的其余部分描述了如何使用查询属性支持，包括必须满足的先决条件。
定义和访问查询属性使用查询属性的先决条件查询属性可加载函数
定义和访问查询属性
使用 MySQL C API 的应用程序通过调用该mysql_bind_param()
函数来定义查询属性。请参阅mysql_bind_param()。其他 MySQL 连接器也可能提供查询属性支持。请参阅各个连接器的文档。
mysql客户端有一个
命令
，query_attributes最多可以定义 32 对属性名称和值。请参阅
第 4.5.1.2 节，“mysql 客户端命令”。
character_set_client查询属性名称使用系统变量
指示的字符集进行传输
。
要访问已定义属性的 SQL 语句中的查询属性，请按照
使用查询属性的先决条件中query_attributes所述安装该组件
。该组件实现了一个
可加载函数，该函数采用属性名称参数并以字符串形式返回属性值，或者
如果该属性不存在。请参阅
查询属性可加载函数。
mysql_query_attribute_string()NULL
以下示例使用mysql客户端
query_attributes命令定义属性名称/值对，以及
mysql_query_attribute_string()
按名称访问属性值的函数。
此示例定义了两个名为n1
和的属性n2。第一个SELECT
展示了如何检索这些属性，还演示了检索不存在的属性 ( n3) 会返回NULL。第二个
SELECT表明属性不会跨语句持续存在。
mysql> query_attributes n1 v1 n2 v2;
mysql> SELECT
mysql_query_attribute_string('n1') AS 'attr 1',
mysql_query_attribute_string('n2') AS 'attr 2',
mysql_query_attribute_string('n3') AS 'attr 3';
+--------+--------+--------+
| attr 1 | attr 2 | attr 3 |
+--------+--------+--------+
| v1     | v2     | NULL   |
+--------+--------+--------+
mysql> SELECT
mysql_query_attribute_string('n1') AS 'attr 1',
mysql_query_attribute_string('n2') AS 'attr 2';
+--------+--------+
| attr 1 | attr 2 |
+--------+--------+
| NULL   | NULL   |
+--------+--------+
如第二SELECT条语句所示，在给定语句之前定义的属性仅适用于该语句，并在该语句执行后被清除。要在多个语句中使用一个属性值，请将其分配给一个变量。以下示例显示如何执行此操作，并说明属性值可通过变量在后续语句中使用，但不能通过调用
mysql_query_attribute_string()：
mysql> query_attributes n1 v1 n2 v2;
mysql> SET
@attr1 = mysql_query_attribute_string('n1'),
@attr2 = mysql_query_attribute_string('n2');
mysql> SELECT
@attr1, mysql_query_attribute_string('n1') AS 'attr 1',
@attr2, mysql_query_attribute_string('n2') AS 'attr 2';
+--------+--------+--------+--------+
| @attr1 | attr 1 | @attr2 | attr 2 |
+--------+--------+--------+--------+
| v1     | NULL   | v2     | NULL   |
+--------+--------+--------+--------+
属性也可以通过将它们存储在表中来保存以备后用：
mysql> CREATE TABLE t1 (c1 CHAR(20), c2 CHAR(20));
mysql> query_attributes n1 v1 n2 v2;
mysql> INSERT INTO t1 (c1, c2) VALUES(
mysql_query_attribute_string('n1'),
mysql_query_attribute_string('n2')
);
mysql> SELECT * FROM t1;
+------+------+
| c1   | c2   |
+------+------+
| v1   | v2   |
+------+------+
查询属性受以下限制和限制：
如果在将语句发送到服务器执行之前发生了多个属性定义操作，则最近的定义操作将应用并替换早期操作中定义的属性。
如果使用相同的名称定义了多个属性，则尝试检索属性值会得到未定义的结果。
无法按名称检索用空名称定义的属性。
属性不适用于使用 准备的语句
PREPARE。
该
mysql_query_attribute_string()
函数不能在 DDL 语句中使用。
不复制属性。调用该
mysql_query_attribute_string()
函数的语句不会在所有服务器上获得相同的值。
使用查询属性的先决条件
要在已定义属性的 SQL 语句中访问查询属性，
query_attributes必须安装该组件。使用此语句执行此操作：
INSTALL COMPONENT "file://component_query_attributes";
组件安装是一次性操作，不需要在每次服务器启动时都完成。INSTALL
COMPONENT加载组件，并将其注册到mysql.component系统表中，以便在后续服务器启动期间加载它。
该query_attributes组件访问查询属性以实现
mysql_query_attribute_string()
功能。请参阅第 5.5.4 节，“查询属性组件”。
要卸载该query_attributes组件，请使用以下语句：
UNINSTALL COMPONENT "file://component_query_attributes";
UNINSTALL COMPONENT卸载组件，并从
mysql.component系统表中注销它，以使其在后续服务器启动期间不被加载。
因为安装和卸载
query_attributes组件就是安装和卸载
mysql_query_attribute_string()
组件实现的功能，所以没有必要使用CREATE
FUNCTION或
DROP FUNCTION
这样做。
查询属性可加载函数
mysql_query_attribute_string(name)
应用程序可以定义应用于发送到服务器的下一个查询的属性。该
mysql_query_attribute_string()
函数从 MySQL 8.0.23 开始可用，在给定属性名称的情况下，将属性值作为字符串返回。此函数使查询能够访问和合并适用于它的属性的值。
mysql_query_attribute_string()
通过安装
query_attributes组件来安装。请参阅
第 9.6 节，“查询属性”，其中还讨论了查询属性的目的和使用。
参数：
name: 属性名称。
返回值：
返回属性值作为成功的字符串，或者
NULL如果属性不存在。
例子：
以下示例使用mysql
客户端query_attributes命令来定义可由 检索的查询属性
mysql_query_attribute_string()。显示SELECT检索不存在的属性 ( n3) 返回
NULL。
mysql> query_attributes n1 v1 n2 v2;
mysql> SELECT
->   mysql_query_attribute_string('n1') AS 'attr 1',
->   mysql_query_attribute_string('n2') AS 'attr 2',
->   mysql_query_attribute_string('n3') AS 'attr 3';
+--------+--------+--------+
| attr 1 | attr 2 | attr 3 |
+--------+--------+--------+
| v1     | v2     | NULL   |
+--------+--------+--------+
© Mysql 中文网
