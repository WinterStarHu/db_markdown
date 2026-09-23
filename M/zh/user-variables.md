# 9.4 用户自定义变量_MySQL 8.0 参考手册

9.4 用户自定义变量_MySQL 8.0 参考手册
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
9.1 文字值
9.2 模式对象名称
9.3 关键字和保留字
9.4 用户自定义变量
9.5 表达式
9.6 查询属性
9.7 评论
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
MySQL 8.0 参考手册  / 第9章语言结构  /
9.4 用户自定义变量
9.4 用户自定义变量
您可以在一条语句中将值存储在用户定义的变量中，稍后在另一条语句中引用它。这使您能够将值从一个语句传递到另一个语句。
用户变量写为
，其中变量名称由字母数字字符、、
和组成。如果您将用户变量名称作为字符串或标识符（例如 、 或 ）引用，则它可以包含其他
字符。
@var_namevar_name._$@'my-var'@"my-var"@`my-var`
用户定义的变量是特定于会话的。一个客户端定义的用户变量不能被其他客户端看到或使用。（例外：有权访问 Performance Schema
user_variables_by_thread表的用户可以查看所有会话的所有用户变量。）当客户端退出时，给定客户端会话的所有变量都会自动释放。
用户变量名称不区分大小写。名称的最大长度为 64 个字符。
设置用户定义变量的一种方法是发出
SET
语句：
SET @var_name = expr [, @var_name = expr] ...
对于SET，要么 要么=可以
:=用作赋值运算符。
可以从一组有限的数据类型中为用户变量分配一个值：整数、十进制、浮点数、二进制或非二进制字符串，或NULL值。小数和实数值的分配不会保留值的精度或小数位。允许类型之一以外的类型的值将转换为允许类型。例如，具有时间或空间数据类型的值被转换为二进制字符串。具有JSON数据类型的值将转换为字符集为
utf8mb4且排序规则为
的字符串utf8mb4_bin。
如果为用户变量分配了非二进制（字符）字符串值，则它具有与字符串相同的字符集和排序规则。用户变量的强制性是隐含的。（这与表列值的可强制性相同。）
分配给用户变量的十六进制或位值被视为二进制字符串。要将十六进制或位值作为数字分配给用户变量，请在数字上下文中使用它。例如，添加 0 或使用CAST(... AS UNSIGNED)：
mysql> SET @v1 = X'41';
mysql> SET @v2 = X'41'+0;
mysql> SET @v3 = CAST(X'41' AS UNSIGNED);
mysql> SELECT @v1, @v2, @v3;
+------+------+------+
| @v1  | @v2  | @v3  |
+------+------+------+
| A    |   65 |   65 |
+------+------+------+
mysql> SET @v1 = b'1000001';
mysql> SET @v2 = b'1000001'+0;
mysql> SET @v3 = CAST(b'1000001' AS UNSIGNED);
mysql> SELECT @v1, @v2, @v3;
+------+------+------+
| @v1  | @v2  | @v3  |
+------+------+------+
| A    |   65 |   65 |
+------+------+------+
如果在结果集中选择了用户变量的值，则将其作为字符串返回给客户端。
如果你引用一个没有被初始化的变量，它的值NULL是字符串类型。
从 MySQL 8.0.22 开始，准备语句中对用户变量的引用在语句首次准备时确定其类型，并在每次执行语句时保留此类型。类似地，在存储过程中的语句中使用的用户变量的类型在第一次调用存储过程时确定，并在每次后续调用中保留此类型。
用户变量可以在大多数允许表达式的上下文中使用。这目前不包括明确需要文字值的上下文，例如在
语句的LIMIT子句
中SELECT或语句的
子句中。
IGNORE N LINESLOAD DATA
以前版本的 MySQL 可以在 . 以外的语句中为用户变量赋值
SET。MySQL 8.0 支持此功能以实现向后兼容性，但在未来的 MySQL 版本中可能会被删除。
以这种方式进行赋值时，必须使用
:=as 赋值运算符；=在 .以外的语句中被视为比较运算符
SET。
涉及用户变量的表达式的求值顺序未定义。例如，不能保证
先SELECT @a, @a:=@a+1求值
@a然后执行赋值。
此外，变量的默认结果类型基于它在语句开头的类型。如果一个变量在语句的开头保持一种类型的值，而在语句中它也被分配了一个不同类型的新值，这可能会产生意想不到的效果。
为避免此行为出现问题，请不要在单个语句中为同一变量赋值并读取该变量的值，或者将该变量设置为0、
0.0，或者''在使用它之前定义其类型。
HAVING、GROUP BY和
ORDER BY，当引用在选择表达式列表中分配了值的变量时，不会按预期工作，因为表达式是在客户端上计算的，因此可以使用前一行中的陈旧列值。
用户变量旨在提供数据值。它们不能直接在 SQL 语句中用作标识符或用作标识符的一部分，例如在需要表或数据库名称的上下文中，或用作保留字，例如
SELECT. 即使引用了变量也是如此，如以下示例所示：
mysql> SELECT c1 FROM t;
+----+
| c1 |
+----+
|  0 |
+----+
|  1 |
+----+
2 rows in set (0.00 sec)
mysql> SET @col = "c1";
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT @col FROM t;
+------+
| @col |
+------+
| c1   |
+------+
1 row in set (0.00 sec)
mysql> SELECT `@col` FROM t;
ERROR 1054 (42S22): Unknown column '@col' in 'field list'
mysql> SET @col = "`c1`";
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT @col FROM t;
+------+
| @col |
+------+
| `c1` |
+------+
1 row in set (0.00 sec)
用户变量不能用于提供标识符这一原则的一个例外是，当您构造一个字符串以用作稍后执行的准备语句时。在这种情况下，用户变量可用于提供语句的任何部分。以下示例说明了如何做到这一点：
mysql> SET @c = "c1";
Query OK, 0 rows affected (0.00 sec)
mysql> SET @s = CONCAT("SELECT ", @c, " FROM t");
Query OK, 0 rows affected (0.00 sec)
mysql> PREPARE stmt FROM @s;
Query OK, 0 rows affected (0.04 sec)
Statement prepared
mysql> EXECUTE stmt;
+----+
| c1 |
+----+
|  0 |
+----+
|  1 |
+----+
2 rows in set (0.00 sec)
mysql> DEALLOCATE PREPARE stmt;
Query OK, 0 rows affected (0.00 sec)
有关详细信息，请参阅第 13.5 节，“准备好的语句”。
可以在应用程序中使用类似的技术来使用程序变量构造 SQL 语句，如下所示使用 PHP 5：
<?php
$mysqli = new mysqli("localhost", "user", "pass", "test");
if( mysqli_connect_errno() )
die("Connection failed: %s\n", mysqli_connect_error());
$col = "c1";
$query = "SELECT $col FROM t";
$result = $mysqli->query($query);
while($row = $result->fetch_assoc())
{
echo "<p>" . $row["$col"] . "</p>\n";
}
$result->close();
$mysqli->close();
?>
以这种方式组合 SQL 语句有时称为
“动态 SQL ”。
© Mysql 中文网
