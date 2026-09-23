# 10.3.9 字符集和归类分配示例_MySQL 8.0 参考手册

10.3.9 字符集和归类分配示例_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.3.1 归类命名约定1
10.3.2 服务器字符集和排序规则1
10.3.3 数据库字符集和排序规则1
10.3.4 表字符集和排序规则1
10.3.5 列字符集和排序规则1
10.3.6 字符串文字字符集和排序规则1
10.3.7 国家字符集1
10.3.8 字符集介绍者1
10.3.9 字符集和归类分配示例1
10.3.10 与其他 DBMS 的兼容性1
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.3 指定字符集和归类  /
10.3.9 字符集和归类分配示例
10.3.9 字符集和归类分配示例
以下示例显示 MySQL 如何确定默认字符集和排序规则值。
示例 1：表和列定义
CREATE TABLE t1
(
c1 CHAR(10) CHARACTER SET latin1 COLLATE latin1_german1_ci
) DEFAULT CHARACTER SET latin2 COLLATE latin2_bin;
这里我们有一个包含latin1字符集和latin1_german1_ci排序规则的列。定义是明确的，所以这很简单。latin1
请注意，在表中存储列没有问题latin2。
示例 2：表和列定义
CREATE TABLE t1
(
c1 CHAR(10) CHARACTER SET latin1
) DEFAULT CHARACTER SET latin1 COLLATE latin1_danish_ci;
这次我们有一个带有latin1
字符集和默认排序规则的列。虽然这看起来很自然，但默认排序规则并不是从表级别获取的。相反，因为默认排序规则
latin1始终
为latin1_swedish_ci，所以列
c1的排序规则为
latin1_swedish_ci(not
latin1_danish_ci)。
示例 3：表和列定义
CREATE TABLE t1
(
c1 CHAR(10)
) DEFAULT CHARACTER SET latin1 COLLATE latin1_danish_ci;
我们有一个带有默认字符集和默认排序规则的列。在这种情况下，MySQL 检查表级别以确定列字符集和排序规则。因此，列的字符集c1是
latin1，其排序规则是
latin1_danish_ci。
示例 4：数据库、表和列定义
CREATE DATABASE d1
DEFAULT CHARACTER SET latin2 COLLATE latin2_czech_ci;
USE d1;
CREATE TABLE t1
(
c1 CHAR(10)
);
我们创建一个列而不指定其字符集和排序规则。我们也没有在表级别指定字符集和排序规则。在这种情况下，MySQL 检查数据库级别以确定表设置，此后成为列设置。）因此，列的字符集c1是
latin2，其排序规则是
latin2_czech_ci。
© Mysql 中文网
