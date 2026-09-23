# 10.10.2 西欧字符集_MySQL 8.0 参考手册

10.10.2 西欧字符集_MySQL 8.0 参考手册
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
10.1 一般字符集和排序规则
10.2 MySQL 中的字符集和排序规则
10.3 指定字符集和归类
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
10.10.1 Unicode 字符集1
10.10.2 西欧字符集1
10.10.3 中欧字符集1
10.10.4 南欧和中东字符集1
10.10.5 波罗的海字符集1
10.10.6 西里尔字符集1
10.10.7 亚洲字符集1
10.10.8 二进制字符集1
10.11 字符集限制
10.12 设置错误信息语言
10.13 添加字符集
10.14 向字符集添加归类
10.15 字符集配置
10.16 MySQL 服务器语言环境支持
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.10 支持的字符集和归类  /
10.10.2 西欧字符集
10.10.2 西欧字符集
西欧字符集涵盖了大部分西欧语言，例如法语、西班牙语、加泰罗尼亚语、巴斯克语、葡萄牙语、意大利语、阿尔巴尼亚语、荷兰语、德语、丹麦语、瑞典语、挪威语、芬兰语、法罗语、冰岛语、爱尔兰语、苏格兰语和英语。
ascii（美国 ASCII）排序规则：
ascii_bin
ascii_general_ci（默认）
cp850（DOS 西欧）整理：
cp850_bin
cp850_general_ci（默认）
dec8（DEC 西欧）整理：
dec8_bin
dec8_swedish_ci（默认）
该dec字符集在 MySQL 8.0.28 中已弃用；期望在后续的 MySQL 版本中删除对它的支持。
hp8（HP 西欧）校对：
hp8_bin
hp8_english_ci（默认）
该hp8字符集在 MySQL 8.0.28 中已弃用；期望在后续的 MySQL 版本中删除对它的支持。
latin1（cp1252 西欧）校对：
latin1_bin
latin1_danish_ci
latin1_general_ci
latin1_general_cs
latin1_german1_ci
latin1_german2_ci
latin1_spanish_ci
latin1_swedish_ci（默认）
MySQL的与Windows的字符集latin1是一样的
。cp1252这意味着它与官方ISO 8859-1或 IANA（Internet Assigned Numbers Authority）
latin1相同，只是 IANA
将和latin1之间的代码点
视为
“未定义” ，而MySQL为这些位置分配字符。例如，
是欧元符号。对于中的
“未定义”条目
，MySQL 转换
为 Unicode
，0x800x9fcp1252latin10x80cp12520x810x00810x8d到
0x008d，0x8f到
0x008f，0x90到
0x0090，0x9d到
0x009d。
latin1_swedish_ci排序规则是大多数 MySQL 客户可能使用的默认值
。尽管经常有人说它是基于瑞典/芬兰的归类规则，但也有瑞典人和芬兰人不同意这种说法。
和归类基于 DIN-1 和 DIN-2 标准，其中 DIN 代表
latin1_german1_ciDeutsches
Institut für Normung（相当于德国的 ANSI）。DIN-1称为“字典校对”，DIN-2称为“电话簿校对”。“有关这在比较或进行搜索时的效果示例，请参阅
第 10.8.6 节，“整理效果示例”。
latin1_german2_ci
latin1_german1_ci（字典）规则：
Ä = A
Ö = O
Ü = U
ß = s
latin1_german2_ci（电话簿）规则：
Ä = AE
Ö = OE
Ü = UE
ß = ss
在latin1_spanish_ci排序规则中，
(n-tilde) 是一个介于和ñ之间的单独字母
。
no
macroman（Mac西欧）校对：
macroman_bin
macroman_general_ci（默认）
macroroman在 MySQL 8.0.28 中已弃用；期望在后续的 MySQL 版本中删除对它的支持。
swe7（7 位瑞典语）排序规则：
swe7_bin
swe7_swedish_ci（默认）
© Mysql 中文网
