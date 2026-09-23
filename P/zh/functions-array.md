# 9.19. 数组函数和操作符

9.19. 数组函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.19. 数组函数和操作符 #
表 9.56显示了可以用于数组类型的专用的操作符。
除此之外，表 9.1中所示的常用比较运算符也适用于数组。
比较操作符逐个元素比较数组内容，使用默认的元素数据类型的B-tree比较函数，并根据第一个差值进行排序。
多维数组的元素按照行序进行访问（最后的下标变化最快）。
如果两个数组的内容相同但维数不等，那么维度信息中的第一个不同将决定排序顺序。
表 9.56. 数组操作符
操作符
描述
示例
anyarray @> anyarray
→ boolean
第一个数组是否包含第二个数组，也就是说，出现在第二个数组中的每个元素是否等于第一个数组中的某个元素？
(重复值不需要特殊处理，因此ARRAY[1] 和 ARRAY[1,1]被认为包含对方。)
ARRAY[1,4,3] @> ARRAY[3,1,3]
→ t
anyarray <@ anyarray
→ boolean
第一个数组是否被第二个数组包含？
ARRAY[2,2,7] <@ ARRAY[1,7,4,2,6]
→ t
anyarray && anyarray
→ boolean
这些数组是否有重叠，也就是说，它们是否有共同的元素？
ARRAY[1,4,3] && ARRAY[2,1]
→ t
anycompatiblearray || anycompatiblearray
→ anycompatiblearray
连接两个数组。连接空(null)或空数组是一个无操作(no-op)；否则，数组必须具有相同的维度数（如第一个示例所示），或者维度数相差一个（如第二个示例所示）。
如果数组不是完全相同的元素类型，它们将被强制转换成一个共同的类型（参见第 10.5 节）。
ARRAY[1,2,3] || ARRAY[4,5,6,7]
→ {1,2,3,4,5,6,7}
ARRAY[1,2,3] || ARRAY[[4,5,6],[7,8,9.9]]
→ {{1,2,3},{4,5,6},{7,8,9.9}}
anycompatible || anycompatiblearray
→ anycompatiblearray
将元素连接到数组的前面（数组必须为空或一维）。
3 || ARRAY[4,5,6]
→ {3,4,5,6}
anycompatiblearray || anycompatible
→ anycompatiblearray
将元素连接到数组的末尾（数组必须为空或一维）。
ARRAY[4,5,6] || 7
→ {4,5,6,7}
参阅第 8.15 节获取有关数组操作符行为的更多细节。有关哪些操作符支持被索引的操作，请参阅第 11.2 节。
表 9.57展示了可以用于数组类型的函数。 参阅第 8.15 节获取更多信息以及使用这些函数的例子。
表 9.57. 数组函数
函数
描述
示例
array_append ( anycompatiblearray, anycompatible )
→ anycompatiblearray
向一个数组的末端追加一个元素 (等同于 anycompatiblearray || anycompatible 操作符)。
array_append(ARRAY[1,2], 3)
→ {1,2,3}
array_cat ( anycompatiblearray, anycompatiblearray )
→ anycompatiblearray
连接两个数组 (等同于 anycompatiblearray || anycompatiblearray 操作符)。
array_cat(ARRAY[1,2,3], ARRAY[4,5])
→ {1,2,3,4,5}
array_dims ( anyarray )
→ text
返回数组维度的文本表示形式。
array_dims(ARRAY[[1,2,3], [4,5,6]])
→ [1:2][1:3]
array_fill ( anyelement, integer[]
[, integer[] ] )
→ anyarray
返回一个包含给定值的拷贝的数组，其维数与第二个参数指定的长度相同。
可选的第三个参数提供每个维度的下界值 (默认为全部为 1)。
array_fill(11, ARRAY[2,3])
→ {{11,11,11},{11,11,11}}
array_fill(7, ARRAY[3], ARRAY[2])
→ [2:4]={7,7,7}
array_length ( anyarray, integer )
→ integer
返回请求的数组维度的长度。
（对于空或缺失的数组维度，返回NULL而不是0。）
array_length(array[1,2,3], 1)
→ 3
array_length(array[]::int[], 1)
→ NULL
array_length(array['text'], 2)
→ NULL
array_lower ( anyarray, integer )
→ integer
返回请求的数组维度的下界。
array_lower('[0:2]={1,2,3}'::integer[], 1)
→ 0
array_ndims ( anyarray )
→ integer
返回数组的维度数。
array_ndims(ARRAY[[1,2,3], [4,5,6]])
→ 2
array_position ( anycompatiblearray, anycompatible [, integer ] )
→ integer
返回数组中第二个参数第一次出现的下标，如果它不存在，则返回NULL。
如果给出了第三个参数，则搜索从该下标开始。数组必须是一维的。
比较是使用IS NOT DISTINCT FROM语义进行的，所以可以搜索NULL。
array_position(ARRAY['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'], 'mon')
→ 2
array_positions ( anycompatiblearray, anycompatible )
→ integer[]
返回作为第一个参数的数组中第二个参数所有出现的下标的数组。
数组必须是一维的。使用IS NOT DISTINCT FROM语义完成比较，所以可以搜索NULL。
只有当数组为NULL时才返回NULL;如果在数组中没有找到该值，则返回空数组。
array_positions(ARRAY['A','A','B','A'], 'A')
→ {1,2,4}
array_prepend ( anycompatible, anycompatiblearray )
→ anycompatiblearray
在数组的开头添加一个元素（等同于anycompatible || anycompatiblearray操作符）。
array_prepend(1, ARRAY[2,3])
→ {1,2,3}
array_remove ( anycompatiblearray, anycompatible )
→ anycompatiblearray
从数组中移除与给定值相等的所有元素。数组必须是一维的。
使用IS NOT DISTINCT FROM语义完成比较，所以可以删除NULL。
array_remove(ARRAY[1,2,3,2], 2)
→ {1,3}
array_replace ( anycompatiblearray, anycompatible, anycompatible )
→ anycompatiblearray
将等于第二个参数的每个数组元素替换为第三个参数。
array_replace(ARRAY[1,2,5,4], 5, 3)
→ {1,2,3,4}
array_reverse ( anyarray )
→ anyarray
反转数组的第一维。
array_reverse(ARRAY[[1,2],[3,4],[5,6]])
→ {{5,6},{3,4},{1,2}}
array_sample ( array anyarray, n integer )
→ anyarray
返回一个包含n个从array中随机选取的项的数组。
n不能超过array第一维的长度。如果
array是多维数组，则“项”是具有给定第一个下标的切片。
array_sample(ARRAY[1,2,3,4,5,6], 3)
→ {2,6,1}
array_sample(ARRAY[[1,2],[3,4],[5,6]], 2)
→ {{5,6},{1,2}}
array_shuffle ( anyarray )
→ anyarray
随机打乱数组的第一维。
array_shuffle(ARRAY[[1,2],[3,4],[5,6]])
→ {{5,6},{1,2},{3,4}}
array_sort (
array anyarray
[, descending boolean
[, nulls_first boolean
]] )
→ anyarray
对数组的第一维进行排序。
排序顺序由数组元素类型的默认排序顺序决定；然而，
如果元素类型是可排序的，则可以通过在
array 参数中添加
COLLATE 子句来指定排序规则。
如果 descending 为 true，则按
降序排序，否则按升序排序。如果省略，则
默认为升序排序。
如果 nulls_first 为 true，则 NULL 值出现在
非 NULL 值之前，否则 NULL 值出现在非 NULL 值之后。
如果省略，nulls_first 被视为与
descending 相同的值。
array_sort(ARRAY[[2,4],[2,1],[6,5]])
→ {{2,1},{2,4},{6,5}}
array_to_string ( array anyarray, delimiter text [, null_string text ] )
→ text
将每个数组元素转换为其文本表示，并将它们用
delimiter 字符串分隔连接起来。
如果提供了 null_string 且不是
NULL，则 NULL 数组条目将用该字符串表示；否则，将被省略。
另请参见 string_to_array。
array_to_string(ARRAY[1, 2, 3, NULL, 5], ',', '*')
→ 1,2,3,*,5
array_upper ( anyarray, integer )
→ integer
返回请求的数组维度的上界。
array_upper(ARRAY[1,8,3,7], 1)
→ 4
cardinality ( anyarray )
→ integer
返回数组中元素的总数，如果数组为空则返回 0。
cardinality(ARRAY[[1,2],[3,4]])
→ 4
trim_array ( array anyarray, n integer )
→ anyarray
通过删除最后的 n 元素来裁剪数组。
如果数组是多维的，则只裁剪第一个维度。
trim_array(ARRAY[1,2,3,4,5,6], 2)
→ {1,2,3,4}
unnest ( anyarray )
→ setof anyelement
将数组展开到一组行。
数组的元素按存储顺序读出。
unnest(ARRAY[1,2])
→
1
2
unnest(ARRAY[['foo','bar'],['baz','quux']])
→
foo
bar
baz
quux
unnest ( anyarray, anyarray [, ... ] )
→ setof anyelement, anyelement [, ... ]
将多个数组（可能是不同的数据类型）展开到一组行中。
如果数组的长度不完全相同，那么较短的数组将用 NULL 填充。
这种形式只在查询的 FROM 子句中允许；参见 第 7.2.1.4 节。
select * from unnest(ARRAY[1,2], ARRAY['foo','bar','baz']) as x(a,b)
→
a |  b
---+-----
1 | foo
2 | bar
| baz
也可参见 第 9.21 节 了解用于数组的聚合函数 array_agg。
上一页 上一级 下一页9.18. 条件表达式 起始页 9.20. 范围/多范围函数和运算符
