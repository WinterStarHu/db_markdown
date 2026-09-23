# F.24. passwordcheck — 验证密码强度

F.24. passwordcheck — 验证密码强度
版本：
纠错本页面
搜索
目录导航
❮
❯
F.24. passwordcheck — 验证密码强度 #F.24.1. 配置参数
只要通过CREATE ROLE或ALTER ROLE设置用户，
passwordcheck模块会检查用户的密码。如果一个密码被认为太弱，它将被拒绝并且该命令将带着一个错误终止。
要启用这个模块，把'$libdir/passwordcheck'加入到postgresql.conf中的shared_preload_libraries，然后重启服务器。
你可以通过修改源代码来按你的需要修改这个模块。例如，你可以使用CrackLib来检查密码 — 这只需要在Makefile中取消两行的注释并且重新编译该模块（由于授权原因，我们不能默认包括CrackLib）。如果没有CrackLib，该模块会对密码强度强制一些简单的规则，你可以自行修改和扩充。
小心
要阻止未加密的密码被通过网络传送、写入到服务器日志或者被一个数据库管理员窃取，PostgreSQL允许用户提供预加密的密码。很多客户端程序利用这种功能并且在把密码发送给服务器之前加密它。
这限制了passwordcheck模块的有用性，因为这种情况下它只能尝试猜测密码。由于这个原因，如果你的安全性需求很高，我们不推荐passwordcheck。使用一个诸如 GSSAPI （见第 20 章）的外部认证方法比依赖数据库内的密码更加安全。
此外，你可以修改passwordcheck来拒绝预加密的密码，但是强制用户将密码设置为明文带来了它的安全风险。
F.24.1. 配置参数 #
passwordcheck.min_password_length (integer)
可接受的最小密码长度（以字节为单位）。默认值为 8。只有
超级用户可以更改此设置。
注意
如果用户提供了预加密的密码，则此参数无效。
在普通使用中，此参数在
postgresql.conf 中设置，但超级用户可以在自己的会话中动态更改它。典型用法可能是：
# postgresql.conf
passwordcheck.min_password_length = 12
上一页 上一级 下一页F.23. pageinspect — 数据库页面的低级检查 起始页 F.25. pg_buffercache — 检查PostgreSQL
缓冲区缓存状态
