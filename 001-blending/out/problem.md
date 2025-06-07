To model this problem mathematically, we'll define a **linear programming (LP)** model to maximize **net profit** subject to **capacity**, **blend**, and **hardness constraints**.

---

### **Decision Variables**

Let:

* $x_1$: tons of VEG1 used in the final blend
* $x_2$: tons of VEG2 used
* $x_3$: tons of OIL1 used
* $x_4$: tons of OIL2 used
* $x_5$: tons of OIL3 used

(All $x_i \geq 0$)

---

### **Objective Function: Maximize Net Profit**

Each ton of product sells for £150. The cost per ton for each ingredient is given. So, net profit is:

$$
\text{Profit} = 150(x_1 + x_2 + x_3 + x_4 + x_5) - (110x_1 + 120x_2 + 130x_3 + 110x_4 + 115x_5)
$$

Simplify the objective function:

$$
\max Z = (150 - 110)x_1 + (150 - 120)x_2 + (150 - 130)x_3 + (150 - 110)x_4 + (150 - 115)x_5
$$

$$
\max Z = 40x_1 + 30x_2 + 20x_3 + 40x_4 + 35x_5
$$

---

### **Constraints**

#### 1. **Refining Capacity Constraints**

* Vegetable oils (VEG1 and VEG2):

  $$
  x_1 + x_2 \leq 200
  $$
* Non-vegetable oils (OIL1, OIL2, OIL3):

  $$
  x_3 + x_4 + x_5 \leq 250
  $$

#### 2. **Hardness Constraint**

Let total product weight:

$$
T = x_1 + x_2 + x_3 + x_4 + x_5
$$

Let total hardness:

$$
H = 8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5
$$

Average hardness must be between 3 and 6:

$$
3 \leq \frac{H}{T} \leq 6 \quad \text{(if } T > 0 \text{)}
$$

This implies:

$$
3T \leq H \leq 6T
$$

Multiply out:

$$
3(x_1 + x_2 + x_3 + x_4 + x_5) \leq 8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5
$$

$$
8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5 \leq 6(x_1 + x_2 + x_3 + x_4 + x_5)
$$

So the hardness constraints become:

* Lower bound:

$$
8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5 \geq 3(x_1 + x_2 + x_3 + x_4 + x_5)
$$

* Upper bound:

$$
8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5 \leq 6(x_1 + x_2 + x_3 + x_4 + x_5)
$$

---

### **Full Linear Program**

**Maximize:**

$$
Z = 40x_1 + 30x_2 + 20x_3 + 40x_4 + 35x_5
$$

**Subject to:**

$$
x_1 + x_2 \leq 200 \quad \text{(vegetable oil refining capacity)}
$$

$$
x_3 + x_4 + x_5 \leq 250 \quad \text{(non-vegetable oil refining capacity)}
$$

$$
8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5 \geq 3(x_1 + x_2 + x_3 + x_4 + x_5)
$$

$$
8.8x_1 + 6.1x_2 + 2.0x_3 + 4.2x_4 + 5.0x_5 \leq 6(x_1 + x_2 + x_3 + x_4 + x_5)
$$

$$
x_1, x_2, x_3, x_4, x_5 \geq 0
$$

---

Let me know if you'd like help solving this LP using a method (e.g., Excel Solver, Python, or graphical for simplification).

