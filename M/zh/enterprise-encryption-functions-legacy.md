# 6.6.6 MySQL企业加密遗留功能说明_MySQL 8.0 参考手册

6.6.6 MySQL企业加密遗留功能说明_MySQL 8.0 参考手册
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
6.6.6 MySQL企业加密遗留功能说明
6.6.6 MySQL企业加密遗留功能说明
在 MySQL 8.0.30 之前的版本中，MySQL Enterprise Encryption 的功能基于openssl_udf共享库。该参考描述了这些功能。如果已安装这些功能，它们将在以后的版本中继续可用，但已弃用。
有关升级到 MySQL 组件提供的新组件功能的信息
component_enterprise_encryption，以及遗留功能和组件功能之间的行为差​​异列表，请参阅
升级 MySQL Enterprise Encryption。
组件函数的参考是
第 6.6.5 节，“MySQL Enterprise Encryption 组件函数描述”。
MySQL Enterprise Encryption 函数具有以下一般特征：
对于错误类型的参数或不正确的参数数量，每个函数都会返回一个错误。
如果参数不适合允许函数执行请求的操作，它会根据需要返回
NULLor 0。例如，如果一个函数不支持指定的算法，密钥长度太短或太长，或者 PEM 格式的预期为密钥字符串的字符串不是有效密钥，就会发生这种情况。
底层 SSL 库负责随机初始化。
一些遗留函数采用加密算法参数。下表按功能总结了支持的算法。
表 6.47 功能支持的算法
功能
支持的算法
asymmetric_decrypt()
RSA
asymmetric_derive()
卫生署
asymmetric_encrypt()
RSA
asymmetric_sign()
自适应搜索广告、动态搜索广告
asymmetric_verify()
自适应搜索广告、动态搜索广告
create_asymmetric_priv_key()
RSA、DSA、DH
create_asymmetric_pub_key()
RSA、DSA、DH
create_dh_parameters()
卫生署
笔记
尽管您可以使用任何 RSA、DSA 或 DH 加密算法创建密钥，但其他采用密钥参数的旧函数可能只接受某些类型的密钥。例如，
asymmetric_encrypt()只
asymmetric_decrypt()接受 RSA 密钥。
有关其他示例和讨论，请参阅
第 6.6.3 节，“MySQL Enterprise Encryption Usage and Examples”。
asymmetric_decrypt(algorithm,
crypt_str,
key_str)
使用给定的算法和密钥字符串解密加密的字符串，并将生成的明文作为二进制字符串返回。如果解密失败，则结果为
NULL。
openssl_udf共享库函数无法解密
component_enterprise_encryption由 MySQL 8.0.30 提供的函数
生成
的内容。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
crypt_str是要解密的加密字符串，它是用 加密的
asymmetric_encrypt()。
key_str是有效的 PEM 编码的 RSA 公钥或私钥。asymmetric_encrypt()为了成功解密，密钥字符串必须对应于用于生成加密字符串
的公钥或私钥字符串。
有关使用示例，请参阅 的说明
asymmetric_encrypt()。
asymmetric_derive(pub_key_str,
priv_key_str)
使用一方的私钥和另一方的公钥导出对称密钥，并将生成的密钥作为二进制字符串返回。如果密钥派生失败，则结果为
NULL。
pub_key_str并且
priv_key_str是使用 DH 算法创建的有效 PEM 编码密钥字符串。
假设您有两对公钥和私钥：
SET @dhp = create_dh_parameters(1024);
SET @priv1 = create_asymmetric_priv_key('DH', @dhp);
SET @pub1 = create_asymmetric_pub_key('DH', @priv1);
SET @priv2 = create_asymmetric_priv_key('DH', @dhp);
SET @pub2 = create_asymmetric_pub_key('DH', @priv2);
进一步假设您使用一对中的私钥和另一对中的公钥来创建对称密钥字符串。那么这个对称密钥身份关系成立：
asymmetric_derive(@pub1, @priv2) = asymmetric_derive(@pub2, @priv1)
此示例需要使用共享对称密钥创建的 DH 私钥/公钥作为输入。通过将密钥长度传递给创建秘密
create_dh_parameters()，然后将秘密作为“密钥长度”传递给
create_asymmetric_priv_key()。
-- Generate DH shared symmetric secret
SET @dhp = create_dh_parameters(1024);
-- Generate DH key pairs
SET @algo = 'DH';
SET @priv1 = create_asymmetric_priv_key(@algo, @dhp);
SET @pub1 = create_asymmetric_pub_key(@algo, @priv1);
SET @priv2 = create_asymmetric_priv_key(@algo, @dhp);
SET @pub2 = create_asymmetric_pub_key(@algo, @priv2);
-- Generate symmetric key using public key of first party,
-- private key of second party
SET @sym1 = asymmetric_derive(@pub1, @priv2);
-- Or use public key of second party, private key of first party
SET @sym2 = asymmetric_derive(@pub2, @priv1);
asymmetric_encrypt(algorithm,
str,
key_str)
使用给定的算法和密钥字符串加密字符串，并将生成的密文作为二进制字符串返回。如果加密失败，则结果为NULL.
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'.
str是要加密的字符串。此字符串的长度不能大于以字节为单位的密钥字符串长度减去 11（用于填充）。
key_str是有效的 PEM 编码的 RSA 公钥或私钥。
要恢复原始未加密的字符串，请将加密的字符串asymmetric_decrypt()连同用于加密的密钥对的另一部分传递给 ，如以下示例所示：
-- Generate private/public key pair
SET @priv = create_asymmetric_priv_key('RSA', 1024);
SET @pub = create_asymmetric_pub_key('RSA', @priv);
-- Encrypt using private key, decrypt using public key
SET @ciphertext = asymmetric_encrypt('RSA', 'The quick brown fox', @priv);
SET @plaintext = asymmetric_decrypt('RSA', @ciphertext, @pub);
-- Encrypt using public key, decrypt using private key
SET @ciphertext = asymmetric_encrypt('RSA', 'The quick brown fox', @pub);
SET @plaintext = asymmetric_decrypt('RSA', @ciphertext, @priv);
假设：
SET @s = a string to be encrypted
SET @priv = a valid private RSA key string in PEM format
SET @pub = the corresponding public RSA key string in PEM format
然后这些身份关系成立：
asymmetric_decrypt('RSA', asymmetric_encrypt('RSA', @s, @priv), @pub) = @s
asymmetric_decrypt('RSA', asymmetric_encrypt('RSA', @s, @pub), @priv) = @s
asymmetric_sign(algorithm,
digest_str,
priv_key_str,
digest_type)
使用私钥字符串对摘要字符串进行签名，并将签名作为二进制字符串返回。如果签名失败，则结果为NULL。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'和
'DSA'。
digest_str是摘要字符串。可以通过调用生成摘要字符串
create_digest()。
priv_key_str是用于签署摘要字符串的私钥字符串。它可以是有效的 PEM 编码的 RSA 私钥或 DSA 私钥。
digest_type是用于对数据进行签名的算法。支持的
digest_type值为
'SHA224'、'SHA256'、
'SHA384'和'SHA512'。
有关使用示例，请参阅 的说明
asymmetric_verify()。
asymmetric_verify(algorithm,
digest_str,
sig_str,
pub_key_str,
digest_type)
验证签名串是否与摘要串匹配，返回1或0表示验证成功或失败。如果验证失败，则结果为
NULL。
openssl_udf共享库函数无法验证
component_enterprise_encryptionMySQL 8.0.30 中可用的函数
生成
的内容。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'和
'DSA'。
digest_str是摘要字符串。摘要字符串是必需的，可以通过调用生成
create_digest()。
sig_str是要验证的签名字符串。可以通过调用生成签名字符串
asymmetric_sign()。
pub_key_str是签名者的公钥字符串。asymmetric_sign()它对应传递给生成签名字符串的私钥。它必须是有效的 PEM 编码 RSA 公钥或 DSA 公钥。
digest_type是用于签署数据的算法。支持的
digest_type值为
'SHA224'、'SHA256'、
'SHA384'和'SHA512'。
-- Set the encryption algorithm and digest type
SET @algo = 'RSA';
SET @dig_type = 'SHA224';
-- Create private/public key pair
SET @priv = create_asymmetric_priv_key(@algo, 1024);
SET @pub = create_asymmetric_pub_key(@algo, @priv);
-- Generate digest from string
SET @dig = create_digest(@dig_type, 'The quick brown fox');
-- Generate signature for digest and verify signature against digest
SET @sig = asymmetric_sign(@algo, @dig, @priv, @dig_type);
SET @verf = asymmetric_verify(@algo, @dig, @sig, @pub, @dig_type);
create_asymmetric_priv_key(algorithm,
{key_len|dh_secret})
使用给定的算法和密钥长度或 DH 秘密创建私钥，并以 PEM 格式的二进制字符串形式返回密钥。密钥采用 PKCS #1 格式。如果密钥生成失败，则结果为NULL。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'、'DSA'和'DH'。
key_len是 RSA 和 DSA 密钥的密钥长度（以位为单位）。如果超过最大允许密钥长度或指定小于最小值，则密钥生成失败并且结果为空输出。允许的最小密钥长度（以位为单位）为 1,024，对于 RSA 算法允许的最大密钥长度为 16,384，对于 DSA 算法为 10,000。这些密钥长度限制是 OpenSSL 强加的约束。MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD服务器管理员可以通过设置、
MYSQL_OPENSSL_UDF_DSA_BITS_THRESHOLD和
MYSQL_OPENSSL_UDF_DH_BITS_THRESHOLD
环境变量对最大密钥长度施加额外限制
。请参阅
第 6.6.2 节，“配置 MySQL 企业加密”。
笔记
生成更长的密钥会消耗大量 CPU 资源。使用环境变量限制密钥长度可以让您为您的需求提供足够的安全性，同时平衡资源使用。
dh_secret是共享的 DH 秘密，必须传递它而不是 DH 密钥的密钥长度。要创建秘密，请将密钥长度传递给
create_dh_parameters()。
此示例创建一个 2,048 位 DSA 私钥，然后从私钥派生出一个公钥：
SET @priv = create_asymmetric_priv_key('DSA', 2048);
SET @pub = create_asymmetric_pub_key('DSA', @priv);
有关显示 DH 密钥生成的示例，请参阅 的描述asymmetric_derive()。
create_asymmetric_pub_key(algorithm,
priv_key_str)
使用给定的算法从给定的私钥派生出公钥，并将密钥作为 PEM 格式的二进制字符串返回。密钥采用 PKCS #1 格式。如果密钥派生失败，则结果为NULL。
algorithm是用于创建密钥的加密算法。支持的算法值为'RSA'、'DSA'和'DH'。
priv_key_str是有效的 PEM 编码 RSA、DSA 或 DH 私钥。
有关使用示例，请参阅 的说明
create_asymmetric_priv_key()。
create_dh_parameters(key_len)
创建用于生成 DH 私钥/公钥对的共享机密，并返回可传递给 的二进制字符串
create_asymmetric_priv_key()。如果秘密生成失败，则结果为NULL。
key_len是密钥长度。以位为单位的最小和最大密钥长度为 1,024 和 10,000。这些密钥长度限制是 OpenSSL 强加的约束。MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD服务器管理员可以通过设置、
MYSQL_OPENSSL_UDF_DSA_BITS_THRESHOLD和
MYSQL_OPENSSL_UDF_DH_BITS_THRESHOLD
环境变量对最大密钥长度施加额外限制
。请参阅
第 6.6.2 节，“配置 MySQL 企业加密”。
有关显示如何使用返回值生成对称密钥的示例，请参阅 的说明
asymmetric_derive()。
SET @dhp = create_dh_parameters(1024);
create_digest(digest_type,
str)
使用给定的摘要类型从给定的字符串创建摘要，并将摘要作为二进制字符串返回。如果摘要生成失败，则结果为NULL。
生成的摘要字符串适合与
asymmetric_sign()和
一起使用asymmetric_verify()。这些功能需要摘要。
digest_type是用于生成摘要字符串的摘要算法。支持的
digest_type值为
'SHA224'、'SHA256'、
'SHA384'和'SHA512'。
str是要为其生成摘要的非空数据字符串。
SET @dig = create_digest('SHA512', 'The quick brown fox');
© Mysql 中文网
