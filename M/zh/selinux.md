# 6.7 SELinux_MySQL 8.0 参考手册

6.7 SELinux_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 6 章 安全  /
6.7 SELinux
6.7 SELinux
6.7.1 检查 SELinux 是否开启6.7.2 更改 SELinux 模式6.7.3 MySQL 服务器 SELinux 策略6.7.4 SELinux 文件上下文6.7.5 SELinux TCP 端口上下文6.7.6 SELinux 故障排除
Security-Enhanced Linux (SELinux) 是一种强制访问控制 (MAC) 系统，它通过将称为SELinux 上下文的安全标签应用于每个系统对象来实现访问权限。SELinux 策略模块使用 SELinux 上下文来定义进程、文件、端口和其他系统对象如何相互交互的规则。只有在策略规则允许的情况下，系统对象之间的交互才被允许。
SELinux 上下文（应用于系统对象的标签）具有以下字段：user、role、
type和security level。类型信息而不是整个 SELinux 上下文最常用于定义进程如何与其他系统对象交互的规则。例如，MySQL SELinux 策略模块使用type信息定义策略规则。
您可以使用操作系统命令（例如带
选项的ls和ps ）查看 SELinux 上下文。-Z假设 SELinux 已启用并且 MySQL 服务器正在运行，以下命令显示mysqld进程和 MySQL 数据目录的 SELinux 上下文：
mysqld进程：
$> ps -eZ | grep mysqld
system_u:system_r:mysqld_t:s0    5924 ?        00:00:03 mysqld
MySQL数据目录：
$> cd /var/lib
$> ls -Z | grep mysql
system_u:object_r:mysqld_db_t:s0 mysql
在哪里：
system_u是系统进程和对象的 SELinux 用户标识。
system_r是用于系统进程的 SELinux 角色。
objects_r是用于系统对象的 SELinux 角色。
mysqld_t是与 mysqld 进程关联的类型。
mysqld_db_t是与 MySQL 数据目录及其文件关联的类型。
s0是安全级别。
有关解释 SELinux 上下文的更多信息，请参阅您的发行版的 SELinux 文档。
© Mysql 中文网
