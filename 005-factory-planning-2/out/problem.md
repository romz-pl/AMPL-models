We will develop a **mixed-integer linear programming (MILP)** model to represent the problem of production planning, maintenance scheduling, and inventory control with the objective of maximizing total profit over six months.

---

### **Indices**

* $i \in \{1,\dots,7\}$: product index (PROD1 to PROD7)
* $m \in \{1,\dots,6\}$: month index (January to June)
* $k \in \{\text{Gr}, \text{VD}, \text{HD}, \text{Bo}, \text{Pl}\}$: machine types: Grinding, Vertical Drill, Horizontal Drill, Borer, Planer

---

### **Parameters**

#### Contribution and machine time usage

* $c_i$: Contribution to profit per unit of product $i$ (£)
* $t_{ik}$: Time required (in hours) on machine $k$ for product $i$ (0 if not used)
* $a_{im}$: Maximum market demand of product $i$ in month $m$
* $H$: Monthly available machine hours = $6 \text{ days/week} \times 2 \text{ shifts/day} \times 8 \text{ hours/shift} \times 4 \text{ weeks} = 384$ hours
* $s_i^0 = 0$: Initial stock
* $s_i^6 = 50$: Desired final stock
* $S = 100$: Max stock per product
* $h = 0.5$: Holding cost per unit per month (£)

---

### **Decision Variables**

* $x_{im} \geq 0$: Units of product $i$ produced in month $m$
* $y_{im} \geq 0$: Units of product $i$ sold in month $m$
* $s_{im} \geq 0$: Stock of product $i$ at end of month $m$
* $d_{km} \in \{0,1\}$: 1 if machine $k$ is down for maintenance in month $m$, 0 otherwise

---

### **Objective Function**

Maximize total profit (sales profit minus holding cost):

$$
\text{Maximize } Z = \sum_{m=1}^6 \sum_{i=1}^7 c_i y_{im} - \sum_{m=1}^6 \sum_{i=1}^7 h \cdot s_{im}
$$

---

### **Constraints**

#### 1. **Demand Constraints (marketing limits)**

$$
y_{im} \leq a_{im} \quad \forall i, m
$$

#### 2. **Inventory Balance**

$$
s_{i0} = 0 \quad \text{(initial stock)} \\
s_{im} = s_{i,m-1} + x_{im} - y_{im} \quad \forall i, m = 1,\dots,6 \\
s_{i6} = 50 \quad \text{(final stock)}
$$

#### 3. **Stock Capacity**

$$
0 \leq s_{im} \leq 100 \quad \forall i, m
$$

#### 4. **Machine Capacity Constraints**

Let $M_k$: number of machines of type $k$, and $H_m = H \cdot (M_k - d_{km})$ be available hours.

For each machine type $k$ and month $m$:

$$
\sum_{i=1}^7 t_{ik} \cdot x_{im} \leq H \cdot (M_k - d_{km}) \quad \forall k, m
$$

Machine counts:

* Grinding (Gr): 4
* Vertical Drill (VD): 2
* Horizontal Drill (HD): 3
* Borer (Bo): 1
* Planer (Pl): 1

#### 5. **Maintenance Scheduling**

* Each non-grinding machine must be down **exactly once**:

$$
\sum_{m=1}^6 d_{km} = 1 \quad \forall k \in \{\text{VD}, \text{HD}, \text{Bo}, \text{Pl}\}
$$

* Exactly two grinding machines are down in total over the 6 months:

$$
\sum_{m=1}^6 d_{\text{Gr},m} = 2
$$

(Note: For the grinders, you may model individual grinder units if a more granular schedule is required.)

---

### **Extensions for Recommendations**

#### (A) **Shadow Prices / Dual Values**

Solving the LP will give dual values indicating:

* How much profit would improve with an extra hour of machine time.
* This can suggest **value of acquiring a new machine**.

#### (B) **Price Sensitivity**

Introduce a scenario analysis or parametric programming to:

* Gradually increase unit price of low-performing products and observe if they enter optimal production.

---

### **Conclusion**

This MILP captures the production, maintenance scheduling, and inventory planning for the factory. You can solve this model using solvers like:

* **Gurobi**, **CPLEX**, **SCIP**, or **CBC** (in Python with `PuLP` or `Pyomo`)
* **Excel Solver** (simplified version)
* **AMPL** or **GAMS** for more industrial-scale optimization.

Let me know if you'd like the full code in Pyomo or PuLP.
