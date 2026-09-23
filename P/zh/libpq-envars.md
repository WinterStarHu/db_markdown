# 32.15. 环境变量

32.15. 环境变量
版本：
纠错本页面
搜索
目录导航
❮
❯
32.15. 环境变量 #
以下环境变量可用于选择默认连接参数值，这些值将被
PQconnectdb，PQsetdbLogin和
PQsetdb使用，如果调用代码没有直接指定值。这些对于
避免将数据库连接信息硬编码到简单的客户端应用程序中非常有用，例如。
PGHOST的行为与host连接参数相同。
PGSSLNEGOTIATION的行为与sslnegotiation连接参数相同。
PGHOSTADDR的行为与hostaddr连接参数相同。
这可以替代或与PGHOST一起设置，以避免DNS查找开销。
PGPORT的行为与port连接参数相同。
PGDATABASE的行为与dbname连接参数相同。
PGUSER的行为与user连接参数相同。
PGPASSWORD的行为与password连接参数相同。
出于安全原因，不建议使用此环境变量，因为一些操作系统允许非root用户通过ps查看进程环境变量；
而应考虑使用密码文件（参见第 32.16 节）。
PGPASSFILE的行为与passfile连接参数相同。
PGREQUIREAUTH的行为与require_auth连接参数相同。
PGCHANNELBINDING的行为与channel_binding连接参数相同。
PGSERVICE的行为与service连接参数相同。
PGSERVICEFILE指定每个用户的连接服务文件的名称
(参见第 32.17 节)。
默认为~/.pg_service.conf，或者在Microsoft Windows上为%APPDATA%\postgresql\.pg_service.conf。
PGOPTIONS的行为与options连接参数相同。
PGAPPNAME的行为与application_name连接参数相同。
PGSSLMODE的行为与sslmode连接参数相同。
PGREQUIRESSL的行为与requiressl连接参数相同。
这个环境变量已被弃用，推荐使用PGSSLMODE变量；设置这两个变量会抑制这个变量的效果。
PGSSLCOMPRESSION的行为与sslcompression连接参数相同。
PGSSLCERT的行为与sslcert连接参数相同。
PGSSLKEY的行为与sslkey连接参数相同。
PGSSLCERTMODE的行为与sslcertmode连接参数相同。
PGSSLROOTCERT的行为与sslrootcert连接参数相同。
PGSSLCRL的行为与sslcrl连接参数相同。
PGSSLCRLDIR的行为与sslcrldir连接参数相同。
PGSSLSNI的行为与sslsni连接参数相同。
PGREQUIREPEER的行为与requirepeer连接参数相同。
PGSSLMINPROTOCOLVERSION的行为与ssl_min_protocol_version连接参数相同。
PGSSLMAXPROTOCOLVERSION的行为与ssl_max_protocol_version连接参数相同。
PGGSSENCMODE的行为与gssencmode连接参数相同。
PGKRBSRVNAME的行为与krbsrvname连接参数相同。
PGGSSLIB的行为与gsslib连接参数相同。
PGGSSDELEGATION 的行为与 gssdelegation 连接参数相同。
PGCONNECT_TIMEOUT 的行为与 connect_timeout 连接参数相同。
PGCLIENTENCODING 的行为与 client_encoding 连接参数相同。
PGTARGETSESSIONATTRS 的行为与 target_session_attrs 连接参数相同。
PGLOADBALANCEHOSTS 的行为与 load_balance_hosts 连接参数相同。
PGMINPROTOCOLVERSION 的行为与 min_protocol_version 连接参数相同。
PGMAXPROTOCOLVERSION 的行为与 max_protocol_version 连接参数相同。
下面的环境变量可用来为每一个PostgreSQL会话指定默认行为（为每一个用户或每一个数据库设置默认行为的方法还可见ALTER ROLE和ALTER DATABASE命令）。
PGDATESTYLE 设置日期/时间表示的默认风格（等同于SET datestyle TO ...）。
PGTZ 设置默认的时区（等同于SET timezone TO ...）。
PGGEQO 为遗传查询优化器设置默认模式（等同于SET geqo TO ...）。
这些环境变量的正确值可参考SQL 命令 SET。
下面的环境变量决定libpq的内部行为，它们会覆盖编译在程序中的默认值。
PGSYSCONFDIR设置包含pg_service.conf文件以及未来版本中可能出现的其他系统范围配置文件的目录。
PGLOCALEDIR设置包含用于消息本地化的locale文件的目录。
上一页 上一级 下一页32.14. 事件系统 起始页 32.16. 密码文件
