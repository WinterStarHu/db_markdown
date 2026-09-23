# 11.1.4 浮点类型（近似值）——FLOAT、DOUBLE_MySQL 8.0 参考手册

11.1.4 浮点类型（近似值）——FLOAT、DOUBLE_MySQL 8.0 参考手册
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
11.1.4 浮点类型（近似值）——FLOAT、DOUBLE
11.1.4 浮点类型（近似值）——FLOAT、DOUBLE
和类型表示FLOAT近似DOUBLE数值数据值。MySQL 对单精度值使用四个字节，对双精度值使用八个字节。
对于FLOAT，SQL 标准允许在括号中的关键字后面以位为单位可选地指定精度（但不是指数的范围）
FLOAT，即
. MySQL 也支持这个可选的精度规范，但精度值
仅用于确定存储大小。从 0 到 23 的精度产生一个 4 字节的单精度
列。从 24 到 53 的精度会产生一个 8 字节的双精度列。
FLOAT(p)FLOAT(p)FLOATDOUBLE
MySQL 允许非标准语法：
or
or 。这里的
意思是，值总共可以存储最多
位数，其中的
位数可以在小数点后。例如，定义为的列
显示为
。MySQL 在存储值时会进行舍入，因此如果插入
到列中，则近似结果为.
FLOAT(M,D)REAL(M,D)DOUBLE
PRECISION(M,D)(M,D)MDFLOAT(7,4)-999.9999999.00009FLOAT(7,4)999.0001
从 MySQL 8.0.17 开始，不推荐使用非标准
和
语法，您应该期望在未来版本的 MySQL 中删除对它的支持。
FLOAT(M,D)DOUBLE(M,D)
因为浮点值是近似值而不是存储为精确值，所以尝试在比较中将它们视为精确值可能会导致问题。它们还受平台或实现依赖性的影响。有关详细信息，请参阅
第 B.3.4.8 节，“浮点值问题”。
为了获得最大的可移植性，需要存储近似数字数据值的代码应该使用FLOATor
DOUBLE PRECISION，而不指定精度或位数。
© Mysql 中文网
