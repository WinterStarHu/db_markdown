# 41.13. 从Oracle PL/SQL 移植

41.13. 从Oracle PL/SQL 移植
版本：
纠错本页面
搜索
目录导航
❮
❯
41.13. 从Oracle PL/SQL 移植 #41.13.1. 移植示例41.13.2. 其他要关注的事项41.13.3. 附录
这一节解释了PostgreSQL的PL/pgSQL语言和 Oracle 的PL/SQL语言之间的差别，用以帮助那些从Oracle®向PostgreSQL移植应用的人。
PL/pgSQL与 PL/SQL 在许多方面都非常类似。它是一种块结构的、命令式的语言并且所有变量必须先被声明。赋值、循环和条件则很类似。在从PL/SQL向PL/pgSQL移植时必须记住一些事情：
如果一个 SQL 命令中使用的名字可能是一个表的列名或者是对一个函数中变量的引用，那么PL/SQL会将它当作一个列名。默认情况下， PL/pgSQL会抛出名称模糊的错误， 你可以指定plpgsql.variable_conflict=use_column来改变这一行为以匹配PL/SQL。如第 41.11.1 节中所述。通常最好是首先避免这种歧义，但如果不得不移植依赖于该行为的大量代码，那么设置variable_conflict将是最好的方案。
在PostgreSQL中，函数体必须写成字符串文本。因此你需要使用美元符引用或者转义函数体中的单引号（见第 41.12.1 节）。
数据类型名称常常需要翻译。例如，在 Oracle 中字符串值通常被声明为类型varchar2，这并非 SQL 标准类型。在PostgreSQL中则要使用类型varchar或者text来替代。类似地，要把类型number替换成numeric，或者在适当的时候使用某种其他数字数据类型。
应该用模式把函数组织成不同的分组，而不是用包。
因为没有包，所以也没有包级别的变量。这一点有时候挺讨厌。你可以在临时表里保存会话级别的状态。
带有REVERSE的整数FOR循环的工作方式不同：PL/SQL中是从第二个数向第一个数倒数，而PL/pgSQL是从第一个数向第二个数倒数，因此在移植时需要交换循环边界。不幸的是这种不兼容性是不太可能改变的（见第 41.6.5.5 节）。
查询上的FOR循环（不是游标）的工作方式同样不同：目标变量必须已经被声明，而PL/SQL总是会隐式地声明它们。但是这样做的优点是在退出循环后，变量值仍然可以访问。
在使用游标变量方面，存在一些记法差异。
41.13.1. 移植示例 #
例 41.9展示了如何从PL/SQL移植一个简单的函数到PL/pgSQL中。
例 41.9. 从PL/SQL移植一个简单的函数到PL/pgSQL
这里有一个Oracle PL/SQL函数：
CREATE OR REPLACE FUNCTION cs_fmt_browser_version(v_name varchar2,
v_version varchar2)
RETURN varchar2 IS
BEGIN
IF v_version IS NULL THEN
RETURN v_name;
END IF;
RETURN v_name || '/' || v_version;
END;
/
show errors;
让我们过一遍这个函数并且看看与PL/pgSQL相比有什么样的不同：
类型名称varchar2被改成了varchar或者text。在这一节的例子中，我们将使用varchar，但如果不需要特定的字符串长度限制，text常常是更好的选择。
在函数原型中（不是函数体中）的RETURN关键字在PostgreSQL中变成了RETURNS。还有，IS变成了AS，并且你还需要增加一个LANGUAGE子句，因为PL/pgSQL并非唯一可用的函数语言。
在PostgreSQL中，函数体被认为是一个字符串，所以你需要使用引号或者美元符号包围它。这代替了Oracle 方法中的用于终止的/。
在PostgreSQL中没有show errors命令，并且也不需要这个命令，因为错误是自动报告的。
这个函数被移植到PostgreSQL后看起来会是这样：
CREATE OR REPLACE FUNCTION cs_fmt_browser_version(v_name varchar,
v_version varchar)
RETURNS varchar AS $$
BEGIN
IF v_version IS NULL THEN
RETURN v_name;
END IF;
RETURN v_name || '/' || v_version;
END;
$$ LANGUAGE plpgsql;
例 41.10展示了如何移植一个会创建另一个函数的函数，以及如何处理引号问题。
例 41.10. 从PL/SQL移植一个创建另一个函数的函数到PL/pgSQL
下面的过程从一个SELECT语句抓取行，并且为了效率而构建一个带有IF语句中结果的大型函数。
这是 Oracle 版本：
CREATE OR REPLACE PROCEDURE cs_update_referrer_type_proc IS
CURSOR referrer_keys IS
SELECT * FROM cs_referrer_keys
ORDER BY try_order;
func_cmd VARCHAR(4000);
BEGIN
func_cmd := 'CREATE OR REPLACE FUNCTION cs_find_referrer_type(v_host IN VARCHAR2,
v_domain IN VARCHAR2, v_url IN VARCHAR2) RETURN VARCHAR2 IS BEGIN';
FOR referrer_key IN referrer_keys LOOP
func_cmd := func_cmd ||
' IF v_' || referrer_key.kind
|| ' LIKE ''' || referrer_key.key_string
|| ''' THEN RETURN ''' || referrer_key.referrer_type
|| '''; END IF;';
END LOOP;
func_cmd := func_cmd || ' RETURN NULL; END;';
EXECUTE IMMEDIATE func_cmd;
END;
/
show errors;
这里是PostgreSQL的版本：
CREATE OR REPLACE PROCEDURE cs_update_referrer_type_proc() AS $func$
DECLARE
referrer_keys CURSOR IS
SELECT * FROM cs_referrer_keys
ORDER BY try_order;
func_body text;
func_cmd text;
BEGIN
func_body := 'BEGIN';
FOR referrer_key IN referrer_keys LOOP
func_body := func_body ||
' IF v_' || referrer_key.kind
|| ' LIKE ' || quote_literal(referrer_key.key_string)
|| ' THEN RETURN ' || quote_literal(referrer_key.referrer_type)
|| '; END IF;' ;
END LOOP;
func_body := func_body || ' RETURN NULL; END;';
func_cmd :=
'CREATE OR REPLACE FUNCTION cs_find_referrer_type(v_host varchar,
v_domain varchar,
v_url varchar)
RETURNS varchar AS '
|| quote_literal(func_body)
|| ' LANGUAGE plpgsql;' ;
EXECUTE func_cmd;
END;
$func$ LANGUAGE plpgsql;
请注意函数体是如何被单独构建并且通过quote_literal被传递以双写其中的任何引号。需要这个技术是因为无法安全地使用美元引用定义新函数：我们不确定从referrer_key.key_string域中来的什么字符串会被插入（我们这里假定referrer_key.kind可以确信总是为host、domain或者url，但是referrer_key.key_string可能是任何东西，特别是它可能包含美元符号）。这个函数实际上是在 Oracle 的原版上的改进，因为当referrer_key.key_string或者referrer_key.referrer_type包含引号时，它将不会生成坏掉的代码。
例 41.11展示了如何移植一个带有OUT参数和字符串处理的函数。PostgreSQL没有内建的instr函数，但是你可以用其他函数的组合来创建一个。在第 41.13.3 节中有一个instr的PL/pgSQL实现，你可以用它让你的移植变得更容易。
例 41.11. 从PL/SQL移植一个带有字符串操作以及OUT参数的过程到PL/pgSQL
下面的Oracle PL/SQL 过程被用来解析一个 URL 并返回一些元素（主机、路径和查询）。
这是 Oracle 版本：
CREATE OR REPLACE PROCEDURE cs_parse_url(
v_url IN VARCHAR2,
v_host OUT VARCHAR2,  -- 这将被传回去
v_path OUT VARCHAR2,  -- 这个也是
v_query OUT VARCHAR2) -- 还有这个
IS
a_pos1 INTEGER;
a_pos2 INTEGER;
BEGIN
v_host := NULL;
v_path := NULL;
v_query := NULL;
a_pos1 := instr(v_url, '//');
IF a_pos1 = 0 THEN
RETURN;
END IF;
a_pos2 := instr(v_url, '/', a_pos1 + 2);
IF a_pos2 = 0 THEN
v_host := substr(v_url, a_pos1 + 2);
v_path := '/';
RETURN;
END IF;
v_host := substr(v_url, a_pos1 + 2, a_pos2 - a_pos1 - 2);
a_pos1 := instr(v_url, '?', a_pos2 + 1);
IF a_pos1 = 0 THEN
v_path := substr(v_url, a_pos2);
RETURN;
END IF;
v_path := substr(v_url, a_pos2, a_pos1 - a_pos2);
v_query := substr(v_url, a_pos1 + 1);
END;
/
show errors;
这里是一种到PL/pgSQL的可能翻译：
CREATE OR REPLACE FUNCTION cs_parse_url(
v_url IN VARCHAR,
v_host OUT VARCHAR,  -- 这将被传递回去
v_path OUT VARCHAR,  -- 这个也是
v_query OUT VARCHAR) -- 以及这个
AS $$
DECLARE
a_pos1 INTEGER;
a_pos2 INTEGER;
BEGIN
v_host := NULL;
v_path := NULL;
v_query := NULL;
a_pos1 := instr(v_url, '//');
IF a_pos1 = 0 THEN
RETURN;
END IF;
a_pos2 := instr(v_url, '/', a_pos1 + 2);
IF a_pos2 = 0 THEN
v_host := substr(v_url, a_pos1 + 2);
v_path := '/';
RETURN;
END IF;
v_host := substr(v_url, a_pos1 + 2, a_pos2 - a_pos1 - 2);
a_pos1 := instr(v_url, '?', a_pos2 + 1);
IF a_pos1 = 0 THEN
v_path := substr(v_url, a_pos2);
RETURN;
END IF;
v_path := substr(v_url, a_pos2, a_pos1 - a_pos2);
v_query := substr(v_url, a_pos1 + 1);
END;
$$ LANGUAGE plpgsql;
这个函数可以这样使用：
SELECT * FROM cs_parse_url('http://foobar.com/query.cgi?baz');
例 41.12展示了如何移植一个使用了多种 Oracle 特性的过程。
例 41.12. 从PL/SQL移植一个过程到PL/pgSQL
Oracle 版本：
CREATE OR REPLACE PROCEDURE cs_create_job(v_job_id IN INTEGER) IS
a_running_job_count INTEGER;
BEGIN
LOCK TABLE cs_jobs IN EXCLUSIVE MODE;
SELECT count(*) INTO a_running_job_count FROM cs_jobs WHERE end_stamp IS NULL;
IF a_running_job_count > 0 THEN
COMMIT; -- 释放锁
raise_application_error(-20000,
'Unable to create a new job: a job is currently running.');
END IF;
DELETE FROM cs_active_job;
INSERT INTO cs_active_job(job_id) VALUES (v_job_id);
BEGIN
INSERT INTO cs_jobs (job_id, start_stamp) VALUES (v_job_id, now());
EXCEPTION
WHEN dup_val_on_index THEN NULL; -- 如果已经存在也不用担心
END;
COMMIT;
END;
/
show errors
这是我们如何将这个过程移植到PL/pgSQL：
CREATE OR REPLACE PROCEDURE cs_create_job(v_job_id integer) AS $$
DECLARE
a_running_job_count integer;
BEGIN
LOCK TABLE cs_jobs IN EXCLUSIVE MODE;
SELECT count(*) INTO a_running_job_count FROM cs_jobs WHERE end_stamp IS NULL;
IF a_running_job_count > 0 THEN
COMMIT; -- 释放锁
RAISE EXCEPTION 'Unable to create a new job: a job is currently running'; -- (1)
END IF;
DELETE FROM cs_active_job;
INSERT INTO cs_active_job(job_id) VALUES (v_job_id);
BEGIN
INSERT INTO cs_jobs (job_id, start_stamp) VALUES (v_job_id, now());
EXCEPTION
WHEN unique_violation THEN -- (2)
-- 如果已经存在也不用担心
END;
COMMIT;
END;
$$ LANGUAGE plpgsql;
(1)
RAISE的语法与 Oracle 的语句相当不同，尽管基本的形式RAISE exception_name工作起来是相似的。
(2)
PL/pgSQL所支持的异常名称不同于 Oracle。内建的异常名称集合要更大（见附录 A）。目前没有办法声明用户定义的异常名称，尽管你能够抛出用户选择的 SQLSTATE 值。
41.13.2. 其他要关注的事项 #
这一节解释了在移植 Oracle PL/SQL函数到PostgreSQL中时要关注的一些其他问题。
41.13.2.1. 异常后隐式回滚 #
在PL/pgSQL，当一个异常被EXCEPTION子句捕获之后，从该块的BEGIN以来的所有数据库改变都会被自动回滚。也就是，该行为等效于你在 Oracle 中用下面的代码得到的效果：
BEGIN
SAVEPOINT s1;
... 代码 ...
EXCEPTION
WHEN ... THEN
ROLLBACK TO s1;
... 代码 ...
WHEN ... THEN
ROLLBACK TO s1;
... 代码 ...
END;
如果你正在翻译一个使用这种风格的SAVEPOINT以及ROLLBACK TO的 Oracle 过程，你的工作比较简单：只要忽略掉SAVEPOINT以及ROLLBACK TO。如果你的 Oracle 过程是以不同的方法使用SAVEPOINT以及ROLLBACK TO，那么就要真正地动一番脑筋了。
41.13.2.2. EXECUTE #
PL/pgSQL的EXECUTE与PL/SQL中的工作相似，但是必须要记住按照第 41.5.4 节中所述地使用quote_literal以及quote_ident。EXECUTE 'SELECT * FROM $1';类型的结构将无法可靠地工作，除非你使用这些函数。
41.13.2.3. 优化 PL/pgSQL 函数 #
PostgreSQL提供了两种函数创建修饰符来优化执行：“volatility”（对于给定的相同参数，函数是否总是返回相同的结果）以及“strictness”（如果任何参数为空，函数是否返回空）。详见CREATE FUNCTION参考页。
在利用这些优化属性时，你的CREATE FUNCTION语句应该看起来像这样：
CREATE FUNCTION foo(...) RETURNS integer AS $$
...
$$ LANGUAGE plpgsql STRICT IMMUTABLE;
41.13.3. 附录 #
这一节包含了一组 Oracle 兼容的instr函数代码，你可以用它来简化你的移植工作。
--
-- instr functions that mimic Oracle's counterpart
-- Syntax: instr(string1, string2 [, n [, m]])
-- where [] denotes optional parameters.
--
-- Search string1, beginning at the nth character, for the mth occurrence
-- of string2.  If n is negative, search backwards, starting at the abs(n)'th
-- character from the end of string1.
-- If n is not passed, assume 1 (search starts at first character).
-- If m is not passed, assume 1 (find first occurrence).
-- Returns starting index of string2 in string1, or 0 if string2 is not found.
--
CREATE FUNCTION instr(varchar, varchar) RETURNS integer AS $$
BEGIN
RETURN instr($1, $2, 1);
END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;
CREATE FUNCTION instr(string varchar, string_to_search_for varchar,
beg_index integer)
RETURNS integer AS $$
DECLARE
pos integer NOT NULL DEFAULT 0;
temp_str varchar;
beg integer;
length integer;
ss_length integer;
BEGIN
IF beg_index > 0 THEN
temp_str := substring(string FROM beg_index);
pos := position(string_to_search_for IN temp_str);
IF pos = 0 THEN
RETURN 0;
ELSE
RETURN pos + beg_index - 1;
END IF;
ELSIF beg_index < 0 THEN
ss_length := char_length(string_to_search_for);
length := char_length(string);
beg := length + 1 + beg_index;
WHILE beg > 0 LOOP
temp_str := substring(string FROM beg FOR ss_length);
IF string_to_search_for = temp_str THEN
RETURN beg;
END IF;
beg := beg - 1;
END LOOP;
RETURN 0;
ELSE
RETURN 0;
END IF;
END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;
CREATE FUNCTION instr(string varchar, string_to_search_for varchar,
beg_index integer, occur_index integer)
RETURNS integer AS $$
DECLARE
pos integer NOT NULL DEFAULT 0;
occur_number integer NOT NULL DEFAULT 0;
temp_str varchar;
beg integer;
i integer;
length integer;
ss_length integer;
BEGIN
IF occur_index <= 0 THEN
RAISE 'argument ''%'' is out of range', occur_index
USING ERRCODE = '22003';
END IF;
IF beg_index > 0 THEN
beg := beg_index - 1;
FOR i IN 1..occur_index LOOP
temp_str := substring(string FROM beg + 1);
pos := position(string_to_search_for IN temp_str);
IF pos = 0 THEN
RETURN 0;
END IF;
beg := beg + pos;
END LOOP;
RETURN beg;
ELSIF beg_index < 0 THEN
ss_length := char_length(string_to_search_for);
length := char_length(string);
beg := length + 1 + beg_index;
WHILE beg > 0 LOOP
temp_str := substring(string FROM beg FOR ss_length);
IF string_to_search_for = temp_str THEN
occur_number := occur_number + 1;
IF occur_number = occur_index THEN
RETURN beg;
END IF;
END IF;
beg := beg - 1;
END LOOP;
RETURN 0;
ELSE
RETURN 0;
END IF;
END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;
上一页 上一级 下一页41.12. PL/pgSQL开发提示 起始页 第 42 章 PL/Tcl — Tcl 过程语言
