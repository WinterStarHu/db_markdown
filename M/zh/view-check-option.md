# 25.5.4 WITH CHECK OPTION 子句的视图_MySQL 8.0 参考手册

25.5.4 WITH CHECK OPTION 子句的视图_MySQL 8.0 参考手册
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
25.1 定义存储程序
25.2 使用存储例程
25.3 使用触发器
25.4 使用事件调度器
25.5 使用视图
25.5.1 查看语法1
25.5.2 视图处理算法1
25.5.3 可更新和可插入视图1
25.5.4 WITH CHECK OPTION 子句的视图1
25.5.5 查看元数据1
25.6 存储对象访问控制
25.7 存储程序二进制日志记录
25.8 存储程序的限制
25.9 视图限制
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.5 使用视图  /
25.5.4 WITH CHECK OPTION 子句的视图
25.5.4 WITH CHECK OPTION 子句的视图
WITH CHECK OPTION可以为可更新视图提供该子句，以防止插入到
子句WHERE不
select_statement正确的行。它还会阻止更新WHERE
子句为真但更新会导致它不为真的行（换句话说，它会阻止可见行更新为不可见行）。
在WITH CHECK OPTION可更新视图的子句中，LOCAL和CASCADED
关键字确定根据另一个视图定义视图时检查测试的范围。当两个关键字都没有给出时，默认为CASCADED.
WITH CHECK OPTION测试符合标准：
使用LOCAL，检查视图
WHERE子句，然后检查递归到基础视图并应用相同的规则。
使用CASCADED，检查视图
WHERE子句，然后检查递归到基础视图，添加WITH CASCADED
CHECK OPTION到它们（为了检查的目的；它们的定义保持不变），并应用相同的规则。
如果没有检查选项，则不检查视图WHERE子句，然后检查递归到基础视图，并应用相同的规则。
考虑下表和视图集的定义：
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a < 2
WITH CHECK OPTION;
CREATE VIEW v2 AS SELECT * FROM v1 WHERE a > 0
WITH LOCAL CHECK OPTION;
CREATE VIEW v3 AS SELECT * FROM v1 WHERE a > 0
WITH CASCADED CHECK OPTION;
这里的v2和v3视图是根据另一个视图定义的v1。
v2针对其
检查选项检查
插入LOCAL，然后检查递归到
v1并再次应用规则。v1导致检查失败的规则。检查
v3也失败了：
mysql> INSERT INTO v2 VALUES (2);
ERROR 1369 (HY000): CHECK OPTION failed 'test.v2'
mysql> INSERT INTO v3 VALUES (2);
ERROR 1369 (HY000): CHECK OPTION failed 'test.v3'
© Mysql 中文网
