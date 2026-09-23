# SoMe 细菌单位底层数据库架构

> **文档级别**：Canonical  
> **创建日期**：2026-07-13  
> **版本**：v1.0  
> **关联设计**：数值锚定真实生物 / 暗度陈仓策略 / 碳基生物朋克美学  

---

## 1. 设计目标

SoMe 中每个细菌单位（敌方/中立/可交互NPC）的**外观、属性、技能、部署位置**都必须有真实生物学数据支撑。本文档定义底层数据库选型、API接口规范、数据映射规则和管线架构。

**核心原则**：
- 数值不是拍脑袋填的，每个 `game_stats` 字段都能溯源到原始数据库字段
- 构建时拉取API数据落盘为本地JSON，运行时游戏引擎只读本地文件
- 三层叠加：表型层（BacDive）+ 临床层（BV-BRC）+ 分类层（NCBI Taxonomy）

---

## 2. 三层数据库架构

```
┌─────────────────────────────────────────────────────┐
│                  SoMe 细菌单位定义                    │
│              game_units/*.json（运行时）               │
├─────────────────────────────────────────────────────┤
│  表型层          │  临床层          │  分类层         │
│  BacDive        │  BV-BRC          │  NCBI Taxonomy │
│  形态/代谢/培养   │  毒力/耐药/血清型  │  lineage/命名   │
│  REST API v2    │  REST API + RQL  │  E-utilities   │
│  免注册          │  OAuth 2.0       │  免注册         │
└─────────────────────────────────────────────────────┘
```

| 层 | 数据库 | 职责 | 认证 | 格式 |
|---|---|---|---|---|
| 表型层 | [BacDive](https://bacdive.dsmz.de/) | 形态、代谢、培养条件、酶活性、生态位 | 免注册（2026.2起） | JSON |
| 临床层 | [BV-BRC](https://www.bv-brc.org/) | 毒力因子、耐药基因、血清型、宿主信息 | OAuth 2.0 Bearer Token | JSON |
| 分类层 | [NCBI Taxonomy](https://www.ncbi.nlm.nih.gov/taxonomy) | 完整分类谱系、学名、同义名 | 免注册（建议API Key） | JSON |

---

## 3. API 接口文档

### 3.1 BacDive REST API v2

**Base URL**: `https://api.bacdive.dsmz.de`

**认证**：无需认证（2026年2月起已取消注册要求）

**返回格式**：JSON

#### 端点一览

| 端点 | 方法 | 用途 |
|---|---|---|
| `/v2/fetch/{bacdive_id}` | GET | 按BacDive ID获取菌株完整详情 |
| `/v2/taxon/{genus}/{species?}/{subspecies?}` | GET | 按分类名搜索菌株列表 |
| `/v2/culturecollectionno/{no}` | GET | 按保藏号搜索（如DSM 26640） |
| `/v2/sequence_16s/{acc}` | GET | 按16S序列 accession 搜索 |
| `/v2/sequence_genome/{acc}` | GET | 按基因组 accession 搜索 |

**限制**：`/v2/fetch` 单次最多100个ID（分号分隔）

#### 示例：按物种名搜索

```bash
# 搜索 Streptococcus pneumoniae 的所有菌株
curl -s "https://api.bacdive.dsmz.de/v2/taxon/Streptococcus/pneumoniae" | jq .
```

返回（分页，每页100条）：
```json
{
  "count": 152,
  "next": "https://api.bacdive.dsmz.de/v2/taxon/Streptococcus/pneumoniae?page=2",
  "previous": null,
  "results": [
    {"bacdive_id": 1234, "url": "https://api.bacdive.dsmz.de/v2/fetch/1234"},
    {"bacdive_id": 5678, "url": "https://api.bacdive.dsmz.de/v2/fetch/5678"}
  ]
}
```

#### 示例：获取菌株完整详情

```bash
# 获取 BacDive ID 1234 的完整表型数据
curl -s "https://api.bacdive.dsmz.de/v2/fetch/1234" | jq .
```

返回（节选关键字段）：
```json
{
  "bacdive_id": 1234,
  "taxonomy_name": "Streptococcus pneumoniae",
  "species": "Streptococcus pneumoniae",
  "strain": "R6",
  "ncbi_tax_id": 1313,
  "morphology": {
    "cell_morphology": [{"value": "coccus"}],
    "cell_arrangement": [{"value": "pairs", "value2": "chains"}],
    "cell_length_um_min": 0.5,
    "cell_length_um_max": 1.25
  },
  "gram_stain": {"gram_stain": [{"value": "positive"}]},
  "physiology_and_metabolism": {
    "oxygen_tolerance": [{"value": "facultative anaerobe"}],
    "catalase": [{"value": "negative"}],
    "oxidase": [{"value": "negative"}],
    "spore_formation": [{"value": "no"}]
  },
  "culture_growth_conditions": {
    "growth_temperature": {
      "temp_min": 30,
      "temp_max": 40,
      "temp_optimum": 37
    },
    "ph_range": {"ph_minimum": 6.5, "ph_maximum": 8.0, "ph_optimum": 7.8}
  },
  "environment": {
    "isolation_source": [{"value": "respiratory tract"}],
    "habitat": [{"value": "human"}]
  },
  "references": [...]
}
```

#### TypeScript 示例

```typescript
// fetch_bacdive.ts — BacDive 表型数据拉取
import { writeFileSync, mkdirSync } from 'fs';

const BACDIVE_BASE = 'https://api.bacdive.dsmz.de/v2';

interface BacDiveSearchResult {
  count: number;
  next: string | null;
  previous: string | null;
  results: { bacdive_id: number; url: string }[];
}

interface BacDiveStrain {
  bacdive_id: number;
  taxonomy_name: string;
  morphology?: Record<string, unknown>;
  physiology_and_metabolism?: Record<string, unknown>;
  culture_growth_conditions?: Record<string, unknown>;
  environment?: Record<string, unknown>;
  [key: string]: unknown;
}

async function fetchStrain(bacdiveId: number): Promise<BacDiveStrain> {
  const res = await fetch(`${BACDIVE_BASE}/fetch/${bacdiveId}`);
  if (!res.ok) throw new Error(`BacDive fetch failed: ${res.status}`);
  return res.json();
}

async function searchBySpecies(genus: string, species: string): Promise<BacDiveSearchResult> {
  const res = await fetch(`${BACDIVE_BASE}/taxon/${genus}/${species}`);
  if (!res.ok) throw new Error(`BacDive search failed: ${res.status}`);
  return res.json();
}

// 按物种搜索并拉取所有菌株详情
async function pullSpecies(genus: string, species: string, outputDir: string) {
  mkdirSync(outputDir, { recursive: true });

  const searchResult = await searchBySpecies(genus, species);
  console.log(`${searchResult.count} strains found for ${genus} ${species}`);

  for (const { bacdive_id } of searchResult.results) {
    const strain = await fetchStrain(bacdive_id);
    const filePath = `${outputDir}/${species}_${bacdive_id}.json`;
    writeFileSync(filePath, JSON.stringify(strain, null, 2), 'utf-8');
    console.log(`  → saved ${filePath}`);
    await new Promise(resolve => setTimeout(resolve, 500)); // 限速
  }
}

// 使用
await pullSpecies('Streptococcus', 'pneumoniae', 'phenotypes');
```

---

### 3.2 NCBI E-utilities API

**Base URL**: `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/`

**认证**：无需认证；建议申请免费API Key（[此处申请](https://www.ncbi.nlm.nih.gov/account/)）将速率从3次/秒提升到10次/秒

**返回格式**：JSON（`retmode=json`）

#### 核心端点

| 端点 | 用途 |
|---|---|
| `esearch.fcgi?db=taxonomy&term=...` | 搜索分类ID |
| `efetch.fcgi?db=taxonomy&id=...` | 获取分类详情（谱系/学名/同义名） |
| `esummary.fcgi?db=taxonomy&id=...` | 获取分类摘要 |

#### 示例：搜索物种获取 TaxID

```bash
# 搜索 Streptococcus pneumoniae
curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=taxonomy&term=Streptococcus+pneumoniae&retmode=json" | jq .
```

返回：
```json
{
  "esearchresult": {
    "count": 1,
    "idlist": ["1313"]
  }
}
```

#### 示例：获取完整分类谱系

```bash
# 获取 TaxID 1313 的完整分类信息
curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=taxonomy&id=1313&retmode=json" | jq .
```

返回：
```json
[
  {
    "TaxId": "1313",
    "ScientificName": "Streptococcus pneumoniae",
    "OtherNames": {
      "Synonym": ["Diplococcus pneumoniae", "Micrococcus pneumoniae"]
    },
    "Rank": "species",
    "Lineage": "cellular organisms; Bacteria; Bacillati; Bacillota; Bacilli; Lactobacillales; Streptococcaceae; Streptococcus",
    "LineageEx": [
      {"TaxId": "131567", "ScientificName": "cellular organisms", "Rank": "no rank"},
      {"TaxId": "2", "ScientificName": "Bacteria", "Rank": "superkingdom"},
      {"TaxId": "1239", "ScientificName": "Bacillota", "Rank": "phylum"},
      {"TaxId": "91061", "ScientificName": "Bacilli", "Rank": "class"},
      {"TaxId": "186826", "ScientificName": "Lactobacillales", "Rank": "order"},
      {"TaxId": "1300", "ScientificName": "Streptococcaceae", "Rank": "family"},
      {"TaxId": "1301", "ScientificName": "Streptococcus", "Rank": "genus"}
    ]
  }
]
```

#### TypeScript 示例

```typescript
// fetch_taxonomy.ts — NCBI Taxonomy 分类数据拉取
import { writeFileSync, mkdirSync } from 'fs';

const EUTILS = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils';
const API_KEY = process.env.NCBI_API_KEY ?? ''; // 可选，有则10次/秒

interface NCBISearchResult {
  esearchresult: { count: string; idlist: string[] };
}

interface NCBITaxonNode {
  TaxId: string;
  ScientificName: string;
  Rank: string;
}

interface NCBITaxon {
  TaxId: string;
  ScientificName: string;
  OtherNames?: { Synonym?: string[] };
  Rank: string;
  Lineage: string;
  LineageEx: NCBITaxonNode[];
}

async function getTaxonomy(speciesName: string): Promise<NCBITaxon> {
  const searchParams = new URLSearchParams({
    db: 'taxonomy',
    term: speciesName,
    retmode: 'json',
    ...(API_KEY && { api_key: API_KEY }),
  });

  const searchRes = await fetch(`${EUTILS}/esearch.fcgi?${searchParams}`);
  const searchData: NCBISearchResult = await searchRes.json();
  const taxId = searchData.esearchresult.idlist[0];

  const fetchParams = new URLSearchParams({
    db: 'taxonomy',
    id: taxId,
    retmode: 'json',
    ...(API_KEY && { api_key: API_KEY }),
  });

  const fetchRes = await fetch(`${EUTILS}/efetch.fcgi?${fetchParams}`);
  const taxonData: NCBITaxon[] = await fetchRes.json();
  return taxonData[0];
}

// 使用
const taxon = await getTaxonomy('Streptococcus pneumoniae');
const lineage = taxon.LineageEx.map(node => node.ScientificName);
console.log(`Lineage: ${lineage.join(' > ')} > ${taxon.ScientificName}`);
// Lineage: cellular organisms > Bacteria > Bacillota > Bacilli > Lactobacillales > Streptococcaceae > Streptococcus > Streptococcus pneumoniae

mkdirSync('taxonomy', { recursive: true });
writeFileSync(`taxonomy/streptococcus_pneumoniae.json`, JSON.stringify(taxon, null, 2), 'utf-8');
```

---

### 3.3 BV-BRC Data API

**Base URL**: `https://www.bv-brc.org/api/`

**认证**：OAuth 2.0 Bearer Token
1. 注册免费账号：https://www.bv-brc.org/
2. 获取Token：通过REST API用用户名/密码请求
3. 请求头携带：`Authorization: Bearer {token}`

**查询语言**：RQL（Resource Query Language），支持复杂的字段筛选

**文档**：https://www.bv-brc.org/api/doc/

**CLI工具**：https://github.com/BV-BRC/BV-BRC-CLI/releases（Mac/Windows/Linux）

#### 核心数据类型

| 数据类型 | 说明 | 对SoMe的价值 |
|---|---|---|
| `genome` | 基因组（100万+细菌） | 基因组大小→HP基准 |
| `genome_feature` | 基因/蛋白（61亿+记录） | 毒力基因→技能列表 |
| `genome_amr` | 抗耐药基因 | 装甲/减伤机制 |
| `spgene` | 特殊基因（毒力/致病） | Boss技能设计 |
| `pathway` | 代谢通路 | 接入SoMe三层能量系统 |

#### 示例：获取物种基因组元数据

```bash
# 获取 S. pneumoniae 的基因组列表（按物种名筛选）
# 需要先获取Bearer Token
TOKEN="your_bearer_token"

# RQL查询：species_name = "Streptococcus pneumoniae"
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://www.bv-brc.org/api/genome/?eq(species_name,%22Streptococcus%20pneumoniae%22)&limit(5)" \
  | jq .
```

返回（节选）：
```json
[
  {
    "genome_id": "1313.122",
    "species": "Streptococcus pneumoniae",
    "strain": "R6",
    "genome_status": "Complete",
    "genome_length": 2038615,
    "gc_content": 39.7,
    "patric_cds": 2043,
    "host_name": "Homo sapiens",
    "isolation_source": "respiratory tract",
    "antibiotic_resistance": {
      "beta_lactam": "resistant",
      "macrolide": "intermediate"
    },
    "serotype": "6B",
    "disease": "pneumonia, meningitis"
  }
]
```

#### 示例：查询毒力/特殊基因

```bash
# 查询某基因组的毒力因子
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://www.bv-brc.org/api/spgene/?eq(genome_id,%221313.122%22)&eq(property,%22virulence%22)" \
  | jq .
```

返回（节选）：
```json
[
  {
    "gene_id": "fig|1313.122.peg.1234",
    "product": "pneumolysin",
    "property": "virulence",
    "source": "PATRIC",
    "feature_type": "CDS"
  },
  {
    "gene_id": "fig|1313.122.peg.5678",
    "product": "capsular polysaccharide biosynthesis",
    "property": "virulence",
    "source": "PATRIC",
    "feature_type": "CDS"
  }
]
```

#### TypeScript 示例

```typescript
// fetch_bvbrc.ts — BV-BRC 临床数据拉取
import { writeFileSync, mkdirSync } from 'fs';

const BV_BRC_BASE = 'https://www.bv-brc.org/api';

interface BVBRCGenome {
  genome_id: string;
  species: string;
  strain: string;
  genome_status: string;
  genome_length: number;
  gc_content: number;
  patric_cds: number;
  host_name?: string;
  isolation_source?: string;
  serotype?: string;
  disease?: string;
  [key: string]: unknown;
}

interface BVBRCSpGene {
  gene_id: string;
  product: string;
  property: string;
  source: string;
  feature_type: string;
}

class BVBRCClient {
  private token: string;
  private headers: Record<string, string>;

  private constructor(token: string) {
    this.token = token;
    this.headers = { Authorization: `Bearer ${token}` };
  }

  static async create(username: string, password: string): Promise<BVBRCClient> {
    const res = await fetch(`${BV_BRC_BASE}/oauth/token`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({
        grant_type: 'password',
        username,
        password,
      }),
    });
    if (!res.ok) throw new Error(`BV-BRC auth failed: ${res.status}`);
    const data = await res.json() as { access_token: string };
    return new BVBRCClient(data.access_token);
  }

  async getGenomes(species: string, limit = 10): Promise<BVBRCGenome[]> {
    const rql = `eq(species_name,"${species}")&limit(${limit})`;
    const res = await fetch(`${BV_BRC_BASE}/genome/?${rql}`, { headers: this.headers });
    if (!res.ok) throw new Error(`BV-BRC genome query failed: ${res.status}`);
    return res.json();
  }

  async getVirulenceGenes(genomeId: string): Promise<BVBRCSpGene[]> {
    const rql = `eq(genome_id,"${genomeId}")&eq(property,"virulence")`;
    const res = await fetch(`${BV_BRC_BASE}/spgene/?${rql}`, { headers: this.headers });
    if (!res.ok) throw new Error(`BV-BRC spgene query failed: ${res.status}`);
    return res.json();
  }

  async getAMRProfile(genomeId: string): Promise<unknown[]> {
    const rql = `eq(genome_id,"${genomeId}")`;
    const res = await fetch(`${BV_BRC_BASE}/genome_amr/?${rql}`, { headers: this.headers });
    if (!res.ok) throw new Error(`BV-BRC AMR query failed: ${res.status}`);
    return res.json();
  }
}

// 使用
const client = await BVBRCClient.create(
  process.env.BV_BRC_USER!,
  process.env.BV_BRC_PASS!,
);

const genomes = await client.getGenomes('Streptococcus pneumoniae');
mkdirSync('clinical', { recursive: true });

for (const g of genomes) {
  const virulence = await client.getVirulenceGenes(g.genome_id);
  const amr = await client.getAMRProfile(g.genome_id);
  console.log(`Strain: ${g.strain}, Virulence genes: ${virulence.length}, AMR entries: ${amr.length}`);

  writeFileSync(
    `clinical/${g.species.replace(/ /g, '_')}_${g.genome_id}.json`,
    JSON.stringify({ genome: g, virulence, amr }, null, 2),
    'utf-8',
  );
  await new Promise(resolve => setTimeout(resolve, 500)); // 限速
}
```

---

## 4. 数据映射规则

### 4.1 BacDive 表型字段 → 游戏属性

| BacDive 字段 | JSON路径 | 游戏属性 | 映射逻辑 |
|---|---|---|---|
| 细胞形态 | `morphology.cell_morphology` | `unit_sprite_type` | coccus→球形, bacillus→杆形, spirillum→螺旋形 |
| 革兰染色 | `gram_stain.gram_stain` | `faction` | positive→革兰阳性阵营, negative→革兰阴性阵营 |
| 芽孢形成 | `physiology.spore_formation` | `revive_mechanism` | yes→死亡后有复活机制, no→无 |
| 需氧类型 | `physiology.oxygen_tolerance` | `terrain_oxygen_modifier` | aerobic→富氧区+30%, anaerobic→缺氧区+30%, facultative→无修正 |
| 过氧化氢酶 | `physiology.catalase` | `oxidative_defense` | positive→氧化应激抗性+50% |
| 氧化酶 | `physiology.oxidase` | `electron_transport` | positive→呼吸链完整, negative→呼吸链受限 |
| 最适温度 | `culture.temp_optimum` | `optimal_temp` | 直接映射（人体37°C为基准） |
| 温度范围 | `culture.temp_min/max` | `temp_tolerance_range` | 直接映射 |
| pH范围 | `culture.ph_min/max` | `ph_tolerance_range` | 直接映射 |
| 生态位 | `environment.habitat` | `deployment_zones` | human→人体各器官地图, environmental→环境地图 |
| 分离来源 | `environment.isolation_source` | `spawn_location` | respiratory tract→呼吸道, blood→血流, CSF→脑脊液 |

### 4.2 BV-BRC 临床字段 → 游戏属性

| BV-BRC 字段 | 游戏属性 | 映射逻辑 |
|---|---|---|
| `genome_length` | `hp_base` | 按比例缩放（1Mbp=100HP基准，上下浮动） |
| `patric_cds`（基因数） | `skill_slots` | 基因数越多技能槽越多（/200取整，上限10） |
| `antibiotic_resistance` | `armor_type` | 每种耐药=一种装甲类型 |
| AMR基因数量 | `damage_reduction` | AMR基因数×5%减伤，上限60% |
| 毒力因子列表 | `abilities[]` | 每个毒力因子=一个主动技能 |
| 毒力因子数量 | `boss_eligible` | ≥5个毒力因子→可设计为Boss |
| `serotype` | `unit_variant` | 同物种不同血清型=同模型不同属性变体 |
| `host_name` | `target_species` | human→对人类细胞有效, animal→仅动物模型 |
| `disease` | `associated_diseases[]` | 直接映射为剧情标签 |

### 4.3 NCBI Taxonomy → 分类树

| NCBI 字段 | 游戏属性 | 映射逻辑 |
|---|---|---|
| `LineageEx` | `lineage[]` | 完整分类谱系，用于图鉴/技能树 |
| `ScientificName` | `scientific_name` | 显示用学名 |
| `OtherNames.Synonym` | `synonyms[]` | 别名列表（历史命名） |
| `TaxId` | `ncbi_taxid` | 跨数据库关联键 |

---

## 5. 数据管线架构

### 5.1 构建时管线（Build-time Pipeline）

```
物种名单 (species_list.json)
    │
    ├──→ NCBI E-utilities ──→ taxonomy/{species}.json
    │         (获取TaxID + 谱系)
    │
    ├──→ BacDive API v2 ──→ phenotypes/{species}_{strain_id}.json
    │         (获取表型 + 代谢 + 培养条件)
    │
    └──→ BV-BRC API ──→ clinical/{species}_{genome_id}.json
              (获取毒力 + 耐药 + 血清型)
              │
              ▼
    merge_mapper.ts（合并 + 游戏化映射）
              │
              ▼
    game_units/{species_slug}.json（最终运行时数据）
```

### 5.2 目录结构

```
SoMe_Design/
├── Bacterial_Unit_Database_Architecture.md   ← 本文档
├── DataPipeline/
│   ├── species_list.json                     ← SoMe收录的细菌物种清单
│   ├── fetch_taxonomy.ts                     ← NCBI Taxonomy 拉取脚本
│   ├── fetch_bacdive.ts                      ← BacDive 拉取脚本
│   ├── fetch_bvbrc.ts                        ← BV-BRC 拉取脚本
│   ├── merge_mapper.ts                       ← 三源合并 + 游戏化映射
│   ├── taxonomy/                             ← NCBI 分类数据缓存
│   │   └── streptococcus_pneumoniae.json
│   ├── phenotypes/                           ← BacDive 表型数据缓存
│   │   └── streptococcus_pneumoniae_1234.json
│   ├── clinical/                             ← BV-BRC 临床数据缓存
│   │   └── streptococcus_pneumoniae_1313.122.json
│   └── game_units/                           ← 最终运行时数据（引擎直接读取）
│       └── streptococcus_pneumoniae.json
```

### 5.3 物种清单格式

`species_list.json` 定义SoMe收录的所有细菌物种：

```json
{
  "species_list": [
    {
      "scientific_name": "Streptococcus pneumoniae",
      "common_name_zh": "肺炎链球菌",
      "role": "boss",
      "clinical_relevance": "肺炎/脑膜炎/中耳炎",
      "some_chapter": "chapter_3_respiratory",
      "priority": 1
    },
    {
      "scientific_name": "Neisseria meningitidis",
      "common_name_zh": "脑膜炎奈瑟菌",
      "role": "boss",
      "clinical_relevance": "流行性脑脊髓膜炎",
      "some_chapter": "chapter_5_meninges",
      "priority": 1
    },
    {
      "scientific_name": "Mycobacterium tuberculosis",
      "common_name_zh": "结核分枝杆菌",
      "role": "boss",
      "clinical_relevance": "结核病",
      "some_chapter": "chapter_4_lung_deep",
      "priority": 1
    },
    {
      "scientific_name": "Escherichia coli",
      "common_name_zh": "大肠杆菌",
      "role": "mob",
      "clinical_relevance": "条件致病菌",
      "some_chapter": "chapter_2_gut",
      "priority": 2
    }
  ]
}
```

---

## 6. 完整示例：肺炎链球菌管线

### Step 1: NCBI Taxonomy

```bash
# 搜索TaxID
curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=taxonomy&term=Streptococcus+pneumoniae&retmode=json"
# → TaxID: 1313

# 获取谱系
curl -s "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=taxonomy&id=1313&retmode=json"
# → Lineage: Bacteria > Bacillota > Bacilli > Lactobacillales > Streptococcaceae > Streptococcus
```

### Step 2: BacDive 表型数据

```bash
# 按物种名搜索菌株
curl -s "https://api.bacdive.dsmz.de/v2/taxon/Streptococcus/pneumoniae"
# → 返回 BacDive ID 列表

# 获取模式菌株详情
curl -s "https://api.bacdive.dsmz.de/v2/fetch/{bacdive_id}"
# → 球菌/革兰阳性/兼性厌氧/过氧化氢酶阴性/37°C最适/呼吸道定植
```

### Step 3: BV-BRC 临床数据

```bash
# 获取基因组元数据
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://www.bv-brc.org/api/genome/?eq(species_name,%22Streptococcus%20pneumoniae%22)&limit(1)"
# → 基因组2.04Mbp / 2043个CDS / 血清型6B / 宿主人类

# 获取毒力因子
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://www.bv-brc.org/api/spgene/?eq(genome_id,%221313.122%22)&eq(property,%22virulence%22)"
# → pneumolysin / capsule / IgA1 protease / autolysin / ...

# 获取耐药谱
curl -s -H "Authorization: Bearer $TOKEN" \
  "https://www.bv-brc.org/api/genome_amr/?eq(genome_id,%221313.122%22)"
# → beta-lactam: resistant / macrolide: intermediate
```

### Step 4: 合并生成 game_unit

最终 `game_units/streptococcus_pneumoniae.json`：

```json
{
  "scientific_name": "Streptococcus pneumoniae",
  "common_name_zh": "肺炎链球菌",
  "ncbi_taxid": 1313,
  "bacdive_id": 1234,
  "bvbrc_genome_id": "1313.122",

  "taxonomy": {
    "lineage": ["Bacteria", "Bacillota", "Bacilli", "Lactobacillales", "Streptococcaceae", "Streptococcus"],
    "rank": "species",
    "synonyms": ["Diplococcus pneumoniae", "Micrococcus pneumoniae"]
  },

  "biology": {
    "morphology": {
      "shape": "coccus",
      "arrangement": "pairs/chains",
      "gram_stain": "positive",
      "size_um": [0.5, 1.25],
      "spore_formation": false
    },
    "metabolism": {
      "oxygen_tolerance": "facultative_anaerobe",
      "catalase": false,
      "oxidase": false,
      "fermentation_type": "lactic_acid"
    },
    "growth": {
      "temp_optimum": 37,
      "temp_range": [30, 40],
      "ph_optimum": 7.8,
      "ph_range": [6.5, 8.0]
    },
    "habitat": ["upper_respiratory_tract", "lungs", "meninges"],
    "host": "Homo sapiens"
  },

  "clinical": {
    "diseases": ["pneumonia", "meningitis", "otitis_media", "septicemia"],
    "serotype": "6B",
    "virulence_factors": [
      {"name": "pneumolysin", "type": "toxin", "mechanism": "cholesterol-dependent cytolysin, forms pores in host cell membranes"},
      {"name": "capsule", "type": "structural", "mechanism": "anti-phagocytic polysaccharide capsule"},
      {"name": "IgA1_protease", "type": "enzyme", "mechanism": "cleaves host secretory IgA1"},
      {"name": "autolysin", "type": "enzyme", "mechanism": "peptidoglycan hydrolase, triggers lysis and toxin release"},
      {"name": "neuraminidase", "type": "enzyme", "mechanism": "cleaves sialic acid, exposes receptors"}
    ],
    "antibiotic_resistance": {
      "beta_lactam": "resistant",
      "macrolide": "intermediate"
    },
    "genome_length_bp": 2038615,
    "cds_count": 2043
  },

  "game_stats": {
    "unit_type": "boss",
    "faction": "gram_positive",
    "sprite_type": "coccus_pair",
    "color_scheme": {
      "primary": "#8B0000",
      "accent": "#FF6347",
      "gram_indicator": "purple_positive"
    },
    "hp_base": 102,
    "skill_slots": 10,
    "abilities": [
      {
        "id": "pneumolysin_burst",
        "name": "溶血毒素",
        "type": "active",
        "biological_source": "pneumolysin",
        "effect": "AOE穿透伤害, 破坏宿主细胞膜",
        "cooldown_turns": 3,
        "damage_type": "toxin"
      },
      {
        "id": "capsule_armor",
        "name": "荚膜装甲",
        "type": "passive",
        "biological_source": "capsular polysaccharide",
        "effect": "吞噬免疫, 物理减伤40%",
        "damage_type": null
      },
      {
        "id": "iga1_stealth",
        "name": "抗体隐身",
        "type": "active",
        "biological_source": "IgA1 protease",
        "effect": "清除区域内宿主sIgA, 隐身2回合",
        "cooldown_turns": 5
      },
      {
        "id": "autolysin_selfdestruct",
        "name": "自溶释放",
        "type": "ultimate",
        "biological_source": "autolysin (LytA)",
        "effect": "濒死时自溶, 释放全部pneumolysin, 对周围造成巨额AOE",
        "trigger": "hp < 10%"
      },
      {
        "id": "neuraminidase_reveal",
        "name": "受体暴露",
        "type": "active",
        "biological_source": "neuraminidase (NanA)",
        "effect": "清除宿主细胞唾液酸, 暴露粘连受体, 增加自身吸附力",
        "cooldown_turns": 4
      }
    ],
    "armor": {
      "beta_lactam_resistance": 0.6,
      "macrolide_resistance": 0.3
    },
    "terrain_modifiers": {
      "respiratory_tract": 1.3,
      "lungs": 1.2,
      "meninges": 1.5,
      "bloodstream": 0.8
    },
    "oxygen_modifier": {
      "aerobic": 1.0,
      "anaerobic": 1.0,
      "facultative": 1.0
    },
    "temp_modifier": {
      "optimal": 37,
      "penalty_below": 30,
      "penalty_above": 40
    }
  },

  "sources": {
    "ncbi_taxid": 1313,
    "bacdive_id": 1234,
    "bvbrc_genome_id": "1313.122",
    "last_updated": "2026-07-13"
  }
}
```

---

## 7. ct.js 集成方案

### 7.1 运行时读取

ct.js 运行时只读 `game_units/` 目录下的最终JSON文件，不直接调用API：

```typescript
// ct.js TypeScript: 加载细菌单位定义
interface BacterialUnit {
  scientific_name: string;
  common_name_zh: string;
  game_stats: {
    unit_type: 'boss' | 'elite' | 'mob' | 'neutral';
    faction: 'gram_positive' | 'gram_negative';
    hp_base: number;
    abilities: Ability[];
    terrain_modifiers: Record<string, number>;
    // ...
  };
  biology: {
    morphology: Morphology;
    metabolism: Metabolism;
    // ...
  };
}

// 构建时通过 ct.js Content Subsystem 注册为自定义类型
// 或直接在代码中 import JSON
import sPneumoniae from '../data/game_units/streptococcus_pneumoniae.json';

const unit: BacterialUnit = sPneumoniae as BacterialUnit;
```

### 7.2 构建时数据拉取

数据拉取脚本全部用 TypeScript（Node.js 运行），与项目技术栈一致，生成JSON后由 AtomCode CLI 集成到 ct.js 项目：

```bash
# 完整管线执行（需先 npm install && npx tsx）
npx tsx fetch_taxonomy.ts --species-list species_list.json --output taxonomy/
npx tsx fetch_bacdive.ts --species-list species_list.json --output phenotypes/
npx tsx fetch_bvbrc.ts --species-list species_list.json --output clinical/ --token $BV_BRC_TOKEN
npx tsx merge_mapper.ts --taxonomy taxonomy/ --phenotypes phenotypes/ --clinical clinical/ --output game_units/
```

---

## 8. 数据更新策略

| 场景 | 频率 | 操作 |
|---|---|---|
| 新增物种 | 按章节开发进度 | 在species_list.json添加 → 运行管线 |
| 数据库更新 | 每季度 | 重新拉取所有物种，diff比对变化 |
| 游戏平衡调整 | 按需 | 仅修改game_stats映射规则，不重新拉取源数据 |
| 发现数据错误 | 即时 | 修正源数据缓存 + 重新生成game_unit |

**版本控制**：`game_units/` 目录纳入Git，每次管线运行后提交，保留历史版本便于回溯。

---

## 9. 与SoMe现有系统的对接

### 9.1 三层能量系统对接

细菌的 `metabolism.oxygen_tolerance` 和 `metabolism.fermentation_type` 直接决定其能量系统类型：

| 细菌代谢类型 | SoMe能量系统 | ATP获取方式 | 游戏效果 |
|---|---|---|---|
| 呼吸型（需氧/兼性） | 完整Krebs循环 | 氧化磷酸化→ATP高产 | 技能释放频繁 |
| 发酵型（厌氧） | 仅糖酵解 | 底物水平磷酸化→ATP低产 | 技能释放受限，但毒性高 |
| 光合型（罕见） | 光合磷酸化 | 光能→ATP | 仅特定地图有效 |

### 9.2 地图系统对接

`habitat` 和 `terrain_modifiers` 对接SoMe器官地图系统：

| 栖息地 | SoMe地图 | 地形修正 |
|---|---|---|
| respiratory_tract | 呼吸道走廊 | 原生地形+30% |
| lungs | 肺泡战场 | 原生地形+20% |
| meninges | 脑膜屏障 | 原生地形+50%（突破BBB后） |
| bloodstream | 血流通道 | 非原生地形-20% |
| gut | 肠道迷宫 | 视物种定 |

### 9.3 免疫系统战斗对接

细菌的 `virulence_factors` 和 `armor` 对接Eiko（小胶质细胞）战斗系统：

- 荚膜 → 对Eiko的吞噬技能免疫
- 溶血素 → 对Eiko造成AOE反伤
- IgA1蛋白酶 → 破坏区域内的抗体增益
- 耐药装甲 → 对应抗生素类道具无效

---

## 10. 扩展性

### 未来可扩展数据源

| 数据库 | 补充能力 | 优先级 |
|---|---|---|
| [GTDB](https://gtdb.ecogenomic.org/) | 系统发育修正分类 | P2 |
| [CARD](https://card.mcmaster.ca/) | 更详细的耐药基因库 | P2 |
| [VFDB](http://www.mgc.ac.cn/VFs/) | 毒力因子专用数据库 | P1 |
| [PATRIC Pathway](https://www.bv-brc.org/) | 代谢通路详情 | P2 |
| [BacMet](http://bacmet.biomedicine.gu.se/) | 抗金属/消毒剂基因 | P3 |

### 病毒/真菌扩展

本架构可复用于SoMe后续的病毒单位（对接 [NCBI Virus](https://www.ncbi.nlm.nih.gov/labs/virus/)）和真菌单位（对接 [MycoBank](https://www.mycobank.org/)），只需调整字段映射规则。

---

## 附录A：API速率限制参考

| API | 免费限额 | 建议策略 |
|---|---|---|
| BacDive v2 | 无明确限制（免注册） | 每次拉取后sleep 0.5s |
| NCBI E-utilities | 3次/秒（无Key），10次/秒（有Key） | 申请API Key + sleep 0.1s |
| BV-BRC | 无明确限制（需Token） | 每次拉取后sleep 0.5s |

## 附录B：数据许可

| 数据库 | 许可 | 商用条件 |
|---|---|---|
| BacDive | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) | 注明来源即可商用 |
| NCBI | 公共领域 | 无限制 |
| BV-BRC | NIAID资助的公共资源 | 免费使用，引用来源 |

SoMe 作为商业游戏使用这些数据时，在致谢页标注三个数据来源即可。
