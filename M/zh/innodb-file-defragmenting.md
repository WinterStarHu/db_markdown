# 15.11.4 对表进行碎片整理_MySQL 8.0 参考手册

15.11.4 对表进行碎片整理_MySQL 8.0 参考手册
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
第14章MySQL数据字典
第 15 章 InnoDB 存储引擎
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.11.1 InnoDB 磁盘 I/O1
15.11.2 文件空间管理1
15.11.3 InnoDB 检查点1
15.11.4 对表进行碎片整理1
15.11.5 使用 TRUNCATE TABLE 回收磁盘空间1
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.11 InnoDB磁盘I/O和文件空间管理  /
15.11.4 对表进行碎片整理
15.11.4 对表进行碎片整理
对二级索引的随机插入或删除会导致索引变得碎片化。碎片是指磁盘上索引页面的物理顺序与页面上记录的索引顺序不接近，或者分配给索引的 64 页块中有许多未使用的页面。
碎片的一个症状是表占用的空间比它“应该”占用的空间多。究竟有多少，很难确定。所有InnoDB数据和索引都存储在B 树中，它们的填充因子可能在 50% 到 100% 之间变化。碎片的另一个症状是像这样的表扫描花费的时间比它
“应该”花费的时间多：
SELECT COUNT(*) FROM t WHERE non_indexed_column <> 12345;
上述查询需要MySQL进行全表扫描，这是大表最慢的查询类型。
为了加快索引扫描，可以定期执行
“ null ” ALTER TABLE
操作，这会导致 MySQL 重建表：
ALTER TABLE tbl_name ENGINE=INNODB
您还可以使用它
来执行重建表的
“ null ”更改操作。
ALTER TABLE
tbl_name FORCE
两者都使用
在线
DDL。有关详细信息，请参阅第 15.12 节，“InnoDB 和在线 DDL”。
ALTER TABLE
tbl_name ENGINE=INNODBALTER TABLE
tbl_name FORCE
执行碎片整理操作的另一种方法是使用
mysqldump将表转储到文本文件，删除表，然后从转储文件中重新加载它。
如果对索引的插入总是升序的，并且只从末尾删除记录，则InnoDB
文件空间管理算法可以保证索引中不会出现碎片。
© Mysql 中文网
