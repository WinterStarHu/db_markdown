# SPI_prepare

SPI_prepare
版本：
纠错本页面
搜索
目录导航
❮
❯
SPI_prepareSPI_prepare — 准备一个语句，但尚未执行它大纲
SPIPlanPtr SPI_prepare(const char * command, int nargs, Oid * argtypes)
描述
SPI_prepare为指定的命令创建并返回一个
预备语句，但并不执行该命令。该预备语句可以在稍后使用
SPI_execute_plan重复执行。
当相同或相似的命令要被重复执行时，通常来说只执行一次解析
分析是有利的，并且更有利的是重用该命令的执行计划。
SPI_prepare把一个命令字符串转换成一个预
备语句，它封装了解析分析的结果。如果发现为每一次执行都生成
一个定制计划没有帮助，该预备语句也提供了一个地方缓存执行计划。
一个预备命令可以通过在一个普通命令中应该出现常量的地方写
上参数（$1、$2等等）来进行
一般化。参数的实际值在调用SPI_execute_plan
时指定。这让该预备命令可以在比没有参数的情况下更广泛地使用。
SPI_prepare返回的语句只能在当前的C函数调用
中使用，因为SPI_finish会释放为这样一个语句
分配的内存。但是可以使用函数SPI_keepplan
或SPI_saveplan将该语句保存更久。
参数const char * command
命令字符串
int nargs
输入参数的数量（$1、$2等等）
Oid * argtypes
指向一个数组的指针，该数组包含参数的数据类型的
OID
返回值
SPI_prepare返回一个指向SPIPlan
的非空指针，它是一个表示预备语句的不透明结构。发生错误时，
将会返回NULL，并且
SPI_result将被设置为一个也被
SPI_execute使用的错误码，不过当
command为NULL、
或者nargs小于零、或者nargs大于
零但是argtypes为NULL
时它会被设置为SPI_ERROR_ARGUMENT。
注意事项
如果没有定义参数，在第一次使用SPI_execute_plan
时将会创建一个一般的计划，并且把它用于所有的后续执行。如果有参数，
SPI_execute_plan的前几次使用将根据提供的参数值
产生定制计划。在使用同一个预备语句足够多次后，
SPI_execute_plan将构建一个一般计划，并且如果它
并不比定制计划昂贵太多， SPI_execute_plan将开始
使用一般计划来取代每次都进行重新规划。如果这种默认的行为不合适，你可以
通过传递CURSOR_OPT_GENERIC_PLAN或
CURSOR_OPT_CUSTOM_PLAN标志给
SPI_prepare_cursor，以分别强制使用一般或者定制
计划。
尽管一个预备语句的要点是避免对语句的重复解析分析以及规划，只要语句中
用到的数据库对象从上一次使用该预备语句以来经历过定义性（DDL）改变，
PostgreSQL将会强制重新分析和重新规划该语句。还有，
如果search_path的值从一个改变成下一个，该语句将
会使用新的search_path进行重新解析（后一种行为是从
PostgreSQL 9.3 开始的新行为）。更多
有关预备语句行为的信息请见PREPARE。
这个函数只能从一个已连接的C函数调用。
SPIPlanPtr被声明为spi.h中的一种不透明结构类型
的指针。尝试直接访问其内容是不明智的，因为那会让你的代码更有可能会在未
来版本的PostgreSQL中崩溃。
SPIPlanPtr这个名字多少有点历史原因，因为该数据结构不再必
要包含一个执行计划。
上一页 上一级 下一页SPI_execute_with_args 起始页 SPI_prepare_cursor
