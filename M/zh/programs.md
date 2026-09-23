# 第 4 章 MySQL 程序_MySQL 8.0 参考手册

第 4 章 MySQL 程序_MySQL 8.0 参考手册
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
4.1 MySQL程序概述
4.2 使用 MySQL 程序
4.3 服务器和服务器启动程序
4.4 安装相关程序
4.5 客户端程序
4.6 管理和实用程序
4.7 程序开发实用程序
4.8 杂项程序
4.9 环境变量
4.10 MySQL 中的 Unix 信号处理
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
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  /
第 4 章 MySQL 程序
第 4 章 MySQL 程序
目录4.1 MySQL程序概述4.2 使用 MySQL 程序4.2.1 调用MySQL程序4.2.2 指定程序选项4.2.3 连接服务器的命令选项4.2.4 使用命令选项连接到 MySQL 服务器4.2.5 使用类似 URI 的字符串或键值对连接到服务器4.2.6 使用 DNS SRV 记录连接到服务器4.2.7 连接传输协议4.2.8 连接压缩控制4.2.9 设置环境变量4.3 服务器和服务器启动程序4.3.1 mysqld——MySQL 服务器4.3.2 mysqld_safe — MySQL 服务器启动脚本4.3.3 mysql.server——MySQL服务器启动脚本4.3.4 mysqld_multi — 管理多个 MySQL 服务器4.4 安装相关程序4.4.1 comp_err——编译MySQL错误信息文件4.4.2 mysql_secure_installation——提高MySQL安装安全性4.4.3 mysql_ssl_rsa_setup — 创建 SSL/RSA 文件4.4.4 mysql_tzinfo_to_sql — 加载时区表4.4.5 mysql_upgrade — 检查和升级 MySQL 表4.5 客户端程序4.5.1 mysql——MySQL 命令行客户端4.5.2 mysqladmin——一个 MySQL 服务器管理程序4.5.3 mysqlcheck——表维护程序4.5.4 mysqldump——数据库备份程序4.5.5 mysqlimport——一个数据导入程序4.5.6 mysqlpump——数据库备份程序4.5.7 mysqlshow——显示数据库、表和列信息4.5.8 mysqlslap — 负载仿真客户端4.6 管理和实用程序4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序4.6.2 innochecksum — 离线 InnoDB 文件校验和工具4.6.3 myisam_ftdump——显示全文索引信息4.6.4 myisamchk — MyISAM 表维护实用程序4.6.5 myisamlog——显示MyISAM日志文件内容4.6.6 myisampack——生成压缩的、只读的 MyISAM 表4.6.7 mysql_config_editor — MySQL 配置实用程序4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序4.6.10 mysqldumpslow——总结慢查询日志文件4.7 程序开发实用程序4.7.1 mysql_config——编译客户端的显示选项4.7.2 my_print_defaults — 显示选项文件中的选项4.8 杂项程序4.8.1 lz4_decompress — 解压缩 mysqlpump LZ4 压缩输出4.8.2 perror——显示MySQL错误信息信息4.8.3 zlib_decompress — 解压缩 mysqlpump ZLIB 压缩输出4.9 环境变量4.10 MySQL 中的 Unix 信号处理
本章简要概述了 Oracle 公司提供的 MySQL 命令行程序。它还讨论了在运行这些程序时指定选项的一般语法。大多数程序都有特定于其自身操作的选项，但所有程序的选项语法都相似。最后，本章对各个程序进行了更详细的描述，包括它们认可的选项。
© Mysql 中文网
