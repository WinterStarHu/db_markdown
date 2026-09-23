# 6.4.3 密码验证组件_MySQL 8.0 参考手册

6.4.3 密码验证组件_MySQL 8.0 参考手册
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
6.3 使用加密连接
6.4 安全组件和插件
6.4.1 认证插件1
6.4.2 连接控制插件1
6.4.3 密码验证组件1
6.4.3.1 密码验证组件安装和卸载
6.4.3.2 密码验证选项和变量
6.4.3.3 过渡到密码验证组件
6.4.4 MySQL 密钥环1
6.4.5 MySQL企业审计1
6.4.6 审计消息组件1
6.4.7 MySQL 企业防火墙1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.4 安全组件和插件  /
6.4.3 密码验证组件
6.4.3 密码验证组件
6.4.3.1 密码验证组件安装和卸载6.4.3.2 密码验证选项和变量6.4.3.3 过渡到密码验证组件
该validate_password组件通过要求帐户密码和启用潜在密码的强度测试来提高安全性。该组件公开了使您能够配置密码策略的系统变量，以及用于组件监控的状态变量。
笔记
在 MySQL 8.0 中，
validate_password插件被重新实现为validate_password组件。（有关组件的一般信息，请参阅第 5.5 节，“MySQL 组件”。）以下说明描述了如何使用组件，而不是插件。有关使用插件形式的说明
validate_password，请参阅
MySQL 5.7 参考手册中
的密码验证插件。
的插件形式validate_password仍然可用，但已弃用；希望在未来的 MySQL 版本中将其删除。使用该插件的 MySQL 安装应该改为使用该组件。请参阅
第 6.4.3.3 节，“转换到密码验证组件”。
该validate_password组件实现了这些功能：
对于分配作为明文值提供的密码的 SQL 语句，validate_password根据当前密码策略检查密码，如果密码较弱（语句返回
ER_NOT_VALID_PASSWORD错误）则拒绝该密码。这适用于ALTER USER、
CREATE USER和
SET PASSWORD语句。
对于CREATE USER语句，
validate_password要求提供密码，并且它满足密码策略。即使帐户最初被锁定也是如此，否则稍后解锁帐户将导致无需满足策略的密码即可访问该帐户。
validate_password实现
VALIDATE_PASSWORD_STRENGTH()
评估潜在密码强度的 SQL 函数。此函数接受一个密码参数并返回一个从 0（弱）到 100（强）的整数。
笔记
对于分配或修改帐户密码（ 、 和 ）的语句，ALTER USER此处
CREATE USER描述
SET PASSWORD的
validate_password功能仅适用于使用在 MySQL 内部存储凭据的身份验证插件的帐户。对于使用针对 MySQL 外部凭证系统执行身份验证的插件的帐户，密码管理也必须针对该系统在外部进行处理。有关内部凭证存储的更多信息，请参阅
第 6.2.15 节，“密码管理”。
上述限制不适用于该
VALIDATE_PASSWORD_STRENGTH()
功能的使用，因为它不直接影响帐户。
例子：
validate_password检查以下语句中的明文密码。在要求密码长度至少为 8 个字符的默认密码策略下，密码很弱，语句会产生错误：
mysql> ALTER USER USER() IDENTIFIED BY 'abc';
ERROR 1819 (HY000): Your password does not satisfy the current
policy requirements
不检查指定为散列值的密码，因为原始密码值不可用于检查：
mysql> ALTER USER 'jeffrey'@'localhost'
IDENTIFIED WITH mysql_native_password
AS '*0D3CED9BEC10A777AEC23CCC353A8C08A633045E';
Query OK, 0 rows affected (0.01 sec)
此帐户创建语句失败，即使帐户最初被锁定，因为它不包含满足当前密码策略的密码：
mysql> CREATE USER 'juanita'@'localhost' ACCOUNT LOCK;
ERROR 1819 (HY000): Your password does not satisfy the current
policy requirements
要检查密码，请使用以下
VALIDATE_PASSWORD_STRENGTH()
函数：
mysql> SELECT VALIDATE_PASSWORD_STRENGTH('weak');
+------------------------------------+
| VALIDATE_PASSWORD_STRENGTH('weak') |
+------------------------------------+
|                                 25 |
+------------------------------------+
mysql> SELECT VALIDATE_PASSWORD_STRENGTH('lessweak$_@123');
+----------------------------------------------+
| VALIDATE_PASSWORD_STRENGTH('lessweak$_@123') |
+----------------------------------------------+
|                                           50 |
+----------------------------------------------+
mysql> SELECT VALIDATE_PASSWORD_STRENGTH('N0Tweak$_@123!');
+----------------------------------------------+
| VALIDATE_PASSWORD_STRENGTH('N0Tweak$_@123!') |
+----------------------------------------------+
|                                          100 |
+----------------------------------------------+
要配置密码检查，请修改具有以下形式名称的系统变量
；这些是控制密码策略的参数。请参阅
第 6.4.3.2 节，“密码验证选项和变量”。
validate_password.xxx
如果validate_password未安装，则
系统变量不可用，不检查语句中的密码，
函数始终返回 0。例如，在未安装插件的情况下，可以为帐户分配少于 8 个字符的密码，或者根本没有密码。
validate_password.xxxVALIDATE_PASSWORD_STRENGTH()
假设validate_password已安装，它会执行三个级别的密码检查：
LOW、MEDIUM和
STRONG。默认是
MEDIUM; 要更改此设置，请修改 的值
validate_password.policy。这些政策实施越来越严格的密码测试。以下描述均参考默认参数值，可以通过更改相应的系统变量来修改这些值。
LOW策略仅测试密码长度。密码长度必须至少为 8 个字符。要更改此长度，请修改
validate_password.length.
MEDIUM策略添加了密码必须包含至少 1 个数字字符、1 个小写字符、1 个大写字符和 1 个特殊（非字母数字）字符的条件。要更改这些值，请修改
validate_password.number_count、
validate_password.mixed_case_count和
validate_password.special_char_count。
STRONG策略添加了一个条件，即长度为 4 或更长的密码子字符串不得与字典文件中的单词匹配（如果已指定的话）。要指定字典文件，请修改
validate_password.dictionary_file.
此外，validate_password支持拒绝与当前会话的有效用户帐户的用户名部分匹配的密码的功能，正向或反向。为了提供对此功能的控制，
validate_password公开了一个
validate_password.check_user_name
默认启用的系统变量。
© Mysql 中文网
