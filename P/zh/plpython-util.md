# 44.9. 实用函数

44.9. 实用函数
版本：
纠错本页面
搜索
目录导航
❮
❯
44.9. 实用函数 #
plpy模块也提供了函数
plpy.debug(msg, **kwargs)plpy.log(msg, **kwargs)plpy.info(msg, **kwargs)plpy.notice(msg, **kwargs)plpy.warning(msg, **kwargs)plpy.error(msg, **kwargs)plpy.fatal(msg, **kwargs)
plpy.error和plpy.fatal实际上会产生一个 Python 异常（如果未被捕捉），它会被传播到调用查询中，导致当前事务或子事务被中止。raise plpy.Error(msg)和raise plpy.Fatal(msg)分别等效于调用plpy.error(msg)和plpy.fatal(msg)，不过raise形式不允许传递关键词参数。其他函数只生成不同优先级的消息。一个特定优先级的消息是被报告给客户端、写入服务器日志还是两者都做，由log_min_messages和client_min_messages配置变量控制。详见第 19 章。
msg参数被给定位一个位置参数。为了向后兼容，可以给出多于一个位置参数。在那种情况下，位置参数形成的元组的字符串表达将会变成报告给客户端的消息。
下列关键字参数被接受：
detailhintsqlstateschema_nametable_namecolumn_namedatatype_nameconstraint_name
作为关键字参数传递的对象的字符串表示用于丰富向客户端报告的消息。例如：
CREATE FUNCTION raise_custom_exception() RETURNS void AS $$
plpy.error("custom exception message",
detail="some info about exception",
hint="hint for users")
$$ LANGUAGE plpython3u;
=# SELECT raise_custom_exception();
ERROR:  plpy.Error: custom exception message
DETAIL:  some info about exception
HINT:  hint for users
CONTEXT:  Traceback (most recent call last):
PL/Python function "raise_custom_exception", line 4, in <module>
hint="hint for users")
PL/Python function "raise_custom_exception"
另一组工具函数是plpy.quote_literal(string)、plpy.quote_nullable(string)以及plpy.quote_ident(string)。它们等效于第 9.4 节中描述的内建引用函数。在构建临时查询时它们能派上用场。例 41.1中动态 SQL 的 PL/Python 等效体是：
plpy.execute("UPDATE tbl SET %s = %s WHERE key = %s" % (
plpy.quote_ident(colname),
plpy.quote_nullable(newvalue),
plpy.quote_literal(keyvalue)))
上一页 上一级 下一页44.8. 事务管理 起始页 44.10. Python 2 vs. Python 3
