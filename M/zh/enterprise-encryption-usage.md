# 6.6.3 MySQL 企业加密使用和示例_MySQL 8.0 参考手册

6.6.3 MySQL 企业加密使用和示例_MySQL 8.0 参考手册
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
6.6.3 MySQL 企业加密使用和示例
6.6.3 MySQL 企业加密使用和示例
要在应用程序中使用 MySQL Enterprise Encryption，请调用适合您希望执行的操作的函数。本节演示如何执行一些代表性任务。
在 MySQL 8.0.30 之前的版本中，MySQL Enterprise Encryption 的功能基于openssl_udf共享库。从 MySQL 8.0.30 开始，这些功能由 MySQL 组件提供
component_enterprise_encryption。在某些情况下，组件函数的行为不同于
openssl_udf. 有关差异的列表，请参阅
升级 MySQL Enterprise Encryption。有关每个组件函数行为的完整详细信息，请参阅
第 6.6.4 节，“MySQL 企业加密函数参考”。
如果您安装遗留功能然后升级到 MySQL 8.0.30 或更高版本，您创建的功能仍然可用，受支持，并继续以相同的方式工作。但是，它们已从 MySQL 8.0.30 中弃用，建议您
component_enterprise_encryption改为安装 MySQL Enterprise Encryption 组件。有关升级说明，请参阅
从 MySQL 8.0.30 安装。
选择密钥长度和加密算法时，需要考虑以下一般注意事项：
私钥和公钥的加密强度随着密钥大小的增加而增加，但密钥生成的时间也会增加。
对于遗留功能，DH 密钥的生成比 RSA 或 DSA 密钥花费的时间长得多。MySQL 8.0.30 的组件函数仅支持 RSA 密钥。
与对称函数相比，非对称加密函数消耗更多资源。它们适用于加密少量数据以及创建和验证签名。对于加密大量数据，对称加密函数速度更快。MySQL Server 提供对称加密的
AES_ENCRYPT()和
AES_DECRYPT()函数。
键字符串值可以在运行时创建，并使用
SET、
SELECT或
存储到变量或表中INSERT。此示例适用于组件函数和遗留函数：
SET @priv1 = create_asymmetric_priv_key('RSA', 2048);
SELECT create_asymmetric_priv_key('RSA', 2048) INTO @priv2;
INSERT INTO t (key_col) VALUES(create_asymmetric_priv_key('RSA', 1024));具有权限的用户
可以使用该
LOAD_FILE()函数读取存储在文件中的关键字符串值。FILE可以类似地处理摘要和签名字符串。
创建私钥/公钥对使用私钥加密数据，使用公钥解密数据从字符串生成摘要使用带有密钥对的摘要
创建私钥/公钥对
此示例适用于组件函数和遗留函数：
-- Encryption algorithm
SET @algo = 'RSA';
-- Key length in bits; make larger for stronger keys
SET @key_len = 2048;
-- Create private key
SET @priv = create_asymmetric_priv_key(@algo, @key_len);
-- Derive corresponding public key from private key, using same algorithm
SET @pub = create_asymmetric_pub_key(@algo, @priv);
您可以使用密钥对对数据进行加密和解密，或者对数据进行签名和验证。
使用私钥加密数据，使用公钥解密数据
此示例适用于组件功能和遗留功能。在这两种情况下，密钥对的成员都必须是 RSA 密钥：
SET @ciphertext = asymmetric_encrypt(@algo, 'My secret text', @priv);
SET @plaintext = asymmetric_decrypt(@algo, @ciphertext, @pub);
从字符串生成摘要
此示例适用于组件函数和遗留函数：
-- Digest type
SET @dig_type = 'SHA512';
-- Generate digest string
SET @dig = create_digest(@dig_type, 'My text to digest');
使用带有密钥对的摘要
密钥对可用于签署数据，然后验证签名是否与摘要匹配。此示例适用于组件函数和遗留函数：
-- Encryption algorithm; keys must
-- have been created using same algorithm
SET @algo = 'RSA';
–- Digest algorithm to sign the data
SET @dig_type = 'SHA512';
-- Generate signature for digest and verify signature against digest
SET @sig = asymmetric_sign(@algo, @dig, @priv, @dig_type);
-- Verify signature against digest
SET @verf = asymmetric_verify(@algo, @dig, @sig, @pub, @dig_type);
对于遗留功能，签名需要摘要。对于组件函数，签名不需要摘要，可以使用任何数据串。这些函数中的摘要类型指的是用于对数据进行签名的算法，而不是用于创建签名原始输入的算法。此示例适用于组件功能：
-- Encryption algorithm; keys must
-- have been created using same algorithm
SET @algo = 'RSA';
–- Arbitrary text string for signature
SET @text = repeat('j', 256);
–- Digest algorithm to sign the data
SET @dig_type = 'SHA512';
-- Generate signature for digest and verify signature against digest
SET @sig = asymmetric_sign(@algo, @text, @priv, @dig_type);
-- Verify signature against digest
SET @verf = asymmetric_verify(@algo, @text, @sig, @pub, @dig_type);
© Mysql 中文网
