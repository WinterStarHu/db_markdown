# 20.16. 认证问题

20.16. 认证问题
版本：
纠错本页面
搜索
目录导航
❮
❯
20.16. 认证问题 #
认证失败以及相关的问题通常由类似下面的错误消息显示：
FATAL:  no pg_hba.conf entry for host "123.123.123.123", user "andym", database "testdb"
这条消息最可能出现的情况是你成功地联系了服务器，但它不愿意和你说话。就像消息本身所建议的，服务器拒绝了连接请求，因为它没有在其pg_hba.conf配置文件里找到匹配项。
FATAL:  password authentication failed for user "andym"
这样的消息表示你联系了服务器，并且它也愿意和你交谈，但是你必须通过pg_hba.conf文件中指定的认证方法。检查你提供的口令，或者如果错误消息提到了 Kerberos 或 ident 认证类型，检查那些软件。
FATAL:  user "andym" does not exist
指示的数据库用户名称没有被找到。
FATAL:  database "testdb" does not exist
您尝试连接的数据库不存在。请注意，如果您未指定数据库名称，
它将默认为数据库用户名。
提示
服务器日志可能包含比报告给客户端的更多有关认证失败的信息。如果您对失败的原因感到困惑，请检查服务器日志。
上一页 上一级 下一页20.15. OAuth 授权/认证 起始页 第 21 章 数据库角色
