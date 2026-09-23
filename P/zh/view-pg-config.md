# 53.6. pg_config

53.6. pg_config
版本：
纠错本页面
搜索
目录导航
❮
❯
53.6. pg_config #
视图pg_config描述了当前安装版本的PostgreSQL的编译时配置参数。
例如，它可供希望与PostgreSQL进行接口的软件包使用，以便找到所需的头文件和库。
它提供与PostgreSQL客户端应用程序pg_config相同的基本信息。
默认情况下，pg_config视图只能被超级用户读取。
表 53.6. pg_config 列
列类型
描述
name text
参数名
setting text
参数值
上一页 上一级 下一页53.5. pg_backend_memory_contexts 起始页 53.7. pg_cursors
