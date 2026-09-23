# 35.20. data_type_privileges

35.20. data_type_privileges
版本：
纠错本页面
搜索
目录导航
❮
❯
35.20. data_type_privileges #
视图data_type_privileges标识当前用户能够访问（作为被描述对象的拥有者或者具有其上的某种特权）的所有数据类型描述符。只要一个数据类型被用在一个表列、一个域或一个函数（作为参数或返回类型）就会生成一个数据类型描述符并且在那个实例中存储一些有关该数据类型如何被使用的信息（例如，声明的最大长度，如果适用）。每一个数据类型描述符被赋予一个任意的标识符，它在被赋予给一个对象（表、域、函数）的数据类型描述符中唯一。这个视图对于应用可能没什么用，但是它被用于定义信息模式中的一些其他视图。
表 35.18. data_type_privileges 列
列类型
描述
object_catalog sql_identifier
包含该描述对象的数据库名称（总是当前数据库）
object_schema sql_identifier
包含该描述对象的模式名称
object_name sql_identifier
描述对象的名称
object_type character_data
被描述对象的类型：TABLE（该表的一列的数据类型描述符）、DOMAIN（该域的数据类型描述符）、ROUTINE（该函数的一个参数或返回数据类型的数据类型描述符）。
dtd_identifier sql_identifier
数据类型描述符的标识符，它在同一对象的数据类型描述符中是唯一的。
上一页 上一级 下一页35.19. constraint_table_usage 起始页 35.21. domain_constraints
