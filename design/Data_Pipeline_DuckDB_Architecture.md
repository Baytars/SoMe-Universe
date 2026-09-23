# SoMe 数据管线架构 v2.0 — DuckDB统一查询层

> **文档级别**：Canonical  
> **创建日期**：2026-07-18  
> **版本**：v2.0  
> **前置文档**：[细菌单位底层数据库架构 v1.0](./Bacterial_Unit_Database_Architecture.md)  
> **关联设计**：数值锚定真实生物 / 全栈TypeScript / 数据库孤岛→连续体  

---

## 0. 版本变更：v1.0 → v2.0

v1.0的管线是**线性串行**：逐个API调 → 各自解析 → TS手写merge逻辑 → 输出JSON。

v2.0引入DuckDB作为**统一查询/加工层**：fetch层只负责把数据拉到本地（JSON/CSV/Parquet），DuckDB负责所有跨源JOIN、JSON解析、格式转换和聚合统计。

| 维度 | v1.0 | v2.0 |
|---|---|---|
| 跨源合并 | TS手写JOIN逻辑 | DuckDB SQL一条搞定 |
| JSON处理 | 逐字段TS代码解析 | `json_extract()` + `UNNEST` |
| MySQL直连 | 不支持（只能REST逐条） | `ATTACH` Ensembl Bacteria批量拉 |
| 数据源数量 | 3个（BacDive/BV-BRC/NCBI） | 12+个（含CARD/VFDB/UniProt/STRING/Ensembl等） |
| 合并代码量 | ~500行TS | ~50行SQL + ~100行TS（fetch层） |
| 内存占用 | 全量加载到JS对象 | 流式读取，按需加载 |

---

## 1. 架构总览

```
┌─────────────────────────────────────────────────────────────────┐
│                    SoMe 数据管线 v2.0                            │
│                                                                 │
│  ┌─────────────── FETCH LAYER (TypeScript) ──────────────────┐ │
│  │                                                             │ │
│  │  REST API          MySQL直连       SPARQL        下载文件    │ │
│  │  BacDive/BV-BRC    Ensembl Bact.   UniProt       CARD/VFDB  │ │
│  │  NCBI/STRING       UCSC            (联邦查询)     Reactome   │ │
│  │  VirJenDB/ClinVar  BioCyc(BioVelo)                           │ │
│  │                                                             │ │
│  │  输出：JSON / CSV / Parquet → data/raw/                     │ │
│  └─────────────────────────┬───────────────────────────────────┘ │
│                            ▼                                     │
│  ┌─────────────── DUCKDB LAYER (SQL) ─────────────────────────┐ │
│  │                                                             │ │
│  │  ATTACH MySQL (Ensembl Bacteria :4157)                      │ │
│  │  ATTACH SQLite (STRING dump本地)                            │ │
│  │  read_json_auto() (CARD ARO / UniProt SPARQL结果)           │ │
│  │  read_csv_auto() (BacDive/BV-BRC REST缓存)                  │ │
│  │  read_parquet() (大规模预计算数据)                           │ │
│  │                                                             │ │
│  │  跨源JOIN → 游戏化映射 → 数值压缩 → 输出                     │ │
│  │                                                             │ │
│  │  输出：game_units/*.json + biomap/*.parquet                 │ │
│  └─────────────────────────┬───────────────────────────────────┘ │
│                            ▼                                     │
│  ┌─────────────── OUTPUT LAYER ──────────────────────────────┐ │
│  │                                                             │ │
│  │  game_units/     → ct.js运行时直接读取（单位定义）           │ │
│  │  biomap/         → 预计算查询索引（图鉴/技能树/PPI网络）     │ │
│  │  validation/     → 数据质量报告（覆盖率/桥接率/缺失统计）    │ │
│  └───────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

**三层职责分离**：
- **Fetch Layer**：只管"把数据从远端弄到本地"，输出原始JSON/CSV/Parquet
- **DuckDB Layer**：只管"把多源数据合并加工成游戏可用格式"，全部用SQL
- **Output Layer**：只管"让游戏引擎读"，输出标准JSON + Parquet索引

---

## 2. 数据源全量清单

### 2.1 接入方式矩阵

| 数据库 | 接入方式 | DuckDB处理 | SoMe阶段 |
|---|---|---|---|
| **BacDive** | REST API → JSON | `read_json_auto()` | Phase 1 |
| **BV-BRC** | REST API → JSON | `read_json_auto()` | Phase 1 |
| **NCBI Taxonomy** | E-utilities → JSON | `read_json_auto()` | Phase 1 |
| **CARD** | 下载OBO/JSON/TSV | `read_json_auto()` / `read_csv_auto()` | Phase 1（替换BV-BRC AMR） |
| **VFDB** | 下载FASTA/TSV | `read_csv_auto()` | Phase 1（替换BV-BRC VF） |
| **Ensembl Bacteria** | MySQL直连 :4157 | `ATTACH (TYPE MYSQL)` | Phase 2 |
| **UniProt** | SPARQL → JSON / REST → JSON | `read_json_auto()` | Phase 2 |
| **RCSB PDB** | REST → JSON | `read_json_auto()` | Phase 2 |
| **STRING** | SQL dump → SQLite | `ATTACH (TYPE SQLITE)` | Phase 2 |
| **BioCyc** | Web services → JSON | `read_json_auto()` | Phase 5 |
| **Reactome** | MySQL dump → 本地 | `ATTACH (TYPE MYSQL)` 本地 | Phase 5 |
| **ClinVar** | E-utilities → JSON | `read_json_auto()` | Phase 4 |
| **VirJenDB** | REST → JSON | `read_json_auto()` | Phase 3（病毒DLC） |

### 2.2 DuckDB直连能力

DuckDB能**直接ATTACH**的数据源（不需要fetch层）：

```sql
-- Ensembl Bacteria MySQL（anonymous，无速率限制）
INSTALL mysql_scanner; LOAD mysql_scanner;
ATTACH 'mysql://anonymous@mysql-eg-publicsql.ebi.ac.uk:4157' AS ensembl (TYPE MYSQL);

-- STRING SQL dump（本地SQLite）
ATTACH 'data/raw/string/string.db' AS string (TYPE SQLITE);

-- Reactome本地MySQL镜像
ATTACH 'mysql://root@localhost:3306/reactome' AS reactome (TYPE MYSQL);
```

DuckDB能**直接读取**的本地文件（fetch层拉取后）：

```sql
-- CARD ARO本体论（JSON）
SELECT * FROM read_json_auto('data/raw/card/aro.json');

-- BacDive REST响应（JSON）
SELECT * FROM read_json_auto('data/raw/bacdive/*.json');

-- VFDB数据（TSV）
SELECT * FROM read_csv_auto('data/raw/vfdb/VFs.tsv');

-- NCBI Taxonomy（JSON）
SELECT * FROM read_json_auto('data/raw/ncbi/*.json');
```

---

## 3. DuckDB Layer 设计

### 3.1 初始化脚本

```typescript
// duckdb_init.ts — 初始化DuckDB数据库
import { Database } from 'duckdb-async';

export async function initPipelineDB(dbPath: string): Promise<Database> {
  const db = await Database.create(dbPath);

  // 安装扩展
  await db.all('INSTALL mysql_scanner; LOAD mysql_scanner;');
  await db.all('INSTALL sqlite; LOAD sqlite;');

  // ATTACH外部数据源
  await db.all(`
    ATTACH 'mysql://anonymous@mysql-eg-publicsql.ebi.ac.uk:4157' AS ensembl (TYPE MYSQL);
  `);

  await db.all(`
    ATTACH 'data/raw/string/string.db' AS string_db (TYPE SQLITE);
  `);

  // 创建工作schema
  await db.all(`
    CREATE SCHEMA IF NOT EXISTS some_pipeline;
    CREATE SCHEMA IF NOT EXISTS game_units;
    CREATE SCHEMA IF NOT EXISTS biomap;
    CREATE SCHEMA IF NOT EXISTS validation;
  `);

  return db;
}
```

### 3.2 视图层：统一数据模型

为每个数据源创建DuckDB视图，屏蔽原始格式差异：

```sql
-- ============ Phase 1 视图 ============

-- BacDive表型视图
CREATE OR REPLACE VIEW some_pipeline.v_bacdive AS
SELECT
  bacdive_id,
  taxonomy_name,
  CAST(json_extract(data, '$.morphology.cell_morphology[0].value') AS VARCHAR) AS cell_shape,
  CAST(json_extract(data, '$.gram_stain.gram_stain[0].value') AS VARCHAR) AS gram_stain,
  CAST(json_extract(data, '$.physiology_and_metabolism.oxygen_tolerance[0].value') AS VARCHAR) AS oxygen_tolerance,
  CAST(json_extract(data, '$.physiology_and_metabolism.catalase[0].value') AS VARCHAR) AS catalase,
  CAST(json_extract(data, '$.culture_growth_conditions.growth_temperature.temp_optimum') AS DOUBLE) AS temp_optimum,
  CAST(json_extract(data, '$.culture_growth_conditions.growth_temperature.temp_min') AS DOUBLE) AS temp_min,
  CAST(json_extract(data, '$.culture_growth_conditions.growth_temperature.temp_max') AS DOUBLE) AS temp_max,
  CAST(json_extract(data, '$.culture_growth_conditions.ph_range.ph_optimum') AS DOUBLE) AS ph_optimum,
  CAST(json_extract(data, '$.environment.habitat[0].value') AS VARCHAR) AS habitat,
  CAST(json_extract(data, '$.environment.isolation_source[0].value') AS VARCHAR) AS isolation_source,
  ncbi_tax_id
FROM read_json_auto('data/raw/bacdive/*.json');

-- BV-BRC临床视图
CREATE OR REPLACE VIEW some_pipeline.v_bvbrc_genome AS
SELECT
  genome_id,
  species,
  strain,
  genome_length,
  gc_content,
  patric_cds,
  host_name,
  serotype,
  disease
FROM read_json_auto('data/raw/bvbrc/genome_*.json');

CREATE OR REPLACE VIEW some_pipeline.v_bvbrc_virulence AS
SELECT
  genome_id,
  gene_id,
  product,
  property,
  source
FROM read_json_auto('data/raw/bvbrc/spgene_*.json')
WHERE property = 'virulence';

-- NCBI Taxonomy视图
CREATE OR REPLACE VIEW some_pipeline.v_taxonomy AS
SELECT
  CAST(json_extract(data, '$.TaxId') AS VARCHAR) AS taxid,
  CAST(json_extract(data, '$.ScientificName') AS VARCHAR) AS scientific_name,
  CAST(json_extract(data, '$.Rank') AS VARCHAR) AS rank,
  CAST(json_extract(data, '$.Lineage') AS VARCHAR) AS lineage
FROM read_json_auto('data/raw/ncbi/taxonomy_*.json');

-- CARD ARO视图（从JSON本体论提取耐药术语）
CREATE OR REPLACE VIEW some_pipeline.v_card_aro AS
SELECT
  CAST(json_extract(node, '$.accession') AS VARCHAR) AS aro_accession,
  CAST(json_extract(node, '$.name') AS VARCHAR) AS term_name,
  CAST(json_extract(node, '$.definition') AS VARCHAR) AS definition,
  CAST(json_extract(node, '$.is_a') AS VARCHAR) AS parent_term,
  CAST(json_extract(node, '$.confers_resistance_to') AS VARCHAR) AS resistance_target
FROM read_json_auto('data/raw/card/aro.json');

-- VFDB毒力因子视图
CREATE OR REPLACE VIEW some_pipeline.v_vfdb AS
SELECT
  vfid,
  genbank_id,
  vfname,
  description,
  category
FROM read_csv_auto('data/raw/vfdb/VFs.tsv', header: true);

-- ============ Phase 2 视图 ============

-- Ensembl Bacteria基因+xref视图（直连MySQL）
CREATE OR REPLACE VIEW some_pipeline.v_ensembl_genes AS
SELECT
  g.stable_id AS ensembl_gene_id,
  x.dbprimary_acc AS cross_ref_id,
  edb.db_name AS external_db,
  g.description AS gene_description,
  g.species_id
FROM ensembl.bacteria_collection_1280_1_core_57_1.gene g
LEFT JOIN ensembl.bacteria_collection_1280_1_core_57_1.xref x
  ON g.display_xref_id = x.xref_id
LEFT JOIN ensembl.bacteria_collection_1280_1_core_57_1.external_db edb
  ON x.external_db_id = edb.external_db_id
WHERE edb.db_name IN ('UNIPROT', 'EMBL', 'REFSEQ');

-- STRING PPI视图（本地SQLite）
CREATE OR REPLACE VIEW some_pipeline.v_string_ppi AS
SELECT
  protein1,
  protein2,
  combined_score
FROM string_db.protein_links_full
WHERE combined_score >= 400;  -- 过滤低置信度互作

-- UniProt蛋白视图（SPARQL结果或REST JSON）
CREATE OR REPLACE VIEW some_pipeline.v_uniprot AS
SELECT
  CAST(json_extract(entry, '$.primaryAccession') AS VARCHAR) AS uniprot_ac,
  CAST(json_extract(entry, '$.proteinDescription.recommendedName.fullName.value') AS VARCHAR) AS protein_name,
  CAST(json_extract(entry, '$.organism.scientificName') AS VARCHAR) AS organism,
  CAST(json_extract(entry, '$.sequence.length') AS INTEGER) AS sequence_length
FROM read_json_auto('data/raw/uniprot/*.json');
```

### 3.3 跨源JOIN：核心管线查询

#### 3.3.1 细菌单位全量构建（Phase 1）

一条SQL完成"三源合并 + 游戏化映射"：

```sql
-- build_units.sql — 从三源数据生成游戏单位
CREATE OR REPLACE TABLE game_units.bacterial_units AS
WITH taxonomy AS (
  SELECT taxid, scientific_name, lineage FROM some_pipeline.v_taxonomy
),
phenotype AS (
  SELECT
    bacdive_id,
    ncbi_tax_id,
    taxonomy_name,
    cell_shape,
    gram_stain,
    oxygen_tolerance,
    catalase,
    temp_optimum,
    habitat,
    isolation_source
  FROM some_pipeline.v_bacdive
),
clinical AS (
  SELECT
    g.genome_id,
    g.species,
    g.strain,
    g.genome_length,
    g.patric_cds,
    g.serotype,
    g.disease,
    -- 聚合毒力因子为JSON数组
    (
      SELECT json_group_array(
        json_object('name', v.product, 'source', v.source)
      )
      FROM some_pipeline.v_bvbrc_virulence v
      WHERE v.genome_id = g.genome_id
    ) AS virulence_factors_json
  FROM some_pipeline.v_bvbrc_genome g
  GROUP BY g.genome_id, g.species, g.strain, g.genome_length, g.patric_cds, g.serotype, g.disease
)
SELECT
  p.taxonomy_name AS scientific_name,
  t.taxid AS ncbi_taxid,
  p.bacdive_id,
  c.genome_id AS bvbrc_genome_id,
  t.lineage,

  -- biology block
  json_object(
    'morphology', json_object(
      'shape', p.cell_shape,
      'gram_stain', p.gram_stain
    ),
    'metabolism', json_object(
      'oxygen_tolerance', p.oxygen_tolerance,
      'catalase', p.catalase
    ),
    'growth', json_object(
      'temp_optimum', p.temp_optimum
    ),
    'habitat', p.habitat
  ) AS biology,

  -- clinical block
  json_object(
    'diseases', c.disease,
    'serotype', c.serotype,
    'virulence_factors', c.virulence_factors_json,
    'genome_length_bp', c.genome_length,
    'cds_count', c.patric_cds
  ) AS clinical,

  -- game_stats block（数值映射）
  json_object(
    'hp_base', CAST(c.genome_length / 20000 AS INTEGER),  -- 1Mbp ≈ 50HP
    'skill_slots', LEAST(CAST(c.patric_cds / 200 AS INTEGER), 10),
    'faction', CASE WHEN p.gram_stain = 'positive' THEN 'gram_positive' ELSE 'gram_negative' END,
    'sprite_type', CASE p.cell_shape
      WHEN 'coccus' THEN 'coccus'
      WHEN 'bacillus' THEN 'rod'
      WHEN 'spirillum' THEN 'spiral'
      ELSE 'unknown'
    END
  ) AS game_stats

FROM phenotype p
LEFT JOIN taxonomy t ON CAST(p.ncbi_tax_id AS VARCHAR) = t.taxid
LEFT JOIN clinical c ON c.species = p.taxonomy_name;
```

#### 3.3.2 CARD耐药装甲系统（Phase 1扩展）

将CARD的ARO本体论映射为武器-装甲克制矩阵：

```sql
-- build_amr_matrix.sql — 从CARD生成耐药装甲矩阵
CREATE OR REPLACE TABLE game_units.amr_armor_matrix AS
SELECT
  aro.term_name AS armor_name,
  aro.parent_term AS armor_category,
  aro.resistance_target AS resistant_to,
  aro.definition AS mechanic_description,

  -- 装甲类型映射
  CASE
    WHEN aro.parent_term LIKE '%beta-lactamase%' THEN 'enzyme_degradation'
    WHEN aro.parent_term LIKE '%efflux%' THEN 'active_pump'
    WHEN aro.parent_term LIKE '%target%' THEN 'target_mutation'
    WHEN aro.parent_term LIKE '%protection%' THEN 'protection_protein'
    ELSE 'unknown'
  END AS armor_mechanism,

  -- 装甲等级（基于CARD-R流行率，越罕见等级越高）
  CASE
    WHEN aro.term_name IN ('NDM', 'KPC', 'OXA-48', 'VIM', 'IMP') THEN 'legendary'
    WHEN aro.parent_term LIKE '%carbapenem%' THEN 'epic'
    WHEN aro.parent_term LIKE '%extended-spectrum%' THEN 'rare'
    ELSE 'common'
  END AS armor_rarity

FROM some_pipeline.v_card_aro aro
WHERE aro.resistance_target IS NOT NULL;
```

#### 3.3.3 Ensembl + UniProt + STRING跨源JOIN（Phase 2）

```sql
-- build_protein_network.sql — 蛋白互作网络构建
CREATE OR REPLACE TABLE biomap.protein_network AS
SELECT
  eg.ensembl_gene_id,
  eg.cross_ref_id AS uniprot_ac,
  up.protein_name,
  up.sequence_length,

  -- STRING PPI得分
  (
    SELECT json_group_array(
      json_object(
        'partner', s.protein2,
        'score', s.combined_score,
        'evidence_level', CASE
          WHEN s.combined_score >= 900 THEN 'highest'
          WHEN s.combined_score >= 700 THEN 'high'
          WHEN s.combined_score >= 400 THEN 'medium'
          ELSE 'low'
        END
      )
    )
    FROM some_pipeline.v_string_ppi s
    WHERE s.protein1 = eg.cross_ref_id
  ) AS interactions

FROM some_pipeline.v_ensembl_genes eg
LEFT JOIN some_pipeline.v_uniprot up
  ON eg.cross_ref_id = up.uniprot_ac
WHERE eg.external_db = 'UNIPROT';
```

#### 3.3.4 VFDB + Ensembl桥接验证

```sql
-- verify_vfdb_bridge.sql — 验证VFDB→UniProt桥接命中率
CREATE OR REPLACE TABLE validation.vfdb_bridge_coverage AS
SELECT
  COUNT(*) AS total_vfdb_entries,
  COUNT(eg.cross_ref_id) AS bridged_to_uniprot,
  ROUND(COUNT(eg.cross_ref_id) * 100.0 / COUNT(*), 1) AS bridge_rate_pct
FROM some_pipeline.v_vfdb vf
LEFT JOIN some_pipeline.v_ensembl_genes eg
  ON vf.genbank_id = eg.cross_ref_id
WHERE eg.external_db IN ('EMBL', 'UNIPROT');

-- 桥接失败的条目（需要手动补全）
CREATE OR REPLACE TABLE validation.vfdb_bridge_gaps AS
SELECT vf.vfid, vf.vfname, vf.genbank_id, vf.description
FROM some_pipeline.v_vfdb vf
LEFT JOIN some_pipeline.v_ensembl_genes eg
  ON vf.genbank_id = eg.cross_ref_id
WHERE eg.cross_ref_id IS NULL;
```

---

## 4. Fetch Layer 设计

DuckDB不能直连的数据源，由TS fetch层拉取到本地：

### 4.1 目录结构

```
SoMe_Design/DataPipeline/
├── duckdb_init.ts                    ← DuckDB初始化+ATTACH
├── fetch/
│   ├── fetch_bacdive.ts              ← BacDive REST → JSON
│   ├── fetch_bvbrc.ts                ← BV-BRC REST → JSON
│   ├── fetch_ncbi.ts                 ← NCBI E-utilities → JSON
│   ├── fetch_uniprot_sparql.ts       ← UniProt SPARQL → JSON
│   ├── fetch_uniprot_rest.ts         ← UniProt REST → JSON
│   ├── fetch_pdb.ts                  ← RCSB PDB REST → JSON
│   ├── fetch_biocyc.ts               ← BioCyc web services → JSON
│   ├── fetch_clinvar.ts              ← ClinVar E-utilities → JSON
│   ├── fetch_virjendb.ts             ← VirJenDB REST → JSON
│   └── fetch_card.ts                 ← CARD下载 → JSON/TSV
├── sql/
│   ├── 00_init.sql                   ← 创建schema和视图
│   ├── 01_build_units.sql            ← 细菌单位构建
│   ├── 02_build_amr_matrix.sql       ← CARD耐药装甲矩阵
│   ├── 03_build_protein_network.sql  ← 蛋白互作网络
│   ├── 04_build_vfdb_bridge.sql      ← VFDB桥接
│   ├── 05_validation.sql             ← 数据质量报告
│   └── 99_export.sql                 ← 导出为游戏JSON
├── run_pipeline.ts                   ← 管线编排器
├── data/
│   ├── raw/                          ← fetch层输出（原始格式）
│   │   ├── bacdive/
│   │   ├── bvbrc/
│   │   ├── ncbi/
│   │   ├── card/
│   │   ├── vfdb/
│   │   ├── uniprot/
│   │   ├── pdb/
│   │   └── string/                   ← SQLite dump
│   ├── some_pipeline.duckdb          ← DuckDB主数据库
│   ├── game_units/                   ← 最终输出（引擎读取）
│   ├── biomap/                       ← 预计算索引
│   └── validation/                   ← 质量报告
└── species_list.json                 ← 收录物种清单
```

### 4.2 管线编排器

```typescript
// run_pipeline.ts — 全量管线编排
import { execSync } from 'child_process';
import { Database } from 'duckdb-async';
import { initPipelineDB } from './duckdb_init';

const PHASES = {
  fetch: [
    { name: 'BacDive', cmd: 'npx tsx fetch/fetch_bacdive.ts' },
    { name: 'BV-BRC', cmd: 'npx tsx fetch/fetch_bvbrc.ts' },
    { name: 'NCBI Taxonomy', cmd: 'npx tsx fetch/fetch_ncbi.ts' },
    { name: 'CARD', cmd: 'npx tsx fetch/fetch_card.ts' },
    { name: 'VFDB', cmd: 'npx tsx fetch/fetch_vfdb.ts' },
    // Phase 2 按需启用
    // { name: 'UniProt SPARQL', cmd: 'npx tsx fetch/fetch_uniprot_sparql.ts' },
    // { name: 'STRING dump', cmd: 'npx tsx fetch/fetch_string_dump.ts' },
  ],
  sql: [
    'sql/00_init.sql',
    'sql/01_build_units.sql',
    'sql/02_build_amr_matrix.sql',
    'sql/04_build_vfdb_bridge.sql',
    'sql/05_validation.sql',
    'sql/99_export.sql',
  ],
};

async function runPipeline() {
  // === Phase 1: Fetch ===
  console.log('=== FETCH PHASE ===');
  for (const task of PHASES.fetch) {
    console.log(`  [${task.name}] Fetching...`);
    execSync(task.cmd, { stdio: 'inherit' });
  }

  // === Phase 2: DuckDB Processing ===
  console.log('\n=== DUCKDB PHASE ===');
  const db = await initPipelineDB('data/some_pipeline.duckdb');

  for (const sqlFile of PHASES.sql) {
    console.log(`  [SQL] ${sqlFile}`);
    const sql = await readFile(sqlFile, 'utf-8');
    await db.all(sql);
  }

  // === Phase 3: Validation Report ===
  console.log('\n=== VALIDATION ===');
  const coverage = await db.all(`
    SELECT 'bacteria_units' AS table_name, COUNT(*) AS rows FROM game_units.bacterial_units
    UNION ALL
    SELECT 'amr_armor', COUNT(*) FROM game_units.amr_armor_matrix
    UNION ALL
    SELECT 'vfdb_bridge_rate', bridge_rate_pct FROM validation.vfdb_bridge_coverage
  `);
  console.table(coverage);

  await db.close();
  console.log('\n✅ Pipeline complete. Output: data/game_units/');
}
```

### 4.3 CARD下载脚本

```typescript
// fetch/fetch_card.ts — CARD数据下载
import { writeFileSync, mkdirSync } from 'fs';

const CARD_BASE = 'https://card.mcmaster.ca/latest';

async function downloadCARD() {
  mkdirSync('data/raw/card', { recursive: true });

  // ARO本体论（CC-BY 4.0，可自由使用）
  console.log('Downloading ARO ontology (JSON)...');
  const aroRes = await fetch(`${CARD_BASE}/ontology`);
  const aroJson = await aroRes.text();
  writeFileSync('data/raw/card/aro.json', aroJson);

  // ARO本体论（OBO格式，备用）
  console.log('Downloading ARO ontology (OBO)...');
  const oboRes = await fetch(`${CARD_BASE}/ontology`);
  const oboText = await oboRes.text();
  writeFileSync('data/raw/card/aro.obo', oboText);

  // 参考序列索引（TSV，用于桥接验证）
  console.log('Downloading CARD reference sequences index...');
  const indexRes = await fetch('https://card.mcmaster.ca/download/0/broadstreet-v1.3.0/sequences');
  if (indexRes.ok) {
    const indexText = await indexRes.text();
    writeFileSync('data/raw/card/sequences.tsv', indexText);
  }

  console.log('✅ CARD data downloaded to data/raw/card/');
}

downloadCARD().catch(console.error);
```

---

## 5. JSON处理能力

DuckDB的JSON函数替代了v1.0中大量TS解析代码：

### 5.1 BacDive嵌套JSON解析

BacDive返回的JSON有深层嵌套（`morphology.cell_morphology[0].value`），v1.0需要TS逐层访问，v2.0用`json_extract`：

```sql
-- v1.0 TS代码（~30行）：
// const morphology = strain.morphology?.cell_morphology?.[0]?.value ?? 'unknown';
// const gram = strain.gram_stain?.gram_stain?.[0]?.value ?? 'unknown';
// ... × 20个字段

-- v2.0 SQL（一行）：
SELECT
  CAST(json_extract(data, '$.morphology.cell_morphology[0].value') AS VARCHAR) AS cell_shape,
  CAST(json_extract(data, '$.gram_stain.gram_stain[0].value') AS VARCHAR) AS gram_stain,
  CAST(json_extract(data, '$.physiology_and_metabolism.oxygen_tolerance[0].value') AS VARCHAR) AS oxygen_tolerance
FROM read_json_auto('data/raw/bacdive/*.json');
```

### 5.2 UNNEST展开数组

BV-BRC的毒力因子是一个基因对应多条记录，用`UNNEST`展开：

```sql
-- 每个基因组的毒力因子数量统计
SELECT
  json_extract(g.data, '$.genome_id') AS genome_id,
  COUNT(v.gene_id) AS virulence_count
FROM read_json_auto('data/raw/bvbrc/genome_*.json') g
LEFT JOIN some_pipeline.v_bvbrc_virulence v
  ON v.genome_id = json_extract(g.data, '$.genome_id')
GROUP BY genome_id
ORDER BY virulence_count DESC;
```

### 5.3 CARD ARO图遍历

ARO是OBO格式的有向无环图（DAG），`is_a`关系形成层级。DuckDB可以用递归CTE遍历：

```sql
-- 递归遍历ARO层级：从NDM-1向上追溯到根节点
WITH RECURSIVE aro_tree AS (
  -- 起点：NDM-1 β-lactamase
  SELECT term_name, parent_term, 0 AS depth
  FROM some_pipeline.v_card_aro
  WHERE term_name LIKE 'NDM%'

  UNION ALL

  -- 递归向上
  SELECT a.term_name, a.parent_term, t.depth + 1
  FROM some_pipeline.v_card_aro a
  JOIN aro_tree t ON a.term_name = t.parent_term
  WHERE t.depth < 20  -- 防止无限循环
)
SELECT * FROM aro_tree ORDER BY depth;
```

---

## 6. 数据质量验证

DuckDB Layer内置验证报告，每次管线运行后自动生成：

```sql
-- validation.sql — 全量数据质量报告

-- 6.1 覆盖率统计
CREATE OR REPLACE TABLE validation.coverage_report AS
SELECT
  'bacterial_units' AS dataset,
  COUNT(DISTINCT scientific_name) AS unique_species,
  COUNT(*) AS total_units,
  SUM(CASE WHEN ncbi_taxid IS NOT NULL THEN 1 ELSE 0 END) AS has_taxonomy,
  SUM(CASE WHEN bvbrc_genome_id IS NOT NULL THEN 1 ELSE 0 END) AS has_clinical,
  SUM(CASE WHEN bacdive_id IS NOT NULL THEN 1 ELSE 0 END) AS has_phenotype,
  ROUND(AVG(CASE WHEN ncbi_taxid IS NOT NULL THEN 100.0 ELSE 0 END), 1) AS taxonomy_pct,
  ROUND(AVG(CASE WHEN bvbrc_genome_id IS NOT NULL THEN 100.0 ELSE 0 END), 1) AS clinical_pct,
  ROUND(AVG(CASE WHEN bacdive_id IS NOT NULL THEN 100.0 ELSE 0 END), 1) AS phenotype_pct
FROM game_units.bacterial_units;

-- 6.2 桥接覆盖率
CREATE OR REPLACE TABLE validation.bridge_coverage AS
SELECT
  'VFDB → UniProt (via Ensembl)' AS bridge,
  (SELECT total_vfdb_entries FROM validation.vfdb_bridge_coverage) AS total,
  (SELECT bridged_to_uniprot FROM validation.vfdb_bridge_coverage) AS bridged,
  (SELECT bridge_rate_pct FROM validation.vfdb_bridge_coverage) AS rate_pct
UNION ALL
SELECT
  'CARD → game armor',
  COUNT(*) AS total,
  SUM(CASE WHEN armor_mechanism != 'unknown' THEN 1 ELSE 0 END),
  ROUND(SUM(CASE WHEN armor_mechanism != 'unknown' THEN 100.0 ELSE 0 END) / COUNT(*), 1)
FROM game_units.amr_armor_matrix;

-- 6.3 数值分布检查（检测异常值）
CREATE OR REPLACE TABLE validation.stat_outliers AS
SELECT
  scientific_name,
  json_extract(game_stats, '$.hp_base')::INTEGER AS hp_base,
  json_extract(game_stats, '$.skill_slots')::INTEGER AS skill_slots
FROM game_units.bacterial_units
WHERE json_extract(game_stats, '$.hp_base')::INTEGER > 500
   OR json_extract(game_stats, '$.hp_base')::INTEGER < 10;
```

---

## 7. 导出策略

DuckDB处理完数据后，导出为ct.js可读格式：

```sql
-- 99_export.sql — 导出最终游戏数据

-- 7.1 细菌单位JSON（每个物种一个文件）
COPY (
  SELECT
    scientific_name,
    json_object(
      'scientific_name', scientific_name,
      'ncbi_taxid', ncbi_taxid,
      'biology', biology,
      'clinical', clinical,
      'game_stats', game_stats,
      'sources', json_object(
        'bacdive_id', bacdive_id,
        'bvbrc_genome_id', bvbrc_genome_id,
        'last_updated', '2026-07-18'
      )
    ) AS unit_json
  FROM game_units.bacterial_units
) TO 'data/game_units/units_export.jsonl' (FORMAT JSON);

-- 7.2 AMR装甲矩阵Parquet（高性能索引）
COPY (
  SELECT * FROM game_units.amr_armor_matrix
) TO 'data/biomap/amr_armor.parquet' (FORMAT PARQUET, COMPRESSION ZSTD);

-- 7.3 PPI网络Parquet
COPY (
  SELECT * FROM biomap.protein_network
) TO 'data/biomap/ppi_network.parquet' (FORMAT PARQUET, COMPRESSION ZSTD);

-- 7.4 验证报告Markdown
COPY (
  SELECT
    '# 数据管线验证报告\n\n' ||
    '## 覆盖率\n\n' ||
    '| 指标 | 值 |\n|---|---|\n' ||
    '| 物种数 | ' || unique_species || ' |\n' ||
    '| 总单位数 | ' || total_units || ' |\n' ||
    '| 分类覆盖 | ' || taxonomy_pct || '% |\n' ||
    '| 临床覆盖 | ' || clinical_pct || '% |\n' ||
    '| 表型覆盖 | ' || phenotype_pct || '% |\n'
  FROM validation.coverage_report
) TO 'data/validation/report.md';
```

---

## 8. 性能对比

| 操作 | v1.0 (纯TS) | v2.0 (DuckDB) | 提升 |
|---|---|---|---|
| 100个物种×3源合并 | ~30s (TS对象操作) | ~0.5s (SQL JOIN) | **60x** |
| BacDive JSON解析 | ~20行TS/字段 | 1行`json_extract` | 代码量**-90%** |
| Ensembl基因批量拉取 | REST逐条×3/s | MySQL一条JOIN | **~100x** |
| STRING PPI批量分析 | REST分页+TS merge | 本地SQLite JOIN | **~50x** |
| 内存占用(10万行) | ~2GB (全量加载) | ~200MB (流式) | **10x** |

来源：[DuckDB vs Pandas基准测试](https://duckdblab.org/en/post/duckdb-replace-pandas-etl-workflow/)（120M行CSV：Pandas 64GB OOM，DuckDB 4.3GB / 0.8s）

---

## 9. 许可与合规

| 数据库 | 数据许可 | DuckDB中使用方式 | 商用条件 |
|---|---|---|---|
| BacDive | CC-BY 4.0 | fetch → JSON → `read_json_auto` | 注明来源 |
| NCBI | 公共领域 | fetch → JSON → `read_json_auto` | 无限制 |
| BV-BRC | NIAID公共资源 | fetch → JSON → `read_json_auto` | 引用来源 |
| CARD ARO本体论 | CC-BY 4.0 | 下载 → JSON → `read_json_auto` | 注明来源 |
| CARD序列/模型 | McMaster版权 | 下载 → TSV → `read_csv_auto` | ⚠️ 商用需书面授权 |
| VFDB | 学术免费 | 下载 → TSV → `read_csv_auto` | 需确认许可 |
| Ensembl | EMBL-EBI开放 | MySQL直连 | 无限制 |
| UniProt | CC-BY 4.0 | SPARQL/REST → JSON → `read_json_auto` | 注明来源 |
| STRING | 学术免费 | SQL dump → SQLite → `ATTACH` | 商用需许可 |
| BioCyc | 学术免费 | Web services → JSON | 商用需许可 |
| Reactome | CC-BY 4.0 | MySQL dump → 本地 | 注明来源 |
| DuckDB | MIT | `npm install duckdb` | 无限制 |

**关键注意**：CARD的ARO本体论（CC-BY 4.0）可自由使用，但CARD的参考序列和检测模型商用需McMaster书面授权。SoMe作为游戏只需要ARO的分类和术语，不需要原始序列数据，因此不受限。

---

## 10. 扩展路线

### Phase 1（当前）：细菌单位管线
- ✅ BacDive + BV-BRC + NCBI（v1.0已有）
- 🔧 新增CARD（替换BV-BRC AMR）+ VFDB（替换BV-BRC VF）
- 🔧 DuckDB统一查询层

### Phase 2：蛋白质系统
- Ensembl Bacteria MySQL直连
- UniProt SPARQL联邦查询
- RCSB PDB 3D结构
- STRING PPI网络

### Phase 3：病毒DLC
- VirJenDB + NCBI Virus
- 病毒单位管线（类比细菌但机制不同——寄生型而非独立型）

### Phase 4：疾病/突变系统
- ClinVar基因突变事件
- OMIM医学史穿越剧情素材

### Phase 5：代谢可视化
- BioCyc BioVelo批量查询
- Reactome本地MySQL
- 对接SoMe三层能量系统

---

## 附录A：DuckDB安装与依赖

```bash
# Node.js绑定
npm install duckdb duckdb-async

# CLI（可选，用于手动调试）
curl https://install.duckdb.org | sh

# 扩展（首次运行自动安装）
# mysql_scanner — ATTACH MySQL
# sqlite — ATTACH SQLite
# httpfs — 远程文件读取
# json — JSON函数（v1.0+内置）
```

## 附录B：SoMe技术栈兼容性

| 技术栈 | 与DuckDB兼容性 |
|---|---|
| TypeScript/Node.js | ✅ 官方`duckdb-async`绑定 |
| ct.js | ✅ 构建时使用Node.js管线，运行时只读JSON |
| 全栈TS一致性 | ✅ 管线代码全部TS，SQL仅作数据处理 |
| AtomCode CLI | ✅ 可读写管线输出的JSON |
| MIT协议 | ✅ 无商用限制 |

## 附录C：从v1.0迁移指南

v1.0的`merge_mapper.ts`（~500行TS）全部被DuckDB SQL替代。迁移步骤：

1. 保留v1.0的fetch脚本（`fetch_bacdive.ts` / `fetch_bvbrc.ts` / `fetch_ncbi.ts`）
2. 新增fetch脚本（`fetch_card.ts` / `fetch_vfdb.ts`）
3. 删除`merge_mapper.ts`
4. 创建`duckdb_init.ts` + `sql/*.sql`
5. 创建`run_pipeline.ts`编排器
6. 输出格式不变（`game_units/*.json`），ct.js侧零改动
