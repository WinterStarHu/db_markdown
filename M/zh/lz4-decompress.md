# 4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出_MySQL 8.0 参考手册

4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出1
4.8.2 perror——显示MySQL错误信息信息1
4.8.3 zlib_decompress — 解压缩 mysqlpump ZLIB 压缩输出1
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.8 杂项程序  /
4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出
4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出
lz4_decompress实用程序解压缩
使用 LZ4 压缩创建
的mysqlpump输出。
笔记
如果使用该
-DWITH_LZ4=system选项配置 MySQL，
则不会构建lz4_decompress 。在这种情况下，可以改用
系统lz4命令。
像这样调用lz4_decompress：
lz4_decompress input_file output_file
例子：
mysqlpump --compress-output=LZ4 > dump.lz4
lz4_decompress dump.lz4 dump.txt
要查看帮助消息，请不带参数调用lz4_decompress
。
要解压缩mysqlpump ZLIB 压缩输出，请使用zlib_decompress。请参阅
第 4.8.3 节，“zlib_decompress — 解压缩 mysqlpump ZLIB 压缩输出”。
© Mysql 中文网
