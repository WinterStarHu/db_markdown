# 10.9.4 ucs2字符集（UCS-2 Unicode编码）_MySQL 8.0 参考手册

10.9.4 ucs2字符集（UCS-2 Unicode编码）_MySQL 8.0 参考手册
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
10.9.4 ucs2字符集（UCS-2 Unicode编码）
10.9.4 ucs2字符集（UCS-2 Unicode编码）
笔记
该ucs2字符集在 MySQL 8.0.28 中已弃用；希望在未来的 MySQL 版本中将其删除。请utf8mb4改用。
在 UCS-2 中，每个字符都由一个 2 字节的 Unicode 代码表示，最高有效字节在前。例如：
LATIN CAPITAL LETTER A有代码
0x0041，它存储为 2 字节序列：
0x00 0x41。CYRILLIC SMALL LETTER
YERU(Unicode 0x044B) 存储为 2 字节序列：0x04 0x4B. 有关 Unicode 字符及其代码，请参阅
Unicode Consortium 网站。
ucs2字符集具有以下特点
：
仅支持 BMP 字符（不支持增补字符）
使用固定长度的 16 位编码，每个字符需要两个字节。
© Mysql 中文网
