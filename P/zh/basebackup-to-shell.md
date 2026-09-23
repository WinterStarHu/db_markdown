# F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块

F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块
版本：
纠错本页面
搜索
目录导航
❮
❯
F.4. basebackup_to_shell — 示例 "shell" pg_basebackup 模块 #F.4.1. 配置参数F.4.2. 作者
basebackup_to_shell 添加了一个名为shell的自定义basebackup目标。这使得可以运行pg_basebackup --target=shell或者，取决于模块的配置方式，pg_basebackup --target=shell:DETAIL_STRING，并导致由服务器管理员选择的服务器命令在备份过程生成的每个tar归档中被执行。该命令将通过标准输入接收归档的内容。
本模块主要是作为通过扩展模块创建新的备份目标的示例，但在某些情况下，它可能
也有自身的用途。
为了使其正常工作，必须通过shared_preload_libraries或
local_preload_libraries加载此模块。
F.4.1. 配置参数 #
basebackup_to_shell.command (string)
服务器应该为备份过程生成的每个存档执行的命令。如果命令字符串中出现
%f，它将被存档的名称替换（例如
base.tar）。如果命令字符串中出现
%d，它将被用户提供的目标详细信息替换。如果命令字符串中使用
%d，则需要目标详细信息，否则禁止使用。出于安全原因，它只能包含字母数字字符。如果命令字符串中出现
%%，它将被替换为一个单独的
%。如果命令字符串中出现
%，后面跟着任何其他字符或在字符串末尾，将会出现错误。
basebackup_to_shell.required_role (string)
使用shell备份目标所需的角色。如果未设置此项，任何复制用户都可以使用shell备份目标。
F.4.2. 作者 #
Robert Haas <rhaas@postgresql.org>
上一页 上一级 下一页F.3. auto_explain — 记录慢查询的执行计划 起始页 F.5. basic_archive — 一个示例WAL归档模块
