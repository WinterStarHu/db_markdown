# J.3. 使用 Make 构建文档

J.3. 使用 Make 构建文档
版本：
纠错本页面
搜索
目录导航
❮
❯
J.3. 使用 Make 构建文档 #J.3.1. HTMLJ.3.2. 手册页J.3.3. PDFJ.3.4. 语法检查
一旦你把所有的东西都设置好，切换到doc/src/sgml目录，并运行下面小节中介绍的命令之一就可以编译文档（记住使用 GNU make）。
J.3.1. HTML #
要编译文档的HTML版本：
doc/src/sgml$ make html
这也是默认的目标。输出将出现在子目录html中。
要用postgresql.org所使用的样式表
而不是默认的简单样式生成 HTML 文档：
doc/src/sgml$ make STYLE=website html
如果使用STYLE=website选项，生成的 HTML 文件包括对托管在postgresql.org上的样式表的引用，需要网络访问来查看。
J.3.2. 手册页 #
我们使用 DocBook XSL 样式表来把DocBook
refentry页转换成适合于手册页的 *roff 输出。要创建手册页，使用命令：
doc/src/sgml$ make man
J.3.3. PDF #
要使用FOP产生文档的PDF版本，可以使用下列命令之一，取决于你喜欢的纸张格式：
A4格式：
doc/src/sgml$ make postgres-A4.pdf
美国信纸格式：
doc/src/sgml$ make postgres-US.pdf
因为PostgreSQL文档很大，FOP会要求可观的内存量。因此，在一些系统上，构建过程将会由于内存相关的错误而失败。通常可以通过在配置文件~/.foprc中配置Java的堆设置来解决这类问题，例如：
# FOP binary distribution
FOP_OPTS='-Xmx1500m'
# Debian
JAVA_ARGS='-Xmx1500m'
# Red Hat
ADDITIONAL_FLAGS='-Xmx1500m'
这是所要求的最小内存量，当然更多的内存会让编译过程更快一些。在内存非常小（小于1GB）的系统上，编译过程会因为磁盘交换而非常慢或者根本就不工作。
在默认配置中，FOP会为每一页发出一条
INFO消息。日志级别可以通过~/.foprc更改：
LOGCHOICE=-Dorg.apache.commons.logging.Log=​org.apache.commons.logging.impl.SimpleLog
LOGLEVEL=-Dorg.apache.commons.logging.simplelog.defaultlog=WARN
也可以手工使用其他XSL-FO处理器，但是自动构建过程仅支持FOP。
J.3.4. 语法检查 #
编译文档可能会花很长时间。但是有办法只检查文档中的语法，这个过程只需要数秒：
doc/src/sgml$ make check
上一页 上一级 下一页J.2. 工具集 起始页 J.4. 使用Meson构建文档
