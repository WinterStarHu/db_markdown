# 9.11. 几何函数和操作符

9.11. 几何函数和操作符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.11. 几何函数和操作符 #
几何类型point、box、
lseg、line、path、
polygon和circle有一大堆本地支持函数和操作符，如表 9.36、表 9.37和表 9.38中所示。
表 9.36. 几何操作符
操作符
描述
示例
geometric_type + point
→ geometric_type
将第二个point的坐标添加到第一个参数的每个点的坐标中，从而执行平移。
适用于 point、box、path、circle。
box '(1,1),(0,0)' + point '(2,0)'
→ (3,1),(2,0)
path + path
→ path
连接两个开放路径（如果其中一个路径是关闭的，则返回NULL）。
path '[(0,0),(1,1)]' + path '[(2,2),(3,3),(4,4)]'
→ [(0,0),(1,1),(2,2),(3,3),(4,4)]
geometric_type - point
→ geometric_type
从第一个参数的每个点的坐标中减去第二个point的坐标，从而执行平移。
适用于 point、 box、 path、circle。
box '(1,1),(0,0)' - point '(2,0)'
→ (-1,1),(-2,0)
geometric_type * point
→ geometric_type
将第一个参数的每个点乘上第二个point（将点视为由实部和虚部表示的复数，并执行标准的复数乘法）。如果将第二个point解释为向量，这等价于将对象的大小和到原点的距离按向量的长度缩放，并以向量与x轴的夹角绕原点逆时针旋转。
适用于point、box、[a]
path、circle。
path '((0,0),(1,0),(1,1))' * point '(3.0,0)'
→ ((0,0),(3,0),(3,3))
path '((0,0),(1,0),(1,1))' * point(cosd(45), sind(45))
→ ((0,0),​(0.7071067811865475,0.7071067811865475),​(0,1.414213562373095))
geometric_type / point
→ geometric_type
将第一个参数的每个点除以第二个point（将点视为由实部和虚部表示的复数，并执行标准的复数除法）。如果将第二个point解释为向量，这等价于将物体的大小和到原点的距离按向量的长度向下缩放，并以向量与x轴的夹角围绕原点顺时针旋转。
适用于 point、 box、[a] path、circle。
path '((0,0),(1,0),(1,1))' / point '(2.0,0)'
→ ((0,0),(0.5,0),(0.5,0.5))
path '((0,0),(1,0),(1,1))' / point(cosd(45), sind(45))
→ ((0,0),​(0.7071067811865476,-0.7071067811865476),​(1.4142135623730951,0))
@-@ geometric_type
→ double precision
计算总长度。
适用于 lseg, path。
@-@ path '[(0,0),(1,0),(1,1)]'
→ 2
@@ geometric_type
→ point
计算中心点。
适用于 box, lseg,
polygon, circle。
@@ box '(2,2),(0,0)'
→ (1,1)
# geometric_type
→ integer
返回点的数量。
适用于 path, polygon。
# path '((1,0),(0,1),(-1,0))'
→ 3
geometric_type # geometric_type
→ point
计算交点，如果没有则为NULL。
适用于 lseg, line。
lseg '[(0,0),(1,1)]' # lseg '[(1,0),(0,1)]'
→ (0.5,0.5)
box # box
→ box
计算两个方框的交集，如果没有则为NULL。
box '(2,2),(-1,-1)' # box '(1,1),(-2,-2)'
→ (1,1),(-1,-1)
geometric_type ## geometric_type
→ point
计算第一个对象上距离第二个对象最近的点。
可用于以下类型的配对：
(point, box),
(point, lseg),
(point, line),
(lseg, box),
(lseg, lseg),
(line, lseg).
point '(0,0)' ## lseg '[(2,0),(0,2)]'
→ (1,1)
geometric_type <-> geometric_type
→ double precision
计算对象之间的距离。
对于所有七种几何类型，所有 point 与另一种几何类型的组合，
以及以下这些额外的类型对：
(box, lseg),
(lseg, line),
(polygon, circle)
（以及交换位置的情况）。
circle '<(0,0),1>' <-> circle '<(5,0),1>'
→ 3
geometric_type @> geometric_type
→ boolean
第一个对象包含第二个对象吗？
适用于这些类型对：
(box, point),
(box, box),
(path, point),
(polygon, point),
(polygon, polygon),
(circle, point),
(circle, circle).
circle '<(0,0),2>' @> point '(1,1)'
→ t
geometric_type <@ geometric_type
→ boolean
第一个对象包含在第二个对象之中还是在第二个对象之上？适用于这些类型对：
(point, box),
(point, lseg),
(point, line),
(point, path),
(point, polygon),
(point, circle),
(box, box),
(lseg, box),
(lseg, line),
(polygon, polygon),
(circle, circle).
point '(1,1)' <@ circle '<(0,0),2>'
→ t
geometric_type && geometric_type
→ boolean
这些对象有重叠吗？（一个共同点使之为真。）
适用于 box、polygon、circle。
box '(1,1),(0,0)' && box '(2,2),(0,0)'
→ t
geometric_type << geometric_type
→ boolean
第一个对象完全位于第二个对象的左边吗？
适用于 point、box、polygon、circle。
circle '<(0,0),1>' << circle '<(5,0),1>'
→ t
geometric_type >> geometric_type
→ boolean
第一个对象完全位于第二个对象的右边吗？
适用于 point、box、polygon、circle。
circle '<(5,0),1>' >> circle '<(0,0),1>'
→ t
geometric_type &< geometric_type
→ boolean
第一个对象没有延伸到第二个对象的右侧吗？
适用于 box、polygon、circle。
box '(1,1),(0,0)' &< box '(2,2),(0,0)'
→ t
geometric_type &> geometric_type
→ boolean
第一个对象没有延伸到第二个对象的左侧吗？
适用于 box、polygon、circle。
box '(3,3),(0,0)' &> box '(2,2),(0,0)'
→ t
geometric_type <<| geometric_type
→ boolean
第一个对象是否确定位于第二个对象下面？
适用于 point、box、polygon、circle。
box '(3,3),(0,0)' <<| box '(5,5),(3,4)'
→ t
geometric_type |>> geometric_type
→ boolean
第一个对象是否确定位于第二个对象上面？
适用于 point、box、polygon、circle。
box '(5,5),(3,4)' |>> box '(3,3),(0,0)'
→ t
geometric_type &<| geometric_type
→ boolean
第一个对象是否没有扩展到第二个对象上面?
适用于 box, polygon,
circle。
box '(1,1),(0,0)' &<| box '(2,2),(0,0)'
→ t
geometric_type |&> geometric_type
→ boolean
第一个对象是否没有扩展到第二个对象下面?
适用于 box, polygon,
circle。
box '(3,3),(0,0)' |&> box '(2,2),(0,0)'
→ t
box <^ box
→ boolean
第一个对象是否位于第二个对象下面(允许边缘相切)?
box '((1,1),(0,0))' <^ box '((2,2),(1,1))'
→ t
box >^ box
→ boolean
第一个对象是否位于第二个对象上面(允许边缘相切)?
box '((2,2),(1,1))' >^ box '((1,1),(0,0))'
→ t
geometric_type ?# geometric_type
→ boolean
这些对象是否相交?
适用于这些类型对:
(box, box),
(lseg, box),
(lseg, lseg),
(lseg, line),
(line, box),
(line, line),
(path, path)。
lseg '[(-1,0),(1,0)]' ?# box '(2,2),(-2,-2)'
→ t
?- line
→ boolean
?- lseg
→ boolean
线是水平的吗?
?- lseg '[(-1,0),(1,0)]'
→ t
point ?- point
→ boolean
点是否水平对齐(即具有相同的y坐标)?
point '(1,0)' ?- point '(0,0)'
→ t
?| line
→ boolean
?| lseg
→ boolean
线是纵向的吗?
?| lseg '[(-1,0),(1,0)]'
→ f
point ?| point
→ boolean
点是否垂直对齐（即具有相同的x坐标）?
point '(0,1)' ?| point '(0,0)'
→ t
line ?-| line
→ boolean
lseg ?-| lseg
→ boolean
线是否垂直?
lseg '[(0,0),(0,1)]' ?-| lseg '[(0,0),(1,0)]'
→ t
line ?|| line
→ boolean
lseg ?|| lseg
→ boolean
线是否平行?
lseg '[(-1,0),(1,0)]' ?|| lseg '[(-1,2),(1,2)]'
→ t
geometric_type ~= geometric_type
→ boolean
这些对象是相同的吗?
适用于 point、 box、
polygon、 circle。
polygon '((0,0),(1,1))' ~= polygon '((1,1),(0,0))'
→ t
[a] “旋转”一个盒子用这些操作符只会移动它的角点：这个盒子仍然被认为有平行于轴的边。因此，盒子的大小并没有像真正的旋转那样得到保留。小心
请注意“same as”操作符（~=），表示point、box、polygon和circle类型的一般相等概念。
这些类型中的某些还有一个=操作符，但是=只比较相同的面积。
其他的标量比较操作符（<=等等），在这些类型可用的地方，同样比较面积。
注意
在PostgreSQL 14之前， 该点严格低于/高于比较操作符 point <<| point 和 point |>> point 分别被称为 <^ 和 >^。
这些名字仍然可以使用，但是已被弃用并且最终将被移除。
表 9.37. 几何函数
函数
描述
示例
area ( geometric_type )
→ double precision
计算面积。适用于 box, path, circle。
path 输入必须封闭，否则返回 NULL。同样，如果 path 是自交叉的，结果可能是没有意义的。
area(box '(2,2),(0,0)')
→ 4
center ( geometric_type )
→ point
计算中心点。适用于 box, circle。
center(box '(1,2),(0,0)')
→ (0.5,1)
diagonal ( box )
→ lseg
提取框的对角线作为线段（与 lseg(box) 相同）。
diagonal(box '(1,2),(0,0)')
→ [(1,2),(0,0)]
diameter ( circle )
→ double precision
计算圆的直径。
diameter(circle '<(0,0),2>')
→ 4
height ( box )
→ double precision
计算框的垂直尺寸。
height(box '(1,2),(0,0)')
→ 2
isclosed ( path )
→ boolean
路径是否封闭?
isclosed(path '((0,0),(1,1),(2,0))')
→ t
isopen ( path )
→ boolean
路径是否开放?
isopen(path '[(0,0),(1,1),(2,0)]')
→ t
length ( geometric_type )
→ double precision
计算总长度。适用于 lseg, path。
length(path '((-1,0),(1,0))')
→ 4
npoints ( geometric_type )
→ integer
返回点的数量。适用于 path、polygon。
npoints(path '[(0,0),(1,1),(2,0)]')
→ 3
pclose ( path )
→ path
将路径转换为封闭形式。
pclose(path '[(0,0),(1,1),(2,0)]')
→ ((0,0),(1,1),(2,0))
popen ( path )
→ path
将路径转换为开放形式。
popen(path '((0,0),(1,1),(2,0))')
→ [(0,0),(1,1),(2,0)]
radius ( circle )
→ double precision
计算圆的半径。
radius(circle '<(0,0),2>')
→ 2
slope ( point, point )
→ double precision
计算通过两点所画直线的斜率。
slope(point '(0,0)', point '(2,1)')
→ 0.5
width ( box )
→ double precision
计算框的水平大小。
width(box '(1,2),(0,0)')
→ 1
表 9.38. 几何类型转换函数
函数
描述
例子
box ( circle )
→ box
计算内切于圆形的框。
box(circle '<(0,0),2>')
→ (1.414213562373095,1.414213562373095),​(-1.414213562373095,-1.414213562373095)
box ( point )
→ box
将点转换为空框。
box(point '(1,0)')
→ (1,0),(1,0)
box ( point, point )
→ box
将任意两个角点转换为框。
box(point '(0,1)', point '(1,0)')
→ (1,1),(0,0)
box ( polygon )
→ box
计算多边形的边界框。
box(polygon '((0,0),(1,1),(2,0))')
→ (2,1),(0,0)
bound_box ( box, box )
→ box
计算两个框的边界框。
bound_box(box '(1,1),(0,0)', box '(4,4),(3,3)')
→ (4,4),(0,0)
circle ( box )
→ circle
计算包围框的最小圆形。
circle(box '(1,1),(0,0)')
→ <(0.5,0.5),0.7071067811865476>
circle ( point, double precision )
→ circle
从圆心和半径构造圆。
circle(point '(0,0)', 2.0)
→ <(0,0),2>
circle ( polygon )
→ circle
将多边形转换为圆。圆心是多边形各点位置的平均值，半径是多边形各点到圆心的平均距离。
circle(polygon '((0,0),(1,3),(2,0))')
→ <(1,1),1.6094757082487299>
line ( point, point )
→ line
将两个点转换成通过它们的直线。
line(point '(-1,0)', point '(1,0)')
→ {0,-1,0}
lseg ( box )
→ lseg
提取框的对角线作为线段。
lseg(box '(1,0),(-1,0)')
→ [(1,0),(-1,0)]
lseg ( point, point )
→ lseg
从两个端点构造线段。
lseg(point '(-1,0)', point '(1,0)')
→ [(-1,0),(1,0)]
path ( polygon )
→ path
将多边形转换为具有相同点列表的封闭路径。
path(polygon '((0,0),(1,1),(2,0))')
→ ((0,0),(1,1),(2,0))
point ( double precision, double precision )
→ point
从它的坐标构造点。
point(23.4, -44.5)
→ (23.4,-44.5)
point ( box )
→ point
计算框的中心。
point(box '(1,0),(-1,0)')
→ (0,0)
point ( circle )
→ point
计算圆心。
point(circle '<(0,0),2>')
→ (0,0)
point ( lseg )
→ point
计算线段的中心。
point(lseg '[(-1,0),(1,0)]')
→ (0,0)
point ( polygon )
→ point
计算多边形的中心（多边形的点位置的平均值）。
point(polygon '((0,0),(1,1),(2,0))')
→ (1,0.3333333333333333)
polygon ( box )
→ polygon
将框转换为4点多边形。
polygon(box '(1,1),(0,0)')
→ ((0,0),(0,1),(1,1),(1,0))
polygon ( circle )
→ polygon
将圆转换为12点多边形。
polygon(circle '<(0,0),2>')
→ ((-2,0),​(-1.7320508075688774,0.9999999999999999),​(-1.0000000000000002,1.7320508075688772),​(-1.2246063538223773e-16,2),​(0.9999999999999996,1.7320508075688774),​(1.732050807568877,1.0000000000000007),​(2,2.4492127076447545e-16),​(1.7320508075688776,-0.9999999999999994),​(1.0000000000000009,-1.7320508075688767),​(3.673819061467132e-16,-2),​(-0.9999999999999987,-1.732050807568878),​(-1.7320508075688767,-1.0000000000000009))
polygon ( integer, circle )
→ polygon
将圆转换为n点多边形。
polygon(4, circle '<(3,0),1>')
→ ((2,0),​(3,1),​(4,1.2246063538223773e-16),​(3,-1))
polygon ( path )
→ polygon
将封闭路径转换为具有相同点列表的多边形。
polygon(path '((0,0),(1,1),(2,0))')
→ ((0,0),(1,1),(2,0))
我们可以把一个point的两个组成数字当作具有索引 0 和 1 的数组访问。例如，如果t.p是一个point列，那么SELECT p[0] FROM t检索 X 座标而 UPDATE t SET p[1] = ...改变 Y 座标。同样，box或者lseg类型的值可以当作两个point值的数组看待。
上一页 上一级 下一页9.10. 枚举支持函数 起始页 9.12. 网络地址函数和操作符
