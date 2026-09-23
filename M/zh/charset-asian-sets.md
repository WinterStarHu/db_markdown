# 10.10.7 亚洲字符集_MySQL 8.0 参考手册

10.10.7 亚洲字符集_MySQL 8.0 参考手册
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
10.10.7.1 cp932 字符集
10.10.7.2 gb18030 字符集
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
10.10.7 亚洲字符集
10.10.7 亚洲字符集
10.10.7.1 cp932 字符集10.10.7.2 gb18030 字符集
我们支持的亚洲字符集包括中文、日文、韩文和泰文。这些可能很复杂。例如，中文集必须允许数千个不同的字符。有关和
字符集的更多信息，请参阅第 10.10.7.1 节，“cp932 字符集”。有关中国国家标准 GB 18030 字符集支持的更多信息，
请参阅
第 10.10.7.2 节，“gb18030 字符集” 。cp932sjis
有关 MySQL 中亚洲字符集支持的一些常见问题和问题的答案，请参阅
第 A.11 节，“MySQL 8.0 FAQ：MySQL 中文、日文和韩文字符集”。
big5（Big5 繁体中文）整理：
big5_bin
big5_chinese_ci（默认）
cp932
（用于 Windows 日语的 SJIS）排序规则：
cp932_bin
cp932_japanese_ci（默认）
eucjpms（用于 Windows 日语的 UJIS）排序规则：
eucjpms_bin
eucjpms_japanese_ci（默认）
euckr（EUC-KR 韩语）校对：
euckr_bin
euckr_korean_ci（默认）
gb2312（GB2312简体中文）校对：
gb2312_bin
gb2312_chinese_ci（默认）
gbk（GBK简体中文）校对：
gbk_bin
gbk_chinese_ci（默认）
gb18030
（中国国家标准GB18030）整理：
gb18030_bin
gb18030_chinese_ci（默认）
gb18030_unicode_520_ci
sjis（Shift-JIS 日语）整理：
sjis_bin
sjis_japanese_ci（默认）
tis620（TIS620泰语）校对：
tis620_bin
tis620_thai_ci（默认）
ujis（EUC-JP 日语）整理：
ujis_bin
ujis_japanese_ci（默认）
big5_chinese_ci排序规则按笔划数排序
。
© Mysql 中文网
