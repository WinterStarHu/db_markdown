# 6.4.4 MySQL 密钥环_MySQL 8.0 参考手册

6.4.4 MySQL 密钥环_MySQL 8.0 参考手册
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
6.4.4 MySQL 密钥环
6.4.4 MySQL 密钥环
6.4.4.1 密钥环组件与密钥环插件6.4.4.2 密钥环组件安装6.4.4.3 密钥环插件安装6.4.4.4 使用 component_keyring_file 基于文件的密钥环组件6.4.4.5 使用 component_keyring_encrypted_file 加密文件密钥环组件6.4.4.6 使用 keyring_file 基于文件的密钥环插件6.4.4.7 使用 keyring_encrypted_file 加密文件密钥环插件6.4.4.8 使用 keyring_okv KMIP 插件6.4.4.9 使用 keyring_aws 亚马逊网络服务密钥环插件6.4.4.10 使用 HashiCorp Vault 密钥环插件6.4.4.11 使用 Oracle Cloud Infrastructure Vault 密钥环组件6.4.4.12 使用 Oracle Cloud Infrastructure Vault Keyring 插件6.4.4.13 支持的密钥环密钥类型和长度6.4.4.14 在密钥环密钥库之间迁移密钥6.4.4.15 通用密钥环密钥管理函数6.4.4.16 插件特定的密钥环密钥管理函数6.4.4.17 密钥环元数据6.4.4.18 密钥环命令选项6.4.4.19 密钥环系统变量
MySQL 服务器支持密钥环，使内部服务器组件和插件能够安全地存储敏感信息以供以后检索。实施包括以下要素：
管理后备存储或与存储后端通信的密钥环组件和插件。密钥环的使用涉及从可用组件和插件中安装一个。密钥环组件和插件都管理密钥环数据，但配置不同并且可能具有操作差异（请参阅
第 6.4.4.1 节，“密钥环组件与密钥环插件”）。
这些密钥环组件可用：
component_keyring_file：将密钥环数据存储在服务器主机的本地文件中。从 MySQL 8.0.24 开始，在 MySQL Community Edition 和 MySQL Enterprise Edition 发行版中可用。请参阅
第 6.4.4.4 节，“使用 component_keyring_file 基于文件的密钥环组件”。
component_keyring_encrypted_file：将密钥环数据存储在服务器主机本地的加密、受密码保护的文件中。从 MySQL 8.0.24 开始，在 MySQL Enterprise Edition 发行版中可用。请参阅
第 6.4.4.5 节，“使用 component_keyring_encrypted_file 加密的基于文件的密钥环组件”。
component_keyring_oci：将密钥环数据存储在 Oracle Cloud Infrastructure Vault 中。从 MySQL 8.0.31 开始，在 MySQL Enterprise Edition 发行版中可用。请参阅
第 6.4.4.11 节，“使用 Oracle Cloud Infrastructure Vault 密钥环组件”。
这些密钥环插件可用：
keyring_file：将密钥环数据存储在服务器主机的本地文件中。在 MySQL Community Edition 和 MySQL Enterprise Edition 发行版中可用。请参阅
第 6.4.4.6 节，“使用 keyring_file 基于文件的密钥环插件”。
keyring_encrypted_file：将密钥环数据存储在服务器主机本地的加密、受密码保护的文件中。在 MySQL 企业版发行版中可用。请参阅
第 6.4.4.7 节，“使用 keyring_encrypted_file 加密的基于文件的密钥环插件”。
keyring_okv：KMIP 1.1 插件，用于与 KMIP 兼容的后端密钥环存储产品，例如 Oracle Key Vault 和 Gemalto SafeNet KeySecure Appliance。在 MySQL 企业版发行版中可用。请参阅
第 6.4.4.8 节，“使用 keyring_okv KMIP 插件”。
keyring_aws：与 Amazon Web Services Key Management Service 通信以生成密钥，并使用本地文件存储密钥。在 MySQL 企业版发行版中可用。请参阅
第 6.4.4.9 节，“使用 keyring_aws Amazon Web Services 密钥环插件”。
keyring_hashicorp：与 HashiCorp Vault 通信以进行后端存储。从 MySQL 8.0.18 开始，在 MySQL Enterprise Edition 发行版中可用。请参阅
第 6.4.4.10 节，“使用 HashiCorp Vault Keyring 插件”。
keyring_oci：与后端存储的 Oracle Cloud Infrastructure Vault 通信。从 MySQL 8.0.22 开始，在 MySQL Enterprise Edition 发行版中可用。请参阅
第 6.4.4.12 节，“使用 Oracle Cloud Infrastructure Vault 密钥环插件”。
用于密钥环密钥管理的密钥环服务接口。此服务可在两个级别访问：
SQL 接口：在 SQL 语句中，调用
第 6.4.4.15 节“通用密钥环密钥管理函数”中描述的函数。
C 接口：在 C 语言代码中，调用第 5.6.9.2 节“密钥环服务”中描述的密钥环服务函数。
关键元数据访问：
Performance Schema
keyring_keys表公开密钥环中密钥的元数据。密钥元数据包括密钥 ID、密钥所有者和后端密钥 ID。该
keyring_keys表不会公开任何敏感的密钥环数据，例如密钥内容。从 MySQL 8.0.16 开始可用。请参阅
第 27.12.18.2 节，“keyring_keys 表”。
Performance Schema
keyring_component_status
表提供有关正在使用的密钥环组件的状态信息（如果已安装）。从 MySQL 8.0.24 开始可用。请参阅
第 27.12.18.1 节，“keyring_component_status 表”。
一个关键的迁移能力。MySQL 支持密钥库之间的密钥迁移，使 DBA 能够将 MySQL 安装从一个密钥库切换到另一个。请参阅
第 6.4.4.14 节，“在密钥环密钥库之间迁移密钥”。
从 MySQL 8.0.24 开始，密钥环插件的实现被修改为使用组件基础设施。这可以使用名为的内置插件来促进，该插件
daemon_keyring_proxy_plugin充当插件和组件服务 API 之间的桥梁。请参阅
第 5.6.8 节，“Keyring 代理桥插件”。
警告
对于加密密钥管理，
component_keyring_file和
component_keyring_encrypted_file组件以及 和keyring_file和
keyring_encrypted_file插件并非旨在作为法规遵从性解决方案。PCI、FIPS 等安全标准要求使用密钥管理系统来保护、管理和保护密钥库或硬件安全模块 (HSM) 中的加密密钥。
在 MySQL 中，密钥环服务消费者包括：
InnoDB存储引擎使用密钥环来存储其用于表空间加密的密钥
。请参阅
第 15.13 节，“InnoDB 静态数据加密”。
MySQL Enterprise Audit 使用密钥环来存储审计日志文件加密密码。请参阅
加密审计日志文件。
二进制日志和中继日志管理支持基于密钥环的日志文件加密。激活日志文件加密后，密钥环存储用于加密二进制日志文件和中继日志文件密码的密钥。请参阅
第 17.3.2 节，“加密二进制日志文件和中继日志文件”。
解密敏感系统变量的持久值的文件密钥的主密钥存储在密钥环中。必须在 MySQL Server 实例上启用密钥环组件以支持持久化系统变量值的安全存储，而不是不支持该功能的密钥环插件。请参阅
保留敏感系统变量。
有关一般密钥环安装说明，请参阅
第 6.4.4.2 节，“密钥环组件安装”和
第 6.4.4.3 节，“密钥环插件安装”。有关特定于给定密钥环组件或插件的安装和配置信息，请参阅描述它的部分。
有关使用密钥环功能的信息，请参阅
第 6.4.4.15 节，“通用密钥环密钥管理功能”。
密钥环组件、插件和函数访问提供密钥环接口的密钥环服务。有关访问此服务和编写密钥环插件的信息，请参阅第 5.6.9.2 节，“密钥环服务”和
编写密钥环插件。
© Mysql 中文网
