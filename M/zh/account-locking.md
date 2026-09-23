# 6.2.20 账户锁定_MySQL 8.0 参考手册

6.2.20 账户锁定_MySQL 8.0 参考手册
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
6.2.20 账户锁定
6.2.20 账户锁定
ACCOUNT LOCKMySQL 支持使用andACCOUNT
UNLOCK子句为CREATE
USERand语句
锁定和解锁用户帐户
ALTER USER
：
与 一起使用时CREATE USER，这些子句指定新帐户的初始锁定状态。在没有任何一个条款的情况下，帐户将以解锁状态创建。
如果validate_password启用该组件，则不允许创建没有密码的帐户，即使该帐户已锁定。请参阅
第 6.4.3 节，“密码验证组件”。
与 一起使用时ALTER USER，这些子句指定现有帐户的新锁定状态。在没有任何一个条款的情况下，帐户锁定状态保持不变。
从 MySQL 8.0.19 开始，
ALTER USER ...
UNLOCK解锁由于登录失败次数过多而暂时锁定的语句命名的任何帐户。请参阅
第 6.2.15 节，“密码管理”。
帐户锁定状态记录在
系统表的account_locked列中
。mysql.user来自的输出
SHOW CREATE USER指示帐户是被锁定还是解锁。
如果客户端尝试连接到锁定的帐户，则尝试失败。服务器递增
Locked_connects指示连接到锁定帐户的尝试次数的状态变量，返回
ER_ACCOUNT_HAS_BEEN_LOCKED错误，并将消息写入错误日志：
Access denied for user 'user_name'@'host_name'.
Account is locked.
锁定帐户不会影响使用假定锁定帐户身份的代理用户进行连接的能力。它也不影响执行具有DEFINER命名锁定帐户属性的存储程序或视图的能力。也就是说，使用代理帐户或存储的程序或视图的能力不受锁定帐户的影响。
帐户锁定功能取决于
系统表中account_locked列
的存在。mysql.user对于从早于 5.7.6 的 MySQL 版本升级，执行 MySQL 升级过程以确保此列存在。请参阅
第 2.11 节，“升级 MySQL”。对于没有account_locked列的未升级安装，服务器将所有帐户视为未锁定，使用ACCOUNT
LOCKorACCOUNT UNLOCK子句会产生错误。
© Mysql 中文网
