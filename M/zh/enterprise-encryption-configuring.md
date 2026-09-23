# 6.6.2 配置MySQL企业加密_MySQL 8.0 参考手册

6.6.2 配置MySQL企业加密_MySQL 8.0 参考手册
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
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.6.1 MySQL企业加密安装升级1
6.6.2 配置MySQL企业加密1
6.6.3 MySQL 企业加密使用和示例1
6.6.4 MySQL企业加密函数参考1
6.6.5 MySQL企业加密组件功能说明1
6.6.6 MySQL企业加密遗留功能说明1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.6 MySQL企业加密  /
6.6.2 配置MySQL企业加密
6.6.2 配置MySQL企业加密
MySQL Enterprise Encryption 允许您将密钥的长度限制在为您的需求提供足够安全性的同时平衡这与资源使用。您还可以配置
component_enterprise_encryptionMySQL 8.0.30组件提供的功能，支持对遗留openssl_udf共享库功能产生的内容进行解密和验证。
组件函数对遗留函数的解密支持
默认情况下，
component_enterprise_encryptionMySQL 8.0.30 中的组件提供的功能不会解密加密文本或验证签名，这些功能是由openssl_udf共享库在早期版本中提供的遗留功能生成的。组件函数假定加密文本使用 RSAES-OAEP 填充方案，签名使用 RSASSA-PSS 签名方案。但是，遗留函数生成的加密文本使用 RSAES-PKCS1-v1_5 填充方案，遗留函数生成的签名使用 RSASSA-PKCS1-v1_5 签名方案。
如果希望组件函数支持MySQL 8.0.30之前遗留函数产生的内容，将组件的系统变量设置
enterprise_encryption.rsa_support_legacy_padding
为ON. 系统变量在安装组件时可用。当你将它设置为
ON，组件功能首先尝试解密或验证内容，假设它有它们的正常方案。如果这不起作用，他们还会尝试解密或验证内容，假设它具有遗留功能使用的方案。此行为不是默认行为，因为它会增加处理根本无法解密或验证的内容所花费的时间。如果您不处理遗留函数生成的内容，请将系统变量保留为默认值
OFF。
密钥长度限制
MySQL Enterprise Encryption 的密钥生成功能所需的 CPU 资源量随着密钥长度的增加而增加。对于某些安装，如果应用程序频繁生成过长的密钥，这可能会导致不可接受的 CPU 使用率。
OpenSSL 为所有密钥指定了 1024 位的最小密钥长度。OpenSSL 还指定 RSA 密钥的最大密钥长度为 16384 位，DSA 密钥为 10000 位，DH 密钥为 10000 位。
从 MySQL 8.0.30 开始，该
component_enterprise_encryption组件提供的函数对 RSA 密钥的最小密钥长度提高了 2048 位，符合当前最小密钥长度的最佳实践。组件的系统变量
enterprise_encryption.maximum_rsa_key_size
指定最大密钥大小，默认为 4096 位。您可以更改此设置以允许密钥达到 OpenSSL 允许的最大长度，即 16384 位。
对于 MySQL 8.0.30 之前的版本，openssl_udf共享库提供的遗留功能默认为 OpenSSL 的最小和最大限制。如果最大值太高，您可以使用以下系统变量指定一个较低的最大密钥长度：
MYSQL_OPENSSL_UDF_DSA_BITS_THRESHOLD: 的最大 DSA 密钥长度（以位为单位）
create_asymmetric_priv_key()。此变量的最小值和最大值为 1024 和 10000。
MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD: 的最大 RSA 密钥长度（以位为单位）
create_asymmetric_priv_key()。此变量的最小值和最大值为 1024 和 16384。
MYSQL_OPENSSL_UDF_DH_BITS_THRESHOLD: 的最大密钥长度（以位为单位）
create_dh_parameters()。此变量的最小值和最大值为 1024 和 10000。
要使用这些环境变量中的任何一个，请在启动服务器的进程的环境中设置它们。如果设置，它们的值优先于 OpenSSL 强加的最大密钥长度。例如，要将 的 DSA 和 RSA 密钥的最大密钥长度设置为 4096 位
create_asymmetric_priv_key()，请设置以下变量：
export MYSQL_OPENSSL_UDF_DSA_BITS_THRESHOLD=4096
export MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD=4096
该示例使用 Bourne shell 语法。其他 shell 的语法可能不同。
© Mysql 中文网
