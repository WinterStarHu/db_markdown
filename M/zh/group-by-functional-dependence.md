# 12.20.4 函数依赖检测_MySQL 8.0 参考手册

12.20.4 函数依赖检测_MySQL 8.0 参考手册
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
12.18 JSON函数
12.19 与全局事务标识符（GTID）一起使用的函数
12.20聚合函数
12.20.1 聚合函数说明1
12.20.2 GROUP BY 修饰符1
12.20.3 MySQL对GROUP BY的处理1
12.20.4 函数依赖检测1
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
MySQL 8.0 参考手册  / 第 12 章函数和运算符  / 12.20聚合函数  /
12.20.4 函数依赖检测
12.20.4 函数依赖检测
以下讨论提供了 MySQL 检测功能依赖性的方式的几个示例。这些示例使用此表示法：
{X} -> {Y}
将此理解为“X唯一确定Y” ，这也意味着它Y在功能上依赖于X。
这些示例使用world数据库，可以从
https://mysql.net.cn/doc/index-other.html下载。您可以在同一页面上找到有关如何安装数据库的详细信息。
从键派生的功能依赖从多列键和等式派生的功能依赖功能依赖特例功能依赖和视图函数依赖的组合
从键派生的功能依赖
以下查询为每个国家/地区选择了一定数量的口头语言：
SELECT co.Name, COUNT(*)
FROM countrylanguage cl, country co
WHERE cl.CountryCode = co.Code
GROUP BY co.Code;
co.Code是 的主键
co，因此 的所有列co
在功能上都依赖于它，如使用以下表示法所示：
{co.Code} -> {co.*}
因此，co.name在功能上依赖于
GROUP BY列并且查询有效。
可以使用列UNIQUE索引NOT
NULL代替主键，并且将应用相同的功能依赖性。UNIQUE（对于允许值的索引而言，
这是不正确的，NULL因为它允许多个
NULL值，在这种情况下，唯一性会丢失。）
从多列键和等式派生的功能依赖
此查询为每个国家/地区选择所有口头语言的列表以及使用这些语言的人数：
SELECT co.Name, cl.Language,
cl.Percentage * co.Population / 100.0 AS SpokenBy
FROM countrylanguage cl, country co
WHERE cl.CountryCode = co.Code
GROUP BY cl.CountryCode, cl.Language;
对 ( cl.CountryCode,
cl.Language) 是 的两列复合主键cl，因此列对唯一确定 的所有列cl：
{cl.CountryCode, cl.Language} -> {cl.*}
此外，由于
WHERE子句中的相等性：
{cl.CountryCode} -> {co.Code}
并且，因为co.Code是 的主键
co：
{co.Code} -> {co.*}
“唯一确定”关系是可传递的，因此：
{cl.CountryCode, cl.Language} -> {cl.*,co.*}
结果，查询有效。
与前面的示例一样，可以使用列上
的UNIQUE键代替主键。NOT NULLINNER JOIN可以使用条件
代替WHERE。相同的功能依赖性适用：
SELECT co.Name, cl.Language,
cl.Percentage * co.Population/100.0 AS SpokenBy
FROM countrylanguage cl INNER JOIN country co
ON cl.CountryCode = co.Code
GROUP BY cl.CountryCode, cl.Language;
功能依赖特例
虽然WHERE
条件或INNER JOIN条件中的相等性测试是对称的，但外部连接条件中的相等性测试不是对称的，因为表扮演不同的角色。
假设引用完整性被意外破坏，并且存在一行，而在 中countrylanguage
没有对应的行country。考虑与上一个示例相同的查询，但带有
LEFT JOIN：
SELECT co.Name, cl.Language,
cl.Percentage * co.Population/100.0 AS SpokenBy
FROM countrylanguage cl LEFT JOIN country co
ON cl.CountryCode = co.Code
GROUP BY cl.CountryCode, cl.Language;
对于 的给定值cl.CountryCode，co.Code连接结果中的值要么在匹配行中找到（由 确定
cl.CountryCode），要么
NULL在没有匹配项时补足（也由 确定cl.CountryCode）。在每种情况下，此关系适用：
{cl.CountryCode} -> {co.Code}
cl.CountryCode本身在功能上依赖于作为主键的
{ cl.CountryCode,
} 。cl.Language
如果连接结果co.Code是
NULL-complemented，
co.Name也是如此。如果
co.Code不是
NULL-complemented，那么因为
co.Code是主键，它确定
co.Name。因此，在所有情况下：
{co.Code} -> {co.Name}
哪个产量：
{cl.CountryCode, cl.Language} -> {cl.*,co.*}
结果，查询有效。
但是，假设交换了表，如以下查询所示：
SELECT co.Name, cl.Language,
cl.Percentage * co.Population/100.0 AS SpokenBy
FROM country co LEFT JOIN countrylanguage cl
ON cl.CountryCode = co.Code
GROUP BY cl.CountryCode, cl.Language;
现在这种关系不适用：
{cl.CountryCode, cl.Language} -> {cl.*,co.*}
实际上，NULL为 生成的所有补全行
cl被放入一个组（它们的两GROUP BY列都等于
NULL），并且在该组内， 的值
co.Name可以变化。查询无效，MySQL 拒绝它。
因此，外连接中的函数依赖关系到行列式是属于 的左侧还是右侧
LEFT JOIN。如果存在嵌套外部连接或连接条件不完全由相等比较组成，则功能依赖的确定会变得更加复杂。
功能依赖和视图
假设一个关于国家的视图产生了他们的代码、大写的名字，以及他们有多少种不同的官方语言：
CREATE VIEW country2 AS
SELECT co.Code, UPPER(co.Name) AS UpperName,
COUNT(cl.Language) AS OfficialLanguages
FROM country AS co JOIN countrylanguage AS cl
ON cl.CountryCode = co.Code
WHERE cl.isOfficial = 'T'
GROUP BY co.Code;
这个定义是有效的，因为：
{co.Code} -> {co.*}
在查看结果中，第一个选择的列是
co.Code，它也是组列，因此决定了所有其他选择的表达式：
{country2.Code} -> {country2.*}
MySQL 理解这一点并使用这些信息，如下所述。
此查询通过将视图与表连接起来，显示国家、他们有多少种不同的官方语言以及他们有多少个城市city：
SELECT co2.Code, co2.UpperName, co2.OfficialLanguages,
COUNT(*) AS Cities
FROM country2 AS co2 JOIN city ci
ON ci.CountryCode = co2.Code
GROUP BY co2.Code;
这个查询是有效的，因为，如前所述：
{co2.Code} -> {co2.*}
MySQL 能够发现视图结果中的功能依赖性，并使用它来验证使用该视图的查询。如果
country2是派生表（或公用表表达式），情况也是如此，如下所示：
SELECT co2.Code, co2.UpperName, co2.OfficialLanguages,
COUNT(*) AS Cities
FROM
(
SELECT co.Code, UPPER(co.Name) AS UpperName,
COUNT(cl.Language) AS OfficialLanguages
FROM country AS co JOIN countrylanguage AS cl
ON cl.CountryCode=co.Code
WHERE cl.isOfficial='T'
GROUP BY co.Code
) AS co2
JOIN city ci ON ci.CountryCode = co2.Code
GROUP BY co2.Code;
函数依赖的组合
MySQL 能够结合前面所有类型的函数依赖（基于键、基于相等、基于视图）来验证更复杂的查询。
© Mysql 中文网
