# 2.13.3 使用 Perl DBI/DBD 接口的问题_MySQL 8.0 参考手册

2.13.3 使用 Perl DBI/DBD 接口的问题_MySQL 8.0 参考手册
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
2.1 一般安装指南
2.2 使用通用二进制文件在 Unix/Linux 上安装 MySQL
2.3 在 Microsoft Windows 上安装 MySQL
2.4 在 macOS 上安装 MySQL
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
2.13.1 在 Unix 上安装 Perl1
2.13.2 在 Windows 上安装 ActiveState Perl1
2.13.3 使用 Perl DBI/DBD 接口的问题1
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
第 29 章连接器和 API
第30章MySQL企业版
第31章MySQL工作台
第 32 章 OCI 市场上的 MySQL
附录 A MySQL 8.0 常见问题解答
附录 B 错误信息和常见问题
附录 C 索引
MySQL 词汇表
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.13 Perl 安装注意事项  /
2.13.3 使用 Perl DBI/DBD 接口的问题
2.13.3 使用 Perl DBI/DBD 接口的问题
如果 Perl 报告找不到
../mysql/mysql.so模块，问题可能是 Perl 找不到
libmysqlclient.so共享库。您应该能够通过以下方法之一解决此问题：
复制libmysqlclient.so到您的其他共享库所在的目录（可能是
/usr/lib或/lib）。
修改-L用于编译的选项
DBD::mysql以反映libmysqlclient.so.
在 Linux 上，您可以将所在目录的路径名添加
libmysqlclient.so到
/etc/ld.so.conf文件中。
将所在目录的路径名添加
libmysqlclient.so到
LD_RUN_PATH环境变量中。有些系统使用LD_LIBRARY_PATH。
-L
请注意，如果链接器无法找到其他库
，您可能还需要修改选项。例如，如果链接器找不到
libc，因为它在/lib
并且链接命令指定-L/usr/lib，请将-L选项更改为-L/lib或添加
-L/lib到现有链接命令。
如果您从 中得到以下错误
DBD::mysql，您可能正在使用
gcc （或使用用gcc编译的旧二进制文件
）：
/usr/bin/perl: can't resolve symbol '__moddi3'
/usr/bin/perl: can't resolve symbol '__divdi3'
在构建库时添加-L/usr/lib/gcc-lib/... -lgcc到链接命令（在编译 Perl 客户端时检查make的
mysql.so输出）。该选项应指定系统上目录的路径名。
mysql.so-Llibgcc.a
这个问题的另一个原因可能是 Perl 和 MySQL 不是都用gcc 编译的。在这种情况下，您可以通过使用gcc进行编译来解决不匹配问题。
© Mysql 中文网
