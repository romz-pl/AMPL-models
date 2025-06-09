We can model this problem as a **Linear Programming (LP)** problem to **maximize the weekly revenue** subject to the given constraints.

---

### **Decision Variables**

Let:

* $x$: number of **Premier** boats
* $y$: number of **Standard** boats

---

### **Objective Function**

Maximize total revenue:

$$
\text{Maximize } Z = 800x + 600y
$$

---

### **Constraints**

1. **Total number of boats cannot exceed berthing capacity**:

$$
x + y \leq 350
$$

2. **Premier boats cannot exceed 200**:

$$
x \leq 200
$$

3. **Premier boats must be at least equal to Standard boats**:

$$
x \geq y
$$

4. **Maintenance time constraint (hours per week)**:

$$
4x + 3y \leq 1400
$$

5. **Non-negativity**:

$$
x \geq 0, \quad y \geq 0
$$

---

### **Summary of Mathematical Model**

$$
\text{Maximize } Z = 800x + 600y
$$

Subject to:

$$
\begin{align*}
x + y &\leq 350 \\
x &\leq 200 \\
x - y &\geq 0 \\
4x + 3y &\leq 1400 \\
x, y &\geq 0
\end{align*}
$$

Let me know if you want this model solved graphically or via any optimization tool like Excel Solver, Python (PuLP), or any other method.
