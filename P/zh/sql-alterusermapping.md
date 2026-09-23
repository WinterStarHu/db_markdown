# ALTER USER MAPPING

ALTER USER MAPPING
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER USER MAPPINGALTER USER MAPPING — 更改用户映射的定义大纲
ALTER USER MAPPING FOR { user_name | USER | CURRENT_ROLE | CURRENT_USER | SESSION_USER | PUBLIC }
SERVER server_name
OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ] )
描述
ALTER USER MAPPING更改用户映射的定义。
外部服务器的拥有者可以为任何用户修改该服务器的用户映射。此外，
如果用户被授予外部服务器上的USAGE特权，则可以修改其
自己的用户名的用户映射。
参数user_name
该映射的用户名。CURRENT_ROLE、CURRENT_USER和USER匹配当前
用户的名称。PUBLIC用于匹配系统中所有当前以及未来的用户名。
server_name
该用户映射的服务器名称。
OPTIONS ( [ ADD | SET | DROP ] option ['value'] [, ... ] )
为该用户映射更改选项。新选项会覆盖任何之前指定的选项。ADD、
SET和DROP指定要执行的操作。如果没有显式地指定
操作，将假定为ADD。选项名称必须唯一；该服务器的外部数据包装
器也会验证选项。
示例
为服务器foo的用户映射bob更改密码：
ALTER USER MAPPING FOR bob SERVER foo OPTIONS (SET password 'public');
兼容性
ALTER USER MAPPING符合 ISO/IEC 9075-9
(SQL/MED)。有一个细微的语法问题：该标准省略了FOR关键字。
由于CREATE USER MAPPING和
DROP USER MAPPING都在类似的位置上使用
FOR，并且 IBM DB2（作为其他主要的 SQL/MED 实现）也在
ALTER USER MAPPING中要求该关键字，因此为了保持一致性和互
操作性，PostgreSQL 在这里的实现与标准不同。
另见CREATE USER MAPPING, DROP USER MAPPING上一页 上一级 下一页ALTER USER 起始页 ALTER VIEW
