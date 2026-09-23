# 20.1. pg_hba.conf 文件

20.1. pg_hba.conf 文件
版本：
纠错本页面
搜索
目录导航
❮
❯
20.1. pg_hba.conf 文件 #
客户端身份验证由一个配置文件控制，传统上被命名为
pg_hba.conf，并存储在集簇的数据目录中。
（HBA代表基于主机的身份验证。）当数据
目录被 initdb 初始化时，会安装一个默认的
pg_hba.conf 文件。
但是也可以将身份验证配置文件放在其他地方；
请参见 hba_file 配置参数。
在启动以及主服务器进程收到SIGHUP信号时，pg_hba.conf文件会被读取。
如果你在活动的系统上编辑了该文件，你将需要通知 postmaster（使用pg_ctl reload，调用SQL函数pg_reload_conf(),或使用kill -HUP）使其重新读取该文件。
注意
前面的说明在 Microsoft Windows 上不为真：在 Windows 上，pg_hba.conf文件中的任何更改会立即被应用到后续的新连接上。
系统视图pg_hba_file_rules有助于预先测试对pg_hba.conf文件的更改，该视图也可以在该文件的装载没有产生预期效果时用于诊断问题。该视图中带有非空error域的行就表示该文件对应行中存在问题。
pg_hba.conf文件的常用格式是一组记录，每行一条。
空白行将被忽略， #注释字符后面的任何文本也被忽略。
记录可以延续到下一行并以反斜线结束该行。(反斜线不是特定的，除了在行尾。)
一条记录由若干用空格和/或制表符分隔的域组成。
如果域值用双引号包围，那么它可以包含空白。
在数据库、用户或地址域中引用一个关键字（例如，all或replication）将使该词失去其特殊含义，并且只是匹配一个有该名字的数据库、用户或主机。
反斜线行的延续在引用文本或注释中也可以使用。
每条认证记录指定了一个连接类型、一个客户端 IP 地址范围（如果与连接类型相关），
一个数据库名称、一个用户名，以及用于匹配这些参数的连接的认证方法。第一个匹配
连接类型、客户端地址、请求的数据库和用户名的记录将用于执行认证。没有
“后备”或“备用”：如果选择了一条记录并且认证失败，
后续记录将不会被考虑。如果没有记录匹配，则拒绝访问。
每条记录可以是一个包含指令或一个认证记录。包含指令指定可以被包含的文件，
这些文件包含额外的记录。这些记录将被插入到包含指令的位置。包含指令只包含
两个字段：include、include_if_exists或
include_dir指令，以及要包含的文件或目录。文件或目录可以是
相对路径或绝对路径，并且可以用双引号括起来。对于include_dir
形式，所有不以.开头且以.conf结尾的文件
都将被包含。包含目录中的多个文件按照文件名顺序处理（根据 C 语言区域规则，
即数字在字母之前，大写字母在小写字母之前）。
一条记录可以有多个格式:
local               database  user  auth-method [auth-options]
host                database  user  address     auth-method  [auth-options]
hostssl             database  user  address     auth-method  [auth-options]
hostnossl           database  user  address     auth-method  [auth-options]
hostgssenc          database  user  address     auth-method  [auth-options]
hostnogssenc        database  user  address     auth-method  [auth-options]
host                database  user  IP-address  IP-mask      auth-method  [auth-options]
hostssl             database  user  IP-address  IP-mask      auth-method  [auth-options]
hostnossl           database  user  IP-address  IP-mask      auth-method  [auth-options]
hostgssenc          database  user  IP-address  IP-mask      auth-method  [auth-options]
hostnogssenc        database  user  IP-address  IP-mask      auth-method  [auth-options]
include             file
include_if_exists   file
include_dir         directory
字段的含义如下：
local
该记录匹配使用Unix域套接字的连接尝试。没有这种类型的记录，Unix域套接字连接是不允许的。
host
该记录匹配使用TCP/IP进行的连接尝试。
host记录匹配
SSL或非SSL连接
尝试，以及GSSAPI加密或
非GSSAPI加密连接尝试。
注意
远程TCP/IP连接将无法实现，除非服务器以适当的值启动
listen_addresses配置参数，
因为默认行为是仅在本地回环地址localhost上监听TCP/IP连接。
hostssl
该记录匹配使用TCP/IP进行的连接尝试，但仅当连接使用SSL加密时。
要使用此选项，服务器必须构建支持SSL。
此外，必须通过设置ssl配置参数来启用SSL
（有关更多信息，请参见第 18.9 节）。
否则，hostssl记录将被忽略，除了记录一个警告，说明它无法匹配任何连接。
hostnossl
这个记录类型与hostssl的行为相反；它只匹配通过
TCP/IP进行的不使用SSL的连接尝试。
hostgssenc
这条记录匹配使用TCP/IP进行的连接尝试，但仅当连接使用
GSSAPI加密时。
要使用此选项，服务器必须构建具有GSSAPI支持。
否则，hostgssenc记录将被忽略，除了记录一个警告，
说明它无法匹配任何连接。
hostnogssenc
这个记录类型与hostgssenc的行为相反；
它只匹配通过TCP/IP进行的不使用GSSAPI加密的连接尝试。
database
指定此记录匹配的数据库名称。值all表示它匹配所有数据库。
值sameuser表示如果请求的数据库名称与请求的用户名称相同，
则记录匹配。值samerole表示请求的用户必须是与请求的数据库
同名的角色的成员。（samegroup是samerole
的一个过时但仍被接受的拼写方式。）超级用户在samerole的
情况下不会被视为角色的成员，除非他们明确是该角色的成员，无论是直接还是间接，
而不仅仅是因为他们是超级用户。
值replication表示如果请求的是物理复制连接，则记录匹配，
但它不会匹配逻辑复制连接。请注意，物理复制连接不指定任何特定的数据库，
而逻辑复制连接则会指定数据库。
否则，这将是一个特定PostgreSQL数据库的名称或
一个正则表达式。可以通过用逗号分隔来提供多个数据库名称和/或正则表达式。
如果数据库名称以斜杠（/）开头，则名称的其余部分将被视为
正则表达式。（有关PostgreSQL的正则表达式语法的
详细信息，请参阅第 9.7.3.1 节。）
可以通过在文件名之前加上@来指定一个包含数据库名称和/或正则
表达式的单独文件。
user
指定此记录匹配的数据库用户名。值all表示它匹配所有用户。
否则，这可以是一个特定数据库用户的名称，一个正则表达式（以斜杠
(/)开头时），或者一个以+开头的组名。
（请记住，在PostgreSQL中，用户和组之间没有真正的区分；
+标记实际上意味着“匹配直接或间接属于此角色的任何角色”，
而没有+标记的名称仅匹配该特定角色。）为此目的，
超级用户只有在明确是某个角色的直接或间接成员时，才被视为该角色的成员，
而不仅仅是因为他们是超级用户。
可以通过用逗号分隔来提供多个用户名和/或正则表达式。
如果用户名以斜杠（/）开头，则名称的其余部分将被视为正则
表达式。（有关PostgreSQL的正则表达式语法的详细信息，
请参见第 9.7.3.1 节。）
可以通过在文件名之前加上@来指定一个包含用户名和/或正则表达式的单独文件。
address
指定此记录匹配的客户端机器地址。此字段可以包含主机名、IP地址范围或下面提到的特殊关键字之一。
IP地址范围使用标准的数字表示法来指定起始地址，然后是斜杠（/）和一个CIDR掩码长度。
掩码长度表示客户端IP地址必须匹配的高位比特数。给定IP地址中右侧的比特应为零。
IP地址、/和CIDR掩码长度之间不得有任何空格。
以这种方式指定的IPv4地址范围的典型示例包括172.20.143.89/32用于单个主机，
或172.20.143.0/24用于小型网络，或10.6.0.0/16用于较大的网络。
IPv6地址范围可能看起来像::1/128用于单个主机（在这种情况下是IPv6环回地址）或
fe80::7a31:c1ff:0000:0000/96用于小型网络。
0.0.0.0/0代表所有IPv4地址，::0/0代表所有IPv6地址。
要指定单个主机，请对IPv4使用32的掩码长度，对IPv6使用128。在网络地址中，不要省略尾部的零。
以IPv4格式给出的条目将仅匹配IPv4连接，而以IPv6格式给出的条目将仅匹配
IPv6连接，即使表示的地址位于IPv4-in-IPv6范围内。
你也可以写all来匹配任何IP地址，
samehost来匹配服务器自己的任何IP地址，
或samenet来匹配服务器直接连接到的任何子网中的任何地址。
如果指定了主机名（任何不是IP地址范围或特殊关键字的内容都被视为主机名），
则将该名称与客户端IP地址的反向名称解析结果进行比较（例如，如果使用DNS，则进行反向DNS查找）。
主机名比较不区分大小写。如果匹配成功，则对主机名执行正向名称解析（例如，进行正向DNS查找），
以检查其解析为的任何地址是否等于客户端IP地址。如果两个方向都匹配，则将条目视为匹配。
（在pg_hba.conf中使用的主机名应该是客户端IP地址的地址到名称解析返回的名称，
否则该行将不会匹配。一些主机名数据库允许将IP地址与多个主机名关联，
但操作系统在要求解析IP地址时只会返回一个主机名。）
以点（.）开头的主机名规范匹配实际主机名的后缀。
因此，.example.com将匹配foo.example.com
（但不仅仅是example.com）。
当在pg_hba.conf中指定主机名时，您应确保名称解析相对快速。
最好设置一个本地名称解析缓存，如nscd。
此外，您可能希望启用配置参数log_hostname，以在日志中看到客户端的主机名而不是IP地址。
这些字段不适用于local记录。
注意
用户有时会想知道为什么主机名以这种看似复杂的方式处理，包括两次名称解析，其中包括对客户端IP地址的反向查找。
如果客户端的反向DNS条目未设置或生成了一些不良的主机名，则使用该功能会变得复杂。
这主要是为了效率：这样，连接尝试最多需要两次解析器查找，一次反向查找和一次正向查找。
如果某个地址存在解析器问题，那就只会成为该客户端的问题。
一个假设的替代实现只进行正向查找的情况下，在每次连接尝试期间都必须解析pg_hba.conf中提到的每个主机名。
如果列出了许多名称，这可能会非常慢。
如果其中一个主机名存在解析器问题，那么这将成为所有人的问题。
此外，实现后缀匹配功能需要进行反向查找，因为需要知道实际客户端主机名
以便将其与模式进行匹配。
请注意，这种行为与其他流行的基于主机名的访问控制实现一致，例如
Apache HTTP服务器和TCP包装器。
IP-addressIP-mask
这两个字段可以用作IP-address/mask-length
表示法的替代方案。而不是指定掩码长度，实际掩码在一个单独的列中指定。
例如，255.0.0.0表示IPv4的CIDR掩码长度为8，
而255.255.255.255表示CIDR掩码长度为32。
这些字段不适用于local记录。
auth-method
指定连接匹配此记录时要使用的身份验证方法。可能的选择在这里总结；详细信息在第 20.3 节中。所有选项都是小写的，并且区分大小写，因此即使是像ldap这样的首字母缩写也必须指定为小写。
trust
允许无条件连接。这种方法允许任何可以连接到PostgreSQL数据库服务器的人以任何他们希望的PostgreSQL用户登录，无需密码或任何其他身份验证。有关详细信息，请参见第 20.4 节。
reject
无条件拒绝连接。这对于“过滤掉”某些主机很有用，例如一个reject行可以阻止特定主机连接，而后面的行允许特定网络中的其余主机连接。
scram-sha-256
执行SCRAM-SHA-256身份验证以验证用户的密码。详细信息请参见第 20.5 节。
md5
执行SCRAM-SHA-256或MD5身份验证以验证用户的密码。详细信息请参见第 20.5 节。
警告
对MD5加密密码的支持已废弃，将在PostgreSQL的未来版本中移除。有关迁移到其他密码类型的详情，请参阅第 20.5 节。
password
要求客户端提供未加密的密码进行身份验证。由于密码以明文形式通过网络发送，因此不应在不受信任的网络上使用。详细信息请参见第 20.5 节。
gss
使用GSSAPI对用户进行身份验证。这仅适用于TCP/IP连接。有关详细信息，请参见第 20.6 节。它可以与GSSAPI加密一起使用。
sspi
使用SSPI对用户进行身份验证。这仅适用于Windows。有关详细信息，请参见第 20.7 节。
ident
通过联系客户端上的ident服务器获取操作系统用户名称，
并检查是否与请求的数据库用户名称匹配。
Ident身份验证只能用于TCP/IP连接。
当为本地连接指定时，将改为使用对等身份验证。
详细信息请参见第 20.8 节。
peer
从操作系统获取客户端的操作系统用户名，并检查是否与请求的数据库用户名匹配。
这仅适用于本地连接。
有关详细信息，请参见第 20.9 节。
ldap
使用LDAP服务器进行身份验证。有关详细信息，请参见第 20.10 节。
radius
使用RADIUS服务器进行身份验证。详细信息请参见第 20.11 节。
cert
使用SSL客户端证书进行身份验证。详情请参见第 20.12 节。
pam
使用操作系统提供的可插拔认证模块（PAM）服务进行身份验证。详细信息请参见第 20.13 节。
bsd
使用操作系统提供的BSD认证服务进行身份验证。有关详细信息，请参见第 20.14 节。
oauth
使用第三方 OAuth 2.0 身份提供者进行授权（可选认证）。
详情请参阅 第 20.15 节。
auth-options
在auth-method字段之后，可以是形如name=value的字段，
用于指定认证方法的选项。关于哪些选项适用于哪些认证方法的详细信息见下文。
除了下面列出的特定于方法的选项外，还有一个方法无关的身份验证选项clientcert，
可以在任何hostssl记录中指定。
此选项可以设置为verify-ca或verify-full。
这两个选项都要求客户端提供有效（受信任的）SSL证书，
而verify-full还要求证书中的cn（通用名称）与用户名或适用映射匹配。
这种行为类似于cert身份验证方法（请参阅第 20.12 节），
但允许将客户端证书的验证与支持hostssl条目的任何身份验证方法配对。
在使用客户端证书认证的任何记录上（即使用cert认证方法或使用clientcert选项的记录），您可以使用clientname选项指定要匹配的客户端证书凭据的哪个部分。此选项可以有两个值之一。如果您指定clientname=CN，这是默认值，则用户名将与证书的Common Name (CN)进行匹配。如果您改为指定clientname=DN，则用户名将与证书的整个Distinguished Name (DN)进行匹配。此选项最好与用户名映射一起使用。比较是使用DN以RFC 2253格式进行的。要查看以此格式显示的客户端证书的DN，请执行
openssl x509 -in myclient.crt -noout -subject -nameopt RFC2253 | sed "s/^subject=//"
在使用此选项时需要小心，特别是在使用正则表达式匹配DN时。
include
这一行将被给定文件的内容替换。
include_if_exists
如果文件存在，这一行将被文件的内容替换。否则，将记录一条消息以表明该文件
已被跳过。
include_dir
这行内容将被目录中找到的所有文件的内容替换，如果它们不以
.开头并以.conf结尾，按照文件名顺序
（根据C语言区域规则，即数字在字母之前，大写字母在小写字母之前）处理。
用@结构包括的文件被读作一个名字列表，它们可以用空白或者逗号分隔。注释用#引入，就像在pg_hba.conf中那样，并且允许嵌套@结构。除非跟在@后面的文件名是一个绝对路径，文件名都被认为是相对于包含引用文件的目录。
因为每一次连接尝试都会顺序地检查pg_hba.conf记录，所以这些记录的顺序是非常关键的。通常，靠前的记录有比较严的连接匹配参数和比较弱的认证方法，而靠后的记录有比较松的匹配参数和比较强的认证方法。 例如，我们希望对本地 TCP/IP 连接使用trust认证，而对远程 TCP/IP 连接要求密码。在这种情况下为来自于 127.0.0.1 的连接指定trust认证的记录将出现在为一个更宽范围的客户端 IP 地址指定密码认证的记录前面。
提示
要连接到一个特定数据库，一个用户必须不仅要通过pg_hba.conf检查，还必须要有该数据库上的CONNECT权限。如果你希望限制哪些用户能够连接到哪些数据库，授予/撤销CONNECT权限通常比在pg_hba.conf项中设置规则简单。
例 20.1中展示了pg_hba.conf项的一些例子。不同认证方法的详情请见下一节。
例 20.1. 示例 pg_hba.conf 项
# Allow any user on the local system to connect to any database with
# any database user name using Unix-domain sockets (the default for local
# connections).
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             all                                     trust
# The same using local loopback TCP/IP connections.
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             all             127.0.0.1/32            trust
# The same as the previous line, but using a separate netmask column
#
# TYPE  DATABASE        USER            IP-ADDRESS      IP-MASK             METHOD
host    all             all             127.0.0.1       255.255.255.255     trust
# The same over IPv6.
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             all             ::1/128                 trust
# The same using a host name (would typically cover both IPv4 and IPv6).
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             all             localhost               trust
# The same using a regular expression for DATABASE, that allows connection
# to any databases with a name beginning with "db" and finishing with a
# number using two to four digits (like "db1234" or "db12").
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    "/^db\d{2,4}$"  all             localhost               trust
# Allow any user from any host with IP address 192.168.93.x to connect
# to database "postgres" as the same user name that ident reports for
# the connection (typically the operating system user name).
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    postgres        all             192.168.93.0/24         ident
# Allow any user from host 192.168.12.10 to connect to database
# "postgres" if the user's password is correctly supplied.
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    postgres        all             192.168.12.10/32        scram-sha-256
# Allow any user from hosts in the example.com domain to connect to
# any database if the user's password is correctly supplied.
#
# Require SCRAM authentication for most users, but make an exception
# for user 'mike', who uses an older client that doesn't support SCRAM
# authentication.
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             mike            .example.com            md5
host    all             all             .example.com            scram-sha-256
# In the absence of preceding "host" lines, these three lines will
# reject all connections from 192.168.54.1 (since that entry will be
# matched first), but allow GSSAPI-encrypted connections from anywhere else
# on the Internet.  The zero mask causes no bits of the host IP address to
# be considered, so it matches any host.  Unencrypted GSSAPI connections
# (which "fall through" to the third line since "hostgssenc" only matches
# encrypted GSSAPI connections) are allowed, but only from 192.168.12.10.
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             all             192.168.54.1/32         reject
hostgssenc all          all             0.0.0.0/0               gss
host    all             all             192.168.12.10/32        gss
# Allow users from 192.168.x.x hosts to connect to any database, if
# they pass the ident check.  If, for example, ident says the user is
# "bryanh" and he requests to connect as PostgreSQL user "guest1", the
# connection is allowed if there is an entry in pg_ident.conf for map
# "omicron" that says "bryanh" is allowed to connect as "guest1".
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
host    all             all             192.168.0.0/16          ident map=omicron
# If these are the only four lines for local connections, they will
# allow local users to connect only to their own databases (databases
# with the same name as their database user name) except for users whose
# name end with "helpdesk", administrators and members of role "support",
# who can connect to all databases.  The file $PGDATA/admins contains a
# list of names of administrators.  Passwords are required in all cases.
#
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   sameuser        all                                     scram-sha-256
local   all             /^.*helpdesk$                           scram-sha-256
local   all             @admins                                 scram-sha-256
local   all             +support                                scram-sha-256
# The last two lines above can be combined into a single line:
local   all             @admins,+support                        scram-sha-256
# The database column can also use lists and file names:
local   db1,db2,@demodbs  all                                   scram-sha-256
上一页 上一级 下一页第 20 章 客户端认证 起始页 20.2. 用户名称映射
