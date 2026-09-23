# 3.6.6 使用外键_MySQL 8.0 参考手册

3.6.6 使用外键_MySQL 8.0 参考手册
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
3.4 获取有关数据库和表的信息
3.5 在批处理模式下使用 mysql
3.6 常见查询示例
3.6.1 列的最大值1
3.6.2 某列最大值所在的行1
3.6.3 每组最大列数1
3.6.4 拥有某列分组最大值的行1
3.6.5 使用用户自定义变量1
3.6.6 使用外键1
3.6.7 搜索两个键1
3.6.8 计算每天的访问量1
3.6.9 使用 AUTO_INCREMENT1
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
MySQL 8.0 参考手册  / 第 3 章教程  / 3.6 常见查询示例  /
3.6.6 使用外键
3.6.6 使用外键
MySQL 支持外键，允许跨表交叉引用相关数据，以及外键约束，这有助于保持相关数据的一致性。
外键关系涉及包含初始列值的父表，以及包含引用父列值的列值的子表。在子表上定义了外键约束。
以下示例通过单列外键关联表，并显示外键约束如何强制执行参照完整性
parent。
child
创建父表和子表：
CREATE TABLE parent (
id INT NOT NULL,
PRIMARY KEY (id)
) ENGINE=INNODB;
CREATE TABLE child (
id INT,
parent_id INT,
INDEX par_ind (parent_id),
FOREIGN KEY (parent_id)
REFERENCES parent(id)
) ENGINE=INNODB;
在父表中插入一行：
mysql> INSERT INTO parent (id) VALUES (1);
验证数据是否已插入：
mysql> SELECT * FROM parent;
+----+
| id |
+----+
|  1 |
+----+
在子表中插入一行：
mysql> INSERT INTO child (id,parent_id) VALUES (1,1);
插入操作成功，因为
parent_id父表中存在 1。
parent_id使用父表中不存在
的值向子表中插入一行
：mysql> INSERT INTO child (id,parent_id) VALUES(2,2);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails
(`test`.`child`, CONSTRAINT `child_ibfk_1` FOREIGN KEY (`parent_id`)
REFERENCES `parent` (`id`))
操作失败，因为指定的
parent_id值在父表中不存在。
尝试从父表中删除先前插入的行：
mysql> DELETE FROM parent WHERE id VALUES = 1;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails
(`test`.`child`, CONSTRAINT `child_ibfk_1` FOREIGN KEY (`parent_id`)
REFERENCES `parent` (`id`))
此操作失败，因为子表中的记录包含引用的 id ( parent_id) 值。
当操作影响父表中具有子表中匹配行的键值时，结果取决于子句ON UPDATE和
ON DELETE子句指定的引用操作FOREIGN
KEY。省略ON DELETEand
ON UPDATE子句（如在当前子表定义中）与指定
RESTRICT选项相同，它拒绝影响父表中具有匹配行的父表中的键值的操作。
要演示ON DELETE和ON
UPDATE参考操作，请删除子表并重新创建它以使用选项包含ON UPDATE和
ON DELETE子句
CASCADE。CASCADE当删除或更新父表中的行时，
该
选项会自动删除或更新子表中的匹配行。DROP TABLE child;
CREATE TABLE child (
id INT,
parent_id INT,
INDEX par_ind (parent_id),
FOREIGN KEY (parent_id)
REFERENCES parent(id)
ON UPDATE CASCADE
ON DELETE CASCADE
) ENGINE=INNODB;
将以下行插入子表：
mysql> INSERT INTO child (id,parent_id) VALUES(1,1),(2,1),(3,1);
验证数据是否已插入：
mysql> SELECT * FROM child;
+------+-----------+
| id   | parent_id |
+------+-----------+
|    1 |         1 |
|    2 |         1 |
|    3 |         1 |
+------+-----------+
更新父表中的 id，将其从 1 更改为 2。
mysql> UPDATE parent SET id = 2 WHERE id = 1;
验证更新是否成功：
mysql> SELECT * FROM parent;
+----+
| id |
+----+
|  2 |
+----+
验证ON UPDATE CASCADE引用操作是否更新了子表：
mysql> SELECT * FROM child;
+------+-----------+
| id   | parent_id |
+------+-----------+
|    1 |         2 |
|    2 |         2 |
|    3 |         2 |
+------+-----------+
为了演示ON DELTE CASCADE
引用操作，从 所在的父表中parent_id = 2删除记录，这将删除父表中的所有记录。
mysql> DELETE FROM parent WHERE id = 2;
因为子表中的所有记录都与 关联
parent_id = 2，ON DELETE
CASCADE引用操作从子表中删除所有记录：
mysql> SELECT * FROM child;
Empty set (0.00 sec)
有关外键约束的更多信息，请参阅
第 13.1.20.5 节，“外键约束”。
© Mysql 中文网
