# 6.4.5 MySQL企业审计_MySQL 8.0 参考手册

6.4.5 MySQL企业审计_MySQL 8.0 参考手册
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
6.1 一般安全问题
6.2 访问控制和账户管理
6.3 使用加密连接
6.4 安全组件和插件
6.4.1 认证插件1
6.4.2 连接控制插件1
6.4.3 密码验证组件1
6.4.4 MySQL 密钥环1
6.4.5 MySQL企业审计1
6.4.5.1 MySQL 企业审计要素
6.4.5.2 安装或卸载 MySQL Enterprise Audit
6.4.5.3 MySQL 企业审计安全注意事项
6.4.5.4 审计日志文件格式
6.4.5.5 配置审计日志特征
6.4.5.6 读取审计日志文件
6.4.5.7 审计日志过滤
6.4.5.8 编写审计日志过滤器定义
6.4.5.9 禁用审计日志
6.4.5.10 传统模式审计日志过滤
6.4.5.11 审计日志参考
6.4.5.12 审计日志限制
6.4.6 审计消息组件1
6.4.7 MySQL 企业防火墙1
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.8 FIPS 支持
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
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.4 安全组件和插件  /
6.4.5 MySQL企业审计
6.4.5 MySQL企业审计
6.4.5.1 MySQL 企业审计要素6.4.5.2 安装或卸载 MySQL Enterprise Audit6.4.5.3 MySQL 企业审计安全注意事项6.4.5.4 审计日志文件格式6.4.5.5 配置审计日志特征6.4.5.6 读取审计日志文件6.4.5.7 审计日志过滤6.4.5.8 编写审计日志过滤器定义6.4.5.9 禁用审计日志6.4.5.10 传统模式审计日志过滤6.4.5.11 审计日志参考6.4.5.12 审计日志限制
笔记
MySQL Enterprise Audit 是商业产品 MySQL Enterprise Edition 中包含的扩展。要了解有关商业产品的更多信息，请参阅
https://www.mysql.com/products/。
MySQL Enterprise Edition 包括 MySQL Enterprise Audit，使用名为
audit_log. MySQL Enterprise Audit 使用开放的 MySQL Audit API 来启用标准的、基于策略的监视、日志记录以及阻止在特定 MySQL 服务器上执行的连接和查询活动。MySQL Enterprise Audit 旨在满足 Oracle 审计规范，为受内部和外部监管准则约束的应用程序提供开箱即用、易于使用的审计和合规性解决方案。
安装后，审计插件使 MySQL 服务器能够生成包含服务器活动审计记录的日志文件。日志内容包括客户端何时连接和断开连接，以及它们在连接时执行的操作，例如它们访问了哪些数据库和表。从 MySQL 8.0.30 开始，您可以为每个查询的时间和大小添加统计信息以检测异常值。
安装审核插件后（请参阅
第 6.4.5.2 节，“安装或卸载 MySQL Enterprise Audit”），它会写入一个审核日志文件。默认情况下，该文件audit.log
在服务器数据目录中命名。要更改文件的名称，请audit_log_file在服务器启动时设置系统变量。
默认情况下，审计日志文件内容以新式 XML 格式编写，未压缩或加密。要选择文件格式，请audit_log_format
在服务器启动时设置系统变量。有关文件格式和内容的详细信息，请参阅第 6.4.5.4 节，“审计日志文件格式”。
有关控制日志记录方式的更多信息，包括审计日志文件命名和格式选择，请参阅
第 6.4.5.5 节，“配置审计日志记录特征”。要执行审计事件的过滤，请参阅
第 6.4.5.7 节，“审计日志过滤”。有关用于配置审计日志插件的参数的说明，请参阅
审计日志选项和变量。
如果启用了审计日志插件，则性能模式（请参阅
第 27 章，MySQL 性能模式）对其进行了检测。要识别相关工具，请使用此查询：
SELECT NAME FROM performance_schema.setup_instruments
WHERE NAME LIKE '%/alog/%';
© Mysql 中文网
