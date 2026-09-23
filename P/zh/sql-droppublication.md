# DROP PUBLICATION

DROP PUBLICATION
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP PUBLICATIONDROP PUBLICATION — 删除一个发布大纲
DROP PUBLICATION [ IF EXISTS ] name [, ...] [ CASCADE | RESTRICT ]
描述
DROP PUBLICATION从数据库中删除一个现有的发布。
发布只能被它的所有者或超级用户删除。
参数IF EXISTS
如果发布不存在，不要抛出错误。在这种情况下发出一个提示。
name
现有出版物的名称。
CASCADERESTRICT
这些关键词没有任何作用，因为没有对发布的依赖关系。
示例
删除一个发布：
DROP PUBLICATION mypublication;
兼容性
DROP PUBLICATION 是一个 PostgreSQL
扩展。
另见CREATE PUBLICATION, ALTER PUBLICATION上一页 上一级 下一页DROP PROCEDURE 起始页 DROP ROLE
