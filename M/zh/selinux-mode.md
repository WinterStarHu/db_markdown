# 6.7.2 更改 SELinux 模式_MySQL 8.0 参考手册

6.7.2 更改 SELinux 模式_MySQL 8.0 参考手册
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
6.7.2 更改 SELinux 模式
6.7.2 更改 SELinux 模式
SELinux 支持强制、许可和禁用模式。强制模式是默认模式。许可模式允许执行模式下不允许的操作，并将这些操作记录到 SELinux 审计日志中。制定策略或故障排除时通常使用许可模式。在禁用模式下，不强制执行策略，并且上下文不应用于系统对象，这使得以后很难启用 SELinux。
要查看当前的 SELinux 模式，请使用前面提到的
sestatus命令或
getenforce实用程序。
$> getenforce
Enforcing
要更改 SELinux 模式，请使用以下setenforce
实用程序：
$> setenforce 0
$> getenforce
Permissive$> setenforce 1
$> getenforce
Enforcing当您重新启动系统时，使用setenforce
所做的更改将丢失。要永久更改 SELinux 模式，请编辑该/etc/selinux/config文件并重新启动系统。
© Mysql 中文网
