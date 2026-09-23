# ALTER VIEW

ALTER VIEW
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER VIEWALTER VIEW — 更改视图的定义大纲
ALTER VIEW [ IF EXISTS ] name ALTER [ COLUMN ] column_name SET DEFAULT expression
ALTER VIEW [ IF EXISTS ] name ALTER [ COLUMN ] column_name DROP DEFAULT
ALTER VIEW [ IF EXISTS ] name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER VIEW [ IF EXISTS ] name RENAME [ COLUMN ] column_name TO new_column_name
ALTER VIEW [ IF EXISTS ] name RENAME TO new_name
ALTER VIEW [ IF EXISTS ] name SET SCHEMA new_schema
ALTER VIEW [ IF EXISTS ] name SET ( view_option_name [= view_option_value] [, ... ] )
ALTER VIEW [ IF EXISTS ] name RESET ( view_option_name [, ... ] )
描述
ALTER VIEW更改视图的多种辅助属性（如果想要
修改视图的定义查询，应使用CREATE OR REPLACE VIEW）。
您必须拥有该视图才能使用ALTER VIEW。
要更改视图的模式，您还必须具有CREATE
权限在新模式上。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须具有CREATE
权限在视图的模式上。
（这些限制确保更改所有者不会执行任何您无法通过删除和重新创建视图
来完成的操作。然而，超级用户仍然可以更改任何视图的所有权。）
参数name
一个现有视图的名称（可以是模式限定的）。
column_name
现有列的名称。
new_column_name
现有列的新名称。
IF EXISTS
该视图不存在时不要抛出错误。这种情况下会发出一个通知。
SET/DROP DEFAULT
这些形式为一个列设置或移除默认值。对于任何在该视图上的
INSERT或UPDATE命令，一个视图列的默认值
会在应用任何规则或触发器之前被替换进来。因此，该视图的默认值将会
优先于来自底层关系的任何默认值。
new_owner
该视图的新拥有者的用户名。
new_name
该视图的新名称。
new_schema
该视图的新模式。
SET ( view_option_name [= view_option_value] [, ... ] )RESET ( view_option_name [, ... ] )
设置或重置视图选项。当前支持的选项包括:
check_option (enum)
更改视图的检查选项。该值必须是local或cascaded。
security_barrier (boolean)
更改视图的安全屏障属性。该值必须是布尔值，如true或false。
security_invoker (boolean)
更改视图的安全调用者属性。该值必须是布尔值，如true或false。
备注
由于历史原因，ALTER TABLE也可以用于视图，但是
只允许等效于以上形式的ALTER TABLE变体用于视图。
示例
把视图foo重命名为
bar：
ALTER VIEW foo RENAME TO bar;
要为一个可更新视图附加一个默认列值：
CREATE TABLE base_table (id int, ts timestamptz);
CREATE VIEW a_view AS SELECT * FROM base_table;
ALTER VIEW a_view ALTER COLUMN ts SET DEFAULT now();
INSERT INTO base_table(id) VALUES(1);  -- ts will receive a NULL
INSERT INTO a_view(id) VALUES(2);  -- ts will receive the current time
兼容性
ALTER VIEW是一种PostgreSQL
扩展的 SQL 标准。
另请参阅CREATE VIEW, DROP VIEW上一页 上一级 下一页ALTER USER MAPPING 起始页 ANALYZE
