We are given a 6-month production-planning problem involving blending and storage decisions for raw oils. The goal is to **maximize profit** from selling a refined food product, given a range of operational constraints. Here's a **mathematical model** formulation of the problem as a **Mixed-Integer Linear Program (MILP)**:

---

## **Sets**

* $T = \{1, 2, 3, 4, 5, 6\}$: months (January to June)
* $V = \{\text{VEG1}, \text{VEG2}\}$: vegetable oils
* $N = \{\text{OIL1}, \text{OIL2}, \text{OIL3}\}$: non-vegetable oils
* $O = V \cup N$: all oils

---

## **Parameters**

* $p_{o,t}$: purchase price of oil $o$ in month $t$ (from table)
* $h_o$: hardness of oil $o$

  * VEG1: 8.8, VEG2: 6.1, OIL1: 2.0, OIL2: 4.2, OIL3: 5.0
* $s = 5$: storage cost (£/ton/month)
* $s_o^0 = 500$: initial inventory of oil $o$
* $s_o^f = 500$: final inventory of oil $o$
* $\text{SellPrice} = 150$: selling price per ton of final product
* Refining limits per month:

  * Vegetable oils: $\text{RefineLimit}_V = 200$
  * Non-vegetable oils: $\text{RefineLimit}_N = 250$

---

## **Decision Variables**

Continuous:

* $b_{o,t} \ge 0$: amount of oil $o$ bought in month $t$
* $r_{o,t} \ge 0$: amount of oil $o$ refined (used in product) in month $t$
* $s_{o,t} \ge 0$: storage of oil $o$ at end of month $t$

Binary:

* $y_{o,t} \in \{0, 1\}$: 1 if oil $o$ is used in month $t$ (i.e., $r_{o,t} > 0$)
* $z_t \in \{0, 1, 2, 3\}$: number of oils used in month $t$

---

## **Objective Function: Maximize Profit**

$$
\max \sum_{t \in T} \left[150 \cdot \sum_{o \in O} r_{o,t} - \sum_{o \in O} \left(p_{o,t} \cdot b_{o,t} + s \cdot s_{o,t} \right) \right]
$$

---

## **Constraints**

### 1. **Inventory Balance** (flow conservation)

For all $o \in O, t \in T$:

$$
s_{o,t} = s_{o,t-1} + b_{o,t} - r_{o,t}, \quad \text{for } t = 1, \dots, 6
$$

Where:

* $s_{o,0} = 500$ (initial inventory)
* $s_{o,6} = 500$ (final inventory)

---

### 2. **Refining Capacity**

For all $t \in T$:

* Vegetable:

$$
\sum_{o \in V} r_{o,t} \le 200
$$

* Non-vegetable:

$$
\sum_{o \in N} r_{o,t} \le 250
$$

---

### 3. **Hardness Constraint**

For all $t \in T$:

Let $R_t = \sum_{o \in O} r_{o,t}$ (total product produced)

$$
3 \cdot R_t \le \sum_{o \in O} h_o \cdot r_{o,t} \le 6 \cdot R_t
$$

---

### 4. **Storage Limit**

For all $o \in O, t \in T$:

$$
s_{o,t} \le 1000
$$

---

### 5. **At Most 3 Oils Per Month**

For all $t \in T$:

$$
\sum_{o \in O} y_{o,t} \le 3
$$

Linking $r_{o,t}$ and $y_{o,t}$:

$$
r_{o,t} \le M \cdot y_{o,t}, \quad \text{where } M \text{ is a large constant, e.g. } 1000
$$

---

### 6. **Minimum Usage If Used**

For all $o \in O, t \in T$:

$$
r_{o,t} \ge 20 \cdot y_{o,t}
$$

This forces at least 20 tons if an oil is used.

---

### 7. **Conditional Oil Usage Rule**

For all $t \in T$:

If VEG1 or VEG2 used $\Rightarrow$ OIL3 must be used

$$
y_{\text{OIL3}, t} \ge y_{\text{VEG1}, t}
$$

$$
y_{\text{OIL3}, t} \ge y_{\text{VEG2}, t}
$$

---

## Summary

This is a **Mixed-Integer Linear Program (MILP)** with:

* Linear objective function (profit)
* Linear constraints (refining limits, hardness, storage, logic rules)
* Binary variables for oil usage to enforce combinatorial conditions

---

Would you like this model implemented in a solver-friendly format (e.g. Python/PuLP or AMPL)?

