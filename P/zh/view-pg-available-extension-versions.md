# 53.4. pg_available_extension_versions

53.4. pg_available_extension_versions
版本：
纠错本页面
搜索
目录导航
❮
❯
53.4. pg_available_extension_versions #
pg_available_extension_versions视图列出了可供安装的特定扩展版本。
另请参阅pg_extension目录，显示当前已安装的扩展。
表 53.4. pg_available_extension_versions 列
列类型
描述
name name
扩展名称
version text
版本名称
installed bool
如果此版本的扩展当前已安装则为真
superuser bool
如果只有超级用户被允许安装此扩展则为真（但请参见 trusted）
trusted bool
如果扩展可以由具有适当权限的非超级用户安装，则为真
relocatable bool
如果扩展可以重定位到另一个模式则为真
schema name
此扩展必须安装到的模式名称，如果此扩展是部分或全部可重定位的，此列为NULL
requires name[]
先决条件扩展的名称，如果没有则为NULL
comment text
扩展的控制文件中的注释字符串
pg_available_extension_versions视图是只读的。
上一页 上一级 下一页53.3. pg_available_extensions 起始页 53.5. pg_backend_memory_contexts
