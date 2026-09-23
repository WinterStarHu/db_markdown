# 9.1.7 空值_MySQL 8.0 参考手册

9.1.7 空值_MySQL 8.0 参考手册
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
9.1.1 字符串文字1
9.1.2 数字文字1
9.1.3 日期和时间文字1
9.1.4 十六进制文字1
9.1.5 位值文字1
9.1.6 布尔文字1
9.1.7 空值1
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
MySQL 8.0 参考手册  / 第9章语言结构  / 9.1 文字值  /
9.1.7 空值
9.1.7 空值
该NULL值表示“无数据。”
NULL可以写在任何信箱中。
请注意，该NULL值不同于0数字类型的值或字符串类型的空字符串。有关详细信息，请参阅
第 B.3.4.3 节，“NULL 值的问题”。
LOAD DATA对于使用或
执行的文本文件导入或导出操作
SELECT ... INTO
OUTFILE，NULL由
\N序列表示。请参阅第 13.2.7 节，“加载数据语句”。
对于使用 排序ORDER BY，
NULL值排序在其他值之前进行升序排序，在其他值之后进行降序排序。
© Mysql 中文网
