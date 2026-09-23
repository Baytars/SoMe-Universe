# SoMe 科技树 × Reactome 通路映射方案

> By Yukio | 2026-04-18 | 生物学 × 游戏设计

---

## 一、映射哲学

**Reactome是"真实的通路"，SoMe是"真实通路的隐喻"**。

本映射方案的目标：
1. 让每个科技节点都能追溯到真实的生物学通路
2. 为未来的"祛魅模式"奠定数据基础（玩家可点击查看通路详情）
3. 用真实科学为游戏叙事背书

---

## 二、Reactome 顶层分类与SoMe对应

| Reactome 顶层分类 | SoMe 科技树层级 | 映射说明 |
|-------------------|----------------|---------|
| **Cell Cycle** | 分裂屋 + 兵种科技I | 有丝分裂 → 生产单位 |
| **Metabolism** | 代谢发电厂 + 营养汲取站 | 瓦氏效应 → 资源产出 |
| **Signal Transduction** | 支援科技树 | 通路激活 → Buff系统 |
| **Immune System** | 敌方阵营 + 己方免疫相关科技 | 对立阵营 |
| **Programmed Cell Death** | 永生祭坛 + 超级武器 | 凋亡抵抗 → 永生 |
| **DNA Repair** | 突变熔炉 + 基因编辑科技 | 突变积累 → 新能力 |
| **Vesicle-mediated Transport** | 外泌体通讯 + CTC系统 | 细胞间通讯 |
| **Epithelial Mesenchymal Transition** | 侵袭/转移科技 | EMT → 扩散能力 |
| **Angiogenesis** | 血管生成科技 | 转移扩散前置 |

---

## 三、详细映射表

### 3.1 Cell Cycle → 分裂系科技

| SoMe科技/单位 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| 基底克隆兵 | R-HSA-69278 (Cell Cycle, Mitotic) | Cyclin D/CDK4/6 | 基础生产单位 |
| 快速分裂者 | R-HSA-69205 (G1/S Transition) | Ki-67, PCNA | 高速生产 |
| 分裂进化I/II/III | R-HSA-69002 (DNA Replication) | ORC, MCM, CDC6 | 加速生产 |
| 有丝分裂异常 | R-HSA-9633012 (Mitotic Spindle Checkpoint) | SAC蛋白 | 死后分裂反击 |
| 干细胞巢穴 | R-HSA-453279 (Stem Cell Transcriptional Programs) | SOX2, OCT4, NANOG | 维持干性 |

**设计原理**：
- Reactome的Cell Cycle分为G1/S和G2/M两个检查点
- SoMe的"分裂进化"科技线对应这两个检查点的突破
- "有丝分裂异常"触发时不完美分裂 → 留下退化细胞

---

### 3.2 Metabolism → 代谢系科技

| SoMe科技/建筑 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| 代谢发电厂 | R-HSA-71403 (Glycolysis) | HK2, PFKFB3, LDHA | ATP基础产出 |
| 瓦氏效应激活 | R-HSA-163200 (Respiratory electron transport) | PDH激酶, PD-L1 | ATP高效产出 |
| 氧化磷酸化电厂 | R-HSA-611105 (Fatty acid metabolism) | CPT1, ACLY | 高ATP但高消耗 |
| 氨基酸提取器 | R-HSA-71441 (Glutamine metabolism) | GLS, GDH | 氨基酸资源 |
| 脂质掠夺站 | R-HSA-75105 (Cholesterol biosynthesis) | HMG-CoA还原酶 | 高产出低HP |

**设计原理**：
- 瓦氏效应：肿瘤即使在有氧条件下也优先糖酵解（vs 正常细胞的有氧氧化）
- SoMe用"代谢发电厂"还原这个选择
- 不同的代谢模式代表不同的资源/风险权衡

---

### 3.3 Signal Transduction → 支援科技树

| SoMe支援科技 | Reactome通路 | 关键分子 | 游戏效果 |
|-------------|-------------|---------|---------|
| 增殖协议 | R-HSA-186763 (Growth factor signaling) | EGFR, HER2, PI3K/AKT | 攻速+移速 |
| 代谢适应 | R-HSA-194315 (MAPK cascade) | RAS/RAF/MEK/ERK | 特殊攻击 |
| 微环境改造 | R-HSA-1227986 (Signaling by EGFR) | TGF-β, IL-6 | 地形变形 |
| 细胞通讯 | R-HSA-380994 (Notch signaling) | Notch1-4 | 友军Buff联动 |
| 血管生成基础 | R-HSA-4420097 (VEGFA-VEGFR2) | VEGF, VEGFR2 | 解锁载具生产 |

**设计原理**：
- 每条支援科技线对应一条经典信号通路
- 信号通路的"开关"性质 → Buff/Debuff系统
- 多通路协同 → 更强的组合效果

---

### 3.4 DNA Repair → 突变系科技

| SoMe科技/单位 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| 突变熔炉 | R-HSA-73885 (DNA Repair) | BER, NER, MMR | 随机突变机会 |
| 基因不稳定 | R-HSA-73942 (Homologous recombination) | BRCA1/2, PALB2 | 更高突变率 |
| 端粒酶激活 | R-HSA-419829 (Telomere maintenance) | hTERT, shelterin | 永生效果 |
| 错配修复缺陷 | R-HSA-735540 (DNA Mismatch Repair) | MSH2, MLH1 | 加速进化 |
| 突变进化I/II/III | R-HSA-69089 (DNA Replication Fork) | Pol η (Y家族) | 新能力解锁 |

**设计原理**：
- DNA损伤修复是双刃剑：修复错误 = 突变，修复正确 = 稳定
- SoMe的"突变"系统模拟"易错修复" → 随机获得能力
- 高级突变科技 = 更可控的定向进化

---

### 3.5 EMT & Invasion → 侵袭转移科技

| SoMe科技/单位 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| EMT转化 | R-HSA-8937144 (EMT过程) | SNAIL, SLUG, ZEB1, TWIST | 解锁侵袭能力 |
| 基底膜突破 | R-HSA-1474228 (Degradation of ECM) | MMP2, MMP9, uPA | 地形穿透 |
| 循环侦察兵 | R-HSA-8979227 (CTCs) | EMT-TFs, Integrin | 血液漂流 |
| 外泌体通讯 | R-HSA-5694530 (Exosome biogenesis) | CD63, CD81, miRNA | 信号中继 |
| 转移播种 | R-HSA-163125 (Pre-NOTCH processing) | NOTCH, JAG | 远处建造 |

**设计原理**：
- EMT（上皮-间质转化）是转移的关键步骤：上皮细胞 → 间质细胞，获得移动能力
- SoMe用"EMT转化"科技解锁转移单位
- 外泌体是CTCs的"侦察兵"，提前到达目标位置建立信号

---

### 3.6 Angiogenesis → 血管生成科技

| SoMe科技/单位 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| 血管生成基础 | R-HSA-194313 (VEGF signaling) | VEGFA, VEGFR2 | 解锁血管网络 |
| 血管拟态 | R-HSA-1237975 (Vasculogenic mimicry) | VE-cadherin, MMPs | 伪装友军血管 |
| 淋巴管生成 | R-HSA-9668321 (Lymphangiogenesis) | VEGFC, VEGFR3 | 淋巴系统 |
| 血流劫持 | R-HSA-4420336 (FOXO signaling) | FOXO3, HIF1α | 加速CTCs |

**设计原理**：
- 血管生成是肿瘤从1mm³长大的关键（无血管期 → 血管期）
- SoMe用血管生成科技解锁"载具单位"的生产
- 血流劫持 = 利用已有的血管网络加速转移

---

### 3.7 Immune Evasion → 免疫逃逸科技

| SoMe科技/单位 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| 免疫驯化者 | R-HSA-389948 (PD-1 signaling) | PD-L1, PD-1 | 检查点攻击 |
| 调节性T细胞 | R-HSA-8853911 (Treg differentiation) | FOXP3, IL-2R | 免疫抑制波 |
| 免疫抑制场 | R-HSA-9665413 (TGF-β signaling) | TGF-β, SMAD | 周围友军减伤 |
| 免疫编辑 | R-HSA-419615 (Immunoediting) | IFN-γ, NKG2D | 隐藏特征 |
| 免疫特权区 | R-HSA-983170 (Antigen presentation) | MHC-I下调 | 免疫逃逸 |

**设计原理**：
- 肿瘤通过PD-L1/PD-1、调节性T细胞、TGF-β等多种机制逃避免疫监视
- SoMe的免疫逃逸单位是高级战术核心
- "免疫编辑" = 肿瘤主动塑造免疫微环境

---

### 3.8 Stemness → 干性维持科技

| SoMe科技/单位 | Reactome通路 | 关键分子 | 游戏效果 |
|--------------|-------------|---------|---------|
| 干细胞巢穴 | R-HSA-452723 (Hedgehog signaling) | GLI, SMO, SHH | 干性基础 |
| 干性增强 | R-HSA-453276 (WNT signaling) | β-catenin, LEF1 | 更强干性 |
| 去分化 | R-HSA-8957275 (YAP/TAZ) | YAP, TAZ | 普通→干性 |
| 休眠激活 | R-HSA-8934901 (p53 signaling) | p53, p21 | 死后休眠反击 |

**设计原理**：
- 肿瘤干细胞(CSCs)是治疗抵抗和复发的根源
- SoMe的干性科技决定单位的"质量"
- 去分化 = 将已有的普通单位转化为干细胞（高级操作）

---

## 四、超级武器 × Reactome通路

| 超级武器 | Reactome通路 | 触发机制 | 游戏效果 |
|---------|-------------|---------|---------|
| **肿瘤爆发** | R-HSA-5357806 (Oncogenic MAPK signaling) | 所有单位同时突变 | 全图随机强化 |
| **永生祭坛** | R-HSA-73817 (Chromatin modifying enzymes) + R-HSA-419829 | 端粒酶无限激活 | 己方全员复活一次 |
| **代谢风暴** | R-HSA-71404 (Pyruvate metabolism) + R-HSA-1430728 | 代谢通路紊乱 | 全图代谢debuff |
| **转移扩散** | R-HSA-8874081 (MET activation) + R-HSA-9668321 | EMT信号爆发 | 强制CTCs空降全图 |

---

## 五、英雄单位 × 核心调控因子

| 英雄 | Reactome对应 | 核心机制 | 科技树位置 |
|------|-------------|---------|-----------|
| Chrono-01 | Cell Cycle Checkpoints (R-HSA-69618) | 时间操控/加速分裂 | 分裂进化III |
| Oblivion | Apoptosis (R-HSA-71474) | 死亡抵抗/吸取 | 永生祭坛 |
| Vesselwright | Angiogenesis (R-HSA-194315) | 血管生成 | 血管生成III |
| Warborne | Metabolism (R-HSA-71403) | 代谢强化 | 代谢重编程III |
| McClintock | DNA Repair (R-HSA-73885) | 突变创造 | 突变进化III |
| Whisperkin | Exosome (R-HSA-5694530) | 通讯干扰 | 外泌体通讯III |

---

## 六、后续行动计划

- [ ] 为每个科技节点添加Reactome R-HSA编号引用
- [ ] 设计"通路详情"UI（玩家可点击查看真实科学背景）
- [ ] 用Reactome API构建通路依赖图（补充SoMe现有科技树图）
- [ ] 评估"祛魅模式"：显示通路矛盾/研究空白

---

*本文档为游戏生物学映射方案，所有Reactome通路编号均为示意，需用API验证*
