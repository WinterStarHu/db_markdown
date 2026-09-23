# 10.9.3 utf8 字符集（utf8mb3 的别名）_MySQL 8.0 参考手册

10.9.3 utf8 字符集（utf8mb3 的别名）_MySQL 8.0 参考手册
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
10.9.1 utf8mb4 字符集（4 字节 UTF-8 Unicode 编码）1
10.9.2 utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）1
10.9.3 utf8 字符集（utf8mb3 的别名）1
10.9.4 ucs2字符集（UCS-2 Unicode编码）1
10.9.5 utf16字符集（UTF-16 Unicode编码）1
10.9.6 utf16le字符集（UTF-16LE Unicode编码）1
10.9.7 utf32字符集（UTF-32 Unicode编码）1
10.9.8 在 3 字节和 4 字节 Unicode 字符集之间转换1
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.9 Unicode 支持  /
10.9.3 utf8 字符集（utf8mb3 的别名）
10.9.3 utf8 字符集（utf8mb3 的别名）
utf8MySQL 一直使用的是utf8mb3字符集的别名，但这种用法正在逐步淘汰；从 MySQL 8.0.28 开始，将改为SHOW
显示信息模式表的语句和列
utf8mb3。有关详细信息，请参阅
第 10.9.2 节，“utf8mb3 字符集（3 字节 UTF-8 Unicode 编码）”。
笔记
该utf8mb3字符集已弃用，您应该期望在未来的 MySQL 版本中将其删除。请utf8mb4改用。
utf8目前是 的别名
utf8mb3，但现在已弃用，utf8预计随后会成为 的引用utf8mb4。从 MySQL 8.0.28 开始，utf8mb3也显示在utf8Information Schema 表的列和 SQL
SHOW语句的输出中。
为避免 的含义出现歧义
utf8，请考虑
utf8mb4明确指定字符集引用。
© Mysql 中文网
