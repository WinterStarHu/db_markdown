# 20.5.2 禁用 X 插件_MySQL 8.0 参考手册

20.5.2 禁用 X 插件_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
20.5.1 检查 X 插件安装1
20.5.2 禁用 X 插件1
20.5.3 使用 X 插件的加密连接1
20.5.4 将 X 插件与缓存 SHA-2 身份验证插件一起使用1
20.5.5 使用 X 插件进行连接压缩1
20.5.6 X 插件选项和变量1
20.5.7 监控 X 插件1
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.5 X 插件  /
20.5.2 禁用 X 插件
20.5.2 禁用 X 插件
X 插件可以在启动时禁用，方法是在 MySQL 配置文件中进行设置
，或者
在启动 MySQL 服务器时
mysqlx=0传入
。--mysqlx=0--skip-mysqlx
或者，使用
-DWITH_MYSQLX=OFFCMake 选项在没有 X 插件的情况下编译 MySQL 服务器。
© Mysql 中文网
