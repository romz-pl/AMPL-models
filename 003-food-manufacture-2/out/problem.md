Here's a **mathematical model** for the described food manufacturing and blending optimization problem.

---

## **Sets**

* $T = \{1, 2, 3, 4, 5, 6\}$: months (January to June)
* $O = \{\text{VEG1}, \text{VEG2}, \text{OIL1}, \text{OIL2}, \text{OIL3}\}$: all oils
* $V = \{\text{VEG1}, \text{VEG2}\}$: vegetable oils
* $N = \{\text{OIL1}, \text{OIL2}, \text{OIL3}\}$: non-vegetable oils

---

## **Parameters**

* $p_{ot}$: purchase price of oil $o$ in month $t$ (given in the table)
* $s = 5$: storage cost per ton per month
* $c = 150$: selling price per ton of final product
* $h_o$: hardness of oil $o$

  * VEG1: 8.8, VEG2: 6.1, OIL1: 2.0, OIL2: 4.2, OIL3: 5.0
* $R_v = 200$: max refining capacity for vegetable oils per month
* $R_n = 250$: max refining capacity for non-vegetable oils per month
* $S_{\max} = 1000$: max storage per oil
* $S_{\text{init}} = 500$: initial (and final) storage per oil
* $H_{\min} = 3, H_{\max} = 6$: required hardness range
* $M = 1000$: big-M constant

---

## **Decision Variables**

* $x_{ot} \geq 0$: tons of oil $o$ purchased in month $t$
* $y_{ot} \geq 0$: tons of oil $o$ used (refined) in month $t$
* $s_{ot} \geq 0$: tons of oil $o$ in storage at end of month $t$
* $z_{ot} \in \{0,1\}$: 1 if oil $o$ is used in month $t$, 0 otherwise

---

## **Objective Function**

Maximize **profit** = Revenue − Purchase cost − Storage cost

$$
\max \sum_{t \in T} \left[ c \cdot \sum_{o \in O} y_{ot} - \sum_{o \in O} p_{ot} \cdot x_{ot} - s \cdot \sum_{o \in O} s_{ot} \right]
$$

---

## **Constraints**

### 1. **Mass balance for each oil**

$$
s_{o,t} = s_{o,t-1} + x_{o,t} - y_{o,t} \quad \forall o \in O, t \in T
$$

* For $t=1$: $s_{o,0} = 500$ (initial storage)
* For $t=6$: $s_{o,6} = 500$ (final storage requirement)

### 2. **Storage capacity**

$$
0 \leq s_{ot} \leq S_{\max} \quad \forall o \in O, t \in T
$$

### 3. **Refining capacity**

$$
\sum_{o \in V} y_{ot} \leq R_v \quad \forall t \in T
$$

$$
\sum_{o \in N} y_{ot} \leq R_n \quad \forall t \in T
$$

### 4. **Hardness constraint**

Let $q_t = \sum_{o \in O} y_{ot}$: total quantity of product in month $t$

$$
H_{\min} \cdot q_t \leq \sum_{o \in O} h_o \cdot y_{ot} \leq H_{\max} \cdot q_t \quad \forall t \in T
$$

### 5. **Usage indicator constraints**

$$
y_{ot} \leq M \cdot z_{ot} \quad \forall o \in O, t \in T
$$

$$
y_{ot} \geq 20 \cdot z_{ot} \quad \forall o \in O, t \in T
$$

### 6. **Limit to 3 oils per month**

$$
\sum_{o \in O} z_{ot} \leq 3 \quad \forall t \in T
$$

### 7. **Conditional use constraint**

If either VEG1 or VEG2 is used in month $t$, then OIL3 must also be used:

$$
z_{\text{VEG1},t} + z_{\text{VEG2},t} \leq 1 + z_{\text{OIL3},t} \quad \forall t \in T
$$

---

## **Variable Domains**

* $x_{ot}, y_{ot}, s_{ot} \geq 0$ continuous
* $z_{ot} \in \{0,1\}$

---

Let me know if you'd like this implemented in a solver (like Python with Pyomo or PuLP) or presented in a more specific way.

