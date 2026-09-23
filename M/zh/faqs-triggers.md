# A.5 MySQL 8.0 FAQ：触发器_MySQL 8.0 参考手册

A.5 MySQL 8.0 FAQ：触发器_MySQL 8.0 参考手册
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
A.1 MySQL 8.0 FAQ：一般
A.2 MySQL 8.0 FAQ：存储引擎
A.3 MySQL 8.0 常见问题解答：服务器 SQL 模式
A.4 MySQL 8.0 FAQ：存储过程和函数
A.5 MySQL 8.0 FAQ：触发器
A.6 MySQL 8.0 FAQ：视图
A.7 MySQL 8.0 FAQ：INFORMATION_SCHEMA
A.8 MySQL 8.0 FAQ：迁移
A.9 MySQL 8.0 FAQ：安全
A.10 MySQL 8.0 FAQ：NDB Cluster
A.11 MySQL 8.0 FAQ：MySQL 中日韩字符集
A.12 MySQL 8.0 常见问题解答：连接器和 API
A.13 MySQL 8.0 常见问题解答：C API、libmysql
A.14 MySQL 8.0 FAQ：复制
A.15 MySQL 8.0 FAQ：MySQL 企业级线程池
A.16 MySQL 8.0 FAQ：InnoDB Change Buffer
A.17 MySQL 8.0 FAQ：InnoDB 静态数据加密
A.18 MySQL 8.0 FAQ：虚拟化支持
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 附录 A MySQL 8.0 常见问题解答  /
A.5 MySQL 8.0 FAQ：触发器
A.5 MySQL 8.0 FAQ：触发器
A.5.1.
在哪里可以找到 MySQL 8.0 触发器的文档？
A.5.2。
是否有 MySQL 触发器的讨论论坛？
A.5.3.
MySQL 8.0 有语句级或行级触发器吗？
A.5.4。
是否有任何默认触发器？
A.5.5。
MySQL 中的触发器是如何管理的？
A.5.6.
有没有办法查看给定数据库中的所有触发器？
A.5.7。
触发器存储在哪里？
A.5.8。
触发器可以调用存储过程吗？
A.5.9。
触发器可以访问表吗？
A.5.10。
一个表可以有多个具有相同触发事件和动作时间的触发器吗？
A.5.11。
触发器是否可以更新远程服务器上的表？
A.5.12。
触发器是否与复制一起使用？
A.5.13。
如何通过复制到副本的源上的触发器执行操作？
A.5.1.
在哪里可以找到 MySQL 8.0 触发器的文档？
请参阅第 25.3 节，“使用触发器”。
A.5.2。
是否有 MySQL 触发器的讨论论坛？
是的。它可以在https://forums.mysql.com/list.php?99找到。
A.5.3.
MySQL 8.0 有语句级或行级触发器吗？
在 MySQL 8.0 中，所有的触发器都是FOR EACH
ROW; 也就是说，为插入、更新或删除的每一行激活触发器。MySQL 8.0 不支持使用FOR EACH
STATEMENT.
A.5.4。
是否有任何默认触发器？
不明确。MySQL 确实对某些TIMESTAMP列以及使用
AUTO_INCREMENT.
A.5.5。
MySQL 中的触发器是如何管理的？
在 MySQL 8.0 中，可以使用
CREATE TRIGGER语句创建触发器，并使用DROP TRIGGER. 有关这些语句的更多信息，请参阅
第 13.1.22 节，“CREATE TRIGGER 语句”和
第 13.1.34 节，“DROP TRIGGER 语句”。
触发器的信息可以通过查询
INFORMATION_SCHEMA.TRIGGERS表获得。请参阅第 26.3.45 节，“INFORMATION_SCHEMA TRIGGERS 表”。
A.5.6.
有没有办法查看给定数据库中的所有触发器？
是的。dbname您可以使用对表的查询
来获取在数据库中定义的所有触发器的列表，INFORMATION_SCHEMA.TRIGGERS如下所示：
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA='dbname';
有关此表的更多信息，请参阅
第 26.3.45 节，“INFORMATION_SCHEMA TRIGGERS 表”。
您还可以使用SHOW
TRIGGERS特定于 MySQL 的语句。请参阅
第 13.7.7.40 节，“SHOW TRIGGERS 语句”。
A.5.7。
触发器存储在哪里？
触发器存储在mysql.triggers
系统表中，它是数据字典的一部分。
A.5.8。
触发器可以调用存储过程吗？
是的。
A.5.9。
触发器可以访问表吗？
触发器可以访问它自己的表中的旧数据和新数据。触发器也可以影响其他表，但不允许修改已被调用函数或触发器的语句使用（用于读取或写入）的表。
A.5.10。
一个表可以有多个具有相同触发事件和动作时间的触发器吗？
在 MySQL 8.0 中，可以为给定的表定义多个具有相同触发事件和动作时间的触发器。例如，您可以BEFORE
UPDATE为一个表设置两个触发器。默认情况下，具有相同触发事件和动作时间的触发器按创建顺序激活。要影响触发器顺序，请在其后指定一个子句，该子句FOR EACH ROW指示
FOLLOWS或PRECEDES以及也具有相同触发器事件和操作时间的现有触发器的名称。使用FOLLOWS，新触发器在现有触发器之后激活。使用
PRECEDES，新触发器在现有触发器之前激活。
A.5.11。
触发器是否可以更新远程服务器上的表？
是的。可以使用
FEDERATED存储引擎更新远程服务器上的表。（参见
第 16.8 节，“联邦存储引擎”）。
A.5.12。
触发器是否与复制一起使用？
是的。但是，它们的工作方式取决于您使用的是 MySQL 的“经典”基于语句还是基于行的复制格式。
使用基于语句的复制时，副本上的触发器由在源上执行（并复制到副本）的语句执行。
使用基于行的复制时，由于在源上运行然后复制到副本的语句，触发器不会在副本上执行。相反，当使用基于行的复制时，在源上执行触发器引起的更改将应用​​于副本。
有关详细信息，请参阅
第 17.5.1.36 节，“复制和触发器”。
A.5.13。
如何通过复制到副本的源上的触发器执行操作？
同样，这取决于您使用的是基于语句还是基于行的复制。
基于语句的复制。
首先，必须在副本服务器上重新创建源上存在的触发器。完成此操作后，复制流程将像参与复制的任何其他标准 DML 语句一样工作。例如，考虑一个
EMP具有AFTER
插入触发器的表，它存在于复制源服务器上。副本服务器上也存在相同的EMP表和
AFTER插入触发器。复制流程将是：
向发表
INSERT声明
。EMPAFTER触发器
EMP激活
。
该INSERT语句被写入二进制日志。
副本获取
INSERT语句
EMP并执行它。
副本上存在
的AFTER触发器
激活。EMP
基于行的复制。
当您使用基于行的复制时，在源上执行触发器引起的更改将应用​​于副本。但是，在基于行的复制下，触发器本身实际上并不在副本上执行。这是因为，如果源和副本都应用了来自源的更改，此外，导致这些更改的触发器也应用于副本，则这些更改实际上会在副本上应用两次，从而导致不同的数据源和副本。
在大多数情况下，基于行和基于语句的复制的结果是相同的。但是，如果您在源和副本上使用不同的触发器，则不能使用基于行的复制。（这是因为基于行的格式将源上执行的触发器所做的更改复制到副本，而不是导致触发器执行的语句，并且不会执行副本上的相应触发器。）相反，任何语句导致执行此类触发器的操作必须使用基于语句的复制进行复制。
有关详细信息，请参阅
第 17.5.1.36 节，“复制和触发器”。
© Mysql 中文网
