# 20.10. LDAP 认证

20.10. LDAP 认证
版本：
纠错本页面
搜索
目录导航
❮
❯
20.10. LDAP 认证 #
这种认证方法操作起来类似于password，只不过它使用 LDAP 作为密码验证方法。LDAP 只被用于验证用户名/密码对。因此，在使用 LDAP 进行认证之前，用户必须已经存在于数据库中。
LDAP 认证可以在两种模式下操作。在第一种模式中（我们将称之为简单绑定模式），服务器将绑定到构造成prefix username suffix的可区分名称。通常，prefix参数被用于指定cn=，或者一个 Active Directory 环境中的DOMAIN\。suffix被用来指定非 Active Directory 环境中的 DN 的剩余部分。
在第二种模式中，我们称之为搜索+绑定模式，服务器首先使用固定的用户名和密码绑定到 LDAP 目录，这些用户名和密码通过ldapbinddn和ldapbindpasswd指定，并执行对尝试登录数据库的用户的搜索。如果未配置用户和密码，将尝试对目录进行匿名绑定。搜索将在ldapbasedn子树上执行，并尝试对ldapsearchattribute指定的属性进行精确匹配。一旦在此搜索中找到用户，服务器将使用客户端指定的密码，以该用户身份重新绑定到目录，以验证登录是否正确。此模式与其他软件中 LDAP 认证方案使用的模式相同，例如 Apache 的mod_authnz_ldap和pam_ldap。该方法允许用户对象在目录中的位置具有更大的灵活性，但会导致向 LDAP 服务器发出额外的两个请求。
以下配置选项在两种模式下都使用：
ldapserver
要连接的 LDAP 服务器的名称或 IP 地址。可以指定多个服务器，用空格分隔。
ldapport
要连接的 LDAP 服务器的端口号。如果未指定端口，则将使用 LDAP 库的默认端口设置。
ldapscheme
设置为ldaps以使用 LDAPS。这是一种非标准的使用 LDAP 进行 SSL 加密的方式，受一些 LDAP 服务器实现支持。另请参阅ldaptls选项作为替代。
ldaptls
设置为 1 以使 PostgreSQL 和 LDAP 服务器之间的连接使用 TLS 加密。这使用StartTLS操作，参见RFC 4513。另请参阅ldapscheme选项作为替代。
注意使用ldapscheme或ldaptls仅会加密 PostgreSQL 服务器和 LDAP 服务器之间的通信。PostgreSQL 服务器和 PostgreSQL 客户端之间的连接仍是未加密的，除非也在其上使用 SSL。
下列选项只被用于简单绑定模式：
ldapprefix
当做简单绑定认证时，前置到用户名形成要用于绑定的DN的字符串。
ldapsuffix
当做简单绑定认证时，后置到用户名形成要用于绑定的DN的字符串。
以下选项仅用于搜索+绑定模式：
ldapbasedn
执行搜索+绑定认证时，搜索用户的根 DN。
ldapbinddn
执行搜索+绑定认证时，用于绑定到目录以执行搜索的用户 DN。
ldapbindpasswd
执行搜索+绑定认证时，用于绑定到目录以执行搜索的用户密码。
ldapsearchattribute
执行搜索+绑定认证时，在搜索中与用户名匹配的属性。
若未指定属性，则使用 uid 属性。
ldapsearchfilter
执行搜索+绑定认证时使用的搜索过滤器。
其中 $username 出现处将被替换为用户名，
这比 ldapsearchattribute 支持更灵活的搜索过滤器。
以下选项可作为以更紧凑、标准的形式编写上述某些 LDAP 选项的替代方式：
ldapurl
符合 RFC 4516
的 LDAP URL，格式为：
ldap[s]://host[:port]/basedn[?[attribute][?[scope][?[filter]]]]
scope 必须是 base、
one、sub 之一，通常为后者。
（默认为 base，在此应用中通常没有用处。）
attribute 可以指定单个属性，此时用作
ldapsearchattribute 的值。若 attribute
为空，则 filter 可用作
ldapsearchfilter 的值。
URL 方案 ldaps 选择通过 SSL 建立 LDAP 连接的 LDAPS
方法，等价于使用 ldapscheme=ldaps。若要使用
StartTLS 操作的加密 LDAP 连接，请使用普通 URL
方案 ldap，并在 ldapurl 基础上
额外指定 ldaptls 选项。
对于非匿名绑定，ldapbinddn 和
ldapbindpasswd 必须作为单独选项指定。
LDAP URL 目前仅支持 OpenLDAP，不支持 Windows。
在简单绑定配置选项和搜索+绑定选项之间混用是错误的。在简单绑定模式下
使用 ldapurl 时，URL 中不得包含 basedn
或查询元素。
在使用搜索+绑定模式时，可以用 ldapsearchattribute 指定的单个属性执行搜索，或者使用 ldapsearchfilter 指定的自定义搜索过滤器执行搜索。指定 ldapsearchattribute=foo 等效于指定 ldapsearchfilter="(foo=$username)"。如果两个选项都没有被指定，则默认为 ldapsearchattribute=uid。
如果 PostgreSQL 是使用 OpenLDAP 作为 LDAP 客户端库编译的，
则 ldapserver 设置可以省略。在这种情况下，将通过 RFC 2782 DNS SRV 记录查找主机名和端口列表。
查找名称为 _ldap._tcp.DOMAIN，其中 DOMAIN 是从 ldapbasedn 中提取的。
这里是一个简单绑定 LDAP 配置的例子：
host ... ldap ldapserver=ldap.example.net ldapprefix="cn=" ldapsuffix=", dc=example, dc=net"
当请求一个作为数据库用户 someuser 到数据库服务器的连接时，PostgreSQL 将尝试使用 cn=someuser, dc=example, dc=net 和客户端提供的口令来绑定到 LDAP 服务器。如果那个连接成功，将被授予数据库访问。
以下是以 URL 形式编写的另一种简单绑定配置，使用 LDAPS 方案和自定义端口号：
host ... ldap ldapurl="ldaps://ldap.example.net:49151" ldapprefix="cn=" ldapsuffix=", dc=example, dc=net"
这比分别指定 ldapserver、ldapscheme
和 ldapport 更为简洁。
这是一个用于搜索+绑定配置的示例：
host ... ldap ldapserver=ldap.example.net ldapbasedn="dc=example, dc=net" ldapsearchattribute=uid
当请求以数据库用户someuser连接数据库服务器时，PostgreSQL将尝试
匿名绑定（因为未指定ldapbinddn）到LDAP服务器，执行在指定的
基础DN下搜索(uid=someuser)。如果找到条目，它将尝试使用该
条目信息和客户端提供的密码进行绑定。如果第二次绑定成功，则授予数据库访问权限。
这里是被写成一个 URL 的相同搜索+绑定配置：
host ... ldap ldapurl="ldap://ldap.example.net/dc=example,dc=net?uid?sub"
一些支持根据 LDAP 认证的其他软件使用相同的 URL 格式，因此很容易共享该配置。
这里是一个搜索+绑定配置的例子，它使用ldapsearchfilter而不是ldapsearchattribute来允许用用户ID或电子邮件地址进行认证：
host ... ldap ldapserver=ldap.example.net ldapbasedn="dc=example, dc=net" ldapsearchfilter="(|(uid=$username)(mail=$username))"
这是一个搜索+绑定配置的例子，它使用DNS SRV发现来查找域名example.net的LDAP服务的主机名和端口：
host ... ldap ldapbasedn="dc=example,dc=net"
提示
如例子中所示，由于 LDAP 通常使用逗号和空格来分割一个 DN 的不同部分，在配置 LDAP 选项时通常有必要使用双引号包围的参数值。
上一页 上一级 下一页20.9. Peer 认证 起始页 20.11. RADIUS 认证
