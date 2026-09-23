# 28.1 使用 sys 模式的先决条件_MySQL 8.0 参考手册

28.1 使用 sys 模式的先决条件_MySQL 8.0 参考手册
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
28.1 使用 sys 模式的先决条件
28.2 使用系统模式
28.3 sys Schema 进度报告
28.4 sys 模式对象参考
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 28 章 MySQL 系统模式  /
28.1 使用 sys 模式的先决条件
28.1 使用 sys 模式的先决条件
在使用sys模式之前，必须满足本节中描述的先决条件。
因为sys模式提供了访问性能模式的替代方法，所以必须启用性能模式才能使
sys模式工作。请参阅
第 27.3 节，“性能模式启动配置”。
要完全访问sys架构，用户必须具有以下权限：
SELECT在所有
sys表和视图
上
EXECUTE在所有
sys存储过程和函数
上
INSERTUPDATE对于
表格，
sys_config如果要对其进行更改
某些模式存储过程和函数的附加权限
sys，如其描述中所述（例如，
ps_setup_save()过程）
还需要对sys模式对象下的对象具有特权：
SELECT在模式对象访问的任何性能模式表上sys
，以及UPDATE使用
sys模式对象
更新的任何表
PROCESS对于
INFORMATION_SCHEMA
INNODB_BUFFER_PAGE表
必须启用某些 Performance Schema 工具和消费者，并且（对于工具）定时以充分利用
sys模式功能：
所有wait仪器
所有stage仪器
所有statement仪器
xxx_current和
xxx_history_long
所有事件的消费者
您可以使用sys架构本身来启用所有其他工具和消费者：
CALL sys.ps_setup_enable_instrument('wait');
CALL sys.ps_setup_enable_instrument('stage');
CALL sys.ps_setup_enable_instrument('statement');
CALL sys.ps_setup_enable_consumer('current');
CALL sys.ps_setup_enable_consumer('history_long');
笔记
对于sys模式的许多用途，默认的性能模式足以用于数据收集。启用刚才提到的所有仪器和消费者都会影响性能，因此最好只启用您需要的额外配置。另外，请记住，如果启用其他配置，则可以像这样轻松恢复默认配置：
CALL sys.ps_setup_reset_to_default(TRUE);
© Mysql 中文网
