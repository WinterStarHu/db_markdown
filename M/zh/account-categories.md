# 6.2.11 账户类别_MySQL 8.0 参考手册

6.2.11 账户类别_MySQL 8.0 参考手册
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
6.2.11 账户类别
6.2.11 账户类别
从 MySQL 8.0.16 开始，MySQL 引入了基于
SYSTEM_USER权限的用户帐户类别的概念。
系统和普通账户受 SYSTEM_USER 权限影响的操作系统和例会保护系统账户免受普通账户的操纵
系统和普通账户
MySQL引入了用户账户类别的概念，系统用户和普通用户根据是否有SYSTEM_USER权限区分：
具有SYSTEM_USER
权限的用户是系统用户。
没有
SYSTEM_USER特权的用户是普通用户。
该SYSTEM_USER权限会影响给定用户可以应用其其他权限的帐户，以及该用户是否受到其他帐户的保护：
系统用户可以修改系统帐户和普通帐户。也就是说，拥有对普通帐户执行给定操作的适当权限的用户也可以通过拥有SYSTEM_USER来对系统帐户执行操作。系统帐户只能由具有适当权限的系统用户修改，普通用户不能修改。
具有适当权限的普通用户可以修改普通帐户，但不能修改系统帐户。具有适当权限的系统用户和普通用户都可以修改普通帐户。
如果用户具有对常规帐户执行给定操作的适当权限，则
SYSTEM_USER使该用户也可以对系统帐户执行该操作。
SYSTEM_USER并不意味着任何其他特权，因此执行给定帐户操作的能力仍然取决于拥有任何其他所需的特权。例如，如果一个用户可以授予
SELECT和
UPDATE权限给普通帐户，那么SYSTEM_USER
该用户也可以授予SELECT
和UPDATE给系统帐户。
SYSTEM_USER系统帐户和常规帐户之间的区别可以通过保护具有特权的帐户免受不具有特权的帐户的影响，
从而更好地控制某些帐户管理问题
。例如，该
CREATE USER权限不仅可以创建新帐户，还可以修改和删除现有帐户。在没有系统用户概念的情况下，拥有CREATE USER权限的用户可以修改或删除任何现有帐户，包括该
root帐户。系统用户的概念可以限制对root
帐户（本身是系统帐户）的修改，因此只能由系统用户进行修改。普通用户CREATE
USER特权仍然可以修改或删除现有帐户，但只能是普通帐户。
受 SYSTEM_USER 权限影响的操作
该SYSTEM_USER特权会影响这些操作：
账户操纵。
帐户操纵包括创建和删除帐户、授予和撤销权限、更改帐户身份验证特征（如凭据或身份验证插件）以及更改其他帐户特征（如密码过期策略）。
使用SYSTEM_USER帐户管理语句（例如
CREATE USER和
）来操作系统帐户需要特权GRANT。SYSTEM_USER要防止帐户以这种方式修改系统帐户，请通过不授予它权限使其成为常规帐户
。（但是，要完全保护系统帐户免受常规帐户的侵害，您还必须保留常规帐户对mysql系统架构的修改权限。请参阅保护系统帐户免受常规帐户的操纵。）
杀死当前会话和其中执行的语句。
要终止以特权执行的会话或语句，
除了任何其他所需的特权（或已弃用的特权）之外SYSTEM_USER，您自己的会话必须具有
特权。
SYSTEM_USERCONNECTION_ADMINSUPER
从 MySQL 8.0.30 开始，如果将服务器置于离线模式的用户没有
SYSTEM_USER权限，则具有权限的已连接客户端用户
SYSTEM_USER也不会断开连接。但是，这些用户无法在服务器处于脱机模式时发起与服务器的新连接，除非他们也具有
CONNECTION_ADMIN或
SUPER
权限。只有他们现有的连接没有被终止，因为
SYSTEM_USER这样做需要特权。
在 MySQL 8.0.16 之前，
CONNECTION_ADMIN特权（或已弃用的SUPER
特权）足以终止任何会话或语句。
设置DEFINER存储对象的属性。
要将DEFINER存储对象的属性设置为具有权限的帐户，
除了任何其他所需的权限（或已弃用的权限）
之外SYSTEM_USER，您还必须具有该权限。SYSTEM_USERSET_USER_IDSUPER
在 MySQL 8.0.16 之前，
SET_USER_ID特权（或已弃用的SUPER特权）足以DEFINER
为存储的对象指定任何值。
指定强制角色。
具有
SYSTEM_USER特权的角色不能列在
mandatory_roles系统变量的值中。
在 MySQL 8.0.16 之前，任何角色都可以列在
mandatory_roles.
覆盖MySQL Enterprise Audit 的审计日志过滤器中的“中止”项目。
从 MySQL 8.0.28 开始，具有
SYSTEM_USER特权的帐户会自动分配
AUDIT_ABORT_EXEMPT特权，因此即使审计日志过滤器中的“中止”项会阻止它们，来自该帐户的查询也会始终执行。因此，具有特权的帐户
SYSTEM_USER可用于在审计配置错误后重新获得对系统的访问权限。请参阅
第 6.4.5 节，“MySQL 企业审计”。
系统和例会
在服务器内执行的会话被区分为系统会话或常规会话，类似于系统用户和普通用户之间的区别：
拥有
SYSTEM_USER特权的会话是系统会话。
不具备
SYSTEM_USER特权的会话是常规会话。
常规会话只能执行常规用户允许的操作。系统会话还能够执行仅允许系统用户执行的操作。
会话拥有的权限是直接授予其基础帐户的权限，以及授予会话中当前活动的所有角色的权限。因此，会话可能是系统会话，因为它的帐户已被
SYSTEM_USER直接授予权限，或者因为会话已激活具有
SYSTEM_USER权限的角色。授予会话中不活动帐户的角色不会影响会话权限。
因为激活和停用角色可以改变会话所拥有的特权，所以会话可能从常规会话变为系统会话，反之亦然。如果会话激活或停用具有
SYSTEM_USER特权的角色，则常规会话和系统会话之间的适当更改将立即发生，仅针对该会话：
如果常规会话激活具有
SYSTEM_USER特权的角色，则该会话成为系统会话。
如果系统会话停用具有
SYSTEM_USER特权的角色，则该会话将成为常规会话，除非具有SYSTEM_USER
特权的其他角色保持活动状态。
这些操作对现有会话没有影响：
如果SYSTEM_USER授予或撤销某个帐户的权限，则该帐户的现有会话不会在常规会话和系统会话之间发生变化。授予或撤销操作仅影响帐户后续连接的会话。
由在会话中调用的存储对象执行的语句以系统或父会话的常规状态执行，即使对象
DEFINER属性命名系统帐户也是如此。
由于角色激活仅影响会话而不影响帐户，因此授予
SYSTEM_USER对普通帐户具有特权的角色并不能保护该帐户免受普通用户的侵害。该角色仅保护已激活该角色的帐户的会话，并且仅保护会话不被常规会话杀死。
保护系统账户免受普通账户的操纵
帐户操纵包括创建和删除帐户、授予和撤销权限、更改帐户身份验证特征（如凭据或身份验证插件）以及更改其他帐户特征（如密码过期策略）。
帐户操纵可以通过两种方式完成：
通过使用帐户管理语句，例如
CREATE USER和
GRANT。这是首选方法。
通过使用诸如
INSERTand
之类的语句直接修改授权表UPDATE。mysql不鼓励使用此方法，但对于对包含授权表
的系统模式具有适当权限的用户来说是可行的。
要完全保护系统帐户免受给定帐户的修改，请将其设置为常规帐户并且不要授予它对mysql模式的修改权限：
使用SYSTEM_USER帐户管理语句操作系统帐户需要特权。要防止帐户以这种方式修改系统帐户，请通过不授予
SYSTEM_USER它使其成为常规帐户。这包括不授予
SYSTEM_USER授予该帐户的任何角色。
模式的权限mysql允许通过直接修改授权表来操纵系统帐户，即使修改帐户是常规帐户也是如此。要限制普通帐户对系统帐户进行​​未经授权的直接修改，请不要将
mysql模式的修改权限授予该帐户（或授予该帐户的任何角色）。如果普通帐户必须具有适用于所有模式的全局权限，
mysql则可以使用部分撤销施加的权限限制来防止模式修改。请参阅第 6.2.12 节，“使用部分撤销的权限限制”。
笔记
与
SYSTEM_USER阻止帐户修改系统帐户而不是常规帐户的保留权限不同，保留mysql模式权限可防止帐户修改系统帐户和常规帐户。这应该不是问题，因为如前所述，不鼓励直接修改授权表。
假设您要创建一个u1拥有所有模式的所有权限的用户，但该
u1用户应该是不能修改系统帐户的普通用户。假设
partial_revokes开启了系统变量，配置u1如下：
CREATE USER u1 IDENTIFIED BY 'password';
GRANT ALL ON *.* TO u1 WITH GRANT OPTION;
-- GRANT ALL includes SYSTEM_USER, so at this point
-- u1 can manipulate system or regular accounts
REVOKE SYSTEM_USER ON *.* FROM u1;
-- Revoking SYSTEM_USER makes u1 a regular user;
-- now u1 can use account-management statements
-- to manipulate only regular accounts
REVOKE ALL ON mysql.* FROM u1;
-- This partial revoke prevents u1 from directly
-- modifying grant tables to manipulate accounts
要阻止mysql帐户访问所有系统架构，请撤销其对该
mysql架构的所有特权，如刚才所示。也可以允许部分mysql模式访问，例如只读访问。以下示例创建一个帐户，该帐户对所有架构具有SELECT、
INSERT、UPDATE和
DELETE全局权限，但仅限SELECT于该
mysql架构：
CREATE USER u2 IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO u2;
REVOKE INSERT, UPDATE, DELETE ON mysql.* FROM u2;
另一种可能性是撤销所有mysql
模式权限，但授予对特定
mysql表或列的访问权限。即使对 进行部分撤销也可以做到这一点mysql。
以下语句启用对架构u1内的只读访问
，但仅适用于表和表
的列：
mysqldbHostUseruserCREATE USER u3 IDENTIFIED BY 'password';
GRANT ALL ON *.* TO u3;
REVOKE ALL ON mysql.* FROM u3;
GRANT SELECT ON mysql.db TO u3;
GRANT SELECT(Host,User) ON mysql.user TO u3;
© Mysql 中文网
