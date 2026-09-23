# 10.14.2 选择归类 ID_MySQL 8.0 参考手册

10.14.2 选择归类 ID_MySQL 8.0 参考手册
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
10.9 Unicode 支持
10.10 支持的字符集和归类
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.14.1 归类实现类型1
10.14.2 选择归类 ID1
10.14.3 向 8 位字符集添加简单归类1
10.14.4 向 Unicode 字符集添加 UCA 归类1
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.14 向字符集添加归类  /
10.14.2 选择归类 ID
10.14.2 选择归类 ID
每个归类必须有一个唯一的 ID。要添加排序规则，您必须选择当前未使用的 ID 值。MySQL 支持两字节的归类 ID。从 1024 到 2047 的 ID 范围是为用户定义的排序规则保留的。
您选择的排序规则 ID 出现在这些上下文中：
表的ID列
INFORMATION_SCHEMA.COLLATIONS
。
输出
列Id。
SHOW COLLATIONC API 数据结构
的charsetnr成员
。MYSQL_FIELD
C API 函数
返回的数据结构
的number成员
。MY_CHARSET_INFOmysql_get_character_set_info()
要确定当前使用的最大 ID，请发出以下语句：
mysql> SELECT MAX(ID) FROM INFORMATION_SCHEMA.COLLATIONS;
+---------+
| MAX(ID) |
+---------+
|     247 |
+---------+
要显示所有当前使用的 ID 的列表，请发出以下语句：
mysql> SELECT ID FROM INFORMATION_SCHEMA.COLLATIONS ORDER BY ID;
+-----+
| ID  |
+-----+
|   1 |
|   2 |
| ... |
|  52 |
|  53 |
|  57 |
|  58 |
| ... |
|  98 |
|  99 |
| 128 |
| 129 |
| ... |
| 247 |
+-----+
警告
在升级之前，您应该保存更改的配置文件。如果就地升级，该过程将替换修改后的文件。
© Mysql 中文网
