# 10.16 MySQL 服务器语言环境支持_MySQL 8.0 参考手册

10.16 MySQL 服务器语言环境支持_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 10 章字符集、排序规则、Unicode  /
10.16 MySQL 服务器语言环境支持
10.16 MySQL 服务器语言环境支持
系统变量指示的语言环境
lc_time_names控制用于显示日月名称和缩写的语言。此变量影响
DATE_FORMAT()、
DAYNAME()和
MONTHNAME()函数的输出。
lc_time_names不影响
STR_TO_DATE()或
GET_FORMAT()功能。
该lc_time_names值不影响 的结果FORMAT()，但此函数采用可选的第三个参数，该参数允许指定区域设置以用于结果数字的小数点、千位分隔符和分隔符之间的分组。lc_time_names允许的语言环境值与系统变量
的合法值相同
。
语言环境名称具有 IANA ( http://www.iana.org/assignments/language-subtag-registry ) 列出的语言和区域子标签，例如'ja_JP'或'pt_BR'。默认值'en_US'与系统的区域设置无关，但是您可以在服务器启动时设置该GLOBAL值，或者如果您有足够的权限设置全局系统变量，则可以在运行时设置该值；参见
第 5.1.9.1 节，“系统变量权限”。任何客户端都可以检查 的值
lc_time_names或设置其
SESSION值以影响其自身连接的语言环境。
mysql> SET NAMES 'utf8mb4';
Query OK, 0 rows affected (0.09 sec)
mysql> SELECT @@lc_time_names;
+-----------------+
| @@lc_time_names |
+-----------------+
| en_US           |
+-----------------+
1 row in set (0.00 sec)
mysql> SELECT DAYNAME('2020-01-01'), MONTHNAME('2020-01-01');
+-----------------------+-------------------------+
| DAYNAME('2020-01-01') | MONTHNAME('2020-01-01') |
+-----------------------+-------------------------+
| Wednesday             | January                 |
+-----------------------+-------------------------+
1 row in set (0.00 sec)
mysql> SELECT DATE_FORMAT('2020-01-01','%W %a %M %b');
+-----------------------------------------+
| DATE_FORMAT('2020-01-01','%W %a %M %b') |
+-----------------------------------------+
| Wednesday Wed January Jan               |
+-----------------------------------------+
1 row in set (0.00 sec)
mysql> SET lc_time_names = 'es_MX';
Query OK, 0 rows affected (0.00 sec)
mysql> SELECT @@lc_time_names;
+-----------------+
| @@lc_time_names |
+-----------------+
| es_MX           |
+-----------------+
1 row in set (0.00 sec)
mysql> SELECT DAYNAME('2020-01-01'), MONTHNAME('2020-01-01');
+-----------------------+-------------------------+
| DAYNAME('2020-01-01') | MONTHNAME('2020-01-01') |
+-----------------------+-------------------------+
| miércoles             | enero                   |
+-----------------------+-------------------------+
1 row in set (0.00 sec)
mysql> SELECT DATE_FORMAT('2020-01-01','%W %a %M %b');
+-----------------------------------------+
| DATE_FORMAT('2020-01-01','%W %a %M %b') |
+-----------------------------------------+
| miércoles mié enero ene                 |
+-----------------------------------------+
1 row in set (0.00 sec)
每个受影响的函数的日期或月份名称都转换为系统变量
utf8mb4指示的字符集
。character_set_connection
lc_time_names可以设置为以下任何区域设置值。MySQL 支持的语言环境集可能与您的操作系统支持的语言环境集不同。
语言环境值
意义
ar_AE
阿拉伯语 - 阿拉伯联合酋长国
ar_BH
阿拉伯语 - 巴林
ar_DZ
阿拉伯语 - 阿尔及利亚
ar_EG
阿拉伯语 - 埃及
ar_IN
阿拉伯语 - 印度
ar_IQ
阿拉伯语 - 伊拉克
ar_JO
阿拉伯语 - 约旦
ar_KW
阿拉伯语 - 科威特
ar_LB
阿拉伯语 - 黎巴嫩
ar_LY
阿拉伯语 - 利比亚
ar_MA
阿拉伯语 - 摩洛哥
ar_OM
阿拉伯语 - 阿曼
ar_QA
阿拉伯语 - 卡塔尔
ar_SA
阿拉伯语 - 沙特阿拉伯
ar_SD
阿拉伯语 - 苏丹
ar_SY
阿拉伯语 - 叙利亚
ar_TN
阿拉伯语 - 突尼斯
ar_YE
阿拉伯语 - 也门
be_BY
白俄罗斯语 - 白俄罗斯
bg_BG
保加利亚语 - 保加利亚
ca_ES
加泰罗尼亚语 - 西班牙
cs_CZ
捷克 - 捷克共和国
da_DK
丹麦语 - 丹麦
de_AT
德语 - 奥地利
de_BE
德语 - 比利时
de_CH
德语 - 瑞士
de_DE
德语 - 德国
de_LU
德语 - 卢森堡
el_GR
希腊语 - 希腊
en_AU
英语 - 澳大利亚
en_CA
英语 - 加拿大
en_GB
英语 - 英国
en_IN
英语 - 印度
en_NZ
英语 - 新西兰
en_PH
英语 - 菲律宾
en_US
美国英语
en_ZA
英语 - 南非
en_ZW
英语 - 津巴布韦
es_AR
西班牙语 - 阿根廷
es_BO
西班牙语 - 玻利维亚
es_CL
西班牙语 - 智利
es_CO
西班牙语 - 哥伦比亚
es_CR
西班牙语 - 哥斯达黎加
es_DO
西班牙语 - 多米尼加共和国
es_EC
西班牙语 - 厄瓜多尔
es_ES
西班牙语 - 西班牙
es_GT
西班牙语 - 危地马拉
es_HN
西班牙语 - 洪都拉斯
es_MX
西班牙语 - 墨西哥
es_NI
西班牙语 - 尼加拉瓜
es_PA
西班牙语 - 巴拿马
es_PE
西班牙语 - 秘鲁
es_PR
西班牙语 - 波多黎各
es_PY
西班牙语 - 巴拉圭
es_SV
西班牙语 - 萨尔瓦多
es_US
西班牙语 - 美国
es_UY
西班牙语 - 乌拉圭
es_VE
西班牙语 - 委内瑞拉
et_EE
爱沙尼亚语——爱沙尼亚
eu_ES
巴斯克语——西班牙
fi_FI
芬兰语 - 芬兰
fo_FO
法罗群岛 - 法罗群岛
fr_BE
法语 - 比利时
fr_CA
法语 - 加拿大
fr_CH
法语 - 瑞士
fr_FR
法语 - 法国
fr_LU
法语 - 卢森堡
gl_ES
加利西亚-西班牙
gu_IN
古吉拉特语 - 印度
he_IL
希伯来语 - 以色列
hi_IN
印地语 - 印度
hr_HR
克罗地亚语 - 克罗地亚
hu_HU
匈牙利语 - 匈牙利
id_ID
印度尼西亚语 - 印度尼西亚
is_IS
冰岛语 - Iceland
it_CH
意大利语 - 瑞士
it_IT
意大利语——意大利
ja_JP
日语 - 日本
ko_KR
韩语 - 大韩民国
lt_LT
立陶宛语 - 立陶宛
lv_LV
拉脱维亚 - 拉脱维亚
mk_MK
马其顿语 - 北马其顿
mn_MN
蒙古 - 蒙古语
ms_MY
马来语 - 马来西亚
nb_NO
挪威语（Bokmål）——挪威
nl_BE
荷兰语 - 比利时
nl_NL
荷兰语——荷兰
no_NO
挪威语——挪威
pl_PL
波兰语 - 波兰
pt_BR
葡萄牙语 - 巴西
pt_PT
葡萄牙语 - 葡萄牙
rm_CH
罗曼语——瑞士
ro_RO
罗马尼亚语 - 罗马尼亚
ru_RU
俄语 - 俄罗斯
ru_UA
俄语 - 乌克兰
sk_SK
斯洛伐克 - 斯洛伐克
sl_SI
斯洛文尼亚语 - 斯洛文尼亚
sq_AL
阿尔巴尼亚语——阿尔巴尼亚
sr_RS
塞尔维亚语 - 塞尔维亚
sv_FI
瑞典语 - 芬兰
sv_SE
瑞典语 - 瑞典
ta_IN
泰米尔语 - 印度
te_IN
泰卢固语 - 印度
th_TH
泰国 - 泰国
tr_TR
土耳其语 - 土耳其
uk_UA
乌克兰语 - 乌克兰
ur_PK
乌尔都语-巴基斯坦
vi_VN
越南语 - 越南
zh_CN
中文 - 中国
zh_HK
中国 - 香港
zh_TW
中国 - 台湾
© Mysql 中文网
