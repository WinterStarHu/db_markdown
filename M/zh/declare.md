# 13.6.3 DECLARE 语句_MySQL 8.0 参考手册

13.6.3 DECLARE 语句_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.6.1 BEGIN ... END 复合语句1
13.6.2 声明标签1
13.6.3 DECLARE 语句1
13.6.4 存储程序中的变量1
13.6.5 流量控制语句1
13.6.6 游标1
13.6.7 条件处理1
13.6.8 条件处理的限制1
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.6 复合语句语法  /
13.6.3 DECLARE 语句
13.6.3 DECLARE 语句
该DECLARE语句用于定义程序本地的各种项目：
局部变量。请参阅
第 13.6.4 节，“存储程序中的变量”。
条件和处理程序。请参阅
第 13.6.7 节，“条件处理”。
光标。请参阅第 13.6.6 节，“游标”。
DECLARE仅允许在
BEGIN ... END
复合语句内使用，并且必须位于复合语句的开头，位于任何其他语句之前。
声明必须遵循一定的顺序。游标声明必须出现在处理程序声明之前。变量和条件声明必须出现在游标或处理程序声明之前。
© Mysql 中文网
