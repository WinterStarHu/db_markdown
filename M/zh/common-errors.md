# B.3.2 使用 MySQL 程序时的常见错误_MySQL 8.0 参考手册

B.3.2 使用 MySQL 程序时的常见错误_MySQL 8.0 参考手册
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
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.9.1 源码安装方式1
2.9.2 源安装先决条件1
2.9.3 MySQL源码安装布局1
2.9.4 使用标准源代码分发安装 MySQL1
2.9.5 使用开发源树安装MySQL1
2.9.6 配置 SSL 库支持1
2.9.7 MySQL 源配置选项1
2.9.8 处理编译MySQL的问题1
B.3.1 如何确定导致问题的原因
B.3.2 使用 MySQL 程序时的常见错误
B.3.3 管理相关问题
B.3.4 查询相关问题
B.3.5 优化器相关问题
B.3.6 表定义相关问题
B.3.7 MySQL 中的已知问题
2.9.9 MySQL配置和第三方工具1
2.9.10 生成MySQL Doxygen文档内容1
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.9 从源码安装MySQL  / 2.9.8 处理编译MySQL的问题  /
B.3.2 使用 MySQL 程序时的常见错误
B.3.2 使用 MySQL 程序时的常见错误
B.3.2.1 拒绝访问B.3.2.2 无法连接到 [本地] MySQL 服务器B.3.2.3 失去与 MySQL 服务器的连接B.3.2.4 交互输入密码失败B.3.2.5 连接太多B.3.2.6 内存不足B.3.2.7 MySQL 服务器消失了B.3.2.8 包太大B.3.2.9 通信错误和中止连接B.3.2.10 表已满B.3.2.11 无法创建/写入文件B.3.2.12 命令不同步B.3.2.13 忽略用户B.3.2.14 表‘tbl_name’不存在B.3.2.15 无法初始化字符集B.3.2.16 找不到文件和类似错误B.3.2.17 表损坏问题
本节列出了用户在运行 MySQL 程序时经常遇到的一些错误。虽然当您尝试运行客户端程序时会出现问题，但许多问题的解决方案涉及更改 MySQL 服务器的配置。
© Mysql 中文网
