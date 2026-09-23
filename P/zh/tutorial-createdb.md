# 1.3. 创建数据库

1.3. 创建数据库
版本：
纠错本页面
搜索
目录导航
❮
❯
1.3. 创建数据库 #
看看你能否访问数据库服务器的第一个例子就是试着创建一个数据库。 一台运行着的PostgreSQL服务器可以管理许多数据库。 通常，我们会为每个项目和每个用户单独使用一个数据库。
你的站点管理员可能已经为你创建了可以使用的数据库。 如果是这样，你就可以省略这一步， 并且跳到下一节。
要从命令行创建一个新的数据库，在本例中命名为
mydb，您可以使用以下命令：
$ createdb mydb
如果没有任何响应，则此步骤成功，您可以跳过本节的其他部分。
如果你看到类似下面这样的信息：
createdb: command not found
那么就是PostgreSQL没有安装好。或者是根本没安装， 或者是你的shell搜索路径没有设置正确。尝试用绝对路径调用该命令试试：
$ /usr/local/pgsql/bin/createdb mydb
在你的站点上这个路径可能不一样。和你的站点管理员联系或者查看安装指导以纠正此情况。
另外一种响应可能是这样：
createdb: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: No such file or directory
Is the server running locally and accepting connections on that socket?
这意味着该服务器没有启动，或者在createdb期望去连接它的时候没有在监听。同样， 你也要查看安装指导或者咨询管理员。
另外一个响应可能是这样：
createdb: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: FATAL:  role "joe" does not exist
在这里提到了你自己的登录名。如果管理员没有为你创建PostgreSQL用户帐号， 就会发生这些现象。（PostgreSQL用户帐号和操作系统用户帐号是不同的。） 如果你是管理员，参阅第 21 章获取创建用户帐号的帮助。 你需要变成安装PostgreSQL的操作系统用户的身份（通常是 postgres）才能创建第一个用户帐号。 也有可能是赋予你的PostgreSQL用户名和你的操作系统用户名不同； 这种情况下，你需要使用-U选项或者使用PGUSER环境变量指定你的PostgreSQL用户名。
如果你有个数据库用户帐号，但是没有创建数据库所需要的权限，那么你会看到下面的信息：
createdb: error: database creation failed: ERROR:  permission denied to create database
并非所有用户都被许可创建新数据库。 如果PostgreSQL拒绝为你创建数据库， 那么你需要让站点管理员赋予你创建数据库的权限。出现这种情况时请咨询你的站点管理员。 如果你自己安装了PostgreSQL， 那么你应该以你启动数据库服务器的用户身份登录然后参考手册完成权限的赋予工作。
[1]
你还可以用其他名字创建数据库。PostgreSQL允许你在一个站点上创建任意数量的数据库。 数据库名必须是以字母开头并且小于 63 个字符长。 一个方便的做法是创建和你当前用户名同名的数据库。 许多工具假设该数据库名为缺省数据库名，所以这样可以节省你的敲键。 要创建这样的数据库，只需要键入：
$ createdb
如果你再也不想使用你的数据库了，那么你可以删除它。 比如，如果你是数据库mydb的所有人（创建人）， 那么你就可以用下面的命令删除它：
$ dropdb mydb
（对于这条命令而言，数据库名不是缺省的用户名，因此你就必须声明它） 。这个动作将在物理上把所有与该数据库相关的文件都删除并且不可取消， 因此做这项操作之前一定要考虑清楚。
更多关于createdb和dropdb的信息可以分别在createdb和dropdb中找到。
[1]
为什么这么做的解释：PostgreSQL用户名是和操作系统用户账号分开的。 如果你连接到一个数据库时，你可以选择以何种PostgreSQL用户名进行连接； 如果你不选择，那么缺省就是你的当前操作系统账号。 如果这样，那么总有一个与操作系统用户同名的PostgreSQL用户账号用于启动服务器， 并且通常这个用户都有创建数据库的权限。如果你不想以该用户身份登录， 那么你也可以在任何地方声明一个-U选项以选择一个用于连接的PostgreSQL用户名。
上一页 上一级 下一页1.2. 架构基础 起始页 1.4. 访问数据库
