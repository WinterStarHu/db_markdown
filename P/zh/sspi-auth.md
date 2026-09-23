# 20.7. SSPI 认证

20.7. SSPI 认证
版本：
纠错本页面
搜索
目录导航
❮
❯
20.7. SSPI 认证 #
SSPI是一种用于安全身份验证和单点登录的Windows技术。
PostgreSQL将在negotiate模式下使用SSPI，
该模式将在可能时使用Kerberos，并在其他情况下自动回退到NTLM。
SSPI和GSSAPI可以作为客户端和服务器进行互操作，
例如，SSPI客户端可以向GSSAPI服务器进行身份验证。
建议在Windows客户端和服务器上使用SSPI，在非Windows平台上使用GSSAPI。
当使用Kerberos认证时，SSPI和GSSAPI的工作方式相同，详见第 20.6 节。
下列被支持的配置选项用于SSPI：
include_realm
如果设置为 0，在通过用户名映射之前（第 20.2 节），来自已认证用户 principal 的 realm 名称会被剥离掉。我们不鼓励这样做，这种方法主要是为了向后兼容性而存在的，因为它在多 realm 环境中是不安全的（除非也使用krb_realm）。推荐用户让include_realm设置为默认值（1）并且在pg_ident.conf中提供一条显式的映射来把 principal 名称转换成PostgreSQL用户名。
compat_realm
如果被设置为 1，该域的 SAM 兼容名称（也被称为 NetBIOS 名称）被用于include_realm选项。这是默认值。如果被设置为 0，会使用来自 Kerberos 用户主名的真实 realm 名称。
不要禁用这个选项，除非你的服务器运行在一个域账号（这包括一个域成员系统上的虚拟服务账号）下并且所有通过 SSPI 认证的客户端也在使用域账号，否则认证将会失败。
upn_username
如果这个选项和compat_realm一起被启用，来自 Kerberos UPN 的用户名会被用于认证。如果它被禁用（默认），会使用 SAM 兼容的用户名。默认情况下，对于新用户账号这两种名称是一样的。
注意如果没有显式指定用户名，libpq会使用 SAM 兼容的名称。如果你使用的是libpq或者基于它的驱动，你应该让这个选项保持禁用或者在连接字符串中显式指定用户名。
map
允许在系统和数据库用户名之间的映射。详见第 20.2 节。
对于一个SSPI/Kerberos原则，例如username@EXAMPLE.COM
（或者更不常见的username/hostbased@EXAMPLE.COM），
用于映射的用户名会是username@EXAMPLE.COM（或者
username/hostbased@EXAMPLE.COM，相应地），除非
include_realm已经被设置为 0，在那种情况下
username（或者username/hostbased）是
映射时被视作系统用户名的东西。
krb_realm
设置领域为对用户 principal 名进行匹配的范围。如果这个参数被设置，只有那个领域的用户将被接受。如果它没有被设置，任何领域的用户都能连接，服从任何已完成的用户名映射。
上一页 上一级 下一页20.6. GSSAPI 认证 起始页 20.8. Ident 认证
