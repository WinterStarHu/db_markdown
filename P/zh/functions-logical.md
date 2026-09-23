# 9.1. 逻辑操作符

9.1. 逻辑操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.1. 逻辑操作符 #
常用的逻辑操作符有：
boolean AND boolean → boolean
boolean OR boolean → boolean
NOT boolean → boolean
SQL使用三值的逻辑系统，包括真、假和null，null表示“未知”。观察下面的真值表：
aba AND ba OR bTRUETRUETRUETRUETRUEFALSEFALSETRUETRUENULLNULLTRUEFALSEFALSEFALSEFALSEFALSENULLFALSENULLNULLNULLNULLNULL
aNOT aTRUEFALSEFALSETRUENULLNULL
操作符AND和OR是可交换的，也就是说，你可以交换左右操作数而不影响结果。
（但是，不能保证左操作数在右操作数之前计算。参见第 4.2.14 节获取有关子表达式计算顺序的更多信息。）
上一页 上一级 下一页第 9 章 函数和操作符 起始页 9.2. 比较函数和操作符
