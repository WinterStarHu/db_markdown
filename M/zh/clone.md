# 13.7.5 CLONE 语句_MySQL 8.0 参考手册

13.7.5 CLONE 语句_MySQL 8.0 参考手册
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
第 5 章 MySQL 服务器管理
第 6 章 安全
第 7 章备份与恢复
第8章优化
第9章语言结构
第 10 章字符集、排序规则、Unicode
第 11 章数据类型
第 12 章函数和运算符
第 13 章 SQL 语句
13.1 数据定义语句
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.7 数据库管理语句
13.7.1 账户管理报表1
13.7.2 资源组管理语句1
13.7.3 表维护语句1
13.7.4 组件、插件和可加载函数语句1
13.7.5 CLONE 语句1
13.7.6 SET 语句1
13.7.7 显示语句1
13.7.8 其他行政报表1
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.7 数据库管理语句  /
13.7.5 CLONE 语句
13.7.5 CLONE 语句
CLONE clone_action
clone_action: {
LOCAL DATA DIRECTORY [=] 'clone_dir';
| INSTANCE FROM 'user'@'host':port
IDENTIFIED BY 'password'
[DATA DIRECTORY [=] 'clone_dir']
[REQUIRE [NO] SSL]
}
该CLONE语句用于在本地或从远程 MySQL 服务器实例克隆数据。要使用
CLONE语法，必须安装克隆插件。请参阅第 5.6.7 节，“克隆插件”。
CLONE LOCAL DATA
DIRECTORY语法将数据从本地 MySQL 数据目录克隆到运行 MySQL 服务器实例的同一服务器或节点上的目录。该'clone_dir'
目录是数据克隆到的本地目录的完整路径。需要绝对路径。指定的目录不能存在，但指定的路径必须是存在的路径。MySQL 服务器需要必要的写入权限才能创建指定的目录。有关详细信息，请参阅
第 5.6.7.2 节，“本地克隆数据”。
CLONE INSTANCE
语法从远程 MySQL 服务器实例（捐赠者）克隆数据并将其传输到发起克隆操作的 MySQL 实例（接收者）。
user是捐赠者 MySQL 服务器实例上的克隆用户。
host是
hostname捐赠者 MySQL 服务器实例的地址。不支持 Internet 协议版本 6 (IPv6) 地址格式。可以改用 IPv6 地址的别名。可以按原样使用 IPv4 地址。
port是
port捐赠者 MySQL 服务器实例的编号。（不支持指定的X Protocol端口，
mysqlx_port也不支持通过MySQL Router连接到donor MySQL服务器实例。）
IDENTIFIED BY
'password'指定捐赠者 MySQL 服务器实例上克隆用户的密码。
DATA DIRECTORY [=]
'clone_dir'是一个可选子句，用于为您正在克隆的数据指定接收方的目录。如果您不想删除收件人数据目录中的现有数据，请使用此选项。需要绝对路径，并且目录不能存在。MySQL 服务器必须具有创建目录所需的写入权限。
当不使用可选子句时，克隆操作会删除接收方数据目录中的现有数据，将其替换为克隆的数据，然后自动重新启动服务器。
DATA DIRECTORY [=]
'clone_dir'
[REQUIRE [NO] SSL]明确指定在通过网络传输克隆数据时是否使用加密连接。如果不能满足显式规范，则返回错误。如果未指定 SSL 子句，则默认情况下克隆会尝试建立加密连接，如果安全连接尝试失败，则回退到不安全的连接。无论是否指定此子句，克隆加密数据时都需要安全连接。有关详细信息，请参阅
为克隆配置加密连接。
有关从远程 MySQL 服务器实例克隆数据的其他信息，请参阅第 5.6.7.3 节，“克隆远程数据”。
© Mysql 中文网
