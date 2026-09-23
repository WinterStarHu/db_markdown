# 10.8.6 整理效果示例_MySQL 8.0 参考手册

10.8.6 整理效果示例_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.8.1 在 SQL 语句中使用 COLLATE1
10.8.2 COLLATE 子句优先级1
10.8.3 字符集和排序规则兼容性1
10.8.4 表达式中的排序规则强制性1
10.8.5 二进制排序规则与 _bin 排序规则的比较1
10.8.6 整理效果示例1
10.8.7 在 INFORMATION_SCHEMA 搜索中使用排序规则1
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.8 整理问题  /
10.8.6 整理效果示例
10.8.6 整理效果示例
示例 1：对德语变音符号进行排序
假设表中的列X具有
T这些latin1列值：
Muffler
Müller
MX Systems
MySQL
还假设使用以下语句检索列值：
SELECT X FROM T ORDER BY X COLLATE collation_name;
下表显示了使用ORDER BY不同排序规则时值的结果顺序。
latin1_swedish_ci
latin1_german1_ci
latin1_german2_ci
围巾
围巾
米勒
MX系统
米勒
围巾
米勒
MX系统
MX系统
MySQL
MySQL
MySQL
导致此示例中不同排序顺序的字符是ü（德语
“ U-umlaut ”）。
第一列显示了
SELECT使用瑞典语/芬兰语整理规则的结果，它表示 U-umlaut 与 Y 排序。
第二列显示
SELECT使用德国 DIN-1 规则的结果，该规则表示 U-umlaut 与 U 排序。
第三列显示了
SELECT使用德国 DIN-2 规则的结果，该规则表示 U-umlaut 与 UE 排序。
示例 2：搜索德语变音符号
假设您有三个表，它们仅在使用的字符集和排序规则方面有所不同：
mysql> SET NAMES utf8mb4;
mysql> CREATE TABLE german1 (
c CHAR(10)
) CHARACTER SET latin1 COLLATE latin1_german1_ci;
mysql> CREATE TABLE german2 (
c CHAR(10)
) CHARACTER SET latin1 COLLATE latin1_german2_ci;
mysql> CREATE TABLE germanutf8 (
c CHAR(10)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
每个表包含两条记录：
mysql> INSERT INTO german1 VALUES ('Bar'), ('Bär');
mysql> INSERT INTO german2 VALUES ('Bar'), ('Bär');
mysql> INSERT INTO germanutf8 VALUES ('Bar'), ('Bär');
上述归类中有两个具有A = Ä
相等性，一个没有这样的相等性 ( latin1_german2_ci)。因此，比较会产生此处显示的结果：
mysql> SELECT * FROM german1 WHERE c = 'Bär';
+------+
| c    |
+------+
| Bar  |
| Bär  |
+------+
mysql> SELECT * FROM german2 WHERE c = 'Bär';
+------+
| c    |
+------+
| Bär  |
+------+
mysql> SELECT * FROM germanutf8 WHERE c = 'Bär';
+------+
| c    |
+------+
| Bar  |
| Bär  |
+------+
这不是错误，而是 和 的排序属性的结果latin1_german1_ci（
utf8mb4_unicode_ci显示的排序是根据德国 DIN 5007 标准完成的）。
© Mysql 中文网
