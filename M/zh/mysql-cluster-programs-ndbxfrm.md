# 23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件_MySQL 8.0 参考手册

23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件_MySQL 8.0 参考手册
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
23.1 一般信息
23.2 NDB Cluster 概述
23.3 NDB Cluster 安装
23.4 NDB Cluster的配置
23.5 NDB 集群程序
23.5.1 ndbd — NDB Cluster 数据节点守护进程1
23.5.2 ndbinfo_select_all — 从 ndbinfo 表中选择1
23.5.3 ndbmtd — NDB Cluster 数据节点守护进程（多线程）1
23.5.4 ndb_mgmd — NDB 集群管理服务器守护进程1
23.5.5 ndb_mgm — NDB 集群管理客户端1
23.5.6 ndb_blob_tool — 检查和修复 NDB 集群表的 BLOB 和 TEXT 列1
23.5.7 ndb_config — 提取 NDB Cluster 配置信息1
23.5.8 ndb_delete_all — 从 NDB 表中删除所有行1
23.5.9 ndb_desc — 描述 NDB 表1
23.5.10 ndb_drop_index — 从 NDB 表中删除索引1
23.5.11 ndb_drop_table — 删除 NDB 表1
23.5.12 ndb_error_reporter — NDB 错误报告实用程序1
23.5.13 ndb_import — 将 CSV 数据导入 NDB1
23.5.14 ndb_index_stat — NDB 索引统计实用程序1
23.5.15 ndb_move_data — NDB 数据复制实用程序1
23.5.16 ndb_perror — 获取 NDB 错误消息信息1
23.5.17 ndb_print_backup_file — 打印 NDB 备份文件内容1
23.5.18 ndb_print_file — 打印 NDB 磁盘数据文件内容1
23.5.19 ndb_print_frag_file — 打印 NDB 片段列表文件内容1
23.5.20 ndb_print_schema_file — 打印 NDB 模式文件内容1
23.5.21 ndb_print_sys_file — 打印 NDB 系统文件内容1
23.5.22 ndb_redo_log_reader - 检查和打印集群重做日志的内容1
23.5.23 ndb_restore — 恢复 NDB Cluster 备份1
23.5.24 ndb_secretsfile_reader — 从加密的 NDB 数据文件中获取密钥信息1
23.5.25 ndb_select_all — 从 NDB 表打印行1
23.5.26 ndb_select_count — 打印 NDB 表的行数1
23.5.27 ndb_show_tables — 显示 NDB 表列表1
23.5.28 ndb_size.pl — NDBCLUSTER 大小需求估计器1
23.5.29 ndb_top — 查看 NDB 线程的 CPU 使用信息1
23.5.30 ndb_waiter — 等待 NDB Cluster 达到给定状态1
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件1
23.6 NDB Cluster的管理
23.7 NDB 集群复制
23.8 NDB Cluster 发行说明
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
MySQL 8.0 参考手册  / 第 23 章 MySQL NDB Cluster 8.0  / 23.5 NDB 集群程序  /
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件
23.5.31 ndbxfrm — 压缩、解压缩、加密和解密 NDB Cluster 创建的文件
NDB 8.0.22 中引入的ndbxfrm实用程序可用于解压缩、解密和输出有关 NDB Cluster 创建的压缩、加密或两者的文件的信息。它还可以用于压缩或加密文件。
表 23.52 与程序 ndbxfrm 一起使用的命令行选项
格式
描述
添加、弃用或删除
--compress,
-c
压缩文件
添加：NDB 8.0.22
--decrypt-key=key
提供文件解密密钥
添加：NDB 8.0.31
--decrypt-key-from-stdin
从 stdin 提供文件解密密钥
添加：NDB 8.0.31
--decrypt-password=password
使用此密码解密文件
添加：NDB 8.0.22
--decrypt-password-from-stdin
从 STDIN 以安全的方式获取解密密码
添加：NDB 8.0.24
--defaults-extra-file=path
读取全局文件后读取给定文件
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-group-suffix=string
还阅读带有 concat(group, suffix) 的组
（支持所有基于 MySQL 8.0 的 NDB 版本）
--defaults-file=path
仅从给定文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--encrypt-block-size=#
打印有关文件的信息，包括文件头和文件尾
添加：NDB 8.0.31
--encrypt-block-size=#
作为一个单元加密的输入数据块的大小。与 XTS 一起使用，对于 CBC 模式设置为零
添加：NDB 8.0.29
--encrypt-cipher=#
加密密码：1个用于CBC，2个用于XTS
添加：NDB 8.0.29
--encrypt-kdf-iter-count=#,
-k
#
键定义中使用的迭代次数
添加：NDB 8.0.22
--encrypt-key=key
使用此密钥加密文件
添加：NDB 8.0.31
--encrypt-key-from-stdin
使用标准输入提供的密钥加密文件
添加：NDB 8.0.31
--encrypt-password=password
使用此密码加密文件
添加：NDB 8.0.22
--encrypt-password-from-stdin
从 STDIN 以安全方式获取加密密码
添加：NDB 8.0.24
--help,
-?
打印使用信息
添加：NDB 8.0.22
--info,
-i
打印文件信息
添加：NDB 8.0.22
--login-path=path
从登录文件中读取给定路径
（支持所有基于 MySQL 8.0 的 NDB 版本）
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项
（支持所有基于 MySQL 8.0 的 NDB 版本）
--print-defaults
打印程序参数列表并退出
（支持所有基于 MySQL 8.0 的 NDB 版本）
--usage,
-?
打印使用信息；--help 的同义词
添加：NDB 8.0.22
--version,
-V
输出版本信息
添加：NDB 8.0.22
用法
ndbxfrm --info file[ file ...]
ndbxfrm --compress input_file output_file
ndbxfrm --decrypt-password=password input_file output_file
ndbxfrm [--encrypt-ldf-iter-count=#] --encrypt-password=password input_file output_file
input_file并且
output_file不能是同一个文件。
选项
--compress,
-c
命令行格式
--compress
介绍
8.0.22-ndb-8.0.22
使用与压缩 NDB Cluster 备份相同的压缩方法压缩输入文件，并将输出写入输出文件。要解压缩
NDB未加密的压缩备份文件，只需使用压缩文件的名称和输出文件（无需任何选项）
调用ndbxfrm 。
--decrypt-key=key,
-K key
命令行格式
--decrypt-key=key
介绍
8.0.31-ndb-8.0.31
解密NDB使用提供的密钥加密的文件。
笔记
该选项不能与 一起使用
--decrypt-password。
--decrypt-key-from-stdin
命令行格式
--decrypt-key-from-stdin
介绍
8.0.31-ndb-8.0.31
解密NDB使用从提供的密钥加密的文件stdin。
--decrypt-password=password
命令行格式
--decrypt-password=password
介绍
8.0.22-ndb-8.0.22
类型
细绳
默认值
[none]
解密NDB使用提供的密码加密的文件。
笔记
该选项不能与 一起使用
--decrypt-key。
--decrypt-password-from-stdin[=TRUE|FALSE]
命令行格式
--decrypt-password-from-stdin
介绍
8.0.24-ndb-8.0.24
NDB使用标准输入提供的密码
解密由 加密的文件。这类似于在选项后面没有密码的情况下
调用mysql后输入密码。
--password
--defaults-extra-file
命令行格式
--defaults-extra-file=path
类型
细绳
默认值
[none]
读取全局文件后读取给定文件。
--defaults-file
命令行格式
--defaults-file=path
类型
细绳
默认值
[none]
仅从给定文件中读取默认选项。
--defaults-group-suffix
命令行格式
--defaults-group-suffix=string
类型
细绳
默认值
[none]
还可以阅读 groups with
。
CONCAT(group,
suffix)
--detailed-info
命令行格式
--encrypt-block-size=#
介绍
8.0.31-ndb-8.0.31
类型
布尔值
默认值
FALSE
打印出文件信息，如
--info，但包括文件的头和尾。
例子：
$> ndbxfrm --detailed-info S0.sysfile
File=/var/lib/cluster-data/ndb_7_fs/D1/NDBCNTR/S0.sysfile, compression=no, encryption=yes
header: {
fixed_header: {
magic: {
magic: { 78, 68, 66, 88, 70, 82, 77, 49 },
endian: 18364758544493064720,
header_size: 32768,
fixed_header_size: 160,
zeros: { 0, 0 }
},
flags: 73728,
flag_extended: 0,
flag_zeros: 0,
flag_file_checksum: 0,
flag_data_checksum: 0,
flag_compress: 0,
flag_compress_method: 0,
flag_compress_padding: 0,
flag_encrypt: 18,
flag_encrypt_cipher: 2,
flag_encrypt_krm: 1,
flag_encrypt_padding: 0,
flag_encrypt_key_selection_mode: 0,
dbg_writer_ndb_version: 524320,
octets_size: 32,
file_block_size: 32768,
trailer_max_size: 80,
file_checksum: { 0, 0, 0, 0 },
data_checksum: { 0, 0, 0, 0 },
zeros01: { 0 },
compress_dbg_writer_header_version: { ... },
compress_dbg_writer_library_version: { ... },
encrypt_dbg_writer_header_version: { ... },
encrypt_dbg_writer_library_version: { ... },
encrypt_key_definition_iterator_count: 100000,
encrypt_krm_keying_material_size: 32,
encrypt_krm_keying_material_count: 1,
encrypt_key_data_unit_size: 32768,
encrypt_krm_keying_material_position_in_octets: 0,
},
octets: {
102, 68, 56, 125, 78, 217, 110, 94, 145, 121, 203, 234, 26, 164, 137, 180,
100, 224, 7, 88, 173, 123, 209, 110, 185, 227, 85, 174, 109, 123, 96, 156,
}
}
trailer: {
fixed_trailer: {
flags: 48,
flag_extended: 0,
flag_zeros: 0,
flag_file_checksum: 0,
flag_data_checksum: 3,
data_size: 512,
file_checksum: { 0, 0, 0, 0 },
data_checksum: { 226, 223, 102, 207 },
magic: {
zeros: { 0, 0 }
fixed_trailer_size: 56,
trailer_size: 32256,
endian: 18364758544493064720,
magic: { 78, 68, 66, 88, 70, 82, 77, 49 },
},
}
}
--encrypt-block-size=#
命令行格式
--encrypt-block-size=#
介绍
8.0.29-ndb-8.0.29
类型
整数
默认值
0
最小值
0
最大值
2147483647
作为一个单元加密的输入数据块的大小。与 XTS 一起使用；0对于 CBC 模式
设置为（默认值）。
--encrypt-cipher=#
命令行格式
--encrypt-cipher=#
介绍
8.0.29-ndb-8.0.29
类型
整数
默认值
1
最小值
0
最大值
2147483647
用于加密的密码。设置1为 CBC 模式（默认）或2XTS。
--encrypt-kdf-iter-count=#,
-k #
命令行格式
--encrypt-kdf-iter-count=#
介绍
8.0.22-ndb-8.0.22
类型
整数
默认值
0
最小值
0
最大值
2147483647
加密文件时，指定用于加密密钥的迭代次数。需要
--encrypt-password选项。
--encrypt-key=key
命令行格式
--encrypt-key=key
介绍
8.0.31-ndb-8.0.31
使用提供的密钥加密文件。
笔记
该选项不能与 一起使用
--encrypt-password。
--encrypt-key-from-stdin
命令行格式
--encrypt-key-from-stdin
介绍
8.0.31-ndb-8.0.31
使用 提供的密钥加密文件
stdin。
--encrypt-password=password
命令行格式
--encrypt-password=password
介绍
8.0.22-ndb-8.0.22
类型
细绳
默认值
[none]
使用选项提供的密码加密备份文件。密码必须满足此处列出的要求：
使用任何可打印的 ASCII 字符，除了
!, ',
", $,
%, \,
`, 和^
长度不超过 256 个字符
被单引号或双引号括起来
笔记
该选项不能与 一起使用
--encrypt-key。
--encrypt-password-from-stdin[=TRUE|FALSE]
命令行格式
--encrypt-password-from-stdin
介绍
8.0.24-ndb-8.0.24
使用标准输入提供的密码加密文件。这类似于在选项后面没有密码的
情况下调用mysql
后输入密码。--password
--help,-?
命令行格式
--help
介绍
8.0.22-ndb-8.0.22
打印程序的使用信息。
--info,-i
命令行格式
--info
介绍
8.0.22-ndb-8.0.22
打印有关一个或多个输入文件的以下信息：
文件名
文件是否压缩 (compression=yes或
compression=no)
文件是否加密（encryption=yes或
encryption=no）
例子：
$> ndbxfrm -i BACKUP-10-0.5.Data BACKUP-10.5.ctl BACKUP-10.5.log
File=BACKUP-10-0.5.Data, compression=no, encryption=yes
File=BACKUP-10.5.ctl, compression=no, encryption=yes
File=BACKUP-10.5.log, compression=no, encryption=yes
从 NDB 8.0.31 开始，您还可以使用该
--detailed-info选项查看文件的头和尾。
--login-path
命令行格式
--login-path=path
类型
细绳
默认值
[none]
从登录文件中读取给定路径。
--no-defaults
命令行格式
--no-defaults
不要从登录文件以外的任何选项文件中读取默认选项。
--print-defaults
命令行格式
--print-defaults
打印程序参数列表并退出。
--usage,-?
命令行格式
--usage
介绍
8.0.22-ndb-8.0.22
的同义词--help。
--version,
-V
命令行格式
--version
介绍
8.0.22-ndb-8.0.22
打印出版本信息。
ndbxfrm可以加密由任何版本的 NDB Cluster 创建的备份。组成备份的.Data、
.ctl和.log文件必须单独加密，并且这些文件必须为每个数据节点单独加密。一旦加密，此类备份只能由
NDB Cluster 8.0.22 或更高版本
的ndbxfrm、 ndb_restore或
ndb_print_backup解密。--encrypt-password可以使用和
--decrypt-password选项一起
使用新密码重新加密加密文件，如下所示：ndbxfrm --decrypt-password=old --encrypt-password=new input_file output_file
在刚刚显示的示例中，old和
new分别是旧密码和新密码；这两个都必须引用。输入文件被解密，然后加密为输出文件。输入文件本身没有改变；如果您不想使用旧密码访问它，则必须手动删除输入文件。
© Mysql 中文网
