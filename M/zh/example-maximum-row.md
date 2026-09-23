# 3.6.2 某列最大值所在的行_MySQL 8.0 参考手册

3.6.2 某列最大值所在的行_MySQL 8.0 参考手册
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
3.6.2 某列最大值所在的行
3.6.2 某列最大值所在的行
任务：找出最贵商品的编号、经销商和价格。
这很容易通过子查询完成：
SELECT article, dealer, price
FROM   shop
WHERE  price=(SELECT MAX(price) FROM shop);
+---------+--------+-------+
| article | dealer | price |
+---------+--------+-------+
|    0004 | D      | 19.95 |
+---------+--------+-------+
另一种解决方案是使用 a LEFT JOIN，如下所示：
SELECT s1.article, s1.dealer, s1.price
FROM shop s1
LEFT JOIN shop s2 ON s1.price < s2.price
WHERE s2.article IS NULL;
您还可以通过按价格降序排列所有行并使用 MySQL 特定
LIMIT子句仅获取第一行来执行此操作，如下所示：
SELECT article, dealer, price
FROM shop
ORDER BY price DESC
LIMIT 1;
笔记
如果有几件最贵的商品，每件价格为 19.95，则LIMIT解决方案将只显示其中一件。
© Mysql 中文网
