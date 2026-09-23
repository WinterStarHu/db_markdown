# 10.3.1 归类命名约定_MySQL 8.0 参考手册

10.3.1 归类命名约定_MySQL 8.0 参考手册
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
10.3.1 归类命名约定1
10.3.2 服务器字符集和排序规则1
10.3.3 数据库字符集和排序规则1
10.3.4 表字符集和排序规则1
10.3.5 列字符集和排序规则1
10.3.6 字符串文字字符集和排序规则1
10.3.7 国家字符集1
10.3.8 字符集介绍者1
10.3.9 字符集和归类分配示例1
10.3.10 与其他 DBMS 的兼容性1
10.4 连接字符集和排序规则
10.5 配置应用程序字符集和排序规则
10.6 错误信息字符集
10.7 列字符集转换
10.8 整理问题
10.9 Unicode 支持
10.10 支持的字符集和归类
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  / 10.3 指定字符集和归类  /
10.3.1 归类命名约定
10.3.1 归类命名约定
MySQL 排序规则名称遵循以下约定：
归类名称以与其关联的字符集的名称开头，通常后跟一个或多个表示其他归类特征的后缀。例如，utf8mb4_0900_ai_ci和
分别是和
字符集latin1_swedish_ci的排序规则
。字符集
有一个排序规则，也名为
，没有后缀。
utf8mb4latin1binarybinary
特定于语言的排序规则包括区域设置代码或语言名称。例如
，分别使用土耳其语utf8mb4_tr_0900_ai_ci和
匈牙利语的规则为字符集
utf8mb4_hu_0900_ai_ci对字符进行排序。并且
相似，但基于较新版本的 Unicode 归类算法。
utf8mb4utf8mb4_turkish_ciutf8mb4_hungarian_ci
排序规则后缀指示排序规则是区分大小写、区分重音还是区分假名（或它们的某种组合）或二进制。下表显示了用于指示这些特性的后缀。
表 10.1 归类后缀含义
后缀
意义
_ai
口音不敏感
_as
口音敏感
_ci
不区分大小写
_cs
区分大小写
_ks
假名敏感
_bin
二进制
对于未指定区分重音的非二进制排序规则名称，由区分大小写决定。如果排序规则名称不包含_aior
_as，_ciin the name implys_ai和_csin the name implies _as。例如，
latin1_general_ci显式不区分大小写且隐式不区分重音，
latin1_general_cs显式区分大小写且隐式区分重音，以及
utf8mb4_0900_ai_ci显式不区分大小写且不区分重音。
对于日语归类，_ks后缀表示归类是假名敏感的；也就是说，它将片假名字符与平假名字符区分开来。没有后缀的日语排序规则对_ks
假名不敏感，并且将片假名和平假名字符视为相同的排序。
对于字符集的binary排序规则
binary，比较是基于数字字节值。对于
_bin非二进制字符集的排序规则，比较基于数字字符代码值，这与多字节字符的字节值不同。有关字符集排序规则与非二进制字符集排序规则之间差异的信息
，
binary请
参阅第 10.8.5 节，“二进制排序规则与 _bin 排序规则的比较”。
binary_bin
Unicode 字符集的归类名称可能包含版本号，以指示归类所基于的 Unicode 归类算法 (UCA) 的版本。名称中没有版本号的基于 UCA 的归类使用版本 4.0.0 UCA 权重键。例如：
utf8mb4_0900_ai_ci基于 UCA 9.0.0 权重密钥 ( http://www.unicode.org/Public/UCA/9.0.0/allkeys.txt )。
utf8mb4_unicode_520_ci基于 UCA 5.2.0 权重键 ( http://www.unicode.org/Public/UCA/5.2.0/allkeys.txt )。
utf8mb4_unicode_ci（没有命名的版本）基于 UCA 4.0.0 权重键（http://www.unicode.org/Public/UCA/4.0.0/allkeys-4.0.0.txt）。
对于 Unicode 字符集，
xxx_general_mysql500_ci
归类保留原始归类的 5.1.24 之前的顺序，
xxx_general_ci
并允许升级在 MySQL 5.1.24 之前创建的表（错误＃27877）。
© Mysql 中文网
