# DROP TABLESPACE

DROP TABLESPACE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP TABLESPACEDROP TABLESPACE — 移除表空间大纲
DROP TABLESPACE [ IF EXISTS ] name
描述
DROP TABLESPACE从系统中移除表空间。
表空间只能被其拥有者或超级用户删除。在表空间被删除前，
必须没有任何数据库对象。即使当前数据库中没有对象正在使用
该表空间，也可能有其他数据库的对象存在于其中。还有，如果
该表空间被列在任何活动会话的temp_tablespaces设置中，
DROP也可能会失败，因为可能有临时文件存在其中。
参数IF EXISTS
如果该表空间不存在则不要抛出错误，而是发出提示。
name
一个表空间的名称。
注释
DROP TABLESPACE不能在事务块内执行。
示例
要从系统移除表空间mystuff：
DROP TABLESPACE mystuff;
兼容性
DROP TABLESPACE是一个
PostgreSQL扩展。
另见CREATE TABLESPACE, ALTER TABLESPACE上一页 上一级 下一页DROP TABLE 起始页 DROP TEXT SEARCH CONFIGURATION
