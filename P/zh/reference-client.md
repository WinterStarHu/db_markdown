# PostgreSQL 客户端应用程序

PostgreSQL 客户端应用程序
版本：
纠错本页面
搜索
目录导航
❮
❯
PostgreSQL 客户端应用程序
这部分包含PostgreSQL客户端应用程序和工具的参考信息。不是所有这些命令都是通用工具，某些可能需要特殊权限。这些应用程序的共同特征是它们可以在任何主机上运行，而不管数据库服务器在哪里。
当在命令行上指定用户和数据库名时，它们的大小写会被保留 — 空格或特殊字符的出现可能需要使用引号。表名和其他标识符的大小写不会被保留，除非有文档说明，并且可能需要使用引号。
目录clusterdb — 聚簇一个PostgreSQL数据库createdb — 创建一个新的PostgreSQL数据库createuser — 定义一个新的PostgreSQL用户账户dropdb — 移除一个PostgreSQL数据库dropuser — 移除一个PostgreSQL用户账户ecpg — 嵌入式 SQL C 预处理器pg_amcheck — 在一个或多个PostgreSQL数据库中检查数据损坏pg_basebackup — 获取一个PostgreSQL集簇的基础备份pgbench — 在PostgreSQL上运行基准测试pg_combinebackup — 从增量备份和依赖备份重建完整备份pg_config — 获取已安装的PostgreSQL版本的信息pg_dump —
将 PostgreSQL 数据库导出为 SQL 脚本或其他格式
pg_dumpall — 将一个PostgreSQL数据库集群抽取到一个脚本文件中pg_isready — 检查PostgreSQL服务器的连接状态pg_receivewal — 以流的方式从一个PostgreSQL服务器获取预写式日志pg_recvlogical — 控制 PostgreSQL 逻辑解码流pg_restore —
从一个由pg_dump创建的归档文件恢复一个PostgreSQL数据库
pg_verifybackup — 验证PostgreSQL集群的基础备份的完整性psql —
PostgreSQL交互式终端
reindexdb — 重新索引一个PostgreSQL数据库vacuumdb — 对一个PostgreSQL数据库进行垃圾收集和分析上一页 上一级 下一页VALUES 起始页 clusterdb
