# 10.9.5 utf16字符集（UTF-16 Unicode编码）_MySQL 8.0 参考手册

10.9.5 utf16字符集（UTF-16 Unicode编码）_MySQL 8.0 参考手册
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
10.9.5 utf16字符集（UTF-16 Unicode编码）
10.9.5 utf16字符集（UTF-16 Unicode编码）
utf16字符集是
ucs2具有扩展名的字符集，可以对补充字符进行编码
：
对于一个BMP字符，utf16具有
ucs2相同的存储特性：相同的码值、相同的编码、相同的长度。
对于增补字符，utf16有一个特殊的序列用于使用 32 位表示字符。这称为“代理”机制：对于大于 的数字0xffff，取 10 位并将它们添加到0xd800第一个 16 位字中，再取 10 位并将它们添加到
0xdc00下一个 16 位中单词。因此，所有增补字符都需要 32 位，其中前 16 位是
0xd800和之间的数字0xdbff，最后 16 位是 和 之间的
0xdc00数字0xdfff。示例在第
15.5 Unicode 4.0 文档的代理区域。
因为支持和不utf16支持代理
，所以存在仅适用于以下情况的有效性检查：您不能在没有底部代理的情况下插入顶部代理，反之亦然。例如：
ucs2utf16INSERT INTO t (ucs2_column) VALUES (0xd800); /* legal */
INSERT INTO t (utf16_column)VALUES (0xd800); /* illegal */
对于技术上有效但不是真正 Unicode 的字符（即 Unicode 认为是“未分配代码点”或
“私人使用”字符甚至
“非法”之类的字符），不进行有效性检查0xffff。例如，因为U+F8FF是 Apple Logo，所以这是合法的：
INSERT INTO t (utf16_column)VALUES (0xf8ff); /* legal */
不能指望这样的角色对每个人都意味着同样的事情。
因为 MySQL 必须考虑到最坏的情况（一个字符需要四个字节），所以
utf16列或索引的最大长度仅为列或索引的最大长度的一半ucs2。例如，MEMORY
表索引键的最大长度为 3072 字节，因此这些语句创建具有最长允许索引的表ucs2
和utf16列：
CREATE TABLE tf (s1 VARCHAR(1536) CHARACTER SET ucs2) ENGINE=MEMORY;
CREATE INDEX i ON tf (s1);
CREATE TABLE tg (s1 VARCHAR(768) CHARACTER SET utf16) ENGINE=MEMORY;
CREATE INDEX i ON tg (s1);
© Mysql 中文网
