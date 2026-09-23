# 1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项_MySQL 8.0 参考手册

1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项_MySQL 8.0 参考手册
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
1.1 关于本手册
1.2 MySQL数据库管理系统概述
1.3 MySQL 8.0 的新特性
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
1.5 MySQL信息源
1.6 如何报告错误或问题
1.7 MySQL 标准合规性
1.8 学分
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
MySQL 8.0 参考手册  / 第一章 一般信息  /
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
1.4 MySQL 8.0 中添加、弃用或删除的服务器和状态变量和选项
MySQL 8.0 中引入的选项和变量MySQL 8.0 中弃用的选项和变量MySQL 8.0 中删除的选项和变量
本节列出了 MySQL 8.0 中首次添加、已弃用或已删除的服务器变量、状态变量和选项。
MySQL 8.0 中引入的选项和变量
MySQL 8.0 中添加了以下系统变量、状态变量和服务器选项。
Acl_cache_items_count：缓存的特权对象数。在 MySQL 8.0.0 中添加。
Audit_log_current_size: 审核日志文件的当前大小。在 MySQL 8.0.11 中添加。
Audit_log_event_max_drop_size：最大的丢弃审计事件的大小。在 MySQL 8.0.11 中添加。
Audit_log_events：已处理的审计事件数。在 MySQL 8.0.11 中添加。
Audit_log_events_filtered：筛选的审计事件数。在 MySQL 8.0.11 中添加。
Audit_log_events_lost：丢弃的审计事件数。在 MySQL 8.0.11 中添加。
Audit_log_events_written：书面审计事件的数量。在 MySQL 8.0.11 中添加。
Audit_log_total_size：书面审计事件的总规模。在 MySQL 8.0.11 中添加。
Audit_log_write_waits：写入延迟的审计事件数。在 MySQL 8.0.11 中添加。
Authentication_ldap_sasl_supported_methods：支持 SASL LDAP 身份验证的身份验证方法。在 MySQL 8.0.21 中添加。
Caching_sha2_password_rsa_public_key: caching_sha2_password 认证插件 RSA 公钥值。在 MySQL 8.0.4 中添加。
Com_alter_resource_group：ALTER RESOURCE GROUP 语句的计数。在 MySQL 8.0.3 中添加。
Com_alter_user_default_role: ALTER USER ... DEFAULT ROLE 语句的计数。在 MySQL 8.0.0 中添加。
Com_change_replication_source：CHANGE REPLICATION SOURCE TO 和 CHANGE MASTER TO 语句的计数。在 MySQL 8.0.23 中添加。
Com_clone：CLONE 语句的计数。在 MySQL 8.0.2 中添加。
Com_create_resource_group: CREATE RESOURCE GROUP 语句的计数。在 MySQL 8.0.3 中添加。
Com_create_role: CREATE ROLE 语句的计数。在 MySQL 8.0.0 中添加。
Com_drop_resource_group：DROP RESOURCE GROUP 语句的计数。在 MySQL 8.0.3 中添加。
Com_drop_role：DROP ROLE 语句的计数。在 MySQL 8.0.0 中添加。
Com_grant_roles：GRANT ROLE 语句的计数。在 MySQL 8.0.0 中添加。
Com_install_component：INSTALL COMPONENT 语句的计数。在 MySQL 8.0.0 中添加。
Com_replica_start：START REPLICA 和 START SLAVE 语句的计数。在 MySQL 8.0.22 中添加。
Com_replica_stop：STOP REPLICA 和 STOP SLAVE 语句的计数。在 MySQL 8.0.22 中添加。
Com_restart：RESTART 语句的计数。在 MySQL 8.0.4 中添加。
Com_revoke_roles：REVOKE ROLES 语句的计数。在 MySQL 8.0.0 中添加。
Com_set_resource_group：SET RESOURCE GROUP 语句的计数。在 MySQL 8.0.3 中添加。
Com_set_role：SET ROLE 语句的计数。在 MySQL 8.0.0 中添加。
Com_show_replica_status：SHOW REPLICA STATUS 和 SHOW SLAVE STATUS 语句的计数。在 MySQL 8.0.22 中添加。
Com_show_replicas：SHOW REPLICAS 和 SHOW SLAVE HOSTS 语句的计数。在 MySQL 8.0.22 中添加。
Com_uninstall_component：UINSTALL COMPONENT 语句的计数。在 MySQL 8.0.0 中添加。
Compression_algorithm: 当前连接的压缩算法。在 MySQL 8.0.18 中添加。
Compression_level：当前连接的压缩级别。在 MySQL 8.0.18 中添加。
Connection_control_delay_generated：服务器延迟连接请求的次数。在 MySQL 8.0.1 中添加。
Current_tls_ca: ssl_ca 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_capath: ssl_capath 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_cert: ssl_cert 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_cipher: ssl_cipher 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_ciphersuites：tsl_ciphersuites 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_crl: ssl_crl 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_crlpath: ssl_crlpath 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_key: ssl_key 系统变量的当前值。在 MySQL 8.0.16 中添加。
Current_tls_version：tls_version 系统变量的当前值。在 MySQL 8.0.16 中添加。
Error_log_buffered_bytes：error_log 表中使用的字节数。在 MySQL 8.0.22 中添加。
Error_log_buffered_events：error_log 表中的事件数。在 MySQL 8.0.22 中添加。
Error_log_expired_events：从 error_log 表中丢弃的事件数。在 MySQL 8.0.22 中添加。
Error_log_latest_write：上次写入 error_log 表的时间。在 MySQL 8.0.22 中添加。
Firewall_access_denied：被 MySQL Enterprise Firewall 拒绝的语句数。在 MySQL 8.0.11 中添加。
Firewall_access_granted：MySQL Enterprise Firewall 接受的语句数。在 MySQL 8.0.11 中添加。
Firewall_cached_entries：MySQL Enterprise Firewall 记录的语句数。在 MySQL 8.0.11 中添加。
Global_connection_memory：所有用户线程当前使用的内存量。在 MySQL 8.0.28 中添加。
Innodb_buffer_pool_resize_status_code：InnoDB 缓冲池调整大小状态代码。在 MySQL 8.0.31 中添加。
Innodb_buffer_pool_resize_status_progress：InnoDB 缓冲池调整大小状态进度。在 MySQL 8.0.31 中添加。
Innodb_redo_log_capacity_resized：在上次完成容量调整大小操作后重做日志容量。在 MySQL 8.0.30 中添加。
Innodb_redo_log_checkpoint_lsn：重做日志检查点LSN。在 MySQL 8.0.30 中添加。
Innodb_redo_log_current_lsn：重做日志的当前LSN。在 MySQL 8.0.30 中添加。
Innodb_redo_log_enabled: InnoDB 重做日志状态。在 MySQL 8.0.21 中添加。
Innodb_redo_log_flushed_to_disk_lsn: 红色日志flushed-to-disk LSN。在 MySQL 8.0.30 中添加。
Innodb_redo_log_logical_size：重做日志逻辑大小。在 MySQL 8.0.30 中添加。
Innodb_redo_log_physical_size：重做日志的物理大小。在 MySQL 8.0.30 中添加。
Innodb_redo_log_read_only: 重做日志是否只读。在 MySQL 8.0.30 中添加。
Innodb_redo_log_resize_status：重做日志调整状态。在 MySQL 8.0.30 中添加。
Innodb_redo_log_uuid: 重做日志 UUID。在 MySQL 8.0.30 中添加。
Innodb_system_rows_deleted：从系统架构表中删除的行数。在 MySQL 8.0.19 中添加。
Innodb_system_rows_inserted：插入系统模式表的行数。在 MySQL 8.0.19 中添加。
Innodb_system_rows_read：从系统架构表中读取的行数。在 MySQL 8.0.19 中添加。
Innodb_undo_tablespaces_active：活动撤消表空间的数量。在 MySQL 8.0.14 中添加。
Innodb_undo_tablespaces_explicit：用户创建的撤消表空间数。在 MySQL 8.0.14 中添加。
Innodb_undo_tablespaces_implicit：InnoDB 创建的撤消表空间数。在 MySQL 8.0.14 中添加。
Innodb_undo_tablespaces_total: 撤消表空间总数。在 MySQL 8.0.14 中添加。
Mysqlx_bytes_received_compressed_payload：作为压缩消息有效负载接收的字节数，在解压缩之前测量。在 MySQL 8.0.19 中添加。
Mysqlx_bytes_received_uncompressed_frame：作为压缩消息有效负载接收的字节数，在解压缩后测量。在 MySQL 8.0.19 中添加。
Mysqlx_bytes_sent_compressed_payload：作为压缩消息有效负载发送的字节数，在压缩后测量。在 MySQL 8.0.19 中添加。
Mysqlx_bytes_sent_uncompressed_frame：作为压缩消息有效负载发送的字节数，在压缩前测量。在 MySQL 8.0.19 中添加。
Mysqlx_compression_algorithm: 用于此会话的 X 协议连接的压缩算法。在 MySQL 8.0.20 中添加。
Mysqlx_compression_level: 用于此会话的 X 协议连接的压缩级别。在 MySQL 8.0.20 中添加。
Replica_open_temp_tables：复制 SQL 线程当前已打开的临时表数。在 MySQL 8.0.26 中添加。
Replica_rows_last_search_algorithm_used：此副本最近使用的搜索算法来定位基于行的复制（索引、表或散列扫描）的行。在 MySQL 8.0.26 中添加。
Resource_group_supported: 服务器是否支持资源组功能。在 MySQL 8.0.31 中添加。
Rpl_semi_sync_replica_status：半同步复制是否在副本上运行。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_clients：半同步副本的数量。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_net_avg_wait_time：源等待副本回复的平均时间。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_net_wait_time：源等待副本回复的总时间。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_net_waits：源等待副本回复的总次数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_no_times：源关闭半同步复制的次数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_no_tx：未成功确认的提交数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_status：半同步复制是否在源上运行。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_timefunc_failures：调用时间函数时源失败的次数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_tx_avg_wait_time：源等待每个事务的平均时间。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_tx_wait_time：源等待事务的总时间。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_tx_waits：源等待事务的总次数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_wait_pos_backtraverse：源等待二进制坐标低于先前等待事件的事件的总次数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_wait_sessions：当前等待副本回复的会话数。在 MySQL 8.0.26 中添加。
Rpl_semi_sync_source_yes_tx：成功确认的提交数。在 MySQL 8.0.26 中添加。
Secondary_engine_execution_count：卸载到辅助引擎的查询数。在 MySQL 8.0.13 中添加。
Ssl_session_cache_timeout：缓存中的当前 SSL 会话超时值。在 MySQL 8.0.29 中添加。
Tls_library_version：正在使用的 OpenSSL 库的运行时版本。在 MySQL 8.0.30 中添加。
activate_all_roles_on_login：是否在连接时激活所有用户角色。在 MySQL 8.0.2 中添加。
admin-ssl：启用连接加密。在 MySQL 8.0.21 中添加。
admin_address：要绑定到管理界面上的连接的 IP 地址。在 MySQL 8.0.14 中添加。
admin_port: 用于管理界面连接的 TCP/IP 编号。在 MySQL 8.0.14 中添加。
admin_ssl_ca：包含受信任的 SSL 证书颁发机构列表的文件。在 MySQL 8.0.21 中添加。
admin_ssl_capath：包含受信任的 SSL 证书颁发机构证书文件的目录。在 MySQL 8.0.21 中添加。
admin_ssl_cert：包含 X.509 证书的文件。在 MySQL 8.0.21 中添加。
admin_ssl_cipher：用于连接加密的允许密码。在 MySQL 8.0.21 中添加。
admin_ssl_crl：包含证书吊销列表的文件。在 MySQL 8.0.21 中添加。
admin_ssl_crlpath：包含证书吊销列表文件的目录。在 MySQL 8.0.21 中添加。
admin_ssl_key：包含 X.509 密钥的文件。在 MySQL 8.0.21 中添加。
admin_tls_ciphersuites：用于加密连接的允许的 TLSv1.3 密码套件。在 MySQL 8.0.21 中添加。
admin_tls_version：用于加密连接的允许的 TLS 协议。在 MySQL 8.0.21 中添加。
audit-log: 是否激活审计日志插件。在 MySQL 8.0.11 中添加。
audit_log_buffer_size：审计日志缓冲区的大小。在 MySQL 8.0.11 中添加。
audit_log_compression：审计日志文件的压缩方式。在 MySQL 8.0.11 中添加。
audit_log_connection_policy：审核连接相关事件的日志记录策略。在 MySQL 8.0.11 中添加。
audit_log_current_session: 是否审计当前会话。在 MySQL 8.0.11 中添加。
audit_log_disable：禁用审计日志。在 MySQL 8.0.28 中添加。
audit_log_encryption: 审计日志文件的加密方法。在 MySQL 8.0.11 中添加。
audit_log_exclude_accounts: 账目不审计。在 MySQL 8.0.11 中添加。
audit_log_file：审计日志文件的名称。在 MySQL 8.0.11 中添加。
audit_log_filter_id: 当前审计日志过滤器的 ID。在 MySQL 8.0.11 中添加。
audit_log_flush：关闭并重新打开审计日志文件。在 MySQL 8.0.11 中添加。
audit_log_format: 审计日志文件格式。在 MySQL 8.0.11 中添加。
audit_log_format_unix_timestamp: 是否在 JSON 格式的审计日志中包含 Unix 时间戳。在 MySQL 8.0.26 中添加。
audit_log_include_accounts: 要审计的帐户。在 MySQL 8.0.11 中添加。
audit_log_max_size：限制 JSON 审计日志文件的组合大小。在 MySQL 8.0.26 中添加。
audit_log_password_history_keep_days：保留存档审核日志加密密码的天数。在 MySQL 8.0.17 中添加。
audit_log_policy：审核日志记录策略。在 MySQL 8.0.11 中添加。
audit_log_prune_seconds：审核日志文件开始修剪之前的秒数。在 MySQL 8.0.24 中添加。
audit_log_read_buffer_size：审核日志文件读取缓冲区大小。在 MySQL 8.0.11 中添加。
audit_log_rotate_on_size：关闭并重新打开此大小的审计日志文件。在 MySQL 8.0.11 中添加。
audit_log_statement_policy：审核语句相关事件的日志记录策略。在 MySQL 8.0.11 中添加。
audit_log_strategy：审核日志记录策略。在 MySQL 8.0.11 中添加。
authentication_fido_rp_id：FIDO 多因素身份验证的依赖方 ID。在 MySQL 8.0.27 中添加。
authentication_kerberos_service_key_tab：包含用于验证 TGS 票证的 Kerberos 服务密钥的文件。在 MySQL 8.0.26 中添加。
authentication_kerberos_service_principal：Kerberos 服务主体名称。在 MySQL 8.0.26 中添加。
authentication_ldap_sasl_auth_method_name: 认证方法名称。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_bind_base_dn: LDAP 服务器基础专有名称。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_bind_root_dn：LDAP 服务器根专有名称。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_bind_root_pwd: LDAP 服务器根绑定密码。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_ca_path: LDAP 服务器证书颁发机构文件名。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_group_search_attr：LDAP 服务器组搜索属性。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_group_search_filter：LDAP 自定义组搜索过滤器。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_init_pool_size: LDAP 服务器初始连接池大小。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_log_status: LDAP 服务器日志级别。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_max_pool_size: LDAP 服务器最大连接池大小。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_referral: 是否启用 LDAP 搜索引用。在 MySQL 8.0.20 中添加。
authentication_ldap_sasl_server_host：LDAP 服务器主机名或 IP 地址。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_server_port：LDAP 服务器端口号。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_tls: 是否使用加密连接到 LDAP 服务器。在 MySQL 8.0.11 中添加。
authentication_ldap_sasl_user_search_attr: LDAP 服务器用户搜索属性。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_auth_method_name: 认证方法名称。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_bind_base_dn: LDAP 服务器基础专有名称。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_bind_root_dn：LDAP 服务器根专有名称。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_bind_root_pwd: LDAP 服务器根绑定密码。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_ca_path: LDAP 服务器证书颁发机构文件名。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_group_search_attr：LDAP 服务器组搜索属性。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_group_search_filter：LDAP 自定义组搜索过滤器。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_init_pool_size: LDAP 服务器初始连接池大小。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_log_status: LDAP 服务器日志级别。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_max_pool_size: LDAP 服务器最大连接池大小。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_referral: 是否启用 LDAP 搜索引用。在 MySQL 8.0.20 中添加。
authentication_ldap_simple_server_host：LDAP 服务器主机名或 IP 地址。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_server_port：LDAP 服务器端口号。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_tls: 是否使用加密连接到 LDAP 服务器。在 MySQL 8.0.11 中添加。
authentication_ldap_simple_user_search_attr: LDAP 服务器用户搜索属性。在 MySQL 8.0.11 中添加。
authentication_policy: 用于多因素身份验证的插件。在 MySQL 8.0.27 中添加。
authentication_windows_log_level: Windows 身份验证插件日志记录级别。在 MySQL 8.0.11 中添加。
authentication_windows_use_principal_name: 是否使用 Windows 身份验证插件主体名称。在 MySQL 8.0.11 中添加。
binlog_encryption: 在此服务器上启用二进制日志文件和中继日志文件的加密。在 MySQL 8.0.14 中添加。
binlog_expire_logs_auto_purge：控制二进制日志文件的自动清除；启用时可以通过将 binlog_expire_logs_seconds 和 expire_logs_days 设置为 0 来覆盖。在 MySQL 8.0.29 中添加。
binlog_expire_logs_seconds：这么多秒后清除二进制日志。在 MySQL 8.0.1 中添加。
binlog_rotate_encryption_master_key_at_startup：在服务器启动时轮换二进制日志主密钥。在 MySQL 8.0.14 中添加。
binlog_row_metadata：使用基于行的日志记录时，是否将所有或仅最小表相关元数据记录到二进制日志。在 MySQL 8.0.1 中添加。
binlog_row_value_options：为基于行的复制启用部分 JSON 更新的二进制日志记录。在 MySQL 8.0.3 中添加。
binlog_transaction_compression：为二进制日志文件中的事务负载启用压缩。在 MySQL 8.0.20 中添加。
binlog_transaction_compression_level_zstd：二进制日志文件中事务负载的压缩级别。在 MySQL 8.0.20 中添加。
binlog_transaction_dependency_history_size：为查找最后更新某行的事务而保留的行哈希数。在 MySQL 8.0.1 中添加。
binlog_transaction_dependency_tracking：依赖信息的来源（提交时间戳或事务写入集），从中可以评估哪些事务可以由副本的多线程应用程序并行执行。在 MySQL 8.0.1 中添加。
build_id：编译时生成的唯一构建 ID（仅限 Linux）。在 MySQL 8.0.31 中添加。
caching_sha2_password_auto_generate_rsa_keys: 是否自动生成 RSA 密钥对文件。在 MySQL 8.0.4 中添加。
caching_sha2_password_digest_rounds：caching_sha2_password 身份验证插件的哈希轮数。在 MySQL 8.0.24 中添加。
caching_sha2_password_private_key_path: SHA2 认证插件私钥路径名。在 MySQL 8.0.3 中添加。
caching_sha2_password_public_key_path: SHA2 认证插件公钥路径名。在 MySQL 8.0.3 中添加。
clone_autotune_concurrency：为远程克隆操作启用线程的动态生成。在 MySQL 8.0.17 中添加。
clone_block_ddl：在克隆操作期间启用独占备份锁。在 MySQL 8.0.27 中添加。
clone_buffer_size：定义捐赠者 MySQL 服务器实例上的中间缓冲区的大小。在 MySQL 8.0.17 中添加。
clone_ddl_timeout：克隆操作等待备份锁定的秒数。在 MySQL 8.0.17 中添加。
clone_delay_after_data_drop：克隆进程开始前的时间延迟（以秒为单位）。在 MySQL 8.0.29 中添加。
clone_donor_timeout_after_network_failure：网络故障后允许重新启动克隆操作的时间。在 MySQL 8.0.24 中添加。
clone_enable_compression：在克隆期间启用网络层数据压缩。在 MySQL 8.0.17 中添加。
clone_max_concurrency：用于执行克隆操作的最大并发线程数。在 MySQL 8.0.17 中添加。
clone_max_data_bandwidth：远程克隆操作的最大数据传输速率（以每秒 MiB 为单位）。在 MySQL 8.0.17 中添加。
clone_max_network_bandwidth：远程克隆操作的最大网络传输速率（以每秒 MiB 为单位）。在 MySQL 8.0.17 中添加。
clone_ssl_ca：指定证书颁发机构 (CA) 文件的路径。在 MySQL 8.0.14 中添加。
clone_ssl_cert: 指定公钥证书文件的路径。在 MySQL 8.0.14 中添加。
clone_ssl_key：指定私钥文件的路径。在 MySQL 8.0.14 中添加。
clone_valid_donor_list：定义用于远程克隆操作的施主主机地址。在 MySQL 8.0.17 中添加。
connection_control_failed_connections_threshold：在出现延迟之前连续尝试连接失败。在 MySQL 8.0.1 中添加。
connection_control_max_connection_delay：服务器响应失败连接尝试的最大延迟（毫秒）。在 MySQL 8.0.1 中添加。
connection_control_min_connection_delay：服务器响应失败连接尝试的最小延迟（毫秒）。在 MySQL 8.0.1 中添加。
connection_memory_chunk_size：仅当用户内存使用量变化了这个数量或更多时才更新 Global_connection_memory；0 禁用更新。在 MySQL 8.0.28 中添加。
connection_memory_limit：在拒绝该用户的其他查询之前，任何一个用户连接可以消耗的最大内存量。不适用于 MySQL root 等系统用户。在 MySQL 8.0.28 中添加。
create_admin_listener_thread：是否在管理界面上使用专用侦听线程进行连接。在 MySQL 8.0.14 中添加。
cte_max_recursion_depth: 公用表表达式最大递归深度。在 MySQL 8.0.3 中添加。
ddl-rewriter: 是否开启ddl_rewriter插件。在 MySQL 8.0.16 中添加。
default_collation_for_utf8mb4：utf8mb4 字符集的默认排序规则；仅供 MySQL 复制内部使用。在 MySQL 8.0.11 中添加。
default_table_encryption：默认架构和表空间加密设置。在 MySQL 8.0.16 中添加。
dragnet.Status：最近分配给 dragnet.log_error_filter_rules 的结果。在 MySQL 8.0.12 中添加。
dragnet.log_error_filter_rules：错误记录的过滤规则。在 MySQL 8.0.4 中添加。
early-plugin-load：在加载强制内置插件之前和存储引擎初始化之前指定要加载的插件。在 MySQL 8.0.0 中添加。
enterprise_encryption.maximum_rsa_key_size：MySQL Enterprise Encryption 生成的 RSA 密钥的最大大小。在 MySQL 8.0.30 中添加。
enterprise_encryption.rsa_support_legacy_padding：解密和验证旧版 MySQL Enterprise Encryption 内容。在 MySQL 8.0.30 中添加。
generated_random_password_length：生成密码的最大长度。在 MySQL 8.0.18 中添加。
global_connection_memory_limit：所有用户连接可以消耗的最大内存总量。当 Global_connection_memory 超过此数量时，来自普通用户的任何新查询都会被拒绝。不适用于 MySQL root 等系统用户。在 MySQL 8.0.28 中添加。
global_connection_memory_tracking：是否计算全局连接内存使用量（如Global_connection_memory所示）；默认是禁用的。在 MySQL 8.0.28 中添加。
group_replication_advertise_recovery_endpoints：为分布式恢复提供的连接。在 MySQL 8.0.21 中添加。
group_replication_autorejoin_tries：成员尝试自动重新加入组的次数。在 MySQL 8.0.16 中添加。
group_replication_clone_threshold：捐赠者和接受者之间的交易数量差距，超过该差距使用远程克隆操作进行状态转移。在 MySQL 8.0.17 中添加。
group_replication_communication_debug_options：组复制组件的调试消息级别。在 MySQL 8.0.3 中添加。
group_replication_communication_max_message_size：组复制通信的最大消息大小，较大的消息被分段。在 MySQL 8.0.16 中添加。
group_replication_communication_stack: 指定是使用XCom通信栈还是MySQL通信栈来建立成员之间的组通信连接。 MySQL 8.0.27新增。
group_replication_consistency: 组提供的交易一致性保证类型。在 MySQL 8.0.14 中添加。
group_replication_exit_state_action: 实例不由自主地离开群体时的行为。在 MySQL 8.0.12 中添加。
group_replication_flow_control_hold_percent：保持未使用状态的组配额百分比。在 MySQL 8.0.2 中添加。
group_replication_flow_control_max_commit_quota: 组的最大流控配额。在 MySQL 8.0.2 中添加。
group_replication_flow_control_member_quota_percent：在计算配额时，成员应该假设自己可以使用的配额百分比。在 MySQL 8.0.2 中添加。
group_replication_flow_control_min_quota: 可以为每个成员分配的最低流量控制配额。在 MySQL 8.0.2 中添加。
group_replication_flow_control_min_recovery_quota: 可以分配给每个成员的最低配额，因为另一个组成员正在恢复。在 MySQL 8.0.2 中添加。
group_replication_flow_control_period：定义流控制迭代之间等待的秒数。在 MySQL 8.0.2 中添加。
group_replication_flow_control_release_percent: 当流量控制不再需要限制写入成员时，应该如何释放组配额。在 MySQL 8.0.2 中添加。
group_replication_ip_allowlist：允许连接到组的主机列表（MySQL 8.0.22 及更高版本）。在 MySQL 8.0.22 中添加。
group_replication_member_expel_timeout: 怀疑组成员故障和将其从组中驱逐之间的时间，导致组成员重新配置。在 MySQL 8.0.13 中添加。
group_replication_member_weight：该成员被选为主要成员的机会。在 MySQL 8.0.2 中添加。
group_replication_message_cache_size: 组通信引擎消息缓存 (XCom) 的最大内存。在 MySQL 8.0.16 中添加。
group_replication_paxos_single_leader：在单主模式下使用单个共识领导者。在 MySQL 8.0.27 中添加。
group_replication_recovery_compression_algorithms：传出恢复连接允许的压缩算法。在 MySQL 8.0.18 中添加。
group_replication_recovery_get_public_key：是否接受关于从捐助者那里获取公钥的偏好。在 MySQL 8.0.4 中添加。
group_replication_recovery_public_key_path：接受公钥信息。在 MySQL 8.0.4 中添加。
group_replication_recovery_tls_ciphersuites: 当 TLSv1.3 用于与此实例作为客户端（加入成员）的连接加密时允许的密码套件。在 MySQL 8.0.19 中添加。
group_replication_recovery_tls_version: 允许的 TLS 协议用于作为客户端（加入成员）的连接加密。在 MySQL 8.0.19 中添加。
group_replication_recovery_zstd_compression_level：使用 zstd 压缩的恢复连接的压缩级别。在 MySQL 8.0.18 中添加。
group_replication_tls_source：组复制的 TLS 材料来源。在 MySQL 8.0.21 中添加。
group_replication_unreachable_majority_timeout：等待导致少数人离开组的网络分区的时间。在 MySQL 8.0.2 中添加。
group_replication_view_change_uuid：用于视图更改事件 GTID 的 UUID。在 MySQL 8.0.26 中添加。
histogram_generation_max_mem_size：创建直方图统计的最大内存。在 MySQL 8.0.2 中添加。
immediate_server_version：作为直接复制源的服务器的MySQL服务器版本号。在 MySQL 8.0.14 中添加。
information_schema_stats_expiry: 缓存表统计的过期设置。在 MySQL 8.0.3 中添加。
init_replica：副本连接到源时执行的语句。在 MySQL 8.0.26 中添加。
innodb_buffer_pool_debug：当缓冲池大小小于 1GB 时允许多个缓冲池实例。在 MySQL 8.0.0 中添加。
innodb_buffer_pool_in_core_file：控制将缓冲池页面写入核心文件。在 MySQL 8.0.14 中添加。
innodb_checkpoint_disabled：禁用检查点，以便有意的服务器退出始终启动恢复。在 MySQL 8.0.2 中添加。
innodb_ddl_buffer_size：DDL 操作的最大缓冲区大小。在 MySQL 8.0.27 中添加。
innodb_ddl_log_crash_reset_debug：重置 DDL 日志崩溃注入计数器的调试选项。在 MySQL 8.0.3 中添加。
innodb_ddl_threads：创建索引的最大并行线程数。在 MySQL 8.0.27 中添加。
innodb_deadlock_detect：启用或禁用死锁检测。在 MySQL 8.0.0 中添加。
innodb_dedicated_server：启用缓冲池大小、日志文件大小和刷新方法的自动配置。在 MySQL 8.0.3 中添加。
innodb_directories：定义目录以在启动时扫描表空间数据文件。在 MySQL 8.0.4 中添加。
innodb_doublewrite_batch_size：每批要写入的双写页数。在 MySQL 8.0.20 中添加。
innodb_doublewrite_dir: 双写缓冲区文件目录。在 MySQL 8.0.20 中添加。
innodb_doublewrite_files：双写文件的数量。在 MySQL 8.0.20 中添加。
innodb_doublewrite_pages：每个线程的双写页数。在 MySQL 8.0.20 中添加。
innodb_extend_and_initialize：控制如何在 Linux 上分配新的表空间页面。在 MySQL 8.0.22 中添加。
innodb_fsync_threshold：控制 InnoDB 在创建新文件时调用 fsync 的频率。在 MySQL 8.0.13 中添加。
innodb_idle_flush_pct：当 InnoDB 空闲时限制 I/0 操作。在 MySQL 8.0.18 中添加。
innodb_log_checkpoint_fuzzy_now: 强制 InnoDB 写入模糊检查点的调试选项。在 MySQL 8.0.13 中添加。
innodb_log_spin_cpu_abs_lwm：最小 CPU 使用量，低于该值用户线程在等待刷新重做时不再旋转。在 MySQL 8.0.11 中添加。
innodb_log_spin_cpu_pct_hwm：最大 CPU 使用量，超过该值用户线程在等待刷新重做时不再旋转。在 MySQL 8.0.11 中添加。
innodb_log_wait_for_flush_spin_hwm：最大平均日志刷新时间，用户线程在等待刷新重做时不再旋转。在 MySQL 8.0.11 中添加。
innodb_log_writer_threads：启用专用日志写入器线程来写入和刷新重做日志。在 MySQL 8.0.22 中添加。
innodb_parallel_read_threads：并行索引读取的线程数。在 MySQL 8.0.14 中添加。
innodb_print_ddl_logs: 是否打印 DDL 日志到错误日志。在 MySQL 8.0.3 中添加。
innodb_redo_log_archive_dirs：标记为重做日志存档目录。在 MySQL 8.0.17 中添加。
innodb_redo_log_capacity：重做日志文件的大小限制。在 MySQL 8.0.30 中添加。
innodb_redo_log_encrypt：控制加密表空间的重做日志数据的加密。在 MySQL 8.0.1 中添加。
innodb_scan_directories：定义在 InnoDB 恢复期间扫描表空间文件的目录。在 MySQL 8.0.2 中添加。
innodb_segment_reserve_factor：保留为空页的表空间文件段页的百分比。在 MySQL 8.0.26 中添加。
innodb_spin_wait_pause_multiplier：用于确定自旋等待循环中 PAUSE 指令数的乘数值。在 MySQL 8.0.16 中添加。
innodb_stats_include_delete_marked：在计算持久性 InnoDB 统计信息时包括删除标记的记录。在 MySQL 8.0.1 中添加。
innodb_temp_tablespaces_dir: 会话临时表空间路径。在 MySQL 8.0.13 中添加。
innodb_tmpdir：在线 ALTER TABLE 操作期间创建的临时表文件的目录位置。在 MySQL 8.0.0 中添加。
innodb_undo_log_encrypt：控制加密表空间的撤消日志数据的加密。在 MySQL 8.0.1 中添加。
innodb_use_fdatasync: InnoDB 在将数据刷新到操作系统时是否使用 fdatasync() 而不是 fsync()。在 MySQL 8.0.26 中添加。
innodb_validate_tablespace_paths：在启动时启用表空间路径验证。在 MySQL 8.0.21 中添加。
internal_tmp_mem_storage_engine：用于内部内存临时表的存储引擎。在 MySQL 8.0.2 中添加。
keyring-migration-destination：密钥迁移目标密钥环插件。在 MySQL 8.0.4 中添加。
keyring-migration-host：用于连接到正在运行的服务器以进行密钥迁移的主机名。在 MySQL 8.0.4 中添加。
keyring-migration-password: 连接到正在运行的服务器进行密钥迁移的密码。在 MySQL 8.0.4 中添加。
keyring-migration-port：用于连接到正在运行的服务器以进行密钥迁移的 TCP/IP 端口号。在 MySQL 8.0.4 中添加。
keyring-migration-socket: Unix 套接字文件或 Windows 命名管道，用于连接到正在运行的服务器以进行密钥迁移。在 MySQL 8.0.4 中添加。
keyring-migration-source：密钥迁移源密钥环插件。在 MySQL 8.0.4 中添加。
keyring-migration-to-component：密钥环迁移是从插件到组件。在 MySQL 8.0.24 中添加。
keyring-migration-user：用于连接到正在运行的服务器以进行密钥迁移的用户名。在 MySQL 8.0.4 中添加。
keyring_aws_cmk_id：AWS 密钥环插件客户主密钥 ID 值。在 MySQL 8.0.11 中添加。
keyring_aws_conf_file：AWS 密钥环插件配置文件位置。在 MySQL 8.0.11 中添加。
keyring_aws_data_file: AWS 密钥环插件存储文件位置。在 MySQL 8.0.11 中添加。
keyring_aws_region：AWS 密钥环插件区域。在 MySQL 8.0.11 中添加。
keyring_encrypted_file_data: keyring_encrypted_file 插件数据文件。在 MySQL 8.0.11 中添加。
keyring_encrypted_file_password: keyring_encrypted_file 插件密码。在 MySQL 8.0.11 中添加。
keyring_hashicorp_auth_path：HashiCorp Vault AppRole 身份验证路径。在 MySQL 8.0.18 中添加。
keyring_hashicorp_ca_path：keyring_hashicorp CA 文件的路径。在 MySQL 8.0.18 中添加。
keyring_hashicorp_caching: 是否启用 keyring_hashicorp 缓存。在 MySQL 8.0.18 中添加。
keyring_hashicorp_commit_auth_path：正在使用的 keyring_hashicorp_auth_path 值。在 MySQL 8.0.18 中添加。
keyring_hashicorp_commit_ca_path：正在使用的 keyring_hashicorp_ca_path 值。在 MySQL 8.0.18 中添加。
keyring_hashicorp_commit_caching：正在使用的 keyring_hashicorp_caching 值。在 MySQL 8.0.18 中添加。
keyring_hashicorp_commit_role_id：正在使用的 keyring_hashicorp_role_id 值。在 MySQL 8.0.18 中添加。
keyring_hashicorp_commit_server_url：正在使用的 keyring_hashicorp_server_url 值。在 MySQL 8.0.18 中添加。
keyring_hashicorp_commit_store_path：正在使用的 keyring_hashicorp_store_path 值。在 MySQL 8.0.18 中添加。
keyring_hashicorp_role_id：HashiCorp Vault AppRole 身份验证角色 ID。在 MySQL 8.0.18 中添加。
keyring_hashicorp_secret_id：HashiCorp Vault AppRole 身份验证秘密 ID。在 MySQL 8.0.18 中添加。
keyring_hashicorp_server_url：HashiCorp Vault 服务器 URL。在 MySQL 8.0.18 中添加。
keyring_hashicorp_store_path：HashiCorp Vault 存储路径。在 MySQL 8.0.18 中添加。
keyring_oci_ca_certificate: 用于对等身份验证的 CA 证书文件。在 MySQL 8.0.22 中添加。
keyring_oci_compartment：OCI隔间OCID。在 MySQL 8.0.22 中添加。
keyring_oci_encryption_endpoint: OCI 加密服务器端点。在 MySQL 8.0.22 中添加。
keyring_oci_key_file: OCI RSA 私钥文件。在 MySQL 8.0.22 中添加。
keyring_oci_key_fingerprint: OCI RSA 私钥文件指纹。在 MySQL 8.0.22 中添加。
keyring_oci_management_endpoint: OCI 管理服务器端点。在 MySQL 8.0.22 中添加。
keyring_oci_master_key: OCI 主密钥 OCID。在 MySQL 8.0.22 中添加。
keyring_oci_secrets_endpoint: OCI 机密服务器端点。在 MySQL 8.0.22 中添加。
keyring_oci_tenancy: OCI 租赁 OCID。在 MySQL 8.0.22 中添加。
keyring_oci_user：OCI 用户 OCID。在 MySQL 8.0.22 中添加。
keyring_oci_vaults_endpoint：OCI 保险库服务器端点。在 MySQL 8.0.22 中添加。
keyring_oci_virtual_vault: OCI 保险库 OCID。在 MySQL 8.0.22 中添加。
keyring_okv_conf_dir：Oracle Key Vault 密钥环插件配置目录。在 MySQL 8.0.11 中添加。
keyring_operations：是否启用密钥环操作。在 MySQL 8.0.4 中添加。
lock_order: 是否在运行时启用 LOCK_ORDER 工具。在 MySQL 8.0.17 中添加。
lock_order_debug_loop: 当 LOCK_ORDER 工具遇到标记为循环的依赖项时是否引起调试断言。在 MySQL 8.0.17 中添加。
lock_order_debug_missing_arc: 当 LOCK_ORDER 工具遇到未声明的依赖时是否引起调试断言。在 MySQL 8.0.17 中添加。
lock_order_debug_missing_key：当 LOCK_ORDER 工具遇到未正确使用 Performance Schema 检测的对象时是否引起调试断言。在 MySQL 8.0.17 中添加。
lock_order_debug_missing_unlock: 当 LOCK_ORDER 工具遇到锁被销毁但仍持有时是否引起调试断言。在 MySQL 8.0.17 中添加。
lock_order_dependencies：lock_order_dependencies.txt 文件的路径。在 MySQL 8.0.17 中添加。
lock_order_extra_dependencies: 第二个依赖文件的路径。在 MySQL 8.0.17 中添加。
lock_order_output_directory: LOCK_ORDER 工具写入日志的目录。在 MySQL 8.0.17 中添加。
lock_order_print_txt：是否进行锁单图分析和打印文本报告。在 MySQL 8.0.17 中添加。
lock_order_trace_loop: 当 LOCK_ORDER 工具遇到标记为循环的依赖项时是否打印日志文件跟踪。在 MySQL 8.0.17 中添加。
lock_order_trace_missing_arc: 当 LOCK_ORDER 工具遇到未声明的依赖项时是否打印日志文件跟踪。在 MySQL 8.0.17 中添加。
lock_order_trace_missing_key：当 LOCK_ORDER 工具遇到未正确使用 Performance Schema 检测的对象时，是否打印日志文件跟踪。在 MySQL 8.0.17 中添加。
lock_order_trace_missing_unlock: 当 LOCK_ORDER 工具遇到锁被销毁时是否打印日志文件跟踪。在 MySQL 8.0.17 中添加。
log_error_filter_rules：错误记录的过滤规则。在 MySQL 8.0.2 中添加。
log_error_services：用于错误记录的组件。在 MySQL 8.0.2 中添加。
log_error_suppression_list：要抑制的警告/信息错误日志消息。在 MySQL 8.0.13 中添加。
log_replica_updates：副本是否应将其复制 SQL 线程执行的更新记录到其自己的二进制日志中。在 MySQL 8.0.26 中添加。
log_slow_extra: 是否将额外信息写入慢查询日志文件。在 MySQL 8.0.14 中添加。
log_slow_replica_statements：导致副本执行的慢语句被写入慢查询日志。在 MySQL 8.0.26 中添加。
mandatory_roles：自动为所有用户授予角色。在 MySQL 8.0.2 中添加。
mysql_firewall_mode: MySQL Enterprise Firewall 是否运行。在 MySQL 8.0.11 中添加。
mysql_firewall_trace: 是否启用防火墙跟踪。在 MySQL 8.0.11 中添加。
mysqlx: X Plugin 是否初始化。在 MySQL 8.0.11 中添加。
mysqlx_compression_algorithms：X 协议连接允许的压缩算法。在 MySQL 8.0.19 中添加。
mysqlx_deflate_default_compression_level：X 协议连接上 Deflate 算法的默认压缩级别。在 MySQL 8.0.20 中添加。
mysqlx_deflate_max_client_compression_level：X 协议连接上 Deflate 算法的最大允许压缩级别。在 MySQL 8.0.20 中添加。
mysqlx_interactive_timeout：等待交互式客户端超时的秒数。在 MySQL 8.0.4 中添加。
mysqlx_lz4_default_compression_level：X 协议连接上 LZ4 算法的默认压缩级别。在 MySQL 8.0.20 中添加。
mysqlx_lz4_max_client_compression_level：X 协议连接上 LZ4 算法的最大允许压缩级别。在 MySQL 8.0.20 中添加。
mysqlx_read_timeout：等待阻塞读取操作完成的秒数。在 MySQL 8.0.4 中添加。
mysqlx_wait_timeout：等待连接活动的秒数。在 MySQL 8.0.4 中添加。
mysqlx_write_timeout：等待阻塞写操作完成的秒数。在 MySQL 8.0.4 中添加。
mysqlx_zstd_default_compression_level：X 协议连接上 zstd 算法的默认压缩级别。在 MySQL 8.0.20 中添加。
mysqlx_zstd_max_client_compression_level：X 协议连接上 zstd 算法的最大允许压缩级别。在 MySQL 8.0.20 中添加。
named_pipe_full_access_group: 授予对命名管道的完全访问权限的 Windows 组的名称。在 MySQL 8.0.14 中添加。
no-dd-upgrade: 防止启动时自动升级数据字典表。在 MySQL 8.0.4 中添加。
no-monitor：不要派生 RESTART 所需的监控进程。在 MySQL 8.0.12 中添加。
original_commit_timestamp：在原始源上提交事务的时间。在 MySQL 8.0.1 中添加。
original_server_version：最初提交事务的服务器的 MySQL 服务器版本号。在 MySQL 8.0.14 中添加。
partial_revokes：是否启用部分撤销。在 MySQL 8.0.16 中添加。
password_history：密码重用前所需的密码更改次数。在 MySQL 8.0.3 中添加。
password_require_current: 修改密码是否需要验证当前密码。在 MySQL 8.0.13 中添加。
password_reuse_interval：密码重用前需要经过的天数。在 MySQL 8.0.3 中添加。
performance-schema-consumer-events-statements-cpu：配置声明CPU使用消费者。在 MySQL 8.0.28 中添加。
performance_schema_max_digest_sample_age: 以秒为单位查询重采样年龄。在 MySQL 8.0.3 中添加。
performance_schema_show_processlist：选择SHOW PROCESSLIST 实现。在 MySQL 8.0.22 中添加。
persist_only_admin_x509_subject: SSL 证书 X.509 Subject 启用持久的持久限制系统变量。在 MySQL 8.0.14 中添加。
persist_sensitive_variables_in_plaintext：是否允许服务器以未加密格式存储敏感系统变量的值。在 MySQL 8.0.29 中添加。
persisted_globals_load：是否加载持久配置设置。在 MySQL 8.0.0 中添加。
print_identified_with_as_hex：对于 SHOW CREATE USER，打印包含十六进制不可打印字符的哈希值。在 MySQL 8.0.17 中添加。
protocol_compression_algorithms：允许的传入连接压缩算法。在 MySQL 8.0.18 中添加。
pseudo_replica_mode: 供内部服务器使用。在 MySQL 8.0.26 中添加。
regexp_stack_limit：正则表达式匹配栈大小限制。在 MySQL 8.0.4 中添加。
regexp_time_limit：正则表达式匹配超时。在 MySQL 8.0.4 中添加。
replica_checkpoint_group：在调用检查点操作以更新进度状态之前，多线程副本处理的最大事务数。NDB Cluster 不支持。在 MySQL 8.0.26 中添加。
replica_checkpoint_period：在此毫秒数后更新多线程副本的进度状态并将中继日志信息刷新到磁盘。NDB Cluster 不支持。在 MySQL 8.0.26 中添加。
replica_compressed_protocol：使用源/副本协议的压缩。在 MySQL 8.0.26 中添加。
replica_exec_mode：允许在 IDEMPOTENT 模式（密钥和其他一些错误被抑制）和 STRICT 模式之间切换复制线程；STRICT 模式是默认的，除了 NDB Cluster，总是使用 IDEMPOTENT。在 MySQL 8.0.26 中添加。
replica_load_tmpdir：副本在复制 LOAD DATA 语句时应放置其临时文件的位置。在 MySQL 8.0.26 中添加。
replica_max_allowed_packet：可以从复制源服务器发送到副本的数据包的最大大小，以字节为单位；覆盖 max_allowed_pa​​cket。在 MySQL 8.0.26 中添加。
replica_net_timeout：在中止读取之前等待来自源/副本连接的更多数据的秒数。在 MySQL 8.0.26 中添加。
replica_parallel_type：告诉副本使用时间戳信息（LOGICAL_CLOCK）或数据库分区（DATABASE）来并行化事务。在 MySQL 8.0.26 中添加。
replica_parallel_workers：并行执行复制事务的applier线程数；0 或 1 禁用副本多线程。NDB Cluster：参见文档。在 MySQL 8.0.26 中添加。
replica_pending_jobs_size_max：持有尚未应用的事件的副本工作者队列的最大大小。在 MySQL 8.0.26 中添加。
replica_preserve_commit_order：确保副本工作者的所有提交都按照与源相同的顺序进行，以在使用并行应用程序线程时保持一致性。在 MySQL 8.0.26 中添加。
replica_skip_errors：当查询从提供的列表中返回错误时，告诉复制线程继续复制。在 MySQL 8.0.26 中添加。
replica_sql_verify_checksum：导致副本在从中继日志读取时检查校验和。在 MySQL 8.0.26 中添加。
replica_transaction_retries：复制 SQL 线程重试事务的次数，以防它因死锁或经过的锁等待超时而失败，然后放弃并停止。在 MySQL 8.0.26 中添加。
replica_type_conversions：控制副本上的类型转换模式。值是此列表中零个或多个元素的列表：ALL_LOSSY、ALL_NON_LOSSY。设置为空字符串以禁止源和副本之间的类型转换。在 MySQL 8.0.26 中添加。
replication_optimize_for_static_plugin_config: 用于半同步复制的共享锁。在 MySQL 8.0.23 中添加。
replication_sender_observe_commit_only：半同步复制的有限回调。在 MySQL 8.0.23 中添加。
require_row_format: 供内部服务器使用。在 MySQL 8.0.19 中添加。
resultset_metadata：服务器是否返回结果集元数据。在 MySQL 8.0.3 中添加。
rewriter_enabled_for_threads_without_privilege_checks：如果将其设置为 OFF，则在禁用特权检查（PRIVILEGE_CHECKS_USER 为 NULL）的情况下执行的复制线程将跳过重写。在 MySQL 8.0.31 中添加。
rpl_read_size：设置从二进制日志文件和中继日志文件读取的最小数据量（以字节为单位）。在 MySQL 8.0.11 中添加。
rpl_semi_sync_replica_enabled：是否在副本上启用了半同步复制。在 MySQL 8.0.26 中添加。
rpl_semi_sync_replica_trace_level：副本上的半同步复制调试跟踪级别。在 MySQL 8.0.26 中添加。
rpl_semi_sync_source_enabled：是否在源上启用了半同步复制。在 MySQL 8.0.26 中添加。
rpl_semi_sync_source_timeout：等待副本确认的毫秒数。在 MySQL 8.0.26 中添加。
rpl_semi_sync_source_trace_level：源上的半同步复制调试跟踪级别。在 MySQL 8.0.26 中添加。
rpl_semi_sync_source_wait_for_replica_count：在继续之前每个事务必须接收的副本确认源的数量。在 MySQL 8.0.26 中添加。
rpl_semi_sync_source_wait_no_replica: 即使没有副本，源是否等待超时。在 MySQL 8.0.26 中添加。
rpl_semi_sync_source_wait_point: 副本交易收据确认的等待点。在 MySQL 8.0.26 中添加。
rpl_stop_replica_timeout：STOP REPLICA 在超时前等待的秒数。在 MySQL 8.0.26 中添加。
secondary_engine_cost_threshold：查询卸载到辅助引擎的优化器成本阈值。在 MySQL 8.0.16 中添加。
select_into_buffer_size: 用于 OUTFILE 或 DUMPFILE 导出文件的缓冲区大小；覆盖 read_buffer_size。在 MySQL 8.0.22 中添加。
select_into_disk_sync：OUTFILE或DUMPFILE导出文件刷新缓冲区后与存储设备同步数据；OFF 禁用同步并且是默认值。在 MySQL 8.0.22 中添加。
select_into_disk_sync_delay：当 select_into_sync_disk = ON 时，在每次同步 OUTFILE 或 DUMPFILE 导出文件缓冲区后设置延迟（以毫秒为单位），否则无效。在 MySQL 8.0.22 中添加。
show-replica-auth-info: 在此源上的 SHOW REPLICAS 中显示用户名和密码。在 MySQL 8.0.26 中添加。
show_create_table_skip_secondary_engine：是否从 SHOW CREATE TABLE 输出中排除 SECONDARY ENGINE 子句。在 MySQL 8.0.18 中添加。
show_create_table_verbosity: 是否在 SHOW CREATE TABLE 中显示 ROW_FORMAT，即使它有默认值。在 MySQL 8.0.11 中添加。
show_gipk_in_create_table_and_information_schema: 生成的不可见主键是否显示在 SHOW 语句和 INFORMATION_SCHEMA 表中。在 MySQL 8.0.30 中添加。
skip-replica-start：如果设置，复制不会在副本服务器启动时自动启动。在 MySQL 8.0.26 中添加。
source_verify_checksum：导致源在从二进制日志读取时检查校验和。在 MySQL 8.0.26 中添加。
sql_generate_invisible_primary_key：是否启用 GIPK 模式，在这种情况下，复制源服务器为没有显式 PK 创建的任何 InnoDB 表生成不可见的主键。对复制表没有影响。在 MySQL 8.0.30 中添加。
sql_replica_skip_counter：副本应跳过的来自源的事件数。与 GTID 复制不兼容。在 MySQL 8.0.26 中添加。
sql_require_primary_key: 表是否必须有主键。在 MySQL 8.0.13 中添加。
ssl_fips_mode：服务器端是否开启FIPS模式。在 MySQL 8.0.11 中添加。
ssl_session_cache_mode: 是否启用服务器生成会话票据。在 MySQL 8.0.29 中添加。
ssl_session_cache_timeout：以秒为单位的 SSL 会话超时值。在 MySQL 8.0.29 中添加。
sync_source_info：在每个#th 事件后同步源信息。在 MySQL 8.0.26 中添加。
syseventlog.facility：系统日志消息的工具。在 MySQL 8.0.13 中添加。
syseventlog.include_pid：是否在 syslog 消息中包含服务器 PID。在 MySQL 8.0.13 中添加。
syseventlog.tag：系统日志消息中服务器标识符的标记。在 MySQL 8.0.13 中添加。
table_encryption_privilege_check：启用 TABLE_ENCRYPTION_ADMIN 权限检查。在 MySQL 8.0.16 中添加。
temptable_max_mmap: TempTable 存储引擎可以从内存映射临时文件分配的最大内存量。在 MySQL 8.0.23 中添加。
temptable_max_ram: 定义在数据存储到磁盘之前，TempTable 存储引擎可以占用的最大内存量。在 MySQL 8.0.2 中添加。
temptable_use_mmap: 定义TempTable存储引擎在达到temptable_max_ram阈值时是否分配内存映射文件。在 MySQL 8.0.16 中添加。
terminology_use_previous：在更改不兼容的指定版本之前使用术语。在 MySQL 8.0.26 中添加。
thread_pool_algorithm：线程池算法。在 MySQL 8.0.11 中添加。
thread_pool_dedicated_listeners：在每个线程组中指定一个监听线程来监听网络事件。在 MySQL 8.0.23 中添加。
thread_pool_high_priority_connection: 当前会话是否为高优先级。在 MySQL 8.0.11 中添加。
thread_pool_max_active_query_threads：每组允许的最大活动查询线程数。在 MySQL 8.0.19 中添加。
thread_pool_max_transactions_limit：线程池操作期间允许的最大事务数。在 MySQL 8.0.23 中添加。
thread_pool_max_unused_threads：未使用线程的最大允许数量。在 MySQL 8.0.11 中添加。
thread_pool_prio_kickup_timer：语句移动到高优先级执行之前的时间。在 MySQL 8.0.11 中添加。
thread_pool_query_threads_per_group：线程组的最大查询线程数。在 MySQL 8.0.31 中添加。
thread_pool_size：线程池中线程组的数量。在 MySQL 8.0.11 中添加。
thread_pool_stall_limit：语句被定义为停滞之前的时间。在 MySQL 8.0.11 中添加。
thread_pool_transaction_delay: 线程池执行新事务前的延迟时间。在 MySQL 8.0.31 中添加。
tls_ciphersuites：用于加密连接的允许的 TLSv1.3 密码套件。在 MySQL 8.0.16 中添加。
upgrade：控制开机自动升级。在 MySQL 8.0.16 中添加。
use_secondary_engine: 是否使用辅助引擎执行查询。在 MySQL 8.0.13 中添加。
validate-config：验证服务器配置。在 MySQL 8.0.16 中添加。
validate_password.check_user_name：是否根据用户名检查密码。在 MySQL 8.0.4 中添加。
validate_password.dictionary_file: validate_password 字典文件。在 MySQL 8.0.4 中添加。
validate_password.dictionary_file_last_parsed：上次解析字典文件的时间。在 MySQL 8.0.4 中添加。
validate_password.dictionary_file_words_count: 词典文件中的单词数。在 MySQL 8.0.4 中添加。
validate_password.length: validate_password 要求的密码长度。在 MySQL 8.0.4 中添加。
validate_password.mixed_case_count: validate_password 所需的大写/小写字符数。在 MySQL 8.0.4 中添加。
validate_password.number_count: validate_password 所需的数字字符数。在 MySQL 8.0.4 中添加。
validate_password.policy: validate_password 密码策略。在 MySQL 8.0.4 中添加。
validate_password.special_char_count: validate_password 所需的特殊字符数。在 MySQL 8.0.4 中添加。
version_compile_zlib: 内置 zlib 库的版本。在 MySQL 8.0.11 中添加。
windowing_use_high_precision: 是否以高精度计算窗函数。在 MySQL 8.0.2 中添加。
MySQL 8.0 中弃用的选项和变量
以下系统变量、状态变量和选项已在 MySQL 8.0 中弃用。
Compression: 客户端连接是否使用客户端/服务器协议中的压缩。在 MySQL 8.0.18 中弃用。
Slave_open_temp_tables：复制 SQL 线程当前已打开的临时表数。在 MySQL 8.0.26 中弃用。
Slave_rows_last_search_algorithm_used：此副本最近使用的搜索算法来定位基于行的复制（索引、表或散列扫描）的行。在 MySQL 8.0.26 中弃用。
abort-slave-event-count：mysql-test 用于调试和测试复制的选项。在 MySQL 8.0.29 中弃用。
admin-ssl：启用连接加密。在 MySQL 8.0.26 中弃用。
default_authentication_plugin：默认身份验证插件。在 MySQL 8.0.27 中弃用。
disconnect-slave-event-count：mysql-test 用于调试和测试复制的选项。在 MySQL 8.0.29 中弃用。
expire_logs_days：这么多天后清除二进制日志。在 MySQL 8.0.3 中弃用。
group_replication_ip_whitelist：允许连接到组的主机列表。在 MySQL 8.0.22 中弃用。
have_openssl: mysqld 是否支持SSL 连接。在 MySQL 8.0.26 中弃用。
have_ssl: mysqld 是否支持SSL 连接。在 MySQL 8.0.26 中弃用。
init_slave：副本连接到源时执行的语句。在 MySQL 8.0.26 中弃用。
innodb_log_file_size：日志组中每个日志文件的大小。在 MySQL 8.0.30 中弃用。
innodb_log_files_in_group: 日志组中 InnoDB 日志文件的数量。在 MySQL 8.0.30 中弃用。
innodb_undo_tablespaces：回滚段之间划分的表空间文件数。在 MySQL 8.0.4 中弃用。
log_bin_use_v1_row_events：服务器是否正在使用版本 1 二进制日志行事件。在 MySQL 8.0.18 中弃用。
log_slave_updates：副本是否应将其复制 SQL 线程执行的更新记录到其自己的二进制日志中。在 MySQL 8.0.26 中弃用。
log_slow_slave_statements：导致副本执行的慢语句被写入慢查询日志。在 MySQL 8.0.26 中弃用。
log_syslog: 是否将错误日志写入系统日志。在 MySQL 8.0.2 中弃用。
master-info-file：记住源文件的位置和名称以及 I/O 复制线程在源二进制日志中的位置。在 MySQL 8.0.18 中弃用。
master_info_repository：是否将连接元数据存储库（包含源二进制日志中的源信息和复制 I/O 线程位置）写入文件或表。在 MySQL 8.0.23 中弃用。
master_verify_checksum：导致源在从二进制日志读取时检查校验和。在 MySQL 8.0.26 中弃用。
max_length_for_sort_data：排序记录中的最大字节数。在 MySQL 8.0.20 中弃用。
myisam_repair_threads：修复 MyISAM 表时使用的线程数。1 禁用并行修复。在 MySQL 8.0.29 中弃用。
no-dd-upgrade: 防止启动时自动升级数据字典表。在 MySQL 8.0.16 中弃用。
old-style-user-limits：启用旧式用户限制（在 5.0.3 之前，用户资源是按每个用户+主机与每个帐户计算的）。在 MySQL 8.0.30 中弃用。
pseudo_slave_mode: 供内部服务器使用。在 MySQL 8.0.26 中弃用。
query_prealloc_size：用于查询解析和执行的持久缓冲区。在 MySQL 8.0.29 中弃用。
relay_log_info_file: 应用程序元数据存储库的文件名，其中副本记录有关中继日志的信息。在 MySQL 8.0.18 中弃用。
relay_log_info_repository: 是否将中继日志中复制SQL线程的位置写入文件或表。在 MySQL 8.0.23 中弃用。
replica_parallel_type：告诉副本使用时间戳信息（LOGICAL_CLOCK）或数据库分区（DATABASE）来并行化事务。在 MySQL 8.0.29 中弃用。
rpl_stop_slave_timeout：STOP REPLICA 或 STOP SLAVE 在超时前等待的秒数。在 MySQL 8.0.26 中弃用。
show-slave-auth-info: 在此源上的 SHOW REPLICAS 和 SHOW SLAVE HOSTS 中显示用户名和密码。在 MySQL 8.0.26 中弃用。
skip-host-cache：不缓存主机名。在 MySQL 8.0.30 中弃用。
skip-slave-start：如果设置，复制不会在副本服务器启动时自动启动。在 MySQL 8.0.26 中弃用。
slave-skip-errors：当查询从提供的列表中返回错误时，告诉复制线程继续复制。在 MySQL 8.0.26 中弃用。
slave_checkpoint_group：在调用检查点操作以更新进度状态之前，多线程副本处理的最大事务数。NDB Cluster 不支持。在 MySQL 8.0.26 中弃用。
slave_checkpoint_period：在此毫秒数后更新多线程副本的进度状态并将中继日志信息刷新到磁盘。NDB Cluster 不支持。在 MySQL 8.0.26 中弃用。
slave_compressed_protocol：使用源/副本协议的压缩。在 MySQL 8.0.18 中弃用。
slave_load_tmpdir：副本在复制 LOAD DATA 语句时应放置其临时文件的位置。在 MySQL 8.0.26 中弃用。
slave_max_allowed_packet：可以从复制源服务器发送到副本的数据包的最大大小，以字节为单位；覆盖 max_allowed_pa​​cket。在 MySQL 8.0.26 中弃用。
slave_net_timeout：在中止读取之前等待来自源/副本连接的更多数据的秒数。在 MySQL 8.0.26 中弃用。
slave_parallel_type：告诉副本使用时间戳信息 (LOGICAL_CLOCK) 或数据库分区 (DATABASE) 来并行化事务。在 MySQL 8.0.26 中弃用。
slave_parallel_workers：并行执行复制事务的applier线程数；0 或 1 禁用副本多线程。NDB Cluster：参见文档。在 MySQL 8.0.26 中弃用。
slave_pending_jobs_size_max：持有尚未应用的事件的副本工作者队列的最大大小。在 MySQL 8.0.26 中弃用。
slave_preserve_commit_order：确保副本工作者的所有提交都按照与源相同的顺序进行，以在使用并行应用程序线程时保持一致性。在 MySQL 8.0.26 中弃用。
slave_rows_search_algorithms：确定用于副本更新批处理的搜索算法。此列表中的任意 2 或 3 个：INDEX_SEARCH、TABLE_SCAN、HASH_SCAN。在 MySQL 8.0.18 中弃用。
slave_sql_verify_checksum：导致副本在从中继日志读取时检查校验和。在 MySQL 8.0.26 中弃用。
slave_transaction_retries：复制 SQL 线程重试事务的次数，以防它因死锁或经过的锁等待超时而失败，然后放弃并停止。在 MySQL 8.0.26 中弃用。
slave_type_conversions：控制副本上的类型转换模式。值是此列表中零个或多个元素的列表：ALL_LOSSY、ALL_NON_LOSSY。设置为空字符串以禁止源和副本之间的类型转换。在 MySQL 8.0.26 中弃用。
sql_slave_skip_counter：副本应跳过的来自源的事件数。与 GTID 复制不兼容。在 MySQL 8.0.26 中弃用。
ssl：启用连接加密。在 MySQL 8.0.26 中弃用。
symbolic-links: 允许 MyISAM 表的符号链接。在 MySQL 8.0.2 中弃用。
sync_master_info：在每个#th 事件后同步源信息。在 MySQL 8.0.26 中弃用。
temptable_use_mmap: 定义TempTable存储引擎在达到temptable_max_ram阈值时是否分配内存映射文件。在 MySQL 8.0.26 中弃用。
transaction_prealloc_size：用于将事务存储在二进制日志中的持久缓冲区。在 MySQL 8.0.29 中弃用。
transaction_write_set_extraction：定义用于散列事务期间提取的写入的算法。在 MySQL 8.0.26 中弃用。
MySQL 8.0 中删除的选项和变量
MySQL 8.0 中删除了以下系统变量、状态变量和选项。
Com_alter_db_upgrade: ALTER DATABASE ... UPGRADE DATA DIRECTORY NAME 语句的计数。在 MySQL 8.0.0 中删除。
Innodb_available_undo_logs：InnoDB回滚段总数；与 innodb_rollback_segments 不同，它显示活动回滚段的数量。在 MySQL 8.0.2 中删除。
Qcache_free_blocks：查询缓存中的空闲内存块数。在 MySQL 8.0.3 中删除。
Qcache_free_memory：查询缓存的可用内存量。在 MySQL 8.0.3 中删除。
Qcache_hits：查询缓存命中数。在 MySQL 8.0.3 中删除。
Qcache_inserts：查询缓存插入数。在 MySQL 8.0.3 中删除。
Qcache_lowmem_prunes：由于缓存中缺少可用内存而从查询缓存中删除的查询数。在 MySQL 8.0.3 中删除。
Qcache_not_cached：非缓存查询的数量（不可缓存，或由于 query_cache_type 设置而未缓存）。在 MySQL 8.0.3 中删除。
Qcache_queries_in_cache：在查询缓存中注册的查询数。在 MySQL 8.0.3 中删除。
Qcache_total_blocks：查询缓存中的块总数。在 MySQL 8.0.3 中删除。
Slave_heartbeat_period: Replica的复制心跳间隔，单位秒。在 MySQL 8.0.1 中删除。
Slave_last_heartbeat：显示接收到最新心跳信号的时间，格式为 TIMESTAMP。在 MySQL 8.0.1 中删除。
Slave_received_heartbeats：自上次重置以来副本收到的心跳数。在 MySQL 8.0.1 中删除。
Slave_retried_transactions：自启动以来复制 SQL 线程重试事务的总次数。在 MySQL 8.0.1 中删除。
Slave_running：此服务器作为副本的状态（复制 I/O 线程状态）。在 MySQL 8.0.1 中删除。
bootstrap：由mysql安装脚本使用。在 MySQL 8.0.0 中删除。
date_format：日期格式（未使用）。在 MySQL 8.0.3 中删除。
datetime_format: DATETIME/TIMESTAMP 格式（未使用）。在 MySQL 8.0.3 中删除。
des-key-file: 从给定文件加载 des_encrypt() 和 des_encrypt 的密钥。在 MySQL 8.0.3 中删除。
group_replication_allow_local_disjoint_gtids_join：允许当前服务器加入组，即使它有组中不存在的事务。在 MySQL 8.0.4 中删除。
have_crypt: crypt() 系统调用的可用性。在 MySQL 8.0.3 中删除。
ignore-db-dir: 将目录视为非数据库目录。在 MySQL 8.0.0 中删除。
ignore_builtin_innodb: 忽略内置的 InnoDB。在 MySQL 8.0.3 中删除。
ignore_db_dirs: 目录被视为非数据库目录。在 MySQL 8.0.0 中删除。
innodb_checksums：启用 InnoDB 校验和验证。在 MySQL 8.0.0 中删除。
innodb_disable_resize_buffer_pool_debug：禁用调整 InnoDB 缓冲池的大小。在 MySQL 8.0.0 中删除。
innodb_file_format：新 InnoDB 表的格式。在 MySQL 8.0.0 中删除。
innodb_file_format_check: InnoDB 是否进行文件格式兼容性检查。在 MySQL 8.0.0 中删除。
innodb_file_format_max: 共享表空间中的文件格式标记。在 MySQL 8.0.0 中删除。
innodb_large_prefix：为列前缀索引启用更长的键。在 MySQL 8.0.0 中删除。
innodb_locks_unsafe_for_binlog：强制 InnoDB 不使用下一键锁定。而是仅使用行级锁定。在 MySQL 8.0.0 中删除。
innodb_scan_directories：定义在 InnoDB 恢复期间扫描表空间文件的目录。在 MySQL 8.0.4 中删除。
innodb_stats_sample_pages: 为索引分布统计采样的索引页数。在 MySQL 8.0.0 中删除。
innodb_support_xa：启用 InnoDB 对 XA 两阶段提交的支持。在 MySQL 8.0.0 中删除。
innodb_undo_logs：InnoDB使用的undo日志（回滚段）数；innodb_rollback_segments 的别名。在 MySQL 8.0.2 中删除。
internal_tmp_disk_storage_engine：内部临时表的存储引擎。在 MySQL 8.0.16 中删除。
log-warnings：将一些非严重警告写入日志文件。在 MySQL 8.0.3 中删除。
log_builtin_as_identified_by_password: 是否以向后兼容的方式记录 CREATE/ALTER USER, GRANT。在 MySQL 8.0.11 中删除。
log_error_filter_rules：错误记录的过滤规则。在 MySQL 8.0.4 中删除。
log_syslog: 是否将错误日志写入系统日志。在 MySQL 8.0.13 中删除。
log_syslog_facility：系统日志消息的工具。在 MySQL 8.0.13 中删除。
log_syslog_include_pid：是否在 syslog 消息中包含服务器 PID。在 MySQL 8.0.13 中删除。
log_syslog_tag：系统日志消息中服务器标识符的标记。在 MySQL 8.0.13 中删除。
max_tmp_tables： 没用过。在 MySQL 8.0.3 中删除。
metadata_locks_cache_size：元数据锁缓存的大小。在 MySQL 8.0.13 中删除。
metadata_locks_hash_instances：元数据锁哈希的数量。在 MySQL 8.0.13 中删除。
multi_range_count：在范围选择期间一次发送到表处理程序的最大范围数。在 MySQL 8.0.3 中删除。
myisam_repair_threads：修复 MyISAM 表时使用的线程数。1 禁用并行修复。在 MySQL 8.0.30 中删除。
old_passwords: 为 PASSWORD() 选择密码散列方法。在 MySQL 8.0.11 中删除。
partition：启用（或禁用）分区支持。在 MySQL 8.0.0 中删除。
query_cache_limit：不要缓存大于此的结果。在 MySQL 8.0.3 中删除。
query_cache_min_res_unit：分配结果空间的单元的最小大小（写入所有结果数据后修剪最后一个单元）。在 MySQL 8.0.3 中删除。
query_cache_size：分配的内存用于存储旧查询的结果。在 MySQL 8.0.3 中删除。
query_cache_type: 查询缓存类型。在 MySQL 8.0.3 中删除。
query_cache_wlock_invalidate：使查询缓存中的查询在 LOCK 上无效以进行写入。在 MySQL 8.0.3 中删除。
secure_auth：禁止对具有旧（4.1 之前）密码的帐户进行身份验证。在 MySQL 8.0.3 中删除。
show_compatibility_56：显示状态/变量的兼容性。在 MySQL 8.0.1 中删除。
skip-partition：不要启用用户定义的分区。在 MySQL 8.0.0 中删除。
sync_frm：在创建时将 .frm 同步到磁盘。默认启用。在 MySQL 8.0.0 中删除。
temp-pool：使用此选项会导致创建的大多数临时文件使用一小组名称，而不是每个新文件的唯一名称。在 MySQL 8.0.1 中删除。
time_format：时间格式（未使用）。在 MySQL 8.0.3 中删除。
tx_isolation：默认事务隔离级别。在 MySQL 8.0.3 中删除。
tx_read_only: 默认事务访问模式。在 MySQL 8.0.3 中删除。
© Mysql 中文网
