# F.5. basic_archive — 一个示例WAL归档模块

F.5. basic_archive — 一个示例WAL归档模块
版本：
纠错本页面
搜索
目录导航
❮
❯
F.5. basic_archive — 一个示例WAL归档模块 #F.5.1. 配置参数F.5.2. 注意事项F.5.3. 作者
basic_archive 是归档模块的一个例子。
此模块将已完成的WAL段文件复制到指定的目录中。
这可能不是特别有用，但它可以作为开发自己的归档模块的起点。
有关归档模块的更多信息，请参见 第 49 章。
为了使模块正常工作，必须通过archive_library加载该模块，并且必须启用archive_mode。
F.5.1. 配置参数 #
basic_archive.archive_directory (string)
服务器应该复制WAL段文件的目录。此目录必须已经存在。默认为空字符串，这
实际上停止了WAL归档，但如果启用了archive_mode
，服务器将积累WAL段文件，期望很快会提供一个值。
这些参数必须在postgresql.conf中设置。典型的使用是：
# postgresql.conf
archive_mode = 'on'
archive_library = 'basic_archive'
basic_archive.archive_directory = '/path/to/archive/directory'
F.5.2. 注意事项 #
服务器崩溃可能会在存档目录中留下以archtemp为前缀的临时文件。建议在崩溃后重新启动服务器之前删除这些文件。在服务器运行时删除这些文件是安全的，只要它们与仍在进行的任何存档无关，但用户在这样做时应格外小心。
F.5.3. 作者 #
Nathan Bossart
上一页 上一级 下一页F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块 起始页 F.6. bloom — bloom过滤器索引访问方法
