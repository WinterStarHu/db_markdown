# 20.6. GSSAPI 认证

20.6. GSSAPI 认证
版本：
纠错本页面
搜索
目录导航
❮
❯
20.6. GSSAPI 认证 #
GSSAPI是一种在
RFC 2743
中定义的安全认证行业标准协议。
PostgreSQL支持GSSAPI用于认证、
通信加密，或两者兼而有之。
GSSAPI为支持它的系统提供自动认证（单点登录）。
认证本身是安全的。如果使用GSSAPI加密
或SSL加密，沿数据库连接发送的数据将被加密；
否则，将不会被加密。
当编译PostgreSQL时，GSSAPI支持必须被启用，详见第 17 章。
当GSSAPI使用Kerberos时，它使用一个标准服务主体（身份验证）名称，以servicename/hostname@realm的格式。
特定安装使用的主体名称没有被以任何方式编码在PostgreSQL服务器中；而是被指定在keytab文件中，服务器读取该文件以决定它的身份。
如果在keytab文件中罗列着多个主体，服务器将接受其中任何一个。
服务器的领域名称是在服务器可访问的Kerberos配置文件中指定的优先领域。
当连接时，客户端必须知道它打算连接的服务器的主体名称。
主体名称的servicename部分通常是postgres，但是其他值可以通过libpq的krbsrvname连接参数来选择。
hostname部分是libpq告知要连接的完全限定的主机名称。
领域名称是在客户端可访问的Kerberos配置文件中指定的优先领域。
客户端也可以有主体名称作为它自己的身份（并且它必须拥有针对这个主体的有效的票据）。
要使用GSSAPI做身份验证，客户端的主体必须与PostgreSQL数据库用户名关联。
pg_ident.conf配置文件可以用于映射主体到用户名；例如，pgusername@realm可能会被映射到pgusername。
或者，你可以使用完整的username@realm主体作为PostgreSQL中的角色而无需任何映射。
PostgreSQL也支持映射客户端主体到用户名，通过从主体中剥离领域的方式。
这种方法是为了向后兼容性，并且我们强烈反对使用它，因为这样就无法区分具有相同用户名却来自不同领域的不同用户了。
要启用这种方法，可将include_realm设置为0。
对于简单的单领域安装，这样做并且设置krb_realm参数（这会检查主体的领域是否正好匹配krb_realm中的参数）仍然是安全的。
但比起在pg_ident.conf中指定一个显式映射来说，这种方法的能力较低。
服务器的keytab文件的位置是由krb_server_keyfile配置参数指定的。
出于安全原因，建议为PostgreSQL服务器使用独立的keytab，而不是允许服务器读取系统的keytab文件。
确保你的服务器的keytab文件是对PostgreSQL服务器账号可读的（并且最好是只读的，不可写）。
（参见第 18.1 节。）
密钥表文件是使用Kerberos软件生成的；请参阅Kerberos文档以获取详细信息。
以下示例展示了使用MIT Kerberos的kadmin工具执行此操作：
kadmin% addprinc -randkey postgres/server.my.domain.org
kadmin% ktadd -k krb5.keytab postgres/server.my.domain.org
GSSAPI验证方法支持下列身份验证选项：
include_realm
如果设置为0，在通过用户名映射之前（第 20.2 节），来自已认证用户主体的领域名称会被剥离掉。
我们不鼓励这样做，这种方法主要是为了向后兼容性而存在的，因为它在多领域环境中是不安全的（除非也使用krb_realm）。
推荐用户让include_realm设置为默认值（1）并且在pg_ident.conf中提供一条显式的映射来把主体名称转换成PostgreSQL用户名。
map
允许从客户端主体到数据库用户名之间的映射。
详见第 20.2 节。
对于一个GSSAPI/Kerberos主体，例如username@EXAMPLE.COM（或者更不常见的username/hostbased@EXAMPLE.COM），用于映射的用户名会是username@EXAMPLE.COM（或者username/hostbased@EXAMPLE.COM，相应地），除非include_realm已经被设置为0，在那种情况下username（或者username/hostbased）是映射时被视作系统用户名的内容。
krb_realm
设置与用户主体名称匹配的领域。如果设置此参数，则仅接受该领域的用户。如果未设置，则任何领域的用户都可以连接，具体取决于所做的用户名映射。
在这些设置之外，对于不同的pg_hba.conf项可能有所不同，还有服务器范围的krb_caseins_users配置参数。
如果设置为真，客户端主体匹配用户映射条目是大小写不敏感的。
如果设置了krb_realm，也不区分大小写。
上一页 上一级 下一页20.5. 口令认证 起始页 20.7. SSPI 认证
