To build a **mathematical model** for this mining problem, we will use a **mixed-integer linear programming (MILP)** approach. The goal is to **maximize net present value (NPV)** of the operation over 5 years, considering constraints on mine operation, ore quality blending, and royalty payments.

---

## **Decision Variables**

Let:

* $x_{i,t}$: amount (in million tons) of ore extracted from mine $i \in \{1,2,3,4\}$ in year $t \in \{1,2,3,4,5\}$
* $y_{i,t} \in \{0,1\}$: 1 if mine $i$ is operated in year $t$, 0 otherwise
* $z_{i,t} \in \{0,1\}$: 1 if mine $i$ is open (i.e., royalties paid) in year $t$, 0 otherwise

---

## **Parameters**

Let:

* $R_i$: royalty cost for keeping mine $i$ open per year (in £ million)

  * $R = [5, 4, 4, 5]$
* $C_i$: capacity of mine $i$ in million tons per year

  * $C = [2.0, 2.5, 1.3, 3.0]$
* $Q_i$: quality of ore from mine $i$

  * $Q = [1.0, 0.7, 1.5, 0.5]$
* $q_t$: required blended quality in year $t$

  * $q = [0.9, 0.8, 1.2, 0.6, 1.0]$
* $p$: price of ore per ton: £10
* $d_t$: discount factor for year $t$, using 10% discount rate:

  $$
  d_t = \frac{1}{(1 + 0.10)^t},\quad t = 1,2,3,4,5
  $$

---

## **Objective Function**

Maximize Net Present Value (NPV):

$$
\max \sum_{t=1}^{5} d_t \left[10 \cdot \sum_{i=1}^{4} x_{i,t} - \sum_{i=1}^{4} R_i \cdot z_{i,t} \right]
$$

---

## **Constraints**

1. **Mine capacity limits**:

   $$
   x_{i,t} \leq C_i \cdot y_{i,t}, \quad \forall i, t
   $$

2. **Operation implies open**:

   $$
   y_{i,t} \leq z_{i,t}, \quad \forall i, t
   $$

3. **No more than 3 mines operated per year**:

   $$
   \sum_{i=1}^{4} y_{i,t} \leq 3, \quad \forall t
   $$

4. **Blended quality constraint** (weighted average):
   Let total output in year $t$ be $T_t = \sum_{i=1}^{4} x_{i,t}$. Then:

   $$
   \sum_{i=1}^{4} Q_i \cdot x_{i,t} = q_t \cdot T_t, \quad \forall t
   $$

   This is linear because both sides are linear in $x_{i,t}$.

5. **Once a mine is permanently closed, it stays closed**:

   $$
   z_{i,t} \geq z_{i,t+1}, \quad \forall i, t = 1,2,3,4
   $$

6. **Binary constraints**:

   $$
   y_{i,t}, z_{i,t} \in \{0,1\}, \quad \forall i, t
   $$

7. **Non-negativity**:

   $$
   x_{i,t} \geq 0, \quad \forall i, t
   $$

---

## **Summary**

This MILP model:

* **Maximizes** discounted profit (revenue minus royalty costs)
* Ensures ore blending meets **quality requirements**
* Limits number of **operational mines**
* Tracks whether mines are **kept open** for future use
* Observes mine **capacity constraints**

Would you like this implemented in Python (e.g., using Pyomo or PuLP)?
