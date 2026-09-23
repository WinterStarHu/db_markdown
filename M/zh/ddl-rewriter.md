# 5.6.5 ddl_rewriter 插件_MySQL 8.0 参考手册

5.6.5 ddl_rewriter 插件_MySQL 8.0 参考手册
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
5.6.5.1 安装或卸载 ddl_rewriter
5.6.5.2 ddl_rewriter 插件选项
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
5.6.5 ddl_rewriter 插件
5.6.5 ddl_rewriter 插件
5.6.5.1 安装或卸载 ddl_rewriter5.6.5.2 ddl_rewriter 插件选项
MySQL 8.0.16 及更高版本包含一个ddl_rewriter
插件，可CREATE TABLE
在服务器解析和执行语句之前修改服务器接收到的语句。该插件删除了ENCRYPTION、
DATA DIRECTORY和INDEX
DIRECTORY子句，这在从 SQL 转储文件恢复表时可能会有所帮助，这些文件是从加密的数据库中创建的，或者它们的表存储在数据目录之外。例如，该插件可以将此类转储文件恢复到未加密的实例中，或者恢复到数据目录之外的路径不可访问的环境中。
在使用ddl_rewriter插件之前，请按照
第 5.6.5.1 节“安装或卸载 ddl_rewriter”中提供的说明进行安装。
ddl_rewriter在解析之前检查服务器接收到的 SQL 语句，并根据这些条件重写它们：
ddl_rewriter仅考虑
CREATE TABLE语句，并且仅当它们是出现在输入行开头或准备语句文本开头的独立语句时。ddl_rewriter不考虑CREATE TABLE
存储程序定义中的语句。语句可以扩展到多行。
在考虑重写的语句中，以下子句的实例被重写并且每个实例由一个空格替换：
ENCRYPTION
DATA DIRECTORY（在表和分区级别）
INDEX DIRECTORY（在表和分区级别）
重写不依赖于字母大小写。
如果ddl_rewriter重写语句，它会生成警告：
mysql> CREATE TABLE t (i INT) DATA DIRECTORY '/var/mysql/data';
Query OK, 0 rows affected, 1 warning (0.03 sec)
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Note
Code: 1105
Message: Query 'CREATE TABLE t (i INT) DATA DIRECTORY '/var/mysql/data''
rewritten to 'CREATE TABLE t (i INT) ' by a query rewrite plugin
1 row in set (0.00 sec)
如果启用了通用查询日志或二进制日志，则服务器将在 重写后出现的语句写入其中
ddl_rewriter。
安装后，ddl_rewriter公开 Performance Schemamemory/rewriter/ddl_rewriter
工具以跟踪插件内存使用情况。请参见
第 27.12.20.10 节，“内存汇总表”
© Mysql 中文网
