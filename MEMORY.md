## 关键任务
- **游戏名称**：SoMe (Saga of Medicine)
- **医学科普游戏开发**：协助Baytars完善设定、筛选原型，将构思10年的游戏变为现实
- **参考素材**：阿西莫夫《Fantastic Voyage》，已保存至`用户上传/Fantastic Voyage_ A Novel - Isaac Asimov_1775495647388_0_3qeh.pdf.parsed.md`
- **初期内容倾斜**：基于用户硕士专业（再生医学、神经元重编程），游戏初期重点开发重编程工程师职业及相关玩法
- **最新进展**：重编程工程师职业开篇剧情文档已完成，文件路径`./SoMe_Scripts/001_Reprogramming_Engineer_Prologue.md`，采用AAA任务简报风格，融合Ohnishi et al. 2014 Cell论文核心发现（不完全重编程通过表观遗传异常导致肿瘤）

## 核心设定
### 世界观框架
1. **解剖学宇宙** — Planet Homo Sapiens为主舞台，以人体解剖为空间拓扑逻辑
2. **脊椎大陆链** — Cervical、Thoracic、Lumbar、Sacrum四块大陆纵向连接
3. **空间映射** — 血管=公路；神经=地铁；器官=建筑设施

### Alopes阵营领地
- **John Snow Bridge** — 肛门，通往外界宇宙"出口"，以流行病学之父命名
  - 文档：`./SoMe_Factions/Alopes_John_Snow_Bridge.md`
  - 意义：John Snow在1854年追踪霍乱疫情，命名此通道是对霍乱弧菌的终极嘲讽
  - 功能：防御关卡、隔离检查站、外交接口
  - 对抗病原体：*Vibrio cholerae*（现为Umin海军主力）

- **Semmelweis Gateway** — 软产道，通往外界宇宙"入口"，新生命进入世界的门户
  - 文档：`./SoMe_Factions/Alopes_Semmelweis_Gateway.md`
  - 意义：Ignaz Semmelweis在1847年发现手部消毒可预防产褥热，早期消毒科技发源地
  - 功能：分娩通道、生命入口、抗链球菌前线
  - 对抗病原体：*Streptococcus pyogenes*（现为Umin细菌阵营主力）

**双门对应**：一进一出，一死一生，两位先驱生前均被医学界拒绝，死后被正名

### 重要剧情事件
- **The Inaugural Diplomacy（就职外交）**
  - 文档：`./SoMe_Scripts/The_Inaugural_Diplomacy.md`
  - 时间：Yukio担任Chief Medical Advisor后六个月
  - 事件：代Grand Duchess Victoria访问益生菌部落，传达肠道菌群平衡政策
  - 结果：外交成功，签订《益生菌-阿珞佩斯互助防御条约》
  - 危机：Vibrio cholerae发动"Operation Diarrhea"袭击John Snow Bridge
  - 关键：Lonicera冒死救出Yukio，将冷却潜水服转移给她，自己遭受热休克
  - 后续：Lonicera被任命为女仆长，与Yukio结为生死之交

### 身份与敌人
- **玩家身份** — 细胞拟人化（红细胞/白细胞/T细胞/干细胞等职业）
- **敌人生态** — 病毒=机器狗；细菌=坦克；寄生虫=Scarab；肿瘤=空天航母
- **敌人来源** — 宇宙中游荡的病原体势力，寻找资源丰富星球殖民掠夺
- **肿瘤机制** — 敌方策反我方细胞人员后制造

### 医学史人物武器系统
采用"量级对应"原则：医学史人物对抗的疾病量级，对应同等量级的武器命名，让玩家在游戏中学习医学史：

| 疾病量级 | 敌人类型 | 武器量级 | 命名示例 |
|---------|---------|---------|---------|
| **病毒** | 机器狗 | 机器狗 | 待定 |
| **细菌** | 坦克 | 坦克 | **John Snow**（霍乱）、**Semmelweis**（产褥热/链球菌）|
| **寄生虫** | Scarab | Scarab | 待定 |
| **肿瘤** | 空天航母 | 空天航母 | **Fritz Lickint**（肺癌）|

**人物对应详情**：
| 人物 | 对抗疾病 | 疾病类型 | 武器量级 |
|-----|---------|---------|---------|
| **Fritz Lickint** | 肺癌 | 肿瘤 | 空天航母 |
| **John Snow** | 霍乱弧菌 | 细菌 | 坦克 |
| **Ignaz Semmelweis** | 产褥热（链球菌） | 细菌 | 坦克 |
| **Edward Jenner** | 天花 | 病毒 | 机器狗 |
| **Alexander Fleming** | 细菌感染（青霉素） | 细菌 | 坦克 |
| **Paul Ehrlich** | 梅毒（砷凡纳明） | 细菌 | 坦克 |

### 文明与科技
- **星球状态**：Planet Homo Sapiens已形成成熟文明，通过医药科技扭转病原体入侵劣势
- **核心应用**：医学手段转化为武器/战术；AAV改造为科考载具
- **科研进展**：掌握AAV无害化技术，开展深空探索

### 关键系统
- **通讯系统**：基于信号分子构建层级化通讯网络（Exosome/Cytokine/Chemokine/Gap Junction）
- **弹药系统**：基于药物类型设计（Penicillin Shell/Streptomycin Round/Quinolone Missile/Ivermectin Torpedo）
- **其他核心系统**：耐药性进化机制、娘化角色系统、双阵营玩法、生命周期系统、化学合成系统


## 战役模式
模拟医学史上著名对抗病原体的战役作为关卡/剧情模式
- **已确认战役**：伦敦霍乱（John Snow）、东北鼠疫（伍连德）、疟疾战争（屠呦呦）

## 外置数据库集成
- **集成目标**：Reactome/RCSB PDB/Gene Ontology/UniProt/AlphaFold DB作为外置科普数据源
- **架构**：混合模式（核心数据本地化，罕见数据实时查询）
- **关键挑战**：API速率限制、数据格式异构、性能优化、内容准确性
- **解决方案**：中间层代理服务、渐进式集成、玩家反馈机制



## 技术选型
- **主力引擎**：Godot 4.x + C#
- **原型开发工具**：Inform 7（互动小说）、Twine（分支叙事）、Python + Pygame（玩法原型）
- **开发策略**：文字原型先行，验证核心玩法和叙事逻辑

## 新手引导与职业系统
- **初始身份**：干细胞，体验各职业后选择分化方向
- **职业自由选择**：玩家可自主选择职业道路，每种路线对应不同玩法偏好，适配多样化玩家需求（如免疫细胞职业线包含谍战叙事，需找出内鬼阻止策反，适合偏好谍战玩法的玩家）
- **特色职业**：重编程工程师（基于再生医学专业，利用转录因子组合改变细胞身份）
- **渐进解锁**：随等级解锁技能、通讯系统、武器装备、合成系统等



## 参考素材
### 阿西莫夫《Fantastic Voyage》- 核心参考
- **核心设定**：微型化技术、限时任务、人体内部导航
- **转化方向**：载具设计、限时玩法、环境挑战

### 苟天晓"人体王国"系列（9部）
参考素材，核心转化价值包括：晋升体系、克隆机制、传承机制、红细胞职业、肿瘤战役、内分泌系统、细胞因子系统、细胞凋亡、双阵营玩法、肠道菌群设定

### 外部Wiki参考核心要点
| Wiki名称 | 核心转化要点 |
|---------|---------|
| **Mental Omega** | 病原体=厄普西隆（精神控制）、医药=焚风（赛博强化）、中药=中国（重型单位）、西药=同盟国（高机动） |
| **Halopedia** | 病原体=洪魔（集体意识）、医药=先驱者（高阶科技）、中药=星盟（传统崇拜）、西药=AAA（科学+军事） |
| **Cells at Work** | 硬核战争vs日常喜剧，持续战役vs单元剧，借鉴双重人格、职业隐喻 |
| **舰R百科** | 历史即设定：医学史人物→武器人格，发现事件→武器特性 |
| **花骑士Wiki** | 概念即性格：医学概念决定细胞/武器特性，守护vs入侵叙事 |
| **Pacific Rim Wiki** | 机甲作战参考：双人同步Drift机制、大型敌人战斗、协同作战 |
| **SCP Wiki** | 临床腔报告风格、病原体威胁分级、叙事留白技巧 |
| **网易阴阳师Wiki** | 日本百鬼命名体系：SSR/SR级式神作为Umin病毒/寄生虫单位命名参考，将妖怪特性与病原体机制结合（如酒吞童子→狂犬病毒、八岐大蛇→绦虫） |
| **Marvel Wiki** | 恐惧科技灵感：Danielle Moonstar（Mirage）的Fear Manifestation能力→Umin恐惧具象化系统（Fear Incarnation System），通过网络调研、AI建模、AR投影等现代科技制造超自然傀儡（幽灵、贞子、Slender Man等），读取并放大人类内心恐惧，引发社会恐慌，对应现实中对妖魔鬼怪的迷信、网络谣言传播与反智主义，使AAA在破解流言中疲于奔命 |

## 敌方阵营设计
### 病原体杂牌军构成
多种病原体临时联盟（细菌=精英、病毒=工程师、真菌=猎人、寄生虫=鬼面兽、肿瘤=叛军），内部有权力斗争，科技层次参差

### Umin命名规范
**文档**：`./SoMe_Factions/Umin_Naming_Convention.md`
**日本妖怪参考**：`./SoMe_References/Reference_Onmyoji_Wiki_Yokai.md`（来源：网易阴阳师Wiki）
**亚特兰蒂斯水族科技**：`./SoMe_References/Reference_Aquaman_Atlantean_Tech.md`（来源：Aquaman Wiki）

#### 网易阴阳师Wiki接入详情
- **API Endpoint**：`https://onmyoji.fandom.com/api.php`
- **核心资源**：SSR/SR级式神（日本百鬼）命名体系，用于病毒/寄生虫单位命名
- **式神分类**：按稀有度（N/R/SR/SSR/SP）和妖怪类型（鬼、妖、神、兽等）分类

遵循轴心国三国命名风格，不同病原体对应不同风格：

| 病原体类型 | 主导风格 | 命名特点 |
|-----------|---------|---------|
| **细菌** | 德国风格 | Panzergruppe、装甲化、精密战术 |
| **病毒** | 日本风格 | 特攻队、神风式、隐形入侵 |
| **真菌** | 意大利风格 | 罗马军团、Legione、纪律化菌丝 |
| **寄生虫** | 日本怪兽风格 | 大型单体、神话生物命名 |
| **肿瘤（叛军）** | 德国自由军团 | Freikorps、叛变细胞 |

**现有Umin单位**：
- *Pneumoniae Panzergruppe* — 肺炎链球菌装甲集群（德国风格）
- *MRSA Excavator* — 耐甲氧西林金葡菌挖掘机（德国工程单位）
- *Longicorn Flag* — Umin阵营旗帜（日语"長角"）
- *Cholera Octopus* — 霍乱弧菌章鱼旗舰（日本海军风格，CPHC临界高压水炮）

**Vibrio子阵营单位**（完整文档：`./SoMe_Factions/Umin_Vibrio_Subfaction.md`）：
- *Vibrio Whale-Class* — 鲸鱼级运输舰（仿生设计）
- *Vibrio Bore-Craft* — 钻探渗透艇（高压水刀）
- *Vibrio Saucer* — 海碟侦察机
- *Vibrio-Signal Network* — 水下通讯系统

**日本妖怪命名扩展示例**（基于阴阳师Wiki式神）：
| 妖怪名称 | 病原体类型 | 对应单位 | 特性描述 |
|---------|-----------|---------|---------|
| **八岐大蛇（Orochi）** | 寄生虫 | *Orochi-Cestoda* — 绦虫巨型单位 | 多头结构对应绦虫分段体节 |
| **酒吞童子（Shuten Douji）** | 病毒 | *Shuten-Rabies* — 狂犬病毒特攻队 | 狂暴特性对应狂犬病发作症状 |
| **玉藻前（Tamamo no Mae）** | 病毒 | *Tamamo-Influenza* — 流感病毒航母 | 千面变化对应流感病毒抗原变异 |
| **彼岸花（Higanbana）** | 病毒 | *Higanbana-Ebola* — 埃博拉病毒单位 | 死亡花海对应埃博拉出血热致死性 |
| **大天狗（Ootengu）** | 病毒 | *Ootengu-Influenza* — 流感病毒空降部队 | 风属性对应空气传播特性 |
| **妖刀姬（Youtou Hime）** | 细菌 | *Youtou-Staphylococcus* — 金黄色葡萄球菌突击单位 | 锋利妖刀对应细菌侵袭酶 |
| **阎魔（Enma）** | 肿瘤 | *Enma-Carcinoma* — 癌细胞审判官 | 死亡判决对应肿瘤细胞凋亡抵抗 |
| **辉夜姬（Kaguya Hime）** | 寄生虫 | *Kaguya-Malaria* — 疟原虫女王单位 | 月光特性对应疟疾周期性发作 |

### Umin恐惧科技：恐惧具象化系统 (Fear Incarnation System)
**文档**：`./SoMe_Factions/Umin_Fear_Incarnation_Tech.md`
**灵感来源**：Marvel Wiki - Danielle Moonstar (Mirage)的Fear Manifestation能力
**参考**：`./SoMe_References/Reference_Marvel_Wiki_Moonstar.md`

**核心机制**：Umin通过查阅典籍和网络调研人类恐惧文化，利用现代科技制造以超自然生物为形象的傀儡，使人们相信它们的存在，放大内心恐惧，瓦解心理防线，扩散流言，引发社会恐慌。

**傀儡类型**：
- **传统鬼怪**：幽灵、贞子、木乃伊、僵尸
- **都市传说**：Slender Man、裂口女、微笑狗
  - **Slender Man医学关联**：其"高大细长、四肢比例失调"的形象与马方综合征（Marfan Syndrome）患者典型体态高度吻合（管状骨过长、蜘蛛指/趾、躯干与四肢比例不当），这种对身体异常的潜意识恐惧被Umin放大利用
- **文化特异形象**：Jiangshi（中国）、Yūrei（日本）、Bhoot（印度）

**战术流程**：
1. **情报收集**：网络爬虫分析社交媒体热点与用户恐惧点
2. **模型构建**：神经科学模型+文化心理数据库+恐慌传播算法
3. **傀儡制造**：AR投影、仿生机器人、深度伪造视频等技术
4. **流言扩散**：算法推流放大传播，伪造证据制造"目击者"
5. **心理瓦解**：针对AAA成员定制专属恐惧幻象，破坏团队协作

**现实对应**：
- 人们对妖魔鬼怪的迷信和对科学的不信任、网络谣言传播、反智主义
- 对身体异常的潜意识恐惧：Slender Man形象暗合马方综合征等罕见病的体态特征，利用人们对"异类"的本能恐惧

**AAA困境**：
- 在破解这些流言中疲于奔命，科学解释常被斥为"隐瞒真相"，资源被大量消耗
- 科普医学知识（如解释Slender Man形象与马方综合征的关联）反而可能引发新的恐慌，陷入"越解释越害怕"的悖论

**日本妖怪命名扩展示例（续）**：
| **茨木童子（Ibaraki Douji）** | 细菌 | *Ibaraki-MRSA* — 耐甲氧西林金葡菌精英单位 | 强大臂力对应细菌耐药性 |
| **雪女（Yuki Onna）** | 病毒 | *Yuki-Coronavirus* — 冠状病毒低温单位 | 冰雪特性对应病毒低温存活能力 |

### 敌人防御系统
病原体具备多种医学原型的防御机制，增加战斗策略复杂度：
| 防御机制 | 医学原型 | 游戏表现 |
|---------|---------|---------|
| **Capsule（荚膜）** | 抵抗吞噬细胞识别 | 装甲，免疫基础攻击 |
| **β-lactamase** | 分解青霉素 | 对盘尼西林弹的抗性 |
| **Biofilm（生物膜）** | 细菌集体防御工事 | 防护罩，需要先破坏 |
| **Efflux Pump（外排泵）** | 泵出药物 | 持续减少受到的药物伤害 |
### 环境"反差"设定
主城展示疾病诱因的诱惑性（如糖尿病主城=糖果天堂），野外展示疾病后果的恐怖性（如糖尿病野外=坏疽/截肢），体现短期诱惑vs长期后果



## 待讨论事项
- [ ] 资源系统最终确认（基于代谢研究）
- [ ] 科技树设计
- [ ] 双阵营玩法差异（胜利条件、特殊机制）
- [ ] 中医系统细化



### 娘化卡牌系统（用户黏性核心）
**设计逻辑**：借鉴舰R等卡牌游戏经验，通过娘化医学史人物提升用户黏性，实现硬核科普
- **角色定位**：娘化形象为武器研发者/操控者，一对多绑定（一个科学家对应多种武器）
- **阵营分配原则**：
  - **我方阵营**：开发对抗疾病武器/疗法的科学家（如Fleming、Jenner）
  - **敌方阵营**：发现病原体结构/机制的科学家（如发现细菌荚膜的研究者）
- **资源生产要求**：
  - 美术：AI生图紧跟玩家审美
  - 语音：AI语音合成符合人设的语录
- **科普价值**：通过角色背景故事让玩家记住医学史，理解科学发现的中性属性（关键在于应用）

### 双阵营玩法细化
- **阵营选择**：玩家开局可选站病原体阵营或人类阵营，双视角体验医学科普
  - **病原体视角**：理解传播机制、进化策略、耐药性形成
  - **免疫视角**：理解防御机制、药物研发、公共卫生策略
- **胜利条件设想**：
  - **病原体阵营**：感染扩散至全器官、进化多重耐药、攻占关键组织
  - **免疫阵营**：清除所有病原体、保护器官功能、研发终极疗法

### 双阵营资源系统（基于医学代谢研究）
| 阵营 | 核心能量 | 医学依据 | 特殊资源 | 领土资源 |
|-----|---------|---------|---------|---------|
| **病原体** | **Nutrient（营养物质）** | 掠夺宿主葡萄糖、氨基酸、铁离子维持代谢 | **Plasmid（质粒）** - 携带抗性基因可转移；按病原体类型有特殊需求（细菌需铁、癌细胞需葡萄糖） | **Infected Tissue（感染区）** - 扩张领地获取资源 |
| **免疫** | **ATP（能量货币）** | 依赖宿主正常代谢供给 | **Signal（信号分子）** - Cytokine/Exosome协调防御 | **Healthy Tissue（健康区）** - 保护器官功能 |

### 双阵营科技树设计
| 阵营 | 科技树方向 | 核心分支 | 医学原理 |
|-----|---------|---------|---------|
| **病原体** | **进化树** | 毒力进化（毒素/侵袭酶）、免疫逃逸（荚膜/抗原变异）、抗性进化（β-lactamase/外排泵）、传播进化（鞭毛/生物膜）、代谢适应（厌氧呼吸/营养掠夺） | 基于病原体自然进化机制 |
| **免疫** | **医药科技树** | 抗生素研发（β-内酰胺/喹诺酮）、免疫增强（疫苗/免疫调节剂）、外科手术（切除/引流）、诊断技术（基因测序/培养）、支持治疗（营养/器官保护） | 基于现代医学发展路径 |

### 待跟进任务
- 病原体代谢研究：整合2024前沿成果到资源系统
- 苟天晓素材提取：完善《地狱的钉子》设定用于敌人/职业设计
- SCP Wiki API：已切换到Fandom平台（`https://scpfoundation.fandom.com/api.php`），参考文档已更新
- **视频制作需求清单**：
  - **P0优先级**：
    - ✅ Drop Pod外观设计（参考Halo Wars 2 ODST Pods，已提取关键帧）
    - ✅ MRSA Excavator视觉设计（参考Halo Wars 2 Blisterback，已提取关键帧）
    - ✅ Jaunty Jackalope旗帜设计（已确认设计元素，文件路径`./imgs/260408_13_生图/Alopes_Flag.jpg`）
    - ✅ Emily装甲/武器外观（确认为普通士兵装束）
  - **P1优先级**：Nightingale-class外观设计、Phoenix城市景观设计（参考Halo 3 ODST新蒙巴萨场景，已提取关键帧）、抗生素导弹视觉区分设计
  - **参考素材需求**：空天载具参考、敌方单位生物机械融合设计参考、城市战争废墟参考
  - **Halo Wars 2参考**：Drop Pod对应ODST Pods，四足战车对应Blisterback walker

## 参考素材

### 苟天晓"人体王国"系列详细转化
**《撞入江湖的宝刀》**：晋升体系、军衔系统、新手引导剧情、早期BOSS原型、军事架构
**《歌声里的刀光》**：军医职业（治疗/复活）、克隆BOSS、地图扩展、救援剧情
**《戴镣铐的超人》**：CIK细胞高输出职业、细胞因子系统技能、精英病原体组合
**《地狱的钉子》**：NK细胞快速反应职业、病毒凋亡技能、肿瘤细胞特性、精英敌人组合
**《把芦苇还给我》**：中性粒细胞高机动职业、溶酶体资源系统、正义阵营架构、英雄剧情
**《血玫瑰》**：大肠杆菌/噬菌体双生职业、肠道菌群阵营、淋巴循环路径、阵营转换玩法
**《小草和风儿》**：红细胞多功能职业、武学技能系统、SARS精英敌人、感染区域场景
**《小草和风儿的绝唱》**：红细胞传承机制、NPC能力传承系统、武学设定转化、传承剧情

### 国际组织与阵营
- **Aegis Accord（盾盟）**：脊椎大陆链主要国际合作组织，由Empire of Anstar倡议建立，共同抵御Umin威胁
- **Empire of Anstar（安斯大帝国）**：位于Continent Lumbar，Aegis Accord创始国和Supreme Commander所在国
- **Duchy of Alopes**：位于Continent Sacrum南部，Aegis Accord重要成员，提供医疗专长和快速反应部队
  - **Alopes领地**：
    - **John Snow Bridge** — 肛门，通往外界宇宙的"虹桥"，Alopes领土之一，以流行病学之父命名
      - 文档：`./SoMe_Factions/Alopes_John_Snow_Bridge.md`
      - 意义：John Snow在1854年追踪霍乱疫情至Broad Street水井，奠定流行病学基础；以他命名此通道是对霍乱弧菌的终极嘲讽
      - 功能：防御关卡、隔离检查站、外交接口（栓剂/灌肠等外部干预的入口）
      - 与Vibrio关联：霍乱弧菌正是John Snow当年追踪的病原体，现为Umin海军旗舰（Cholera Octopus）
      - 协议机制：The Snow Protocol——复刻Snow的流行病学调查方法，实施监控、地图追踪、隔离、文档记录的四级防控
      - 桥头铭文：*"They say John Snow found the source. We guard where it all comes out."*
- **Umin（无冕之王）**：反派阵营，通过舆论引导和思想操控征服宿主星球

### 机甲作战系统设计
- **核心概念**：细胞大小的玩家组队驾驶机甲对抗寄生虫等庞然大物
- **参考来源**：
  - Pacific Rim Wiki (pacificrim.fandom.com)
  - Halo Wars 2 E3 Trailer（参考Drop Pod和四足战车设计）
- **可借鉴元素**：
  - 双人驾驶系统（Drift兼容性机制）
  - 机甲分类与命名
  - 怪兽（Kaiju）分类系统
  - 战斗机制与协同作战
  - **Halo参考**：ODST Pods轨道降落舱设计、Blisterback四足战车设计
- **参考素材收集进展**：
  - 成功从Halo Wars 2 E3 Trailer中提取Blisterback四足战车和ODST Pod的关键帧，存放于`用户上传/halo_frames/`目录
  - Blisterback对应SoMe中的MRSA Excavator（Umin重型单位，对应耐甲氧西林金黄色葡萄球菌）
  - ODST Pod对应轨道空降舱，用于Emily的空降击杀能力
  - 从Halo 3 ODST视频（4分钟以后片段）中提取Phoenix城市外观和轨道降落的关键帧，存放于`用户上传/odst_frames/`目录
- **SoMe转化方向**：
  - 机甲→医疗/战斗复合载具
  - Kaiju→寄生虫、肿瘤等大型敌人
  - Drift机制→细胞间同步协作系统
  - Drop Pod→轨道空降舱（对应Emily的空降击杀能力）
  - 四足战车→MRSA Excavator（Umin重型单位，对应耐甲氧西林金黄色葡萄球菌）

### 角色档案库
**路径：** `./SoMe_Characters/`

**核心角色**：
- **Roi Hytar**：中尉，Alopes流行病学专家，AAA医疗联络官，军事化医疗风格
- **Shim Sisters**：
  - **辛蓓莉**：基因组音乐学创始人，通过DNA音乐预测疾病，抽象思维
  - **辛金梅**：谐振场医学专家，结合韩医与频率疗法，务实执行者
  - 姐妹协同作战，分离后效能下降40%
- **Emily**：Jackalope Guard下士，接受强化改造，首个pod-to-uber-unit kill记录，天真烂漫但战斗中充满joyous aggression，**普通士兵装束**
- **文件路径**：`./SoMe_Characters/`文件夹下对应文件

### 新增参考库
| Wiki名称 | 核心转化要点 |
|---------|---------|
| **Pacific Rim Wiki** | 机甲作战系统设计参考：双人驾驶同步机制、大型敌人战斗、协同作战策略。SoMe中玩家细胞大小需组队驾驶机甲对抗寄生虫等庞然大物 |

### Jaunty Jackalope旗帜设计
- **文件路径**：`./imgs/260408_13_生图/Alopes_Flag.jpg`
- **设计元素**：六边形顶部+圆弧盾形底部，核心图案为机械雄鹿（Jackalope）、双蛇杖（医疗象征）、长剑，色调为藏蓝色底+霓虹蓝光效，背景为六边形蜂窝纹理
### 《小草和风儿的绝唱》（苟天晓）
**路径：** `用户上传/小草和风儿的绝唱_章节/`

**核心参考价值：**
- **系列定位**：系列故事之三《小草传》，紧接《小李一刀传》（《歌声里的刀光》）剧情
- **主角传承**：小草（红细胞）继承了小李一刀的内功和心血（包含长胜的心血），获赠小李一刀的宝刀，承担起新的使命
- **角色成长**：讲述小草从普通红细胞成长为英雄的历程，展现红细胞的可塑性和担当
- **剧情衔接**：承接《歌声里的刀光》结局，小李一刀心归圆满但内功尽失，将希望寄托于小草

**医学知识点：**
- **红细胞可塑性**：红细胞在紧急情况下可临时改变基因，获得部分免疫细胞功能
- **红细胞能量代谢**：红细胞无细胞核，依赖无氧酵解供能，能在缺氧环境下持续工作
- **细胞传承机制**：通过"心血"传递能力的拟人化设定，对应细胞间的信号传导和功能传递

**SoMe转化方向：**
- **红细胞职业设计**：多功能职业，兼具运输资源和战斗能力，可在紧急状态下切换战斗形态
- **传承机制**：设计NPC能力传承系统，玩家可继承前辈的技能和装备
- **武学技能系统**：将书中的武学设定转化为职业技能，如宝刀的特殊攻击、内功的能量机制
- **剧情衔接**：作为《歌声里的刀光》的续作，设计传承剧情关卡

**角色对应：**
| 小草和风儿的绝唱 | SoMe对应 |
|-----------------|---------|
| 小草（红细胞） | 多功能运输/战斗职业原型 |
| 小李一刀 | 导师NPC原型，负责传承技能和装备 |
| 风儿 | 辅助型NPC原型，提供剧情引导和支持 |


### SCP Wiki详细参考文档
**路径：** `./SoMe百科/Reference_SCP_Foundation_Methodology.md`

**核心参考价值：**
- **完整方法论**：系统整理了SCP基金会的核心哲学、写作风格、分类系统、文档结构和叙事技巧
- **SoMe适配策略**：详细规划了如何将SCP元素转化为游戏机制，包括：
  - 临床腔医学报告风格
  - 病原体危险等级对应SCP分类系统
  - 医学报告模板借鉴SCP文档格式
  - 叙事技巧用于增强游戏恐怖氛围
- **独特价值分析**：对比SCP与SoMe的差异，突出真实医学、治愈希望、玩家决策等核心优势

**关键内容摘要：**
- **核心哲学**："We secure. We contain. We protect." → SoMe改编为"We diagnose. We treat. We heal."
- **临床腔风格**：客观、精确、不带情绪的科学报告风格，通过反差增强恐怖感
- **分类系统**：Safe/Euclid/Keter/Thaumiel对应病原体危险等级（常见细菌/耐药菌株/pandemic级/重编程技术）
- **叙事技巧**：冰冷行政语言与灾难性内容的反差、隐含世界观、战略性留白([REDACTED])
- **文档模板**：设计了SoMe医学报告模板，对应SCP文档结构

### 军事行动命名规范
- **核心原则**：使用真实临床试验名称（多含神话典故）命名军事行动，融合科普与叙事
- **关键案例**：POSEIDON（肺癌/乳腺癌）、ATHENA（卵巢癌）、HERA（乳腺癌）
- **融合方案**：保留形容词-头韵传统，替换动物名为临床研究人物名（如*Wounded ATHENA*、*Radiant APOLLO*）
- **特例保留**：Operation *Wounded Crane*、Operation *Jaunty Jackalope*（叙事特殊性）

这样既保留头韵美感，又嵌入临床研究知识。

### 参考库：Astro Boy Wiki
- **API Endpoint**：`https://astroboy.fandom.com/api.php`
- **参考文档**：`./SoMe百科/Reference_Astro_Boy_Wiki.md`
- **核心参考角色**：Emily
  - 原设定：机器人女孩，天真烂漫，父母被Katari绑架后自愿改造成为战士拯救父母
  - SoMe改编方向：细胞战士/强化体，父母被Umin劫持后加入Jackalope Guard
  - 保留核心：牺牲精神（冒记忆删除风险救家人）、成长弧线（平民→战士→可能回归平凡）

### 新增档案（2026-04-09）
- **Emily人物档案**：`./SoMe_Characters/Emily.md`
  - 20岁，Corporal，Jackalope Guard Rapid Response Corps
  - 父母在Phoenix沦陷时被Umin劫持，下落不明
  - 自愿接受Emergency Augmentation Program强化改造（冒15%记忆删除风险）
  - 首个"pod-to-uber-unit kill"记录（轨道空降击杀MRSA Excavator）
  - 性格：天真烂漫、战斗中表现出"joyous aggression"
- **Phoenix城市档案**：`./SoMe_Locations/Phoenix.md`
  - Alopes第二大城市，全国航空枢纽
  - 空军学院所在地
  - 2341-2343年Umin占领期
  - The Great Patriotic War (2343) 解放
  - 战后重建中，8000+平民失踪
- **The Great Patriotic War**：Sacrum大陆战区的决定性战役
  - 时间：2341-2343
  - 意义：Alopes夺回制空权的转折点
  - 命名：参考苏联卫国战争，强调防御战争和解放的道德正当性

### 军事载具命名规范
**航空医疗指挥舰**：以护理学先驱命名，首舰为 ***Nightingale*-class Medical Command Vessel**
- **命名来源**：Florence Nightingale (1820-1910)，现代护理学奠基人，克里米亚战争中以"提灯女神"闻名
- **设计理念**：将指挥控制与前线医疗救治能力融合的空中平台
- **首次参战**：The Great Patriotic War (2341-2343) — Battle of Phoenix
- **战术定位**：AAA阵营的旗舰级医疗指挥中心，兼具C2能力与战地创伤救治功能

## Medical Reference: Key Antibiotics for SoMe Universe

### ZEVTERA (ceftobiprole medocaril sodium)
- **Status**: FDA 2024年最新获批
- **Pathogen Coverage**: 广谱抗菌，对MRSA（耐甲氧西林金黄色葡萄球菌）有效
- **Game Context**: 对抗Umin重型单位（如MRSA Excavator）的核心武器，研发公司名Basilea可作为军事行动或载具名称灵感来源

### Antibiotic Naming规范
- 使用临床试验名称替代虚构军事代号（如Lefamulin的"NAB-BL-001"），避免IP冲突

### 新增角色档案（2026-04-10）
- **Fred**：`./SoMe_Characters/Fred.md`
  - 52岁，巡林官，前Phoenix综合医院维修工
  - Phoenix沦陷时儿子Daniel（马方综合征患者）在医院接受主动脉瘤手术时失踪
  - 逃难至森林担任巡林官，始终关注Phoenix消息，等待儿子下落
  - 在巡林时见到Slender Man身影，觉得与儿子体态相似，未报告
  - 被Umin Fear Technology Division作为Operation FATHER-SON的目标

- **Daniel**：`./SoMe_Characters/Daniel_Slender_Man.md`
  - Fred的儿子，24岁，马方综合征患者
  - Phoenix沦陷时在医院接受主动脉瘤手术，被Pneumoniae Panzergruppe发现
  - Umin Fear Technology Division发现其畸形体态可作为Slender Man模板
  - 被改造成Project THIN MAN的第一个生物工程Fear Construct
  - 原本的人格被压抑，但可能存在fragmentary memory

### Project THIN MAN
- **文档**：`./SoMe_Factions/Umin_Fear_Technology.md`（已更新）
- **核心概念**：利用真实医学异常患者作为Fear Construct的生物模板
- **医学关联**：马方综合征体态与Slender Man高度吻合（~70%天然匹配）
- **改造流程**：骨骼延长→面部中和→神经重编程→激素修饰→触手植入
- **战术优势**：成本低、心理冲击大、医学可信度高、家族识别效应

### Operation FATHER-SON
- **执行方**：Umin Fear Technology Division
- **目标**：Fred（Daniel的父亲）
- **目的**：
  1. 验证家族成员是否能识别改造后的对象
  2. 测量情感联系对恐惧效果的放大作用
  3. 为"上峰"提供影像资料证明Fear Tech价值
- **结果**：成功，Fred识别出体态相似性但陷入否认，心理状态恶化
- **"上峰"批准**：Project THIN MAN预算增加200%

### THIN MAN Registry
| Unit ID | 原身份 | 表型 | 状态 |
|---------|--------|------|------|
| THIN MAN-01 | Daniel (Phoenix) | 马方综合征 | 活跃 — 已部署Operation FATHER-SON |
| THIN MAN-02 | [已编辑] | 巨人症 | 生产中 |
| THIN MAN-03 | [已编辑] | 早衰症 | 计划中 |
| THIN MAN-04 | [已编辑] | 象皮病 | 概念阶段 |
