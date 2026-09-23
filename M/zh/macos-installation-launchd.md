# 2.4.3 安装和使用MySQL Launch Daemon_MySQL 8.0 参考手册

2.4.3 安装和使用MySQL Launch Daemon_MySQL 8.0 参考手册
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
2.4.1 macOS 安装MySQL 一般注意事项1
2.4.2 在 macOS 上使用原生包安装 MySQL1
2.4.3 安装和使用MySQL Launch Daemon1
2.4.4 安装和使用 MySQL 首选项面板1
2.5 在 Linux 上安装 MySQL
2.6 使用坚不可摧的Linux网络（ULN）安装MySQL
2.7 在 Solaris 上安装 MySQL
2.8 在 FreeBSD 上安装 MySQL
2.9 从源码安装MySQL
2.10 安装后设置和测试
2.11 升级MySQL
2.12 降级MySQL
2.13 Perl 安装注意事项
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
MySQL 8.0 参考手册  / 第 2 章安装和升级 MySQL  / 2.4 在 macOS 上安装 MySQL  /
2.4.3 安装和使用MySQL Launch Daemon
2.4.3 安装和使用MySQL Launch Daemon
macOS 使用启动守护进程来自动启动、停止和管理进程和应用程序，例如 MySQL。
默认情况下，macOS 上的安装包 (DMG) 会安装一个名为 launchd 的文件
/Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist
，其中包含类似于以下内容的 plist 定义：
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>             <string>com.oracle.oss.mysql.mysqld</string>
<key>ProcessType</key>       <string>Interactive</string>
<key>Disabled</key>          <false/>
<key>RunAtLoad</key>         <true/>
<key>KeepAlive</key>         <true/>
<key>SessionCreate</key>     <true/>
<key>LaunchOnlyOnce</key>    <false/>
<key>UserName</key>          <string>_mysql</string>
<key>GroupName</key>         <string>_mysql</string>
<key>ExitTimeOut</key>       <integer>600</integer>
<key>Program</key>           <string>/usr/local/mysql/bin/mysqld</string>
<key>ProgramArguments</key>
<array>
<string>/usr/local/mysql/bin/mysqld</string>
<string>--user=_mysql</string>
<string>--basedir=/usr/local/mysql</string>
<string>--datadir=/usr/local/mysql/data</string>
<string>--plugin-dir=/usr/local/mysql/lib/plugin</string>
<string>--log-error=/usr/local/mysql/data/mysqld.local.err</string>
<string>--pid-file=/usr/local/mysql/data/mysqld.local.pid</string>
<string>--keyring-file-data=/usr/local/mysql/keyring/keyring</string>
<string>--early-plugin-load=keyring_file=keyring_file.so</string>
</array>
<key>WorkingDirectory</key>  <string>/usr/local/mysql</string>
</dict>
</plist>
笔记
一些用户报告说添加 plist DOCTYPE 声明会导致 launchd 操作失败，尽管它通过了 lint 检查。我们怀疑这是复制粘贴错误。包含上述片段的文件的 md5 校验和是
d925f05f6d1b6ee5ce5451b596d6baed。
要启用 launchd 服务，您可以：
打开 macOS 系统首选项并选择 MySQL 首选项面板，然后执行Start MySQL Server。
图 2.18 MySQL 首选项面板：位置
Instances页面包括启动或停止 MySQL
的选项，Initialize Database会重新创建data/
目录。卸载卸载 MySQL 服务器和可选的 MySQL 首选项面板和启动信息。
图 2.19 MySQL 首选项面板：实例
或者，手动加载 launchd 文件。
$> cd /Library/LaunchDaemons
$> sudo launchctl load -F com.oracle.oss.mysql.mysqld.plist
要将 MySQL 配置为开机自动启动，您可以：
$> sudo launchctl load -w com.oracle.oss.mysql.mysqld.plist
笔记
升级 MySQL 服务器时，launchd 安装过程会删除 MySQL 服务器 5.7.7 及以下版本安装的旧启动项。
升级还会替换您现有的名为 .launchd 的文件
com.oracle.oss.mysql.mysqld.plist。
其他 launchd 相关信息：
plist 条目覆盖my.cnf
条目，因为它们作为命令行参数传入。有关传入程序选项的其他信息，请参阅第 4.2.2 节，“指定程序选项”。
ProgramArguments部分定义传递到程序中的命令行选项，在本例中为
二进制mysqld文件。
默认的 plist 定义是在考虑不太复杂的用例的情况下编写的。对于更复杂的设置，您可能希望删除一些参数，而是依赖 MySQL 配置文件，例如
my.cnf.
如果您编辑 plist 文件，则在重新安装或升级 MySQL 时取消选中安装程序选项。否则，您编辑的 plist 文件将被覆盖，并且所有编辑都将丢失。
因为默认的 plist 定义定义了几个
ProgramArguments，你可以删除大部分这些参数，而是依赖你的
my.cnfMySQL 配置文件来定义它们。例如：
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>             <string>com.oracle.oss.mysql.mysqld</string>
<key>ProcessType</key>       <string>Interactive</string>
<key>Disabled</key>          <false/>
<key>RunAtLoad</key>         <true/>
<key>KeepAlive</key>         <true/>
<key>SessionCreate</key>     <true/>
<key>LaunchOnlyOnce</key>    <false/>
<key>UserName</key>          <string>_mysql</string>
<key>GroupName</key>         <string>_mysql</string>
<key>ExitTimeOut</key>       <integer>600</integer>
<key>Program</key>           <string>/usr/local/mysql/bin/mysqld</string>
<key>ProgramArguments</key>
<array>
<string>/usr/local/mysql/bin/mysqld</string>
<string>--user=_mysql</string>
<string>--basedir=/usr/local/mysql</string>
<string>--datadir=/usr/local/mysql/data</string>
<string>--plugin-dir=/usr/local/mysql/lib/plugin</string>
<string>--log-error=/usr/local/mysql/data/mysqld.local.err</string>
<string>--pid-file=/usr/local/mysql/data/mysqld.local.pid</string>
<string>--keyring-file-data=/usr/local/mysql/keyring/keyring</string>
<string>--early-plugin-load=keyring_file=keyring_file.so</string>
</array>
<key>WorkingDirectory</key>  <string>/usr/local/mysql</string>
</dict>
</plist>
在这种情况下，basedir、
datadir、
plugin_dir、
log_error、
pid_file、
keyring_file_data和
﻿--early-plugin-load选项
已从默认的 plist ProgramArguments定义中删除，您可能已经在其中定义了该定义my.cnf。
© Mysql 中文网
