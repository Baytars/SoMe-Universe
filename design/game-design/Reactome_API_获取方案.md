# Reactome 通路层级数据获取方案

> By Yukio | 2026-04-18 | 技术实现方案

---

## 一、API 概览

Reactome提供两套核心API：

| API | Base URL | 用途 |
|-----|----------|------|
| **Content Service** | `https://reactome.org/ContentService` | 通路数据、层级关系、图表导出 |
| **Analysis Service** | `https://reactome.org/AnalysisService` | 富集分析、表达数据 |

---

## 二、通路层级查询方案

### 方案A：Python reactome2py 包（推荐）

```python
from reactome import content

# 查询通路信息
pathway_info = content.query_by_id("R-HSA-69278")  # Cell Cycle

# 获取父通路
parent = content.get_pathway_parent_by_id("R-HSA-69278")

# 获取顶层父通路
top_parent = content.get_top_hiearchy_parent_by_id("R-HSA-69278")

# 获取所有顶层通路
all_tops = content.get_all_top_hierarchy_pathways()

# 获取人类通路
human_pathways = content.get_human_pathways()
```

### 方案B：REST API 直接调用

```python
import requests

BASE = "https://reactome.org/ContentService"

# 获取通路详情
def get_pathway_info(pathway_id):
    url = f"{BASE}/data/query/{pathway_id}"
    response = requests.get(url)
    return response.json()

# 获取子通路（层级向下）
def get_child_pathways(pathway_id):
    url = f"{BASE}/data/event/{pathway_id}/children"
    response = requests.get(url)
    return response.json()

# 获取父通路（层级向上）
def get_parent_pathway(pathway_id):
    url = f"{BASE}/data/event/{pathway_id}/parent"
    response = requests.get(url)
    return response.json()

# 获取通路参与者（蛋白质/基因）
def get_participants(pathway_id):
    url = f"{BASE}/data/event/{pathway_id}/participatingPhysicalEntities"
    response = requests.get(url)
    return response.json()
```

---

## 三、SoMe 核心通路 ID 映射

| SoMe科技分类 | Reactome顶层通路 | Reactome ID |
|-------------|-----------------|-------------|
| **Cell Cycle** | Cell Cycle | R-HSA-1640170 |
| **Metabolism** | Metabolism | R-HSA-1430728 |
| **Signal Transduction** | Signal Transduction | R-HSA-162582 |
| **DNA Repair** | DNA Repair | R-HSA-73885 |
| **Immune System** | Immune System | R-HSA-168256 |
| **Programmed Cell Death** | Apoptosis | R-HSA-71474 |
| **Vesicle Transport** | Vesicle-mediated Transport | R-HSA-5653656 |
| **EMT** | EMT (niche-specific) | R-HSA-8937144 |

---

## 四、通路层级数据示例

### Cell Cycle 层级结构

```
Cell Cycle (R-HSA-1640170)
├── Cell Cycle, Mitotic (R-HSA-69278)
│   ├── G1 Phase (R-HSA-69239)
│   ├── G1/S Transition (R-HSA-69206)
│   ├── S Phase (R-HSA-69239)
│   ├── G2 Phase (R-HSA-69618)
│   └── M Phase (R-HSA-68884)
│       ├── Mitosis (R-HSA-68875)
│       └── Cytokinesis (R-HSA-68877)
└── Meiosis (R-HSA-186712)
```

### Metabolism 层级结构

```
Metabolism (R-HSA-1430728)
├── Carbohydrate Metabolism
│   ├── Glycolysis (R-HSA-71403)
│   ├── Gluconeogenesis (R-HSA-70263)
│   └── Pentose Phosphate Pathway (R-HSA-1247363)
├── Lipid Metabolism
│   ├── Fatty Acid Metabolism (R-HSA-77289)
│   └── Cholesterol Biosynthesis (R-HSA-75105)
├── Amino Acid Metabolism
│   └── Glutamine Metabolism (R-HSA-71441)
└── Energy Metabolism
    ├── TCA Cycle (R-HSA-71403)
    └── Respiratory Electron Transport (R-HSA-611105)
```

---

## 五、图表导出方案

### 直接导出通路图（PNG/SVG）

```python
import requests

pathway_id = "R-HSA-69278"  # Cell Cycle

# 导出PNG
url = f"https://reactome.org/ContentService/exporter/diagram/{pathway_id}.png"
response = requests.get(url)
with open(f"pathway_{pathway_id}.png", "wb") as f:
    f.write(response.content)

# 高质量导出
url = f"https://reactome.org/ContentService/exporter/diagram/{pathway_id}.png?quality=10"
```

### 导出带标注的通路图

```python
# 标注特定基因
gene = "BRCA1"
url = f"https://reactome.org/ContentService/exporter/diagram/{pathway_id}.png?flg={gene}"
```

---

## 六、SoMe 科技树可视化实现

### Step 1: 获取层级数据

```python
import json
import requests

def build_pathway_tree(top_pathway_id, depth=3):
    """递归获取通路层级树"""
    def get_children(pid, current_depth):
        if current_depth <= 0:
            return None
        url = f"https://reactome.org/ContentService/data/event/{pid}/children"
        try:
            response = requests.get(url, timeout=10)
            if response.status_code == 200:
                children = response.json()
                result = {"id": pid, "children": []}
                for child in children:
                    result["children"].append(get_children(child["stId"], current_depth - 1))
                return result
        except:
            pass
        return {"id": pid, "children": []}
    
    return get_children(top_pathway_id, depth)

# 获取Cell Cycle子树
cell_cycle_tree = build_pathway_tree("R-HSA-1640170", depth=2)
```

### Step 2: 转换为SoMe格式

```python
def to_some_format(tree, pathway_mapping):
    """将Reactome层级转换为SoMe科技树格式"""
    node = {
        "id": tree["id"],
        "reactome_id": tree["id"],
        "soMe_name": pathway_mapping.get(tree["id"], "TBD"),
        "children": []
    }
    if tree.get("children"):
        for child in tree["children"]:
            if child:
                node["children"].append(to_some_format(child, pathway_mapping))
    return node
```

### Step 3: 生成可视化

使用 `drawio-generator` skill 生成 draw.io 格式的层级图，或用 `echart` 生成网页可交互的科技树。

---

## 七、行动计划

- [ ] **Phase 1**: 编写Python脚本获取Cell Cycle、Metabolism、DNA Repair三个核心通路的层级数据
- [ ] **Phase 2**: 建立SoMe科技节点 ↔ Reactome通路的映射表
- [ ] **Phase 3**: 用drawio-generator生成科技树依赖图
- [ ] **Phase 4**: 评估接入Reactome Pathway Browser的可能性（用于"祛魅模式"）

---

## 八、参考资源

- Reactome官网: https://reactome.org/
- API文档: https://reactome.org/dev/
- reactome2py文档: https://reactome.github.io/reactome2py/
- 数据下载: https://reactome.org/download-data
