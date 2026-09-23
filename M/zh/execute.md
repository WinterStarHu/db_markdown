# 13.5.2 执行语句_MySQL 8.0 参考手册

13.5.2 执行语句_MySQL 8.0 参考手册
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
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.5.1 PREPARE 语句1
13.5.2 执行语句1
13.5.3 解除分配准备语句1
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.5 准备好的语句  /
13.5.2 执行语句
13.5.2 执行语句
EXECUTE stmt_name
[USING @var_name [, @var_name] ...]
在使用 准备语句后
，您可以使用引用准备好的语句名称PREPARE的语句来执行它
。EXECUTE如果准备好的语句包含任何参数标记，则必须提供一个USING
子句，列出包含要绑定到参数的值的用户变量。参数值只能由用户变量提供，并且USING子句命名的变量必须与语句中参数标记的数量完全一样。
您可以多次执行给定的准备语句，将不同的变量传递给它或在每次执行之前将变量设置为不同的值。
有关示例，请参阅第 13.5 节，“准备好的语句”。
© Mysql 中文网
