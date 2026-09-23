# 44.11. 环境变量

44.11. 环境变量
版本：
纠错本页面
搜索
目录导航
❮
❯
44.11. 环境变量 #
某些 Python 解释器接受的环境变量也能被用来影响 PL/Python 行为。它们需要在主 PostgreSQL 服务器进程的环境中设置，例如在一个启动脚本中设置。可用的环境变量取决于 Python 的版本，细节可见 Python 文档。在编写这份文档时，下面的环境变量可以对 PL/Python 产生影响（假定有一个合适的 Python 版本）：
PYTHONHOMEPYTHONPATHPYTHONY2KPYTHONOPTIMIZEPYTHONDEBUGPYTHONVERBOSEPYTHONCASEOKPYTHONDONTWRITEBYTECODEPYTHONIOENCODINGPYTHONUSERBASEPYTHONHASHSEED
（Python 的实现细节似乎超出了 PL/Python 的控制范围，某些列在python手册页上的环境变量只在命令行解释器中有效，但在嵌入式 Python 解释器中无效）。
上一页 上一级 下一页44.10. Python 2 vs. Python 3 起始页 第 45 章 服务器编程接口
