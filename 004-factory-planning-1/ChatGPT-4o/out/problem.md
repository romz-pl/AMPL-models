We can model this problem as a **Mixed Integer Linear Programming (MILP)** or **Linear Programming (LP)** problem, depending on whether we need to round decisions to integers. Here's the full **mathematical model formulation**:

---

## **Sets**

Let:

* $P = \{1,2,3,4,5,6,7\}$ = set of products (PROD1 to PROD7)
* $M = \{1,2,3,4,5,6\}$ = set of months (January to June)
* $T = \{g, vd, hd, b, pl\}$ = set of machine types

  * $g$: grinder
  * $vd$: vertical drill
  * $hd$: horizontal drill
  * $b$: borer
  * $pl$: planer

---

## **Parameters**

### **Profit and Machine Usage**

* $c_p$: profit contribution of product $p$ (in £/unit)
* $u_{pt}$: hours of machine type $t$ used by one unit of product $p$; if dash in table, $u_{pt} = 0$

### **Machine Availability**

* $a_t$: total number of machine type $t$

  * Grinders: 4
  * Vertical Drills: 2
  * Horizontal Drills: 3
  * Borer: 1
  * Planer: 1
* $d_{mt}$: number of machine type $t$ down for maintenance in month $m$

Total available time for machine $t$ in month $m$:
$A_{mt} = (a_t - d_{mt}) \times 24 \text{ days} \times 2 \text{ shifts} \times 8 \text{ h}$

### **Marketing Constraints**

* $L_{mp}$: maximum demand (upper limit) for product $p$ in month $m$

### **Inventory Parameters**

* $h$: inventory holding cost per unit per month = 0.5 £/unit
* $S_{\text{max}}$: maximum storage per product per month = 100 units
* $S_{\text{final}} = 50$: desired final stock at end of June
* No initial stock.

---

## **Decision Variables**

* $x_{mp} \geq 0$: units of product $p$ **produced** in month $m$
* $s_{mp} \geq 0$: units of product $p$ **in stock** at end of month $m$
* $y_{mp} \geq 0$: units of product $p$ **sold** in month $m$

---

## **Objective Function**

Maximise total profit:

$$
\max \sum_{m \in M} \sum_{p \in P} \left[ c_p \cdot y_{mp} - h \cdot s_{mp} \right]
$$

---

## **Constraints**

### 1. **Machine Time Capacity (per month)**

For all $m \in M, \ t \in T$:

$$
\sum_{p \in P} u_{pt} \cdot x_{mp} \leq A_{mt}
$$

### 2. **Inventory Balance (Flow Constraints)**

For all $m \in M, \ p \in P$:

* Month 1:

$$
x_{1p} = y_{1p} + s_{1p}
$$

* Month 2–6:

$$
s_{(m-1)p} + x_{mp} = y_{mp} + s_{mp}
$$

### 3. **Sales Cannot Exceed Demand**

For all $m \in M, \ p \in P$:

$$
y_{mp} \leq L_{mp}
$$

### 4. **Storage Capacity**

For all $m \in M, \ p \in P$:

$$
s_{mp} \leq S_{\text{max}}
$$

### 5. **Final Stock Requirement (June)**

For all $p \in P$:

$$
s_{6p} = S_{\text{final}} = 50
$$

---

## **Machine Availability Detail (Per Month)**

| Month    | Grinder | Vert. Drill | Horiz. Drill | Borer | Planer |
| -------- | ------- | ----------- | ------------ | ----- | ------ |
| January  | 3       | 2           | 3            | 1     | 1      |
| February | 4       | 2           | 1            | 1     | 1      |
| March    | 4       | 2           | 3            | 0     | 1      |
| April    | 4       | 1           | 3            | 1     | 1      |
| May      | 3       | 1           | 3            | 1     | 1      |
| June     | 4       | 2           | 2            | 1     | 0      |

---

## **Recommendations Section (post-optimization)**

After solving the LP model, perform **sensitivity analysis** to:

1. **Identify binding machine constraints** (e.g. if a machine's capacity is fully used each month).

   * The shadow price indicates how much profit would increase if you had one more hour.
   * If high: consider **acquiring more machines**.

2. **Check dual prices on sales constraints** (demand limits).

   * If dual prices are non-zero for a product's sales limit, consider **increasing product price** or **expanding market capacity**.

---

Would you like help implementing this model in a solver (like Python with PuLP/Pyomo or Excel Solver)?
