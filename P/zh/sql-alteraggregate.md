# ALTER AGGREGATE

ALTER AGGREGATE
版本：
纠错本页面
搜索
目录导航
❮
❯
ALTER AGGREGATEALTER AGGREGATE — 更改聚合函数的定义大纲
ALTER AGGREGATE name ( aggregate_signature ) RENAME TO new_name
ALTER AGGREGATE name ( aggregate_signature )
OWNER TO { new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER }
ALTER AGGREGATE name ( aggregate_signature ) SET SCHEMA new_schema
其中 aggregate_signature 是：
* |
[ argmode ] [ argname ] argtype [ , ... ] |
[ [ argmode ] [ argname ] argtype [ , ... ] ] ORDER BY [ argmode ] [ argname ] argtype [ , ... ]
描述
ALTER AGGREGATE更改聚合函数的定义。
您必须拥有聚合函数的所有权才能使用ALTER AGGREGATE。
要更改聚合函数的模式，您还必须拥有新模式的CREATE
权限。
要更改所有者，您必须能够SET ROLE为新的所有角色，
并且该角色必须拥有聚合函数模式的CREATE权限。
（这些限制确保更改所有者不会执行任何您无法通过删除和重新创建
聚合函数来完成的操作。然而，超级用户仍然可以更改任何聚合函数的
所有权。）
参数name
一个现有聚合函数的名称（可以是模式限定的）。
argmode
一个参数的模式：IN或VARIADIC。
如果省略，默认为IN。
argname
一个参数的名称。注意ALTER AGGREGATE
并不真正关心参数名称，因为决定聚合函数的身份时只需要参数的数据类型。
argtype
聚合函数要在其上操作的输入数据类型。要引用一个零参数聚合函数，在参数
说明列表的位置写上*。要引用一个有序集聚合函数，在直接参数
说明和聚合参数说明之间写上ORDER BY。
new_name
聚合函数的新名称。
new_owner
聚合函数的新拥有者。
new_schema
聚合函数的新模式。
Notes
引用有序集聚合的推荐语法是在直接参数说明和聚合参数说明之间写上
ORDER BY，这和CREATE AGGREGATE
中的风格相同。不过，省略ORDER BY并且只把直接和
聚合参数说明放到一个单一列表中也是可以的。在这种简写形式中，如果
在直接和聚合参数列表中都使用了VARIADIC "any"，只用
写一次VARIADIC "any"。
示例
要把用于类型integer的聚合函数
myavg重命名为my_average：
ALTER AGGREGATE myavg(integer) RENAME TO my_average;
要把用于类型integer的聚合函数
myavg的拥有者改为joe：
ALTER AGGREGATE myavg(integer) OWNER TO joe;
把带有float8类型直接参数和integer
类型聚合参数的有序集聚合mypercentile移动到
模式myschema中：
ALTER AGGREGATE mypercentile(float8 ORDER BY integer) SET SCHEMA myschema;
这也能行：
ALTER AGGREGATE mypercentile(float8, integer) SET SCHEMA myschema;
兼容性
在 SQL 标准中没有ALTER AGGREGATE语句。
其他CREATE AGGREGATE, DROP AGGREGATE上一页 上一级 下一页ABORT 起始页 ALTER COLLATION
