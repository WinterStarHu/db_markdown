# db_doc — 数据库文档归档

按厂商分目录的数据库官方文档归档。

## 目录

- [`O/`](O/) — Oracle Database 19c 文档
  - `O/md/` — 全量 Markdown（151 本，便于全文检索）
  - `O/zh/` — 中文（82 个 Scheduler 数据字典视图 + 高级包 22 个 DBMS_* 包 + DBMS_SCHEDULER 精译）
  - `O/高级包/` — Oracle 高级包按类别分类（定时任务/SQL/LOB/XML/统计等）
- [`G/`](G/) — GaussDB 文档
  - `G/*.md` — 10 个版本 CHM 解包 Markdown（68769 页）
  - `G/高级包/` — 高级包分类（29 个 DBE_*/PKG_* 包，含 Oracle↔GaussDB 对照）
  - `G/chm/` — 源 CHM 分片归档（gitignored，本地留存）
- [`T/`](T/) — TPC 基准测试规范（TPC-H/DS/DI/E/V，含 TPC-H 中文精译）
- [`P/`](P/) — PostgreSQL 18 文档
  - `postgresql-18-docs.md` — 英文全量（1148 页）
  - `postgresql-18-zh.md` — 中文（1146 页，来自 postgres.cn）
- [`M/`](M/) — MySQL 文档
  - `md/mysql-9.7-refman.md` — 英文（9.7 创新版，19MB）
  - `mysql-8.0-refman-zh.md` — 中文（8.0，1321 页，来自 mysql.net.cn）

源文件（PDF、CHM、per-page HTML）在 `archive/full` 分支和本地（gitignored）。

## 版权声明

本仓库归档的所有文档版权归**对应厂商/组织**所有：
- `O/`（Oracle）→ Oracle Corporation
- `G/`（GaussDB）→ Huawei Technologies
- `T/`（TPC）→ Transaction Processing Performance Council (TPC)
- `P/`（PostgreSQL）→ PostgreSQL Community（PostgreSQL License，自由使用）
- `M/`（MySQL）→ Oracle Corporation / MySQL Community（GPLv2 with FOSS Exception）

本归档**仅供个人学习与研究使用**，不用于任何商业目的，也不对外分发。所有内容均为各厂商/组织官方文档的副本。若任何权利方认为本归档侵犯其权益，请告知，将**立即删除**对应内容。
