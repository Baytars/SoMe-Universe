# SoMe 叙事：海葵——碳基OS v0.1逆向工程

> **文档状态**：v1.0（重构版） | **创建日期**：2026-07-22 | **关联文档**：`Privilege_Escalation_Paradigm.md`、`Notch_Lock_System.md`、`Carbon_Based_Cyberspace.md`

---

## 1. 发现机制

### 1.1 叙事前提

Archaeology Division是**Umin阵营**的子部门，不属于医学阵营。其格言："In the beginning, there was sulfur."——专门在极端环境挖掘古细菌/古生物技术。

医学阵营发现海葵研究的方式不是"自己去考古"，而是：

```
玩家清剿Umin据点
  → 缴获Archaeology Division加密研究档案
  → 档案标题："碳基OS v0.1逆向工程——Nematostella vectensis"
  → Eiko/Yukio破译分析
```

### 1.2 Umin的动机

Umin的Archaeology Division研究海葵的理由完全符合其职能：海葵（Nematostella vectensis）是最古老的动物门门类之一，是"活化石"级别的古老生物技术载体。

Umin的研究目标：**找到lockdown loop漏洞→实现handler权限提升→让细胞可塑→便于感染转化**

```
海葵 v0.1 handler 有 root 权限（收到Notch信号→全身再生）
人类 v2.0 handler 有访问控制（同样信号→被限制的操作）

Umin的逆向工程：
  1. 研究海葵v0.1源码 → 找到handler无访问控制的实现方式
  2. 对比人类v2.0 → 定位访问控制是在哪一层加的
  3. 寻找绕过路径 → handler权限提升exploit
  4. 应用exploit → 让人类细胞可塑 → 感染转化
```

---

## 2. 叙事弧线

```
玩家清剿Umin据点
  → 缴获Archaeology Division加密研究档案
  → 档案标题："碳基OS v0.1逆向工程——Nematostella vectensis"
  → Eiko/Yukio破译分析
  → 发现Umin在研究海葵的lockdown loop缺失
    → Umin的目的：找到解锁方法→让细胞可塑→便于感染转化
  → 医学阵营的顿悟：
    → 同一个"解锁"，Umin拿来做武器，我们能拿来治病
    → lockdown loop不是bug是feature——防癌代价
    → 但对于已经梗死的脑组织，这把锁恰恰是障碍
  → 核心抉择：要不要用敌人的研究来尝试神经再生？
    → 解锁=再生可能，但也是癌症风险
    → 而且这是Umin的技术，伦理上能接受吗？
```

### 2.1 三幕结构

**第一幕：缴获**

玩家在清剿Umin据点时发现Archaeology Division的加密研究档案。档案使用古细菌代谢编码加密（呼应Umin的格言"In the beginning, there was sulfur"）。Eiko协助破译。

档案内容揭示：Umin一直在系统性地逆向工程海葵的再生机制。海葵的Notch handler有root权限——一个信号就能重建整个身体。Umin的目的是找到人类handler的访问控制弱点，实现权限提升。

**第二幕：顿悟**

Yukio分析档案后提出核心洞察：

- 协议从v0.1到v2.0没变过——Notch信号通路的通信规范在海葵和人类之间是保守的
- 变的是handler的权限策略——海葵是root，人类被加了访问控制
- lockdown loop不是bug，是feature——它防止细胞随意可塑，是防癌的代价
- 但对于已经梗死的脑组织，这把锁恰恰是障碍

**Umin拿这个技术做武器（让细胞可塑→感染转化），我们能拿来做治疗（让神经元重编程→修复梗死区）。**

同一技术，意图相反。玩家与Umin是同一privilege escalation的镜像。

**第三幕：抉择**

玩家面临核心抉择：
- 要不要用Umin的研究来尝试神经再生？
- 解锁=再生可能，但也是癌症风险
- 这是敌人的技术——伦理上能接受吗？
- 如果接受，如何确保只解锁目标区域而不影响全局？

这个抉择直接对接[Notch锁系统](../Combat_System/Notch_Lock_System.md)——8把锁不是抽象的，每把锁都是玩家必须面对的具体决策。

---

## 3. 海葵生物学→SoMe叙事映射

| 海葵生物学 | SoMe碳基赛博空间 | 叙事功能 |
|---|---|---|
| Lockdown loop缺失 | v0.1源码handler无访问控制 | 玩家发现"人类为什么不能再生"的答案 |
| 单一Notch信号→完整重建 | root权限handler收到消息即可重建 | 极简系统恢复协议 |
| CARDIB反向免疫 | 替代安全协议架构 | 揭示"防御系统不只有一种写法" |
| Nematosomes选择性吞噬 | 无特征库的状态防火墙 | 先天免疫≠无差别攻击 |
| 海葵毒素靶向离子通道 | 远古exploit工具包 | 考古发现的"武器"可被玩家复用 |
| i-cells全能干细胞 | root权限种子细胞 | 单细胞→完整系统的"种子恢复" |

### 3.1 关键生物学依据

- **心脏基因lockdown loop**：[UF News 2017](https://news.ufl.edu/articles/2017/06/does-a-tiny-sea-creature-hold-the-key-to-heart-regeneration.html) — 海葵研究揭示心脏再生基因被"锁定"
- **Notch→癌症治疗**：[PMC综述](https://pmc.ncbi.nlm.nih.gov/articles/PMC10912471/) — Notch通路作为癌症治疗靶点
- **CARDIB反向免疫**：[ScienceDaily 2026-06-30](https://sciencedaily.com/releases/2026/06/260630020534.htm) — 海葵的替代免疫架构
- **Nematosomes选择性吞噬**：[idw-online 2026-07-16](https://idw-online.de/de/news?id=874653) — 海葵的先天免疫不是无差别攻击

---

## 4. 与提权式成长范式的对接

海葵叙事是[提权式成长范式](../Core_Mechanics/Privilege_Escalation_Paradigm.md)的第一个完整叙事实现：

1. **发现权限差异**：海葵v0.1有root，人类v2.0被锁 → 玩家理解"为什么我不能再生"
2. **理解锁的本质**：lockdown loop是防癌的feature，不是bug → 玩家理解"为什么不能简单解锁"
3. **面对镜像敌人**：Umin用同一技术做exploit，玩家做restore → 玩家理解"敌人不是邪恶，是镜像"
4. **做出伦理抉择**：用敌人的研究治病？ → 玩家理解"提权不是免费的"
5. **执行精确操作**：通过Notch 8把锁的守门神玩法 → 玩家理解"提权需要精确，不能暴力破解"

---

## 5. Umin Archaeology Division背景

> 详见：`SoMe_Universe_Git/Factions/Umin_Archaeology_Division.md`

- 格言："In the beginning, there was sulfur."
- 职能：极端环境探索，祖先技术回收
- 4个考古遗址：热泉/高盐湖/无氧区/酸性温泉
- 3层原始技术：基础代谢/高级酶/极端生存
- 与AAA敌对：AAA视古细菌技术为"危险的退化"，主动摧毁考古遗址

海葵研究属于Archaeology Division的扩展任务——从古细菌扩展到最古老的动物门类，寻找碳基OS的早期版本。

---

## 文档关联

- **提权式成长范式**：`SoMe_Design/Core_Mechanics/Privilege_Escalation_Paradigm.md`
- **Notch锁系统+守门神玩法**：`SoMe_Design/Combat_System/Notch_Lock_System.md`
- **碳基赛博空间框架**：`SoMe_Design/Carbon_Based_Cyberspace.md`
- **Umin Archaeology Division档案**：`SoMe_Universe_Git/Factions/Umin_Archaeology_Division.md`
- **Umin主阵营档案**：`SoMe_Design/Factions/Umin_The_Unseen_Crown.md`
