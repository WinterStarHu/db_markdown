# 13.6.7 条件处理_MySQL 8.0 参考手册

13.6.7 条件处理_MySQL 8.0 参考手册
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
13.1 数据定义语句
13.2 数据操作语句
13.3 事务和锁定语句
13.4 复制语句
13.5 准备好的语句
13.6 复合语句语法
13.6.1 BEGIN ... END 复合语句1
13.6.2 声明标签1
13.6.3 DECLARE 语句1
13.6.4 存储程序中的变量1
13.6.5 流量控制语句1
13.6.6 游标1
13.6.7 条件处理1
13.6.7.1 DECLARE ... CONDITION 语句
13.6.7.2 DECLARE ... HANDLER 语句
13.6.7.3 GET DIAGNOSTICS 语句
13.6.7.4 RESIGNAL 语句
13.6.7.5 SIGNAL 语句
13.6.7.6 处理程序的范围规则
13.6.7.7 MySQL诊断区
13.6.7.8 条件处理和 OUT 或 INOUT 参数
13.6.8 条件处理的限制1
13.7 数据库管理语句
13.8 效用语句
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
MySQL 8.0 参考手册  / 第 13 章 SQL 语句  / 13.6 复合语句语法  /
13.6.7 条件处理
13.6.7 条件处理
13.6.7.1 DECLARE ... CONDITION 语句13.6.7.2 DECLARE ... HANDLER 语句13.6.7.3 GET DIAGNOSTICS 语句13.6.7.4 RESIGNAL 语句13.6.7.5 SIGNAL 语句13.6.7.6 处理程序的范围规则13.6.7.7 MySQL诊断区13.6.7.8 条件处理和 OUT 或 INOUT 参数
存储程序执行期间可能会出现需要特殊处理的情况，例如退出当前程序块或继续执行。可以为一般情况（例如警告或异常）或特定情况（例如特定错误代码）定义处理程序。可以为特定条件分配名称并在处理程序中以这种方式引用。
要命名条件，请使用
DECLARE ...
CONDITION语句。要声明处理程序，请使用该
DECLARE ...
HANDLER语句。请参阅
第 13.6.7.1 节，“DECLARE ... CONDITION 语句”和
第 13.6.7.2 节，“DECLARE ... HANDLER 语句”。有关在条件发生时服务器如何选择处理程序的信息，请参阅
第 13.6.7.6 节，“处理程序的作用域规则”。
要提出条件，请使用
SIGNAL语句。要修改条件处理程序中的条件信息，请使用
RESIGNAL. 请参阅
第 13.6.7.1 节，“DECLARE ... CONDITION 语句”和
第 13.6.7.2 节，“DECLARE ... HANDLER 语句”。
要从诊断区域检索信息，请使用
GET DIAGNOSTICS语句（请参阅
第 13.6.7.3 节，“GET DIAGNOSTICS 语句”）。有关诊断区域的信息，请参阅第 13.6.7.7 节，“MySQL 诊断区域”。
© Mysql 中文网
