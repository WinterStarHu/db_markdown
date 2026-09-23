# 3.3.3 将数据加载到表中_MySQL 8.0 参考手册

3.3.3 将数据加载到表中_MySQL 8.0 参考手册
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
3.1 连接和断开服务器
3.2 输入查询
3.3 创建和使用数据库
3.3.1 创建和选择数据库1
3.3.2 创建表1
3.3.3 将数据加载到表中1
3.3.4 从表中检索信息1
3.4 获取有关数据库和表的信息
3.5 在批处理模式下使用 mysql
3.6 常见查询示例
3.7 在 Apache 中使用 MySQL
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
MySQL 8.0 参考手册  / 第 3 章教程  / 3.3 创建和使用数据库  /
3.3.3 将数据加载到表中
3.3.3 将数据加载到表中
创建表后，您需要填充它。LOAD DATA和
语句对此
INSERT很有用。
假设您的宠物记录可以描述为此处所示。（注意 MySQL 期望日期
格式；这可能与您习惯的不同。）
'YYYY-MM-DD'
姓名
所有者
物种
性别
诞生
死亡
蓬松的
哈罗德
猫
F
1993-02-04
爪子
格温
猫
米
1994-03-17
巴菲
哈罗德
狗
F
1989-05-13
芳
本尼
狗
米
1990-08-27
鲍泽
黛安
狗
米
1979-08-31
1995-07-29
扢
格温
鸟
F
1998-09-11
惠斯勒
格温
鸟
1997-12-09
瘦
本尼
蛇
米
1996-04-29
因为您是从一个空表开始的，所以填充它的一种简单方法是创建一个包含每只动物一行的文本文件，然后使用一条语句将文件的内容加载到表中。
您可以创建一个文本文件pet.txt
，每行包含一条记录，值由制表符分隔，并按照列在
CREATE TABLE语句中列出的顺序给出。对于缺失值（例如尚存动物的未知性别或死亡日期），您可以使用NULL
值。要在您的文本文件中表示这些，请使用
\N（反斜杠，大写 N）。例如，Whistler the bird 的记录如下所示（值之间的空格是单个制表符）：
Whistler        Gwen    bird    \N      1997-12-09      \N
要将文本文件加载pet.txt到
pet表中，请使用以下语句：
mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet;
如果您在 Windows 上使用
\r\n用作行终止符的编辑器创建文件，则应改用此语句：
mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet
LINES TERMINATED BY '\r\n';
（在运行 macOS 的 Apple 机器上，您可能希望使用
LINES TERMINATED BY '\r'.）
LOAD
DATA如果愿意，
您可以在语句中明确指定列值分隔符和行尾标记，但默认值为制表符和换行符。这些足以让语句pet.txt正确读取文件。
如果该语句失败，则可能是您的 MySQL 安装没有默认启用本地文件功能。有关如何更改此设置的信息，
请参阅第 6.1.6 节“LOAD DATA LOCAL 的安全注意事项” 。
当您想一次添加一条新记录时，该
INSERT语句很有用。在最简单的形式中，您按照列在
CREATE TABLE语句中列出的顺序为每一列提供值。假设黛安得到了一只名为“马勃”的新仓鼠。”您可以使用如下
INSERT语句添加新记录：
mysql> INSERT INTO pet
VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);
字符串和日期值在此处指定为带引号的字符串。此外，使用INSERT，您可以直接插入
NULL以表示缺失值。您不像\N使用
LOAD DATA.
从此示例中，您应该能够看到，最初使用多个INSERT语句而不是单个LOAD DATA
语句来加载记录会涉及更多的输入。
© Mysql 中文网
