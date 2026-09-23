# SET CONNECTION

SET CONNECTION
版本：
纠错本页面
搜索
目录导航
❮
❯
SET CONNECTIONSET CONNECTION — 选择一个数据库连接大纲
SET CONNECTION [ TO | = ] connection_name
描述
SET CONNECTION设置“当前”数据库连接，除非被覆盖，所有命令都会使用这个连接。
参数connection_name #
一个由CONNECT命令建立的数据库连接名称。
CURRENT #
将连接设置为当前连接（因此，什么也不会发生）。
示例
EXEC SQL SET CONNECTION TO con2;
EXEC SQL SET CONNECTION = con1;
兼容性
SET CONNECTION 在 SQL 标准中被规定。
另请参阅CONNECT, DISCONNECT上一页 上一级 下一页SET AUTOCOMMIT 起始页 SET DESCRIPTOR
