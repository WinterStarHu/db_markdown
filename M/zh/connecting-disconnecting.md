# 3.1 连接和断开服务器_MySQL 8.0 参考手册

3.1 连接和断开服务器_MySQL 8.0 参考手册
Skip to Main Content
Documentation
MySQL手册
MySQL企业版
工作台
InnoDB集群
MySQL NDB集群
连接器
Section Menu:
Documentation Home
MySQL 8.0 参考手册
前言和法律声明
第一章 一般信息
第 2 章安装和升级 MySQL
第 3 章教程
3.1 连接和断开服务器
3.2 输入查询
3.3 创建和使用数据库
3.4 获取有关数据库和表的信息
3.5 在批处理模式下使用 mysql
3.6 常见查询示例
3.7 在 Apache 中使用 MySQL
第 4 章 MySQL 程序
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
第21章InnoDB Cluster
第 22 章 InnoDB 副本集
第 23 章 MySQL NDB Cluster 8.0
第24章分区
第25章存储对象
第 26 章 INFORMATION_SCHEMA 表
第 27 章 MySQL 性能模式
第 28 章 MySQL 系统模式
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 3 章教程  /
3.1 连接和断开服务器
3.1 连接和断开服务器
要连接到服务器，您通常需要在调用mysql时提供 MySQL 用户名，并且很可能需要提供密码。如果服务器在您登录的机器以外的机器上运行，您还必须指定一个主机名。请与您的管理员联系以了解应该使用哪些连接参数进行连接（即要使用的主机、用户名和密码）。知道正确的参数后，您应该能够像这样连接：
$> mysql -h host -u user -p
Enter password: ********
host并
user代表运行 MySQL 服务器的主机名和 MySQL 帐户的用户名。为您的设置替换适当的值。代表您的
********密码；在mysql显示Enter
password:提示
时输入。
如果可行，您应该会看到一些介绍性信息，然后是mysql>提示：
$> mysql -h host -u user -p
Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 25338 to server version: 8.0.31-standard
Type 'help;' or '\h' for help. Type '\c' to clear the buffer.
mysql>mysql>提示符告诉你
mysql已经准备好让你输入sql语句了
。
如果你在运行 MySQL 的同一台机器上登录，你可以省略主机，只需使用以下内容：
$> mysql -u user -p
如果在尝试登录时收到错误消息，例如
ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)，这意味着 MySQL 服务器守护进程 (Unix) 或服务 (Windows) 未运行。请咨询管理员或参阅
第 2 章安装和升级 MySQL中适合您的操作系统的部分。
有关尝试登录时经常遇到的其他问题的帮助，请参阅第 B.3.2 节，“使用 MySQL 程序时的常见错误”。
一些 MySQL 安装允许用户以匿名（未命名）用户的身份连接到在本地主机上运行的服务器。如果你的机器是这种情况，你应该能够通过不带任何选项
调用mysql来连接到该服务器：$> mysql
成功连接后，您可以随时通过在提示符
下键入QUIT（或\q）断开连接：mysql>mysql> QUIT
Bye
在 Unix 上，您也可以通过按 Control+D 来断开连接。
以下部分中的大多数示例都假定您已连接到服务器。他们通过
mysql>提示表明这一点。
© Mysql 中文网
