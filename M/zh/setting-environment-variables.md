# 4.2.9 设置环境变量_MySQL 8.0 参考手册

4.2.9 设置环境变量_MySQL 8.0 参考手册
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
第 4 章 MySQL 程序
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.2.1 调用MySQL程序1
4.2.2 指定程序选项1
4.2.3 连接服务器的命令选项1
4.2.4 使用命令选项连接到 MySQL 服务器1
4.2.5 使用类似 URI 的字符串或键值对连接到服务器1
4.2.6 使用 DNS SRV 记录连接到服务器1
4.2.7 连接传输协议1
4.2.8 连接压缩控制1
4.2.9 设置环境变量1
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.2 使用 MySQL 程序  /
4.2.9 设置环境变量
4.2.9 设置环境变量
可以在命令提示符处设置环境变量以影响命令处理器的当前调用，或永久设置以影响将来的调用。要永久设置一个变量，您可以在启动文件中设置它，或者使用您的系统为此目的提供的界面。有关特定详细信息，请参阅命令解释器的文档。
第 4.9 节，“环境变量”，列出了所有影响 MySQL 程序运行的环境变量。
要为环境变量指定值，请使用适合您的命令处理器的语法。例如，在 Windows 上，您可以设置USER变量来指定您的 MySQL 帐户名。为此，请使用以下语法：
SET USER=your_name
Unix 上的语法取决于您的 shell。假设您想使用
MYSQL_TCP_PORT变量指定 TCP/IP 端口号。典型语法（例如sh、ksh、
bash、zsh等）如下所示：
MYSQL_TCP_PORT=3306
export MYSQL_TCP_PORT
第一个命令设置变量，然后
export命令将变量导出到 shell 环境，以便 MySQL 和其他进程可以访问它的值。
对于csh和tcsh，使用
setenv使 shell 变量对环境可用：
setenv MYSQL_TCP_PORT 3306
设置环境变量的命令可以在您的命令提示符下执行以立即生效，但这些设置仅在您注销之前一直存在。要使设置在您每次登录时生效，请使用系统提供的界面或将适当的命令或命令放入命令解释器每次启动时读取的启动文件中。
在 Windows 上，您可以使用系统控制面板（在高级下）设置环境变量。
在 Unix上
，典型的 shell 启动文件是
.bashrcor .bash_profile
for bash或tcsh.tcshrc。
假设您的 MySQL 程序已安装，
/usr/local/mysql/bin并且您希望能够轻松调用这些程序。为此，请将
PATH环境变量的值设置为包含该目录。例如，如果您的 shell 是bash，请将以下行添加到您的.bashrc文件中：
PATH=${PATH}:/usr/local/mysql/bin
bash对登录和非登录 shell 使用不同的启动文件，因此您可能希望将设置添加到
.bashrc登录 shell 和
.bash_profile以确保PATH无论如何设置。
如果您的 shell 是tcsh，请将以下行添加到您的.tcshrc文件中：
setenv PATH ${PATH}:/usr/local/mysql/bin
如果您的主目录中不存在适当的启动文件，请使用文本编辑器创建它。
修改PATH设置后，在 Windows 上打开一个新的控制台窗口或在 Unix 上重新登录以使设置生效。
© Mysql 中文网
