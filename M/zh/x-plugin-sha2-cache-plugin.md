# 20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用_MySQL 8.0 参考手册

20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
20.5.1 检查 X 插件安装1
20.5.2 禁用 X 插件1
20.5.3 使用 X 插件的加密连接1
20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用1
20.5.5 使用 X 插件进行连接压缩1
20.5.6 X 插件选项和变量1
20.5.7 监控 X 插件1
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.5 X 插件  /
20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用
20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用
X Plugin 支持使用
caching_sha2_password身份验证插件创建的 MySQL 用户帐户。有关此插件的更多信息，请参阅
第 6.4.1.2 节，“缓存 SHA-2 可插入身份验证”。您可以使用 X Plugin 对此类帐户进行身份验证，使用带身份验证的非 SSL 连接和带SHA256_MEMORY身份验证的 SSL 连接PLAIN。
虽然caching_sha2_password
认证插件持有一个认证缓存，但是这个缓存不与X Plugin共享，所以X Plugin使用自己的认证缓存进行SHA256_MEMORY
认证。X 插件身份验证缓存存储用户帐户密码的哈希值，无法使用 SQL 访问。如果用户帐户被修改或删除，相关条目将从缓存中删除。X Plugin认证缓存由mysqlx_cache_cleaner插件维护，默认开启，没有相关的系统变量和状态变量。
在您可以使用非 SSL X 协议连接对使用caching_sha2_password
身份验证插件的帐户进行身份验证之前，该帐户必须至少通过使用 SSL 的 X 协议连接进行身份验证一次，以向 X 插件身份验证缓存提供密码。一旦通过 SSL 的初始身份验证成功，就可以使用非 SSL X 协议连接。
可以通过使用选项启动 MySQL 服务器来禁用
mysqlx_cache_cleaner插件
--mysqlx_cache_cleaner=0。如果这样做，X 插件身份验证缓存将被禁用，因此在使用身份验证进行SHA256_MEMORY身份验证时，必须始终将 SSL 用于 X 协议连接。
© Mysql 中文网
