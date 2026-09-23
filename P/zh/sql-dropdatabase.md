# DROP DATABASE

DROP DATABASE
版本：
纠错本页面
搜索
目录导航
❮
❯
DROP DATABASEDROP DATABASE — 删除一个数据库大纲
DROP DATABASE [ IF EXISTS ] name [ [ WITH ] ( option [, ...] ) ]
其中 option 可以是：
FORCE
描述
DROP DATABASE移除一个数据库。它会
移除该数据库的系统目录项并且删除包含数据的文件目录。它只能由数据库
拥有者执行。当你已经连接到目标数据库时，它不能被执行（连接
到postgres或者任何其他数据库来发出这个命令）。
另外，如果其他任何人已经连接到目标数据库，这个命令将会失败，除非您
使用以下所述的FORCE选项。
DROP DATABASE不能被撤销。请小心使用！
参数IF EXISTS
如果该数据库不存在则不要抛出一个错误，而是发出一个提示。
name
要移除的数据库名称。
FORCE
尝试终止与目标数据库的所有现有连接。
如果目标数据库中存在准备好的事务、活跃的逻辑复制槽或订阅，则不会终止。
这将终止后台工作者连接以及当前用户有权限通过
pg_terminate_backend终止的连接，具体描述见
第 9.28.2 节。如果仍有连接存在，
此命令将失败。
注释
DROP DATABASE不能在事务块内执行。
此命令不能在连接到目标数据库时执行。因此，使用程序
dropdb会更方便，它是此命令的一个包装器。
兼容性
SQL 标准中没有DROP DATABASE语句。
另请参阅CREATE DATABASE上一页 上一级 下一页DROP CONVERSION 起始页 DROP DOMAIN
