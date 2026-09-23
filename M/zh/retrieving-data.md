# 3.3.4 从表中检索信息_MySQL 8.0 参考手册

3.3.4 从表中检索信息_MySQL 8.0 参考手册
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
3.1 连接和断开服务器
3.2 输入查询
3.3 创建和使用数据库
3.3.1 创建和选择数据库1
3.3.2 创建表1
3.3.3 将数据加载到表中1
3.3.4 从表中检索信息1
3.3.4.1 选择所有数据
3.3.4.2 选择特定行
3.3.4.3 选择特定列
3.3.4.4 排序行
3.3.4.5 日期计算
3.3.4.6 使用 NULL 值
3.3.4.7 模式匹配
3.3.4.8 计数行
3.3.4.9 使用多个表
3.4 获取有关数据库和表的信息
3.5 在批处理模式下使用 mysql
3.6 常见查询示例
3.7 在 Apache 中使用 MySQL
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
MySQL 8.0 参考手册  / 第 3 章教程  / 3.3 创建和使用数据库  /
3.3.4 从表中检索信息
3.3.4 从表中检索信息
3.3.4.1 选择所有数据3.3.4.2 选择特定行3.3.4.3 选择特定列3.3.4.4 排序行3.3.4.5 日期计算3.3.4.6 使用 NULL 值3.3.4.7 模式匹配3.3.4.8 计数行3.3.4.9 使用多个表
该SELECT语句用于从表中提取信息。语句的一般形式是：
SELECT what_to_select
FROM which_table
WHERE conditions_to_satisfy;
what_to_select表示您想看到的内容。这可以是列列表，或
*指示“所有列。”
which_table表示要从中检索数据的表。该WHERE
子句是可选的。如果存在，
conditions_to_satisfy则指定行必须满足才能符合检索条件的一个或多个条件。
© Mysql 中文网
