# 12.10.3 带查询扩展的全文搜索_MySQL 8.0 参考手册

12.10.3 带查询扩展的全文搜索_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.10.1 自然语言全文搜索1
12.10.2 布尔全文搜索1
12.10.3 带查询扩展的全文搜索1
12.10.4 全文停用词1
12.10.5 全文限制1
12.10.6 微调 MySQL 全文搜索1
12.10.7 为全文索引添加用户定义的排序规则1
12.10.8 ngram 全文解析器1
12.10.9 MeCab 全文解析器插件1
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.10 全文搜索功能  /
12.10.3 带查询扩展的全文搜索
12.10.3 带查询扩展的全文搜索
全文搜索支持查询扩展（特别是它的变体“盲查询扩展”）。当搜索短语太短时这通常很有用，这通常意味着用户依赖全文搜索引擎缺乏的隐含知识。例如，搜索
“ database ”的用户可能真正意味着
“ MySQL ”、“ Oracle ”、“ DB2 ”和“ RDBMS ”都是应与
“ databases ”匹配的词组也应该归还。这是隐含知识。
盲查询扩展（也称为自动相关性反馈）通过添加WITH QUERY
EXPANSION或IN NATURAL LANGUAGE MODE WITH
QUERY EXPANSION跟随搜索短语来启用。它通过执行两次搜索来工作，其中第二次搜索的搜索短语是原始搜索短语与第一次搜索中几个最相关的文档连接而成。因此，如果其中一个文档包含单词
“ databases ”和单词“ MySQL ”，则第二次搜索会找到包含单词
“ MySQL ”的文档，即使它们不包含单词
“ database ”. 以下示例显示了这种差异：
mysql> SELECT * FROM articles
WHERE MATCH (title,body)
AGAINST ('database' IN NATURAL LANGUAGE MODE);
+----+-------------------+------------------------------------------+
| id | title             | body                                     |
+----+-------------------+------------------------------------------+
|  1 | MySQL Tutorial    | DBMS stands for DataBase ...             |
|  5 | MySQL vs. YourSQL | In the following database comparison ... |
+----+-------------------+------------------------------------------+
2 rows in set (0.00 sec)
mysql> SELECT * FROM articles
WHERE MATCH (title,body)
AGAINST ('database' WITH QUERY EXPANSION);
+----+-----------------------+------------------------------------------+
| id | title                 | body                                     |
+----+-----------------------+------------------------------------------+
|  5 | MySQL vs. YourSQL     | In the following database comparison ... |
|  1 | MySQL Tutorial        | DBMS stands for DataBase ...             |
|  3 | Optimizing MySQL      | In this tutorial we show ...             |
|  6 | MySQL Security        | When configured properly, MySQL ...      |
|  2 | How To Use MySQL Well | After you went through a ...             |
|  4 | 1001 MySQL Tricks     | 1. Never run mysqld as root. 2. ...      |
+----+-----------------------+------------------------------------------+
6 rows in set (0.00 sec)
另一个例子可能是当用户不确定如何拼写
“ Maigret ”时搜索 Georges Simenon 关于 Maigret 的书籍。搜索“ Megre and the Reluctant Witnesses ”只会找到“ Maigret and the Reluctant Witnesses ”，而没有查询扩展。带有查询扩展的搜索会
在第二遍中
找到所有包含单词“ Maigret ”的书籍。
笔记
由于盲目查询扩展往往会通过返回不相关的文档来显着增加噪音，因此仅在搜索短语较短时才使用它。
© Mysql 中文网
