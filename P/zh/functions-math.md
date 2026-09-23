# 9.3. 数学函数和运算符

9.3. 数学函数和运算符
版本：
纠错本页面
搜索
目录导航
❮
❯
9.3. 数学函数和运算符 #
PostgreSQL为很多类型提供了数学操作符。对于那些没有标准数学表达的类型（如日期/时间类型），我们将在后续小节中描述实际的行为。
表 9.4 显示了可用于标准数字类型的数学操作符。除非另有说明，显示为可接受 numeric_type 的操作符对所有的 smallint、integer、bigint、numeric、real 和 double precision 类型都可用。显示为可接受 integral_type 的操作符对 smallint、integer 和 bigint 类型是可用的。除了特别说明之处，操作符的每种形式都返回与其参数相同的数据类型。涉及多个参数数据类型的调用，例如 integer + numeric，可通过使用这些列表中稍后出现的类型来解析。
表 9.4. 数学运算符
操作符
描述
示例
numeric_type + numeric_type
→ numeric_type
加法
2 + 3
→ 5
+ numeric_type
→ numeric_type
一元加（无操作）
+ 3.5
→ 3.5
numeric_type - numeric_type
→ numeric_type
减法
2 - 3
→ -1
- numeric_type
→ numeric_type
取反
- (-4)
→ 4
numeric_type * numeric_type
→ numeric_type
乘法
2 * 3
→ 6
numeric_type / numeric_type
→ numeric_type
除法（对于整型，除法将结果截断为零）
5.0 / 2
→ 2.5000000000000000
5 / 2
→ 2
(-5) / 2
→ -2
numeric_type % numeric_type
→ numeric_type
取模（余数）；适用于 smallint、integer、bigint 和 numeric
5 % 4
→ 1
numeric ^ numeric
→ numeric
double precision ^ double precision
→ double precision
指数运算
2 ^ 3
→ 8
不像典型的数学实践，多次使用 ^ 将会默认从左到右关联:
2 ^ 3 ^ 3
→ 512
2 ^ (3 ^ 3)
→ 134217728
|/ double precision
→ double precision
平方根
|/ 25.0
→ 5
||/ double precision
→ double precision
立方根
||/ 64.0
→ 4
@ numeric_type
→ numeric_type
绝对值
@ -5.0
→ 5.0
integral_type & integral_type
→ integral_type
按位与 (AND)
91 & 15
→ 11
integral_type | integral_type
→ integral_type
按位或 (OR)
32 | 3
→ 35
integral_type # integral_type
→ integral_type
按位异或 (exclusive OR)
17 # 5
→ 20
~ integral_type
→ integral_type
按位求反 (NOT)
~1
→ -2
integral_type << integer
→ integral_type
按位左移
1 << 4
→ 16
integral_type >> integer
→ integral_type
按位右移
8 >> 2
→ 2
表 9.5 显示了可用的数学函数。
许多这样的函数以多种具有不同的参数类型的形式提供。
除非注明，任何给定形式的函数都返回与其参数相同的数据类型；跨类型情况的解决方法与上述对操作符的解释相同。
使用double precision数据的函数大多是在主机系统的C库上实现的；
因此，边界情况下的准确性和行为会因主机系统的区别而不同。
表 9.5. 数学函数
函数
描述
示例
abs ( numeric_type )
→ numeric_type
绝对值
abs(-17.4)
→ 17.4
cbrt ( double precision )
→ double precision
立方根
cbrt(64.0)
→ 4
ceil ( numeric )
→ numeric
ceil ( double precision )
→ double precision
大于或等于参数的最接近的整数
ceil(42.2)
→ 43
ceil(-42.8)
→ -42
ceiling ( numeric )
→ numeric
ceiling ( double precision )
→ double precision
大于或等于参数的最接近的整数 (与 ceil 相同)
ceiling(95.3)
→ 96
degrees ( double precision )
→ double precision
将弧度转换为角度
degrees(0.5)
→ 28.64788975654116
div ( y numeric,
x numeric )
→ numeric
y/x 的整数商（截断为零）
div(9, 4)
→ 2
erf ( double precision )
→ double precision
误差函数
erf(1.0)
→ 0.8427007929497149
erfc ( double precision )
→ double precision
互补误差函数 (1 - erf(x), 对于较大输入无精度损失)
erfc(1.0)
→ 0.15729920705028513
exp ( numeric )
→ numeric
exp ( double precision )
→ double precision
指数 (e 的给定次方)
exp(1.0)
→ 2.7182818284590452
factorial ( bigint )
→ numeric
阶乘
factorial(5)
→ 120
floor ( numeric )
→ numeric
floor ( double precision )
→ double precision
小于或等于参数的最接近整数
floor(42.8)
→ 42
floor(-42.8)
→ -43
gamma ( double precision )
→ double precision
Gamma 函数
gamma(0.5)
→ 1.772453850905516
gamma(6)
→ 120
gcd ( numeric_type, numeric_type )
→ numeric_type
最大公约数 (能将两个输入数整除而无余数的最大正数); 如果两个输入为零则返回 0; 适用于 integer, bigint, 和 numeric
gcd(1071, 462)
→ 21
lcm ( numeric_type, numeric_type )
→ numeric_type
最小公倍数 (两个输入的整数倍的最小的严格正数); 如果任意一个输入值为零则返回 0; 适用于 integer, bigint, 和 numeric
lcm(1071, 462)
→ 23562
lgamma ( double precision )
→ double precision
Gamma 函数绝对值的自然对数
lgamma(1000)
→ 5905.220423209181
ln ( numeric )
→ numeric
ln ( double precision )
→ double precision
自然对数
ln(2.0)
→ 0.6931471805599453
log ( numeric )
→ numeric
log ( double precision )
→ double precision
以10为底的对数
log(100)
→ 2
log10 ( numeric )
→ numeric
log10 ( double precision )
→ double precision
以10为底的对数 (与 log 相同)
log10(1000)
→ 3
log ( b numeric,
x numeric )
→ numeric
以b为底对参数x取对数
log(2.0, 64.0)
→ 6.0000000000000000
min_scale ( numeric )
→ integer
精确表示所提供值所需的最小刻度（小数位数）
min_scale(8.4100)
→ 2
mod ( y numeric_type,
x numeric_type )
→ numeric_type
y/x的余数；
适用于smallint、integer、bigint和numeric
mod(9, 4)
→ 1
pi (  )
→ double precision
π的近似值
pi()
→ 3.141592653589793
power ( a numeric,
b numeric )
→ numeric
power ( a double precision,
b double precision )
→ double precision
a的b次幂
power(9, 3)
→ 729
radians ( double precision )
→ double precision
将角度转换为弧度
radians(45.0)
→ 0.7853981633974483
round ( numeric )
→ numeric
round ( double precision )
→ double precision
四舍五入到最近的整数。对于numeric，通过从零舍入来截断平局。
对于double precision，平局解决行为取决于平台，但“round to nearest even”是最常见的规则。
round(42.4)
→ 42
round ( v numeric, s integer )
→ numeric
将 v 四舍五入到 s 位小数。
当出现平局时，通过远离零的方向进行四舍五入来解决。
round(42.4382, 2)
→ 42.44
round(1234.56, -1)
→ 1230
scale ( numeric )
→ integer
参数的刻度（小数部分的位数）
scale(8.4100)
→ 4
sign ( numeric )
→ numeric
sign ( double precision )
→ double precision
参数的符号 (-1, 0, 或 +1)
sign(-8.4)
→ -1
sqrt ( numeric )
→ numeric
sqrt ( double precision )
→ double precision
平方根
sqrt(2)
→ 1.4142135623730951
trim_scale ( numeric )
→ numeric
通过删除尾数部分的零来降低值的刻度（小数位数）
trim_scale(8.4100)
→ 8.41
trunc ( numeric )
→ numeric
trunc ( double precision )
→ double precision
截断为整数（向零靠近）
trunc(42.8)
→ 42
trunc(-42.8)
→ -42
trunc ( v numeric, s integer )
→ numeric
截断 v 到 s 位小数
trunc(42.4382, 2)
→ 42.43
width_bucket ( operand numeric, low numeric, high numeric, count integer )
→ integer
width_bucket ( operand double precision, low double precision, high double precision, count integer )
→ integer
返回在具有 count 个等宽桶的直方图中
operand 所在的桶的编号，桶的范围为
low 到 high。
桶的下界是包含的，上界是排除的。
对于小于 low 的输入，返回 0，
对于大于或等于 high 的输入，返回
count+1。
如果 low > high，
行为将会反转，桶 1 现在是位于
low 之下的桶，包含的边界现在位于上侧。
width_bucket(5.35, 0.024, 10.06, 5)
→ 3
width_bucket(9, 10, 0, 10)
→ 2
width_bucket ( operand anycompatible, thresholds anycompatiblearray )
→ integer
返回在给定包含桶的下界的数组中
operand 所在的桶的编号。
对于小于第一个下界的输入，返回 0。
operand 和数组元素可以是
任何具有标准比较运算符的类型。
thresholds 数组 必须排序，
从小到大，否则将会得到意外的结果。
width_bucket(now(), array['yesterday', 'today', 'tomorrow']::timestamptz[])
→ 2
表 9.6 显示用于生成随机数的函数。
表 9.6. 随机函数
函数
描述
示例
random ( )
→ double precision
返回一个范围 0.0 <= x < 1.0 中的随机值
random()
→ 0.897124072839091
random ( min integer, max integer )
→ integer
random ( min bigint, max bigint )
→ bigint
random ( min numeric, max numeric )
→ numeric
返回一个范围内的随机值
min <= x <= max。
对于类型 numeric，结果将具有与
min 或 max 中较大者相同的小数位数。
random(1, 10)
→ 7
random(-0.499, 0.499)
→ 0.347
random_normal (
[ mean double precision
[, stddev double precision ]] )
→ double precision
返回一个来自正态分布的随机值，使用给定的参数；
mean 默认为 0.0，
stddev 默认为 1.0
random_normal(0.0, 1.0)
→ 0.051285419
setseed ( double precision )
→ void
设置后续random()和random_normal()调用的种子；
参数必须在-1.0到1.0之间（包括边界值）
setseed(0.12345)
random() 和 random_normal()
函数在 表 9.6 中列出，使用确定性伪随机数生成器。
它速度快，但不适用于加密应用；
有关更安全的替代方案，请参见 pgcrypto 模块。
如果调用了 setseed()，则可以通过在当前会话中以相同参数
重新调用 setseed() 来重现后续对这些函数的调用序列。
在同一会话中没有任何先前的 setseed() 调用时，
第一次调用这些函数中的任意一个将从平台相关的随机位来源获取种子。
表 9.7 显示了可用的三角函数。
每一种这样的函数都有两个变体，一个以弧度度量角，另一个以角度度量角。
表 9.7. 三角函数
函数
描述
示例
acos ( double precision )
→ double precision
反余弦，结果为弧度
acos(1)
→ 0
acosd ( double precision )
→ double precision
反余弦，结果为度数
acosd(0.5)
→ 60
asin ( double precision )
→ double precision
反正弦，结果为弧度
asin(1)
→ 1.5707963267948966
asind ( double precision )
→ double precision
反正弦，结果为度数
asind(0.5)
→ 30
atan ( double precision )
→ double precision
反正切，结果为弧度
atan(1)
→ 0.7853981633974483
atand ( double precision )
→ double precision
反正切，结果为度数
atand(1)
→ 45
atan2 ( y double precision,
x double precision )
→ double precision
y/x的反正切，结果为弧度
atan2(1, 0)
→ 1.5707963267948966
atan2d ( y double precision,
x double precision )
→ double precision
y/x的反正切，结果为度数
atan2d(1, 0)
→ 90
cos ( double precision )
→ double precision
余弦，参数为弧度
cos(0)
→ 1
cosd ( double precision )
→ double precision
余弦，参数为度数
cosd(60)
→ 0.5
cot ( double precision )
→ double precision
余切，参数为弧度
cot(0.5)
→ 1.830487721712452
cotd ( double precision )
→ double precision
余切，参数为度数
cotd(45)
→ 1
sin ( double precision )
→ double precision
正弦，参数为弧度
sin(1)
→ 0.8414709848078965
sind ( double precision )
→ double precision
正弦，参数为度数
sind(30)
→ 0.5
tan ( double precision )
→ double precision
正切，参数为弧度
tan(1)
→ 1.5574077246549023
tand ( double precision )
→ double precision
正切，参数为度数
tand(45)
→ 1
注意
另一种使用以角度度量的角的方法是使用早前展示的单位转换函数radians()和degrees()。不过，使用基于角度的三角函数更好，因为这类方法能避免sind(30)等特殊情况下的舍入偏差。
表 9.8显示的是可用的双曲函数。
表 9.8. 双曲函数
函数
描述
示例
sinh ( double precision )
→ double precision
双曲正弦
sinh(1)
→ 1.1752011936438014
cosh ( double precision )
→ double precision
双曲余弦
cosh(0)
→ 1
tanh ( double precision )
→ double precision
双曲切线
tanh(1)
→ 0.7615941559557649
asinh ( double precision )
→ double precision
反双曲正弦
asinh(1)
→ 0.881373587019543
acosh ( double precision )
→ double precision
反双曲余弦
acosh(1)
→ 0
atanh ( double precision )
→ double precision
反双曲切线
atanh(0.5)
→ 0.5493061443340548
上一页 上一级 下一页9.2. 比较函数和操作符 起始页 9.4. 字符串函数和操作符
