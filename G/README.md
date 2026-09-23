# G/ — GaussDB 文档

华为 GaussDB 产品文档归档。源为 CHM（Windows 编译帮助，GB18030 编码），已用 7z 解包全部 HTML 页并转成 Markdown，**每版本拼接成一个 MD 文件**便于全文检索。共 10 个版本、68769 页。

| 文件 | 页数 | 大小 |
|---|---:|---:|
| [G/云数据库-GaussDB-24.7.30.10-产品文档for-华为云Stack-8.5.0-03.md](G/云数据库-GaussDB-24.7.30.10-产品文档for-华为云Stack-8.5.0-03.md) | 8050 | 30M |
| [G/云数据库-GaussDB-25.1.32-分布式版产品文档for-华为云Stack-8.5.1-01.md](G/云数据库-GaussDB-25.1.32-分布式版产品文档for-华为云Stack-8.5.1-01.md) | 5602 | 19M |
| [G/云数据库-GaussDB-25.1.32-集中式版产品文档for-华为云Stack-8.5.1-01.md](G/云数据库-GaussDB-25.1.32-集中式版产品文档for-华为云Stack-8.5.1-01.md) | 5826 | 20M |
| [G/GaussDB轻量化部署形态-25.1.32-分布式版产品文档-01.md](G/GaussDB轻量化部署形态-25.1.32-分布式版产品文档-01.md) | 5921 | 19M |
| [G/GaussDB轻量化部署形态-25.1.32-集中式版产品文档-01.md](G/GaussDB轻量化部署形态-25.1.32-集中式版产品文档-01.md) | 5979 | 20M |
| [G/GaussDB-AI助手-V2.0-26.861.0.1-产品文档for-轻量化部署形态.md](G/GaussDB-AI助手-V2.0-26.861.0.1-产品文档for-轻量化部署形态.md) | 188 | 192K |
| [G/GaussDB-V2.0-25.860.0-分布式版产品文档for-华为云Stack-8.6.0-01.md](G/GaussDB-V2.0-25.860.0-分布式版产品文档for-华为云Stack-8.6.0-01.md) | 5758 | 20M |
| [G/GaussDB-V2.0-25.860.0-集中式版产品文档for-华为云Stack-8.6.0-01.md](G/GaussDB-V2.0-25.860.0-集中式版产品文档for-华为云Stack-8.6.0-01.md) | 5990 | 20M |
| [G/GaussDB-V2.0-26.861.1-产品文档for-华为云Stack-8.6.1-01.md](G/GaussDB-V2.0-26.861.1-产品文档for-华为云Stack-8.6.1-01.md) | 10800 | 43M |
| [G/GaussDB-V2.0-26.861.1-产品文档for-轻量化部署形态-01.md](G/GaussDB-V2.0-26.861.1-产品文档for-轻量化部署形态-01.md) | 14655 | 52M |

> 源 CHM zip（约 2GB）在仓库外。每页以 `## <标题>` 分隔，标题来自原 HTML 的 `DC.Title`。

## 高级包参考（`高级包/`）

[`高级包/`](高级包/) 目录：29 个 DBE_/PKG_ 高级包按功能分类整理为「总览 + 分类别」。
- [`高级包/README.md`](高级包/README.md) — 总览（含 Oracle↔GaussDB 兼容性对照表、分类目录）
- [`高级包/定时任务.md`](高级包/定时任务.md) — **DBE_SCHEDULER + DBE_TASK**（对应 Oracle DBMS_SCHEDULER/DBMS_JOB），openGauss dbe_scheduler 直接参考
- 其余按类别分文件：SQL与描述、输出与调试、LOB与文件、工具与杂项、统计、XML、安全与ILM、系统包


## 源 CHM 分片（`chm/`，本地，未推送）

`chm/` 存放 10 个原始 CHM 的归档（1.5GB）：3 个 <100MB 整片，7 个切成 90MB 分片（`*.chm.partNNN`，含 `reassemble.py` 可还原）。因总量 1.5GB 超 GitHub 单次推送能力（SSH 上传会被掐断），**整个 `chm/` 已 gitignore，仅本地留存**；云端只保留可检索的 Markdown。如需源 CHM 上云，建议用 Git LFS 或外部对象存储。
