# 52.8. pg_authid

52.8. pg_authid
版本：
纠错本页面
搜索
目录导航
❮
❯
52.8. pg_authid #
目录pg_authid包含关于数据库授权标识符（角色）的信息。角色把“用户”和“组”的概念包含在内。一个用户实际上就是一个rolcanlogin标志被设置的角色。任何角色（不管rolcanlogin设置与否）都能够把其他角色作为成员，参见pg_auth_members。
由于这个目录包含密码，它不能是公共可读的。pg_roles是在pg_authid上的一个公共可读视图，它隐去了密码字段。
第 21 章包含关于用户和权限管理的详细信息。
由于用户标识符是集簇范围的，pg_authid在一个集簇的所有数据库之间共享：在一个集簇中只有一份pg_authid拷贝，而不是每个数据库一份。
表 52.8. pg_authid 列
列类型
描述
oid oid
行标识符
rolname name
角色名
rolsuper bool
角色具有超级用户权限
rolinherit bool
如果本角色是另一个角色的成员，本角色是否自动继承该角色的权限
rolcreaterole bool
角色能创建更多角色
rolcreatedb bool
角色能创建数据库
rolcanlogin bool
角色是否能登录。即该角色是否能够作为初始会话授权标识符
rolreplication bool
角色是一个复制角色。复制角色可以启动复制连接并且创建和删除复制槽。
rolbypassrls bool
角色可以绕过所有的行级安全性策略，详见第 5.9 节。
rolconnlimit int4
对于可以登录的角色，本列设置该角色可以同时发起的最大连接数。-1表示无限制。
rolpassword text
加密后的密码；若无则为空。格式取决于所用的加密方式。
rolvaliduntil timestamptz
密码过期时间（仅用于密码认证）；如果没有过期则为null
对于一个MD5加密的密码，rolpassword列将由字符串md5后面跟上一个32字符的十六进制MD5哈希值构成。MD5哈希值将是该用户的密码串接上他们的用户名。例如，如果用户joe的密码是xyzzy，则PostgreSQL将存储xyzzyjoe的md5哈希。
警告
对MD5加密密码的支持已废弃，将在PostgreSQL的未来版本中移除。有关迁移到其他密码类型的详情，请参阅第 20.5 节。
如果密码是使用SCRAM-SHA-256加密的，则格式如下：
SCRAM-SHA-256$<iteration count>:<salt>$<StoredKey>:<ServerKey>
其中salt，StoredKey和ServerKey都是以Base64编码格式表示。这种格式与RFC 5803中指定的格式相同。
上一页 上一级 下一页52.7. pg_attribute 起始页 52.9. pg_auth_members
