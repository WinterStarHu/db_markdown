# 3.5 在批处理模式下使用 mysql_MySQL 8.0 参考手册

3.5 在批处理模式下使用 mysql_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 3 章教程  /
3.5 在批处理模式下使用 mysql
3.5 在批处理模式下使用 mysql
在前面的部分中，您以交互方式使用mysql
输入语句并查看结果。您还可以以批处理模式运行mysql。为此，将要运行的语句放在文件中，然后告诉
mysql从文件中读取其输入：
$> mysql < batch-file
如果你在Windows下运行mysql，文件中有一些特殊字符导致问题，你可以这样做：
C:\> mysql -e "source batch-file"
如果您需要在命令行上指定连接参数，该命令可能如下所示：
$> mysql -h host -u user -p < batch-file
Enter password: ********
当您以这种方式使用mysql时，您正在创建一个脚本文件，然后执行该脚本。
如果您希望脚本继续运行，即使其中的某些语句产生错误，您应该使用
--force命令行选项。
为什么要使用脚本？这里有几个原因：
如果您重复运行查询（例如，每天或每周），将其设为脚本可以避免每次执行时都重新输入。
您可以通过复制和编辑脚本文件从现有的类似查询生成新查询。
在开发查询时，批处理模式也很有用，特别是对于多行语句或多语句序列。如果您输入错误，您不必重新输入所有内容。只需编辑您的脚本以更正错误，然后告诉mysql再次执行它。
如果您有一个产生大量输出的查询，您可以通过寻呼机运行输出而不是看着它从屏幕顶部滚动：
$> mysql < batch-file | more
您可以在文件中捕获输出以进行进一步处理：
$> mysql < batch-file > mysql.out
您可以将脚本分发给其他人，以便他们也可以运行这些语句。
有些情况不允许交互式使用，例如，当您从cron作业运行查询时。在这种情况下，您必须使用批处理模式。
当你以批处理模式运行mysql
时，默认输出格式与你交互使用它时不同（更简洁）
。例如，交互式运行
mysqlSELECT DISTINCT
species FROM pet时的输出如下所示
：+---------+
| species |
+---------+
| bird    |
| cat     |
| dog     |
| hamster |
| snake   |
+---------+
在批处理模式下，输出看起来像这样：
species
bird
cat
dog
hamster
snake
如果要以批处理模式获取交互式输出格式，请使用mysql -t。要将执行的语句回显到输出中，请使用mysql -v。
您还可以使用命令或
命令从mysql提示符使用脚本：
source\.mysql> source filename;
mysql> \. filename
有关更多信息，请参阅第 4.5.1.5 节，“从文本文件执行 SQL 语句”。
© Mysql 中文网
