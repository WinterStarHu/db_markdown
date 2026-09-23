# 12.18.7 JSON 模式验证函数_MySQL 8.0 参考手册

12.18.7 JSON 模式验证函数_MySQL 8.0 参考手册
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
12.18.7 JSON 模式验证函数
12.18.7 JSON 模式验证函数
从 MySQL 8.0.17 开始，MySQL 支持根据符合
JSON Schema 规范草案 4 的 JSON模式验证 JSON 文档。这可以使用本节中详述的任一函数来完成，这两个函数都有两个参数，一个 JSON 模式和一个根据该模式验证的 JSON 文档。
JSON_SCHEMA_VALID()如果文档根据模式进行验证，则返回 true，否则返回 false；
JSON_SCHEMA_VALIDATION_REPORT()
提供 JSON 格式的验证报告。
这两个函数都按如下方式处理 null 或无效输入：
如果至少有一个参数是NULL，则函数返回NULL。
如果至少有一个参数不是有效的 JSON，则该函数会引发错误 ( ER_INVALID_TYPE_FOR_JSON)
此外，如果模式不是有效的 JSON 对象，该函数将返回
ER_INVALID_JSON_TYPE。
MySQL 支持requiredJSON 模式中的属性以强制包含所需的属性（请参阅函数描述中的示例）。
MySQL 支持 JSON 模式中的id、
$schema、description和
type属性，但不需要其中任何一个。
MySQL 不支持 JSON 模式中的外部资源；使用$ref关键字会导致
JSON_SCHEMA_VALID()失败并显示
ER_NOT_SUPPORTED_YET.
笔记
MySQL 支持 JSON 模式中的正则表达式模式，它支持但静默地忽略无效模式（参见JSON_SCHEMA_VALID()示例的描述）。
以下列表详细描述了这些功能：
JSON_SCHEMA_VALID(schema,document)
根据 JSON 验证documentJSON schema。schema和
都是
document必需的。架构必须是有效的 JSON 对象；该文档必须是有效的 JSON 文档。如果满足这些条件： 如果文档根据模式进行验证，则函数返回 true (1)；否则，它返回假 (0)。
在此示例中，我们将一个用户变量设置
@schema为地理坐标的 JSON 架构值，将另一个
变量设置@document为包含一个此类坐标的 JSON 文档的值。然后我们
通过将它们用作以下参数来
验证@document验证
：
@schemaJSON_SCHEMA_VALID()mysql> SET @schema = '{
'>  "id": "http://json-schema.org/geo",
'> "$schema": "http://json-schema.org/draft-04/schema#",
'> "description": "A geographical coordinate",
'> "type": "object",
'> "properties": {
'>   "latitude": {
'>     "type": "number",
'>     "minimum": -90,
'>     "maximum": 90
'>   },
'>   "longitude": {
'>     "type": "number",
'>     "minimum": -180,
'>     "maximum": 180
'>   }
'> },
'> "required": ["latitude", "longitude"]
'>}';
Query OK, 0 rows affected (0.01 sec)
mysql> SET @document = '{
'> "latitude": 63.444697,
'> "longitude": 10.445118
'>}';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT JSON_SCHEMA_VALID(@schema, @document);
+---------------------------------------+
| JSON_SCHEMA_VALID(@schema, @document) |
+---------------------------------------+
|                                     1 |
+---------------------------------------+
1 row in set (0.00 sec)
由于@schema包含该
required属性，我们可以设置
@document一个有效但不包含所需属性的值，然后对其进行测试@schema，如下所示：
mysql> SET @document = '{}';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT JSON_SCHEMA_VALID(@schema, @document);
+---------------------------------------+
| JSON_SCHEMA_VALID(@schema, @document) |
+---------------------------------------+
|                                     0 |
+---------------------------------------+
1 row in set (0.00 sec)
如果我们现在将 的值设置@schema为相同的 JSON 模式但没有required
属性，@document则验证因为它是一个有效的 JSON 对象，即使它不包含任何属性，如下所示：
mysql> SET @schema = '{
'> "id": "http://json-schema.org/geo",
'> "$schema": "http://json-schema.org/draft-04/schema#",
'> "description": "A geographical coordinate",
'> "type": "object",
'> "properties": {
'>   "latitude": {
'>     "type": "number",
'>     "minimum": -90,
'>     "maximum": 90
'>   },
'>   "longitude": {
'>     "type": "number",
'>     "minimum": -180,
'>     "maximum": 180
'>   }
'> }
'>}';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT JSON_SCHEMA_VALID(@schema, @document);
+---------------------------------------+
| JSON_SCHEMA_VALID(@schema, @document) |
+---------------------------------------+
|                                     1 |
+---------------------------------------+
1 row in set (0.00 sec)JSON_SCHEMA_VALID() 和 CHECK 约束。
JSON_SCHEMA_VALID()也可以用来强制CHECK约束。
考虑如下geo所示创建的表，其中一个 JSON 列coordinate
表示地图上的纬度和经度点，由用作调用中参数的 JSON 模式控制，该
调用作为该表上的约束
JSON_SCHEMA_VALID()表达式传递：CHECKmysql> CREATE TABLE geo (
->     coordinate JSON,
->     CHECK(
->         JSON_SCHEMA_VALID(
->             '{
'>                 "type":"object",
'>                 "properties":{
'>                       "latitude":{"type":"number", "minimum":-90, "maximum":90},
'>                       "longitude":{"type":"number", "minimum":-180, "maximum":180}
'>                 },
'>                 "required": ["latitude", "longitude"]
'>             }',
->             coordinate
->         )
->     )
-> );
Query OK, 0 rows affected (0.45 sec)
笔记
由于 MySQLCHECK约束不能包含对变量的引用，因此JSON_SCHEMA_VALID()在使用它为表指定此类约束时必须将 JSON 模式传递给内联。
我们将表示坐标的 JSON 值分配给三个变量，如下所示：
mysql> SET @point1 = '{"latitude":59, "longitude":18}';
Query OK, 0 rows affected (0.00 sec)
mysql> SET @point2 = '{"latitude":91, "longitude":0}';
Query OK, 0 rows affected (0.00 sec)
mysql> SET @point3 = '{"longitude":120}';
Query OK, 0 rows affected (0.00 sec)
这些值中的第一个是有效的，如以下INSERT语句所示：
mysql> INSERT INTO geo VALUES(@point1);
Query OK, 1 row affected (0.05 sec)
第二个 JSON 值无效，因此约束失败，如下所示：
mysql> INSERT INTO geo VALUES(@point2);
ERROR 3819 (HY000): Check constraint 'geo_chk_1' is violated.
在 MySQL 8.0.19 及更高版本中，您可以获得有关故障性质的准确信息——在本例中，该
latitude值超过模式中定义的最大值——通过发出以下SHOW
WARNINGS语句：
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Error
Code: 3934
Message: The JSON document location '#/latitude' failed requirement 'maximum' at
JSON Schema location '#/properties/latitude'.
*************************** 2. row ***************************
Level: Error
Code: 3819
Message: Check constraint 'geo_chk_1' is violated.
2 rows in set (0.00 sec)
上面定义的第三个坐标值也是无效的，因为它缺少必需的latitude
属性。和以前一样，您可以通过尝试将值插入geo表中然后再发出
来看到这一点SHOW WARNINGS：
mysql> INSERT INTO geo VALUES(@point3);
ERROR 3819 (HY000): Check constraint 'geo_chk_1' is violated.
mysql> SHOW WARNINGS\G
*************************** 1. row ***************************
Level: Error
Code: 3934
Message: The JSON document location '#' failed requirement 'required' at JSON
Schema location '#'.
*************************** 2. row ***************************
Level: Error
Code: 3819
Message: Check constraint 'geo_chk_1' is violated.
2 rows in set (0.00 sec)
有关详细信息，请参阅第 13.1.20.6 节，“检查约束”。
JSON Schema 支持为字符串指定正则表达式模式，但 MySQL 使用的实现会默默地忽略无效模式。这意味着
JSON_SCHEMA_VALID()即使正则表达式模式无效，它也可以返回 true，如下所示：
mysql> SELECT JSON_SCHEMA_VALID('{"type":"string","pattern":"("}', '"abc"');
+---------------------------------------------------------------+
| JSON_SCHEMA_VALID('{"type":"string","pattern":"("}', '"abc"') |
+---------------------------------------------------------------+
|                                                             1 |
+---------------------------------------------------------------+
1 row in set (0.04 sec)
JSON_SCHEMA_VALIDATION_REPORT(schema,document)
根据 JSON 验证documentJSON schema。schema和
都是
document必需的。与 JSON_VALID_SCHEMA() 一样，模式必须是有效的 JSON 对象，文档必须是有效的 JSON 文档。如果满足这些条件，该函数将以 JSON 文档的形式返回有关验证结果的报告。如果根据 JSON 模式认为 JSON 文档有效，则该函数返回一个 JSON 对象，其中一个属性
valid的值为“true”。如果 JSON 文档验证失败，该函数将返回一个 JSON 对象，其中包含此处列出的属性：
valid: 对于失败的架构验证始终为“false”
reason：包含失败原因的人类可读字符串
schema-location：一个 JSON 指针 URI 片段标识符，指示在 JSON 模式中验证失败的位置（请参阅此列表后面的注释）
document-location：一个 JSON 指针 URI 片段标识符，指示 JSON 文档中验证失败的位置（请参阅此列表后面的注释）
schema-failed-keyword：一个字符串，其中包含违反的 JSON 架构中的关键字或属性的名称
笔记
JSON 指针 URI 片段标识符在
RFC 6901 - JavaScript Object Notation (JSON) Pointer中定义。（这些与JSON_EXTRACT()和其他 MySQL JSON 函数
使用的 JSON 路径表示法不同
。）在此表示法中，#代表整个文档，并
#/myprop代表包含在名为 的顶级属性中的文档部分
myprop。有关详细信息，请参阅刚刚引用的规范和本节后面显示的示例。
在此示例中，我们将一个用户变量设置
@schema为地理坐标的 JSON 架构值，将另一个
变量设置@document为包含一个此类坐标的 JSON 文档的值。然后我们
通过将它们用作以下参数来
验证@document验证
：
@schemaJSON_SCHEMA_VALIDATION_REORT()mysql> SET @schema = '{
'>  "id": "http://json-schema.org/geo",
'> "$schema": "http://json-schema.org/draft-04/schema#",
'> "description": "A geographical coordinate",
'> "type": "object",
'> "properties": {
'>   "latitude": {
'>     "type": "number",
'>     "minimum": -90,
'>     "maximum": 90
'>   },
'>   "longitude": {
'>     "type": "number",
'>     "minimum": -180,
'>     "maximum": 180
'>   }
'> },
'> "required": ["latitude", "longitude"]
'>}';
Query OK, 0 rows affected (0.01 sec)
mysql> SET @document = '{
'> "latitude": 63.444697,
'> "longitude": 10.445118
'>}';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT JSON_SCHEMA_VALIDATION_REPORT(@schema, @document);
+---------------------------------------------------+
| JSON_SCHEMA_VALIDATION_REPORT(@schema, @document) |
+---------------------------------------------------+
| {"valid": true}                                   |
+---------------------------------------------------+
1 row in set (0.00 sec)
现在我们设置@document它为其属性之一指定非法值，如下所示：
mysql> SET @document = '{
'> "latitude": 63.444697,
'> "longitude": 310.445118
'> }';
使用 测试时，now 的验证@document失败
JSON_SCHEMA_VALIDATION_REPORT()。函数调用的输出包含有关失败的详细信息（包含函数
JSON_PRETTY()以提供更好的格式），如下所示：
mysql> SELECT JSON_PRETTY(JSON_SCHEMA_VALIDATION_REPORT(@schema, @document))\G
*************************** 1. row ***************************
JSON_PRETTY(JSON_SCHEMA_VALIDATION_REPORT(@schema, @document)): {
"valid": false,
"reason": "The JSON document location '#/longitude' failed requirement 'maximum' at JSON Schema location '#/properties/longitude'",
"schema-location": "#/properties/longitude",
"document-location": "#/longitude",
"schema-failed-keyword": "maximum"
}
1 row in set (0.00 sec)
由于@schema包含该
required属性，我们可以设置
@document一个有效但不包含所需属性的值，然后对其进行测试@schema。的输出
JSON_SCHEMA_VALIDATION_REPORT()显示由于缺少必需的元素而导致验证失败，如下所示：
mysql> SET @document = '{}';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT JSON_PRETTY(JSON_SCHEMA_VALIDATION_REPORT(@schema, @document))\G
*************************** 1. row ***************************
JSON_PRETTY(JSON_SCHEMA_VALIDATION_REPORT(@schema, @document)): {
"valid": false,
"reason": "The JSON document location '#' failed requirement 'required' at JSON Schema location '#'",
"schema-location": "#",
"document-location": "#",
"schema-failed-keyword": "required"
}
1 row in set (0.00 sec)
如果我们现在将 的值设置@schema为相同的 JSON 模式但没有required
属性，@document则验证因为它是一个有效的 JSON 对象，即使它不包含任何属性，如下所示：
mysql> SET @schema = '{
'> "id": "http://json-schema.org/geo",
'> "$schema": "http://json-schema.org/draft-04/schema#",
'> "description": "A geographical coordinate",
'> "type": "object",
'> "properties": {
'>   "latitude": {
'>     "type": "number",
'>     "minimum": -90,
'>     "maximum": 90
'>   },
'>   "longitude": {
'>     "type": "number",
'>     "minimum": -180,
'>     "maximum": 180
'>   }
'> }
'>}';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT JSON_SCHEMA_VALIDATION_REPORT(@schema, @document);
+---------------------------------------------------+
| JSON_SCHEMA_VALIDATION_REPORT(@schema, @document) |
+---------------------------------------------------+
| {"valid": true}                                   |
+---------------------------------------------------+
1 row in set (0.00 sec)
© Mysql 中文网
