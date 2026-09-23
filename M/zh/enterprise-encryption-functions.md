# 6.6.5 MySQL企业加密组件功能说明_MySQL 8.0 参考手册

6.6.5 MySQL企业加密组件功能说明_MySQL 8.0 参考手册
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
6.6.5 MySQL企业加密组件功能说明
6.6.5 MySQL企业加密组件功能说明
在 MySQL 8.0.30 版本中，MySQL Enterprise Encryption 的功能由 MySQL 组件提供
component_enterprise_encryption。该参考描述了这些功能。
有关升级到 MySQL 组件提供的新组件功能的信息
component_enterprise_encryption，以及遗留功能和组件功能之间的行为差​​异列表，请参阅
升级 MySQL Enterprise Encryption。
基于openssl_udf共享库的MySQL 8.0.30 之前版本中的遗留函数参考第 6.6.6 节，“MySQL 企业加密遗留函数说明”。
MySQL Enterprise Encryption 函数具有以下一般特征：
对于错误类型的参数或不正确的参数数量，每个函数都会返回一个错误。
如果参数不适合允许函数执行请求的操作，它会根据需要返回
NULLor 0。例如，如果一个函数不支持指定的算法，密钥长度太短或太长，或者 PEM 格式的预期为密钥字符串的字符串不是有效密钥，就会发生这种情况。
底层 SSL 库负责随机初始化。
组件函数只支持RSA加密算法。
有关其他示例和讨论，请参阅
第 6.6.3 节，“MySQL Enterprise Encryption Usage and Examples”。
asymmetric_decrypt(algorithm,
data_str,
priv_key_str)
使用给定的算法和密钥字符串解密加密的字符串，并将生成的明文作为二进制字符串返回。如果解密失败，则结果为
NULL。
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
默认情况下，该
component_enterprise_encryption函数假定加密文本使用 RSAES-OAEP 填充方案。openssl_udf如果系统变量
enterprise_encryption.rsa_support_legacy_padding
设置为ON（默认为
OFF），该函数支持解密由遗留共享库函数加密的内容。设置后ON，该函数还支持 RSAES-PKCS1-v1_5 填充方案，如旧openssl_udf
共享库函数所使用的那样。设置时OFF，无法解密由遗留函数加密的内容，并且该函数返回此类内容的空输出。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
data_str是要解密的加密字符串，它是用 加密的
asymmetric_encrypt()。
priv_key_str是有效的 PEM 编码 RSA 私钥。asymmetric_encrypt()为了成功解密，密钥字符串必须与用于生成加密字符串的公钥字符串相对应
。组件函数仅支持使用
asymmetric_encrypt()公钥加密，因此解密需要使用相应的私钥。
有关使用示例，请参阅 的说明
asymmetric_encrypt()。
asymmetric_encrypt(algorithm,
data_str,
pub_key_str)
使用给定的算法和密钥字符串加密字符串，并将生成的密文作为二进制字符串返回。如果加密失败，则结果为NULL.
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
data_str是要加密的字符串。此字符串的长度不能大于密钥字符串长度（以字节为单位）减去 42（用于填充）。
pub_key_str是有效的 PEM 编码 RSA 公钥。组件函数仅支持使用
asymmetric_encrypt()公钥加密。
要恢复原始未加密的字符串，请将加密的字符串asymmetric_decrypt()连同用于加密的密钥对的另一部分传递给 ，如以下示例所示：
-- Generate private/public key pair
SET @priv = create_asymmetric_priv_key('RSA', 2048);
SET @pub = create_asymmetric_pub_key('RSA', @priv);
-- Encrypt using public key, decrypt using private key
SET @ciphertext = asymmetric_encrypt('RSA', 'The quick brown fox', @pub);
SET @plaintext = asymmetric_decrypt('RSA', @ciphertext, @priv);
假设：
SET @s = a string to be encrypted
SET @priv = a valid private RSA key string in PEM format
SET @pub = the corresponding public RSA key string in PEM format
然后这些身份关系成立：
asymmetric_decrypt('RSA', asymmetric_encrypt('RSA', @s, @pub), @priv) = @s
asymmetric_sign(algorithm,
text,
priv_key_str,
digest_type)
使用私钥对摘要字符串或数据字符串进行签名，并将签名作为二进制字符串返回。如果签名失败，则结果为NULL。
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
text是数据字符串或摘要字符串。该函数接受摘要但不需要它们，因为它还能够处理任意长度的数据字符串。可以通过调用生成摘要字符串
create_digest()。
priv_key_str是用于签署摘要字符串的私钥字符串。它必须是有效的 PEM 编码 RSA 私钥。
digest_type是用于对数据进行签名的算法。支持的
digest_type值为
'SHA224'、'SHA256'、
'SHA384'，并且'SHA512'
在使用 OpenSSL 1.0.1 时。如果正在使用 OpenSSL 1.1.1，则附加值digest_type、
'SHA3-224'、'SHA3-256'和
'SHA3-384'可用
'SHA3-512'。
有关使用示例，请参阅 的说明
asymmetric_verify()。
asymmetric_verify(algorithm,
text,
sig_str,
pub_key_str,
digest_type)
验证签名串是否与摘要串匹配，返回1或0表示验证成功或失败。如果验证失败，则结果为
NULL。
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
默认情况下，该
component_enterprise_encryption函数假定签名使用 RSASSA-PSS 签名方案。openssl_udf如果系统变量
enterprise_encryption.rsa_support_legacy_padding
设置为ON（默认为
OFF），该函数支持验证由遗留共享库函数生成的签名。设置后ON，该函数还支持 RSASSA-PKCS1-v1_5 签名方案，如旧openssl_udf
共享库函数所使用的那样。设置时OFF，无法验证遗留函数生成的签名，并且该函数会为此类内容返回空输出。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
text是数据字符串或摘要字符串。组件函数接受摘要但不需要它们，因为它还能够处理任意长度的数据字符串。可以通过调用生成摘要字符串create_digest()。
sig_str是要验证的签名字符串。可以通过调用生成签名字符串
asymmetric_sign()。
pub_key_str是签名者的公钥字符串。asymmetric_sign()它对应传递给生成签名字符串的私钥。它必须是有效的 PEM 编码 RSA 公钥。
digest_type是用于签署数据的算法。支持的
digest_type值为
'SHA224'、'SHA256'、
'SHA384'，并且'SHA512'
在使用 OpenSSL 1.0.1 时。如果正在使用 OpenSSL 1.1.1，则附加值digest_type、
'SHA3-224'、'SHA3-256'和
'SHA3-384'可用
'SHA3-512'。
-- Set the encryption algorithm and digest type
SET @algo = 'RSA';
SET @dig_type = 'SHA512';
-- Create private/public key pair
SET @priv = create_asymmetric_priv_key(@algo, 2048);
SET @pub = create_asymmetric_pub_key(@algo, @priv);
-- Generate digest from string
SET @dig = create_digest(@dig_type, 'The quick brown fox');
-- Generate signature for digest and verify signature against digest
SET @sig = asymmetric_sign(@algo, @dig, @priv, @dig_type);
SET @verf = asymmetric_verify(@algo, @dig, @sig, @pub, @dig_type);
create_asymmetric_priv_key(algorithm,
key_length)
使用给定的算法和密钥长度创建私钥，并以 PEM 格式的二进制字符串形式返回密钥。密钥采用 PKCS #8 格式。如果密钥生成失败，则结果为NULL。
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
key_length是以位为单位的密钥长度。如果超过最大允许密钥长度或指定小于最小值，则密钥生成失败并且结果为空输出。允许的最小密钥长度（以位为单位）为 2048。允许的最大密钥长度是
enterprise_encryption.maximum_rsa_key_size
系统变量的值，默认为 4096。它的最大设置为 16384，这是 RSA 算法允许的最大密钥长度。请参阅
第 6.6.2 节，“配置 MySQL 企业加密”。
笔记
生成更长的密钥会消耗大量 CPU 资源。使用系统变量限制密钥长度
enterprise_encryption.maximum_rsa_key_size
可以让您为您的需求提供足够的安全性，同时平衡资源使用。
此示例创建一个 2048 位 RSA 私钥，然后从私钥派生出一个公钥：
SET @priv = create_asymmetric_priv_key('RSA', 2048);
SET @pub = create_asymmetric_pub_key('RSA', @priv);
create_asymmetric_pub_key(algorithm,
priv_key_str)
使用给定的算法从给定的私钥派生出公钥，并将密钥作为 PEM 格式的二进制字符串返回。密钥采用 PKCS #8 格式。如果密钥派生失败，则结果为NULL。
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
priv_key_str是有效的 PEM 编码 RSA 私钥。
有关使用示例，请参阅 的说明
create_asymmetric_priv_key()。
create_digest(digest_type,
str)
使用给定的摘要类型从给定的字符串创建摘要，并将摘要作为二进制字符串返回。如果摘要生成失败，则结果为NULL。
对于 MySQL 8.0.29 之前使用的此功能的旧版本，请参阅
第 6.6.6 节，“MySQL Enterprise Encryption Legacy Function Descriptions”。
生成的摘要字符串适合与
asymmetric_sign()和
一起使用asymmetric_verify()。这些函数的组件版本接受摘要但不需要它们，因为它们能够处理任意长度的数据。
digest_type是用于生成摘要字符串的摘要算法。支持的
digest_type值为
'SHA224'、'SHA256'、
'SHA384'，并且'SHA512'
在使用 OpenSSL 1.0.1 时。如果正在使用 OpenSSL 1.1.1，则附加值digest_type、
'SHA3-224'、'SHA3-256'和
'SHA3-384'可用
'SHA3-512'。
str是要为其生成摘要的非空数据字符串。
SET @dig = create_digest('SHA512', 'The quick brown fox');
© Mysql 中文网
