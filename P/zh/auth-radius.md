# 20.11. RADIUS 认证

20.11. RADIUS 认证
版本：
纠错本页面
搜索
目录导航
❮
❯
20.11. RADIUS 认证 #
这种认证方法的操作类似于password，不过它使用 RADIUS 作为密码验证方式。RADIUS 只被用于验证用户名/密码对。因此，在 RADIUS 能被用于认证之前，用户必须已经存在于数据库中。
当使用 RADIUS 认证时，一个访问请求消息将被发送到配置好的 RADIUS 服务器。
这一请求将是Authenticate Only类型，并且包含参数user name、password（加密的）和NAS Identifier。
该请求将使用一个与服务器共享的密钥加密。
RADIUS 服务器将对这个请求响应Access Accept或者Access Reject。不支持 RADIUS 计费。
可以指定多个 RADIUS 服务器，这种情况下将会依次尝试它们。如果从一台服务器接收到否定响应，则认证失败。
如果没有接收到响应，则将会尝试列表中的下一台服务器。要指定多台服务器，可用双引号括住列表并用逗号将服务器名称分开。
如果指定了多台服务器，其他 RADIUS 选项也可以用逗号分隔的列表给出，用来为每台服务器应用个别的值。
它们也可以指定为单个值，这种情况下该值将被应用到所有的服务器。
下列被支持的配置选项用于 RADIUS：
radiusservers
连接到 RADIUS 服务器的 DNS 名称或 IP 地址。此参数是必需的。
radiussecrets
和 RADIUS 服务器安全通信时使用的共享密钥。此值在 PostgreSQL 和 RADIUS 服务器之间必须完全相同。建议使用至少 16 个字符的字符串。此参数是必需的。
注意
如果PostgreSQL编译为支持OpenSSL，所用的加密向量将是强密码。如果没有，传输到 RADIUS 服务器的内容应被视为混淆而非安全，必要时应采取外部安全措施。
radiusports
连接 RADIUS 服务器的端口号。如果没有指定端口，则使用默认 RADIUS 端口1812。
radiusidentifiers
在 RADIUS 请求中字符串被用作NAS Identifier。
这个参数可以用于识别用户尝试连接哪些数据库集群，这对 RADIUS 服务器上的策略匹配很有用。
如果没有指定标识符，默认使用postgresql。
如果 RADIUS 参数值中需要有逗号或者空格，可以通过双引号括住该值来完成，但这样做是比较繁琐的，因为需要两层双引号。
将空格放到 RADIUS 密钥字符串的一个示例为：
host ... radius radiusservers="server1,server2" radiussecrets="""secret one"",""secret two"""
上一页 上一级 下一页20.10. LDAP 认证 起始页 20.12. 证书认证
