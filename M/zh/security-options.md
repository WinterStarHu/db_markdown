# 6.1.4 安全相关的 mysqld 选项和变量_MySQL 8.0 参考手册

6.1.4 安全相关的 mysqld 选项和变量_MySQL 8.0 参考手册
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
6.1.1 安全指南1
6.1.2 保证密码安全1
6.1.3 使 MySQL 免受攻击1
6.1.4 安全相关的 mysqld 选项和变量1
6.1.5 如何以普通用户运行MySQL1
6.1.6 LOAD DATA LOCAL 的安全注意事项1
6.1.7 客户端编程安全指南1
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.1 一般安全问题  /
6.1.4 安全相关的 mysqld 选项和变量
6.1.4 安全相关的 mysqld 选项和变量
下表显示了影响安全性的mysqld选项和系统变量。有关其中每一项的描述，请参阅第 5.1.7 节，“服务器命令选项”和
第 5.1.8 节，“服务器系统变量”。
表 6.1 安全选项和变量摘要
姓名
命令行
选项文件
系统变量
状态变量
可变范围
动态的
允许可疑的 udfs
是的
是的
automatic_sp_privileges
是的
是的
是的
全球的
是的
chroot
是的
是的
本地文件
是的
是的
是的
全球的
是的
安全用户创建
是的
是的
secure_file_priv
是的
是的
是的
全球的
不
跳过授权表
是的
是的
skip_name_resolve
是的
是的
是的
全球的
不
跳过网络
是的
是的
是的
全球的
不
跳过显示数据库
是的
是的
是的
全球的
不
© Mysql 中文网
