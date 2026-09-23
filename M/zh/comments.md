# 9.7 评论_MySQL 8.0 参考手册

9.7 评论_MySQL 8.0 参考手册
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
9.7 评论
9.7 评论
MySQL Server 支持三种注释样式：
从一个#字符到行尾。
从-- 序列到行尾。在 MySQL 中，-- （双破折号）注释样式要求第二个破折号后跟至少一个空格或控制字符（例如空格、制表符、换行符等）。此语法与标准 SQL 注释语法略有不同，如
第 1.7.2.4 节“'--'作为注释的开始”中所述。
从一个/*序列到下一个
*/序列，就像在 C 编程语言中一样。此语法使注释可以扩展到多行，因为开始和结束序列不需要在同一行上。
以下示例演示了所有三种注释样式：
mysql> SELECT 1+1;     # This comment continues to the end of line
mysql> SELECT 1+1;     -- This comment continues to the end of line
mysql> SELECT 1 /* this is an in-line comment */ + 1;
mysql> SELECT 1+
/*
this is a
multiple-line comment
*/
1;
不支持嵌套评论，并且已弃用；希望它们在未来的 MySQL 版本中被删除。（在某些情况下，可能允许嵌套注释，但通常不允许，用户应避免使用它们。）
MySQL 服务器支持某些 C 风格注释的变体。这些使您能够编写包含 MySQL 扩展但仍然可移植的代码，方法是使用以下形式的注释：
/*! MySQL-specific code */
在这种情况下，MySQL Server 会像处理任何其他 SQL 语句一样解析和执行注释中的代码，但其他 SQL 服务器应该忽略这些扩展。例如，MySQL 服务器识别STRAIGHT_JOIN以下语句中的关键字，但其他服务器不应该：
SELECT /*! STRAIGHT_JOIN */ col1 FROM table1,table2 WHERE ...
如果在该!
字符后加上版本号，则注释中的语法只有在MySQL版本大于或等于指定的版本号时才会执行。以下注释中的KEY_BLOCK_SIZE关键字仅由 MySQL 5.1.10 或更高版本的服务器执行：
CREATE TABLE t1(a INT, KEY (a)) /*!50110 KEY_BLOCK_SIZE=1024 */;
刚刚描述的注释语法适用于
mysqld服务器如何解析 SQL 语句。mysql客户端程序在将
语句发送到服务器之前还会对语句进行一些解析。（它这样做是为了确定多语句输入行中的语句边界。）有关服务器和
mysql客户端解析器之间差异的信息，请参阅
第 4.5.1.6 节，“mysql 客户端提示”。
格式的评论/*!12345 ... */不存储在服务器上。如果使用这种格式对存储的程序进行注释，注释将不会保留在程序体中。
C 风格注释语法的另一种变体用于指定优化器提示。提示评论在评论开始顺序+
之后包含一个字符。/*例子：
SELECT /*+ BKA(t1) */ FROM ... ;
有关详细信息，请参阅第 8.9.3 节，“优化器提示”。
不支持在多行注释中
使用短格式的mysql命令
。短格式命令在单行版本注释中起作用，就像存储在对象定义中的优化器提示注释一样。如果担心优化器提示注释可能存储在对象定义中，以便在重新加载时转储文件
会导致执行此类命令，请使用该
选项调用mysql或使用mysql以外的重新加载客户端。
\C/* ...
*//*! ... *//*+ ... */mysql--binary-mode
© Mysql 中文网
