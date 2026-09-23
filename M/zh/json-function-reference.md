# 12.18.1 JSON函数参考_MySQL 8.0 参考手册

12.18.1 JSON函数参考_MySQL 8.0 参考手册
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
12.1 内置函数和操作符参考
12.2 可加载函数参考
12.3 表达式求值中的类型转换
12.4 运营商
12.5 流量控制函数
12.6 数值函数和运算符
12.7 日期和时间函数
12.8 字符串函数和运算符
12.9 MySQL 使用什么日历？
12.10 全文搜索功能
12.11 转换函数和运算符
12.12 XML函数
12.13 位函数和运算符
12.14 加密和压缩函数
12.15 锁定函数
12.16 信息函数
12.17空间分析函数
12.17.1 空间函数参考1
12.17.2 空间函数的参数处理1
12.17.3 从 WKT 值创建几何值的函数1
12.17.4 从 WKB 值创建几何值的函数1
12.17.5 创建几何值的 MySQL 特定函数1
12.17.6 几何格式转换函数1
12.17.7 几何属性函数1
12.17.8 空间算子函数1
12.17.9 测试几何对象之间空间关系的函数1
12.17.10 空间 Geohash 函数1
12.17.11 空间 GeoJSON 函数1
12.18.1 JSON函数参考
12.18.2 创建 JSON 值的函数
12.18.3 搜索 JSON 值的函数
12.18.4 修改 JSON 值的函数
12.18.5 返回 JSON 值属性的函数
12.18.6 JSON 表函数
12.18.7 JSON 模式验证函数
12.18.8 JSON 实用函数
12.17.12 空间聚合函数1
12.17.13 空间便利功能1
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.21 窗口函数
12.22性能模式函数
12.23 内部函数
12.24 辅助功能
12.25 精密数学
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.17空间分析函数  / 12.17.11 空间 GeoJSON 函数  /
12.18.1 JSON函数参考
12.18.1 JSON函数参考
表 12.22 JSON 函数
姓名
描述
介绍
弃用
->
评估路径后从 JSON 列返回值；相当于 JSON_EXTRACT()。
->>
在评估路径并取消引用结果后从 JSON 列返回值；相当于 JSON_UNQUOTE(JSON_EXTRACT())。
JSON_ARRAY()
创建 JSON 数组
JSON_ARRAY_APPEND()
将数据附加到 JSON 文档
JSON_ARRAY_INSERT()
插入 JSON 数组
JSON_CONTAINS()
JSON 文档是否包含路径中的特定对象
JSON_CONTAINS_PATH()
JSON 文档是否包含路径中的任何数据
JSON_DEPTH()
JSON文档的最大深度
JSON_EXTRACT()
从 JSON 文档返回数据
JSON_INSERT()
向 JSON 文档中插入数据
JSON_KEYS()
来自 JSON 文档的键数组
JSON_LENGTH()
JSON 文档中的元素数量
JSON_MERGE()
合并 JSON 文档，保留重复键。JSON_MERGE_PRESERVE() 的弃用同义词
是的
JSON_MERGE_PATCH()
合并 JSON 文档，替换重复键的值
JSON_MERGE_PRESERVE()
合并 JSON 文档，保留重复键
JSON_OBJECT()
创建 JSON 对象
JSON_OVERLAPS()
比较两个 JSON 文档，如果它们具有任何共同的键值对或数组元素，则返回 TRUE (1)，否则返回 FALSE (0)
8.0.17
JSON_PRETTY()
以人类可读的格式打印 JSON 文档
JSON_QUOTE()
引用 JSON 文档
JSON_REMOVE()
从 JSON 文档中删除数据
JSON_REPLACE()
替换 JSON 文档中的值
JSON_SCHEMA_VALID()
根据 JSON 模式验证 JSON 文档；如果文档针对架构进行验证，则返回 TRUE/1，否则返回 FALSE/0
8.0.17
JSON_SCHEMA_VALIDATION_REPORT()
根据 JSON 模式验证 JSON 文档；返回 JSON 格式的验证结果报告，包括成功或失败以及失败原因
8.0.17
JSON_SEARCH()
JSON 文档中的值路径
JSON_SET()
向 JSON 文档中插入数据
JSON_STORAGE_FREE()
部分更新后 JSON 列值的二进制表示中的释放空间
JSON_STORAGE_SIZE()
用于存储 JSON 文档的二进制表示的空间
JSON_TABLE()
从 JSON 表达式返回数据作为关系表
JSON_TYPE()
JSON 值的类型
JSON_UNQUOTE()
取消引用 JSON 值
JSON_VALID()
JSON值是否有效
JSON_VALUE()
在提供的路径指向的位置从 JSON 文档中提取值；将此值作为 VARCHAR(512) 或指定类型返回
8.0.21
MEMBER OF()
如果第一个操作数与作为第二个操作数传递的 JSON 数组的任何元素匹配，则返回真 (1)，否则返回假 (0)
8.0.17
MySQL 支持两个聚合 JSON 函数
JSON_ARRAYAGG()和
JSON_OBJECTAGG(). 有关这些的描述，请参阅
第 12.20 节，“聚合函数”。
MySQL 还支持使用该函数以易于阅读的格式
“漂亮地打印” JSON 值。您可以分别使用和
JSON_PRETTY()来查看给定 JSON 值占用了多少存储空间，以及剩余多少空间用于额外存储
。有关这些功能的完整描述，请参阅
第 12.18.8 节，“JSON 实用程序功能”。
JSON_STORAGE_SIZE()JSON_STORAGE_FREE()
© Mysql 中文网
