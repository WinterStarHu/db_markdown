# 25.5.3 可更新和可插入视图_MySQL 8.0 参考手册

25.5.3 可更新和可插入视图_MySQL 8.0 参考手册
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
25.1 定义存储程序
25.2 使用存储例程
25.3 使用触发器
25.4 使用事件调度器
25.5 使用视图
25.5.1 查看语法1
25.5.2 视图处理算法1
25.5.3 可更新和可插入视图1
25.5.4 WITH CHECK OPTION 子句的视图1
25.5.5 查看元数据1
25.6 存储对象访问控制
25.7 存储程序二进制日志记录
25.8 存储程序的限制
25.9 视图限制
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
MySQL 8.0 参考手册  / 第25章存储对象  / 25.5 使用视图  /
25.5.3 可更新和可插入视图
25.5.3 可更新和可插入视图
一些视图是可更新的，对它们的引用可用于指定要在数据更改语句中更新的表。也就是说，您可以在 、 或 等语句中使用它们
UPDATE来
DELETE更新
INSERT基础表的内容。派生表和公用表表达式也可以在多表
UPDATEand
DELETE语句中指定，但只能用于读取数据指定要更新或删除的行。通常，视图引用必须是可更新的，这意味着它们可以合并而不是具体化。复合视图具有更复杂的规则。
对于可更新的视图，视图中的行与基础表中的行之间必须存在一对一的关系。还有某些其他构造使视图不可更新。更具体地说，如果视图包含以下任何一项，则该视图不可更新：
聚合函数或窗口函数（SUM()、
MIN()、
MAX()、
COUNT()等）
DISTINCT
GROUP BY
HAVING
UNION或者
UNION ALL
选择列表中的子查询
选择列表中的非依赖子查询对于 失败
，
INSERT但对于 没问题
。对于选择列表中的依赖子查询，不允许任何数据更改语句。
UPDATEDELETE
某些连接（请参阅本节后面的附加连接讨论）
FROM
在子句
中引用不可更新的视图WHERE引用子句中表的FROM子句
中的子查询
仅指文字值（在这种情况下，没有要更新的基础表）
ALGORITHM = TEMPTABLE（使用临时表总是使视图不可更新）
对基表的任何列的多个引用（失败
INSERT，好的
UPDATE，
DELETE）
视图中生成的列被认为是可更新的，因为它可以分配给它。但是，如果显式更新此类列，则唯一允许的值为
DEFAULT. 有关生成的列的信息，请参阅第 13.1.20.8 节，“CREATE TABLE 和生成的列”。
假设多表视图可以用
MERGE算法处理，有时它是可以更新的。为此，视图必须使用内部联接（而不是外部联接或
UNION）。此外，只能更新视图定义中的单个表，因此该
SET子句必须仅命名视图中其中一个表的列。使用的视图
UNION ALL是不允许的，即使它们在理论上可能是可更新的。
关于可插入性（可通过
INSERT语句更新），如果可更新视图也满足视图列的这些附加要求，则它是可插入的：
不得有重复的视图列名称。
视图必须包含基表中没有默认值的所有列。
视图列必须是简单的列引用。它们不能是表达式，例如：
3.14159
col1 + 3
UPPER(col2)
col3 / col4
(subquery)
MySQL 会设置一个标志，称为视图可更新性标志
CREATE VIEW。如果和
（以及类似操作）对于视图是合法的，则该标志设置为YES(true)
。否则，标志设置为
(false)。表中的
列
显示此标志的状态。这意味着服务器始终知道视图是否可更新。
UPDATEDELETENOIS_UPDATABLEINFORMATION_SCHEMA.VIEWS
如果视图不可更新，则 、 和 等语句
UPDATE是
DELETE非法
INSERT的并被拒绝。（即使视图是可更新的，也可能无法插入其中，如本节其他地方所述。）
视图的可更新性可能会受到
updatable_views_with_limit系统变量值的影响。请参阅第 5.1.8 节，“服务器系统变量”。
对于以下讨论，假设存在这些表和视图：
CREATE TABLE t1 (x INTEGER);
CREATE TABLE t2 (c INTEGER);
CREATE VIEW vmat AS SELECT SUM(x) AS s FROM t1;
CREATE VIEW vup AS SELECT * FROM t2;
CREATE VIEW vjoin AS SELECT * FROM vmat JOIN vup ON vmat.s=vup.c;
INSERT,
UPDATE, 和
DELETE语句允许如下：
INSERT: 语句的插入表
INSERT可能是合并的视图引用。如果视图是连接视图，则视图的所有组件都必须是可更新的（不是物化的）。对于多表可更新视图，
INSERT如果它插入到单个表中则可以工作。
此语句无效，因为连接视图的一个组件不可更新：
INSERT INTO vjoin (c) VALUES (1);
此声明有效；该视图不包含物化组件：
INSERT INTO vup (c) VALUES (1);
UPDATE：语句中要更新的一个或多个表UPDATE
可能是合并的视图引用。如果视图是连接视图，则视图的至少一个组件必须是可更新的（这与 不同
INSERT）。
在多表UPDATE
语句中，语句的更新表引用必须是基表或可更新视图引用。未更新的表引用可能是物化视图或派生表。
此声明有效；列c来自连接视图的可更新部分：
UPDATE vjoin SET c=c+1;
此声明无效；列x来自不可更新的部分：
UPDATE vjoin SET x=x+1;
此声明有效；多表的更新表引用UPDATE是一个可更新的视图（vup）：
UPDATE vup JOIN (SELECT SUM(x) AS s FROM t1) AS dt ON ...
SET c=c+1;
此声明无效；它尝试更新物化派生表：
UPDATE vup JOIN (SELECT SUM(x) AS s FROM t1) AS dt ON ...
SET s=s+1;
DELETE: 语句中要删除的DELETE
表必须是合并视图。不允许加入视图（这不同于INSERT和
UPDATE）。
此语句无效，因为该视图是一个连接视图：
DELETE vjoin WHERE ...;
此语句有效，因为该视图是合并（可更新）视图：
DELETE vup WHERE ...;
此语句有效，因为它从合并（可更新）视图中删除：
DELETE vup FROM vup JOIN (SELECT SUM(x) AS s FROM t1) AS dt ON ...;
其他讨论和示例如下。
本节前面的讨论指出，如果不是所有列都是简单的列引用（例如，如果它包含表达式或复合表达式的列），则视图不可插入。尽管这样的视图不可插入，但如果您只更新不是表达式的列，则它可以更新。考虑这个观点：
CREATE VIEW v AS SELECT col1, 1 AS col2 FROM t;
此视图不可插入，因为col2它是一个表达式。但如果更新不尝试更新它是可更新的col2。此更新是允许的：
UPDATE v SET col1 = 0;
此更新是不允许的，因为它试图更新表达式列：
UPDATE v SET col2 = 0;
如果表包含一AUTO_INCREMENT列，插入到不包含该AUTO_INCREMENT列的表的可插入视图中不会更改 的值
LAST_INSERT_ID()，因为将默认值插入不属于视图的列的副作用不应该是可见的。
© Mysql 中文网
