# B.3.5 优化器相关问题_MySQL 8.0 参考手册

B.3.5 优化器相关问题_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.9.1 源码安装方式1
2.9.2 源安装先决条件1
2.9.3 MySQL源码安装布局1
2.9.4 使用标准源代码分发安装 MySQL1
2.9.5 使用开发源树安装MySQL1
2.9.6 配置 SSL 库支持1
2.9.7 MySQL 源配置选项1
2.9.8 处理编译MySQL的问题1
B.3.1 如何确定导致问题的原因
B.3.2 使用 MySQL 程序时的常见错误
B.3.3 管理相关问题
B.3.4 查询相关问题
B.3.5 优化器相关问题
B.3.6 表定义相关问题
B.3.7 MySQL 中的已知问题
2.9.9 MySQL配置和第三方工具1
2.9.10 生成MySQL Doxygen文档内容1
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.9 从源码安装MySQL  / 2.9.8 处理编译MySQL的问题  /
B.3.5 优化器相关问题
B.3.5 优化器相关问题
MySQL 使用基于成本的优化器来确定解决查询的最佳方法。在许多情况下，MySQL 可以计算出可能的最佳查询计划，但有时 MySQL 手头没有足够的数据信息，不得不对数据进行“有
根据的”猜测。
对于 MySQL 没有做“正确”事情的情况，可用于帮助 MySQL 的工具有：
使用该EXPLAIN语句获取有关 MySQL 如何处理查询的信息。要使用它，只需将关键字添加
到语句
EXPLAIN的前面
：SELECTmysql> EXPLAIN SELECT * FROM t1, t2 WHERE t1.i = t2.i;
EXPLAIN在第 13.8.2 节“EXPLAIN 语句”中有更详细的讨论。
用于更新扫描表的键分布。请参阅
第 13.7.3.1 节，“ANALYZE TABLE 语句”。
ANALYZE TABLE
tbl_name
用于FORCE INDEX扫描表告诉 MySQL 与使用给定索引相比，表扫描非常昂贵：
SELECT * FROM t1, t2 FORCE INDEX (index_for_column)
WHERE t1.col_name=t2.col_name;
USE INDEX也IGNORE
INDEX可能有用。请参阅
第 8.9.4 节，“索引提示”。
全局和表级STRAIGHT_JOIN。请参阅
第 13.2.10 节，“SELECT 语句”。
您可以调整全局或线程特定的系统变量。例如，使用选项或使用启动mysqld
来告诉
优化器假定没有键扫描会导致超过 1,000 次键查找。请参阅
第 5.1.8 节，“服务器系统变量”。
--max-seeks-for-key=1000SET max_seeks_for_key=1000
© Mysql 中文网
