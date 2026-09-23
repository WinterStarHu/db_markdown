# 53.7. pg_cursors

53.7. pg_cursors
版本：
纠错本页面
搜索
目录导航
❮
❯
53.7. pg_cursors #
pg_cursors视图列出当前可用的游标。游标可以通过多种方式定义：
通过SQL中的DECLARE语句
通过前端/后端协议中的Bind消息，如第 54.2.3 节中所述
通过服务器编程接口(SPI)，如第 45.1 节中所述
pg_cursors视图显示通过任何这些方式创建的游标。游标仅在定义它们的事务的持续时间内存在，除非它们已经声明为WITH HOLD。
因此，非持有游标仅在其创建事务结束之前存在于视图中。
注意
游标在内部用于实现PostgreSQL的某些组件，如过程语言。因此，pg_cursors视图可能包含用户未明确创建的游标。
表 53.7. pg_cursors 列
列类型
描述
name text
游标的名称
statement text
提交用于声明此游标的查询字符串
is_holdable bool
如果游标是可保持的（即，它可以在其定义事务提交后被访问）则为true，否则为false
is_binary bool
如果游标被声明为BINARY则为true，否则为false
is_scrollable bool
如果游标是可滚动的（即，允许以一种非顺序的方式检索行）则为true，否则为false
creation_time timestamptz
游标被声明的时间
pg_cursors视图是只读的。
上一页 上一级 下一页53.6. pg_config 起始页 53.8. pg_file_settings
