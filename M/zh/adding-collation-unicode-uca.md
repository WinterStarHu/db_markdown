# 10.14.4 向 Unicode 字符集添加 UCA 归类_MySQL 8.0 参考手册

10.14.4 向 Unicode 字符集添加 UCA 归类_MySQL 8.0 参考手册
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
10.14.4.1 使用 LDML 语法定义 UCA 归类
10.14.4.2 MySQL 支持的 LDML 语法
10.14.4.3 Index.xml 解析期间的诊断
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
10.14.4 向 Unicode 字符集添加 UCA 归类
10.14.4 向 Unicode 字符集添加 UCA 归类
10.14.4.1 使用 LDML 语法定义 UCA 归类10.14.4.2 MySQL 支持的 LDML 语法10.14.4.3 Index.xml 解析期间的诊断
本节介绍如何通过
在 MySQL文件<collation>的字符集描述中写入元素
来为 Unicode 字符集添加 UCA 归类。此处描述的过程不需要重新编译 MySQL。它使用区域设置数据标记语言 (LDML) 规范的子集，可从
http://www.unicode.org/reports/tr35/获得。使用此方法，您无需定义整个排序规则。相反，您从现有的“基础”开始<charset>Index.xml排序规则并描述新排序规则与基本排序规则的区别。下表列出了可以为其定义 UCA 归类的 Unicode 字符集的基本归类。无法为 ; 创建用户定义的 UCA 排序规则utf16le；没有
utf16le_unicode_ci可作为此类整理基础的整理。
表 10.4 可用于用户定义的 UCA 归类的 MySQL 字符集
字符集
基础整理
utf8mb4
utf8mb4_unicode_ci
ucs2
ucs2_unicode_ci
utf16
utf16_unicode_ci
utf32
utf32_unicode_ci
以下部分显示如何添加使用 LDML 语法定义的排序规则，并提供 MySQL 中支持的 LDML 规则的摘要。
© Mysql 中文网
