# F.26. pgcrypto — 加密函数

F.26. pgcrypto — 加密函数
版本：
纠错本页面
搜索
目录导航
❮
❯
F.26. pgcrypto — 加密函数 #F.26.1. 通用哈希函数F.26.2. 口令哈希函数F.26.3. PGP 加密函数F.26.4. 原始加密函数F.26.5. 随机数据函数F.26.6. OpenSSL 支持函数F.26.7. 配置参数F.26.8. 注释F.26.9. 作者
pgcrypto模块为PostgreSQL提供加密函数。
该模块被认为是“trusted”，也就是说，它可以由对当前数据库具有CREATE权限的非超级用户安装。
pgcrypto需要OpenSSL，如果在构建PostgreSQL时没有选择OpenSSL支持，则不会安装。
F.26.1. 通用哈希函数 #F.26.1.1. digest() #
digest(data text, type text) returns bytea
digest(data bytea, type text) returns bytea
计算给定data的二进制哈希值。
type是要使用的算法。
标准算法包括md5、sha1、
sha224、sha256、
sha384和sha512。
此外，OpenSSL支持的任何摘要算法都会自动被选中。
如果你想将摘要作为十六进制字符串，可以在结果上使用encode()。例如：
CREATE OR REPLACE FUNCTION sha1(bytea) returns text AS $$
SELECT encode(digest($1, 'sha1'), 'hex')
$$ LANGUAGE SQL STRICT IMMUTABLE;
F.26.1.2. hmac() #
hmac(data text, key text, type text) returns bytea
hmac(data bytea, key bytea, type text) returns bytea
为带有密钥key的data计算哈希过的MAC。
type与digest()中相同。
这与digest()相似，但是该哈希只能在知晓密钥的情况下被重新计算出来。
这阻止了某人修改数据且还想更改哈希以匹配之的企图。
如果密钥大于哈希块的大小，它将首先被哈希，然后结果将用作密钥。
F.26.2. 口令哈希函数 #
函数crypt()和gen_salt()是特别设计用来做密码哈希的。crypt()完成哈希，而gen_salt()负责为前者准备算法参数。
crypt()中的算法与通常的
MD5或SHA-1哈希算法在以下方面有所不同：
它们很慢。由于数据量很小，这是增加暴力破解密码难度的唯一方法。
它们使用一个随机值（称为salt），这样具有相同密码的用户将得到不同的密文密码。这也是针对逆转算法的一种额外保护。
它们会在结果中包括算法类型，这样用不同算法哈希的密码能共存。
其中一些是自适应的 — 这意味着当计算机变得更快时，你可以调整该算法变得更慢，而不会产生与现有密码的不兼容。
表 F.18列出了crypt()函数所支持的算法。
表 F.18. crypt()支持的算法算法最大密码长度自适应？盐位数输出长度描述bf72yes12860基于 Blowfish，变体 2amd5unlimitedno4834基于 MD5 的加密xdes8yes2420扩展的 DESdes8no1213原生 UNIX 加密sha256cryptunlimitedyes最多 3280改编自公开可用的参考实现
使用 SHA-256 和 SHA-512 的 Unix crypt
sha512cryptunlimitedyes最多 32123改编自公开可用的参考实现
使用 SHA-256 和 SHA-512 的 Unix crypt
F.26.2.1. crypt() #
crypt(password text, salt text) 返回 text
计算password的一个 crypt(3) 风格的哈希。在存储一个新密码时，你需要使用gen_salt()产生一个新的salt值。要检查一个密码，把存储的哈希值作为salt，并测试结果是否匹配存储的值。
设置一个新密码的例子：
UPDATE ... SET pswhash = crypt('new password', gen_salt('md5'));
认证的例子：
SELECT (pswhash = crypt('entered password', pswhash)) AS pswmatch FROM ... ;
如果输入的密码正确，这会返回true。
F.26.2.2. gen_salt() #
gen_salt(type text [, iter_count integer ]) 返回 text
产生一个在crypt()中使用的新随机 salt 字符串。该 salt 字符串也告诉crypt()要使用哪种算法。
type 参数指定哈希算法。
可接受的类型有：des、xdes、
md5、bf、sha256crypt 和
sha512crypt。最后两个，sha256crypt 和
sha512crypt 是基于现代 SHA-2 的密码哈希。
iter_count 参数让用户可以为使用迭代计数的算法指定迭代计数。
计数越高，哈希密码花费的时间就越长，因此攻破它所需的时间也越多。
不过使用过高的计数可能导致计算一个哈希的时间高达数年 — 这并不实用。
如果 iter_count 参数被忽略，将使用默认的迭代计数。
允许的 iter_count 值与算法相关，如 表 F.19 所示。
表 F.19. crypt() 的迭代计数算法默认值最小值最大值xdes725116777215bf6431sha256crypt, sha512crypt50001000999999999
对 xdes 算法还有额外的限制：迭代计数必须是一个奇数。
要选取一个合适的迭代计数，考虑最初的 DES 加密被设计成在当时的硬件上每秒钟完成 4 次哈希。低于每秒 4 次哈希的速度很可能会损害可用性。而超过每秒 100 次哈希又可能太快了。
表 F.20给出了不同哈希算法的相对慢度的综述。该表展示了在假设口令只含有小写字母或者大小写字母及数字的情况下，在一个 8 字符口令中尝试所有字符组合所需要的时间。在crypt-bf项中，斜线后的数字是gen_salt的iter_count参数。
sha256crypt 和 sha512crypt 的默认 iter_count
为 5000 被认为对于现代硬件来说过低，但可以调整以生成更强的密码哈希。
否则，两个哈希，sha256crypt 和 sha512crypt 被认为是安全的。
表 F.20. 哈希算法速度算法次哈希/秒对于[a-z]对于[A-Za-z0-9]相对于md5 hash的持续时间crypt-bf/817924 年3927 年100kcrypt-bf/736482 年1929 年50kcrypt-bf/671681 年982 年25kcrypt-bf/513504188天521年12.5kcrypt-md517158415天41年1kcrypt-des23221568157.5分钟108天7sha13777427290分钟68天4md5 (hash)15008550422.5分钟17天1
注意：
使用的机器是一台 Intel Mobile Core i3。
crypt-des和crypt-md5算法的数字是取自 John the Ripper v1.6.38 -test输出。
md5 hash的数字来自mdcrack 1.2。
sha1的数字来自lcrack-20031130-beta。
crypt-bf 数字是通过一个简单的程序获取的，该程序循环
处理1000个8字符的密码。这样可以显示不同迭代次数下的速度。
参考数据：john-test 显示 crypt-bf/5 的
速度为13506次循环/秒。（结果中的非常小的差异与以下事实一致：
crypt-bf 在 pgcrypto 中的实现与
John the Ripper 中使用的实现是相同的。）
注意“尝试所有组合”并非是现实中会采用的方式。通常口令破解都是在词典的帮助下完成的，词典中会包含常用词以及它们的多种变化。因此，甚至有些像词的口令被破解的时间可能会大大快于上面建议的数字，而一个 6 字符的不像词的口令可能会逃过破解，也可能不能逃脱。
F.26.3. PGP 加密函数 #
这里的函数实现了OpenPGP的加密部分
(RFC 4880)
标准。支持对称密钥和公钥加密。
一个加密的 PGP 消息由两个部分或者包组成：
包含一个会话密钥的包 — 加密过的对称密钥或者公钥。
包含用会话密钥加密的数据包。
当使用对称密钥（即密码）加密时：
给定的密码使用 String2Key (S2K) 算法进行哈希。这更像是crypt()算法 — 有目的地慢并且使用随机盐 — 但是它会产生一个全长度的二进制密钥。
如果请求一个独立的会话密钥，将会生成一个新的随机密钥。否则将直接使用 S2K 密钥作为会话密钥。
如果直接使用 S2K 密钥，那么只有 S2K 设置将被放入会话密钥包中。否则会话密钥将使用 S2K 密钥加密并放入会话密钥包中。
当使用公共密钥加密时：
生成一个新的随机会话密钥。
它使用公共密钥加密并放入会话密钥包中。
在两种情况下，要被加密的数据按下列步骤处理：
可选的数据操作：压缩、转换为 UTF-8 和/或行末转换。
数据会被加上一个随机字节的块作为前缀。这等效于使用随机 IV。
随机前缀和数据的 SHA-1 哈希被附加。
所有这些都用会话密钥加密并放在数据包中。
F.26.3.1. pgp_sym_encrypt() #
pgp_sym_encrypt(data text, psw text [, options text ]) returns bytea
pgp_sym_encrypt_bytea(data bytea, psw text [, options text ]) returns bytea
使用一个对称 PGP 密钥 psw 加密 data。options 参数可以包含下文所述的选项设置。
F.26.3.2. pgp_sym_decrypt() #
pgp_sym_decrypt(msg bytea, psw text [, options text ]) returns text
pgp_sym_decrypt_bytea(msg bytea, psw text [, options text ]) returns bytea
解密一个用对称密钥加密的 PGP 消息。
不允许使用 pgp_sym_decrypt 解密 bytea 数据。这是为了避免输出非法的字符数据。使用 pgp_sym_decrypt_bytea 解密原始文本数据是可以的。
options 参数可以包含下文所述的选项设置。
F.26.3.3. pgp_pub_encrypt() #
pgp_pub_encrypt(data text, key bytea [, options text ]) returns bytea
pgp_pub_encrypt_bytea(data bytea, key bytea [, options text ]) returns bytea
用一个公共 PGP 密钥 key加密 data。
给这个函数一个私钥会产生一个错误。
options 参数可以包含下文所述的选项设置。
F.26.3.4. pgp_pub_decrypt() #
pgp_pub_decrypt(msg bytea, key bytea [, psw text [, options text ]]) returns text
pgp_pub_decrypt_bytea(msg bytea, key bytea [, psw text [, options text ]]) returns bytea
解密一个公共密钥加密的消息。key 必须是对应于用来加密的公钥的私钥。
如果私钥是用口令保护的，你必须在 psw 中给出该口令。
如果没有口令，但你想要指定选项，你需要给出一个空口令。
不允许使用pgp_pub_decrypt解密bytea数据。这是为了避免输出无效的字符数据。使用pgp_pub_decrypt_bytea解密原始文本数据是可以的。
options参数可以包含选项设置，如下所述。
F.26.3.5. pgp_key_id() #
pgp_key_id(bytea) returns text
pgp_key_id提取 PGP 公钥或私钥的密钥 ID。或者如果给定了一个加密过的消息，它会给出一个用于加密数据的密钥 ID。
它可以返回 2 个特殊密钥 ID：
SYMKEY
该消息是用对称密钥加密的。
ANYKEY
该消息是用公钥加密的，但是密钥 ID 已经被移除。这意味着你将需要尝试你所有的私钥来看看哪个能解密该消息。pgcrypto本身不产生这样的消息。
注意不同的密钥可能具有相同的 ID。这很少见但是是一种正常事件。客户端应用则应该尝试用每一个去解密，看看哪个合适 — 像处理 ANYKEY 一样。
F.26.3.6. armor(), dearmor() #
armor(data bytea [ , keys text[], values text[] ]) returns text
dearmor(data text) returns bytea
这些函数把二进制数据包装/解包成 PGP ASCII-armored 格式，其基本上是带有 CRC 和额外格式化的 Base64。
如果指定了 keys 和 values 数组，每一个
键/值对的 armored 格式上会增加一个 armor header。两个
数组都必须是单一维度的，并且它们的长度必须相同。键和值不能包含任何
非 ASCII 字符。
F.26.3.7. pgp_armor_headers #
pgp_armor_headers(data text, key out text, value out text) returns setof record
pgp_armor_headers()从data中提取
armor headers。返回值是一个有两列的行集合，包括键和值。如果键或值
包含任何非ASCII字符，它们会被视作UTF-8。
F.26.3.8. PGP 函数的选项 #
选项被命名为与GnuPG类似的形式。一个选项的值应该在一个等号后给出，各个选项之间用逗号分隔。例如：
pgp_sym_encrypt(data, psw, 'compress-algo=1, cipher-algo=aes256')
除了convert-crlf之外，所有这些选项只适用于加密函数。解密函数会从PGP数据中得到这些参数。
最有趣的选项可能是compress-algo和unicode-mode。其余的应该有合理的默认值。
F.26.3.8.1. cipher-algo #
使用哪个密码算法。
Values: bf, aes128, aes192, aes256, 3des, cast5
Default: aes128
Applies to: pgp_sym_encrypt, pgp_pub_encrypt
F.26.3.8.2. compress-algo #
要使用哪种压缩算法。只有PostgreSQL编译时使用了zlib时才可用。
Values:
0 - no compression
1 - ZIP compression
2 - ZLIB compression (= ZIP plus meta-data and block CRCs)
Default: 0
Applies to: pgp_sym_encrypt, pgp_pub_encrypt
F.26.3.8.3. compress-level #
压缩多少。级别越高压缩得越小但是速度也越慢。0表示禁用压缩。
Values: 0, 1-9
Default: 6
Applies to: pgp_sym_encrypt, pgp_pub_encrypt
F.26.3.8.4. convert-crlf #
加密时是否把\n转换成\r\n以及解密时是否把\r\n转换成\n。RFC 4880指定文本数据存储时应该使用\r\n换行。使用这个选项能够得到完全RFC兼容的行为。
Values: 0, 1
Default: 0
Applies to: pgp_sym_encrypt, pgp_pub_encrypt, pgp_sym_decrypt, pgp_pub_decrypt
F.26.3.8.5. disable-mdc #
不用SHA-1保护数据。使用这个选项的唯一好理由是实现与古董级别PGP产品的兼容，这些产品在受SHA-1保护的包被加入到RFC 4880之前就已经存在了。最近的gnupg.org和pgp.com软件能很好地支持它。
Values: 0, 1
Default: 0
Applies to: pgp_sym_encrypt, pgp_pub_encrypt
F.26.3.8.6. sess-key #
使用单独的会话密钥。公钥加密总是使用一个单独的会话密钥；这个选项是用于对称密钥加密的，对称密钥加密默认直接使用 S2K 密钥。
Values: 0, 1
Default: 0
Applies to: pgp_sym_encrypt
F.26.3.8.7. s2k-mode #
要使用哪种 S2K 算法。
Values:
0 - Without salt.  Dangerous!
1 - With salt but with fixed iteration count.
3 - Variable iteration count.
Default: 3
Applies to: pgp_sym_encrypt
F.26.3.8.8. s2k-count #
S2K 算法要使用的迭代次数。它必须是一个介于 1024 和 65011712 之间的值，
包括首尾两个值。
Default: A random value between 65536 and 253952
Applies to: pgp_sym_encrypt, only with s2k-mode=3
F.26.3.8.9. s2k-digest-algo #
要在 S2K 计算中使用哪种摘要算法。
Values: md5, sha1
Default: sha1
Applies to: pgp_sym_encrypt
F.26.3.8.10. s2k-cipher-algo #
要用哪种密码来加密独立的会话密钥。
Values: bf, aes, aes128, aes192, aes256
Default: use cipher-algo
Applies to: pgp_sym_encrypt
F.26.3.8.11. unicode-mode #
是否把文本数据在数据库内部编码和 UTF-8 之间来回转换。如果你的数据库已经是 UTF-8，将不会转换，但是消息将被标记为 UTF-8。没有这个选项，它将不会被标记。
Values: 0, 1
Default: 0
Applies to: pgp_sym_encrypt, pgp_pub_encrypt
F.26.3.9. 用 GnuPG 生成 PGP 密钥 #
要生成一个新密钥：
gpg --gen-key
首选的密钥类型是“DSA 和 Elgamal”。
对于 RSA 加密，你必须创建仅用于签名的 DSA 或 RSA 密钥作为主控密钥，然后用gpg --edit-key增加一个 RSA 加密子密钥。
要列举密钥：
gpg --list-secret-keys
要以 ASCII-装甲格式导出一个公钥：
gpg -a --export KEYID > public.key
要以 ASCII-装甲格式导出一个私钥：
gpg -a --export-secret-keys KEYID > secret.key
在把这些密钥交给 PGP 函数之前，你需要对它们使用dearmor()。或者如果你能处理二进制数据，你可以从命令中去掉-a。
更多细节请参考man gpg、
The GNU
Privacy Handbook以及
https://www.gnupg.org/上的其他文档。
F.26.3.10. PGP 代码的限制 #
不支持签名。这也意味着它不检查加密子密钥是否属于主密钥。
不支持加密密钥作为主密钥。由于通常并不鼓励那种用法，这应该不是问题。
不支持多个子密钥。这可能看起来像一个问题，因为在实践中普遍需要多个子密钥。另一方面，你不能把你的常规 GPG/PGP 密钥用于pgcrypto，而是创建一些新的密钥，因为使用场景相当不同。
F.26.4. 原始加密函数 #
这些函数只在数据上运行一次加密，它们不具有 PGP 加密的任何高级特性。因此它们有一些主要的问题：
它们直接把用户密钥用作加密密钥。
它们不提供任何完整性检查，以查看被加密的数据是否被修改。
它们希望用户自己管理所有加密参数，甚至是 IV。
它们无法处理文本。
因此，在引入 PGP 加密后，我们不鼓励使用原始加密函数。
encrypt(data bytea, key bytea, type text) returns bytea
decrypt(data bytea, key bytea, type text) returns bytea
encrypt_iv(data bytea, key bytea, iv bytea, type text) returns bytea
decrypt_iv(data bytea, key bytea, iv bytea, type text) returns bytea
使用 type 指定的密码方法加密/解密数据。type 字符串的语法是：
algorithm [ - mode ] [ /pad: padding ]
其中 algorithm 是以下之一：
bf — Blowfishaes — AES (Rijndael-128、-192 或 -256)
而 mode 是以下之一：
cbc — 下一个块依赖于前一个块（默认）
cfb — 下一个块依赖于前一个加密块
ecb — 每个块单独加密（仅用于测试）
而 padding 是以下之一：
pkcs — 数据可以是任意长度（默认）
none — 数据必须是密码块大小的倍数
因此，例如这些是等效的：
encrypt(data, 'fooz', 'bf')
encrypt(data, 'fooz', 'bf-cbc/pad:pkcs')
在 encrypt_iv 和 decrypt_iv 中，iv 参数是 CBC 和
CFB 模式的初始值；
对于 ECB 模式则被忽略。
如果不是精确的块大小，则会被截断或用零填充。
在没有此参数的函数中，默认值为全零。
F.26.5. 随机数据函数 #
gen_random_bytes(count integer) returns bytea
返回count个密码学上强随机的字节。一次最多可以抽取 1024 个字节。这是为了避免耗尽随机数生成器池。
gen_random_uuid() returns uuid
返回一个版本 4（随机）UUID。（已过时，此函数内部调用同名的核心函数。）
F.26.6. OpenSSL 支持函数 #
fips_mode() 返回布尔值
如果 OpenSSL 在启用 FIPS 模式下运行，则返回 true，否则返回 false。
F.26.7. 配置参数 #
有一个配置参数控制 pgcrypto 的行为。
pgcrypto.builtin_crypto_enabled (enum)
#
pgcrypto.builtin_crypto_enabled 决定内置加密函数 gen_salt() 和 crypt() 是否可用。将其设置为 off 将禁用这些函数。on（默认值）使这些函数正常工作。fips 在检测到 OpenSSL 以 FIPS 模式运行时禁用这些函数。
在普通使用中，此参数设置在 postgresql.conf 中，尽管超级用户可以在自己的会话中动态更改它。
F.26.8. 注释 #F.26.8.1. 配置 #
pgcrypto会根据查找主 PostgreSQL configure脚本配置它自身。影响它的选项是--with-zlib以及--with-ssl=openssl。
在编译 zlib 时，PGP 加密函数能够在加密前压缩数据。
pgcrypto需要OpenSSL。
否则，它将无法构建或安装。
当针对OpenSSL 3.0.0和更高版本进行编译时，必须在openssl.cnf配置文件中启用旧版提供程序，以便使用旧的密码，如DES或Blowfish。
F.26.8.2. NULL 处理 #
按照 SQL 中的标准，只要任何参数是 NULL，所有的函数都会返回 NULL。在不当使用时这可能会导致安全风险。
F.26.8.3. 安全性限制 #
所有pgcrypto函数都在数据库服务器内部运行。这意味着在pgcrypto和客户端应用之间移动的所有数据和密码都是明文。因此，你必须：
本地连接或使用 SSL 连接。信任系统和数据库管理员。
如果你不能这样做，那么最好在客户端应用中进行加密。
该实现无法抵抗
侧信道
攻击。例如，一个pgcrypto解密函数完成所需的时间是随着密文尺寸变化的。
F.26.9. 作者 #
Marko Kreen <markokr@gmail.com>
pgcrypto使用了来自下列来源的代码：
算法作者来源DES cryptDavid Burren 等FreeBSD libcryptMD5 cryptPoul-Henning KampFreeBSD libcryptBlowfish cryptSolar Designerwww.openwall.com上一页 上一级 下一页F.25. pg_buffercache — 检查PostgreSQL
缓冲区缓存状态 起始页 F.27. pg_freespacemap — 检查空闲空间映射
