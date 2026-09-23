# 41.10. 触发器函数

41.10. 触发器函数
版本：
纠错本页面
搜索
目录导航
❮
❯
41.10. 触发器函数 #41.10.1. 数据更改触发器41.10.2. 事件触发器
PL/pgSQL可以被用来在数据更改或数据库事件上定义触发器函数。触发器函数用CREATE FUNCTION命令创建，它被声明为一个没有参数并且返回类型为trigger（对于数据更改触发器）或者event_trigger（对于数据库事件触发器）的函数。名为TG_something的特殊局部变量将被自动创建用以描述触发该调用的条件。
41.10.1. 数据更改触发器 #
一个数据更改触发器被声明为一个没有参数并且返回类型为trigger的函数。注意，即便该函数准备接收一些在CREATE TRIGGER中指定的参数 — 这类参数通过TG_ARGV传递，也必须把它声明为没有参数。
当一个PL/pgSQL函数作为触发器被调用时，
在顶层块中会自动创建几个特殊变量。它们是：
NEW record #
用于行级触发器中INSERT/UPDATE操作的新数据库行。
在语句级触发器中以及DELETE操作时，此变量为null。
OLD record #
行级触发器中用于UPDATE/DELETE操作的旧数据库行。
在语句级触发器中以及INSERT操作时，此变量为null。
TG_NAME name #
触发器的名称。
TG_WHEN text #
BEFORE、AFTER或
INSTEAD OF，取决于触发器的定义。
TG_LEVEL text #
ROW或STATEMENT，
取决于触发器的定义。
TG_OP text #
触发器被触发的操作：
INSERT、UPDATE、
DELETE或TRUNCATE。
TG_RELID oid（引用 pg_class.oid） #
引发触发器调用的表的对象ID。
TG_RELNAME name #
导致触发器调用的表。这现在已被弃用，并可能在未来的版本中消失。
请改用TG_TABLE_NAME。
TG_TABLE_NAME name #
导致触发器调用的表。
TG_TABLE_SCHEMA name #
导致触发器调用的表的模式。
TG_NARGS integer #
在CREATE TRIGGER语句中传递给触发器函数的参数数量。
TG_ARGV text[] #
参数来自CREATE TRIGGER语句。
索引从0开始计数。无效的索引（小于0或大于等于
tg_nargs）将导致一个空值。
一个触发器函数必须返回NULL或一个
记录/行值，其结构必须与触发器所针对的表完全相同。
BEFORE引发的行级触发器可以返回null来告诉触发器
管理器跳过对该行剩下的操作（即后续的触发器将不再被引发，
并且不会对该行发生INSERT/UPDATE/
DELETE）。如果返回了一个非空值，那么对该行值
会继续操作。返回不同于原始NEW的行值将修改将要
被插入或更新的行。因此，如果该触发器函数想要触发动作正常成功
而不修改行值，NEW（或者另一个相等的值）必须被
返回。要修改将被存储的行，可以直接在NEW中替换
单一值并返回修改后的NEW，或者构建一个全新的
记录/行来返回。在一个DELETE上的前触发器情况下，
返回值没有直接效果，但是它必须为非空以允许触发器动作继续下去。
注意NEW在DELETE触发器中是空值，
因此返回它通常没有意义。在DELETE中的常用方法是
返回OLD。
INSTEAD OF触发器（总是行级触发器，并且可能只被
用于视图）能够返回null来表示它们没有执行任何更新，并且对该行
剩余的操作可以被跳过（即后续的触发器不会被引发，并且该行不会
被计入外围INSERT/UPDATE/
DELETE的行影响状态中）。否则一个非空值应该被返回
用以表示该触发器执行了所请求的操作。对于INSERT
和UPDATE操作，返回值应该是NEW，
触发器函数可能对它进行了修改来支持INSERT RETURNING
和UPDATE RETURNING（这也将影响被传递给任何后续
触发器的行值，或者被传递给带有ON CONFLICT DO UPDATE
的INSERT语句中一个特殊的EXCLUDED
别名引用）。对于DELETE操作，返回值应该是
OLD。
一个AFTER行级触发器或一个BEFORE或
AFTER语句级触发器的返回值总是会被忽略，它可能也是
空。不过，任何这些类型的触发器可能仍会通过抛出一个错误来中止
整个操作。
例 41.3展示了PL/pgSQL
中一个触发器函数的例子。
例 41.3. 一个PL/pgSQL触发器函数
这个例子触发器保证：任何时候一个行在表中被插入或更新时，
当前用户名和时间也会被标记在该行中。并且它会检查给出了一个
雇员的姓名以及薪水是一个正值。
CREATE TABLE emp (
empname           text,
salary            integer,
last_date         timestamp,
last_user         text
);
CREATE FUNCTION emp_stamp() RETURNS trigger AS $emp_stamp$
BEGIN
-- Check that empname and salary are given
IF NEW.empname IS NULL THEN
RAISE EXCEPTION 'empname cannot be null';
END IF;
IF NEW.salary IS NULL THEN
RAISE EXCEPTION '% cannot have null salary', NEW.empname;
END IF;
-- Who works for us when they must pay for it?
IF NEW.salary < 0 THEN
RAISE EXCEPTION '% cannot have a negative salary', NEW.empname;
END IF;
-- Remember who changed the payroll when
NEW.last_date := current_timestamp;
NEW.last_user := current_user;
RETURN NEW;
END;
$emp_stamp$ LANGUAGE plpgsql;
CREATE TRIGGER emp_stamp BEFORE INSERT OR UPDATE ON emp
FOR EACH ROW EXECUTE FUNCTION emp_stamp();
另一种记录对表的改变的方法涉及到创建一个新表来为每一个发生的插入、更新或删除保持一行。这种方法可以被认为是对一个表的改变的审计。例 41.4展示了PL/pgSQL中一个审计触发器函数的例子。
例 41.4. 一个用于审计的 PL/pgSQL 触发器函数
这个例子触发器保证了在emp表上的任何插入、更新或删除一行的动作都被记录（即审计）在emp_audit表中。当前时间和用户名会被记录到行中，还有在其上执行的操作类型。
CREATE TABLE emp (
empname           text NOT NULL,
salary            integer
);
CREATE TABLE emp_audit(
operation         char(1)   NOT NULL,
stamp             timestamp NOT NULL,
userid            text      NOT NULL,
empname           text      NOT NULL,
salary            integer
);
CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
BEGIN
--
-- Create a row in emp_audit to reflect the operation performed on emp,
-- making use of the special variable TG_OP to work out the operation.
--
IF (TG_OP = 'DELETE') THEN
INSERT INTO emp_audit SELECT 'D', now(), current_user, OLD.*;
ELSIF (TG_OP = 'UPDATE') THEN
INSERT INTO emp_audit SELECT 'U', now(), current_user, NEW.*;
ELSIF (TG_OP = 'INSERT') THEN
INSERT INTO emp_audit SELECT 'I', now(), current_user, NEW.*;
END IF;
RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$emp_audit$ LANGUAGE plpgsql;
CREATE TRIGGER emp_audit
AFTER INSERT OR UPDATE OR DELETE ON emp
FOR EACH ROW EXECUTE FUNCTION process_emp_audit();
前一个例子的一种变体使用一个视图将主表连接到审计表来展示每一项最后被修改是什么时间。这种方法还是记录了对于表修改的完整审查跟踪，但是也提供了审查跟踪的一个简化视图，只为每一个项显示从审查跟踪生成的最后修改时间戳。例 41.5展示了在PL/pgSQL中一个视图上审计触发器的例子。
例 41.5. 一个用于审计的 PL/pgSQL 视图触发器函数
这个例子在视图上使用了一个触发器让它变得可更新，并且确保视图中一行的任何插入、更新或删除被记录（即审计）在emp_audit表中。当前时间和用户名会被与执行的操作类型一起记录，并且该视图会显示每一行的最后修改时间。
CREATE TABLE emp (
empname           text PRIMARY KEY,
salary            integer
);
CREATE TABLE emp_audit(
operation         char(1)   NOT NULL,
userid            text      NOT NULL,
empname           text      NOT NULL,
salary            integer,
stamp             timestamp NOT NULL
);
CREATE VIEW emp_view AS
SELECT e.empname,
e.salary,
max(ea.stamp) AS last_updated
FROM emp e
LEFT JOIN emp_audit ea ON ea.empname = e.empname
GROUP BY 1, 2;
CREATE OR REPLACE FUNCTION update_emp_view() RETURNS TRIGGER AS $$
BEGIN
--
-- 执行对 emp 的必要操作，并在 emp_audit 中创建一行
-- 以反映对 emp 所做的更改。
--
IF (TG_OP = 'DELETE') THEN
DELETE FROM emp WHERE empname = OLD.empname;
IF NOT FOUND THEN RETURN NULL; END IF;
OLD.last_updated = now();
INSERT INTO emp_audit VALUES('D', current_user, OLD.*);
RETURN OLD;
ELSIF (TG_OP = 'UPDATE') THEN
UPDATE emp SET salary = NEW.salary WHERE empname = OLD.empname;
IF NOT FOUND THEN RETURN NULL; END IF;
NEW.last_updated = now();
INSERT INTO emp_audit VALUES('U', current_user, NEW.*);
RETURN NEW;
ELSIF (TG_OP = 'INSERT') THEN
INSERT INTO emp VALUES(NEW.empname, NEW.salary);
NEW.last_updated = now();
INSERT INTO emp_audit VALUES('I', current_user, NEW.*);
RETURN NEW;
END IF;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER emp_audit
INSTEAD OF INSERT OR UPDATE OR DELETE ON emp_view
FOR EACH ROW EXECUTE FUNCTION update_emp_view();
触发器的一种用法是维护一个表的汇总表。作为结果的汇总表可以用来在特定查询中替代原始表 — 通常会大量减少运行时间。这种技术常用于数据仓库中，在其中被度量或被观察数据的表（称为事实表）可能会极度大。例 41.6展示了PL/pgSQL中一个为数据仓库事实表维护汇总表的触发器函数的例子。
例 41.6. 一个 PL/pgSQL 触发器函数用于维护汇总表
这里详述的模式有一部分是基于 Grocery Store 例子，来自 The Data Warehouse Toolkit，作者为 Ralph Kimball。
--
-- 主表 - 时间维度和销售事实。
--
CREATE TABLE time_dimension (
time_key                    integer NOT NULL,
day_of_week                 integer NOT NULL,
day_of_month                integer NOT NULL,
month                       integer NOT NULL,
quarter                     integer NOT NULL,
year                        integer NOT NULL
);
CREATE UNIQUE INDEX time_dimension_key ON time_dimension(time_key);
CREATE TABLE sales_fact (
time_key                    integer NOT NULL,
product_key                 integer NOT NULL,
store_key                   integer NOT NULL,
amount_sold                 numeric(12,2) NOT NULL,
units_sold                  integer NOT NULL,
amount_cost                 numeric(12,2) NOT NULL
);
CREATE INDEX sales_fact_time ON sales_fact(time_key);
--
-- 汇总表 - 按时间汇总销售
--
CREATE TABLE sales_summary_bytime (
time_key                    integer NOT NULL,
amount_sold                 numeric(15,2) NOT NULL,
units_sold                  numeric(12) NOT NULL,
amount_cost                 numeric(15,2) NOT NULL
);
CREATE UNIQUE INDEX sales_summary_bytime_key ON sales_summary_bytime(time_key);
--
-- 在 UPDATE、INSERT、DELETE 时修改汇总列的函数和触发器。
--
CREATE OR REPLACE FUNCTION maint_sales_summary_bytime() RETURNS TRIGGER
AS $maint_sales_summary_bytime$
DECLARE
delta_time_key          integer;
delta_amount_sold       numeric(15,2);
delta_units_sold        numeric(12);
delta_amount_cost       numeric(15,2);
BEGIN
-- 算出增量/减量数。
IF (TG_OP = 'DELETE') THEN
delta_time_key = OLD.time_key;
delta_amount_sold = -1 * OLD.amount_sold;
delta_units_sold = -1 * OLD.units_sold;
delta_amount_cost = -1 * OLD.amount_cost;
ELSIF (TG_OP = 'UPDATE') THEN
-- 禁止更改 time_key 的更新 -
-- （可能不会太麻烦，因为大部分的更改是用 DELETE + INSERT 完成的）。
IF ( OLD.time_key != NEW.time_key) THEN
RAISE EXCEPTION 'Update of time_key : % -> % not allowed',
OLD.time_key, NEW.time_key;
END IF;
delta_time_key = OLD.time_key;
delta_amount_sold = NEW.amount_sold - OLD.amount_sold;
delta_units_sold = NEW.units_sold - OLD.units_sold;
delta_amount_cost = NEW.amount_cost - OLD.amount_cost;
ELSIF (TG_OP = 'INSERT') THEN
delta_time_key = NEW.time_key;
delta_amount_sold = NEW.amount_sold;
delta_units_sold = NEW.units_sold;
delta_amount_cost = NEW.amount_cost;
END IF;
-- 插入或更新带有新值的汇总行。
<<insert_update>>
LOOP
UPDATE sales_summary_bytime
SET amount_sold = amount_sold + delta_amount_sold,
units_sold = units_sold + delta_units_sold,
amount_cost = amount_cost + delta_amount_cost
WHERE time_key = delta_time_key;
EXIT insert_update WHEN found;
BEGIN
INSERT INTO sales_summary_bytime (
time_key,
amount_sold,
units_sold,
amount_cost)
VALUES (
delta_time_key,
delta_amount_sold,
delta_units_sold,
delta_amount_cost
);
EXIT insert_update;
EXCEPTION
WHEN UNIQUE_VIOLATION THEN
-- 什么也不做
END;
END LOOP insert_update;
RETURN NULL;
END;
$maint_sales_summary_bytime$ LANGUAGE plpgsql;
CREATE TRIGGER maint_sales_summary_bytime
AFTER INSERT OR UPDATE OR DELETE ON sales_fact
FOR EACH ROW EXECUTE FUNCTION maint_sales_summary_bytime();
INSERT INTO sales_fact VALUES(1,1,1,10,3,15);
INSERT INTO sales_fact VALUES(1,2,1,20,5,35);
INSERT INTO sales_fact VALUES(2,2,1,40,15,135);
INSERT INTO sales_fact VALUES(2,3,1,10,1,13);
SELECT * FROM sales_summary_bytime;
DELETE FROM sales_fact WHERE product_key = 1;
SELECT * FROM sales_summary_bytime;
UPDATE sales_fact SET units_sold = units_sold * 2;
SELECT * FROM sales_summary_bytime;
AFTER触发器也可以利用过渡表来检查触发语句更改的整个行集。CREATE TRIGGER命令为一个或两个过渡表分配名称，然后函数可以像引用只读临时表一样引用这些名称。例 41.7展示了一个例子。
例 41.7. 使用过渡表进行审计
这个例子产生和例 41.4相同的结果，但并未使用一个为每一行都触发的触发器，而是在把相关信息收集到一个过渡表中之后用了一个只为每个语句引发一次的触发器。当调用语句修改了很多行时，这种方法明显比行触发器方法快。注意我们必须为每一种事件建立一个单独的触发器声明，因为每种情况的REFERENCING子句必须不同。但是这并不能阻止我们使用单一的触发器函数（实际上，使用三个单独的函数会更好，因为可以避免在TG_OP上的运行时测试）。
CREATE TABLE emp (
empname           text NOT NULL,
salary            integer
);
CREATE TABLE emp_audit(
operation         char(1)   NOT NULL,
stamp             timestamp NOT NULL,
userid            text      NOT NULL,
empname           text      NOT NULL,
salary            integer
);
CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
BEGIN
--
-- 创建 emp_audit 中的行以反映对 emp 执行的操作，
-- 利用特殊变量 TG_OP 来确定操作。
--
IF (TG_OP = 'DELETE') THEN
INSERT INTO emp_audit
SELECT 'D', now(), current_user, o.* FROM old_table o;
ELSIF (TG_OP = 'UPDATE') THEN
INSERT INTO emp_audit
SELECT 'U', now(), current_user, n.* FROM new_table n;
ELSIF (TG_OP = 'INSERT') THEN
INSERT INTO emp_audit
SELECT 'I', now(), current_user, n.* FROM new_table n;
END IF;
RETURN NULL; -- 结果被忽略，因为这是一个 AFTER 触发器
END;
$emp_audit$ LANGUAGE plpgsql;
CREATE TRIGGER emp_audit_ins
AFTER INSERT ON emp
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION process_emp_audit();
CREATE TRIGGER emp_audit_upd
AFTER UPDATE ON emp
REFERENCING OLD TABLE AS old_table NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION process_emp_audit();
CREATE TRIGGER emp_audit_del
AFTER DELETE ON emp
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE FUNCTION process_emp_audit();
41.10.2. 事件触发器 #
PL/pgSQL可以被用来定义事件触发器。PostgreSQL要求一个可以作为事件触发器调用的函数必须被声明为没有参数并且返回类型为event_trigger。
当一个PL/pgSQL函数作为事件触发器被调用时，
顶层块中会自动创建几个特殊变量。它们是：
TG_EVENT text #
触发器触发的事件。
TG_TAG text #
触发器触发的命令标签。
例 41.8展示了PL/pgSQL中一个事件触发器函数的例子。
例 41.8. 一个 PL/pgSQL 事件触发器函数
这个例子触发器在受支持命令每一次被执行时会简单地抛出一个NOTICE消息。
CREATE OR REPLACE FUNCTION snitch() RETURNS event_trigger AS $$
BEGIN
RAISE NOTICE 'snitch: % %', tg_event, tg_tag;
END;
$$ LANGUAGE plpgsql;
CREATE EVENT TRIGGER snitch ON ddl_command_start EXECUTE FUNCTION snitch();
上一页 上一级 下一页41.9. 错误和消息 起始页 41.11. PL/pgSQL的内部实现
