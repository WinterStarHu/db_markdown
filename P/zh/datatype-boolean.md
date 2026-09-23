# 8.6. 布尔类型

8.6. 布尔类型
版本：
纠错本页面
搜索
目录导航
❮
❯
8.6. 布尔类型 #
PostgreSQL 提供标准的 SQL 类型 boolean；参见 表 8.19。boolean 可以有多个状态：“true”、“false” 和第三种状态，“unknown”，未知状态由 SQL 空值表示。
表 8.19. 布尔数据类型名称存储大小描述boolean1 byte真或假的状态
在 SQL 查询中，布尔常量可以表示为 SQL 关键字 TRUE、FALSE 和 NULL。
boolean 类型的数据类型输入函数接受这些字符串表示 “真” 状态：
trueyeson1
以及这些表示 “假” 状态：
falsenooff0
这些字符串的唯一前缀也可以接受，例如 t 或 n。
前导或尾随空格将被忽略，并且大小写不敏感。
boolean类型的数据类型输出函数总是发出 t 或 f，如例 8.2所示。
例 8.2. 使用boolean类型
CREATE TABLE test1 (a boolean, b text);
INSERT INTO test1 VALUES (TRUE, 'sic est');
INSERT INTO test1 VALUES (FALSE, 'non est');
SELECT * FROM test1;
a |    b
---+---------
t | sic est
f | non est
SELECT * FROM test1 WHERE a;
a |    b
---+---------
t | sic est
在SQL查询中优先使用关键字TRUE 和 FALSE来写布尔常数(SQL-兼容)。
但是你也可以使用遵循第 4.1.2.7 节中描述的通用字符串文字常量句法的字符串来表达，例如'yes'::boolean。
注意语法分析程序会把TRUE 和 FALSE 自动理解为boolean类型，但是不包括NULL ，因为它可以是任何类型的。
因此在某些语境中你也许要将 NULL 转化为显示boolean类型，例如NULL::boolean。 反过来，上下文中的字符串文字布尔值也可以不转换，当语法分析程序能够断定文字必定为boolean类型时。
上一页 上一级 下一页8.5. 日期/时间类型 起始页 8.7. 枚举类型
