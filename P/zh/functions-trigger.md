# 9.29. 触发器函数

9.29. 触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
9.29. 触发器函数 #
虽然很多触发器的使用都涉及到用户编写的触发器函数，但PostgreSQL提供了一些可以直接在用户定义触发器中使用的内置触发器函数。
这些总结在了表 9.110中。
(另外还有一些内置的触发器函数存在，它们实现了外键约束和延期索引约束。因为用户不需要直接使用它们，所以这里就不做论述了。)
有关创建触发器的更多信息，请参考CREATE TRIGGER。
表 9.110. 内置触发器函数
函数
描述
示例用法
suppress_redundant_updates_trigger ( )
→ trigger
阻止不做事的更新操作。详见下文。
CREATE TRIGGER ... suppress_redundant_updates_trigger()
tsvector_update_trigger ( )
→ trigger
自动从相关的纯文本文档列更新tsvector列。
要使用的文本搜索配置是以名称指定为触发器参数。详情请参见第 12.4.3 节。
CREATE TRIGGER ... tsvector_update_trigger(tsvcol, 'pg_catalog.swedish', title, body)
tsvector_update_trigger_column ( )
→ trigger
自动从相关的纯文本文档列更新tsvector列。
要使用的文本搜索配置取自表的regconfig列。详情请参见第 12.4.3 节。
CREATE TRIGGER ... tsvector_update_trigger_column(tsvcol, tsconfigcol, title, body)
suppress_redundant_updates_trigger函数，在作为行级BEFORE UPDATE触发器应用时，将阻止任何没有实际更改行中数据的更新发生。
这会覆盖那种始终执行物理行更新而无论数据是否已更改的常规行为。
(这种常规的行为使更新运行得更快，因为不需要检查，而且在某些情况下也很有用。)
理想的情况下，你应该避免运行实际上并没有改变记录中数据的更新。
冗余更新会花费大量不必要的时间，尤其是如果有大量索引要改变，并将最终不得不清理被死行占用的空间。
但是，在客户端代码中检测这种情况并不总是容易的，甚至不可能做到。 而写表达式来检测它们容易产生错误。
作为替代，使用suppress_redundant_updates_trigger可以跳过不改变数据的更新。 但是，你需要小心使用它。
触发器需要很短但不能忽略的时间来处理每条记录，所以如果受更新影响的大多数记录确实变化了，此触发器的使用将使更新比平均水平运行得更慢。
suppress_redundant_updates_trigger函数可以像这样添加到表中:
CREATE TRIGGER z_min_update
BEFORE UPDATE ON tablename
FOR EACH ROW EXECUTE FUNCTION suppress_redundant_updates_trigger();
在大多数情况下，你需要为每一行最后触发这个触发器，这样它就不会覆盖可能希望更改该行的其他触发器。
请记住，触发器是按照名称顺序触发的，你将为此选择一个触发器名称，该名称位于表中可能存在的任何其他触发器的名称之后。
(因此在示例中使用了“z”前缀。)
上一页 上一级 下一页9.28. 系统管理函数 起始页 9.30. 事件触发器函数
