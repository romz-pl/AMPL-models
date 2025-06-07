To formulate a **mathematical model** for this oil blending problem, we'll use a **linear programming (LP)** approach to **maximize profit** over a **6-month planning horizon (January to June)**.

---

## **Sets and Indices**

Let:

* $T = \{1, 2, 3, 4, 5, 6\}$: Months (January to June)
* $V = \{\text{VEG1}, \text{VEG2}\}$: Vegetable oils
* $N = \{\text{OIL1}, \text{OIL2}, \text{OIL3}\}$: Non-vegetable oils
* $O = V \cup N$: All oils

---

## **Parameters**

Let:

* $p_{ot}$: Purchase price of oil $o \in O$ in month $t \in T$ (from the table)
* $s = 5$: Storage cost per ton per month
* $r = 150$: Selling price per ton of the final product
* $h_o$: Hardness of oil $o$
* $C_v = 200$: Monthly refining capacity for vegetable oils
* $C_n = 250$: Monthly refining capacity for non-vegetable oils
* $S_{\max} = 1000$: Maximum storage per oil
* $S_0 = 500$: Initial stock for each oil
* $h_{\min} = 3$, $h_{\max} = 6$: Hardness bounds

---

## **Decision Variables**

For all $o \in O$, $t \in T$:

* $x_{ot} \geq 0$: Tons of oil $o$ **purchased** in month $t$
* $y_{ot} \geq 0$: Tons of oil $o$ **used** in production in month $t$
* $z_{ot} \geq 0$: Tons of oil $o$ **stored** at the end of month $t$

---

## **Objective Function: Maximize Profit**

$$
\text{Maximize } Z = \sum_{t \in T} \left[ r \cdot \sum_{o \in O} y_{ot} - \sum_{o \in O} \left( p_{ot} \cdot x_{ot} + s \cdot z_{ot} \right) \right]
$$

---

## **Constraints**

### 1. **Inventory Balance**

For all $o \in O$, $t \in T$:

* For January ($t = 1$):

$$
S_0 + x_{o1} = y_{o1} + z_{o1}
$$

* For $t > 1$:

$$
z_{o,t-1} + x_{ot} = y_{ot} + z_{ot}
$$

---

### 2. **Storage Limits**

$$
0 \leq z_{ot} \leq S_{\max} \quad \forall o \in O,\ t \in T
$$

---

### 3. **Refining Capacity**

* For all $t \in T$:

$$
\sum_{o \in V} y_{ot} \leq C_v \quad (\text{Vegetable oils})
$$

$$
\sum_{o \in N} y_{ot} \leq C_n \quad (\text{Non-vegetable oils})
$$

---

### 4. **Hardness Constraint**

For all $t \in T$, define total tons produced:

$$
P_t = \sum_{o \in O} y_{ot}
$$

Then impose:

$$
\sum_{o \in O} h_o \cdot y_{ot} \geq h_{\min} \cdot P_t
$$

$$
\sum_{o \in O} h_o \cdot y_{ot} \leq h_{\max} \cdot P_t
$$

---

### 5. **End-of-Horizon Inventory Requirement**

$$
z_{o6} = S_0 = 500 \quad \forall o \in O
$$

---

## **Summary**

This LP model includes:

* **Variables**: Purchases, usage, storage of oils
* **Objective**: Maximize profit (sales – purchase – storage cost)
* **Constraints**: Inventory flow, refining capacity, storage limits, hardness, and end-period inventory.

Would you like help converting this model into a form suitable for a solver (e.g., using Python/Pyomo, Excel Solver, or AMPL)?

