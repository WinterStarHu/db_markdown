# 20.4.1 MySQL 外壳_MySQL 8.0 参考手册

20.4.1 MySQL 外壳_MySQL 8.0 参考手册
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
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
第 16 章替代存储引擎
第十七章复制
第十八章 组复制
第十九章MySQL Shell
第 20 章使用 MySQL 作为文档存储
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.4.1 MySQL 外壳1
20.4.2 下载导入world_x数据库1
20.4.3 文件和收藏1
20.4.4 关系表1
20.4.5 表格中的文件1
20.5 X 插件
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.4 Python 快速入门指南：用于文档存储的 MySQL Shell  /
20.4.1 MySQL 外壳
20.4.1 MySQL 外壳
本快速入门指南假设您对 MySQL Shell 有一定程度的熟悉。以下部分是一个高级概述，请参阅 MySQL Shell 文档以获取更多信息。MySQL Shell 是 MySQL Server 的统一脚本接口。它支持使用 JavaScript 和 Python 编写脚本。JavaScript 是默认的处理模式。
启动 MySQL 外壳
安装并启动 MySQL 服务器后，将 MySQL Shell 连接到服务器实例。您需要知道您计划连接的 MySQL 服务器实例的地址。为了能够将实例用作文档存储，服务器实例必须安装 X 插件并且您应该使用 X 协议连接到服务器。例如，要连接到ds1.example.com默认 X 协议端口 33060 上的实例，请使用网络字符串
user@ds1.example.com:33060。
小费
如果您使用经典 MySQL 协议连接到实例，例如使用默认
port的 3306 而不是 ，
mysqlx_port则
无法使用本教程中显示的文档存储功能。例如，
db未填充全局对象。要使用文档存储，请始终使用 X 协议进行连接。
如果 MySQL Shell 尚未运行，请打开终端窗口并发出：
mysqlsh user@ds1.example.com:33060/world_x
或者，如果 MySQL Shell 已经在运行，请
\connect通过发出以下命令使用命令：
\connect user@ds1.example.com:33060/world_x
您需要指定要连接 MySQL Shell 的 MySQL 服务器实例的地址。例如在前面的例子中：
user代表您的 MySQL 帐户的用户名。
ds1.example.com是运行 MySQL 的服务器实例的主机名。将其替换为您用作文档存储的 MySQL 服务器实例的主机名。
此会话的默认架构是
world_x. 有关设置world_x模式的说明，请参阅
第 20.4.2 节，“下载和导入 world_x 数据库”。
有关详细信息，请参阅
第 4.2.5 节，“使用类似 URI 的字符串或键值对连接到服务器”。
一旦 MySQL Shell 打开，mysql-js>
提示表明此会话的活动语言是 JavaScript。要将 MySQL Shell 切换到 Python 模式，请使用
\py命令。
mysql-js> \py
Switching to Python mode...
mysql-py>
MySQL Shell 支持输入行编辑，如下所示：
左箭头键和右箭头
键在当前输入行内水平移动。
向上箭头键和向下箭头
键在先前输入的行中上下移动。
退格键删除光标前的字符，键入新字符会在光标位置输入新字符。
Enter将当前输入行发送到服务器。
获取 MySQL Shell 的帮助
在命令解释器的提示符下键入mysqlsh --help以获得命令行选项列表。
mysqlsh --help
在 MySQL Shell 提示符下键入\help可用命令及其描述的列表。
mysql-py> \help
键入\help后跟命令名称以获得有关单个 MySQL Shell 命令的详细帮助。例如，要查看\connect
命令的帮助，请发出：
mysql-py> \help \connect
退出 MySQL 外壳
要退出 MySQL Shell，请发出以下命令：
mysql-py> \quit
相关信息
有关交互式代码执行
如何在 MySQL Shell 中工作的说明，请参阅交互式代码执行。
请参阅MySQL Shell 入门以了解会话和连接替代方案。
© Mysql 中文网
