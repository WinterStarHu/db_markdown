# 6.7.6 SELinux 故障排除_MySQL 8.0 参考手册

6.7.6 SELinux 故障排除_MySQL 8.0 参考手册
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
6.7.6 SELinux 故障排除
6.7.6 SELinux 故障排除
SELinux 故障排除通常包括将 SELinux 置于许可模式、重新运行有问题的操作、检查 SELinux 审计日志中的访问拒绝消息，以及在问题解决后将 SELinux 置于强制模式。
为避免使用setenforce
将整个系统置于许可模式
，您可以使用semanage命令
将其 SELinux 域 ( mysqld_t) 置于许可模式
，从而仅允许 MySQL 服务以许可模式运行：semanage permissive -a mysqld_t
完成故障排除后，使用此命令将mysqld_t域重新置于强制模式：
semanage permissive -d mysqld_t
SELinux 将拒绝操作的日志写入
/var/log/audit/audit.log. 您可以通过搜索“被拒绝”消息来检查是否被拒绝。
grep "denied" /var/log/audit/audit.log
以下部分描述了一些可能会遇到 SELinux 相关问题的常见区域。
文件上下文
如果 MySQL 目录或文件的 SELinux 上下文不正确，访问可能会被拒绝。如果 MySQL 配置为读取或写入非默认目录或文件，则会发生此问题。例如，如果您将 MySQL 配置为使用非默认数据目录，则该目录可能没有预期的 SELinux 上下文。
尝试在具有无效 SELinux 上下文的非默认数据目录上启动 MySQL 服务会导致以下启动失败。
$> systemctl start mysql.service
Job for mysqld.service failed because the control process exited with error code.
See "systemctl status mysqld.service" and "journalctl -xe" for details.
在这种情况下，“拒绝”消息将记录到
/var/log/audit/audit.log：
$> grep "denied" /var/log/audit/audit.log
type=AVC msg=audit(1587133719.786:194): avc:  denied  { write } for  pid=7133 comm="mysqld"
name="mysql" dev="dm-0" ino=51347078 scontext=system_u:system_r:mysqld_t:s0
tcontext=unconfined_u:object_r:default_t:s0 tclass=dir permissive=0
有关为 MySQL 目录和文件设置正确的 SELinux 上下文的信息，请参阅
第 6.7.4 节，“SELinux 文件上下文”。
端口访问
SELinux 期望诸如 MySQL 服务器之类的服务使用特定的端口。更改端口而不更新 SELinux 策略可能会导致服务失败。
mysqld_port_t端口类型定义了 MySQL 监听的端口
。如果您将 MySQL 服务器配置为使用非默认端口，例如端口 3307，并且不更新策略以反映更改，则 MySQL 服务无法启动：
$> systemctl start mysqld.service
Job for mysqld.service failed because the control process exited with error code.
See "systemctl status mysqld.service" and "journalctl -xe" for details.
在这种情况下，拒绝消息将记录到
/var/log/audit/audit.log：
$> grep "denied" /var/log/audit/audit.log
type=AVC msg=audit(1587134375.845:198): avc:  denied  { name_bind } for  pid=7340
comm="mysqld" src=3307 scontext=system_u:system_r:mysqld_t:s0
tcontext=system_u:object_r:unreserved_port_t:s0 tclass=tcp_socket permissive=0
有关为 MySQL 设置正确的 SELinux 端口上下文的信息，请参阅第 6.7.5 节，“SELinux TCP 端口上下文”。当启用使用未在所需上下文中定义的端口的 MySQL 功能时，可能会出现类似的端口访问问题。有关详细信息，请参阅
第 6.7.5.2 节，“为 MySQL 功能设置 TCP 端口上下文”。
申请变更
SELinux 可能不知道应用程序的更改。例如，新版本、应用程序扩展或新功能可能会以 SELinux 不允许的方式访问系统资源，从而导致访问被拒绝。在这种情况下，您可以使用audit2allow实用程序创建自定义策略以在需要时允许访问。创建自定义策略的典型方法是将 SELinux 模式更改为宽松模式，在 SELinux 审计日志中识别访问拒绝消息，并使用audit2allow
实用程序创建自定义策略以允许访问。
有关使用audit2allow
实用程序的信息，请参阅您的发行版的 SELinux 文档。
如果您遇到您认为应该由标准 MySQL SELinux 策略模块处理的 MySQL 访问问题，请在您的发行版的错误跟踪系统中打开错误报告。
© Mysql 中文网
