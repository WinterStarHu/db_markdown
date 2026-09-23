# 6.7.5 SELinux TCP 端口上下文_MySQL 8.0 参考手册

6.7.5 SELinux TCP 端口上下文_MySQL 8.0 参考手册
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
6.7.5.1 为 mysqld 设置 TCP 端口上下文
6.7.5.2 设置MySQL特性的TCP端口上下文
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
6.7.5 SELinux TCP 端口上下文
6.7.5 SELinux TCP 端口上下文
6.7.5.1 为 mysqld 设置 TCP 端口上下文6.7.5.2 设置MySQL特性的TCP端口上下文
下面的说明使用semanage
二进制文件来管理端口上下文；在 RHEL 上，它是
policycoreutils-python-utils包的一部分：
yum install -y policycoreutils-python-utils
安装二进制文件后，您可以使用with
选项
semanage列出使用mysqld_port_t
上下文定义的端口。semanageport$> semanage port -l | grep mysqld
mysqld_port_t                  tcp      1186, 3306, 63132-63164
© Mysql 中文网
