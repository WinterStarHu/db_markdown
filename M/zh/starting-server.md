# 2.10.2 启动服务器_MySQL 8.0 参考手册

2.10.2 启动服务器_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.3.1 MySQL 在Microsoft Windows 上的安装布局1
2.3.2 选择安装包1
2.3.3 Windows 版 MySQL 安装程序1
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL1
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
2.10.1 初始化数据目录
2.10.2 启动服务器
2.10.3 测试服务器
2.10.4 保护初始 MySQL 帐户
2.10.5 自动启动和停止MySQL
2.3.7 Windows 平台限制1
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  / 2.3.6 Windows 安装后程序  /
2.10.2 启动服务器
2.10.2 启动服务器
2.10.2.1 排除MySQL服务器启动问题
本节介绍如何在 Unix 和类 Unix 系统上启动服务器。（对于 Windows，请参阅
第 2.3.4.5 节“首次启动服务器”。）有关可用于测试服务器是否可访问和正常工作的一些建议命令，请参阅第 2.10.3 节“测试服务器” ”。
如果您的安装包括mysqld_safe
，则像这样启动 MySQL 服务器
：
$> bin/mysqld_safe --user=mysql &
笔记
对于使用 RPM 包安装 MySQL 的 Linux 系统，服务器启动和关闭是使用 systemd 而不是mysqld_safe管理的，并且
未安装mysqld_safe 。请参阅
第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
如果您的安装包括 systemd 支持，请像这样启动服务器：
$> systemctl start mysqld
如果与
mysqld（例如，mysql
在 SLES 系统上）不同，请替换为适当的服务名称。
root使用非特权（非）登录帐户
运行 MySQL 服务器很重要。为确保这一点，运行
mysqld_safe asroot并包含--user如图所示的选项。否则，您应该在登录时执行该程序mysql，在这种情况下您可以省略
--user命令中的选项。
有关以非特权用户身份运行 MySQL 的更多说明，请参阅第 6.1.5 节，“如何以普通用户身份运行 MySQL”。
如果命令立即失败并打印mysqld
ended，请在错误日志中查找信息（默认情况下是
host_name.err数据目录中的文件）。
如果服务器无法访问它启动的数据目录或读取mysql模式中的授权表，它会在其错误日志中写入一条消息。如果您在继续执行此步骤之前忽略了通过初始化数据目录来创建授权表，或者如果您运行了初始化数据目录的命令而没有选择该
--user选项，则可能会出现此类问题。删除
data目录并运行带
--user选项的命令。
如果您在启动服务器时遇到其他问题，请参阅
第 2.10.2.1 节，“解决启动 MySQL 服务器的问题”。有关mysqld_safe的更多信息，请参阅
第 4.3.2 节，“mysqld_safe — MySQL 服务器启动脚本”。有关 systemd 支持的更多信息，请参阅第 2.5.9 节，“使用 systemd 管理 MySQL 服务器”。
© Mysql 中文网
