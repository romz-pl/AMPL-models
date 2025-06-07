To mathematically model this **Linear Programming (LP)** problem, we define the variables, objective function, and constraints based on the data provided.

---

### **1. Decision Variables**

Let:

* $x_1$: number of units of **PROD1** to be produced
* $x_2$: number of units of **PROD2** to be produced
* $x_3$: number of units of **PROD3** to be produced
* $x_4$: number of units of **PROD4** to be produced
* $x_5$: number of units of **PROD5** to be produced

---

### **2. Objective Function**

Maximize total profit:

$$
\text{Maximize } Z = 550x_1 + 600x_2 + 350x_3 + 400x_4 + 200x_5
$$

---

### **3. Constraints**

#### **(a) Grinding time availability**

Each grinding machine works:

$$
6 \text{ days} \times 2 \text{ shifts/day} \times 8 \text{ hours/shift} = 96 \text{ hours/week}
$$

Total grinding capacity:

$$
3 \text{ machines} \times 96 = 288 \text{ hours/week}
$$

Grinding time per unit:

* PROD1: 12h
* PROD2: 20h
* PROD4: 25h
* PROD5: 15h
  (others use "-" → 0h)

So:

$$
12x_1 + 20x_2 + 25x_4 + 15x_5 \leq 288
$$

#### **(b) Drilling time availability**

Drilling capacity:

$$
2 \text{ machines} \times 96 = 192 \text{ hours/week}
$$

Drilling time per unit:

* PROD1: 10h
* PROD2: 8h
* PROD3: 16h
  (others use "-" → 0h)

So:

$$
10x_1 + 8x_2 + 16x_3 \leq 192
$$

#### **(c) Assembly time availability**

8 workers × 6 days × 8 hours =

$$
8 \times 6 \times 8 = 384 \text{ hours/week}
$$

Each unit of any product requires 20 hours of assembly:

$$
20x_1 + 20x_2 + 20x_3 + 20x_4 + 20x_5 \leq 384
$$

Or:

$$
x_1 + x_2 + x_3 + x_4 + x_5 \leq 19.2
$$

(We may leave it in terms of hours for clarity or simplify later.)

---

### **4. Non-negativity Constraints**

$$
x_1, x_2, x_3, x_4, x_5 \geq 0
$$

---

### **Final Mathematical Model**

**Maximize:**

$$
Z = 550x_1 + 600x_2 + 350x_3 + 400x_4 + 200x_5
$$

**Subject to:**

$$
12x_1 + 20x_2 + 25x_4 + 15x_5 \leq 288 \quad \text{(Grinding constraint)}
$$

$$
10x_1 + 8x_2 + 16x_3 \leq 192 \quad \text{(Drilling constraint)} \\
20x_1 + 20x_2 + 20x_3 + 20x_4 + 20x_5 \leq 384 \quad \text{(Assembly constraint)} \\
x_1, x_2, x_3, x_4, x_5 \geq 0
$$

---

Let me know if you’d like this solved with specific values or visualized!

