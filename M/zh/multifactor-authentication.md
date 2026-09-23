# 6.2.18 多因素认证_MySQL 8.0 参考手册

6.2.18 多因素认证_MySQL 8.0 参考手册
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
6.2.18 多因素认证
6.2.18 多因素认证
身份验证涉及一方建立其身份以使另一方满意。多因素身份验证 (MFA) 是在
身份验证过程中使用多个身份验证值（或“因素” ）。MFA 提供比单因素/单因素身份验证 (1FA/SFA) 更高的安全性，后者仅使用一种身份验证方法，例如密码。MFA 启用其他身份验证方法，例如使用多个密码进行身份验证，或使用智能卡、安全密钥和生物识别读取器等设备进行身份验证。
MySQL 8.0.27 及更高版本包括对多因素身份验证的支持。此功能包括最多需要三个身份验证值的 MFA 形式。也就是说，除了现有的 1FA 支持外，MySQL 账户管理还支持使用 2FA 或 3FA 的账户。
当客户端尝试使用单因素帐户连接到 MySQL 服务器时，服务器会调用帐户定义指示的身份验证插件，并根据插件报告成功还是失败来接受或拒绝连接。
对于具有多个身份验证因素的帐户，过程类似。服务器按照帐户定义中列出的顺序调用身份验证插件。如果插件报告成功，如果插件是最后一个，服务器将接受连接，或者继续调用下一个插件（如果还有）。如果任何插件报告失败，服务器将拒绝连接。
以下部分更详细地介绍了 MySQL 中的多因素身份验证。
多因素身份验证支持的元素配置多重身份验证策略多因素身份验证入门
多因素身份验证支持的元素
身份验证因素通常包括以下类型的信息：
你知道的东西，例如秘密密码或密码。
您拥有的东西，例如安全密钥或智能卡。
你是什​​么；也就是说，生物特征，例如指纹或面部扫描。
“你知道
的事情”因素类型依赖于在身份验证过程的双方都保密的信息。不幸的是，秘密可能会受到损害：有人可能会看到您输入密码或通过网络钓鱼攻击来欺骗您，存储在服务器端的密码可能会因安全漏洞而暴露，等等。可以通过使用多个密码来提高安全性，但每个密码仍可能受到威胁。使用其他因素类型可以提高安全性，同时降低泄露风险。
MySQL 中多因素身份验证的实现包括以下元素：
系统authentication_policy
变量控制可以使用多少身份验证因素以及每个因素允许的身份验证类型。也就是说，它对多因素身份验证施加了约束
CREATE USER和
ALTER USER声明。
CREATE USER并
ALTER USER具有允许为新帐户指定多种身份验证方法以及为现有帐户添加、修改或删除身份验证方法的语法。如果帐户使用 2FA 或 3FA，mysql.user系统表会在列中存储有关其他身份验证因素的信息User_attributes。
要使用需要多个密码的帐户启用对 MySQL 服务器的身份验证，客户端程序具有
--password1、
--password2和
--password3选项，允许最多指定三个密码。对于使用 C API 的应用程序，C API 函数的
MYSQL_OPT_USER_PASSWORD选项
mysql_options4()启用相同的功能。
服务器端authentication_fido
插件启用使用设备的身份验证。此服务器端 FIDO 身份验证插件仅包含在 MySQL 企业版发行版中。它不包含在 MySQL 社区发行版中。但是，客户端
authentication_fido_client插件包含在所有发行版中，包括社区发行版。这使来自任何发行版的客户端都可以连接到用于
authentication_fido在加载了该插件的服务器上进行身份验证的帐户。请参阅
第 6.4.1.11 节，“FIDO 可插入身份验证”。
authentication_fido如果它是帐户使用的唯一身份验证插件，还可以启用无密码身份验证。请参阅
FIDO 无密码身份验证。
多因素身份验证可以使用非 FIDO MySQL 身份验证方法、FIDO 身份验证方法或两者的组合。
这些权限使用户能够执行某些受限的多因素身份验证相关操作：
拥有
AUTHENTICATION_POLICY_ADMIN
特权的用户不受
authentication_policy
系统变量强加的约束。（对于否则不允许的语句，确实会出现警告。）
该
PASSWORDLESS_USER_ADMIN
特权允许创建无密码身份验证帐户并复制对它们的操作。
配置多重身份验证策略
系统authentication_policy
变量定义多因素身份验证策略。具体来说，它定义了帐户可能具有（或需要具有）多少个身份验证因素以及可用于每个因素的身份验证方法。
的值
authentication_policy是 1、2 或 3 个逗号分隔元素的列表。列表中的每个元素对应一个身份验证因素，可以是身份验证插件名称、星号 ( *)、空或缺失。（例外：元素 1 不能为空或缺失。）整个列表用单引号括起来。例如，以下
authentication_policy值包括一个星号、一个身份验证插件名称和一个空元素：
authentication_policy = '*,authentication_fido,'
星号 ( *) 表示需要一种身份验证方法，但允许使用任何方法。空元素表示身份验证方法是可选的，并且允许使用任何方法。缺少元素（没有星号、空元素或身份验证插件名称）表示不允许使用身份验证方法。指定插件名称后，在创建或修改帐户时，相应因素需要使用该身份验证方法。
默认
authentication_policy值为
'*,,'（一个星号和两个空元素），它需要第一个因素，并且可以选择允许第二个和第三个因素。因此，默认
authentication_policy值向后兼容现有的 1FA 帐户，但也允许创建或修改帐户以使用 2FA 或 3FA。
拥有
AUTHENTICATION_POLICY_ADMIN
特权的用户不受
authentication_policy设置强加的约束。（对于否则不允许的语句会出现警告。）
authentication_policy值可以在选项文件中定义或使用
SET
GLOBAL语句指定：
SET GLOBAL authentication_policy='*,*,';
有几个规则可以控制如何
authentication_policy定义值。有关这些规则的完整说明，请参阅
authentication_policy系统变量描述。下表提供了几个
authentication_policy示例值和每个值建立的策略。
表 6.11 authentication_policy 值示例
authentication_policy 值
有效政策
'*'
只允许创建或更改具有一个因素的帐户。
'*,*'
仅允许创建或更改具有两个因素的帐户。
'*,*,*'
仅允许创建或更改具有三个因素的帐户。
'*,'
允许使用一个或两个因素创建或更改帐户。
'*,,'
允许创建或更改具有一个、两个或三个因素的帐户。
'*,*,'
允许创建或更改具有两个或三个因素的帐户。
'*,auth_plugin'
允许使用两个因素创建或更改帐户，其中第一个因素可以是任何身份验证方法，第二个因素必须是指定的插件。
'auth_plugin,*,'
允许创建或更改具有两个或三个因素的帐户，其中第一个因素必须是指定的插件。
'auth_plugin,'
允许使用一个或两个因素创建或更改帐户，其中第一个因素必须是指定的插件。
'auth_plugin,auth_plugin,auth_plugin'
允许创建或更改具有三个因素的帐户，其中因素必须使用指定的插件。
多因素身份验证入门
默认情况下，MySQL 使用多因素身份验证策略，允许任何身份验证插件用于第一个因素，并可选择允许第二个和第三个身份验证因素。该策略是可配置的；有关详细信息，请参阅
配置多因素身份验证策略。
假设您希望帐户首先使用
caching_sha2_password插件进行身份验证，然后使用
authentication_ldap_saslSASL LDAP 插件。（这假定 LDAP 身份验证已经按照第 6.4.1.7 节“LDAP 可插入身份验证”中的描述进行了设置，并且用户在 LDAP 目录中有一个条目对应于示例中显示的身份验证字符串。）使用创建帐户像这样的声明：
CREATE USER 'alice'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'sha2_password'
AND IDENTIFIED WITH authentication_ldap_sasl
AS 'uid=u1_ldap,ou=People,dc=example,dc=com';
要连接，用户必须提供两个密码。要使用需要多个密码的帐户启用对 MySQL 服务器的身份验证，客户端程序具有
--password1、
--password2和
--password3选项，允许最多指定三个密码。这些选项类似于--password选项，因为它们可以在命令行上的选项之后采用密码值（这是不安全的），或者如果在没有密码值的情况下给出，则会提示用户输入密码值。对于刚刚创建的帐户，因素 1 和 2 需要密码，因此
使用和
选项
调用mysql客户端
。数据库--password1--password2将依次提示输入每个密码：
$> mysql --user=alice --password1 --password2
Enter password: (enter factor 1 password)
Enter password: (enter factor 2 password)
假设您要添加第三个身份验证因素。这可以通过使用第三个因素或使用
语法删除并重新创建用户来实现。两种方法如下所示：
ALTER USER
user ADD
factorDROP USER 'alice'@'localhost';
CREATE USER 'alice'@'localhost'
IDENTIFIED WITH caching_sha2_password
BY 'sha2_password'
AND IDENTIFIED WITH authentication_ldap_sasl
AS 'uid=u1_ldap,ou=People,dc=example,dc=com'
AND IDENTIFIED WITH authentication_fido;
ADD factor语法包括因子编号和FACTOR
关键字：
ALTER USER 'alice'@'localhost' ADD 3 FACTOR IDENTIFIED WITH authentication_fido;
ALTER USER
user DROP
factor语法允许删除一个因素。以下示例删除了authentication_fido上一示例中添加的第三个因素 ( )：
ALTER USER 'alice'@'localhost' DROP 3 FACTOR;
ALTER USER
user MODIFY
factor语法允许更改特定因素的插件或身份验证字符串，前提是该因素存在。以下示例修改了第二个因素，将身份验证方法从更改authentication_ldap_sasl为
authetication_fido：
ALTER USER 'alice'@'localhost' MODIFY 2 FACTOR IDENTIFIED WITH authentication_fido;
用于SHOW CREATE USER查看为帐户定义的身份验证方法：
SHOW CREATE USER 'u1'@'localhost'\G
*************************** 1. row ***************************
CREATE USER for u1@localhost: CREATE USER `u1`@`localhost`
IDENTIFIED WITH 'caching_sha2_password' AS 'sha2_password'
AND IDENTIFIED WITH 'authentication_fido' REQUIRE NONE
PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK PASSWORD HISTORY
DEFAULT PASSWORD REUSE INTERVAL DEFAULT PASSWORD REQUIRE
CURRENT DEFAULT
© Mysql 中文网
