# 8.3.3 空间索引优化_MySQL 8.0 参考手册

8.3.3 空间索引优化_MySQL 8.0 参考手册
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
8.1 优化概述
8.2 优化SQL语句
8.3 优化和索引
8.3.1 MySQL如何使用索引1
8.3.2 主键优化1
8.3.3 空间索引优化1
8.3.4 外键优化1
8.3.5 列索引1
8.3.6 多列索引1
8.3.7 验证索引使用1
8.3.8 InnoDB和MyISAM索引统计收集1
8.3.9 B-Tree和哈希索引的比较1
8.3.10 索引扩展的使用1
8.3.11 优化器使用生成的列索引1
8.3.12 不可见索引1
8.3.13 降序索引1
8.3.14 从 TIMESTAMP 列进行索引查找1
8.4 优化数据库结构
8.5 优化 InnoDB 表
8.6 优化 MyISAM 表
8.7 优化 MEMORY 表
8.8 了解查询执行计划
8.9 控制查询优化器
8.10 缓冲和缓存
8.11 优化锁定操作
8.12 优化MySQL服务器
8.13 测量性能（基准测试）
8.14 查看服务器线程（进程）信息
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
MySQL 8.0 参考手册  / 第8章优化  / 8.3 优化和索引  /
8.3.3 空间索引优化
8.3.3 空间索引优化
MySQL 允许SPATIAL在
NOT NULL几何值列上创建索引（请参阅
第 11.4.10 节，“创建空间索引”）。优化器检查SRID索引列的属性以确定要使用哪个空间参考系统 (SRS) 进行比较，并使用适合 SRS 的计算。（在 MySQL 8.0 之前，优化器SPATIAL使用笛卡尔计算对索引值进行比较；如果列包含具有非笛卡尔 SRID 的值，则此类操作的结果是未定义的。）
为使比较正常进行，
SPATIAL索引中的每一列都必须受 SRID 限制。也就是说，列定义必须包含显式
SRID属性，并且所有列值必须具有相同的 SRID。
优化器SPATIAL只考虑 SRID 限制列的索引：
限制为笛卡尔 SRID 的列上的索引启用笛卡尔边界框计算。
限制为地理 SRID 的列上的索引支持地理边界框计算。
优化器忽略SPATIAL没有SRID属性（因此不受 SRID 限制）的列上的索引。MySQL仍然维护着这样的索引，如下：
它们会针对表格修改进行更新（INSERT、
UPDATE、
DELETE等等）。更新就像索引是笛卡尔坐标一样发生，即使该列可能包含笛卡尔坐标值和地理值的混合。
它们的存在只是为了向后兼容（例如，能够在 MySQL 5.7 中执行转储并在 MySQL 8.0 中恢复）。因为SPATIAL不受 SRID 限制的列上的索引对优化器没有用，所以应该修改每个这样的列：
验证列中的所有值是否具有相同的 SRID。要确定几何列中包含的 SRID col_name，请使用以下查询：
SELECT DISTINCT ST_SRID(col_name) FROM tbl_name;
如果查询返回多行，则该列包含 SRID 的混合。在这种情况下，修改其内容，使所有值都具有相同的 SRID。
重新定义列以具有显式
SRID属性。
重新创建SPATIAL索引。
© Mysql 中文网
