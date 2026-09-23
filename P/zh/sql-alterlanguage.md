# ALTER LANGUAGE

ALTER LANGUAGE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER LANGUAGEALTER LANGUAGE — 更改过程语言的定义大纲
ALTER [ PROCEDURAL ] LANGUAGE name RENAME TO new_name
ALTER [ PROCEDURAL ] LANGUAGE name OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
描述
ALTER LANGUAGE更改过程语言的定义。唯一
的功能是重命名该语言或为其指定新的拥有者。要使用
ALTER LANGUAGE，你必须是超级用户或该
语言的拥有者。
参数name
语言名称
new_name
语言的新名称
new_owner
该语言的新拥有者
兼容性
在 SQL 标准中没有ALTER LANGUAGE语句。
另见CREATE LANGUAGE, DROP LANGUAGE上一页 上一级 下一页ALTER INDEX 起始页 ALTER LARGE OBJECT
