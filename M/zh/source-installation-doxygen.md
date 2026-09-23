# 2.9.10 生成MySQL Doxygen文档内容_MySQL 8.0 参考手册

2.9.10 生成MySQL Doxygen文档内容_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.9 从源码安装MySQL  /
2.9.10 生成MySQL Doxygen文档内容
2.9.10 生成MySQL Doxygen文档内容
MySQL 源代码包含使用 Doxygen 编写的内部文档。生成的 Doxygen 内容可在
https://mysql.net.cn/doc/index-other.html获得。也可以使用以下过程从 MySQL 源分发本地生成此内容：
安装doxygen 1.9.2 或更高版本。分发版位于
http://www.doxygen.nl/。
安装doxygen后，验证版本号：
$> doxygen --version
1.9.2
安装
PlantUML。
当您在 Windows 上安装 PlantUML（在 Windows 10 上测试）时，您必须至少以管理员身份运行一次，以便它创建注册表项。打开管理员控制台并运行以下命令：
$> java -jar path-to-plantuml.jar
该命令应打开一个 GUI 窗口，并且不会在控制台上返回任何错误。
将PLANTUML_JAR_PATH环境设置为安装 PlantUML 的位置。例如：
$> export PLANTUML_JAR_PATH=path-to-plantuml.jar
安装
Graphviz
点命令。
安装 Graphviz 后，验证dot
可用性。例如：
$> which dot
/usr/bin/dot
$> dot -V
dot - graphviz version 2.28.0 (20130928.0220)
将位置更改为 MySQL 源代码分发的顶级目录并执行以下操作：
首先，执行cmake：
$> cd your-mysql-source-directory
$> mkdir bld
$> cd bld
$> cmake ..
接下来，生成doxygen文档：
$> make doxygen
检查错误日志。它
doxyerror.log在顶级目录的文件中可用。假设构建成功执行，使用浏览器查看生成的输出。例如：
$> firefox doxygen/html/index.html
© Mysql 中文网
