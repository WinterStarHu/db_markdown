# 4.6.2 innochecksum — 离线 InnoDB 文件校验和工具_MySQL 8.0 参考手册

4.6.2 innochecksum — 离线 InnoDB 文件校验和工具_MySQL 8.0 参考手册
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
4.6.1 ibd2sdi — InnoDB 表空间 SDI 提取实用程序1
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具1
4.6.3 myisam_ftdump——显示全文索引信息1
4.6.4 myisamchk — MyISAM 表维护实用程序1
4.6.5 myisamlog——显示MyISAM日志文件内容1
4.6.6 myisampack——生成压缩的、只读的 MyISAM 表1
4.6.7 mysql_config_editor — MySQL 配置实用程序1
4.6.8 mysql_migrate_keyring — 密钥环密钥迁移实用程序1
4.6.9 mysqlbinlog — 处理二进制日志文件的实用程序1
4.6.10 mysqldumpslow——总结慢查询日志文件1
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
MySQL 8.0 参考手册  / 第 4 章 MySQL 程序  / 4.6 管理和实用程序  /
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具
4.6.2 innochecksum — 离线 InnoDB 文件校验和工具
innochecksum打印
InnoDB文件的校验和。该工具读取
InnoDB表空间文件，计算每个页面的校验和，将计算的校验和与存储的校验和进行比较，并报告不匹配，这表明页面已损坏。它最初是为了在断电后加快验证表空间文件的完整性而开发的，但也可以在文件复制后使用。由于校验和不匹配会导致
InnoDB故意关闭正在运行的服务器，因此最好使用此工具，而不是等待生产中的服务器遇到损坏的页面。
innochecksum不能用于服务器已经打开的表空间文件。对于此类文件，您应该使用CHECK TABLE检查表空间内的表。尝试
在服务器已打开的表空间上运行innochecksum会导致无法锁定文件错误。
如果发现校验和不匹配，则从备份中恢复表空间或启动服务器并尝试使用
mysqldump对表空间内的表进行备份。
像这样调用innochecksum：
innochecksum [options] file_name
innochecksum 选项
innochecksum支持以下选项。对于引用页码的选项，数字从零开始。
--help,
-?
显示命令行帮助。用法示例：
innochecksum --help
--info,
-I
的同义词--help。显示命令行帮助。用法示例：
innochecksum --info
--version,
-V
显示版本信息。用法示例：
innochecksum --version
--verbose,
-v
详细模式；每五秒向日志文件打印一个进度指示器。为了打印进度指示器，必须使用
--log option. 要打开
verbose模式，请运行：
innochecksum --verbose
要关闭详细模式，请运行：
innochecksum --verbose=FALSE--verbose选项和
--log选项可以同时指定
。例如：
innochecksum --verbose --log=/var/lib/mysql/test/logtest.txt
要在日志文件中定位进度指示器信息，您可以执行以下搜索：
cat ./logtest.txt | grep -i "okay"
日志文件中的进度指示器信息类似于以下内容：
page 1663 okay: 2.863% done
page 8447 okay: 14.537% done
page 13695 okay: 23.568% done
page 18815 okay: 32.379% done
page 23039 okay: 39.648% done
page 28351 okay: 48.789% done
page 33023 okay: 56.828% done
page 37951 okay: 65.308% done
page 44095 okay: 75.881% done
page 49407 okay: 85.022% done
page 54463 okay: 93.722% done
...
--count,
-c
打印文件中的页数并退出。用法示例：
innochecksum --count ../data/test/tab1.ibd
--start-page=num,
-s num
从此页码开始。用法示例：
innochecksum --start-page=600 ../data/test/tab1.ibd
或者：
innochecksum -s 600 ../data/test/tab1.ibd
--end-page=num,
-e num
在此页码结束。用法示例：
innochecksum --end-page=700 ../data/test/tab1.ibd
或者：
innochecksum --p 700 ../data/test/tab1.ibd
--page=num,
-p num
仅检查此页码。用法示例：
innochecksum --page=701 ../data/test/tab1.ibd
--strict-check,
-C
指定严格的校验和算法。选项包括
innodb、crc32和
none。
在此示例中，innodb指定了校验和算法：
innochecksum --strict-check=innodb ../data/test/tab1.ibd
在此示例中，crc32指定了校验和算法：
innochecksum -C crc32 ../data/test/tab1.ibd
以下条件适用：
如果您未指定该
--strict-check
选项，则 innochecksum 将针对innodb,
crc32和进行验证none。
如果您指定该none选项，则只none允许由 生成的校验和。
如果您指定该innodb选项，则只innodb
允许由 生成的校验和。
如果您指定该crc32选项，则只crc32允许由 生成的校验和。
--no-check,
-n
重写校验和时忽略校验和验证。此选项只能与
innochecksum
--write选项一起使用。如果
--write未指定该选项，则innochecksum终止。
在此示例中，innodb重写校验和以替换无效校验和：
innochecksum --no-check --write innodb ../data/test/tab1.ibd
--allow-mismatches,
-a
innochecksum终止
前允许的最大校验和不匹配数
。默认设置为 0。如果
--allow-mismatches=N，其中N>=0，
N不匹配是允许的并且
innochecksum终止于
N+1。当
--allow-mismatches设置为 0 时，
innochecksum在第一个校验和不匹配时终止。
在此示例中，现有innodb
校验和被重写为设置
--allow-mismatches为 1。
innochecksum --allow-mismatches=1 --write innodb ../data/test/tab1.ibd
设置为 1 时，如果在--allow-mismatches1000 页文件的第 600 页和第 700 页不匹配，则会更新第 0-599 和 601-699 页的校验和。因为
--allow-mismatches设置为 1，所以校验和容忍第一次不匹配并在第二次不匹配时终止，从而使第 600 页和第 700-999 页保持不变。
--write=name,
-w num
重写校验和。重写无效校验和时，该
--no-check选项必须与该--write选项一起使用。该--no-check选项告诉innochecksum忽略对无效校验和的验证。--no-check如果当前校验和有效，则
不必指定该
选项。--write使用该选项
时必须指定算法
。--write该选项的
可能值为：
innodb：使用来自 的原始算法在软件中计算的校验和
InnoDB。
crc32：使用crc32算法计算的校验和，可能通过硬件辅助完成。
none: 一个常数。
该--write选项将整个页面重写到磁盘。如果新校验和与现有校验和相同，则不会将新校验和写入磁盘以最小化 I/O。
innochecksum--write在使用该选项
时获得排他锁
在这个例子中，crc32校验和被写为tab1.ibd：
innochecksum -w crc32 ../data/test/tab1.ibd
在此示例中，crc32重写校验和以替换无效crc32
校验和：
innochecksum --no-check --write crc32 ../data/test/tab1.ibd
--page-type-summary,
-S
显示表空间中每种页类型的计数。用法示例：
innochecksum --page-type-summary ../data/test/tab1.ibd
示例输出--page-type-summary：
File::../data/test/tab1.ibd
================PAGE TYPE SUMMARY==============
#PAGE_COUNT PAGE_TYPE
===============================================
2        Index page
0        Undo log page
1        Inode page
0        Insert buffer free list page
2        Freshly allocated page
1        Insert buffer bitmap
0        System page
0        Transaction system page
1        File Space Header
0        Extent descriptor page
0        BLOB page
0        Compressed BLOB page
0        Other type of page
===============================================
Additional information:
Undo page type: 0 insert, 0 update, 0 other
Undo page state: 0 active, 0 cached, 0 to_free, 0 to_purge, 0 prepared, 0 other
--page-type-dump,
-D
将表空间中每个页面的页面类型信息转储到stderr或stdout。用法示例：
innochecksum --page-type-dump=/tmp/a.txt ../data/test/tab1.ibd
--log,
-l
innochecksum工具
的日志输出。必须提供日志文件名。日志输出包含每个表空间页面的校验和值。对于未压缩的表，还提供了 LSN 值。--log替换了
--debug早期版本中可用的选项。
用法示例：
innochecksum --log=/tmp/log.txt ../data/test/tab1.ibd
或者：
innochecksum -l /tmp/log.txt ../data/test/tab1.ibd
-选项。
指定-从标准输入读取的选项。如果在预期“从标准中读取”时缺少该选项，则innochecksum打印-innochecksum使用信息
，指示“ - ”选项被省略。用法示例：
cat t1.ibd | innochecksum -
在此示例中，innochecksum将
crc32校验和算法
写入a.ibd而不更改原始
t1.ibd文件。
cat t1.ibd | innochecksum --write=crc32 - > a.ibd
在多个用户定义的表空间文件上运行 innochecksum
以下示例演示如何
在多个用户定义的表空间文件 ( files)
上运行innochecksum 。.ibd对“测试”
数据库
中的所有表空间 ( ) 文件
运行innochecksum ：.ibdinnochecksum ./data/test/*.ibd对文件名以“ t ”开头的所有表空间文件（文件）
运行innochecksum：
.ibdinnochecksum ./data/test/t*.ibd对目录中的所有表空间文件（files ）
运行innochecksum：
.ibddatainnochecksum ./data/*/*.ibd
笔记
Windows 操作系统不支持在多个用户定义的表空间文件上
运行innochecksum ，因为cmd.exe等 Windows shell不支持 glob 模式扩展。在 Windows 系统上，
必须为每个用户定义的表空间文件单独运行innochecksum 。例如：
innochecksum.exe t1.ibd
innochecksum.exe t2.ibd
innochecksum.exe t3.ibd
在多个系统表空间文件上运行 innochecksum
默认情况下，只有一个InnoDB系统表空间文件 ( ibdata1)，但可以使用该
innodb_data_file_path选项为系统表空间定义多个文件。在以下示例中，系统表空间的三个文件使用
innodb_data_file_path选项定义：
ibdata1、ibdata2和
ibdata3。
./bin/mysqld --no-defaults --innodb-data-file-path="ibdata1:10M;ibdata2:10M;ibdata3:10M:autoextend"
这三个文件（ibdata1、
ibdata2和ibdata3）形成一个逻辑系统表空间。要在形成一个逻辑系统表空间的多个文件上运行
innochecksum ， innochecksum
需要-从标准输入读取表空间文件的选项，这相当于连接多个文件以创建一个文件。对于上面提供的示例，将使用以下
innochecksum命令：
cat ibdata* | innochecksum -有关“ - ”选项的更多信息，
请参阅innochecksum选项信息。
笔记
Windows 操作系统不支持对同一表空间中的多个文件
运行innochecksum ，因为cmd.exe等 Windows shell
不支持 glob 模式扩展。在 Windows 系统上，
必须为每个系统表空间文件单独运行innochecksum 。例如：
innochecksum.exe ibdata1
innochecksum.exe ibdata2
innochecksum.exe ibdata3
© Mysql 中文网
