# 6.2.14 分配账户密码_MySQL 8.0 参考手册

6.2.14 分配账户密码_MySQL 8.0 参考手册
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
6.2.14 分配账户密码
6.2.14 分配账户密码
连接到 MySQL 服务器的客户端所需的凭据可以包括密码。本节介绍如何为 MySQL 帐户分配密码。
MySQL 将凭据存储在系统数据库的user表中。mysql分配或修改密码的操作仅允许具有
CREATE USER特权或mysql
数据库INSERT特权（创建新帐户的UPDATE
特权，修改现有帐户的特权）的用户使用。如果
read_only启用了系统变量，则使用诸如
CREATE USER或
之类的帐户修改语句ALTER USER还需要CONNECTION_ADMIN特权（或已弃用的SUPER特权）。
此处的讨论仅总结了最常见的密码分配语句的语法。有关其他可能性的完整详细信息，请参阅第 13.7.1.3 节，“CREATE USER 语句”，
第 13.7.1.1 节，“ALTER USER 语句”和第 13.7.1.10 节，“SET PASSWORD 语句”。
MySQL 使用插件来执行客户端身份验证；请参阅
第 6.2.17 节，“可插入身份验证”。在密码分配语句中，与帐户关联的身份验证插件执行指定的明文密码所需的任何散列。这使 MySQL 能够在将密码存储到mysql.user系统表之前混淆密码。对于此处描述的语句，MySQL 会自动散列指定的密码。还有用于CREATE
USER和ALTER USER允许按字面指定散列值的语法。有关详细信息，请参阅这些语句的描述。
要在创建新帐户时分配密码，请使用
CREATE USER并包含一个
IDENTIFIED BY子句：
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';
CREATE USER还支持指定帐户身份验证插件的语法。请参阅
第 13.7.1.3 节，“CREATE USER 语句”。
要为现有帐户分配或更改密码，请使用
ALTER USER带
IDENTIFIED BY子句的语句：
ALTER USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';
如果您没有以匿名用户身份连接，您可以更改自己的密码而无需按字面命名您自己的帐户：
ALTER USER USER() IDENTIFIED BY 'password';
要从命令行更改帐户密码，请使用
mysqladmin命令：
mysqladmin -u user_name -h host_name password "password"
此命令为其设置密码的帐户是mysql.user系统表中的行与列中user_name的
行和列中您连接的User客户端主机相匹配的帐户
。
Host
警告
使用mysqladmin
设置密码应该被认为是不安全的。在某些系统上，您的密码对系统状态程序（例如
ps ）可见，其他用户可能会调用这些程序来显示命令行。MySQL 客户端通常在初始化序列期间用零覆盖命令行密码参数。但是，仍然有一个短暂的时间间隔，在此期间该值是可见的。此外，在某些系统上，这种覆盖策略是无效的，密码对ps仍然可见。（SystemV Unix 系统和其他系统可能会遇到这个问题。）
如果您正在使用 MySQL 复制，请注意，目前，副本作为
CHANGE REPLICATION SOURCE TO
语句（从 MySQL 8.0.23 开始）或CHANGE
MASTER TO语句（MySQL 8.0.23 之前）的一部分使用的密码的长度实际上限制为 32 个字符；如果密码较长，则会截断任何多余的字符。这不是由于 MySQL 服务器通常强加的任何限制，而是 MySQL 复制特有的问题。
© Mysql 中文网
