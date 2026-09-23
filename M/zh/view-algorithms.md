# 25.5.2 视图处理算法_MySQL 8.0 参考手册

25.5.2 视图处理算法_MySQL 8.0 参考手册
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
25.5.2 视图处理算法
25.5.2 视图处理算法
or
的可选ALGORITHM子句
是 MySQL 对标准 SQL 的扩展。它会影响 MySQL 处理视图的方式。
取三个值：
、或
。
CREATE VIEWALTER VIEWALGORITHMMERGETEMPTABLEUNDEFINED
对于MERGE，引用视图的语句文本和视图定义被合并，以便视图定义的部分替换语句的相应部分。
对于TEMPTABLE，视图的结果被检索到临时表中，然后用于执行语句。
对于UNDEFINED，MySQL 选择使用哪种算法。如果可能的话，它会优先选择，因为
MERGE通常
效率更高，而且如果使用临时表，视图将无法更新。
TEMPTABLEMERGE
如果不存在ALGORITHM子句，则默认算法由
系统变量derived_merge标志的
值确定。optimizer_switch有关其他讨论，请参阅
第 8.2.2.4 节，“使用合并或实现优化派生表、视图引用和公用表表达式”。
明确指定的一个原因TEMPTABLE是可以在创建临时表之后和使用它完成处理语句之前释放基础表上的锁。这可能导致比该MERGE算法更快的锁定释放，从而使使用该视图的其他客户端不会被阻塞太久。
视图算法可能UNDEFINED出于三个原因：
声明中没有ALGORITHM子句
CREATE VIEW。
该CREATE VIEW语句有一个显式ALGORITHM = UNDEFINED子句。
ALGORITHM = MERGE为只能用临时表处理的视图指定。在这种情况下，MySQL 会生成警告并将算法设置为
UNDEFINED.
如前所述，MERGE通过将视图定义的相应部分合并到引用视图的语句中来处理。以下示例简要说明该MERGE算法的工作原理。这些示例假定存在v_merge
具有以下定义的视图：
CREATE ALGORITHM = MERGE VIEW v_merge (vc1, vc2) AS
SELECT c1, c2 FROM t WHERE c3 > 100;
示例 1：假设我们发出以下语句：
SELECT * FROM v_merge;
MySQL 处理语句如下：
v_merge成为t
*变成vc1, vc2，这对应于c1, c2
添加了视图WHERE子句
要执行的结果语句变为：
SELECT c1, c2 FROM t WHERE c3 > 100;
示例 2：假设我们发出以下语句：
SELECT * FROM v_merge WHERE vc1 < 100;
该语句的处理方式与前一个语句类似，不同之处在于vc1 < 100becomec1 <
100并且使用连接词将视图WHERE子句添加到语句WHERE子句
AND（并添加圆括号以确保子句的各部分以正确的优先级执行）。要执行的结果语句变为：
SELECT c1, c2 FROM t WHERE (c3 > 100) AND (c1 < 100);
实际上，要执行的语句具有
WHERE以下形式的子句：
WHERE (select WHERE) AND (view WHERE)
如果MERGE不能使用该算法，则必须使用临时表代替。阻止合并的构造与阻止在派生表和公用表表达式中合并的构造相同。示例是SELECT
DISTINCT或LIMIT在子查询中。有关详细信息，请参阅第 8.2.2.4 节，“使用合并或实现优化派生表、视图引用和公用表表达式”。
© Mysql 中文网
