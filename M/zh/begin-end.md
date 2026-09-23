# 13.6.1 BEGIN ... END 复合语句_MySQL 8.0 参考手册

13.6.1 BEGIN ... END 复合语句_MySQL 8.0 参考手册
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
13.6.1 BEGIN ... END 复合语句
13.6.1 BEGIN ... END 复合语句
[begin_label:] BEGIN
[statement_list]
END [end_label]
BEGIN ... END
语法用于编写复合语句，这些语句可以出现在存储程序（存储过程和函数、触发器和事件）中。复合语句可以包含多个语句，由BEGINand
END关键字括起来。
statement_list表示一个或多个语句的列表，每个语句以分号 ( ;) 语句分隔符终止。The
statement_list本身是可选的，所以空复合语句 ( BEGIN END) 是合法的。
BEGIN ... END
块可以嵌套。
使用多个语句要求客户端能够发送包含;语句定界符的语句字符串。在mysql命令行客户端中，这是用delimiter命令来处理的。更改;语句结束分隔符（例如，更改为//）允许;在程序主体中使用。有关示例，请参阅
第 25.1 节，“定义存储程序”。
块可以BEGIN ...
END被标记。请参阅
第 13.6.2 节，“语句标签”。
[NOT] ATOMIC不支持
可选子句。这意味着在指令块的开头没有设置事务保存点，并且
BEGIN在此上下文中使用的子句对当前事务没有影响。
笔记
在所有存储的程序中，解析器将
BEGIN [WORK]
其视为块的开头
BEGIN ...
END。要在此上下文中开始事务，请
START
TRANSACTION改用。
© Mysql 中文网
