# Oracle Database 19c 文档全量归档

Oracle Database 19c 完整文档库（152 本）的本地归档，按官网目录结构 `en/<tag>/` 组织，便于离线查阅与对照实现。

## 目录结构

```
en/<tag>/<书名>.pdf        # 148 本，官方 PDF（GitHub 可在线查看）
en/sqlrf/*.md  en/dbseg/*.md  en/tdddg/*.md   # 3 本无 PDF 的书，HTML→Markdown（1037 页）
en/refrn/*.md  en/arpls/DBMS_SCHEDULER.md      # Scheduler 子集逐页 Markdown
```

## 覆盖情况

- ✅ 148 本 PDF（371 MB）
- ✅ 3 本 HTML→MD（官网无 PDF）：`sqlrf`（602 页）、`dbseg`（360 页）、`tdddg`（75 页）
- ❌ 1 本 `exmpl`（Database Examples Installation Guide）：官网内容页全部 404，无法获取

完整书籍清单见 [BOOKS.md](BOOKS.md)，Scheduler 视图清单见 [INDEX.md](INDEX.md)。

## 全文 Markdown（便于检索）

`md/` 目录：151 本书全部转为 Markdown，按 [BOOKS.md](BOOKS.md) 索引命名为 `NN-<书名>.md`（如 `54-database-reference.md`、`130-sql-language-reference.md`），便于全文搜索。
- 148 本由 PDF 用 `pdftotext -layout` 提取
- 3 本（sqlrf/dbseg/tdddg）由抓取的 HTML 页面按目录顺序拼接

## 来源

- https://docs.oracle.com/en/database/oracle/oracle-database/19/ （书架与各书）

下载日期：2026-09-03 ~ 09-04
