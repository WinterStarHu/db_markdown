# 25.2.2 存储例程和 MySQL 权限_MySQL 8.0 参考手册

25.2.2 存储例程和 MySQL 权限_MySQL 8.0 参考手册
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
25.2.1 存储例程语法1
25.2.2 存储例程和 MySQL 权限1
25.2.3 存储例程元数据1
25.2.4 存储过程、函数、触发器和 LAST_INSERT_ID()1
25.3 使用触发器
25.4 使用事件调度器
25.5 使用视图
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.2 使用存储例程  /
25.2.2 存储例程和 MySQL 权限
25.2.2 存储例程和 MySQL 权限
MySQL 授权系统将存储的例程考虑如下：
CREATE ROUTINE创建存储例程需要特权
。ALTER ROUTINE需要特权才能更改或删除存储的例程
。如有必要，此权限会自动授予例程的创建者，并在删除例程时从创建者处删除。
执行EXECUTE存储例程需要特权。但是，如有必要，此权限会自动授予例程的创建者（并在删除例程时从创建者处删除）。此外，例程的默认SQL SECURITY
特征是DEFINER，它使有权访问与例程关联的数据库的用户能够执行例程。
如果
automatic_sp_privileges
系统变量为 0，
则不会自动向例程创建者授予和删除权限
EXECUTE。
ALTER ROUTINE
例程的创建者是用于为其执行
CREATE语句的帐户。这可能与
DEFINER在例程定义中命名为的帐户不同。
命名为例程的帐户DEFINER可以查看所有例程属性，包括其定义。因此，该帐户可以完全访问由以下人员生成的例程输出：
表的内容
INFORMATION_SCHEMA.ROUTINES
。
和SHOW CREATE FUNCTION
语句SHOW CREATE PROCEDURE
。
和SHOW FUNCTION CODE语句
SHOW PROCEDURE CODE
。
和SHOW FUNCTION STATUS
语句SHOW PROCEDURE STATUS
。
对于名为 routine 的帐户以外的帐户
DEFINER，对例程属性的访问取决于授予该帐户的权限：
具有SHOW_ROUTINE
权限或全局
SELECT权限的帐户可以查看所有例程属性，包括其定义。
通过在包含例程的范围内授予
CREATE ROUTINE,
ALTER ROUTINE或
特权，该帐户可以查看除其定义之外的所有例程属性。EXECUTE
© Mysql 中文网
