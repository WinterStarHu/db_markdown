# SHOW

SHOW
版本：
纠错本页面
搜索
目录导航
❮
❯
SHOWSHOW — 显示运行时参数的值大纲
SHOW name
SHOW ALL
描述
SHOW将显示运行时参数的当前设置。
这些变量可以使用SET语句、编辑
postgresql.conf配置文件、通过
PGOPTIONS环境变量（使用
libpq或基于libpq的
应用时），或者启动postgres服务器时通过命令行
标志设置。详见第 19 章。
参数name
运行时参数的名称。可用的参数记录在
第 19 章和SET参考页面上。此外，还有一些参数可以显示但不能
设置：
SERVER_VERSION
显示服务器的版本号。
SERVER_ENCODING
显示服务器端的字符集编码。目前，这个参数可以显示但不能设置，
因为编码是在数据库创建时确定的。
IS_SUPERUSER
如果当前角色具有超级用户权限，则为真。
ALL
显示所有配置参数的值，并带有描述。
注释
函数current_setting产生等效的输出，见
第 9.28.1 节。还有，
pg_settings
系统视图产生同样的信息。
示例
显示参数DateStyle的当前设置：
SHOW DateStyle;
DateStyle
-----------
ISO, MDY
(1 row)
显示参数geqo的当前设置：
SHOW geqo;
geqo
------
on
(1 row)
显示所有设置:
SHOW ALL;
name         | setting |                description
-------------------------+---------+-------------------------------------------------
allow_system_table_mods | off     | Allows modifications of the structure of ...
.
.
.
xmloption               | content | Sets whether XML data in implicit parsing ...
zero_damaged_pages      | off     | Continues processing past damaged page headers.
(196 rows)
兼容性
SHOW命令是一种
PostgreSQL扩展。
另见SET, RESET上一页 上一级 下一页SET TRANSACTION 起始页 START TRANSACTION
