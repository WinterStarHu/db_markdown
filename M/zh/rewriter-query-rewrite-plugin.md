# 5.6.4 重写器查询重写插件_MySQL 8.0 参考手册

5.6.4 重写器查询重写插件_MySQL 8.0 参考手册
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
5.6.4.1 安装或卸载 Rewriter 查询重写插件
5.6.4.2 使用重写器查询重写插件
5.6.4.3 Rewriter Query Rewrite 插件参考
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
5.6.4 重写器查询重写插件
5.6.4 重写器查询重写插件
5.6.4.1 安装或卸载 Rewriter 查询重写插件5.6.4.2 使用重写器查询重写插件5.6.4.3 Rewriter Query Rewrite 插件参考
MySQL 支持查询重写插件，可以在服务器执行之前检查并可能修改服务器接收到的 SQL 语句。请参阅查询重写插件。
MySQL 发行版包括一个名为 postparse 查询重写的插件
Rewriter和用于安装该插件及其相关元素的脚本。这些元素协同工作以提供语句重写功能：
一个名为 examines statements 的服务器端插件Rewriter
可以根据其内存中的重写规则缓存来重写它们。
这些陈述可能会被重写：
从 MySQL 8.0.12 开始：SELECT、
INSERT、
REPLACE、
UPDATE和
DELETE。
MySQL 8.0.12 之前：
SELECT仅。
独立语句和准备好的语句可能会被重写。视图定义或存储程序中出现的语句不会被重写。
该Rewriter插件使用一个名为 的数据库
query_rewrite，其中包含一个名为 的表
rewrite_rules。该表为插件用来决定是否重写语句的规则提供持久存储。用户通过修改存储在该表中的规则集与插件进行通信。该插件通过设置
message表格行的列与用户进行通信。
query_rewrite数据库包含一个名为的存储过程
，flush_rewrite_rules()它将规则表的内容加载到插件中。
名为的可加载函数
load_rewrite_rules()由flush_rewrite_rules()存储过程使用。
该Rewriter插件公开了启用插件配置的系统变量和提供运行时操作信息的状态变量。在 MySQL 8.0.31 及更高版本中，此插件还支持SKIP_QUERY_REWRITE保护给定用户的查询不被重写的权限 ( )。
以下部分介绍如何安装和使用
Rewriter插件，并提供其相关元素的参考信息。
© Mysql 中文网
