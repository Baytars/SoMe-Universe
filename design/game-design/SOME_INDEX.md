# SoMe 宇宙文件索引
> 用于快速定位 SoMe 游戏设计相关文件 | 最后更新：2026-06-08

---

## 📁 文件总览

| 文件 | 内容摘要 |
|------|---------|
| `SoMe大世界架构札记.md` | 核心设计哲学 + 宏观架构 |
| `科技树/SoMe_Technology_Tree.md` | 完整科技树 v1.0（含11个英雄单位） |
| `Reactome科技树映射.md` | 科技树 ↔ 真实生物学通路映射 |
| `Reactome_API_获取方案.md` | 如何用 Reactome API 获取通路数据 |
| `Reactome_SoMe_科技树.drawio` | 科技树可视化图表 |
| `Narratives/Operation_Before_the_Storm.md` | 剧本：「风暴前行动」凤凰解放战役 |
| `Factions/Anstar_Empire/The_Seekers.md` | 阵营设定：Anstar 第七侦察团「Seekers」 |

---

## 🌍 核心设定速览

### 世界观
- **SoMe = 恶性肿瘤**（某种恶性肿瘤）
- 地图 = 人体解剖系统，宏观→中观→微观三级无缝缩放
- 双交通网络：血管系统（血流固定）+ 淋巴系统（免疫安检）
- 转移灶动态生成，同一局游戏不同玩家的地图可能完全不同

### 阵营
- **Anstar Empire**（免疫方）：Anstar 帝国，第7侦察团「Seekers」
- **Umin**（占领方）：占领了颈椎高地的 Phoenix 堡垒，有 Silencing Fog 通讯网络
- **Eastern Therapeutics Coalition**：东部治疗联盟，支援方
- **Preceptor Order**：预言者团，负责情报预测

### 关键角色（档案已知）
| 角色 | 阵营 | 身份 |
|------|------|------|
| Gamor Stuart 宋佳木 | Anstar | 第七侦察团指挥官，中校 |
| Kimi Jimi 季芈 | Anstar | 情报信号专家，狙击手 |
| Specter | Anstar | 渗透专员（身份保密） |
| Wraith | Anstar | 生存专家，47天solo侦察记录 |
| Echolot | Anstar | 通讯分析员，话唠 |
| Briar | Anstar | 生物侦察+医疗兵 |
| Nightingale | Anstar | Helicarrier级战舰（人形存在） |
| Drift | Anstar? | 疑似叛变/双面，原Cervical Institute研究员 |
| Roi Hytar | 联盟 | 第三机动团少校 |
| Mute | Umin | Harbinger级特工，反情报专家 |

---

## ⚔️ 已知战役/事件

### Operation Phoenix Liberation「凤凰解放战役」
- 时间：Year 2343
- 背景：Umin 占领 Phoenix 堡垒（颈椎高地）三年
- 四阶段作战：
  1. **Subclavian Cut** - 切断供给线（47小时完成）
  2. **Operation Quiet Thunder** - 破坏 Silencing Fog 通讯节点
  3. **Bone Marrow Gambit** - 正面佯攻（最血腥阶段，212人阵亡）
  4. **Operation Quietus** - 突入指挥塔，广播「你们为何而战？」
- 结果：Phoenix 解放

---

## 🔬 科技树核心（玩家阵营：肿瘤/SoMe）

### 资源系统
- 营养素 = 葡萄糖/氨基酸
- ATP = 细胞能量货币（瓦氏效应核心）
- 人口上限 = 肿瘤微环境容量

### 超级武器
- 肿瘤爆发（Oncogenic Burst）
- 永生祭坛（Altar of Immortality）
- 代谢风暴（Metabolic Storm）
- 转移扩散（Metastatic Spread）

### 英雄单位（11个）
原初者(Primus)、永生论者(Chrono)、不死者(Oblivion)、血匠(Vesselwright)、驯化者(Tamedon)、代谢暴君(Warborne)、暮落之剑(Eclipsion)、血途朝圣者(Errath)、暗影先遣(Prevan)、残烬(Cinderine)、无尽低语(Whisperkin)

---

## 🛠️ 技术选型
- **引擎**：Godot 4.x（MIT开源）
- **数据来源**：Reactome 数据库（R-HSA通路编号）
- **原型阶段**：单器官先行

---

## 📋 开放问题（来自架构札记）
- [ ] 人体地图分区加载策略
- [ ] 解剖知识嵌入深度（教育边界）
- [ ] 动态转移灶与战局平衡
- [ ] 新手引导设计
