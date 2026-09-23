# dblink_connect_u

dblink_connect_u
版本：
纠错本页面
搜索
目录导航
❮
❯
dblink_connect_udblink_connect_u — 不安全地打开一个持久连接到远程数据库大纲
dblink_connect_u(text connstr) returns text
dblink_connect_u(text connname, text connstr) returns text
描述
dblink_connect_u()和dblink_connect()一样，不过它将允许非超级用户使用任意认证方式来连接。
如果远程服务器选择了一种不涉及密码的认证方式，那么可能发生模仿以及后续的权限提升，因为该会话看起来像由运行PostgreSQL的用户发起的。此外，即使远程服务器要求密码，也可能从服务器环境提供该密码，例如一个属于服务器用户的~/.pgpass文件。这带来的不仅是模仿的风险，还有将密码暴露给不可信的远程服务器的可能性。因此，dblink_connect_u()最初是用所有从PUBLIC撤销的特权安装的，这让它只能被超级用户调用。在某些情况下，为dblink_connect_u()授予EXECUTE权限给被认为可信的特定用户是合适的，但这应该谨慎进行。我们也推荐任何属于服务器用户的~/.pgpass文件不包含任何指定了通配符主机名的记录。
详见dblink_connect()。
上一页 上一级 下一页dblink_connect 起始页 dblink_disconnect
