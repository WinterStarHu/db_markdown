# 53.3. pg_available_extensions

53.3. pg_available_extensions
版本：
纠错本页面
搜索
目录导航
❮
❯
53.3. pg_available_extensions #
pg_available_extensions 视图列出了可供安装的扩展。
另请参阅pg_extension 目录，显示当前已安装的扩展。
表 53.3. pg_available_extensions 列
列类型
描述
name name
扩展名称
default_version text
默认版本的名称，如果没有指定则为NULL
installed_version text
当前已安装的扩展版本，如果没有安装则为NULL
comment text
来自扩展控制文件的注释字符串
pg_available_extensions视图是只读的。
上一页 上一级 下一页53.2. pg_aios 起始页 53.4. pg_available_extension_versions
