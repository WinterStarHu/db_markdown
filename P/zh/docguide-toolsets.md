# J.2. 工具集

J.2. 工具集
版本：
纠错本页面
搜索
目录导航
❮
❯
J.2. 工具集 #J.2.1. 在 Fedora、RHEL 和衍生版上安装J.2.2. 在 FreeBSD 上安装J.2.3. Debian 包J.2.4. macOSJ.2.5. 通过configure检测
以下工具用于处理文档。一些工具可能是可选的，如注释所示。
DocBook DTD #
这是 DocBook 本身的定义。我们目前使用的是 4.5 版本；您不能使用更高或更低的版本。
您需要 DocBook DTD 的XML变体，而不是SGML变体。
DocBook XSL 样式表 #
这些包含将 DocBook 源文件转换为其他格式（例如HTML）的处理指令。
当前最低要求版本是 1.77.0，但建议使用最新可用版本以获得最佳效果。
Libxml2 用于 xmllint #
该库及其包含的xmllint工具用于处理 XML。许多开发者可能已经安装了
Libxml2，因为它在构建 PostgreSQL 代码时也会被使用。
但请注意，xmllint可能需要从一个单独的子包中安装。
Libxslt 用于 xsltproc #
xsltproc 是一个 XSLT 处理器，即使用 XSLT 样式表将 XML 转换为其他格式的程序。
FOP #
这是一个用于将 XML 转换为 PDF 等格式的程序。仅当您希望以 PDF 格式构建文档时才需要它。
我们已经在文档中记录了几种安装处理此文档所需的各种工具的方法。它们将在下文中描述。也可能有这些工具的其他打包发布。请向文档邮件列表报告这些包的状态，我们就会在这里包括它们的信息。
J.2.1. 在 Fedora、RHEL 和衍生版上安装 #
要安装所需的软件包，请使用:
yum install docbook-dtds docbook-style-xsl libxslt fop
J.2.2. 在 FreeBSD 上安装 #
要使用pkg安装所需的软件包，请执行:
pkg install docbook-xml docbook-xsl libxslt fop
在从doc目录构建文档时，你需要使用gmake，因为所提供的makefile不适合于FreeBSD的make。
J.2.3. Debian 包 #
有一整套文档工具的软件包可用于Debian GNU/Linux。
要安装，只需使用：
apt-get install docbook-xml docbook-xsl libxml2-utils xsltproc fop
J.2.4. macOS #
如果您使用MacPorts，以下步骤将帮助您设置好环境：
sudo port install docbook-xml docbook-xsl-nons libxslt fop
如果您使用Homebrew，请执行以下步骤：
brew install docbook docbook-xsl libxslt fop
Homebrew提供的程序需要设置以下环境变量。对于基于Intel的机器，请使用以下命令：
export XML_CATALOG_FILES=/usr/local/etc/xml/catalog
对于基于Apple Silicon的机器，请使用以下命令：
export XML_CATALOG_FILES=/opt/homebrew/etc/xml/catalog
没有设置这个环境变量，xsltproc会抛出类似以下错误：
I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
postgres.sgml:21: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
...
虽然可以使用苹果提供的xmllint和xsltproc版本，
而不是来自MacPorts或Homebrew的版本，但仍需要安装DocBook DTD和样式表，
并设置一个指向它们的目录文件。
J.2.5. 通过configure检测 #
在您能编译文档之前，您需要运行configure脚本，就像您在编译
PostgreSQL程序本身时所作的那样。
检查运行末尾附近的输出；它应该看起来像这样：
checking for xmllint... xmllint
checking for xsltproc... xsltproc
checking for fop... fop
checking for dbtoepub... dbtoepub
如果没有找到xmllint或xsltproc，您将不能构建任何文档。
fop仅在构建PDF格式的文档时需要。
dbtoepub仅在构建EPUB格式的文档时需要。
如果需要，您可以告诉configure在哪里找到这些程序，例如
./configure ... XMLLINT=/opt/local/bin/xmllint ...
如果您更喜欢使用PostgreSQL通过Meson构建，请按照
第 17.4 节中描述的运行meson setup，
然后参阅第 J.4 节。
上一页 上一级 下一页J.1. DocBook 起始页 J.3. 使用 Make 构建文档
