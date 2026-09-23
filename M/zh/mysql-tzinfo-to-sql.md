# 4.4.4 mysql_tzinfo_to_sql — 加载时区表_MySQL 8.0 参考手册

4.4.4 mysql_tzinfo_to_sql — 加载时区表_MySQL 8.0 参考手册
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
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.4.1 comp_err——编译MySQL错误信息文件1
4.4.2 mysql_secure_installation——提高MySQL安装安全性1
4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件1
4.4.4 mysql_tzinfo_to_sql — 加载时区表1
4.4.5 mysql_upgrade — 检查和升级 MySQL 表1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.4 安装相关程序  /
4.4.4 mysql_tzinfo_to_sql — 加载时区表
4.4.4 mysql_tzinfo_to_sql — 加载时区表
mysql_tzinfo_to_sql程序加载数据库中的时区表mysql。它用于具有
zoneinfo数据库（描述时区的文件集）的系统。此类系统的示例包括 Linux、FreeBSD、Solaris 和 macOS。这些文件的一个可能位置是/usr/share/zoneinfo
目录（/usr/share/lib/zoneinfo在 Solaris 上）。如果您的系统没有 zoneinfo 数据库，您可以使用
第 5.1.15 节，“MySQL 服务器时区支持”中描述的可下载包。
可以通过多种方式调用
mysql_tzinfo_to_sql ：mysql_tzinfo_to_sql tz_dir
mysql_tzinfo_to_sql tz_file tz_name
mysql_tzinfo_to_sql --leap tz_file
对于第一个调用语法，将 zoneinfo 目录路径名传递给mysql_tzinfo_to_sql并将输出发送到mysql程序。例如：
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
mysql_tzinfo_to_sql读取系统的时区文件并从中生成 SQL 语句。
mysql处理这些语句以加载时区表。
第二种语法导致mysql_tzinfo_to_sqltz_file加载与时区名称相对应
的单个时区文件
tz_name：
mysql_tzinfo_to_sql tz_file tz_name | mysql -u root mysql
如果您的时区需要考虑闰秒，请使用第三种语法调用
mysql_tzinfo_to_sql，这会初始化闰秒信息。
tz_file是您的时区文件的名称：
mysql_tzinfo_to_sql --leap tz_file | mysql -u root mysql
运行mysql_tzinfo_to_sql后，最好重新启动服务器，这样它就不会继续使用任何以前缓存的时区数据。
© Mysql 中文网
