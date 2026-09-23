# 15.20.5 InnoDB memcached 插件的安全注意事项_MySQL 8.0 参考手册

15.20.5 InnoDB memcached 插件的安全注意事项_MySQL 8.0 参考手册
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
15.1 InnoDB简介
15.2 InnoDB 和 ACID 模型
15.3 InnoDB 多版本
15.4 InnoDB架构
15.5 InnoDB 内存结构
15.6 InnoDB 磁盘结构
15.7 InnoDB 锁定和事务模型
15.8 InnoDB配置
15.9 InnoDB 表和页压缩
15.10 InnoDB 行格式
15.11 InnoDB磁盘I/O和文件空间管理
15.12 InnoDB和在线DDL
15.13 InnoDB静态数据加密
15.14 InnoDB 启动选项和系统变量
15.15 InnoDB INFORMATION_SCHEMA 表
15.16 InnoDB 与 MySQL 性能模式的集成
15.17 InnoDB 监视器
15.18 InnoDB备份与恢复
15.19 InnoDB和MySQL复制
15.20 InnoDB 内存缓存插件
15.20.1 InnoDB memcached 插件的好处1
15.20.2 InnoDB 内存缓存架构1
15.20.3 设置 InnoDB memcached 插件1
15.20.4 InnoDB memcached 多获取和范围查询支持1
15.20.5 InnoDB memcached 插件的安全注意事项1
15.20.6 为 InnoDB memcached 插件编写应用程序1
15.20.7 InnoDB memcached 插件和复制1
15.20.8 InnoDB memcached 插件内部1
15.20.9 InnoDB memcached 插件故障排除1
15.21 InnoDB 故障排除
15.22 InnoDB 限制
15.23 InnoDB 限制和限制
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
MySQL 8.0 参考手册  / 第 15 章 InnoDB 存储引擎  / 15.20 InnoDB 内存缓存插件  /
15.20.5 InnoDB memcached 插件的安全注意事项
15.20.5 InnoDB memcached 插件的安全注意事项
警告
daemon_memcached如果 MySQL 实例包含敏感数据，则在生产服务器或测试服务器上
部署插件之前请参阅本节
。
由于memcached默认不使用认证机制，可选的SASL认证没有传统DBMS安全措施强，只在使用daemon_memcached插件的MySQL实例中保留非敏感数据，隔离任何使用此配置的服务器来自潜在的入侵者。不允许memcached从 Internet 访问这些服务器；只允许从有防火墙的内部网访问，最好是从您可以限制成员资格的子网访问。
使用 SASL 密码保护 memcached
SASL 支持提供了保护您的 MySQL 数据库免受通过
memcached客户端未经身份验证的访问的能力。本节介绍如何使用daemon_memcached
插件启用 SASL。这些步骤几乎与为传统memcached
服务器启用 SASL 所执行的步骤相同。
SASL 代表“简单身份验证和安全层”，这是一种为基于连接的协议添加身份验证支持的标准。memcached在版本 1.4.3 中添加了 SASL 支持。
SASL 身份验证仅支持二进制协议。
memcached客户端只能访问
InnoDB在表中注册的
innodb_memcache.containers表。即使 DBA 可以对此类表进行访问限制，也无法控制通过memcached应用程序进行的访问。为此，提供了 SASL 支持来控制对插件
InnoDB关联的表的daemon_memcached
以下部分展示了如何构建、启用和测试支持 SASL 的daemon_memcached插件。
使用 InnoDB memcached 插件构建和启用 SASL
默认情况下，启用 SASL 的daemon_memcached
插件不包含在 MySQL 发布包中，因为启用 SASL 的插件需要使用 SASL 库daemon_memcached构建memcached 。要启用 SASL 支持，请下载 MySQL 源代码并在下载 SASL 库后重建
daemon_memcached插件：
安装 SASL 开发和实用程序库。例如，在 Ubuntu 上，使用apt-get获取库：
sudo apt-get -f install libsasl2-2 sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules通过添加到您的
cmake选项
来
构建daemon_memcached具有 SASL 功能的插件共享库
。memcached还提供简单的明文密码支持，这有助于测试。要启用简单的明文密码支持，请指定cmake选项。
ENABLE_MEMCACHED_SASL=1ENABLE_MEMCACHED_SASL_PWDB=1
总之，添加以下三个cmake
选项：
cmake ... -DWITH_INNODB_MEMCACHED=1 -DENABLE_MEMCACHED_SASL=1 -DENABLE_MEMCACHED_SASL_PWDB=1
安装daemon_memcached插件，如第 15.20.3 节“设置 InnoDB memcached 插件”中所述。
配置用户名和密码文件。（此示例使用
memcached简单明文密码支持。）
在一个文件中，创建一个名为的用户并将
testname密码定义为
testpasswd：
echo "testname:testpasswd:::::::" >/home/jy/memcached-sasl-db
配置MEMCACHED_SASL_PWDB
环境变量告知
memcached用户名密码文件：
export MEMCACHED_SASL_PWDB=/home/jy/memcached-sasl-db
通知memcached使用明文密码：
echo "mech_list: plain" > /home/jy/work2/msasl/clients/memcached.conf
export SASL_CONF_PATH=/home/jy/work2/msasl/clients
通过使用配置参数
中编码
的memcached 选项
重新启动 MySQL 服务器来启用 SASL
：-Sdaemon_memcached_optionmysqld ... --daemon_memcached_option="-S"
要测试设置，请使用支持 SASL 的客户端，例如
支持 SASL 的 libmemcached。
memcp --servers=localhost:11211 --binary  --username=testname
--password=password myfile.txt
memcat --servers=localhost:11211 --binary --username=testname
--password=password myfile.txt
如果指定的用户名或密码不正确，操作将被拒绝并显示一条memcache error
AUTHENTICATION FAILURE消息。在这种情况下，请检查
memcached-sasl-db文件中设置的明文密码以验证您提供的凭据是否正确。
还有其他方法可以使用
memcached测试 SASL 身份验证，但上述方法是最直接的。
© Mysql 中文网
