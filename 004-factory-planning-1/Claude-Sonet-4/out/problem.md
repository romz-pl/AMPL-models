# Factory Production Planning Mathematical Model

## Decision Variables

Let:
- $x_{ij}$ = number of units of product $i$ produced in month $j$
- $s_{ij}$ = stock level of product $i$ at the end of month $j$

Where:
- $i \in \{1, 2, 3, 4, 5, 6, 7\}$ (products PROD1 to PROD7)
- $j \in \{1, 2, 3, 4, 5, 6\}$ (months January to June)

## Objective Function

**Maximize Total Profit:**
$$\max Z = \sum_{j=1}^{6} \sum_{i=1}^{7} p_i \cdot x_{ij} - \sum_{j=1}^{6} \sum_{i=1}^{7} 0.5 \cdot s_{ij}$$

Where $p_i$ is the profit contribution per unit for product $i$:
- $p_1 = 10$, $p_2 = 6$, $p_3 = 8$, $p_4 = 4$, $p_5 = 11$, $p_6 = 9$, $p_7 = 3$

## Constraints

### 1. Machine Capacity Constraints

**Available machine hours per month:** 24 days × 2 shifts × 8 hours = 384 hours

#### Grinding Capacity:
- **January (3 grinders available):** $0.5x_{1j} + 0.7x_{2j} + 0.3x_{5j} + 0.2x_{6j} + 0.5x_{7j} \leq 1152$
- **February-April (4 grinders):** $0.5x_{1j} + 0.7x_{2j} + 0.3x_{5j} + 0.2x_{6j} + 0.5x_{7j} \leq 1536$
- **May (3 grinders available):** $0.5x_{15} + 0.7x_{25} + 0.3x_{55} + 0.2x_{65} + 0.5x_{75} \leq 1152$
- **June (4 grinders):** $0.5x_{16} + 0.7x_{26} + 0.3x_{56} + 0.2x_{66} + 0.5x_{76} \leq 1536$

#### Vertical Drilling Capacity:
- **January-March (2 drills):** $0.1x_{1j} + 0.2x_{2j} + 0.3x_{4j} + 0.6x_{6j} \leq 768$
- **April (1 drill available):** $0.1x_{14} + 0.2x_{24} + 0.3x_{44} + 0.6x_{64} \leq 384$
- **May (1 drill available):** $0.1x_{15} + 0.2x_{25} + 0.3x_{45} + 0.6x_{65} \leq 384$
- **June (2 drills):** $0.1x_{16} + 0.2x_{26} + 0.3x_{46} + 0.6x_{66} \leq 768$

#### Horizontal Drilling Capacity:
- **January (3 drills):** $0.2x_{1j} + 0.8x_{3j} + 0.6x_{7j} \leq 1152$
- **February (1 drill available):** $0.2x_{12} + 0.8x_{32} + 0.6x_{72} \leq 384$
- **March-May (3 drills):** $0.2x_{1j} + 0.8x_{3j} + 0.6x_{7j} \leq 1152$
- **June (2 drills available):** $0.2x_{16} + 0.8x_{36} + 0.6x_{76} \leq 768$

#### Boring Capacity:
- **January-February (1 borer):** $0.05x_{1j} + 0.03x_{2j} + 0.07x_{4j} + 0.1x_{5j} + 0.08x_{7j} \leq 384$
- **March (0 borers available):** $0.05x_{13} + 0.03x_{23} + 0.07x_{43} + 0.1x_{53} + 0.08x_{73} \leq 0$
- **April-June (1 borer):** $0.05x_{1j} + 0.03x_{2j} + 0.07x_{4j} + 0.1x_{5j} + 0.08x_{7j} \leq 384$

#### Planing Capacity:
- **January-May (1 planer):** $0.01x_{3j} + 0.05x_{5j} + 0.05x_{7j} \leq 384$
- **June (0 planers available):** $0.01x_{36} + 0.05x_{56} + 0.05x_{76} \leq 0$

### 2. Marketing Demand Constraints

For each product $i$ in each month $j$:
$$x_{ij} \leq d_{ij}$$

Where $d_{ij}$ represents the marketing limits from the given table.

### 3. Inventory Balance Constraints

For each product $i$ and each month $j$:
$$s_{ij} = s_{i,j-1} + x_{ij} - \text{sales}_{ij}$$

Assuming maximum sales (up to marketing limit):
$${\text{sales}}_{ij} = \text{min}(s_{i,{j-1}} + x_{ij}, d_{ij})$$

This can be linearized as:
$$s_{ij} \geq s_{i,j-1} + x_{ij} - d_{ij}$$
$$s_{ij} \leq s_{i,j-1} + x_{ij}$$

### 4. Storage Capacity Constraints

For each product $i$ in each month $j$:
$$s_{ij} \leq 100$$

### 5. Initial and Final Inventory Constraints

**Initial inventory (end of December):**
$$s_{i0} = 0 \quad \forall i$$

**Final inventory requirement (end of June):**
$$s_{i6} = 50 \quad \forall i$$

### 6. Non-negativity Constraints

$$x_{ij} \geq 0 \quad \forall i,j$$
$$s_{ij} \geq 0 \quad \forall i,j$$

## Model Summary

This is a linear programming problem with:
- **Decision variables:** 84 production variables + 42 inventory variables = 126 variables
- **Constraints:** Machine capacity (30) + Marketing limits (42) + Inventory balance (42) + Storage limits (42) + Final inventory (7) = 163 constraints
- **Objective:** Maximize profit from sales minus inventory holding costs

## Additional Analysis Recommendations

1. **Sensitivity Analysis:** Examine shadow prices of machine capacity constraints to identify bottleneck machines
2. **Price Increases:** Analyze reduced costs of production variables to determine products with potential for price increases
3. **Machine Acquisition:** Evaluate shadow prices of binding capacity constraints to determine the value of additional machines
4. **Seasonal Planning:** Consider the impact of maintenance schedules on optimal production timing
