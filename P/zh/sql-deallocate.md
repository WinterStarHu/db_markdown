# DEALLOCATE

DEALLOCATE
版本：
纠错本页面
搜索
目录导航
❮
❯
DEALLOCATEDEALLOCATE — 释放预备语句大纲
DEALLOCATE [ PREPARE ] { name | ALL }
描述
DEALLOCATE被用来释放一个之前
准备好的 SQL 语句。如果不显式地释放一个预备语句，会话结束
时会释放它。
更多关于预备语句的信息请见PREPARE。
参数PREPARE
这个关键字会被忽略。
name
要释放的预备语句的名称。
ALL
释放所有预备语句。
兼容性
SQL 标准包括一个DEALLOCATE语句，
但是只用于嵌入式 SQL。
另见EXECUTE, PREPARE上一页 上一级 下一页CREATE VIEW 起始页 DECLARE
