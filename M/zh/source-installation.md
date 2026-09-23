# 2.9 从源码安装MySQL_MySQL 8.0 参考手册

2.9 从源码安装MySQL_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  /
2.9 从源码安装MySQL
2.9 从源码安装MySQL
2.9.1 源码安装方式2.9.2 源安装先决条件2.9.3 MySQL源码安装布局2.9.4 使用标准源代码分发安装 MySQL2.9.5 使用开发源树安装MySQL2.9.6 配置 SSL 库支持2.9.7 MySQL 源配置选项2.9.8 处理编译MySQL的问题2.9.9 MySQL配置和第三方工具2.9.10 生成MySQL Doxygen文档内容
从源代码构建 MySQL 使您能够自定义构建参数、编译器优化和安装位置。有关已知运行 MySQL 的系统列表，请参阅
https://www.mysql.com/support/supportedplatforms/database.html。
在继续从源安装之前，请检查 Oracle 是否为您的平台生成预编译的二进制分发版以及它是否适合您。我们付出了大量努力来确保我们的二进制文件是使用最佳选项构建的，以获得最佳性能。第 2.2 节“使用通用二进制文件在 Unix/Linux 上安装 MySQL”中提供了安装二进制分发版的说明
。
如果您有兴趣使用与 Oracle 在您的平台上使用相同或相似的构建选项从源代码分发构建 MySQL，以在您的平台上生成二进制分发，请获取二进制分发，将其解压缩，然后查看
docs/INFO_BIN包含有关信息的文件MySQL 发行版是如何配置和编译的。
警告
使用非标准选项构建 MySQL 可能会导致功能、性能或安全性降低。
MySQL 源代码包含使用 Doxygen 编写的内部文档。生成的 Doxygen 内容可在
https://mysql.net.cn/doc/index-other.html获得。也可以使用第 2.9.10 节“生成 MySQL Doxygen 文档内容”中的说明从 MySQL 源代码分发本地生成此内容。
© Mysql 中文网
