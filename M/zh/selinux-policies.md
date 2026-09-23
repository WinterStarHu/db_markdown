# 6.7.3 MySQL 服务器 SELinux 策略_MySQL 8.0 参考手册

6.7.3 MySQL 服务器 SELinux 策略_MySQL 8.0 参考手册
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
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.7.1 检查 SELinux 是否开启1
6.7.2 更改 SELinux 模式1
6.7.3 MySQL 服务器 SELinux 策略1
6.7.4 SELinux 文件上下文1
6.7.5 SELinux TCP 端口上下文1
6.7.6 SELinux 故障排除1
6.8 FIPS 支持
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.7 SELinux  /
6.7.3 MySQL 服务器 SELinux 策略
6.7.3 MySQL 服务器 SELinux 策略
MySQL Server SELinux 策略模块通常默认安装。您可以使用
semodule -l命令查看已安装的模块。MySQL Server SELinux 策略模块包括：
mysqld_selinux
mysqld_safe_selinux
有关 MySQL Server SELinux 策略模块的信息，请参阅 SELinux 手册页。手册页提供有关与 MySQL 服务关联的类型和布尔值的信息。手册页以
service-name_selinux
格式命名。
man mysqld_selinux
如果 SELinux 手册页不可用，请参阅您的发行版的 SELinux 文档，了解有关如何使用该sepolicy
manpage实用程序生成手册页的信息。
© Mysql 中文网
