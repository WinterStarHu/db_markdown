# F.42. sslinfo — 获取客户端SSL信息

F.42. sslinfo — 获取客户端SSL信息
版本：
纠错本页面
搜索
目录导航
❮
❯
F.42. sslinfo — 获取客户端SSL信息 #F.42.1. 提供的函数F.42.2. Author
在连接到PostgreSQL时，sslinfo模块提供当前客户端提供的 SSL 证书的有关信息。如果当前连接不使用 SSL，这个模块就没有用处（大部分函数将返回 NULL）。
本模块提供的一些信息，也可以使用内置系统视图
pg_stat_ssl来获得。
除非安装时用--with-ssl=openssl进行了配置，这个扩展压根就不会被编译。
F.42.1. 提供的函数 #
ssl_is_used() returns boolean
如果当前到服务器的连接使用 SSL 则返回 true，否则返回 false。
ssl_version() returns text
返回 SSL 连接使用的协议名称（如 TLSv1.0、TLSv1.1、TLSv1.2 或 TLSv1.3）。
ssl_cipher() returns text
返回 SSL 连接所用的加密方法名称（如 DHE-RSA-AES256-SHA）。
ssl_client_cert_present() returns boolean
如果当前客户端已经向服务器出示了一个合法的 SSL 客户端证书则返回 true，否则返回 false（服务器可能被配置要求一个客户端证书，也可能没有被配置成这样）。
ssl_client_serial() returns numeric
返回当前客户端证书的序列号。证书序列号和证书发行人的组合被确保可以
唯一标识一个证书（但是不能唯一标识其拥有者 — 拥有者应该定期地更换其密钥，
并且从发行人那里得到新的证书）。
因此，如果你运行自己的 CA 并且只允许服务器接收来自于这个 CA 的证书，序列号就是最可靠的（虽然并非很好记忆）标识用户的方法。
ssl_client_dn() returns text
返回当前客户端证书的完整主题，并将字符数据转换成当前数据库的编码。我们假定如果你在证书名中使用非 ASCII 字符，你的数据库也有能力表示这些字符。如果你的数据库使用 SQL_ASCII 编码，名称中的非 ASCII 字符将被表示为 UTF-8 序列。
结果看起来像/CN=某人 /C=某个国家 /O=某个组织。
ssl_issuer_dn() returns text
返回当前客户端证书的完整发行人名称，并把字符数据转换成当前数据库的编码。编码转换以与ssl_client_dn相同的方式处理。
这个函数的返回值与证书序列号的组合唯一地标识证书。
如果在服务器的证书授权中心文件中有多个可信 CA 证书，或者如果这个 CA 已经发行了某些中间证书授权机构证书，这个函数就真的很有用。
ssl_client_dn_field(fieldname text) returns text
这个函数返回证书主题中指定字段的值，如果字段不存在则返回 NULL。
字段名称是字符串常量，它们被使用OpenSSL对象数据库转换成 ASN1 对象标识符。
下列值是可接受的：
commonName (alias CN)
surname (alias SN)
name
givenName (alias GN)
countryName (alias C)
localityName (alias L)
stateOrProvinceName (alias ST)
organizationName (alias O)
organizationalUnitName (alias OU)
title
description
initials
postalCode
streetAddress
generationQualifier
description
dnQualifier
x500UniqueIdentifier
pseudonym
role
emailAddress
这些字段中除了commonName都是可选的。它们中哪些会被包括或者不会被包括完全取决于你的 CA 策略。不过，这些字段的含义由 X.500 和 X.509 标准严格地定义，因此你不能只是为它们分配任意含义。
ssl_issuer_field(fieldname text) returns text
和ssl_client_dn_field一样，但是用于证书发行人而不是证书主题。
ssl_extension_info() returns setof record
提供有关客户端证书扩展的信息：扩展名称、扩展值，以及是否为
关键扩展。
F.42.2. Author #
Victor Wagner <vitus@cryptocom.ru>, Cryptocom LTD
Dmitry Voronin <carriingfate92@yandex.ru>
Cryptocom OpenSSL 开发组的电子邮件：
<openssl@cryptocom.ru>
上一页 上一级 下一页F.41. spi — 服务器编程接口功能/示例 起始页 F.43. tablefunc — 返回表的函数（crosstab及其他）
