# 4.10 MySQL 中的 Unix 信号处理_MySQL 8.0 参考手册

4.10 MySQL 中的 Unix 信号处理_MySQL 8.0 参考手册
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  /
4.10 MySQL 中的 Unix 信号处理
4.10 MySQL 中的 Unix 信号处理
在 Unix 和类 Unix 系统上，进程可以是root系统帐户或拥有该进程的系统帐户发送给它的信号的接收者。可以使用kill命令发送信号。一些命令解释器将某些键序列与信号相关联，例如
Control+C发送SIGINT
信号。本节介绍 MySQL 服务器和客户端程序如何响应信号。
服务器对信号的响应客户端对信号的响应
服务器对信号的响应
mysqld响应信号如下：
SIGTERM导致服务器关闭。这就像在
SHUTDOWN不必连接到服务器的情况下执行语句（关闭服务器需要具有
SHUTDOWN特权的帐户）。
SIGHUP导致服务器重新加载授权表并刷新表、日志、线程缓存和主机缓存。这些动作就像FLUSH语句的各种形式。发送信号可以在无需连接到服务器的情况下执行刷新操作，这需要一个 MySQL 帐户具有足够的权限来执行这些操作。在 MySQL 8.0.20 之前，服务器还会将状态报告写入具有以下格式的错误日志：
Status information:
Current dir: /var/mysql/data/
Running threads: 4  Stack size: 262144
Current locks:
lock: 0x7f742c02c0e0:
lock: 0x2cee2a20:
:
lock: 0x207a080:
Key caches:
default
Buffer_size:       8388608
Block_size:           1024
Division_limit:        100
Age_limit:             300
blocks used:             4
not flushed:             0
w_requests:              0
writes:                  0
r_requests:              8
reads:                   4
handler status:
read_key:           13
read_next:           4
read_rnd             0
read_first:         13
write:               1
delete               0
update:              0
Table status:
Opened tables:        121
Open tables:          114
Open files:            18
Open streams:           0
Memory status:
<malloc version="1">
<heap nr="0">
<sizes>
<size from="17" to="32" total="32" count="1"/>
<size from="33" to="48" total="96" count="2"/>
<size from="33" to="33" total="33" count="1"/>
<size from="97" to="97" total="6014" count="62"/>
<size from="113" to="113" total="904" count="8"/>
<size from="193" to="193" total="193" count="1"/>
<size from="241" to="241" total="241" count="1"/>
<size from="609" to="609" total="609" count="1"/>
<size from="16369" to="16369" total="49107" count="3"/>
<size from="24529" to="24529" total="98116" count="4"/>
<size from="32689" to="32689" total="32689" count="1"/>
<unsorted from="241" to="7505" total="7746" count="2"/>
</sizes>
<total type="fast" count="3" size="128"/>
<total type="rest" count="84" size="195652"/>
<system type="current" size="690774016"/>
<system type="max" size="690774016"/>
<aspace type="total" size="690774016"/>
<aspace type="mprotect" size="690774016"/>
</heap>
:
<total type="fast" count="85" size="5520"/>
<total type="rest" count="116" size="316820"/>
<total type="mmap" count="82" size="939954176"/>
<system type="current" size="695717888"/>
<system type="max" size="695717888"/>
<aspace type="total" size="695717888"/>
<aspace type="mprotect" size="695717888"/>
</malloc>
Events status:
LLA = Last Locked At  LUA = Last Unlocked At
WOC = Waiting On Condition  DL = Data Locked
Event scheduler status:
State      : INITIALIZED
Thread id  : 0
LLA        : n/a:0
LUA        : n/a:0
WOC        : NO
Workers    : 0
Executed   : 0
Data locked: NO
Event queue status:
Element count   : 0
Data locked     : NO
Attempting lock : NO
LLA             : init_queue:95
LUA             : init_queue:103
WOC             : NO
Next activation : never
从 MySQL 8.0.19 开始，SIGUSR1导致服务器刷新错误日志、一般查询日志和慢速查询日志。for 的一种用途SIGUSR1是在无需连接到服务器的情况下实现日志轮换，这需要一个 MySQL 帐户具有足够的权限来执行这些操作。有关日志轮换的信息，请参阅第 5.4.6 节，“服务器日志维护”。
服务器对 的响应SIGUSR1是对 的响应的一个子集，SIGHUP可以SIGUSR1用作更
“轻量级”的信号来刷新某些日志，而不会产生其他SIGHUP影响，例如刷新线程和主机缓存以及将状态报告写入错误日志。
SIGINT通常被服务器忽略。使用该选项启动服务器
--gdb会安装一个中断处理程序以SIGINT用于调试目的。参见
第 5.9.1.4 节，“在 gdb 下调试 mysqld”。
客户端对信号的响应
MySQL客户端程序响应信号如下：
mysql客户端将
（SIGINT通常是键入
Control+C的结果）解释为中断当前语句（如果有）的指令，否则取消任何部分输入行。可以使用--sigint-ignore忽略SIGINT信号的选项禁用此行为。
默认情况下，使用 MySQL 客户端库的客户端程序会阻止
SIGPIPE信号。这些变化是可能的：
客户端可以安装自己的SIGPIPE
处理程序来覆盖默认行为。请参阅
编写 C API 线程化客户端程序。
客户端可以通过在连接时SIGPIPE指定
CLIENT_IGNORE_SIGPIPE选项来
阻止处理程序的安装
。mysql_real_connect()请参阅mysql_real_connect()。
© Mysql 中文网
