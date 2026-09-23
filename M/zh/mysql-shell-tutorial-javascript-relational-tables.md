# 20.3.4 关系表_MySQL 8.0 参考手册

20.3.4 关系表_MySQL 8.0 参考手册
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
20.1 MySQL文档存储的接口
20.2 文档存储概念
20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell
20.3.1 MySQL 外壳1
20.3.2 下载导入world_x数据库1
20.3.3 文件和收藏1
20.3.4 关系表1
20.3.4.1 向表中插入记录
20.3.4.2 选择表
20.3.4.3 更新表格
20.3.4.4 删除表
20.3.5 表格中的文件1
20.4 Python 快速入门指南：用于文档存储的 MySQL Shell
20.5 X 插件
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
MySQL 8.0 参考手册  / 第 20 章使用 MySQL 作为文档存储  / 20.3 JavaScript 快速入门指南：用于文档存储的 MySQL Shell  /
20.3.4 关系表
20.3.4 关系表
20.3.4.1 向表中插入记录20.3.4.2 选择表20.3.4.3 更新表格20.3.4.4 删除表
您还可以使用 X DevAPI 来处理关系表。在 MySQL 中，每个关系表都与特定的存储引擎相关联。本节中的示例使用
模式InnoDB中的表
world_x。
确认架构
要显示分配给db
全局变量的架构，请发出db。
mysql-js> db
<Schema:world_x>
如果返回值不是，则按如下
方式Schema:world_x设置变量：dbmysql-js> \use world_x
Schema `world_x` accessible through db.
显示所有表格
要显示模式中的所有关系表world_x
，请使用对象getTables()上的方法
db。
mysql-js> db.getTables()
{
"city": <Table:city>,
"country": <Table:country>,
"countrylanguage": <Table:countrylanguage>
}
基本表操作
表范围内的基本操作包括：
操作形式
描述
db.name.insert()
insert()方法将
一条或多条记录插入指定的表中。
db.name.select()
select()方法返回指定表中的
部分或全部记录。
db.name.update()
update()方法更新指定表中的
记录。
db.name.delete()
delete()方法从指定表中
删除一条或多条记录。
相关信息
有关详细信息，请参阅
使用关系表
。
CRUD EBNF 定义提供了完整的操作列表。
有关设置
模式示例
的说明，
请参阅第 20.3.2 节“下载和导入 world_x 数据库” 。world_x
© Mysql 中文网
