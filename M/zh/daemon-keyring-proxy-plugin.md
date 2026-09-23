# 5.6.8 密钥环代理桥插件_MySQL 8.0 参考手册

5.6.8 密钥环代理桥插件_MySQL 8.0 参考手册
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
5.1 MySQL 服务器
5.2 MySQL数据目录
5.3 mysql系统架构
5.4 MySQL 服务器日志
5.5 MySQL组件
5.6 MySQL 服务器插件
5.6.1 安装和卸载插件1
5.6.2 获取服务器插件信息1
5.6.3 MySQL企业级线程池1
5.6.4 重写器查询重写插件1
5.6.5 ddl_rewriter 插件1
5.6.6 版本令牌1
5.6.7 克隆插件1
5.6.8 密钥环代理桥插件1
5.6.9 MySQL 插件服务1
5.7 MySQL 服务器可加载函数
5.8 在一台机器上运行多个MySQL实例
5.9 调试 MySQL
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
MySQL 8.0 参考手册  / 第 5 章 MySQL 服务器管理  / 5.6 MySQL 服务器插件  /
5.6.8 密钥环代理桥插件
5.6.8 密钥环代理桥插件
MySQL Keyring 最初使用服务器插件实现密钥库功能，但开始过渡到使用 MySQL 8.0.24 中的组件基础结构。过渡包括修改密钥环插件的底层实现以使用组件基础设施。使用 named 插件可以促进这一点，该插件daemon_keyring_proxy_plugin充当插件和组件服务 API 之间的桥梁，并使密钥环插件能够继续使用，而不会改变用户可见的特征。
daemon_keyring_proxy_plugin是内置的，无需安装或启用它。
© Mysql 中文网
