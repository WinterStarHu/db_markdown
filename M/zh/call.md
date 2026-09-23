# 13.2.1 CALL 语句_MySQL 8.0 参考手册

13.2.1 CALL 语句_MySQL 8.0 参考手册
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
13.2.1 CALL 语句1
13.2.2 删除语句1
13.2.3 DO 声明1
13.2.4 HANDLER 语句1
13.2.5 导入表语句1
13.2.6 插入语句1
13.2.7 加载数据语句1
13.2.8 加载 XML 语句1
13.2.9 REPLACE 语句1
13.2.10 SELECT 语句1
13.2.11 子查询1
13.2.12 TABLE 语句1
13.2.13 更新语句1
13.2.14 VALUES 语句1
13.2.15 WITH（公用表表达式）1
13.2.12 集合操作1
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.2 数据操作语句  /
13.2.1 CALL 语句
13.2.1 CALL 语句
CALL sp_name([parameter[,...]])
CALL sp_name[()]
该CALL语句调用之前使用 定义的存储过程
CREATE PROCEDURE。
可以在没有括号的情况下调用不带参数的存储过程。也就是说，CALL p()和
CALL p是等价的。
CALLOUT可以使用声明为或参数的参数将值传回其调用者
INOUT。当过程返回时，客户端程序还可以获得在例程中执行的最终语句受影响的行数： 在 SQL 级别，调用
ROW_COUNT()函数；从 C API 调用
mysql_affected_rows()函数。
有关未处理条件对过程参数的影响的信息，请参阅
第 13.6.7.8 节，“条件处理和 OUT 或 INOUT 参数”。
OUT要使用or参数
从过程中取回值
INOUT，请通过用户变量传递参数，然后在过程返回后检查变量的值。（如果从另一个存储过程或函数中调用该过程，您还可以将例程参数或局部例程变量作为INorINOUT
参数传递。）对于INOUT参数，在将其传递给过程之前初始化其值。以下过程具有OUT该过程设置为当前服务器版本的参数，以及
INOUT该过程从其当前值递增 1 的值：
CREATE PROCEDURE p (OUT ver_param VARCHAR(25), INOUT incr_param INT)
BEGIN
# Set value of OUT parameter
SELECT VERSION() INTO ver_param;
# Increment value of INOUT parameter
SET incr_param = incr_param + 1;
END;
在调用过程之前，初始化要作为INOUT参数传递的变量。调用该过程后，您可以看到两个变量的值被设置或修改：
mysql> SET @increment = 10;
mysql> CALL p(@version, @increment);
mysql> SELECT @version, @increment;
+--------------------+------------+
| @version           | @increment |
+--------------------+------------+
| 8.0.3-rc-debug-log |         11 |
+--------------------+------------+
在与和
一起使用的准备好的CALL语句中，占位符可用于参数、 和
参数。这些类型的参数可以按如下方式使用：
PREPAREEXECUTEINOUTINOUTmysql> SET @increment = 10;
mysql> PREPARE s FROM 'CALL p(?, ?)';
mysql> EXECUTE s USING @version, @increment;
mysql> SELECT @version, @increment;
+--------------------+------------+
| @version           | @increment |
+--------------------+------------+
| 8.0.3-rc-debug-log |         11 |
+--------------------+------------+
要编写使用
CALLSQL 语句执行生成结果集的存储过程
的 C 程序，CLIENT_MULTI_RESULTS必须启用该标志。这是因为CALL除了过程中执行的语句可能返回的任何结果集之外，每个函数都返回一个结果来指示调用状态。如果用于执行包含准备好的语句的任何存储过程，CLIENT_MULTI_RESULTS则也必须启用。CALL无法确定何时加载这样的过程，这些语句是否会产生结果集，因此有必要假设它们会产生结果集。
CLIENT_MULTI_RESULTS可以在调用时启用mysql_real_connect()，可以显式地传递CLIENT_MULTI_RESULTS
标志本身，也可以隐式地传递
CLIENT_MULTI_STATEMENTS（这也启用
CLIENT_MULTI_RESULTS）。
CLIENT_MULTI_RESULTS默认情况下启用。
要处理使用or
CALL
执行的语句
的结果，请使用调用以确定是否有更多结果的循环。有关示例，请参阅
多语句执行支持。
mysql_query()mysql_real_query()mysql_next_result()
C 程序可以使用准备语句接口来执行
语句和CALL访问
参数。这是通过
使用调用以确定是否有更多结果的循环来处理语句的结果来完成的。有关示例，请参阅
准备好的 CALL 语句支持。提供 MySQL 接口的语言可以使用准备好的
语句来直接检索和
处理参数。
OUTINOUTCALLmysql_stmt_next_result()CALLOUTINOUT
检测到存储程序引用的对象的元数据更改，并在下一次执行程序时自动重新分析受影响的语句。有关详细信息，请参阅
第 8.10.3 节，“准备好的语句和存储程序的缓存”。
© Mysql 中文网
