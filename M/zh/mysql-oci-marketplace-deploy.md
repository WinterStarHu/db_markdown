# 32.2 在 Oracle 云基础设施上部署 MySQL EE_MySQL 8.0 参考手册

32.2 在 Oracle 云基础设施上部署 MySQL EE_MySQL 8.0 参考手册
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
32.1 在 Oracle Cloud Infrastructure 上部署 MySQL EE 的先决条件
32.2 在 Oracle 云基础设施上部署 MySQL EE
32.3 配置网络访问
32.4 连接
32.5 维护
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 32 章 OCI 市场上的 MySQL  /
32.2 在 Oracle 云基础设施上部署 MySQL EE
32.2 在 Oracle 云基础设施上部署 MySQL EE
要在 Oracle Cloud Infrastructure 上部署 MySQL EE，请执行以下操作：
打开 OCI Marketplace 并选择
MySQL。
显示MySQL列表。
单击Launch Instance开始应用程序启动过程。
显示创建计算实例对话框。
有关如何填写字段的信息，
请参阅
创建 Linux 实例。
默认情况下，MySQL 服务器侦听端口 3306 并配置有一个用户 root。
重要的
部署完成并启动 MySQL 服务器后，您必须连接到计算实例并检索写入 MySQL 日志文件的默认根密码。
有关详细信息，请参阅使用 SSH 连接。
安装了以下 MySQL 软件：
MySQL服务器EE
MySQL 企业备份
MySQL外壳
路由器
MySQL配置
为了安全起见，启用了以下功能：
SELinux：有关更多信息，请参阅
配置和使用 SELinux
firewalld：有关更多信息，请参阅
控制 firewalld 防火墙服务
启用了以下 MySQL 插件：
thread_pool
validate_password
启动时，会发生以下情况：
MySQL 服务器读取/etc/my.cnf所有
*.cnf以
/etc/my.cnf.d/.
/etc/my.cnf.d/perf-tuning.cnf/usr/bin/mkcnf基于选定的 OCI 形状
创建。
笔记
要禁用此机制，请删除
/etc/systemd/system/mysqld.service.d/perf-tuning.conf.
性能调整配置为以下形状：
VM.Standard2.1
VM.Standard2.2
VM.Standard2.4
VM.Standard2.8
VM.Standard2.16
VM.Standard2.24
VM.标准.E2.1
VM.标准.E2.2
VM.标准.E2.4
VM.标准.E2.8
VM.标准.E3.Flex
VM.标准.E4.Flex
BM.Standard2.52
对于所有其他形状，使用 VM.Standard2.1 的调整。
© Mysql 中文网
