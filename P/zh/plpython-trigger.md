# 44.5. 触发器函数

44.5. 触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
44.5. 触发器函数 #
当函数被用作触发器时，字典TD包含触发器相关的值：
TD["event"]
包含字符串型的事件：INSERT、UPDATE、DELETE或者TRUNCATE。
TD["when"]
包含BEFORE、AFTER或者INSTEAD OF之一。
TD["level"]
包含ROW或者STATEMENT。
TD["new"]TD["old"]
对于行级触发器，这些字段的一个或者两个包含相应的触发器行，这取决于触发器事件。
TD["name"]
包含触发器的名称。
TD["table_name"]
包含该触发器发生的表名。
TD["table_schema"]
包含该触发器发生的表所属的模式名。
TD["relid"]
包含该触发器发生的表的 OID。
TD["args"]
如果CREATE TRIGGER命令包括参数，它们可以通过TD["args"][0]至TD["args"][n-1]使用。
如果TD["when"]是BEFORE或者INSTEAD OF并且TD["level"]是ROW，可以从 Python 函数返回None或者"OK"来表示行没有被修改。返回"SKIP"可以中止事件，或者在TD["event"]为INSERT或UPDATE时可以返回"MODIFY"以表示已经修改了新行。否则返回值会被忽略。
上一页 上一级 下一页44.4. 匿名代码块 起始页 44.6. 数据库访问
