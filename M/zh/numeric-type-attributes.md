# 11.1.6 数值类型属性_MySQL 8.0 参考手册

11.1.6 数值类型属性_MySQL 8.0 参考手册
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
11.1 数值数据类型
11.1.1 数字数据类型语法1
11.1.2 整数类型（精确值）——INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT1
11.1.3 定点类型（精确值）——DECIMAL、NUMERIC1
11.1.4 浮点类型（近似值）——FLOAT、DOUBLE1
11.1.5 比特值类型——BIT1
11.1.6 数值类型属性1
11.1.7 超出范围和溢出处理1
11.2 日期和时间数据类型
11.3 字符串数据类型
11.4 空间数据类型
11.5 JSON数据类型
11.6 数据类型默认值
11.7 数据类型存储要求
11.8 为列选择正确的类型
11.9 使用来自其他数据库引擎的数据类型
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
MySQL 8.0 参考手册  / 第 11 章数据类型  / 11.1 数值数据类型  /
11.1.6 数值类型属性
11.1.6 数值类型属性
MySQL 支持一个扩展，可以在类型的基本关键字后面的括号中选择性地指定整数数据类型的显示宽度。例如，
INT(4)指定 an
INT的显示宽度为四位。应用程序可以使用此可选显示宽度来显示宽度小于为列指定的宽度的整数值，方法是用空格向左填充它们。（也就是说，这个宽度存在于随结果集返回的元数据中。是否使用它取决于应用程序。）
显示宽度不限制可以存储在列中的值的范围。它也不会阻止正确显示比列显示宽度宽的值。例如，指定为 的列
SMALLINT(3)的通常
SMALLINT范围为
-32768到32767，超出三位数允许范围的值将使用多于三位数完整显示。
当与可选（非标准）
ZEROFILL属性一起使用时，默认的空格填充将替换为零。例如，对于声明为 的列，将检索为
INT(4) ZEROFILL的值。
50005
笔记
对于表达式或查询
ZEROFILL中涉及的列，
该属性将被忽略。UNION
如果您在具有该属性的整数列中存储大于显示宽度的值，则ZEROFILL
当 MySQL 为某些复杂的连接生成临时表时，您可能会遇到问题。在这些情况下，MySQL 假定数据值适合列显示宽度。
从 MySQL 8.0.17 开始，ZEROFILL不推荐使用数字数据类型的属性，整数数据类型的显示宽度属性也是如此。ZEROFILL您应该期望在未来版本的 MySQL 中删除对整数数据类型的支持
和显示宽度。考虑使用替代方法来产生这些属性的效果。例如，应用程序可以使用该
LPAD()函数将数字补零到所需的宽度，或者它们可以将格式化后的数字存储在CHAR列中。
所有整数类型都可以有一个可选的（非标准的）
UNSIGNED属性。无符号类型可用于在一列中仅允许非负数，或者当您需要该列的较大数值范围上限时。例如，如果列为 ，则INT列
UNSIGNED范围的大小相同，但其端点向上移动，
从
到-2147483648和。
214748364704294967295
浮点和定点类型也可以是
UNSIGNED. 对于整数类型，此属性可防止负值存储在列中。与整数类型不同，列值的上限范围保持不变。从 MySQL 8.0.17 开始，
不推荐使用,
, and
（以及任何同义词）UNSIGNED类型的列的属性，您应该期望在 MySQL 的未来版本中删除对它的支持。考虑对此类列使用简单的
约束。
FLOATDOUBLEDECIMALCHECK
如果您ZEROFILL为数字列指定，MySQL 会自动添加该UNSIGNED
属性。
整数或浮点数据类型可以具有该
AUTO_INCREMENT属性。当您将值NULL插入索引
AUTO_INCREMENT列时，该列将设置为下一个序列值。通常为
value+1，其中
value是表中当前列的最大值。（AUTO_INCREMENT序列以 . 开头
1）
除非
启用了 SQL 模式
，否则
存储0到
AUTO_INCREMENT列中与存储具有相同的效果。NULLNO_AUTO_VALUE_ON_ZERO
插入NULL以生成
AUTO_INCREMENT值需要声明该列NOT NULL。如果该列已声明NULL，插入将
NULL存储一个NULL. 当您将任何其他值插入
AUTO_INCREMENT列时，该列将设置为该值并重置序列，以便下一个自动生成的值按顺序从插入的值开始。
AUTO_INCREMENT不支持列的
负值。
CHECK约束不能引用具有AUTO_INCREMENT属性的列，也不能将AUTO_INCREMENT属性添加到CHECK
约束中使用的现有列。
从 MySQL 8.0.17 开始，AUTO_INCREMENT不推荐使用FLOAT和
DOUBLE列的支持；你应该期望它会在未来版本的 MySQL 中被删除。考虑AUTO_INCREMENT从此类列中删除属性，或将它们转换为整数类型。
© Mysql 中文网
