# 6.2.12 使用部分撤销的权限限制_MySQL 8.0 参考手册

6.2.12 使用部分撤销的权限限制_MySQL 8.0 参考手册
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
6.2 访问控制和账户管理
6.2.1 账户用户名和密码1
6.2.2 MySQL提供的权限1
6.2.3 授权表1
6.2.4 指定账户名1
6.2.5 指定角色名称1
6.2.6 访问控制，第 1 阶段：连接验证1
6.2.7 访问控制，第 2 阶段：请求验证1
6.2.8 添加账号、分配权限、删除账号1
6.2.9 预留账户1
6.2.10 使用角色1
6.2.11 账户类别1
6.2.12 使用部分撤销的权限限制1
6.2.13 权限变更何时生效1
6.2.14 分配账户密码1
6.2.15 密码管理1
6.2.16 服务器对过期密码的处理1
6.2.17 可插拔认证1
6.2.18 多因素认证1
6.2.19 代理用户1
6.2.20 账户锁定1
6.2.21 设置账号资源限制1
6.2.22 MySQL连接问题排查1
6.2.23 基于 SQL 的账户活动审计1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.2 访问控制和账户管理  /
6.2.12 使用部分撤销的权限限制
6.2.12 使用部分撤销的权限限制
在 MySQL 8.0.16 之前，不可能授予全局应用的权限，但某些模式除外。从 MySQL 8.0.16 开始，如果
partial_revokes启用了系统变量，这是可能的。具体来说，对于在全局级别拥有特权的用户，partial_revokes
可以撤销特定模式的特权，同时保留其他模式的特权。因此施加的权限限制可能对管理具有全局权限但不应被允许访问某些模式的帐户很有用。例如，可以允许一个帐户修改除
mysql系统模式中的表之外的任何表。
使用部分撤销部分撤销与显式模式授权禁用部分撤销部分撤销和复制
笔记
为简洁起见，CREATE USER
此处显示的语句不包括密码。对于生产用途，始终分配帐户密码。
使用部分撤销
系统partial_revokes变量控制是否可以对帐户进行权限限制。默认情况下，
partial_revokes禁用并且尝试部分撤销全局权限会产生错误：
mysql> CREATE USER u1;
mysql> GRANT SELECT, INSERT ON *.* TO u1;
mysql> REVOKE INSERT ON world.* FROM u1;
ERROR 1141 (42000): There is no such grant defined for user 'u1' on host '%'
要允许REVOKE操作，请启用partial_revokes：
SET PERSIST partial_revokes = ON;
SET
PERSIST为正在运行的 MySQL 实例设置一个值。它还会保存该值，使其在随后的服务器重新启动时继续使用。要更改正在运行的 MySQL 实例的值而不使其延续到后续重新启动，请使用GLOBAL关键字而不是
PERSIST. 请参阅第 13.7.6.1 节，“变量赋值的 SET 语法”。
启用后，partial_revokes部分撤销成功：
mysql> REVOKE INSERT ON world.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+------------------------------------------+
| Grants for u1@%                          |
+------------------------------------------+
| GRANT SELECT, INSERT ON *.* TO `u1`@`%`  |
| REVOKE INSERT ON `world`.* FROM `u1`@`%` |
+------------------------------------------+
SHOW GRANTS在其输出中列出部分撤销作为REVOKE语句。结果表明u1具有全局SELECT和
INSERT特权，但
INSERT不能对world模式中的表行使。也就是说，u1对world表的访问是只读的。
mysql.user服务器在系统表
中记录通过部分撤销实现的特权限制。如果一个账户有部分撤销，它的
User_attributes列值有一个
Restrictions属性：
mysql> SELECT User, Host, User_attributes->>'$.Restrictions'
FROM mysql.user WHERE User_attributes->>'$.Restrictions' <> '';
+------+------+------------------------------------------------------+
| User | Host | User_attributes->>'$.Restrictions'                   |
+------+------+------------------------------------------------------+
| u1   | %    | [{"Database": "world", "Privileges": ["INSERT"]}] |
+------+------+------------------------------------------------------+
笔记
尽管可以对任何模式实施部分撤销，但对mysql系统模式的特权限制作为防止普通帐户修改系统帐户的策略的一部分尤其有用。请参阅保护系统帐户免受常规帐户的操纵。
部分撤销操作受以下条件约束：
可以使用部分撤销来限制不存在的模式，但前提是撤销的权限是全局授予的。如果未全局授予特权，则为不存在的模式撤销它会产生错误。
部分撤销仅适用于架构级别。您不能对仅适用于全局的权限（例如FILE或
BINLOG_ADMIN）或表、列或例程权限使用部分撤销。
在权限分配中，启用
partial_revokes会导致 MySQL 将模式名称中出现的未转义
字符_和%SQL 通配符解释为文字字符，就好像它们已被转义为\_and
一样\%。因为这会改变 MySQL 解释权限的方式，所以建议在
partial_revokes可能启用的安装的权限分配中避免使用未转义的通配符。
如前所述，模式级特权的部分撤销在SHOW GRANTS
输出中显示为REVOKE语句。这与SHOW GRANTS
表示“普通”模式级特权的方式不同：
授予后，模式级特权GRANT在输出中由它们自己的语句表示：
mysql> CREATE USER u1;
mysql> GRANT UPDATE ON mysql.* TO u1;
mysql> GRANT DELETE ON world.* TO u1;
mysql> SHOW GRANTS FOR u1;
+---------------------------------------+
| Grants for u1@%                       |
+---------------------------------------+
| GRANT USAGE ON *.* TO `u1`@`%`        |
| GRANT UPDATE ON `mysql`.* TO `u1`@`%` |
| GRANT DELETE ON `world`.* TO `u1`@`%` |
+---------------------------------------+
撤销时，模式级特权会从输出中消失。它们不作为
REVOKE语句出现：
mysql> REVOKE UPDATE ON mysql.* FROM u1;
mysql> REVOKE DELETE ON world.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+--------------------------------+
| Grants for u1@%                |
+--------------------------------+
| GRANT USAGE ON *.* TO `u1`@`%` |
+--------------------------------+
当用户授予特权时，授予者对该特权的任何限制都将由被授予者继承，除非被授予者已经拥有不受限制的特权。考虑以下两个用户，其中一个具有全局
SELECT权限：
CREATE USER u1, u2;
GRANT SELECT ON *.* TO u2;
假设管理用户admin具有全局但部分撤销的
SELECT权限：
mysql> CREATE USER admin;
mysql> GRANT SELECT ON *.* TO admin WITH GRANT OPTION;
mysql> REVOKE SELECT ON mysql.* FROM admin;
mysql> SHOW GRANTS FOR admin;
+------------------------------------------------------+
| Grants for admin@%                                   |
+------------------------------------------------------+
| GRANT SELECT ON *.* TO `admin`@`%` WITH GRANT OPTION |
| REVOKE SELECT ON `mysql`.* FROM `admin`@`%`          |
+------------------------------------------------------+
如果全局授予
admin和
，则每个用户的结果不同：
SELECTu1u2
如果全局
admin授予
，谁没有
特权开始，继承
特权限制：
SELECTu1SELECTu1adminmysql> GRANT SELECT ON *.* TO u1;
mysql> SHOW GRANTS FOR u1;
+------------------------------------------+
| Grants for u1@%                          |
+------------------------------------------+
| GRANT SELECT ON *.* TO `u1`@`%`          |
| REVOKE SELECT ON `mysql`.* FROM `u1`@`%` |
+------------------------------------------+
另一方面，u2已经拥有SELECT不受限制的全局特权。GRANT
只能增加被授予者的现有特权，而不能减少它们，因此如果全局
admin授予
，则不会继承限制：
SELECTu2u2adminmysql> GRANT SELECT ON *.* TO u2;
mysql> SHOW GRANTS FOR u2;
+---------------------------------+
| Grants for u2@%                 |
+---------------------------------+
| GRANT SELECT ON *.* TO `u2`@`%` |
+---------------------------------+
如果GRANT语句包含
子句，则应用的权限限制是针对该子句指定的用户/角色组合的权限限制，而不是针对执行该语句的用户的权限限制。有关该
子句的信息，请参阅第 13.7.1.6 节，“GRANT 语句”。
AS userAS
对授予帐户的新权限的限制添加到该帐户的任何现有限制中：
mysql> CREATE USER u1;
mysql> GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO u1;
mysql> REVOKE INSERT ON mysql.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+---------------------------------------------------------+
| Grants for u1@%                                         |
+---------------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `u1`@`%` |
| REVOKE INSERT ON `mysql`.* FROM `u1`@`%`                |
+---------------------------------------------------------+
mysql> REVOKE DELETE, UPDATE ON db2.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+---------------------------------------------------------+
| Grants for u1@%                                         |
+---------------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `u1`@`%` |
| REVOKE UPDATE, DELETE ON `db2`.* FROM `u1`@`%`          |
| REVOKE INSERT ON `mysql`.* FROM `u1`@`%`                |
+---------------------------------------------------------+
特权限制的聚合适用于显式部分撤销特权（如刚才所示）以及从执行语句的用户或子句中提到的用户隐式继承限制的情况。
AS
user
如果帐户对模式有权限限制：
该帐户不能向其他帐户授予对受限模式或其中任何对象的特权。
另一个没有限制的帐户可以向受限帐户授予受限模式或其中的对象的权限。假设不受限制的用户执行这些语句：
CREATE USER u1;
GRANT SELECT, INSERT, UPDATE ON *.* TO u1;
REVOKE SELECT, INSERT, UPDATE ON mysql.* FROM u1;
GRANT SELECT ON mysql.user TO u1;          -- grant table privilege
GRANT SELECT(Host,User) ON mysql.db TO u1; -- grant column privileges
生成的帐户具有这些特权，能够在受限模式中执行有限的操作：
mysql> SHOW GRANTS FOR u1;
+-----------------------------------------------------------+
| Grants for u1@%                                           |
+-----------------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE ON *.* TO `u1`@`%`           |
| REVOKE SELECT, INSERT, UPDATE ON `mysql`.* FROM `u1`@`%`  |
| GRANT SELECT (`Host`, `User`) ON `mysql`.`db` TO `u1`@`%` |
| GRANT SELECT ON `mysql`.`user` TO `u1`@`%`                |
+-----------------------------------------------------------+
如果帐户对全局权限有限制，则可以通过以下任何操作删除该限制：
通过对权限没有限制的帐户全局授予该帐户的权限。
在架构级别授予权限。
全局撤销特权。
考虑一个u1拥有多个全局权限但对
INSERT,
UPDATE和
有限制的用户DELETE：
mysql> CREATE USER u1;
mysql> GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO u1;
mysql> REVOKE INSERT, UPDATE, DELETE ON mysql.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+----------------------------------------------------------+
| Grants for u1@%                                          |
+----------------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `u1`@`%`  |
| REVOKE INSERT, UPDATE, DELETE ON `mysql`.* FROM `u1`@`%` |
+----------------------------------------------------------+
无限制地从一个帐户全局授予权限u1会删除权限限制。例如，要删除INSERT
限制：
mysql> GRANT INSERT ON *.* TO u1;
mysql> SHOW GRANTS FOR u1;
+---------------------------------------------------------+
| Grants for u1@%                                         |
+---------------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `u1`@`%` |
| REVOKE UPDATE, DELETE ON `mysql`.* FROM `u1`@`%`        |
+---------------------------------------------------------+
在模式级别授予特权以
u1删除特权限制。例如，要删除UPDATE
限制：
mysql> GRANT UPDATE ON mysql.* TO u1;
mysql> SHOW GRANTS FOR u1;
+---------------------------------------------------------+
| Grants for u1@%                                         |
+---------------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `u1`@`%` |
| REVOKE DELETE ON `mysql`.* FROM `u1`@`%`                |
+---------------------------------------------------------+
撤销全局权限会删除该权限，包括对其的任何限制。例如，要删除
DELETE限制（以删除所有访问为代价DELETE）：
mysql> REVOKE DELETE ON *.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+-------------------------------------------------+
| Grants for u1@%                                 |
+-------------------------------------------------+
| GRANT SELECT, INSERT, UPDATE ON *.* TO `u1`@`%` |
+-------------------------------------------------+
如果一个帐户在全局和架构级别都具有特权，则必须在架构级别将其撤销两次才能实现部分撤销。假设u1具有这些特权， whereINSERT在全局和world模式上都持有：
mysql> CREATE USER u1;
mysql> GRANT SELECT, INSERT ON *.* TO u1;
mysql> GRANT INSERT ON world.* TO u1;
mysql> SHOW GRANTS FOR u1;
+-----------------------------------------+
| Grants for u1@%                         |
+-----------------------------------------+
| GRANT SELECT, INSERT ON *.* TO `u1`@`%` |
| GRANT INSERT ON `world`.* TO `u1`@`%`   |
+-----------------------------------------+
撤销INSERTon
world撤销模式级权限（SHOW GRANTS不再显示模式级GRANT
语句）：
mysql> REVOKE INSERT ON world.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+-----------------------------------------+
| Grants for u1@%                         |
+-----------------------------------------+
| GRANT SELECT, INSERT ON *.* TO `u1`@`%` |
+-----------------------------------------+
再次撤销INSERT执行
world全局权限的部分撤销（SHOW GRANTS现在包括模式级REVOKE
语句）：
mysql> REVOKE INSERT ON world.* FROM u1;
mysql> SHOW GRANTS FOR u1;
+------------------------------------------+
| Grants for u1@%                          |
+------------------------------------------+
| GRANT SELECT, INSERT ON *.* TO `u1`@`%`  |
| REVOKE INSERT ON `world`.* FROM `u1`@`%` |
+------------------------------------------+
部分撤销与显式模式授权
为了提供对某些模式而非其他模式的帐户的访问权限，部分撤销提供了一种替代方法，可以替代显式授予模式级访问权限而不授予全局权限的方法。这两种方法各有优缺点。
授予模式级权限而不是全局权限：
添加新模式：默认情况下，现有帐户无法访问该模式。对于模式应该可访问的任何帐户，DBA 必须授予模式级别的访问权限。
添加新帐户：DBA 必须为该帐户应有权访问的每个模式授予模式级访问权限。
结合部分撤销授予全局权限：
添加新模式：具有全局权限的现有帐户可以访问该模式。对于模式不可访问的任何此类帐户，DBA 必须添加部分撤销。
添加新帐户：DBA 必须授予全局权限，以及对每个受限模式的部分撤销。
使用显式模式级授权的方法对于访问权限仅限于少数模式的帐户更为方便。使用部分撤销的方法对于具有广泛访问除少数模式之外的所有模式的帐户更方便。
禁用部分撤销
一旦启用，partial_revokes
如果任何帐户有权限限制，则无法禁用。如果存在任何此类帐户，则禁用
partial_revokes失败：
对于在启动时禁用的尝试
partial_revokes，服务器会记录一条错误消息并启用
partial_revokes.
对于在运行时禁用的尝试
partial_revokes，会发生错误并且
partial_revokes值保持不变。
要partial_revokes在存在限制时禁用，必须首先删除限制：
确定哪些账户有部分撤销：
SELECT User, Host, User_attributes->>'$.Restrictions'
FROM mysql.user WHERE User_attributes->>'$.Restrictions' <> '';
对于每个这样的帐户，删除其权限限制。假设上一步显示帐户
u1有这些限制：
[{"Database": "world", "Privileges": ["INSERT", "DELETE"]
可以通过多种方式取消限制：
全局授予权限，没有限制：
GRANT INSERT, DELETE ON *.* TO u1;
在架构级别授予权限：
GRANT INSERT, DELETE ON world.* TO u1;
全局撤销权限（假设不再需要它们）：
REVOKE INSERT, DELETE ON *.* FROM u1;
删除帐户本身（假设不再需要它）：
DROP USER u1;
删除所有权限限制后，可以禁用部分撤销：
SET PERSIST partial_revokes = OFF;
部分撤销和复制
在复制场景中，如果
partial_revokes在任何主机上启用，则必须在所有主机上启用。否则，
REVOKE部分撤销全局权限的语句不会对发生复制的所有主机产生相同的效果，可能会导致复制不一致或错误。
启用时partial_revokes，扩展语法会记录在
GRANT语句的二进制日志中，包括发出该语句的当前用户及其当前活动的角色。如果以这种方式记录的用户或角色在副本上不存在，则复制应用程序线程会在该GRANT语句处停止并出错。确保GRANT在复制源服务器上发出或可能发出语句的所有用户帐户也存在于副本上，并且具有与它们在源上相同的角色集。
© Mysql 中文网
