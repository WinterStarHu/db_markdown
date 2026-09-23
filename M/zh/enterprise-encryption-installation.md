# 6.6.1 MySQL企业加密安装升级_MySQL 8.0 参考手册

6.6.1 MySQL企业加密安装升级_MySQL 8.0 参考手册
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
6.6.1 MySQL企业加密安装升级
6.6.1 MySQL企业加密安装升级
在 MySQL 8.0.30 之前的版本中，MySQL Enterprise Encryption 提供的功能是通过基于openssl_udf共享库单独创建它们来安装的。从 MySQL 8.0.30 开始，功能由 MySQL 组件提供
component_enterprise_encryption，安装组件即安装所有功能。共享库中的函数已从openssl_udf该版本中弃用，您应该升级到该组件。
从 MySQL 8.0.30 安装安装到 MySQL 8.0.29升级 MySQL Enterprise 加密
从 MySQL 8.0.30 安装
从 MySQL 8.0.30 开始，MySQL Enterprise Encryption 的功能由 MySQL 组件提供
component_enterprise_encryption，而不是从openssl_udf共享库安装。如果您从使用 MySQL Enterprise Encryption 的早期版本升级到 MySQL 8.0.30，您创建的功能仍然可用并受支持。但是，此版本已弃用这些遗留功能，建议您改为安装该组件。组件功能是向后兼容的。有关升级信息，请参阅
升级 MySQL Enterprise Encryption。
如果要升级，请在安装组件之前使用以下
DROP
FUNCTION语句卸载旧功能：
DROP FUNCTION asymmetric_decrypt;
DROP FUNCTION asymmetric_derive;
DROP FUNCTION asymmetric_encrypt;
DROP FUNCTION asymmetric_sign;
DROP FUNCTION asymmetric_verify;
DROP FUNCTION create_asymmetric_priv_key;
DROP FUNCTION create_asymmetric_pub_key;
DROP FUNCTION create_dh_parameters;
DROP FUNCTION create_digest;
函数名称必须以小写形式指定。这些语句需要数据库的DROP
特权mysql。
要安装该组件，请发出一条INSTALL
COMPONENT语句：
INSTALL COMPONENT "file://component_enterprise_encryption";
INSTALL COMPONENT需要系统表的
INSERT权限，
mysql.component因为它向该表添加一行以注册组件。要验证组件是否已安装，请发出：
SELECT * FROM mysql.component;
中列出的组件在mysql.component启动序列期间由加载程序服务加载。
如果您需要卸载该组件，请发出一条
UNINSTALL COMPONENT语句：
UNINSTALL COMPONENT "file://component_enterprise_encryption";
有关详细信息，请参阅第 5.5.1 节 “安装和卸载组件”。
安装该组件即安装所有功能，因此您无需CREATE
FUNCTION像MySQL 8.0.30 之前那样使用语句创建它们。卸载组件会卸载所有功能。
安装组件后，如果希望组件函数支持对MySQL 8.0.30之前遗留函数产生的内容进行解密和校验，可将该组件的系统变量设置
enterprise_encryption.rsa_support_legacy_padding
为ON。此外，如果要更改组件函数生成的 RSA 密钥所允许的最大长度，请使用组件的系统变量
enterprise_encryption.maximum_rsa_key_size
来设置适当的最大值。有关配置信息，请参阅第 6.6.2 节，“配置 MySQL 企业加密”。
安装到 MySQL 8.0.29
在 MySQL 8.0.29 之前，MySQL Enterprise Encryption 函数位于安装在插件目录（
plugin_dir系统变量命名的目录）下的一个可加载函数库文件中。函数库基本名称是
openssl_udf，后缀是平台相关的。例如，Linux 或 Windows 上的文件名
分别
为openssl_udf.so或
。openssl_udf.dll
要从openssl_udf
共享库文件安装函数，请使用
CREATE
FUNCTION语句。要从库中加载所有函数，请使用这组语句，并根据需要调整文件名后缀：
CREATE FUNCTION asymmetric_decrypt RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION asymmetric_derive RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION asymmetric_encrypt RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION asymmetric_sign RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION asymmetric_verify RETURNS INTEGER
SONAME 'openssl_udf.so';
CREATE FUNCTION create_asymmetric_priv_key RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION create_asymmetric_pub_key RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION create_dh_parameters RETURNS STRING
SONAME 'openssl_udf.so';
CREATE FUNCTION create_digest RETURNS STRING
SONAME 'openssl_udf.so';
安装后，这些功能会在服务器重新启动后保持安装状态。如果需要卸载函数，使用
DROP
FUNCTION语句：
DROP FUNCTION asymmetric_decrypt;
DROP FUNCTION asymmetric_derive;
DROP FUNCTION asymmetric_encrypt;
DROP FUNCTION asymmetric_sign;
DROP FUNCTION asymmetric_verify;
DROP FUNCTION create_asymmetric_priv_key;
DROP FUNCTION create_asymmetric_pub_key;
DROP FUNCTION create_dh_parameters;
DROP FUNCTION create_digest;
在
CREATE
FUNCTIONand
DROP
FUNCTION语句中，函数名称必须以小写形式指定。这不同于它们在函数调用时的使用，您可以使用任何字母大小写。
CREATE
FUNCTION和
DROP
FUNCTION语句分别需要
数据库
的
INSERT和
DROP特权mysql。
共享库提供的openssl_udf
函数允许最小密钥大小为 1024 位。MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD您可以使用、
MYSQL_OPENSSL_UDF_DSA_BITS_THRESHOLD和
环境变量设置最大密钥大小
MYSQL_OPENSSL_UDF_DH_BITS_THRESHOLD
，如
第 6.6.2 节“配置 MySQL 企业加密”中所述。如果不设置最大密钥大小，则按照 OpenSSL 的规定，RSA 算法的上限为 16384，DSA 算法的上限为 10000。
升级 MySQL Enterprise 加密
如果您从使用
openssl_udf共享库提供的功能的早期版本升级到 MySQL 8.0.30 或更高版本，您创建的功能仍然可用并受支持。但是，这些遗留功能已从 MySQL 8.0.30 中弃用，建议您component_enterprise_encryption
改为安装 MySQL Enterprise Encryption 组件。
升级时，在安装组件之前，必须使用
DROP FUNCTION语句卸载遗留功能。有关执行此操作的说明，请参阅
从 MySQL 8.0.30 安装。
组件函数是向后兼容的：
遗留函数生成的 RSA 公钥和私钥可以与组件函数一起使用。
组件函数可以解密使用遗留函数加密的数据。
遗留功能创建的签名可以使用组件功能进行验证。
对于支持对遗留函数产生的内容进行解密和验证的组件函数，您必须将系统变量设置
enterprise_encryption.rsa_support_legacy_padding
为ON（默认为
OFF）。有关配置信息，请参阅
第 6.6.2 节，“配置 MySQL 企业加密”。
由于组件函数为满足当前标准而使用的填充和密钥格式存在差异，因此遗留函数无法处理组件函数创建的加密数据、公钥和签名。
组件提供的新功能
与共享库component_enterprise_encryption提供的遗留功能在行为和支持方面存在一些差异。openssl_udf其中最重要的如下：
遗留功能支持旧的 DSA 算法和 Diffie-Hellman 密钥交换方法。组件函数仅使用通常首选的 RSA 算法。
对于遗留功能，最小 RSA 密钥大小小于当前最佳实践。组件功能遵循当前关于最小 RSA 密钥大小的最佳实践。
遗留函数仅支持 SHA2 摘要，并且需要摘要作为签名。组件函数还支持 SHA3 摘要（假设正在使用 OpenSSL 1.1.1），并且不需要摘要作为签名，尽管它们支持它们。
legacy 函数支持使用asymmetric_encrypt()
私钥进行加密。asymmetric_encrypt()
组件函数只接受公钥。
建议您也仅使用具有旧功能的公钥进行加密。
该
组件
不提供 Diffie-Hellman 密钥交换方法
的create_dh_parameters()
和遗留功能。asymmetric_derive()component_enterprise_encryption
openssl_udf表 1 总结了共享库
提供的遗留功能component_enterprise_encryption与 MySQL 8.0.30 组件
提供的
功能在支持和操作方面的技术差异
。
表 6.46 MySQL 企业加密函数
能力
遗留功能（到 MySQL 8.0.29）
组件函数（来自 MySQL 8.0.30）
加密方式
RSA、DSA、迪菲-赫尔曼 (DH)
仅限 RSA
加密密钥
私人或公共
仅限公众
RSA 密钥格式
PKCS #1 v1.5
PKCS #8
最小 RSA 密钥大小
1024位
2048位
最大 RSA 密钥大小限制
使用环境变量设置
MYSQL_OPENSSL_UDF_RSA_BITS_THRESHOLD，默认限制是算法最大值 16384
使用系统变量设置
enterprise_encryption.maximum_rsa_key_size，默认限制为 4096
摘要算法
SHA2
SHA2、SHA3（使用 OpenSSL 1.1.1）
签名
需要摘要
支持但不是必需的摘要，可以使用任意长度的任何字符串
输出填充
RSAES-PKCS1-v1_5
RSAES-OAEP
签名填充
RSASSA-PKCS1-v1_5
RSASSA-PSS
© Mysql 中文网
