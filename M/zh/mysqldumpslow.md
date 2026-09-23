# 4.6.10 mysqldumpslow——总结慢查询日志文件_MySQL 8.0 参考手册

4.6.10 mysqldumpslow——总结慢查询日志文件_MySQL 8.0 参考手册
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
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
4.7 程序开发实用程序
4.8 杂项程序
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.10 mysqldumpslow——总结慢查询日志文件
4.6.10 mysqldumpslow——总结慢查询日志文件
MySQL 慢速查询日志包含有关需要很长时间执行的查询的信息（请参阅
第 5.4.5 节，“慢速查询日志”）。
mysqldumpslow解析 MySQL 慢查询日志文件并汇总其内容。
通常，mysqldumpslow将相似的查询分组，除了数字和字符串数据值的特定值。它在显示摘要输出时“抽象”这些值
。要修改值抽象行为，请使用
和选项。
N'S'-a-n
像这样调用mysqldumpslow：
mysqldumpslow [options] [log_file ...]
没有给出选项的示例输出：
Reading mysql slow query log from /usr/local/mysql/data/mysqld80-slow.log
Count: 1  Time=4.32s (4s)  Lock=0.00s (0s)  Rows=0.0 (0), root[root]@localhost
insert into t2 select * from t1
Count: 3  Time=2.53s (7s)  Lock=0.00s (0s)  Rows=0.0 (0), root[root]@localhost
insert into t2 select * from t1 limit N
Count: 3  Time=2.13s (6s)  Lock=0.00s (0s)  Rows=0.0 (0), root[root]@localhost
insert into t1 select * from t1
mysqldumpslow支持以下选项。
表 4.23 mysqldumpslow 选项
选项名称
描述
-一个
不要将所有数字抽象为 N，将字符串抽象为 'S'
-n
至少具有指定数字的抽象数字
--调试
写入调试信息
-G
只考虑匹配模式的语句
- 帮助
显示帮助信息并退出
-H
日志文件名中服务器的主机名
-一世
服务器实例的名称
-l
不要从总时间中减去锁定时间
-r
反转排序顺序
-s
如何排序输出
-t
仅显示前 num 个查询
--冗长
详细模式
--help
显示帮助信息并退出。
-a
不要将所有数字N和字符串抽象为'S'。
--debug,
-d
在调试模式下运行。
仅当 MySQL 是使用
WITH_DEBUG. Oracle 提供的 MySQL 发布二进制文件不是
使用此选项构建的。
-g pattern
只考虑匹配（grep样式）模式的查询。
-h host_name
文件名的 MySQL 服务器的主机
*-slow.log名。该值可以包含通配符。默认为*
（全部匹配）。
-i name
服务器实例的名称（如果使用
mysql.server启动脚本）。
-l
不要从总时间中减去锁定时间。
-n N
名称中至少包含N
数字的抽象数字。
-r
反转排序顺序。
-s sort_type
如何排序输出。的值
sort_type应从以下列表中选择：
t, at: 按查询时间或平均查询时间排序
l, al: 按锁定时间或平均锁定时间排序
r, ar: 按发送的行数或发送的平均行数排序
c: 按次数排序
默认情况下，mysqldumpslow按平均查询时间排序（相当于-s at）。
-t N
仅显示输出中的第一个N查询。
--verbose,
-v
详细模式。打印有关程序功能的更多信息。
© Mysql 中文网
