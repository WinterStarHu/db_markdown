# 38.4. 一个表重写事件触发器示例

38.4. 一个表重写事件触发器示例
版本：
纠错本页面
搜索
目录导航
❮
❯
38.4. 一个表重写事件触发器示例 #
得益于table_rewrite事件的存在，我们可以实现一种只允许在
维护窗口中重写的表重写策略。
这里是实现这种策略的例子。
CREATE OR REPLACE FUNCTION no_rewrite()
RETURNS event_trigger
LANGUAGE plpgsql AS
$$
---
--- 实现本地表重写策略：
---   public.foo 不允许重写，其他表只允许在 1am 和 6am 之间重写，
---   且前提是它们拥有不超过 100 块
---
DECLARE
table_oid oid := pg_event_trigger_table_rewrite_oid();
current_hour integer := extract('hour' from current_time);
pages integer;
max_pages integer := 100;
BEGIN
IF pg_event_trigger_table_rewrite_oid() = 'public.foo'::regclass
THEN
RAISE EXCEPTION 'you''re not allowed to rewrite the table %',
table_oid::regclass;
END IF;
SELECT INTO pages relpages FROM pg_class WHERE oid = table_oid;
IF pages > max_pages
THEN
RAISE EXCEPTION 'rewrites only allowed for table with less than % pages',
max_pages;
END IF;
IF current_hour NOT BETWEEN 1 AND 6
THEN
RAISE EXCEPTION 'rewrites only allowed between 1am and 6am';
END IF;
END;
$$;
CREATE EVENT TRIGGER no_rewrite_allowed
ON table_rewrite
EXECUTE FUNCTION no_rewrite();
上一页 上一级 下一页38.3. 一个完整的事件触发器示例 起始页 38.5. 数据库登录事件触发器示例
