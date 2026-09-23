# 2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL_MySQL 8.0 参考手册

2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL_MySQL 8.0 参考手册
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
2.3.4.1 提取安装档案
2.3.4.2 创建选项文件
2.3.4.3 选择MySQL服务器类型
2.3.4.4 初始化数据目录
2.3.4.5 首次启动服务器
2.3.4.6 Windows命令行启动MySQL
2.3.4.7 自定义MySQL工具路径
2.3.4.8 将 MySQL 作为 Windows 服务启动
2.3.4.9 测试MySQL安装
2.3.5 Microsoft Windows MySQL 服务器安装故障排除1
2.3.6 Windows 安装后程序1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.3 在 Microsoft Windows 上安装 MySQL  /
2.3.4 使用 noinstall ZIP 存档在 Microsoft Windows 上安装 MySQL
2.3.4 使用
noinstallZIP 存档在 Microsoft Windows 上安装 MySQL
2.3.4.1 提取安装档案2.3.4.2 创建选项文件2.3.4.3 选择MySQL服务器类型2.3.4.4 初始化数据目录2.3.4.5 首次启动服务器2.3.4.6 Windows命令行启动MySQL2.3.4.7 自定义MySQL工具路径2.3.4.8 将 MySQL 作为 Windows 服务启动2.3.4.9 测试MySQL安装
从noinstall
软件包安装的用户可以使用本节中的说明手动安装 MySQL。从 ZIP 存档包安装 MySQL 的过程如下：
将主存档提取到所需的安装目录
可选：如果您计划执行 MySQL 基准测试和测试套件，还提取调试测试存档
创建选项文件
选择 MySQL 服务器类型
初始化MySQL
启动MySQL服务器
保护默认用户帐户
此过程在以下部分中描述。
© Mysql 中文网
