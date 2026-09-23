# 3.6.7 搜索两个键_MySQL 8.0 参考手册

3.6.7 搜索两个键_MySQL 8.0 参考手册
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
3.4 获取有关数据库和表的信息
3.5 在批处理模式下使用 mysql
3.6 常见查询示例
3.6.1 列的最大值1
3.6.2 某列最大值所在的行1
3.6.3 每组最大列数1
3.6.4 拥有某列分组最大值的行1
3.6.5 使用用户自定义变量1
3.6.6 使用外键1
3.6.7 搜索两个键1
3.6.8 计算每天的访问量1
3.6.9 使用 AUTO_INCREMENT1
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
MySQL 8.0 参考手册  / 第 3 章教程  / 3.6 常见查询示例  /
3.6.7 搜索两个键
3.6.7 搜索两个键
一个OR使用单个键的优化很好，处理也是如此
AND。
一个棘手的案例是搜索两个不同的键结合OR：
SELECT field1_index, field2_index FROM test_table
WHERE field1_index = '1' OR  field2_index = '1'
这个案例是优化过的。请参阅
第 8.2.1.3 节，“索引合并优化”。
您还可以通过使用
UNION组合两个单独SELECT语句的输出的 a 来有效地解决问题。请参阅第 13.2.10.3 节，“UNION 子句”。
每个SELECT只搜索一个键并且可以优化：
SELECT field1_index, field2_index
FROM test_table WHERE field1_index = '1'
UNION
SELECT field1_index, field2_index
FROM test_table WHERE field2_index = '1';
© Mysql 中文网
