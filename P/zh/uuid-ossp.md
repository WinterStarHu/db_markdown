# F.49. uuid-ossp — 一个UUID生成器

F.49. uuid-ossp — 一个UUID生成器
版本：
纠错本页面
搜索
目录导航
❮
❯
F.49. uuid-ossp — 一个UUID生成器 #F.49.1. uuid-ossp 函数F.49.2. 构建 uuid-osspF.49.3. 作者
uuid-ossp模块提供函数使用几种标准算法之一产生通用唯一标识符（UUID）。还提供产生某些特殊 UUID 常量的函数。此模块仅适用于核心PostgreSQL中提供的其他特殊要求。有关生成UUID的内置方法，请参见第 9.14 节。
这个模块被认为是“可信的”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
F.49.1. uuid-ossp 函数 #
表 F.35显示了可用于生成UUID的函数。
相关标准ITU-T Rec. X.667，ISO/IEC 9834-8:2005和
RFC 4122
指定了四种生成UUID的算法，由版本号1、3、4和5标识。
（没有版本2的算法。）这些算法中的每一个都可能适用于不同的一组应用程序。
表 F.35. 用于 UUID 生成的函数
函数
简介
uuid_generate_v1 ()
→ uuid
产生一个版本 1 的 UUID。这涉及到计算机的 MAC 地址和一个时间戳。注意这种 UUID 会泄露产生该标识符的计算机标识以及产生的时间，因此它不适合某些对安全性很敏感的应用。
uuid_generate_v1mc ()
→ uuid
产生一个版本 1 的 UUID，但是使用一个随机多播 MAC 地址而不是该计算机真实的 MAC 地址。
uuid_generate_v3 ( namespace uuid, name text )
→ uuid
使用指定的输入名称在给定的名字空间中产生一个版本 3 的 UUID。该名字空间应该是由uuid_ns_*()函数（如表 F.36所示）产生的特殊常量之一（理论上它可以是任意 UUID）。名称是选择的名字空间中的一个标识符。
例如：
SELECT uuid_generate_v3(uuid_ns_url(), 'http://www.postgresql.org');
名称参数将使用 MD5 进行哈希，因此从产生的 UUID 中得不到明文。采用这种方法的 UUID 生成没有随机性并且不涉及依赖于环境的元素，因此是可以重现的。
uuid_generate_v4 ()
→ uuid
产生一个版本 4 的 UUID，它完全由随机数生成。
uuid_generate_v5 ( namespace uuid, name text )
→ uuid
产生一个版本 5 的 UUID，它和版本 3 的 UUID 相似，但是采用的是 SHA-1 作为哈希方法。版本 5 比版本 3 更好，因为 SHA-1 被认为比 MD5 更安全。
表 F.36. 返回 UUID 常量的函数
函数
简述
uuid_nil ()
→ uuid
返回一个“nil” UUID 常量，它不作为一个真正的 UUID 出现。
uuid_ns_dns ()
→ uuid
返回一个常量，指定 UUID 的 DNS 名字空间。
uuid_ns_url ()
→ uuid
返回一个常量，指定 UUID 的 URL 名字空间。
uuid_ns_oid ()
→ uuid
返回一个常量，指定 ISO 对象标识符（OID）名字空间的 UUID。
（这与 ASN.1 OID 相关，它与 PostgreSQL 使用的 OID 无关。）
uuid_ns_x500 ()
→ uuid
返回一个常量，指定 UUID 的 X.500 可识别名（DN）名字空间。
F.49.2. 构建 uuid-ossp #
历史上，这个模块依赖于 OSSP UUID 库，这也解释了模块的名称。虽然 OSSP UUID 库仍然可以在
http://www.ossp.org/pkg/lib/uuid/找到，但它已经不再得到很好的维护，
并且在新平台上越来越难移植。在一些平台上，uuid-ossp现在可以在没有
OSSP 库的情况下构建。在 FreeBSD 和一些其他基于 BSD 的平台上，适当的 UUID 创建函数包含在
核心 libc 库中。在 Linux、macOS 和一些其他平台上，适当的函数由
libuuid 库提供，该库最初来自 e2fsprogs 项目
（尽管在现代 Linux 中被认为是 util-linux-ng 的一部分）。在调用
configure 时，指定 --with-uuid=bsd 来使用 BSD 函数，
或 --with-uuid=e2fs 来使用 e2fsprogs 的
libuuid，或 --with-uuid=ossp 来使用 OSSP UUID 库。
在特定机器上可能有多个这些库可用，因此 configure 不会自动选择一个。
F.49.3. 作者 #
Peter Eisentraut <peter_e@gmx.net>
上一页 上一级 下一页F.48. unaccent — 一个去除变音符号的文本搜索字典 起始页 F.50. xml2 — XPath查询和XSLT功能
