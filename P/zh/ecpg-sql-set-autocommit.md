# SET AUTOCOMMIT

SET AUTOCOMMIT
版本：
纠错本页面
搜索
目录导航
❮
❯
SET AUTOCOMMITSET AUTOCOMMIT — 设置当前会话的自动提交行为大纲
SET AUTOCOMMIT { = | TO } { ON | OFF }
描述
SET AUTOCOMMIT设置当前数据库会话的自动提交行为。默认情况下，嵌入式 SQL 程序不在自动提交模式中，因此需要显式地发出COMMIT。这个命令可以把会话改成自动提交模式，这样每一个单独的语句都会被隐式提交。
兼容性
SET AUTOCOMMIT是 PostgreSQL ECPG 的扩展。
上一页 上一级 下一页PREPARE 起始页 SET CONNECTION
