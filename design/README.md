# SoMe Design Layer

设计层文档（Design Layer）——架构方案、核心机制、数值系统、科技树、风格规范、竞品调研与叙事草稿。

## 与正典层的关系

- 本目录（`design/`）存放**设计过程文档**：技术实现方案、设计备忘（design memo）、草稿、调研。部分文档会自标 *"non-canonical / design memo"*。
- 世界内**正典**（in-fiction canon）位于仓库根的 `Factions/`、`Characters/`、`Locations/`、`Organizations/`、`Protocols/`、`Lore/`、`Scripts/`，由 hy3 修缮定稿。
- 设计文档中的相对链接保留历史写法，未逐条对齐；链接修缮留 hy3。

## 目录结构

| 路径 | 内容 |
|---|---|
| `Carbon_Based_Cyberspace.md` | 碳基赛博空间核心叙事框架 |
| `Opening_Sequence_Somnambule.md` | 梦游者开场引导 |
| `Engagement_First_Design.md` | 上头优先设计原则与 MVP 路线 |
| `Core_Mechanics/` | 细胞身份重编程、提权式成长范式 |
| `Combat_System/` | 属性数值系统、Notch 锁系统 |
| `Bacterial_Unit_Database_Architecture.md` | 细菌单位底层数据库架构 |
| `Data_Pipeline_DuckDB_Architecture.md` | DuckDB 统一查询层 / 数据管线 |
| `Curriculum_Medicine_to_CS.md` | 用生命系统学 CS |
| `AI蛋白质设计-SoMe关联分析.md` | AI 蛋白质设计的 SoMe 关联 |
| `Factions/` | 相分离第四阵营、Umin 无冕之王（设计底稿） |
| `Technology/Umin_Technology_Tree.md` | Umin 科技树 / 恐惧具象化系统 |
| `Encyclopedia/` | MRSA、肺癌母舰、代谢同像性等百科草稿 + wiki 方法论参考 |
| `Narrative/` `Narratives/` | 海葵叙事、Operation Blinding Prophet |
| `Style_Design/` | Alopes 时装元规则、化合物娘化设计圣经 |
| `Research/` | 《工作细胞》竞品情报 |
| `References/` | Aquaman 参考、视频 POC 制作指南与关键帧 |
| `Scripts/` | 序章/胆管姐妹剧本草稿、Opening Sequence Ink 脚本 |
| `game-design/` | 早期中文设计包：大世界架构札记、科技树、Reactome 映射、The Seekers、Operation Before the Storm、`SOME_INDEX.md` |

## 外部数据（不入库）

- `design/data/CARD/`：第三方 **CARD（Comprehensive Antibiotic Resistance Database）** 原始下载，约 82 MB（`card.json`、OWL/OBO、FASTA、tar.bz2）。属可从 [card.mcmaster.ca](https://card.mcmaster.ca/) 重新获取的外部数据，已通过 `.gitignore` 排除，不提交到本仓库。

---

*整合入仓库：2026-09-24。*
