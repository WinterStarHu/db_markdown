# dropuser

dropuser
版本：
纠错本页面
搜索
目录导航
❮
❯
dropuserdropuser — 移除一个PostgreSQL用户账户大纲dropuser [connection-option...] [option...] [username]说明
dropuser 删除一个现有的
PostgreSQL 用户。
超级用户可以使用此命令删除任何角色；否则，只能删除非超级用户角色，
并且只能由拥有CREATEROLE权限并被授予目标角色
ADMIN OPTION的用户执行。
dropuser是SQL命令
DROP ROLE的一个包装器。
在通过这个工具和其他方法访问服务器来删除用户之间没有实质性的区别。
选项
dropuser 接受下列命令行参数：
username
指定要移除的PostgreSQL用户的名字。如果没有在命令行指定并且使用了-i/---interactive选项，你将被提示要求一个用户名。
-e---echo
回显dropuser生成并发送给服务器的命令。
-i---interactive
在实际移除该用户之前提示要求确认，并且在没有在命令行指定用户名时提示要求一个用户名。
-V---version
打印dropuser版本并退出。
---if-exists
如果用户不存在时不要抛出一个错误。在这种情况下将发出一个提示。
-?---help
显示有关dropuser命令行参数的帮助并退出。
dropuser 也接受下列命令行参数作为连接参数：
-h host---host=host
指定运行服务器的机器的主机名。如果该值以一个斜线开始，它被用作Unix域套接字的目录。
-p port---port=port
指定服务器正在监听连接的TCP端口或本地Unix域套接字文件扩展。
-U username---username=username
要作为哪个用户连接。
-w---no-password
不发出口令提示。如果服务器要求口令认证并且没有可用的口令（例如一个.pgpass文件），那么连接尝试将失败。这个选项对于批处理任务和脚本有用，因为在其中没有一个用户来输入口令。
-W---password
强制dropuser在连接到一个数据库之前提示要求一个口令。
这个选项不是必不可少的，因为如果服务器要求口令认证，dropuser将自动提示要求一个口令。但是，dropuser将浪费一次连接尝试来发现服务器想要一个口令。在某些情况下值得用-W来避免额外的连接尝试。
环境PGHOSTPGPORTPGUSER
默认连接参数
PG_COLOR
规定在诊断消息中是否使用颜色。可能的值为always、auto和never。
和大部分其他PostgreSQL工具相似，这个工具也使用libpq（见第 32.15 节）支持的环境变量。
诊断
在有困难时，可以在DROP ROLE和psql中找潜在问题和错误消息的讨论。数据库服务器必须运行在目标主机上。同样，任何libpq前端库使用的默认连接设置和环境变量都将适用于此。
示例
要从默认数据库服务器移除用户joe：
$ dropuser joe
要使用在主机eden、端口5000上的服务器移除用户joe，并带有验证和查看底层命令，可使用下面的命令：
$ dropuser -p 5000 -h eden -i -e joe
Role "joe" will be permanently removed.
Are you sure? (y/n) y
DROP ROLE joe;
另见createuser, DROP ROLE上一页 上一级 下一页dropdb 起始页 ecpg
