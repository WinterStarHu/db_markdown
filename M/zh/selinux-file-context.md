# 6.7.4 SELinux 文件上下文_MySQL 8.0 参考手册

6.7.4 SELinux 文件上下文_MySQL 8.0 参考手册
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
6.5 MySQL 企业数据屏蔽和去标识化
6.6 MySQL企业加密
6.7 SELinux
6.7.1 检查 SELinux 是否开启1
6.7.2 更改 SELinux 模式1
6.7.3 MySQL 服务器 SELinux 策略1
6.7.4 SELinux 文件上下文1
6.7.5 SELinux TCP 端口上下文1
6.7.6 SELinux 故障排除1
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
MySQL 8.0 参考手册  / 第 6 章 安全  / 6.7 SELinux  /
6.7.4 SELinux 文件上下文
6.7.4 SELinux 文件上下文
MySQL 服务器读取和写入许多文件。如果没有为这些文件正确设置 SELinux 上下文，则可能会拒绝访问这些文件。
下面的说明使用semanage
二进制文件来管理文件上下文；在 RHEL 上，它是
policycoreutils-python-utils包的一部分：
yum install -y policycoreutils-python-utils
安装二进制文件后，您可以使用选项semanage列出 MySQL 文件上下文。
semanagefcontextsemanage fcontext -l | grep -i mysql
设置 MySQL 数据目录上下文
默认数据目录位置是
/var/lib/mysql/；并且使用的 SELinux 上下文是mysqld_db_t.
如果您编辑配置文件以将不同的位置用于数据目录，或用于通常位于数据目录中的任何文件（例如二进制日志），您可能需要为新位置设置上下文。例如：
semanage fcontext -a -t mysqld_db_t "/path/to/my/custom/datadir(/.*)?"
restorecon -Rv /path/to/my/custom/datadir
semanage fcontext -a -t mysqld_db_t "/path/to/my/custom/logdir(/.*)?"
restorecon -Rv /path/to/my/custom/logdir
设置 MySQL 错误日志文件上下文
RedHat RPM 的默认位置是
/var/log/mysqld.log；并且使用的 SELinux 上下文类型是mysqld_log_t.
如果您编辑配置文件以使用不同的位置，您可能需要为新位置设置上下文。例如：
semanage fcontext -a -t mysqld_log_t "/path/to/my/custom/error.log"
restorecon -Rv /path/to/my/custom/error.log
设置 PID 文件上下文
PID 文件的默认位置是
/var/run/mysqld/mysqld.pid；并且使用的 SELinux 上下文类型是mysqld_var_run_t.
如果您编辑配置文件以使用不同的位置，您可能需要为新位置设置上下文。例如：
semanage fcontext -a -t mysqld_var_run_t "/path/to/my/custom/pidfile/directory/.*?"
restorecon -Rv /path/to/my/custom/pidfile/directory
设置 Unix 域套接字上下文
Unix 域套接字的默认位置是
/var/lib/mysql/mysql.sock；并且使用的 SELinux 上下文类型是mysqld_var_run_t.
如果您编辑配置文件以使用不同的位置，您可能需要为新位置设置上下文。例如：
semanage fcontext -a -t mysqld_var_run_t "/path/to/my/custom/mysql\.sock"
restorecon -Rv /path/to/my/custom/mysql.sock
设置 secure_file_priv 目录上下文
对于 5.6.34、5.7.16 和 8.0.11 之后的 MySQL 版本。
安装 MySQL Server RPM 会创建一个
/var/lib/mysql-files/目录，但不会为其设置 SELinux 上下文。该
/var/lib/mysql-files/目录旨在用于诸如SELECT ... INTO
OUTFILE.
如果您通过设置启用了此目录
secure_file_priv，您可能需要像这样设置上下文：
semanage fcontext -a -t mysqld_db_t "/var/lib/mysql-files/(/.*)?"
restorecon -Rv /var/lib/mysql-files
如果您使用不同的位置，请编辑此路径。出于安全目的，此目录永远不应位于数据目录中。
有关此变量的更多信息，请参阅
secure_file_priv文档。
© Mysql 中文网
