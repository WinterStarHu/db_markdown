# 2.4.4 安装和使用 MySQL 首选项面板_MySQL 8.0 参考手册

2.4.4 安装和使用 MySQL 首选项面板_MySQL 8.0 参考手册
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
2.4 在 macOS 上安装 MySQL
2.4.1 macOS 安装MySQL 一般注意事项1
2.4.2 在 macOS 上使用原生包安装 MySQL1
2.4.3 安装和使用MySQL Launch Daemon1
2.4.4 安装和使用 MySQL 首选项面板1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.4 在 macOS 上安装 MySQL  /
2.4.4 安装和使用 MySQL 首选项面板
2.4.4 安装和使用 MySQL 首选项面板
MySQL 安装包包括一个 MySQL 首选项面板，使您能够在 MySQL 安装启动期间启动、停止和控制自动启动。
此首选项面板是默认安装的，并列在系统的“系统首选项”窗口下。
图 2.20 MySQL 首选项面板：位置
MySQL 首选项窗格与安装 MySQL 服务器的相同 DMG 文件一起安装。通常它与 MySQL Server 一起安装，但也可以单独安装。
安装 MySQL 首选项面板：
完成安装 MySQL 服务器的过程，如
第 2.4.2 节“使用本机包在 macOS 上安装 MySQL”中的文档中所述。
在
安装类型步骤中
单击自定义。“首选项窗格”选项列在那里并默认启用；确保它没有被取消选择。可以选择或取消选择其他选项，例如 MySQL 服务器。
图 2.21 MySQL 包安装程序向导：自定义
完成安装过程。
笔记
MySQL 首选项窗格仅启动和停止从已安装在默认位置的 MySQL 包安装中安装的 MySQL 安装。
安装 MySQL 首选项面板后，您可以使用此首选项面板控制 MySQL 服务器实例。
Instances页面包括启动或停止 MySQL
的选项，Initialize Database会重新创建data/
目录。卸载卸载 MySQL 服务器和可选的 MySQL 首选项面板和启动信息。
图 2.22 MySQL 首选项面板：实例
图 2.23 MySQL 首选项面板：初始化数据库
配置页面显示 MySQL 服务器选项，包括 MySQL 配置文件的路径
。
图 2.24 MySQL 首选项面板：配置
MySQL 首选项窗格显示 MySQL 服务器的当前状态，如果服务器未运行则显示停止（红色），如果服务器已启动则显示运行（绿色）。首选项窗格还显示了 MySQL 服务器是否已设置为自动启动的当前设置。
© Mysql 中文网
