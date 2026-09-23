# 25.1 定义存储程序_MySQL 8.0 参考手册

25.1 定义存储程序_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第25章存储对象  /
25.1 定义存储程序
25.1 定义存储程序
每个存储的程序都包含一个由 SQL 语句组成的主体。;该语句可能是由分号（ ）字符分隔的多个语句组成的复合语句。例如，以下存储过程的主体由包含一条语句的BEGIN ...
END块
和本身包含另一条
SET
语句的循环组成
：
REPEATSETCREATE PROCEDURE dorepeat(p1 INT)
BEGIN
SET @x = 0;
REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
END;
如果使用mysql客户端程序定义包含分号字符的存储程序，就会出现问题。默认情况下，mysql本身将分号识别为语句分隔符，因此必须临时重新定义分隔符，才能使mysql将整个存储程序定义传递给服务器。
要重新定义mysql分隔符，请使用
delimiter命令。以下示例显示了如何针对dorepeat()刚刚显示的过程执行此操作。定界符更改为//以使整个定义能够作为单个语句传递到服务器，然后;在调用该过程之前恢复为 。这使得;
过程主体中使用的定界符能够传递到服务器，而不是被mysql
本身解释。
mysql> delimiter //
mysql> CREATE PROCEDURE dorepeat(p1 INT)
-> BEGIN
->   SET @x = 0;
->   REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
-> END
-> //
Query OK, 0 rows affected (0.00 sec)
mysql> delimiter ;
mysql> CALL dorepeat(1000);
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT @x;
+------+
| @x   |
+------+
| 1001 |
+------+
1 row in set (0.00 sec)
您可以将分隔符重新定义为 以外的字符串
//，分隔符可以由单个字符或多个字符组成。您应该避免使用反斜杠 ( \) 字符，因为这是 MySQL 的转义字符。
下面是一个函数示例，它接受一个参数，使用 SQL 函数执行操作并返回结果。在这种情况下，不需要使用
delimiter，因为函数定义不包含内部;语句定界符：
mysql> CREATE FUNCTION hello (s CHAR(20))
mysql> RETURNS CHAR(50) DETERMINISTIC
-> RETURN CONCAT('Hello, ',s,'!');
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT hello('world');
+----------------+
| hello('world') |
+----------------+
| Hello, world!  |
+----------------+
1 row in set (0.00 sec)
© Mysql 中文网
